Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C90471926
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 08:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhLLHky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 02:40:54 -0500
Received: from smtpbg587.qq.com ([113.96.223.105]:34676 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhLLHkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 02:40:53 -0500
X-QQ-mid: bizesmtp50t1639294849tih7sgr2
Received: from localhost.localdomain (unknown [182.132.179.213])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sun, 12 Dec 2021 15:40:48 +0800 (CST)
X-QQ-SSF: 01000000002000D0I000B00A0000000
X-QQ-FEAT: yoVs+U5I/l63biBhPqvfp8hx+O7T6kXoc4RHqDESnkArQQE4XerTuRI1t7JJz
        iCQVtLEJfvjF9Chw9ZqxSzssfFnMw8xrexyzEhvGkwVejuYa+M2EdXc2fJij1ThkIqnHrRq
        wNs2Rh78yHxPuNqeB5FUFKWsVAqKv3z5SY4TQXszoim6SJFY4v1S/WzR9UuPRVY3s0tvqkg
        jki6QVJsMX/E3GEjtt8w+9hBJfI1GmYwzGVV1luWsXUncHJOEUWUK5hLmQaloIDbeoufsi3
        TSmgWf8hRUY+FfBrSm0VvslrAui0QCf8YAHjeQ5EEhjfClpvreMyK4ccOvtXu846UKlIXs0
        12asVL7RDJ7B0lxs6myLEPRLBBL2+mWdsV5d43uMUHgZY6zsqw=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     wangborong@cdjrlc.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/virt/fsl_hypervisor: remove an unneeded variable
Date:   Sun, 12 Dec 2021 15:40:47 +0800
Message-Id: <20211212074047.330285-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable `ret' used for returning is never changed in function
`fsl_hv_close'. So that it can be removed and just return its
initial value 0 at the end of `fsl_hv_close' function.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/virt/fsl_hypervisor.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/virt/fsl_hypervisor.c b/drivers/virt/fsl_hypervisor.c
index 46ee0a0998b6..e49bec8bc8a4 100644
--- a/drivers/virt/fsl_hypervisor.c
+++ b/drivers/virt/fsl_hypervisor.c
@@ -687,15 +687,13 @@ static int fsl_hv_close(struct inode *inode, struct file *filp)
 	struct doorbell_queue *dbq = filp->private_data;
 	unsigned long flags;
 
-	int ret = 0;
-
 	spin_lock_irqsave(&db_list_lock, flags);
 	list_del(&dbq->list);
 	spin_unlock_irqrestore(&db_list_lock, flags);
 
 	kfree(dbq);
 
-	return ret;
+	return 0;
 }
 
 static const struct file_operations fsl_hv_fops = {
-- 
2.34.1

