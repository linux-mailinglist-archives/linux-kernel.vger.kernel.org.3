Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0FA58E0D3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344033AbiHIUPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344085AbiHIUPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:15:07 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B48D26135
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 13:15:06 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z16so15445921wrh.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 13:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=fht4T02AJsm7RzN5fUBiXhu56qdywVISHR5D86D3Apw=;
        b=gEw6cjkxWXxas2xdn6RuNkbfUeSd9bj8xuWQIspShEkoneStEVjS2ZX+o4lzyl7oAc
         uJSg5WyRCCUxRPad0T+BR/WmkzdFsCtcVHUvJsQaixLFAaNeJGZsS168NzCBcjKu8KIO
         II4sv3LzNOyCTNZC7PUoWFa7qg95HWKTZMJxy5+SvCId/K975iyN7mZSxPCR9tlNKlGv
         qwhvXDBpT+qG+VdAJ5CeiGvrrQxXiwqjkAKVkThMa32qst0Qxnhaxp1kG8Gm45ETlwDj
         5XXGmw6j1NQJ0SoQXDP9PV0a77HlHiqyPIvyFIAYIAM7w1mOF4XyQTyxkhQ3Dn5Rcpzy
         w4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=fht4T02AJsm7RzN5fUBiXhu56qdywVISHR5D86D3Apw=;
        b=NpByoSF+KoK8hwBOFkouU6hvNkOb5cmZOzgIf9epRLTIrYpY3hqW76u6QFU0xNkmT+
         +EC2jkkwM/B5B30Eri8DwQdgSF2CoSTkSEb0laqJkMabaJhuhVH3CifKC4kuMpnkIfAa
         44TkJdSpn/a8IqybZFVSw0Gl8S1DL6LDt0SeB6EkhZsrsdwxigajYO6XcFPJem9I0ZGI
         1N7Yl8iT60+f86jUCLmhGx1sYGg+lFcNltuO9zB0hNDPUh6g41l80MdQ6gwIis9zQl4v
         i8RlTBfJ2wUzI6WH+tsb6aMiOtHKFGzN7u2oGkUNnGWLFY1hhC6/qactIJVS2BuCNTCI
         xR/g==
X-Gm-Message-State: ACgBeo0eWYGXZxdNOvnq7a3rDsOeQPM+sjNmIdCjBEIdfL2+NAQEOoS/
        WzxRHD/KpsP8PjLCynZZVO/UpA==
X-Google-Smtp-Source: AA6agR4ob8fPym4LPeE8iqiDyhAvDhm1vefWb8U7o4ei9PRaZwpcMvL6xB0SHnLWnkB/tGwNcMzo6A==
X-Received: by 2002:a05:6000:1f8a:b0:223:796f:c1ae with SMTP id bw10-20020a0560001f8a00b00223796fc1aemr179721wrb.514.1660076105156;
        Tue, 09 Aug 2022 13:15:05 -0700 (PDT)
Received: from debian.office.codethink.co.uk ([2405:201:8005:8149:e5c9:c0ac:4d82:e94b])
        by smtp.gmail.com with ESMTPSA id q15-20020a7bce8f000000b003a53e6c5425sm24041wmj.8.2022.08.09.13.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 13:15:04 -0700 (PDT)
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
Subject: [PATCH v2 3/3] mtd: spi-nor: issi: is25wp256: Enable Quad Input Page Program
Date:   Tue,  9 Aug 2022 21:14:28 +0100
Message-Id: <20220809201428.118523-4-sudip.mukherjee@sifive.com>
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

The flash chip is25wp256 supports Quad Input Page Program but it is not
discoverable from the SFDP table. Enable the fixup flag for is25wp256.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
---
 drivers/mtd/spi-nor/issi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index 8b48459b5054..36e6c4a1d022 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -72,7 +72,7 @@ static const struct flash_info issi_nor_parts[] = {
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "is25wp256", INFO(0x9d7019, 0, 64 * 1024, 512)
 		PARSE_SFDP
-		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
+		FIXUP_FLAGS(SPI_NOR_4B_OPCODES | SPI_NOR_QUAD_PP)
 		.fixups = &is25lp256_fixups },
 
 	/* PMC */
-- 
2.30.2

