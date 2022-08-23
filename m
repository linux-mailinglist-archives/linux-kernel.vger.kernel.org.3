Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABAE59CF88
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 05:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240109AbiHWDeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 23:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbiHWDeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 23:34:20 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D4932AA3;
        Mon, 22 Aug 2022 20:34:17 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id g16so9406364qkl.11;
        Mon, 22 Aug 2022 20:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=gm8nv1A1HcUSnQ4KZ2XBswRy9fFO4PeMLiDQLhSlOoo=;
        b=IQjqzc+KSmruImmSPXbpoKrGOJlGjBg8YJEsxTyXvk3j4YkbpGJ65ekZNg/B+EIEnE
         4jSMwRwB29H7E1OdhN9XvNW3jsWsSo/rhSK14FPXynq/A4AzKC1QtuvV8wHfR2x+YG9V
         tdjHltSvvJiJwvaFxMDIXeKPlySSy80pvXDOSWfNJe9vcesfLUmfIc/yuIWFS1+SbGA3
         jCJ+BTX1c6MARZqWX7wUOmiEhptNibKbhUz4Qwdk3nf/Njv+MI/OeVs3cuvF5Uqi9o3e
         ++YE/tCjSOlMst1NwOIo2+yc5y74ORyUqGKW2b0K5UXO8329kBvLKh9WMdm+/90SbreM
         1oqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=gm8nv1A1HcUSnQ4KZ2XBswRy9fFO4PeMLiDQLhSlOoo=;
        b=JIHFu9dOm0GK8WOBpR2jpd4x8dRLZQnanuGjhYwkkKozM2n0BRYyxFGWA1tnErNT36
         mS03weIXcF2WiP6g6nkj2JEz1isO1MqCOZ/VCmHPNUW7aMw7avzfEEQhK9MGc8vTRaI3
         ch1NZdFilBxwAyah6E704S1B5wZdfU0cdBZ4g1HZacf+g3yMDrNHs6obYuL5o1FYCphS
         qIU7VfwXyZHRbeTpc9DaF3gvuQM/k5ngrddjZgG7fHtC3d0pbcpvbhkysRU5OqOLoKlB
         3ixuUoiTKXsAsDrnVB4CZga5fTWoF1nNIdPZIpcJtpI22ypq/qFTJ/939WLhoIM6YiDO
         /sxA==
X-Gm-Message-State: ACgBeo1QTFh3LGkQytgu6MCYUdinTs5aMlQ0HfXrP4VR9aZCFKdT5ibd
        EOUUip5I+VZBGtwasQ1b1DJHhwefkrs=
X-Google-Smtp-Source: AA6agR6lmmubZgl6EhUBDYD/YV2sSKNCQ3dZtwVcDPZbPb1njTV75FORlUOzhyaqpaY6sUBMCY57DA==
X-Received: by 2002:a37:2ec6:0:b0:6bb:2ee3:4519 with SMTP id u189-20020a372ec6000000b006bb2ee34519mr14762140qkh.178.1661225656614;
        Mon, 22 Aug 2022 20:34:16 -0700 (PDT)
Received: from localhost (pool-173-73-95-180.washdc.fios.verizon.net. [173.73.95.180])
        by smtp.gmail.com with UTF8SMTPSA id j20-20020a05620a411400b006b9a24dc9d7sm12084640qko.7.2022.08.22.20.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 20:34:16 -0700 (PDT)
From:   Sean Anderson <seanga2@gmail.com>
To:     linux-mips@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Yang Ling <gnaygnil@gmail.com>, linux-kernel@vger.kernel.org,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Du Huanpeng <dhu@hodcarrier.org>,
        Sean Anderson <seanga2@gmail.com>
Subject: [RESEND PATCH] clk: ls1c: Fix PLL rate calculation
Date:   Mon, 22 Aug 2022 23:34:14 -0400
Message-Id: <20220823033414.198525-1-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
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

	rate = parent * (256 * M_PLL + FRAC_N) / 256 / 4

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
index 1ebf740380ef..2aa839b05d6b 100644
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
2.37.1

