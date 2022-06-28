Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52CD55DB74
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345232AbiF1MKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345177AbiF1MKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:10:49 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCC33465E;
        Tue, 28 Jun 2022 05:10:46 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LXNgT2nJgzkWn9;
        Tue, 28 Jun 2022 20:09:25 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 28 Jun
 2022 20:10:44 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <digetx@gmail.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] soc/tegra: fuse: Add missing DMADEVICES dependency
Date:   Tue, 28 Jun 2022 20:10:39 +0800
Message-ID: <20220628121039.21640-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: unmet direct dependencies detected for TEGRA20_APB_DMA
  Depends on [n]: DMADEVICES [=n] && (ARCH_TEGRA [=y] || COMPILE_TEST [=n])
  Selected by [y]:
  - SOC_TEGRA_FUSE [=y] && ARCH_TEGRA [=y] && ARCH_TEGRA_2x_SOC [=y]

TEGRA20_APB_DMA depends on DMADEVICES, so SOC_TEGRA_FUSE also should depends on it
before select it.

Fixes: 19d41e5e9c68 ("soc/tegra: fuse: Add APB DMA dependency for Tegra20")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/soc/tegra/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index 5725c8ef0406..2b6ba0f798fa 100644
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -135,6 +135,7 @@ endif
 config SOC_TEGRA_FUSE
 	def_bool y
 	depends on ARCH_TEGRA
+	depends on DMADEVICES
 	select SOC_BUS
 	select TEGRA20_APB_DMA if ARCH_TEGRA_2x_SOC
 
-- 
2.17.1

