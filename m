Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88AF446E413
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbhLIIZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 03:25:28 -0500
Received: from foss.arm.com ([217.140.110.172]:51086 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234667AbhLIIZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:25:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3EB011FB;
        Thu,  9 Dec 2021 00:21:52 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CEF4E3F5A1;
        Thu,  9 Dec 2021 00:21:51 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] mailbox: pcc: Avoid using the uninitialized variable 'dev'
Date:   Thu,  9 Dec 2021 08:21:43 +0000
Message-Id: <20211209082143.619354-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch static checker warns:

  |  drivers/mailbox/pcc.c:292 pcc_mbox_request_channel()
  |  error: uninitialized symbol 'dev'.

Fix the same by using pr_err instead of dev_err as the variable 'dev'
is uninitialized at that stage.

Fixes: ce028702ddbc ("mailbox: pcc: Move bulk of PCCT parsing into pcc_mbox_probe")
Cc: Jassi Brar <jassisinghbrar@gmail.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/pcc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 887a3704c12e..e0a1ab3861f0 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -289,7 +289,7 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 	pchan = chan_info + subspace_id;
 	chan = pchan->chan.mchan;
 	if (IS_ERR(chan) || chan->cl) {
-		dev_err(dev, "Channel not found for idx: %d\n", subspace_id);
+		pr_err("Channel not found for idx: %d\n", subspace_id);
 		return ERR_PTR(-EBUSY);
 	}
 	dev = chan->mbox->dev;
-- 
2.25.1

