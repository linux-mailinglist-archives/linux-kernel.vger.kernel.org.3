Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C17657211C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbiGLQiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiGLQig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:38:36 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0F92AD2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:38:34 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z12so11956448wrq.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JKhfBSF99cGeRL5/E+3ybugh2cH4mwS43tAxuhC31f0=;
        b=WalzjrJan0GdgXNc+jcedb6CZZSxb19MlR0FEDV27T/Eh8Ph077HshjmYEqrScbLL3
         qPM+GPV5cwfOzw3e+PjdwKlOrveJCRAx64fSOLw2K30sPDOmGTWWH0mOyeULI6D1vlXc
         nmplU2PWoRNhO7oTEeUdGBw/M/k63v0IvscKOeDCEb/bDl5chzlY/4VdN01eyJbeDC2g
         ABrpGv+eAQ4kbtdQAB8XJ8kyKz/SM5ztbP0R9UqLkWRPSEmzNw2gc2KOa+Mu2/F33PxG
         5RguZuynrkpFFDgEsTRWYJXhJ6EMEXBsZWHzrosOoUi9aPxq+1jW1x9xnhGT7rJpivgx
         NTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JKhfBSF99cGeRL5/E+3ybugh2cH4mwS43tAxuhC31f0=;
        b=6zqs0oP83THMPHdNYq6Q4oZ0VP1TtzBWnD2xsYays4z7nEEm3CA/UAnm5mWKV64QuT
         SImWJp+0ZQGtoRrvn0Gj3kaZTf1aWerq87mY/YOZk2X5VOAFhu7OfJVGjhtkRGtArT9Q
         dU5lE17OhrxaEBcaMlPEV3y7yUmFhPvlneVBpWU5hRQHC87IQh41EoaalgYbvpqAa/Cr
         Y2w23hg+DBNpyJVpEnnIr7Mc93/0crQFCdhGyy/rf1SjRt6Y10SR1nVrJ4ikywY3DB1I
         dmX8MCQFjdA5xql/zGb7JuxcXCuaUXSeobDNGyh+a0XmeASWdLTPFRQ1ipZVcy8ApHu5
         g0Cw==
X-Gm-Message-State: AJIora8Rt45fLAYOdSkUG17vAlAPM7vMsrBmlqDTfDYgO07Rb3B2sfXG
        Gnbn2TVWh9dCYyTwZTtb3QtpcA==
X-Google-Smtp-Source: AGRyM1ufviadNLw6BfOV8sOAMFzMPgwFnfwUzwRqtK79s7nSUqOHQuOz0PRmE30FEk4ryAtWtjTjZA==
X-Received: by 2002:adf:d1cf:0:b0:21d:a2cd:522d with SMTP id b15-20020adfd1cf000000b0021da2cd522dmr13120142wrd.383.1657643912986;
        Tue, 12 Jul 2022 09:38:32 -0700 (PDT)
Received: from localhost.localdomain (host-78-150-47-22.as13285.net. [78.150.47.22])
        by smtp.gmail.com with ESMTPSA id s14-20020a5d424e000000b0021d4d6355efsm8623751wrr.109.2022.07.12.09.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 09:38:32 -0700 (PDT)
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
Subject: [PATCH 3/3] mtd: spi-nor: issi: is25wp256: Enable Quad Input Page Program
Date:   Tue, 12 Jul 2022 17:38:23 +0100
Message-Id: <20220712163823.428126-4-sudip.mukherjee@sifive.com>
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

The flash chip is25wp256 supports Quad Input Page Program. Enable it
in its no_sfdp_flags flags.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
---
 drivers/mtd/spi-nor/issi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index 3c7d51d2b0509..9a04b03bebe0b 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -71,7 +71,8 @@ static const struct flash_info issi_nor_parts[] = {
 	{ "is25wp128",  INFO(0x9d7018, 0, 64 * 1024, 256)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "is25wp256", INFO(0x9d7019, 0, 64 * 1024, 512)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+		SPI_NOR_QUAD_PP)
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
 		.fixups = &is25lp256_fixups },
 
-- 
2.30.2

