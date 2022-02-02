Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F4C4A73AE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345176AbiBBOvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345090AbiBBOvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:51:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AA6C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 06:51:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A438060C72
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 14:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAFDC340ED;
        Wed,  2 Feb 2022 14:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643813495;
        bh=drlEPGUjV+wPgfhl3A9RyJ1fkmiImQJzXyfMAKyI8dw=;
        h=From:To:Cc:Subject:Date:From;
        b=KPfsp/oc70GAMbFCN18GnJ5AlJ2si4ALVO0wwc/Hzlx/zrqbKU+uq5gPe9eDEpUQq
         trckAS1zVW2ZS17l8Z0NPAsuZ+6wokqoVrbf7qXqyqyCFUsRd1qrF7E8sdlq457tfz
         PzS7kRRhN1GjjkjtsBwplntH3cOR4hTTl7W0icBRH2S4HwF9bhdoL/v8D2VZPkLpzW
         ttwsyx8Y/L2wTUrS/LGpgFCeA+KJDgzLK6sl7e3suERhmjTzDph6IMPBc4eiFKCBXD
         UoAeZQsxTe8I9joV6zWG+Oh5AWGM+BNWZch2Uy13C11JWfrGNWUYl56usHug6L8gg1
         PGVnloVRq+DMA==
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH] mfd: sprd: Add SPI device ID table
Date:   Wed,  2 Feb 2022 14:43:36 +0000
Message-Id: <20220202144336.16514-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1362; h=from:subject; bh=drlEPGUjV+wPgfhl3A9RyJ1fkmiImQJzXyfMAKyI8dw=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh+ph89YzD2kVtiXi3TpVrYLRvh/ceF/6wLXZ5po6y ahB0mnKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYfqYfAAKCRAk1otyXVSH0JamB/ 4sCYFn05WkuStYCsPNLWC7z+b9cQYL9H4ffXLumfYpMcOjhfINAbTzfy7ZLQplk0HCtrBk6PSTlK+5 OgLAktXOAFTy46XuebBnhH3HsDO+wGZ63s3zoJoyxoe29n4cotw8bNS9NVGz5YSoGp6s7YXcZxAwlu 2ybNMnaTgpZL7+9qYRtZbiAasX7HqUft+QrDJHNplCVjpgHnhdGNUG30YJI7/yxw2ln6w5WzQcFD+W c7d39gnn/BOnD7pqgUbeY68TkkLtc6riauu85LYIIESLXd2cyYFfjodfytGY6IYF9Bz7wFaXnF0bxX 4JqTDy5nH7+b24O9s7zt6+93lzYyoE
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently autoloading for SPI devices does not use the DT ID table, it uses
SPI modalises. Supporting OF modalises is going to be difficult if not
impractical, an attempt was made but has been reverted, so ensure that
module autoloading works for this driver by adding a SPI device ID table.

Fixes: 96c8395e2166 ("spi: Revert modalias changes")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Baolin Wang <baolin.wang7@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
---

Rebased onto v5.17-rc1.

 drivers/mfd/sprd-sc27xx-spi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
index 55d2c31bdfb2..864031eccd4c 100644
--- a/drivers/mfd/sprd-sc27xx-spi.c
+++ b/drivers/mfd/sprd-sc27xx-spi.c
@@ -239,6 +239,12 @@ static int sprd_pmic_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(sprd_pmic_pm_ops, sprd_pmic_suspend, sprd_pmic_resume);
 
+static const struct spi_device_id sprd_pmic_spi_ids[] = {
+	{ .name = "sc2731", .driver_data = (unsigned long)&sc2731_data },
+	{},
+};
+MODULE_DEVICE_TABLE(spi, sprd_pmic_spi_ids);
+
 static const struct of_device_id sprd_pmic_match[] = {
 	{ .compatible = "sprd,sc2731", .data = &sc2731_data },
 	{ .compatible = "sprd,sc2730", .data = &sc2730_data },
-- 
2.30.2

