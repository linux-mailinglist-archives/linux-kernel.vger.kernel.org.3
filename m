Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1706447CAEF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 02:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241320AbhLVBwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 20:52:20 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25]:36420 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232258AbhLVBwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 20:52:19 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-05 (Coremail) with SMTP id zQCowABHKBW+hMJhxLR+BA--.51475S2;
        Wed, 22 Dec 2021 09:51:58 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     matthias.bgg@gmail.com, lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v2] isoc: mediatek: Check for error clk pointer
Date:   Wed, 22 Dec 2021 09:51:57 +0800
Message-Id: <20211222015157.1025853-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABHKBW+hMJhxLR+BA--.51475S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KryfWw4UXr1DAFykKF4kZwb_yoW8uF4UpF
        ykta42yFWrtrWxWas5ZrWDWFyakryxta9rK34fKw4Fy3s8Jrn3JF95Ja4jyF4fAFykK3Wa
        yr4YgrW8CF1UZFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK
        6w4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbLiSPUUUU
        U==
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 01:57:15AM +0800, Mark Brown wrote:
>> +	for (i = CLK_NONE + 1; i < CLK_MAX; i++) {
>>  		clk[i] = devm_clk_get(&pdev->dev, clk_names[i]);
>> +		if (IS_ERR(clk[i]))
>> +			return PTR_ERR(clk[i]);
>
> This now pays attention to the error code here which is good but...
>
>> -	init_clks(pdev, clk);
>> +	ret = init_clks(pdev, clk);
>> +	if (ret)
>> +		return ERR_PTR(-ENOMEM);
>
> ...then discards it here with a random most likely inappropriate error
> code.

Yes, you are right and now the return code depending on the
init_clks().

Fixes: 6078c651947a ("soc: mediatek: Refine scpsys to support multiple platform")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
Changelog:

v1 -> v2

*Change 1. Change the return code.
---
 drivers/soc/mediatek/mtk-scpsys.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index ca75b14931ec..670cc82d17dc 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -411,12 +411,17 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 	return ret;
 }
 
-static void init_clks(struct platform_device *pdev, struct clk **clk)
+static int init_clks(struct platform_device *pdev, struct clk **clk)
 {
 	int i;
 
-	for (i = CLK_NONE + 1; i < CLK_MAX; i++)
+	for (i = CLK_NONE + 1; i < CLK_MAX; i++) {
 		clk[i] = devm_clk_get(&pdev->dev, clk_names[i]);
+		if (IS_ERR(clk[i]))
+			return PTR_ERR(clk[i]);
+	}
+
+	return 0;
 }
 
 static struct scp *init_scp(struct platform_device *pdev,
@@ -426,7 +431,7 @@ static struct scp *init_scp(struct platform_device *pdev,
 {
 	struct genpd_onecell_data *pd_data;
 	struct resource *res;
-	int i, j;
+	int i, j, ret;
 	struct scp *scp;
 	struct clk *clk[CLK_MAX];
 
@@ -481,7 +486,9 @@ static struct scp *init_scp(struct platform_device *pdev,
 
 	pd_data->num_domains = num;
 
-	init_clks(pdev, clk);
+	ret = init_clks(pdev, clk);
+	if (ret)
+		return ERR_PTR(ret);
 
 	for (i = 0; i < num; i++) {
 		struct scp_domain *scpd = &scp->domains[i];
-- 
2.25.1

