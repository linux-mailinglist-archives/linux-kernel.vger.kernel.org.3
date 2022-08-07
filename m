Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2697458BC46
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 20:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbiHGSOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 14:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbiHGSOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 14:14:03 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A35695A4
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 11:13:59 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z22so8937994edd.6
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 11:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc;
        bh=vMHi6yjR8K+qFLdzbL1qS1VwBovHqrZTSu9kJ2npcA4=;
        b=LCyoBZP90E+9ObSdPhnohQL4+qRXAFcyx+5ucHnVgxvNxlRzJttmiInnAJCeFhMWrJ
         sAYDRPSn3P0y9EUsmvtvr7wswB7/eYYRjCq1kA+Mr3+8jXCiInLmF1wLJeVszjr3Arxz
         eq485gWizpqmAe7WAtdCcC37bmKt8inIBhNGkzbY171RDvFcQtpO5M78HwSi5Fj+8DQb
         ne4xgm3zpZp7+4lj0WsNnlqw6nkRyzQJv2kg36+id7wzEWS8ntjddcHlCfOh8KSYBjVK
         12jwZZc7Au0IjJtn5a/2WxNxL6U8q7BDgn5iKSsox1VYkk2DIEhz7xwGjQ7+QQD4VgdJ
         LJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc;
        bh=vMHi6yjR8K+qFLdzbL1qS1VwBovHqrZTSu9kJ2npcA4=;
        b=CxgZKje/o6yhUwN5+ZHMOS8NGPLMuDuEt1hBDI5diAiZ/9e0JmG46pBjP/yJOSRCU5
         r5PVxRRjlscz8bH4vOMPEitOpmY3mYbrDlRvxF4L8rpZ7QNP2iv9i+1VJX8MDCwY2/MB
         N8RsrQIl2xDqRpULC/w/f800BT4iN7QefRgFE6tKiKdvqYuhL5hc5NbkYDUpn738IYUe
         mkoOBIYgl1s0BplMzSqS7lbZwh6xZWhC3zhPu0RyouFLGiCPB/G+Z39gRHxFNObGTbGa
         nghfoHrUYUNviMdlw6YPigIC8MZiZOdkL2uGy0FhWGWeydP8ENaAW0wLDI/CyI+iLCJ+
         oIPQ==
X-Gm-Message-State: ACgBeo0uqPsJb6W1k0HOvSZwMUVaffj+Z6b8zOQvNPS12eF8QEK9XNCv
        SQIukNoXzlpo8AxahN24+8E=
X-Google-Smtp-Source: AA6agR46EgO+2eepxhX3z5DGowcKmMPWYCnnyQzdj/zHuozdCf99GIjeXiJAFxyLWE8nAVbyDj/uWg==
X-Received: by 2002:a05:6402:348f:b0:43d:e568:97bd with SMTP id v15-20020a056402348f00b0043de56897bdmr14845164edc.279.1659896037459;
        Sun, 07 Aug 2022 11:13:57 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id qk27-20020a170906d9db00b006ff0b457cdasm4053477ejb.53.2022.08.07.11.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 11:13:57 -0700 (PDT)
Date:   Sun, 7 Aug 2022 20:13:55 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] staging: vt6655: Convert macro
 MACvDisableBarkerPreambleMd
Message-ID: <2a1d67762d9ecf3f30f3e293ad6ab997ad278b84.1659892671.git.philipp.g.hortmann@gmail.com>
References: <cover.1659892670.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1659892670.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert macro MACvDisableBarkerPreambleMd to static function which calls
the common static function vt6655_mac_clear_bits. This saves
codelines and multiline macros are not liked by kernel community.
Function name is also changed to avoid CamelCase which is not accepted
by checkpatch.pl and to clean up namespace.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: Changed used function to vt6655_mac_clear_bits
---
 drivers/staging/vt6655/device_main.c | 8 +++++++-
 drivers/staging/vt6655/mac.h         | 8 --------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 46bd88ee4668..8e2a976aaaad 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -248,6 +248,12 @@ static void vt6655_mac_en_barker_preamble_md(void __iomem *iobase)
 {
 	vt6655_mac_set_bits(iobase, ENCFG_BARKERPREAM);
 }
+
+static void vt6655_mac_dis_barker_preamble_md(void __iomem *iobase)
+{
+	vt6655_mac_clear_bits(iobase, ENCFG_BARKERPREAM);
+}
+
 /*
  * Initialisation of MAC & BBP registers
  */
@@ -1486,7 +1492,7 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 			vt6655_mac_en_barker_preamble_md(priv->port_offset);
 			priv->preamble_type = true;
 		} else {
-			MACvDisableBarkerPreambleMd(priv->port_offset);
+			vt6655_mac_dis_barker_preamble_md(priv->port_offset);
 			priv->preamble_type = false;
 		}
 	}
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 3400ea15b673..a75cd318ee25 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -543,14 +543,6 @@
 #define MACvSelectPage1(iobase)				\
 	iowrite8(1, iobase + MAC_REG_PAGE1SEL)
 
-#define MACvDisableBarkerPreambleMd(iobase)				\
-do {									\
-	unsigned long dwOrgValue;					\
-	dwOrgValue = ioread32(iobase + MAC_REG_ENCFG);			\
-	dwOrgValue = dwOrgValue & ~ENCFG_BARKERPREAM;			\
-	iowrite32((u32)dwOrgValue, iobase + MAC_REG_ENCFG);		\
-} while (0)
-
 #define MACvSetBBType(iobase, byTyp)					\
 do {									\
 	unsigned long dwOrgValue;					\
-- 
2.37.1

