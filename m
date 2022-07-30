Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0E3585BBC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 21:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbiG3TUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 15:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235715AbiG3TUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 15:20:35 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CF110570
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 12:20:34 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ez10so13701087ejc.13
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 12:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc;
        bh=HUoAZomuVEY3gWZs5PRO+GGlcpFSS2IlF4vVoPzeVgo=;
        b=HN2RwIDPEaVjNCV1XzPSUga1o1wtGNu7/UOLJgj5RnVjBNZl8cPif4Pxk1u6M9PH4/
         Xu9ffrQZeQ+D/+BB4eGl9BYvWuSdr/ZUtsQvlGgNskCjhn71D/8auNidWLp6ciZ9kvXO
         e52PgPCQw58BC7ngd6FnNKLujO0vTQvBkvu9wrWR/8tCB6tf5yuHY5S9/brMiDb+u9hL
         cYE1OcJD8b93E9/4usiin2XhQSlusoK2Vd8f2dTyyc7bpSE10pwCIdjIixrniaQMixuU
         UPgxLc2UHLjoalNv8BrGs3UvhvXlEBftUFZm2nRNdorbB9luhtO7kf3PYyPsnjoHAm7M
         mI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc;
        bh=HUoAZomuVEY3gWZs5PRO+GGlcpFSS2IlF4vVoPzeVgo=;
        b=Z4UOwvg3zgox289onb5bR6qGdzDdz07DRdfZBozc2a0r9ytzU509C6btt2L+szzxAs
         U64T/kiklLPkXuBi7M1eHj2RLCHL+n8AFUqvm470cVFnVMBVgP0Zgpj+1uJDUMZ0h0yW
         mct1zg6XxLJAX6+soSY3gDvEiqABS4GuX9uD5cHnCU35le/kKYKB7W4Tibv29wvTQlTh
         vfKeq0LM+yrTOpnh9Ue0ZT0gokiBEoDC9dL1soNG5llszFKXGie/3bGYra/wjoPo3jnG
         JlfDEQJwbhMFOmF/k2rk/65lzDtcIi9YoOkeIOWQBhxGtFw36cQawzfBYuONliplGdvk
         emMw==
X-Gm-Message-State: AJIora8bfhFTuXosFnDKdEwawR112sDdqGGL5tjBL1Rie8sghQ10KRJO
        EHu0VfQdkJrb8mccVVgafFi7wRag2rU=
X-Google-Smtp-Source: AGRyM1sJVck7k58kzPJmFKFcb8QhrXHG/kmie+BSgXBXqzStigwLX5UwwNgDAkLGbL4Ay+EMMYZu1A==
X-Received: by 2002:a17:907:2cef:b0:72b:5b3e:3d7a with SMTP id hz15-20020a1709072cef00b0072b5b3e3d7amr6942572ejc.293.1659208832652;
        Sat, 30 Jul 2022 12:20:32 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id g10-20020a1709067c4a00b0072ab06bf296sm3282425ejp.23.2022.07.30.12.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 12:20:32 -0700 (PDT)
Date:   Sat, 30 Jul 2022 21:20:30 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] staging: vt6655: Create one function for four macros
Message-ID: <d4768227a7ea10ccec6d08eb0c55f8790ef70379.1659192760.git.philipp.g.hortmann@gmail.com>
References: <cover.1659192760.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1659192760.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create function vt6655_mac_en_dis_bits_u32_reg with three parameters to
cover functionality of four macros.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/device_main.c | 12 ++++++++++--
 drivers/staging/vt6655/mac.h         |  3 +++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 3565aa53f007..5f64204dc312 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -216,15 +216,23 @@ static void vt6655_mac_dma_ctl(void __iomem *iobase, u8 reg_index)
 		iowrite32(DMACTL_RUN, iobase + reg_index);
 }
 
-static void MACvEnableProtectMD(void __iomem *iobase)
+static void vt6655_mac_en_dis_bits_u32_reg(void __iomem *iobase, bool en_not_dis, u32 bit_mask)
 {
 	u32 reg_value;
 
 	reg_value = ioread32(iobase + MAC_REG_ENCFG);
-	reg_value = reg_value | ENCFG_PROTECTMD;
+	if (en_not_dis)
+		reg_value = reg_value | bit_mask;
+	else
+		reg_value = reg_value & ~bit_mask;
 	iowrite32(reg_value, iobase + MAC_REG_ENCFG);
 }
 
+static void MACvEnableProtectMD(void __iomem *iobase)
+{
+	vt6655_mac_en_dis_bits_u32_reg(iobase, ENABLE, ENCFG_PROTECTMD);
+}
+
 /*
  * Initialisation of MAC & BBP registers
  */
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 84d203c56b1f..31e75df5f02f 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -21,6 +21,9 @@
 #include "device.h"
 
 /*---------------------  Export Definitions -------------------------*/
+#define ENABLE 1
+#define DISABLE 0
+
 /* Registers in the MAC */
 #define MAC_MAX_CONTEXT_SIZE_PAGE0  256
 #define MAC_MAX_CONTEXT_SIZE_PAGE1  128
-- 
2.37.1

