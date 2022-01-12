Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A138248BFF1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351631AbiALIcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:32:19 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25]:59394 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238074AbiALIcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:32:17 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-05 (Coremail) with SMTP id zQCowADHzQH9kd5hTlcSBg--.19832S2;
        Wed, 12 Jan 2022 16:31:57 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v2] mmc: sdhci-of-esdhc: Check for error num after setting mask
Date:   Wed, 12 Jan 2022 16:31:56 +0800
Message-Id: <20220112083156.1124782-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowADHzQH9kd5hTlcSBg--.19832S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4UJr1ktFWxCF1rJFWxtFb_yoW8Wr17pa
        1rWFyFkrWfJr1ru39av3WUZFyYqw1ktFWrt3y7Wan2v343JryjqFyxAFyjvF1kJFyrtw1f
        XFWjyr1ru3y8J3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkm14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GFyl
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUepBTUUUUU
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because of the possible failure of the dma_supported(), the
dma_set_mask_and_coherent() may return error num.
Therefore, it should be better to check it and return the error if
fails.
And since the sdhci_setup_host() has already checked the return value of
the enable_dma, we need not check it in sdhci_resume_host() again.

Fixes: 5552d7ad596c ("mmc: sdhci-of-esdhc: set proper dma mask for ls104x chips")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
Changelog

v1 -> v2

* Change 1. Remove the change of esdhc_of_resume and refine the commit
* message.
---
 drivers/mmc/host/sdhci-of-esdhc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index a593b1fbd69e..0f3658b36513 100644
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
 
-- 
2.25.1

