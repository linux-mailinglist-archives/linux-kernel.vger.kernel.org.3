Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FEE58E0D1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343780AbiHIUPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245695AbiHIUPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:15:00 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229EA26AF2
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 13:14:59 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h13so15516238wrf.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 13:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=aYM+SEPG/7AeXfBir1sz3Jj6H6PWY6S17v6O/XAxZQU=;
        b=Yu+I6VTDeglbHhXcc4OhPmlmHty3sSwuan4B8e+IiRLJOz6S55SuTJU9xiqRVUuExg
         78rQt3Ujcw6VBgMb4oDdXIXsbpeWvC42WuAMehz4M+b7oXARsw0q039dfqylRYkzS0rP
         Kg+ejclj8nUkoEcinIiuasxtGVtx4bQV9egkEg5do/+QCQDdGJ3S4GbSYuPflhjHo/xQ
         qp0zBxUHMmfLHncXKLRBAjREiu5aiFK/W0Bpw1I7YL8HCscDu7SSnAUToZQHY8J/d+YZ
         yBbFjoJY9UpcyjzX54xjWAytGZPe8JZkQOwaLzfnxQ4OhDq2dach2rOPqjfh1IJGFvuH
         f/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=aYM+SEPG/7AeXfBir1sz3Jj6H6PWY6S17v6O/XAxZQU=;
        b=KC60Rb/Fan+ygeFkO7aZ7+vj+j7l1fExsKOhncSAHMWGAeJW4s6SxkKEvw+ZzP3+ms
         KCSuZaPzaf8nlz7jvmydj0s1oj3TFLg5/DshehCPrbDL2gcez/0vUM2TKg/YvBq+kL4H
         7Xu5LLoooE5Sa4hIGdysVVDhpiaVt7S3JYwsl1FBJLfHRtcSlXFPFfMepj8lDAoDyV8k
         473gteIK4mZc9rUAhIO3LBDNQKwVc0H/jxzLffPqoUnXKpSOzcyByeMsep4RmeBEJVdI
         U4ZqsTkSwj4lQ/fttVQ2FqZdujX/DbR9Tx1INQbcg0Bx1Rz/UxxmJqSTEKzsgiUA2TTY
         rAlg==
X-Gm-Message-State: ACgBeo1cDRC+dh9s/+OUWIi7FCKx+EgvYIoWsDvDEShRzpcElaagE5JY
        KobMEtXVy1i5dSiCD+qzlJjwNQ==
X-Google-Smtp-Source: AA6agR70SagFhodtAdqWPBrXvzFjM78jJIg4F1hRUfV2yVHrJUrMmqUzPizh7p16F7PoiEiUUcWfMA==
X-Received: by 2002:a5d:5964:0:b0:222:ed7f:4418 with SMTP id e36-20020a5d5964000000b00222ed7f4418mr5640931wri.133.1660076097720;
        Tue, 09 Aug 2022 13:14:57 -0700 (PDT)
Received: from debian.office.codethink.co.uk ([2405:201:8005:8149:e5c9:c0ac:4d82:e94b])
        by smtp.gmail.com with ESMTPSA id q15-20020a7bce8f000000b003a53e6c5425sm24041wmj.8.2022.08.09.13.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 13:14:57 -0700 (PDT)
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
Subject: [PATCH v2 2/3] mtd: spi-nor: add SFDP fixups for Quad Page Program
Date:   Tue,  9 Aug 2022 21:14:27 +0100
Message-Id: <20220809201428.118523-3-sudip.mukherjee@sifive.com>
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

SFDP table of some flash chips do not advertise support of Quad Input
Page Program even though it has support. Use fixup flags and add hardware
cap for these chips.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
---
 drivers/mtd/spi-nor/core.c | 9 +++++++++
 drivers/mtd/spi-nor/core.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index f2c64006f8d7..7542404332a5 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1962,6 +1962,12 @@ spi_nor_spimem_adjust_hwcaps(struct spi_nor *nor, u32 *hwcaps)
 	if (nor->flags & SNOR_F_BROKEN_RESET)
 		*hwcaps &= ~(SNOR_HWCAPS_X_X_X | SNOR_HWCAPS_X_X_X_DTR);
 
+	if (nor->flags & SNOR_F_HAS_QUAD_PP) {
+		*hwcaps |= SNOR_HWCAPS_PP_1_1_4;
+		spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP_1_1_4],
+					SPINOR_OP_PP_1_1_4, SNOR_PROTO_1_1_4);
+	}
+
 	for (cap = 0; cap < sizeof(*hwcaps) * BITS_PER_BYTE; cap++) {
 		int rdidx, ppidx;
 
@@ -2446,6 +2452,9 @@ static void spi_nor_init_fixup_flags(struct spi_nor *nor)
 
 	if (fixup_flags & SPI_NOR_IO_MODE_EN_VOLATILE)
 		nor->flags |= SNOR_F_IO_MODE_EN_VOLATILE;
+
+	if (fixup_flags & SPI_NOR_QUAD_PP)
+		nor->flags |= SNOR_F_HAS_QUAD_PP;
 }
 
 /**
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 85b0cf254e97..7dbdf16a67b4 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -130,6 +130,7 @@ enum spi_nor_option_flags {
 	SNOR_F_IO_MODE_EN_VOLATILE = BIT(11),
 	SNOR_F_SOFT_RESET	= BIT(12),
 	SNOR_F_SWP_IS_VOLATILE	= BIT(13),
+	SNOR_F_HAS_QUAD_PP	= BIT(14),
 };
 
 struct spi_nor_read_command {
@@ -520,6 +521,7 @@ struct flash_info {
 	u8 fixup_flags;
 #define SPI_NOR_4B_OPCODES		BIT(0)
 #define SPI_NOR_IO_MODE_EN_VOLATILE	BIT(1)
+#define SPI_NOR_QUAD_PP			BIT(2)
 
 	u8 mfr_flags;
 
-- 
2.30.2

