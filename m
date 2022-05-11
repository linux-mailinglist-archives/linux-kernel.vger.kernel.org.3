Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACF05228EA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 03:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240334AbiEKBZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 21:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240272AbiEKBZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 21:25:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277FCE15FC
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 18:25:19 -0700 (PDT)
Received: from kwepemi500017.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kycds2qvHzbmKr;
        Wed, 11 May 2022 09:24:49 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 kwepemi500017.china.huawei.com (7.221.188.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 09:25:17 +0800
Received: from ubuntu1804.huawei.com (10.67.175.30) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 09:25:16 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <lgirdwood@gmail.com>
CC:     <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <ryan.lee.analog@gmail.com>, <ricardw@axis.com>, <steve@sk2.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <tanghui20@huawei.com>
Subject: [PATCH -next 1/2] ASoC: max98396: Fix build error for implicit function declaration
Date:   Wed, 11 May 2022 09:23:47 +0800
Message-ID: <20220511012348.94288-2-tanghui20@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220511012348.94288-1-tanghui20@huawei.com>
References: <20220511012348.94288-1-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.175.30]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sound/soc/codecs/max98396.c: In function ‘max98396_i2c_probe’:
sound/soc/codecs/max98396.c:1555:25: error: implicit declaration of function ‘devm_gpiod_get_optional’; did you mean ‘devm_regulator_get_optional’? [-Werror=implicit-function-declaration]
  max98396->reset_gpio = devm_gpiod_get_optional(&i2c->dev,
                         ^~~~~~~~~~~~~~~~~~~~~~~
                         devm_regulator_get_optional
sound/soc/codecs/max98396.c:1556:23: error: ‘GPIOD_OUT_HIGH’ undeclared (first use in this function); did you mean ‘GPIOF_INIT_HIGH’?
              "reset", GPIOD_OUT_HIGH);
                       ^~~~~~~~~~~~~~
                       GPIOF_INIT_HIGH
sound/soc/codecs/max98396.c:1556:23: note: each undeclared identifier is reported only once for each function it appears in
sound/soc/codecs/max98396.c:1565:3: error: implicit declaration of function ‘gpiod_set_value_cansleep’; did you mean ‘gpio_set_value_cansleep’? [-Werror=implicit-function-declaration]
   gpiod_set_value_cansleep(max98396->reset_gpio, 0);
   ^~~~~~~~~~~~~~~~~~~~~~~~
   gpio_set_value_cansleep
cc1: all warnings being treated as errors

Add depend on GPIOLIB for 'config SND_SOC_MAX98396'

Fixes: b58581136770 ("ASoC: max98396: add amplifier driver")
Signed-off-by: Hui Tang <tanghui20@huawei.com>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index b106e5517090..71a7afedd0aa 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1051,6 +1051,7 @@ config SND_SOC_MAX98390
 config SND_SOC_MAX98396
 	tristate "Analog Devices MAX98396 Speaker Amplifier"
 	depends on I2C
+	depends on GPIOLIB
 	help
 	  Enable support for Analog Devices MAX98396 audio
 	  amplifier. The device provides a PCM interface for
-- 
2.17.1

