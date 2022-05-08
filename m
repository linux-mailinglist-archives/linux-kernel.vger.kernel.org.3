Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6BF51EAED
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 04:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387354AbiEHCiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 22:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiEHCiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 22:38:00 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EE411144
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 19:34:07 -0700 (PDT)
X-QQ-mid: bizesmtp80t1651977243trr81gac
Received: from localhost.localdomain ( [125.69.42.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 08 May 2022 10:34:02 +0800 (CST)
X-QQ-SSF: 01000000002000E0S000B00A0000000
X-QQ-FEAT: a4niRxydalGnKaWQvlEkNpty5z+DUQ5beMSeF/B8CIO8DML5fxpJb59elfVlp
        KDhEN5AgpLeTNStES/32PxL4irmUJOtTkTjRnW6/F4JFZbikIYtvk0HGezXRtOfoC0s67lf
        fxMW7Cpc4y1+TJFbk3lmHNsivsIzyupeXpPzRcN8A4T/daaYJEoj1ljPZ+2wdoMfP7HQqv6
        gcfxxHmn1NhUsiNF32kHED1s8Tx+yfOFaby3gCHJM30/9Hl0NNzgf891xs5npY9W/MV2TPF
        5Q6tDTwdeAp9xEu7/j5Br+eUUlvr5SzAiY8xRtEYDElklngVnuYVEOHFMjI2FrCRCLUA18l
        s95GYW1NrYOv4H7Qrjliz8O4+8VQg==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     zbr@ioremap.net
Cc:     linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] w1: no need to initialise statics to 0
Date:   Sun,  8 May 2022 10:34:00 +0800
Message-Id: <20220508023400.102244-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
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
 drivers/w1/w1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index f2ae2e563dc5..bb28e36993d6 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -32,7 +32,7 @@ static int w1_timeout = 10;
 module_param_named(timeout, w1_timeout, int, 0);
 MODULE_PARM_DESC(timeout, "time in seconds between automatic slave searches");
 
-static int w1_timeout_us = 0;
+static int w1_timeout_us;
 module_param_named(timeout_us, w1_timeout_us, int, 0);
 MODULE_PARM_DESC(timeout_us,
 		 "time in microseconds between automatic slave searches");
-- 
2.35.1


