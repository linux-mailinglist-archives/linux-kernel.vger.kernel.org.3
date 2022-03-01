Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5F84C8705
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbiCAIsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbiCAIsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:48:43 -0500
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C82F8522C8
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 00:48:02 -0800 (PST)
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-01 (Coremail) with SMTP id qwCowACnr8ev3R1ifM_wAQ--.26497S2;
        Tue, 01 Mar 2022 16:47:44 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, robin.murphy@arm.com, yangyingliang@huawei.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] ASoC: dwc-i2s: Handle errors for clk_enable
Date:   Tue,  1 Mar 2022 16:47:42 +0800
Message-Id: <20220301084742.3751939-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACnr8ev3R1ifM_wAQ--.26497S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw43XF4DGrWDZFWUXr4rGrg_yoW8GFWkpa
        naya9YgrWxXFySkay3ZF48ZF13trW0yFW7G3y2g34fZwnxCrn09FW8Gryvya1UCFy8CF15
        Gr4Uta4UCF48ZaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
        7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the potential failure of the clk_enable(),
it should be better to check it, as same as clk_prepare_enable().

Fixes: c9afc1834e81 ("ASoC: dwc: Disallow building designware_pcm as a module")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 sound/soc/dwc/dwc-i2s.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
index 5cb58929090d..1edac3e10f34 100644
--- a/sound/soc/dwc/dwc-i2s.c
+++ b/sound/soc/dwc/dwc-i2s.c
@@ -403,9 +403,13 @@ static int dw_i2s_runtime_suspend(struct device *dev)
 static int dw_i2s_runtime_resume(struct device *dev)
 {
 	struct dw_i2s_dev *dw_dev = dev_get_drvdata(dev);
+	int ret;
 
-	if (dw_dev->capability & DW_I2S_MASTER)
-		clk_enable(dw_dev->clk);
+	if (dw_dev->capability & DW_I2S_MASTER) {
+		ret = clk_enable(dw_dev->clk);
+		if (ret)
+			return ret;
+	}
 	return 0;
 }
 
@@ -422,10 +426,13 @@ static int dw_i2s_resume(struct snd_soc_component *component)
 {
 	struct dw_i2s_dev *dev = snd_soc_component_get_drvdata(component);
 	struct snd_soc_dai *dai;
-	int stream;
+	int stream, ret;
 
-	if (dev->capability & DW_I2S_MASTER)
-		clk_enable(dev->clk);
+	if (dev->capability & DW_I2S_MASTER) {
+		ret = clk_enable(dev->clk);
+		if (ret)
+			return ret;
+	}
 
 	for_each_component_dais(component, dai) {
 		for_each_pcm_streams(stream)
-- 
2.25.1

