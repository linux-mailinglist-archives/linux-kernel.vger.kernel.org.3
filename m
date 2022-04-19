Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0D95063C7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 07:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348456AbiDSFOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 01:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiDSFOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 01:14:09 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21DE21E21;
        Mon, 18 Apr 2022 22:11:27 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id d19so4841854qko.3;
        Mon, 18 Apr 2022 22:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JXEZ5C8fYOz+un4E/+M4H7uOYX0LQVxNU9wzlCZQgnI=;
        b=eII8IdHoWLxjcKl0Sg+2eT49DZP+AhiUxs7TAqxbXeF/yiv5sjwIDUKREFQEKWxzn4
         kSnJJ1XwNvrRRwdX5GOzB9qaejlo8q7L5vi9bmG0ntRIXlvZpwIfyMCQJpGcgl92Pe69
         DF5QLpTFc6wX8ijdI2lRKhCKS4VGlrKh2vFFnWSwPK2hA8iLfbAkaKvuSUxFenLECl0P
         qzmXCo7ex0FCiLKn4X0oTUyBNPzczXwDlJstIk7jlj3UMuG9qnDF7lh+B/IQm+HZALNU
         ZAPq5xhYHdKN8cptiEwAg/wXKel1AWBE//GqQ88X+fX8w7DYzE1E9pTcz/OEDtyuqgSv
         Trhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JXEZ5C8fYOz+un4E/+M4H7uOYX0LQVxNU9wzlCZQgnI=;
        b=mDnGX4q1KPobaDjBilkf82pg6P3F72xG+fgcCMYmDiBYJVgz9hhb+G10GA2h+nCIaw
         eTWXigXB3FcWpEGqFjqhPUUjJ5kC9epwozgSuDPXAXXJiCGL20A/giBSeREQSxnyjA8u
         DvF6mkat6MDfOt1A7mFEkp37DF76eOygcLaU9rSd06Nks2dp2QgnYbiqZMBS6vDJdIzo
         Qfmwqx7sJ3/CIh4zsTFjVyhUT4vq+Soz73JUT09BBzAXkrqpP/SQCiKdh3y3/vZdC8s5
         G6irql30l5iOu/wLxtP3OGtL5yh2cW7wI2qTrQGEp/fzj21vOuiC+KkThJb+ryOpo/xL
         bXIQ==
X-Gm-Message-State: AOAM533L897+uI3pNDuj0U0GTGNFjHw2DNRT52FUD9oFfeuoE81C2haZ
        ZY5fbB0+viZHs5/p0NjzrL92AC9407s=
X-Google-Smtp-Source: ABdhPJwxG8YlmBr7Dtj1KIGOFk9rucVNbIgI/EDbWfI/FxwsK8Eu2be6DFUis7xFz986aFYem0hfKw==
X-Received: by 2002:a37:a196:0:b0:69e:b207:16ee with SMTP id k144-20020a37a196000000b0069eb20716eemr3051364qke.321.1650345086571;
        Mon, 18 Apr 2022 22:11:26 -0700 (PDT)
Received: from godwin.fios-router.home (pool-108-18-137-133.washdc.fios.verizon.net. [108.18.137.133])
        by smtp.gmail.com with ESMTPSA id y85-20020a376458000000b0069e64801b7dsm5327222qkb.62.2022.04.18.22.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 22:11:26 -0700 (PDT)
From:   Sean Anderson <seanga2@gmail.com>
To:     linux-mips@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Du Huanpeng <dhu@hodcarrier.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Yang Ling <gnaygnil@gmail.com>,
        Sean Anderson <seanga2@gmail.com>
Subject: [RFT PATCH] clk: ls1c: Fix PLL rate calculation
Date:   Tue, 19 Apr 2022 01:11:14 -0400
Message-Id: <20220419051114.1569291-1-seanga2@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

While reviewing Dhu's patch adding ls1c300 clock support to U-Boot [1], I
noticed the following calculation, which is copied from
drivers/clk/loongson1/clk-loongson1c.c:

ulong ls1c300_pll_get_rate(struct clk *clk)
{
	unsigned int mult;
	long long parent_rate;
	void *base;
	unsigned int val;

	parent_rate = clk_get_parent_rate(clk);
	base = (void *)clk->data;

	val = readl(base + START_FREQ);
	mult = FIELD_GET(FRAC_N, val) + FIELD_GET(M_PLL, val);
	return (mult * parent_rate) / 4;
}

I would like to examine the use of M_PLL and FRAC_N to calculate the multiplier
for the PLL. The datasheet has the following to say:

START_FREQ 位    缺省值      描述
========== ===== =========== ====================================
FRAC_N     23:16 0           PLL 倍频系数的小数部分

                 由          PLL 倍频系数的整数部分
M_PLL      15:8  NAND_D[3:0] (理论可以达到 255，建议不要超过 100)
                 配置

which according to google translate means

START_FREQ Bits  Default       Description
========== ===== ============= ================================================
FRAC_N     23:16 0             Fractional part of the PLL multiplication factor

                 Depends on    Integer part of PLL multiplication factor
M_PLL      15:8  NAND_D[3:0]   (Theoretically it can reach 255, [but] it is
                 configuration  recommended not to exceed 100)

So just based on this description, I would expect that the formula to be
something like

	rate = parent * (255 * M_PLL + FRAC_N) / 255 / 4

However, the datasheet also gives the following formula:

	rate = parent * (M_PLL + FRAC_N) / 4

which is what the Linux driver has implemented. I find this very unusual.
First, the datasheet specifically says that these fields are the integer and
fractional parts of the multiplier. Second, I think such a construct does not
easily map to traditional PLL building blocks. Implementing this formula in
hardware would likely require an adder, just to then set the threshold of a
clock divider.

I think it is much more likely that the first formula is correct. The author of
the datasheet may think of a multiplier of (say) 3.14 as

	M_PLL = 3
	FRAC_N = 0.14

which together sum to the correct multiplier, even though the actual value
stored in FRAC_N would be 36.

I suspect that this has slipped by unnoticed because when FRAC_N is 0, there is
no difference in the formulae. The following patch is untested, but I suspect
it will fix this issue. I would appreciate if anyone with access to the
hardware could measure the output of the PLL (or one of its derived clocks) and
determine the correct formula.

[1] https://lore.kernel.org/u-boot/20220418204519.19991-1-dhu@hodcarrier.org/T/#u

Fixes: b4626a7f4892 ("CLK: Add Loongson1C clock support")
Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 drivers/clk/loongson1/clk-loongson1c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/loongson1/clk-loongson1c.c b/drivers/clk/loongson1/clk-loongson1c.c
index 703f87622cf5..2b98a116c1ea 100644
--- a/drivers/clk/loongson1/clk-loongson1c.c
+++ b/drivers/clk/loongson1/clk-loongson1c.c
@@ -21,9 +21,9 @@ static unsigned long ls1x_pll_recalc_rate(struct clk_hw *hw,
 	u32 pll, rate;
 
 	pll = __raw_readl(LS1X_CLK_PLL_FREQ);
-	rate = ((pll >> 8) & 0xff) + ((pll >> 16) & 0xff);
+	rate = (pll & 0xff00) + ((pll >> 16) & 0xff);
 	rate *= OSC;
-	rate >>= 2;
+	rate >>= 10;
 
 	return rate;
 }
-- 
2.35.1

