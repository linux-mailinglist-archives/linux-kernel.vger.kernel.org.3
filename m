Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988D258E0D0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343666AbiHIUO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245695AbiHIUOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:14:53 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A8825EA0
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 13:14:51 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v3so15586918wrp.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 13:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=n+sIRfD+RQiRGeYS26jphMxCdbHEnhlhpCnFs913kcs=;
        b=jejZm+LsOkP/sKHcTEjTV6a/YYsp2p6PJWvV5Wq5e8AsJrGoqYxITRS6VyHhbYmoJM
         hz3dmUTvecCc+8BvqDnixZPoalS7dbYY5PMNY+/s85jL232ek1hkXHYI1OD5gzRwOV6k
         nlBEF2Gs8w1ocpv5PHneyEd6jUo47n/RFaR13fe5PGUkP23vB2QHFlpqLcpMtJqxujMF
         vfvY2a5JjxDykh1Wn/uI3hDCqNVys2WFTCDMTyXDTQLYOe4LiP+SYg/7YPfwdBLfYmXG
         giw3vBtwH9PmT61uF1ns7I+qhVCoRDczkpafU2m9cP6VaRONGMV3TLZI1ltQQGFyojJz
         UVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=n+sIRfD+RQiRGeYS26jphMxCdbHEnhlhpCnFs913kcs=;
        b=dHBH5S1lDK4hS8Bn91fdD4IoZQt65nK+7u3vgOMAi2SGGYVKkslDywP3Fn2X/CmuTx
         T/eNTbuH41qAeA4zyKR28RTMxMn4MXWkovyXFpKPjnmswSIRPZJwRSFLKn+mNYRh12ic
         11VQE2OdBBpJb/yrEr704867WBTTCE7hHXpRavw1XptAB9hJ3RMyGhBiAH3Mj4VrQHUw
         U0603l3JkUxlflSFYPWqcaM9K1soHAH/oA00ZK6Sr1ZGui8RqYiadTKX7LuyClwJ29Vp
         7bCp6b3YKk5ipnbilX6PLN9rs1APsbzCOXQrSbicXyH5/U+EdiojJ8i3mn3yJ2kXE67j
         DmpA==
X-Gm-Message-State: ACgBeo0WfjPPykZeNpgn3V2c89YB+iQ/gpowlLEEAIWKBnpxZWBm8FjP
        LHw31AFp35kRmZwHsnUoln0DfA==
X-Google-Smtp-Source: AA6agR6Q0kQEIw5VavO/Vm78ynSFGIF8hJpL/Byv5pZN1uWpXtoptmzd9VDOfD5ycVuA3Pjge+IeXQ==
X-Received: by 2002:a5d:6608:0:b0:220:625e:f4e1 with SMTP id n8-20020a5d6608000000b00220625ef4e1mr16069047wru.252.1660076090308;
        Tue, 09 Aug 2022 13:14:50 -0700 (PDT)
Received: from debian.office.codethink.co.uk ([2405:201:8005:8149:e5c9:c0ac:4d82:e94b])
        by smtp.gmail.com with ESMTPSA id q15-20020a7bce8f000000b003a53e6c5425sm24041wmj.8.2022.08.09.13.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 13:14:49 -0700 (PDT)
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     greentime.hu@sifive.com, jude.onyenegecha@sifive.com,
        william.salmon@sifive.com, adnan.chowdhury@sifive.com,
        ben.dooks@sifive.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>
Subject: [PATCH v2 1/3] mtd: spi-nor: issi: is25wp256: Init flash based on SFDP
Date:   Tue,  9 Aug 2022 21:14:26 +0100
Message-Id: <20220809201428.118523-2-sudip.mukherjee@sifive.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220809201428.118523-1-sudip.mukherjee@sifive.com>
References: <20220809201428.118523-1-sudip.mukherjee@sifive.com>
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

The datasheet of is25wp256 says it supports SFDP. Get rid of the static
initialization of the flash parameters and init them when parsing SFDP.

Testing showed the flash using SPINOR_OP_READ_1_1_4_4B 0x6c,
SPINOR_OP_PP_4B 0x12 and SPINOR_OP_BE_4K_4B 0x21 before enabling SFDP.
After this patch, it parses the SFDP information and still uses the
same opcodes.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
---
 drivers/mtd/spi-nor/issi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index 89a66a19d754..8b48459b5054 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -71,7 +71,7 @@ static const struct flash_info issi_nor_parts[] = {
 	{ "is25wp128",  INFO(0x9d7018, 0, 64 * 1024, 256)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "is25wp256", INFO(0x9d7019, 0, 64 * 1024, 512)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
+		PARSE_SFDP
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
 		.fixups = &is25lp256_fixups },
 
-- 
2.30.2

