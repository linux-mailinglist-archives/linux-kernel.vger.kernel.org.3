Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C78A4FB19B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 04:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244337AbiDKCLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 22:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239877AbiDKCLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 22:11:30 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB521ADAE;
        Sun, 10 Apr 2022 19:09:14 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KcC2H6qNyz1HBJm;
        Mon, 11 Apr 2022 10:08:39 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 11 Apr
 2022 10:09:12 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <spujar@nvidia.com>,
        <yuehaibing@huawei.com>
CC:     <alsa-devel@alsa-project.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] ASoC: tegra186_asrc: mark runtime-pm functions as __maybe_unused
Date:   Mon, 11 Apr 2022 10:09:08 +0800
Message-ID: <20220411020908.580-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sound/soc/tegra/tegra186_asrc.c:90:12: error: ‘tegra186_asrc_runtime_resume’ defined but not used [-Werror=unused-function]
 static int tegra186_asrc_runtime_resume(struct device *dev)
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/tegra/tegra186_asrc.c:80:12: error: ‘tegra186_asrc_runtime_suspend’ defined but not used [-Werror=unused-function]
 static int tegra186_asrc_runtime_suspend(struct device *dev)
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Mark these functions as __maybe_unused to avoid this kind of warning.

Fixes: a2df8c2d5b36 ("ASoC: tegra: Add Tegra186 based ASRC driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/tegra/tegra186_asrc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/tegra/tegra186_asrc.c b/sound/soc/tegra/tegra186_asrc.c
index 3c1e20cbb319..9f12faaa609d 100644
--- a/sound/soc/tegra/tegra186_asrc.c
+++ b/sound/soc/tegra/tegra186_asrc.c
@@ -77,7 +77,7 @@ static void tegra186_asrc_lock_stream(struct tegra186_asrc *asrc,
 		     1);
 }
 
-static int tegra186_asrc_runtime_suspend(struct device *dev)
+static int __maybe_unused tegra186_asrc_runtime_suspend(struct device *dev)
 {
 	struct tegra186_asrc *asrc = dev_get_drvdata(dev);
 
@@ -87,7 +87,7 @@ static int tegra186_asrc_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int tegra186_asrc_runtime_resume(struct device *dev)
+static int __maybe_unused tegra186_asrc_runtime_resume(struct device *dev)
 {
 	struct tegra186_asrc *asrc = dev_get_drvdata(dev);
 	int id;
-- 
2.17.1

