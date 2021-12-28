Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5505480789
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 09:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbhL1I7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 03:59:31 -0500
Received: from out162-62-57-137.mail.qq.com ([162.62.57.137]:36951 "EHLO
        out162-62-57-137.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229843AbhL1I7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 03:59:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1640681967;
        bh=+689YS5oM8/gTYb5QJQcojo4pLXNJ21HNXCsd40T7Rc=;
        h=From:To:Cc:Subject:Date;
        b=KljtKW3mEfYpPaPEF8YGX0p6VZtFEiu0Oj22IfjSHjakj3i6WYgV5WIsaceo069Om
         amBT/Oly1Ufoj9s2tJn+2MMggJFTaXpv7PhJPzioBdVMHf1N6lN9XiQNw738EqlWAn
         qPPWCRdusrChhOKjmGmsd8Ye6p+09bwg709mm0/c=
Received: from localhost.localdomain ([159.226.95.43])
        by newxmesmtplogicsvrszc9.qq.com (NewEsmtp) with SMTP
        id ED8116A4; Tue, 28 Dec 2021 16:59:24 +0800
X-QQ-mid: xmsmtpt1640681964ty2qopx5s
Message-ID: <tencent_C851C0324431466CBC22D60C5C6AC4A8E808@qq.com>
X-QQ-XMAILINFO: N0opbxSOYLeWlVkPhlVUM3ptA5o5FhAyD9gUiw/Kkkk7/zd5wVHwOXTs3ttKOX
         lCQz67LWONT/NzSTJGKrNfLscqRyqdg1oMdBa3H9gYHKyiShdYtUf1tYoCXV7RQnQCzRFLfOYXFd
         A0ofxdjsW9kZ+GN90Y9abx8q1HBA8x3QWcQfeA50dk1paDb6FlvNf3EWLm3/DtXsYQTHuKc/hBch
         qQ8MGao13Rw3HAIVHKGDH5vruoABOSyhl7jcZiFWnIjGktoXz1vXbzHMj0ppeTJVmvwptnaDJGbP
         k2nlId5a4gz1VHAzFH2cYtjE466B7PjnabkdsMMU1Uff4puks9bEGtMqr0WXVbeHEtlnANwPoGIh
         wUug4Bp6wMcmDqANzEugfb/6mRdotnqyQIkZtE2PeSixCQMQ+MNxOvMk5Y5BkpRxOKiXp2XtpV3+
         LQipUtBsWITE1ihQAV/CvhqNnWG0FZCleuXrZeYMFmog22aMjtCi1mPo932rN6wEbDtF4xGuJMNO
         C15+KuYHOMBQbDdFy53JG39ohqHMbjTR2WVvwCbESmG7hza6wFuwgQ220B6UK9J8Ct8/xMrLivqo
         xrNfoHVK+uhFI22ve9SshIzL/AbaO7e3YPvfafoklTjftaeKRkChWPoWoQ6Krqmdhy+uK7QNIZBw
         jztsphWfTPnoqRMBaT8davnnlyCsSjIl1kxPWLUCOV1Tnk/K5PyXeIetRzXtPnOIUi/G1vCcEev7
         dm+K31DZGS2/qVzctYrdTyuH1loFVM+IF6LHGtQ4bN61m3ND8MEq/3+zFz8LDS2VLOJgSXUFEfld
         bDJHBpjWq8UiZLajI5axX+Ptxtm0Hq1r2jljhZ2Ikl6MhCNZU3GACI4QvY5OoBF0R799Hs714Yog
         ==
From:   Peiwei Hu <jlu.hpw@foxmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org, Peiwei Hu <jlu.hpw@foxmail.com>
Subject: [PATCH] hwmon: add free before exiting xgene_hwmon_probe
Date:   Tue, 28 Dec 2021 16:59:10 +0800
X-OQ-MSGID: <20211228085910.3293192-1-jlu.hpw@foxmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do kfifo_free(&ctx->async_msg_fifo) before error exiting
instead of returning directly.

Signed-off-by: Peiwei Hu <jlu.hpw@foxmail.com>
---
 drivers/hwmon/xgene-hwmon.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/xgene-hwmon.c b/drivers/hwmon/xgene-hwmon.c
index 30aae8642069..5cde837bfd09 100644
--- a/drivers/hwmon/xgene-hwmon.c
+++ b/drivers/hwmon/xgene-hwmon.c
@@ -659,8 +659,10 @@ static int xgene_hwmon_probe(struct platform_device *pdev)
 
 		acpi_id = acpi_match_device(pdev->dev.driver->acpi_match_table,
 					    &pdev->dev);
-		if (!acpi_id)
-			return -EINVAL;
+		if (!acpi_id) {
+			rc = -EINVAL;
+			goto out_mbox_free;
+		}
 
 		version = (int)acpi_id->driver_data;
 
-- 
2.25.1

