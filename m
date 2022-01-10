Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACCE489090
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 08:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239174AbiAJHMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 02:12:23 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:33764 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239187AbiAJHMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 02:12:14 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-01 (Coremail) with SMTP id qwCowAC3v1cx3Nth2PIdBg--.24110S2;
        Mon, 10 Jan 2022 15:11:45 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, srinivas.kandagatla@linaro.org,
        colin.king@canonical.com, sashal@kernel.org,
        guennadi.liakhovetski@linux.intel.com, wanjiabing@vivo.com,
        pierre-louis.bossart@linux.intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] ASoC: codecs: lpass-rx-macro: Check for error pointer after calling devm_regmap_init_mmio
Date:   Mon, 10 Jan 2022 15:11:43 +0800
Message-Id: <20220110071143.28984-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAC3v1cx3Nth2PIdBg--.24110S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xry8XF18ur4kXF1UZw1rCrg_yoWkAFg_G3
        93ur48uayrWrnrAFyDtr47AF4DAFnayrW3Kw40qas3J345Aw1fZryxGr13Z397Zws3ua48
        WFZF9F43Xry3CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb38FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCY02Avz4vE14v_GF4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjfUYMKZDUUUU
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_regmap_init_mmio() may return error pointer under certain
circumstances, for example the possible failure of the kzalloc() in
regmap_mmio_gen_context(), which is called by devm_regmap_init_mmio().
Then the rx->regmap will be error pointer and be used in
rx_macro_mclk_enable().
Therefore, it should be better to check it in order to avoid the
dereference of the error pointer.

Fixes: af3d54b99764 ("ASoC: codecs: lpass-rx-macro: add support for lpass rx macro")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 sound/soc/codecs/lpass-rx-macro.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index 07894ec5e7a6..2adbf2e2697f 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -3542,6 +3542,8 @@ static int rx_macro_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	rx->regmap = devm_regmap_init_mmio(dev, base, &rx_regmap_config);
+	if (IS_ERR(rx->regmap))
+		return PTR_ERR(rx->regmap);
 
 	dev_set_drvdata(dev, rx);
 
-- 
2.25.1

