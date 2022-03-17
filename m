Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645814DC395
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 11:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiCQKGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 06:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiCQKGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 06:06:42 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358331DC998
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 03:05:24 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 17 Mar
 2022 18:05:22 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Thu, 17 Mar
 2022 18:05:22 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <sudeep.holla@arm.com>, <cristian.marussi@arm.com>,
        <ardb@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <bjorn.andersson@linaro.org>, <linux-kernel@vger.kernel.org>,
        Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH] firmware: edd: Remove redundant condition
Date:   Thu, 17 Mar 2022 18:05:20 +0800
Message-ID: <1647511520-26455-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logic !A || A && B is equivalent to !A || B. so we have
to make code clear.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/firmware/edd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/firmware/edd.c b/drivers/firmware/edd.c
index 69353dd..5cc2389 100644
--- a/drivers/firmware/edd.c
+++ b/drivers/firmware/edd.c
@@ -685,8 +685,7 @@ static void edd_populate_dir(struct edd_device * edev)
 	int i;
 
 	for (i = 0; (attr = edd_attrs[i]) && !error; i++) {
-		if (!attr->test ||
-		    (attr->test && attr->test(edev)))
+		if (!attr->test || attr->test(edev))
 			error = sysfs_create_file(&edev->kobj,&attr->attr);
 	}
 
-- 
2.7.4

