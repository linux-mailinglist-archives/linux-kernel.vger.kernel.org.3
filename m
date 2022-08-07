Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F9D58BC42
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 20:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbiHGSNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 14:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbiHGSNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 14:13:42 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD6E65F3
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 11:13:41 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id m4so12900021ejr.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 11:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc;
        bh=zD17J0eH2wPYwZr+9CUo9VuUmFGElTpvvgk6zTTTY90=;
        b=ZztM717a1mtjobKwFBK8U7wqJxMgEkltelF826ecqjXXWaGseSHNt0g8ztaSXMmX8x
         y1fLdu47CanmPT4NNAEYwSfVblRpWlZNsYef7x4+nI91wuIItOKkdxnov90ntvrdNuXU
         97m/e7HXAvwsmm2fKGLxHrZF8t0dxrBpQlXZhsSqa1cvaCtalCqwuveCzcC9L2HTJB0+
         IbsQLP0khV8XSwykp8q04EO353l38aQ2FqNVeARAuHDWIhWpNpvw2nnIu4Xey8GYPRAW
         mWbAnFNXQaxS3NwD4GpaNeCxd68fh5NKkgNwqTJbjZsMcJKUefBFwkylprvd/ZBXH5CW
         /V7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc;
        bh=zD17J0eH2wPYwZr+9CUo9VuUmFGElTpvvgk6zTTTY90=;
        b=KNcF8ydcv+QQhce8FxBLF4KnZdcDVSrZL7+o40F3a0CnNrX1Vr6GUcvBe3jDHQ4a4J
         JVcB/38wQlPVCTjKVhJmDczXpugVsU+P7Hx1f43s5RvbnMNlBPDuzExOczo994zLKxH7
         VHaMAyrge8GFM0sXxiC7r2a/6ARuki1VBKEm5DUyh1mJ06M0CdtRTBGnwTq13AB5Evel
         A8TKkWb9E5eH5AISaq/XpX9+PleyX2VVC+wX9i/elfLz/G2hKTf4zHtqqsq+KB9IjilI
         NdY7ipwnfWErHyrT7FGgUSzWdiW3Wzsw8kvER06PIZi+KADRJ3t2Bj06T+INlIIYyAzk
         uTUw==
X-Gm-Message-State: ACgBeo11UbROhJv0UDRjeCAdT3eE4nNLExyuRzVwTeBU5tdofmbz2hCc
        cnMs9kc4skpbag3PHosq9VQ=
X-Google-Smtp-Source: AA6agR6Xa3KQwBv71sNy/xYGmyk4Ok+a6lmfLPRbZ/59pl81W9v6lO0IN7Eaqne1ge7LY3x3IY5X0A==
X-Received: by 2002:a17:906:8a4e:b0:730:9fcd:d988 with SMTP id gx14-20020a1709068a4e00b007309fcdd988mr11498063ejc.636.1659896019873;
        Sun, 07 Aug 2022 11:13:39 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id q9-20020a170906540900b0073073ce488asm4021819ejo.45.2022.08.07.11.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 11:13:39 -0700 (PDT)
Date:   Sun, 7 Aug 2022 20:13:37 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] staging: vt6655: Create one function for two macros
Message-ID: <78883f42b2df258dbf821d7f7515a82932a157f1.1659892670.git.philipp.g.hortmann@gmail.com>
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

Create function vt6655_mac_set_bits with two parameters to cover
functionality of two macros.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: Change function to cover only the set bits part and omitted
          the clear bits part
          Changed title from "...four..." to "...two..."
          Changed description accordingly
---
 drivers/staging/vt6655/device_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index ab6456fc2b3f..dc50bff4403f 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -216,15 +216,20 @@ static void vt6655_mac_dma_ctl(void __iomem *iobase, u8 reg_index)
 		iowrite32(DMACTL_RUN, iobase + reg_index);
 }
 
-static void MACvEnableProtectMD(void __iomem *iobase)
+static void vt6655_mac_set_bits(void __iomem *iobase, u32 mask)
 {
 	u32 reg_value;
 
 	reg_value = ioread32(iobase + MAC_REG_ENCFG);
-	reg_value = reg_value | ENCFG_PROTECTMD;
+	reg_value = reg_value | mask;
 	iowrite32(reg_value, iobase + MAC_REG_ENCFG);
 }
 
+static void MACvEnableProtectMD(void __iomem *iobase)
+{
+	vt6655_mac_set_bits(iobase, ENCFG_PROTECTMD);
+}
+
 /*
  * Initialisation of MAC & BBP registers
  */
-- 
2.37.1

