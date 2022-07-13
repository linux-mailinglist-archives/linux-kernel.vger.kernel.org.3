Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5718F572CDF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 07:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbiGMFCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 01:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbiGMFCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 01:02:21 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A86932073
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:02:18 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id j22so17885935ejs.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o4KU5GfxgtTjFqUAyp9nHhKmqMhsJeckxPFNR7wwGhI=;
        b=Su/LoPrTpSQslxh3aRcpzhdO0vAseTq7tIMW75z4Nu13bfhVvB99uQhmU06C07/0TP
         sWzwKBqhY7cdtxYfZjAdgRCDWtB5MaOW3XZneAp+qDINW7YwDdfQmKesvSRi74r18UWh
         UDx6poxvQTA5+Ll78Drgf76DhYtDF6BlPvewOry66lnQ2qEiz9hqYAegzQALzfFTzlSC
         ajRPGjSA/s/GVH14orBrUhm4vMGoGqglqakwQYutWY0/hG5CA4/q8VgAMkqYJp/C966s
         1oPx2iKMCtMfJJkCTPms99QqE3E5Oxjbe+wTTKICBO+kiwcWOm/mQi24D8qGpNwfF2mv
         6c3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o4KU5GfxgtTjFqUAyp9nHhKmqMhsJeckxPFNR7wwGhI=;
        b=CG4LsdKtwXZ9siPhWQWwL+7inS2BlhbbQLkdFYOTzzTgcATd4QML4izahn14qlk7dn
         JnVLM5R8ze8S5oOCIszExLwYPwxDPzd62IZsLxl1TlXCRB5UwZfDQo738GvIQ7Jt09d/
         X5q5V6ckqkt88xrgJCfu9aSG7oK6gFm78UMOvUuneHAF5tYLBhzyP7q0yFnqHNE38cVt
         /dwVoO9tu+KarQa3itObGLyndwhr1AjzxovnIt6sSo2chqGvOMpfPboHEJanH5oGJov2
         qOWC46vQETs7Z7Fa2NEmyh12jAWCzgPiYWE/JVWIe8v2waDoJ9PlQdA4MDbE+V3lxLkE
         TaOg==
X-Gm-Message-State: AJIora8hFiKj6tlj3clvQhFj3DItqYe4SgSdUNMAQ4ciyke5+8EhoFCB
        eb7gDN/nTG4cQ1l4T7vKdCE=
X-Google-Smtp-Source: AGRyM1t6uC82lJ3lW6knb43+V1KxvgxUhrauEIGPKf18IZ1Sr7igNIjbN7AKlIBzbTBm41bCL3uyVg==
X-Received: by 2002:a17:907:6d9b:b0:72b:5cc3:79cf with SMTP id sb27-20020a1709076d9b00b0072b5cc379cfmr1641151ejc.382.1657688536770;
        Tue, 12 Jul 2022 22:02:16 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id b13-20020a17090630cd00b0072637b9c8c0sm4506178ejb.219.2022.07.12.22.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 22:02:16 -0700 (PDT)
Date:   Wed, 13 Jul 2022 07:02:14 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] staging: vt6655: Convert macro
 vt6655_mac_word_reg_bits_off to function
Message-ID: <04fb37871c4d383c27287934a0dddb3aa7974b08.1657657918.git.philipp.g.hortmann@gmail.com>
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

Convert macro vt6655_mac_word_reg_bits_off to function.
checkpatch.pl does not accept multiline macros.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/mac.c | 8 ++++++++
 drivers/staging/vt6655/mac.h | 9 ++-------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vt6655/mac.c b/drivers/staging/vt6655/mac.c
index aa9684229dfe..a7f645f9ccf8 100644
--- a/drivers/staging/vt6655/mac.c
+++ b/drivers/staging/vt6655/mac.c
@@ -62,6 +62,14 @@ void vt6655_mac_reg_bits_off(void __iomem *iobase, const u8 reg_offset, const u8
 	iowrite8(reg_value & ~(bit_mask), iobase + reg_offset);
 }
 
+void vt6655_mac_word_reg_bits_off(void __iomem *iobase, const u8 reg_offset, const u16 bit_mask)
+{
+	unsigned short reg_value;
+
+	reg_value = ioread16(iobase + reg_offset);
+	iowrite16(reg_value & ~(bit_mask), iobase + reg_offset);
+}
+
 /*
  * Description:
  *      Test if all test bits off
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index e7b648cf2024..b307161818a0 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -537,13 +537,6 @@
 
 /*---------------------  Export Macros ------------------------------*/
 
-#define vt6655_mac_word_reg_bits_off(iobase, reg_offset, bit_mask)	\
-do {									\
-	unsigned short reg_value;					\
-	reg_value = ioread16(iobase + reg_offset);			\
-	iowrite16(reg_value & ~(bit_mask), iobase + reg_offset);	\
-} while (0)
-
 #define MACvReceive0(iobase)						\
 do {									\
 	unsigned long dwData;						\
@@ -648,6 +641,8 @@ do {									\
 void vt6655_mac_reg_bits_on(void __iomem *iobase, const u8 reg_offset, const u8 bit_mask);
 void vt6655_mac_word_reg_bits_on(void __iomem *iobase, const u8 reg_offset, const u16 bit_mask);
 void vt6655_mac_reg_bits_off(void __iomem *iobase, const u8 reg_offset, const u8 bit_mask);
+void vt6655_mac_word_reg_bits_off(void __iomem *iobase, const u8 reg_offset, const u16 bit_mask);
+
 bool MACbIsRegBitsOff(struct vnt_private *priv, unsigned char byRegOfs,
 		      unsigned char byTestBits);
 
-- 
2.37.0

