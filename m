Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C1558BC41
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 20:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbiHGSNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 14:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbiHGSNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 14:13:37 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25B26558
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 11:13:35 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id j8so12839566ejx.9
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 11:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc;
        bh=AN1zVwKUXEz2V3Gkaa20oR+ncHTmapAurqeiNEnFlvE=;
        b=psqh4H1CDUWrtpWNIaieHeb4g77hr/WG3ZPjvz/nmEuWgZ7+zCtqiXOTu98qQeeW68
         8F7ay7GI+/UqaOyqucKP3J9dRnM4/g+CeogJj+EOcAXRKFirCS0gSTgpRglXPy/E97sV
         kcajyrljmxc/IrhCKl+N9qMP99ImnE70YVKr3IKYqKf8x3NSyjPh2amOtYSYDk5g9Fut
         sfQB7i5yukmLkBwvWb25MBvzLsz6Z5N1TO9KFAKLBnSDZsSGHidP/kPMuF6AJfq8svdr
         c8/MLhFbIm6m87be3MvgW2hdJnuBErEBczQ10xwWVmDoOa3Jwo++WAifjUkP5nl7Vqo1
         hl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc;
        bh=AN1zVwKUXEz2V3Gkaa20oR+ncHTmapAurqeiNEnFlvE=;
        b=GYy9QNVkWZE6Cu14+N549l69zseQd75qdv+PWWH6BlTf/L95YDiISWOjVo0BuNnBrh
         SGebUpLcfx0YNY7FyeJ+3hWVtsh8FQnnKqXa9PpH56KpnsnnLpdhzO7u027wL1K4j7EZ
         3H+hI0Wz2PQ9+jX99bD/wMXGSJRehdwAEN6AOri60LHoFyjKKO82M3bFmKSK2ZruXVYz
         NC3rc6OSQBIgEchf+ovDNM43HvtOQn75H60TwnG9z6XJbOU+dbQGwBD8NUKAeV98I9x1
         pMR2KtklmtWN8x8P8CvqwAnYCgyj3lisTRxF8FOilL0joqy1VsHLiwDtojCyZKd0XlhZ
         aKaA==
X-Gm-Message-State: ACgBeo1jADJ8TVBf2V4i+agTn1x/i9+lbJU01dnjj9SG2LsycPBjjuYV
        MFbLMFUb2nHaY6EpO7NgI2D1MFSs3mc=
X-Google-Smtp-Source: AA6agR7JjLX0OtZogUv+gm0tyk8HgnyPc/CVtzUJs04tXoMd7OhARgwKPDQLbnboZcpjFJfIjt5bAg==
X-Received: by 2002:a17:907:720a:b0:72b:549e:305a with SMTP id dr10-20020a170907720a00b0072b549e305amr11111101ejc.691.1659896015249;
        Sun, 07 Aug 2022 11:13:35 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id g18-20020a17090604d200b0072ee7b51d9asm4082722eja.39.2022.08.07.11.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 11:13:34 -0700 (PDT)
Date:   Sun, 7 Aug 2022 20:13:33 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] staging: vt6655: Convert macro MACvEnableProtectMD to
 function
Message-ID: <f3a5ec5352346f1dc4bf3afbee25973fdb47d7e4.1659892670.git.philipp.g.hortmann@gmail.com>
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

Convert macro to static function. Multiline macros are not liked by
kernel community. Rename variable dwOrgValue to reg_value to avoid
CamelCase which is not accepted by checkpatch.pl. Change variable
declaration to u32 as this improves readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: No changes
---
 drivers/staging/vt6655/device_main.c | 9 +++++++++
 drivers/staging/vt6655/mac.h         | 8 --------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 8db655742bd4..ab6456fc2b3f 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -216,6 +216,15 @@ static void vt6655_mac_dma_ctl(void __iomem *iobase, u8 reg_index)
 		iowrite32(DMACTL_RUN, iobase + reg_index);
 }
 
+static void MACvEnableProtectMD(void __iomem *iobase)
+{
+	u32 reg_value;
+
+	reg_value = ioread32(iobase + MAC_REG_ENCFG);
+	reg_value = reg_value | ENCFG_PROTECTMD;
+	iowrite32(reg_value, iobase + MAC_REG_ENCFG);
+}
+
 /*
  * Initialisation of MAC & BBP registers
  */
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 467c599a3289..84d203c56b1f 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -543,14 +543,6 @@
 #define MACvSelectPage1(iobase)				\
 	iowrite8(1, iobase + MAC_REG_PAGE1SEL)
 
-#define MACvEnableProtectMD(iobase)					\
-do {									\
-	unsigned long dwOrgValue;					\
-	dwOrgValue = ioread32(iobase + MAC_REG_ENCFG);			\
-	dwOrgValue = dwOrgValue | ENCFG_PROTECTMD;			\
-	iowrite32((u32)dwOrgValue, iobase + MAC_REG_ENCFG);		\
-} while (0)
-
 #define MACvDisableProtectMD(iobase)					\
 do {									\
 	unsigned long dwOrgValue;					\
-- 
2.37.1

