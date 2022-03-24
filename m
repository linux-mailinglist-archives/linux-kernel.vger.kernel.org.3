Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD164E5F24
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348419AbiCXHNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238062AbiCXHNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:13:08 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C68985A3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:11:36 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 24 Mar
 2022 15:11:27 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Thu, 24 Mar
 2022 15:11:27 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <gregkh@linuxfoundation.org>, <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>, Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH] char: mwave: Fix assigning negative error code to unsigned variable
Date:   Thu, 24 Mar 2022 15:11:26 +0800
Message-ID: <1648105886-9323-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-125.meizu.com (172.16.1.125) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the issue by changing the type of usSmapiOK to short, since the 
negative error value is assigned to unsigned variables would be ignored.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/char/mwave/smapi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/mwave/smapi.c b/drivers/char/mwave/smapi.c
index f8d79d3..4a0123d 100644
--- a/drivers/char/mwave/smapi.c
+++ b/drivers/char/mwave/smapi.c
@@ -66,10 +66,11 @@ static int smapi_request(unsigned short inBX, unsigned short inCX,
 	unsigned short myoutDX = 5, *pmyoutDX = &myoutDX;
 	unsigned short myoutDI = 6, *pmyoutDI = &myoutDI;
 	unsigned short myoutSI = 7, *pmyoutSI = &myoutSI;
-	unsigned short usSmapiOK = -EIO, *pusSmapiOK = &usSmapiOK;
+	unsigned short *pusSmapiOK = &usSmapiOK;
 	unsigned int inBXCX = (inBX << 16) | inCX;
 	unsigned int inDISI = (inDI << 16) | inSI;
 	int retval = 0;
+	short usSmapiOK = -EIO;
 
 	PRINTK_5(TRACE_SMAPI, "inBX %x inCX %x inDI %x inSI %x\n",
 		inBX, inCX, inDI, inSI);
-- 
2.7.4

