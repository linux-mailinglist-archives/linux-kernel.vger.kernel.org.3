Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7570C4F04B5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 18:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357661AbiDBQFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 12:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352942AbiDBQFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 12:05:33 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DAD29835
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 09:03:40 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id w7so5157753pfu.11
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 09:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mnneJ6Ho0S+IA/D1ZV6cBxZg4vItd7oSWatM2pfG5Pg=;
        b=W5xsRbbpSLi9p1T6Laus3rnc5bGfdBkLjIkZ/QY9875Zszcx8AxGQn7R+lEbw4aQd9
         cmTn4S2OM9wUBWaZCSqB+MRLmKhXcO4Nc0YbGUFBTF9xVdsBhuGy1Q7YOz/+XgdNrqm/
         OmyFJ+YeNVw6W3EzgIlGFTKlEqwA0LCLm0GpVMfl6bzOfEAGx+J4t6plSWsfWNEpEkoP
         RhRRTsMcq553SQXzqBCf47WxBS1EsjEcVFICBzyOEpNfoM5tAnRg4wvEndLo8WaOFVy1
         o7WnqkHR73KTuHJ8dUmaktGxFwmxCbIv4yG/y+N9bPJ7BJ3hfqZhTtlwxUcbGJMFVtg/
         bBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mnneJ6Ho0S+IA/D1ZV6cBxZg4vItd7oSWatM2pfG5Pg=;
        b=bU+P7PQrHHgYGLfpEcJleB9skzHDMpLH9R037SMb0K6fktvN2DlnrgZFfKqmrT4B/f
         m789dyNtUM9HGfQT8iuKFEAHKxtj91seesKjTOxaQ0M82NYRK/VnxwLtmhcvYpLpLCyM
         uf0hRt+ABr2xHIGJVR9NYLHcMZzwHebMhCm7kSKM5QXo1xUor73S/l0z1Q7UZQWJIC+7
         HwG1+eJ8vwXOX+Ll60PA2xr7qF5XEzE6flrx+UB6U/m/weuezE5cujLrKdeKI1sgIG7J
         1gV5sRtfjXjRUIJc4RUdu+BUhWJP+1miQM8iJXA0Cc2Zhu6kigipPiQ68rfNdc5NF8rr
         x6Qw==
X-Gm-Message-State: AOAM533icWrR+kE2ZqDlkHpx37GVg871gcIhOodqI3adwnVmv0kY0shM
        AzcwXkwchbx24T0jA20iq9o=
X-Google-Smtp-Source: ABdhPJwQSFddjPPGwDTDrCrAyDtU8UoQsvWTSrQlSFtt+quKPSBuORiJM8uSNZHpJoKZHQF/gH0ZCQ==
X-Received: by 2002:a05:6a00:ac1:b0:4f1:29e4:b3a1 with SMTP id c1-20020a056a000ac100b004f129e4b3a1mr49940986pfl.63.1648915420250;
        Sat, 02 Apr 2022 09:03:40 -0700 (PDT)
Received: from guoguo-omen.lan ([222.201.153.219])
        by smtp.gmail.com with ESMTPSA id p3-20020a056a000b4300b004faee36ea56sm6733974pfo.155.2022.04.02.09.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 09:03:39 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Yu Kuai <yukuai3@huawei.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        RogerCC Lin <rogercc.lin@mediatek.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mtd: rawnand: fix ecc parameters for mt7622
Date:   Sun,  3 Apr 2022 00:03:13 +0800
Message-Id: <20220402160315.919094-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the datasheet, mt7622 only has 5 ECC capabilities instead
of 7, and the decoding error register is arranged  as follows:
+------+---------+---------+---------+---------+
| Bits |  19:15  |  14:10  |   9:5   |   4:0   |
+------+---------+---------+---------+---------+
| Name | ERRNUM3 | ERRNUM2 | ERRNUM1 | ERRNUM0 |
+------+---------+---------+---------+---------+
This means err_mask should be 0x1f instead of 0x3f and the number of
bits shifted in mtk_ecc_get_stats should be 5 instead of 8.

This commit introduces err_shift for the difference in this register
and fix other existing parameters.

Public MT7622 reference manual can be found on [0] and the info this
commit is based on is from page 656 and page 660.

[0]: https://wiki.banana-pi.org/Banana_Pi_BPI-R64#Documents

Fixes: 98dea8d71931 ("mtd: nand: mtk: Support MT7622 NAND flash controller.")
Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
 drivers/mtd/nand/raw/mtk_ecc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/mtk_ecc.c b/drivers/mtd/nand/raw/mtk_ecc.c
index e7df3dac705e..49ab3448b9b1 100644
--- a/drivers/mtd/nand/raw/mtk_ecc.c
+++ b/drivers/mtd/nand/raw/mtk_ecc.c
@@ -43,6 +43,7 @@
 
 struct mtk_ecc_caps {
 	u32 err_mask;
+	u32 err_shift;
 	const u8 *ecc_strength;
 	const u32 *ecc_regs;
 	u8 num_ecc_strength;
@@ -76,7 +77,7 @@ static const u8 ecc_strength_mt2712[] = {
 };
 
 static const u8 ecc_strength_mt7622[] = {
-	4, 6, 8, 10, 12, 14, 16
+	4, 6, 8, 10, 12
 };
 
 enum mtk_ecc_regs {
@@ -221,7 +222,7 @@ void mtk_ecc_get_stats(struct mtk_ecc *ecc, struct mtk_ecc_stats *stats,
 	for (i = 0; i < sectors; i++) {
 		offset = (i >> 2) << 2;
 		err = readl(ecc->regs + ECC_DECENUM0 + offset);
-		err = err >> ((i % 4) * 8);
+		err = err >> ((i % 4) * ecc->caps->err_shift);
 		err &= ecc->caps->err_mask;
 		if (err == ecc->caps->err_mask) {
 			/* uncorrectable errors */
@@ -449,6 +450,7 @@ EXPORT_SYMBOL(mtk_ecc_get_parity_bits);
 
 static const struct mtk_ecc_caps mtk_ecc_caps_mt2701 = {
 	.err_mask = 0x3f,
+	.err_shift = 8,
 	.ecc_strength = ecc_strength_mt2701,
 	.ecc_regs = mt2701_ecc_regs,
 	.num_ecc_strength = 20,
@@ -459,6 +461,7 @@ static const struct mtk_ecc_caps mtk_ecc_caps_mt2701 = {
 
 static const struct mtk_ecc_caps mtk_ecc_caps_mt2712 = {
 	.err_mask = 0x7f,
+	.err_shift = 8,
 	.ecc_strength = ecc_strength_mt2712,
 	.ecc_regs = mt2712_ecc_regs,
 	.num_ecc_strength = 23,
@@ -468,10 +471,11 @@ static const struct mtk_ecc_caps mtk_ecc_caps_mt2712 = {
 };
 
 static const struct mtk_ecc_caps mtk_ecc_caps_mt7622 = {
-	.err_mask = 0x3f,
+	.err_mask = 0x1f,
+	.err_shift = 5,
 	.ecc_strength = ecc_strength_mt7622,
 	.ecc_regs = mt7622_ecc_regs,
-	.num_ecc_strength = 7,
+	.num_ecc_strength = 5,
 	.ecc_mode_shift = 4,
 	.parity_bits = 13,
 	.pg_irq_sel = 0,
-- 
2.35.1

