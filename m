Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5066149E3A7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242041AbiA0Ni1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:38:27 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:56354 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242143AbiA0Ngv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:36:51 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8443B218CE;
        Thu, 27 Jan 2022 13:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643290610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=O9QO+GuOwuNfCQAL5X6kgAbs9JlqPuUL4SKyZ4gCtFk=;
        b=QYaek997c5pGHBy5TBaos7w+eHs4u2gf+NndfKaQg7gz0kxFgI7c20g95O2H6lMYGycnav
        wqcGuiYiIE/ZwgBeUkLfNLPGXk1Pr0LkQ+JtatlDrIRKCy2C8BPX3n8IMchjdR0KtkSeEq
        dQqF8sbwlmPZVKVwFculCR5fkIiGKEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643290610;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=O9QO+GuOwuNfCQAL5X6kgAbs9JlqPuUL4SKyZ4gCtFk=;
        b=3V+c1YSBRZbizUpOK3QrjutsbkQU/u64evuTAIMS6QJD4OjohwAG0NVNIRtZxdPt8Niax+
        zM2EEuaCTBVXTzDQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 7DFC6A3B87;
        Thu, 27 Jan 2022 13:36:50 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id 71F435192D56; Thu, 27 Jan 2022 14:36:50 +0100 (CET)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [RFC] nvme: Do not reject dynamic controller cntlid
Date:   Thu, 27 Jan 2022 14:36:48 +0100
Message-Id: <20220127133648.8201-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NVME spec states in 3.1.1 Controller Model there are two types
controllers: dynamic and static.

The nvme_validate_cntlid() check ensures that the newly discovered
controller does not have the same cntlid as a known controller. For
the dynamic controller model this check doesn't make sense as all
cntlid will be 0xffff. In this case ignore this check.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

I got a bug report with this:

 nvme nvme10: pci function 0000:00:19.0
 nvme 0000:00:19.0: enabling device (0000 -> 0002)
 nvme nvme10: Duplicate cntlid 65535 with nvme7, rejecting
 nvme nvme10: Removing after probe failure status: -22

From reading the spec I got the impression that it should be enough to
ignore the cntlid check if the cntlid is 0xffff. Though I might be
completely wrong here.

 drivers/nvme/host/core.c | 2 +-
 drivers/nvme/host/nvme.h | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dd18861f77c0..918abb54771c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2701,7 +2701,7 @@ static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,
 		if (nvme_state_terminal(tmp))
 			continue;
 
-		if (tmp->cntlid == ctrl->cntlid) {
+		if (!nvme_ctrl_dynamic(tmp) && tmp->cntlid == ctrl->cntlid) {
 			dev_err(ctrl->device,
 				"Duplicate cntlid %u with %s, subsys %s, rejecting\n",
 				ctrl->cntlid, dev_name(tmp->device),
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a162f6c6da6e..ed75245263f5 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -539,6 +539,11 @@ static inline struct request *nvme_cid_to_rq(struct blk_mq_tags *tags,
 	return blk_mq_tag_to_rq(tags, nvme_tag_from_cid(command_id));
 }
 
+static inline bool nvme_ctrl_dynamic(struct nvme_ctrl *ctrl)
+{
+	return ctrl->cntlid == 0xffff;
+}
+
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
 void nvme_fault_inject_init(struct nvme_fault_inject *fault_inj,
 			    const char *dev_name);
-- 
2.29.2

