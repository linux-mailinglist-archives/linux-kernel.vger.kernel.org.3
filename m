Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAA348904C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 07:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbiAJGnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 01:43:37 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:44270 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229991AbiAJGng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 01:43:36 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-01 (Coremail) with SMTP id qwCowABHTp501dthqI8dBg--.18516S2;
        Mon, 10 Jan 2022 14:43:00 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     srinivas.kandagatla@linaro.org, bgoswami@codeaurora.org,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] ASoC: codecs: lpass-wsa-macro: Check for error pointer after calling devm_regmap_init_mmio
Date:   Mon, 10 Jan 2022 14:42:59 +0800
Message-Id: <20220110064259.4175705-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowABHTp501dthqI8dBg--.18516S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr4kWF4DAFy8Cr45XF1UZFb_yoWkJrg_Ga
        s5ur4kZa40gr9rXr1Dtr40yFs8tF1ayr4rtr48t3Z3J34DJr1fXryUCrnxu3yDursY9a43
        GFWvqr4Sqry7CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbckFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJV
        W0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GF1l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU-J5rUUUUU=
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_regmap_init_mmio() may return error pointer in some cases, for
example the possible failure of the kzalloc() in
regmap_mmio_gen_context().
Then the wsa->regmap will be error pointer and be used in
wsa_macro_mclk_enable().
Therefore, it should be better to check it in order to avoid the
dereference of the error pointer.

Fixes: 809bcbcecebf ("ASoC: codecs: lpass-wsa-macro: Add support to WSA Macro")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 sound/soc/codecs/lpass-wsa-macro.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index d3ac318fd6b6..dd1a8b7bc794 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -2405,6 +2405,8 @@ static int wsa_macro_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	wsa->regmap = devm_regmap_init_mmio(dev, base, &wsa_regmap_config);
+	if (IS_ERR(wsa->regmap))
+		return PTR_ERR(wsa->regmap);
 
 	dev_set_drvdata(dev, wsa);
 
-- 
2.25.1

