Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85BB3468BF6
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 16:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbhLEPrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 10:47:07 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37886 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236310AbhLEPqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 10:46:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A16DB80E83
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 15:42:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DCA1C00446
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 15:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638718964;
        bh=uj2wN6gVuHypHAq9XiLoaLSfrCUbW7vgwLUglYbREgE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Ee4HjvphYzn5KmTrPGEZSVIz2IW9tftHqWoCbJrbLl967iF7nasJdSnl/h4VJQVVA
         CDfVamJRz/ZWlgSHOjq05q3sUspaney5Vqz0aYX1O5RCw5KjsMerdCNZD8D1RDjAsq
         51iJr0/EuRtlyDY2z6qepfchkk1N0nxSECFTtsZHNRBMYhRnuoNoddD3RjcidItgSs
         AhqSe3+HPbPWakRunTuhGTW/HwDvHidHQdrd4AntKTt2QAzONQwAHUBk5sFaSIPTcS
         j2Gubn0FEIp86ikjvqPvNktkWOe59YEyfqwIz8oOSgfjuBNcjJrLQq43iCDv17+rFk
         p0hNeGe5f6aPg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] habanalabs: free signal handle on failure
Date:   Sun,  5 Dec 2021 17:42:30 +0200
Message-Id: <20211205154236.2198481-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211205154236.2198481-1-ogabbay@kernel.org>
References: <20211205154236.2198481-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a bug where in case of failure to allocate idr, the handle's
memory wasn't freed as part of the error handling code.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 8be547b0926c..d169418197c0 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -1838,7 +1838,7 @@ static int cs_ioctl_reserve_signals(struct hl_fpriv *hpriv,
 	if (hdl_id < 0) {
 		dev_err(hdev->dev, "Failed to allocate IDR for a new signal reservation\n");
 		rc = -EINVAL;
-		goto out;
+		goto free_handle;
 	}
 
 	handle->id = hdl_id;
@@ -1891,7 +1891,9 @@ static int cs_ioctl_reserve_signals(struct hl_fpriv *hpriv,
 	idr_remove(&mgr->handles, hdl_id);
 	spin_unlock(&mgr->lock);
 
+free_handle:
 	kfree(handle);
+
 out:
 	return rc;
 }
-- 
2.25.1

