Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556E25094C1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 03:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383687AbiDUBqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 21:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383675AbiDUBqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 21:46:06 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA5D765E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 18:43:18 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 21 Apr
 2022 09:43:17 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Thu, 21 Apr
 2022 09:43:16 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <gregkh@linuxfoundation.org>
CC:     <ardb@kernel.org>, <baihaowen@meizu.com>,
        <bjorn.andersson@linaro.org>, <cristian.marussi@arm.com>,
        <linux-kernel@vger.kernel.org>, <sudeep.holla@arm.com>
Subject: [PATCH V2] firmware: edd: Remove redundant condition
Date:   Thu, 21 Apr 2022 09:43:13 +0800
Message-ID: <1650505393-19398-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <YmBDgRYGdcjz3ppn@kroah.com>
References: <YmBDgRYGdcjz3ppn@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logic (!A || (A && B)) is equivalent to (!A || B). so we have
to make code clear.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
V1->V2: 
change changelog text
1. !A || A && B -> (!A || (A && B))
2. !A || B -> (!A || B)

 drivers/firmware/edd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/firmware/edd.c b/drivers/firmware/edd.c
index 69353dd0ea22..5cc238916551 100644
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

