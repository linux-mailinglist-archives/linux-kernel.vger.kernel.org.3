Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FA5485E7F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 03:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344650AbiAFCRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 21:17:13 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25]:58116 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344590AbiAFCRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 21:17:06 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-05 (Coremail) with SMTP id zQCowADn7AAHUdZhnw2wBQ--.50564S2;
        Thu, 06 Jan 2022 10:16:39 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] mmc: sdhci-of-esdhc: Check for error num after setting mask
Date:   Thu,  6 Jan 2022 10:16:38 +0800
Message-Id: <20220106021638.2527426-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowADn7AAHUdZhnw2wBQ--.50564S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4UJr1ktFWxCF1rJFWxtFb_yoW8Cr13pa
        yrWFyFkrWfXr1rWrZ3Za1UZF1UKr48trW5K3y7Wan2vwn8JryjkF1xCFyYvF1DJFyrGw4S
        vFW2yF15C3y8J3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_
        Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5vtCUU
        UUU
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because of the possible failure of the dma_supported(), the
dma_set_mask_and_coherent() may return error num.
Therefore, it should be better to check it and return the error if
fails.
Also, the caller, esdhc_of_resume(), should deal with the return value.
Moreover, as the sdhci_esdhc_driver has not been used, it does not need to
be considered.

Fixes: 5552d7ad596c ("mmc: sdhci-of-esdhc: set proper dma mask for ls104x chips")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index a593b1fbd69e..bedfc7bb5174 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -524,12 +524,16 @@ static void esdhc_of_adma_workaround(struct sdhci_host *host, u32 intmask)
 
 static int esdhc_of_enable_dma(struct sdhci_host *host)
 {
+	int ret;
 	u32 value;
 	struct device *dev = mmc_dev(host->mmc);
 
 	if (of_device_is_compatible(dev->of_node, "fsl,ls1043a-esdhc") ||
-	    of_device_is_compatible(dev->of_node, "fsl,ls1046a-esdhc"))
-		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
+	    of_device_is_compatible(dev->of_node, "fsl,ls1046a-esdhc")) {
+		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
+		if (ret)
+			return ret;
+	}
 
 	value = sdhci_readl(host, ESDHC_DMA_SYSCTL);
 
@@ -1245,7 +1249,10 @@ static int esdhc_of_resume(struct device *dev)
 
 	if (ret == 0) {
 		/* Isn't this already done by sdhci_resume_host() ? --rmk */
-		esdhc_of_enable_dma(host);
+		ret = esdhc_of_enable_dma(host);
+		if (ret)
+			return ret;
+
 		sdhci_writel(host, esdhc_proctl, SDHCI_HOST_CONTROL);
 	}
 	return ret;
-- 
2.25.1

