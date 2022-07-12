Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B6957211A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbiGLQir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiGLQif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:38:35 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159181168
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:38:33 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z12so11956398wrq.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bsQn2grPS7xgXNrR8QS8Z/js+pIZTD+IK94HxJFk+rM=;
        b=Vc3tXNm7QiJjXb2PTQiQlCHYyKSpT4cw3gmMIXMXtLLDSS5+msg5QkSbx8OcZgwJWB
         3sJNkhjVy3ykyph+owYKFX0NI7pd7Bshi6xOaJOKQjJSDOGAPkPDtiXBz7Oh7CPy99bf
         ckoBPbv0Jvu8rNIk/yiiPqlsOQViRLUEfEi3D6ecNMA90ETZK1V4dLgnEztbxQJxOiWy
         FVadpwlMlqMSvkfJEteuERDldYZRwrBuWgsKqcRriOp5P6eKeSVPQ+FJD8kOYqKlUiGE
         rbG2mpLuhM11eKznY/j1BC7Ep8pCGcjE/G025iFI8857+aIGwVIzj7KZ/1ZV4T2zVm0d
         DqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bsQn2grPS7xgXNrR8QS8Z/js+pIZTD+IK94HxJFk+rM=;
        b=oEI577GXnzJSWIHnbSc53FPQQmiJh71yE6qUu+661WNkYODMiBmKNwppQYsTKHwImy
         9rLu/CYwrY9dEqHosyxiOhWcRspm7b0UHZ358WIuAYknjXwI6y+AZ93b9rfchwWgebhY
         20WGmbi0IwK9axLRXqvIrKz0RPwxTOpf44c2cqzinRTCeAe0+usQreSxf2kLc3aExU14
         IkwmFT1fm6YoO4Ph8hpbyd7ZUXCJ1Z+1x1INLrnsp7b+C76Ztw/1hxB7Vym5y8wIaS3A
         LO74C8MjbLr1IIE+yL0/57tGPBD84ZIPWPUmCGftUVzEkPsW/F4Zs3i5TcyJnzTHr0v7
         vuNw==
X-Gm-Message-State: AJIora/H9MgalGtM/urjRuwRKtFBhATJ4Mok5xE+CWL5JdtS4vHRJnSZ
        IbPeBY5NcGmWVGk4N/t60IW6XA==
X-Google-Smtp-Source: AGRyM1vnzhRsv1t/YSN1aTRxG2Afz1YPqX0pdQKi6vtLJh2KgUD2dcowzt9rE3HD+p/L7p/Z8YYmmQ==
X-Received: by 2002:a5d:4889:0:b0:21b:293e:9e43 with SMTP id g9-20020a5d4889000000b0021b293e9e43mr22404241wrq.705.1657643912132;
        Tue, 12 Jul 2022 09:38:32 -0700 (PDT)
Received: from localhost.localdomain (host-78-150-47-22.as13285.net. [78.150.47.22])
        by smtp.gmail.com with ESMTPSA id s14-20020a5d424e000000b0021d4d6355efsm8623751wrr.109.2022.07.12.09.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 09:38:31 -0700 (PDT)
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     greentime.hu@sifive.com, jude.onyenegecha@sifive.com,
        william.salmon@sifive.com, adnan.chowdhury@sifive.com,
        ben.dooks@sifive.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>
Subject: [PATCH 2/3] mtd: spi-nor: add support for Quad Page Program to no_sfdp_flags
Date:   Tue, 12 Jul 2022 17:38:22 +0100
Message-Id: <20220712163823.428126-3-sudip.mukherjee@sifive.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220712163823.428126-1-sudip.mukherjee@sifive.com>
References: <20220712163823.428126-1-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some flash chips which does not have a SFDP table can support Quad
Input Page Program. Enable it in hwcaps if defined.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
---
 drivers/mtd/spi-nor/core.c | 5 +++++
 drivers/mtd/spi-nor/core.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index e5f7691c5bd40..e299fc8fdd3d4 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2375,6 +2375,11 @@ static void spi_nor_no_sfdp_init_params(struct spi_nor *nor)
 		spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP_8_8_8_DTR],
 					SPINOR_OP_PP, SNOR_PROTO_8_8_8_DTR);
 	}
+	if (no_sfdp_flags & SPI_NOR_QUAD_PP) {
+		params->hwcaps.mask |= SNOR_HWCAPS_PP_1_1_4;
+		spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP_1_1_4],
+					SPINOR_OP_PP_1_1_4, SNOR_PROTO_1_1_4);
+	}
 
 	/*
 	 * Sector Erase settings. Sort Erase Types in ascending order, with the
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 58fbedc94080f..dde636bdb1a7c 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -462,6 +462,7 @@ struct spi_nor_fixups {
  *   SPI_NOR_OCTAL_READ:      flash supports Octal Read.
  *   SPI_NOR_OCTAL_DTR_READ:  flash supports octal DTR Read.
  *   SPI_NOR_OCTAL_DTR_PP:    flash supports Octal DTR Page Program.
+ *   SPI_NOR_QUAD_PP:         flash supports Quad Input Page Program.
  *
  * @fixup_flags:    flags that indicate support that can be discovered via SFDP
  *                  ideally, but can not be discovered for this particular flash
@@ -509,6 +510,7 @@ struct flash_info {
 #define SPI_NOR_OCTAL_READ		BIT(5)
 #define SPI_NOR_OCTAL_DTR_READ		BIT(6)
 #define SPI_NOR_OCTAL_DTR_PP		BIT(7)
+#define SPI_NOR_QUAD_PP			BIT(8)
 
 	u8 fixup_flags;
 #define SPI_NOR_4B_OPCODES		BIT(0)
-- 
2.30.2

