Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AB251EAEA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 04:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380485AbiEHCfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 22:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiEHCfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 22:35:30 -0400
X-Greylist: delayed 68 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 07 May 2022 19:31:38 PDT
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D3C10FED
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 19:31:38 -0700 (PDT)
X-QQ-mid: bizesmtp70t1651976959tg41pyo4
Received: from localhost.localdomain ( [125.69.42.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 08 May 2022 10:29:17 +0800 (CST)
X-QQ-SSF: 01000000002000E0S000B00A0000000
X-QQ-FEAT: geCjBjpTnm6wH8dkcfptTm/kV0xeKQiTfO8xFucTmeXpMaef0xVIeQzWjo/pd
        HFX9nuI6I03xLu9OxmVKcmtN9Kcvn5Is8fMTqirEQFQaq4UH4xAErWVOlDb02H/NObwpHvz
        Vc5aHd9tqX1lisXXcDKDaqQWh9N3f+iJE8PRBcYhxwUuBOcjfpXFMWHz2Oj6YCjGICs6jY8
        2V7aqrWDU91ff/O2dBspMDrum2Vl4laO8GUAmsKe+kzYqv1WJdoLIEe5lEb06N4h63LZ3Kk
        6dd93MguMzpHOuI2T38G0+4/mklhPPrEvQL4L/DIPhrTzW3ip2pp8Xq9h06zRlfw6Gmguvv
        FVrhnRHT/o3Sc3QCME=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     jcmvbkbc@gmail.com
Cc:     chris@zankel.net, wangborong@cdjrlc.com,
        linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xtensa: no need to initialise statics to 0
Date:   Sun,  8 May 2022 10:29:10 +0800
Message-Id: <20220508022910.98481-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static variables do not need to be initialised to 0, because compiler
will initialise all uninitialised statics to 0. Thus, remove the
unneeded initializations.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/xtensa/platforms/xt2000/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/platforms/xt2000/setup.c b/arch/xtensa/platforms/xt2000/setup.c
index 145d129be76f..0dc22c371614 100644
--- a/arch/xtensa/platforms/xt2000/setup.c
+++ b/arch/xtensa/platforms/xt2000/setup.c
@@ -78,7 +78,7 @@ void __init platform_init(bp_tag_t *first)
 
 void platform_heartbeat(void)
 {
-	static int i=0, t = 0;
+	static int i, t;
 
 	if (--t < 0)
 	{
-- 
2.35.1

