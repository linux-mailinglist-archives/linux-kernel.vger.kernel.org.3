Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8106572CDD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 07:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbiGMFC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 01:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbiGMFBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 01:01:50 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E170DC19C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:01:47 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l23so17846736ejr.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8pZzd2vkbWzLoKgooVDcdAnN/Oz4GsC2lEDWrGxwNUk=;
        b=KpZJ/sxYtSgXBtNQ+dEC26HGEsAQPY7u2WhDe5g6ImWu92np52XYUjSP60mI+gMuaw
         T9k19F3IUTnr7YYdGx6b6LkfB/g74O8A1ZFpSeRdSg2iEtxiPf+pBlQ2STr2blPeCsZD
         U//nJZq1+EK8pZUUqpuJPRhWHEKAB1YuNkRr0cOijw6Y2YkgoATpTWj78RqpmczydnS/
         Gl/7ogIr9sON1sb93fvZ6n88d+4i4L67P+MJhdWrm4m6snOoePVKdgcbTU7kFggjVb89
         T5RfyqA7sQ2NAY4J1eVSfJ9GDXcpElcoF3FX0cmYM0ADpDSUe9UBOr7jTN3PsQyO/j5D
         KZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8pZzd2vkbWzLoKgooVDcdAnN/Oz4GsC2lEDWrGxwNUk=;
        b=of5qtH2TwSw+21Mm5PrwzsC21QqMRUMT8kxd59ynsHVgo/dy8QONHVb+7Cx0kbVO9l
         uOZMhuj/Z8IbT9xDpL67KagsuYpUp8H3hOEI3rq0Q4qK3rrCCu7GeAK02G81l2TtQvmi
         41P3B9zQFZDqifHeaNOhVkvmtM2UDKQLi921Z5v6JqUaux0oR2RdUJSMk5qIT0lEQyAL
         xVoj4yJ9sB18yjv2KXuzPczd7h3eZ2Kpo1YRBclrn5QnTjRDQItHAqk3YOfTj6PJOwVo
         o97PYNHinCDSsDlxyHefexqqcT2l+lmaN59p/ybHnbVgtHbi8Af3QFepahZm/nu5TUWq
         1aQw==
X-Gm-Message-State: AJIora+GxgohkWb8+olCcD3xsYIGVO76y2WBLTdvt2g+L2TKQKYNcj3L
        LvYcBGR787uojYorO3Zj1F8=
X-Google-Smtp-Source: AGRyM1uRDQnlEJOfnP6nA+lxydgis+vWUMY0ZLHQjr1LIpnr00RBVAO8LZmUkvb2Sj9kxQlcRMuu8A==
X-Received: by 2002:a17:906:284c:b0:727:3773:1a53 with SMTP id s12-20020a170906284c00b0072737731a53mr1461214ejc.765.1657688506419;
        Tue, 12 Jul 2022 22:01:46 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id i19-20020a170906115300b007262b9f7120sm4475495eja.167.2022.07.12.22.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 22:01:46 -0700 (PDT)
Date:   Wed, 13 Jul 2022 07:01:37 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] staging: vt6655: Convert macro
 vt6655_mac_word_reg_bits_on to function
Message-ID: <255c7f5a5e98a399aa4e299e7cf567016bd86d60.1657657918.git.philipp.g.hortmann@gmail.com>
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

Convert macro vt6655_mac_word_reg_bits_on to function.
checkpatch.pl does not accept multiline macros.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/mac.c | 8 ++++++++
 drivers/staging/vt6655/mac.h | 8 +-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vt6655/mac.c b/drivers/staging/vt6655/mac.c
index 902034a28c6c..076e1bfff3e0 100644
--- a/drivers/staging/vt6655/mac.c
+++ b/drivers/staging/vt6655/mac.c
@@ -46,6 +46,14 @@ void vt6655_mac_reg_bits_on(void __iomem *iobase, const u8 reg_offset, const u8
 	iowrite8(reg_value | bit_mask, iobase + reg_offset);
 }
 
+void vt6655_mac_word_reg_bits_on(void __iomem *iobase, const u8 reg_offset, const u16 bit_mask)
+{
+	unsigned short reg_value;
+
+	reg_value = ioread16(iobase + reg_offset);
+	iowrite16(reg_value | (bit_mask), iobase + reg_offset);
+}
+
 /*
  * Description:
  *      Test if all test bits off
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 031316d42dba..3b23334db538 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -537,13 +537,6 @@
 
 /*---------------------  Export Macros ------------------------------*/
 
-#define vt6655_mac_word_reg_bits_on(iobase, reg_offset, bit_mask)	\
-do {									\
-	unsigned short reg_value;					\
-	reg_value = ioread16(iobase + reg_offset);			\
-	iowrite16(reg_value | (bit_mask), iobase + reg_offset);		\
-} while (0)
-
 #define vt6655_mac_reg_bits_off(iobase, reg_offset, bit_mask)			\
 do {									\
 	unsigned char reg_value;					\
@@ -660,6 +653,7 @@ do {									\
 	((unsigned short)(((unsigned char)(lb)) | (((unsigned short)((unsigned char)(hb))) << 8)))
 
 void vt6655_mac_reg_bits_on(void __iomem *iobase, const u8 reg_offset, const u8 bit_mask);
+void vt6655_mac_word_reg_bits_on(void __iomem *iobase, const u8 reg_offset, const u16 bit_mask);
 bool MACbIsRegBitsOff(struct vnt_private *priv, unsigned char byRegOfs,
 		      unsigned char byTestBits);
 
-- 
2.37.0

