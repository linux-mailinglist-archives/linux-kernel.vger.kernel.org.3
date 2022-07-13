Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA51572CDE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 07:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbiGMFCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 01:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbiGMFCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 01:02:10 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5C6DC8A2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:02:07 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id va17so17915769ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wN7/gNJBgu38ouetv3OP7CgVYpHlU5zqKmahD//PyWE=;
        b=cN2okkhM1rEKWcNhuv5KbGnU2IcO4jwVN8X0XFaLqPRQiZJwxm8IoWwAzVOezItXzr
         B4szhFyzRYD+LBsTNUQ0z53PUKkXajAmQEauQCQxBwkLUZecCyDnHEdtB1Oz2cj3bYbg
         pOs15l+JSGNdegyMooZQ3pcK4HlW4VcRxV6PFehHIR740IN0q7kHkztes1hcGVjB7YxZ
         tUBuRHDl43nhO6idD5ci9/DM7WG4fSRwobULAgOmtmdHwGuYk+5FK7isGzP1I5MFHoBo
         h0kFB5b7nCxV3uGcwb1p86EXi7ZQCe+kWiVsKS24qzdcmgokIAFTitwYznvZSvJYMNHF
         Uhpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wN7/gNJBgu38ouetv3OP7CgVYpHlU5zqKmahD//PyWE=;
        b=r+7ZElMQCN0pWhFYd/8HqApYWw+Zu10p7xfuItX+vJgUQtd60YVNjSmUmpAhf6OTPr
         JV/YhRZso8/8cfck5xp/mAXw7tYI9aaeP5+3LwHl/l5l0i2FlvAj+eAHWUJcN9j9v8TN
         Q2Qpmih6a8U3MrwGihlR2tPDE40BGPnHVxg2OI3lQL2WDdmeUVrBvZY0Kp6Ry+S/OtkB
         0mcKy8gjC8uZCeqq8NJ7RM+pUJx5wSArV1WRf0jmpYy5diC6fpVaLuCSj9X2hcWMw2EI
         8SXLvqlktFTjuvzW8ZMxVX/v+NrUgqjD8LZ1Vt0c/aL0TaOlM4RfvqMdPt/65L65PEQY
         0yhA==
X-Gm-Message-State: AJIora+aNgmS2qgbFYpAT2kFia5TYEhcf0FKXwl6r1eg6VHW861JAilQ
        KdON/XPUmnmBBajGoyQzX5c=
X-Google-Smtp-Source: AGRyM1tLEBiNFrjipJRZQZQ0orwZb4Aj3HpFuQ9Sodd/jBAt8/Gq0iZZo7rQ+cuL6u4FibFFVsImEA==
X-Received: by 2002:a17:907:62a6:b0:6ef:8118:d3e2 with SMTP id nd38-20020a17090762a600b006ef8118d3e2mr1501409ejc.605.1657688526117;
        Tue, 12 Jul 2022 22:02:06 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id o15-20020a170906768f00b0070efa110afcsm4493151ejm.83.2022.07.12.22.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 22:02:05 -0700 (PDT)
Date:   Wed, 13 Jul 2022 07:02:03 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] staging: vt6655: Convert macro vt6655_mac_reg_bits_off
 to function
Message-ID: <422950c8e1349fba2f97b0b95ba13f361cde05d9.1657657918.git.philipp.g.hortmann@gmail.com>
References: <cover.1657657918.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1657657918.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert macro vt6655_mac_reg_bits_off to function.
checkpatch.pl does not accept multiline macros.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/mac.c | 8 ++++++++
 drivers/staging/vt6655/mac.h | 8 +-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vt6655/mac.c b/drivers/staging/vt6655/mac.c
index 076e1bfff3e0..aa9684229dfe 100644
--- a/drivers/staging/vt6655/mac.c
+++ b/drivers/staging/vt6655/mac.c
@@ -54,6 +54,14 @@ void vt6655_mac_word_reg_bits_on(void __iomem *iobase, const u8 reg_offset, cons
 	iowrite16(reg_value | (bit_mask), iobase + reg_offset);
 }
 
+void vt6655_mac_reg_bits_off(void __iomem *iobase, const u8 reg_offset, const u8 bit_mask)
+{
+	unsigned char reg_value;
+
+	reg_value = ioread8(iobase + reg_offset);
+	iowrite8(reg_value & ~(bit_mask), iobase + reg_offset);
+}
+
 /*
  * Description:
  *      Test if all test bits off
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 3b23334db538..e7b648cf2024 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -537,13 +537,6 @@
 
 /*---------------------  Export Macros ------------------------------*/
 
-#define vt6655_mac_reg_bits_off(iobase, reg_offset, bit_mask)			\
-do {									\
-	unsigned char reg_value;					\
-	reg_value = ioread8(iobase + reg_offset);			\
-	iowrite8(reg_value & ~(bit_mask), iobase + reg_offset);		\
-} while (0)
-
 #define vt6655_mac_word_reg_bits_off(iobase, reg_offset, bit_mask)	\
 do {									\
 	unsigned short reg_value;					\
@@ -654,6 +647,7 @@ do {									\
 
 void vt6655_mac_reg_bits_on(void __iomem *iobase, const u8 reg_offset, const u8 bit_mask);
 void vt6655_mac_word_reg_bits_on(void __iomem *iobase, const u8 reg_offset, const u16 bit_mask);
+void vt6655_mac_reg_bits_off(void __iomem *iobase, const u8 reg_offset, const u8 bit_mask);
 bool MACbIsRegBitsOff(struct vnt_private *priv, unsigned char byRegOfs,
 		      unsigned char byTestBits);
 
-- 
2.37.0

