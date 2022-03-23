Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDFA4E53BC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 14:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243245AbiCWOBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiCWOBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:01:04 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326F922290
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 06:59:33 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KNqj51jH8z1GCh3;
        Wed, 23 Mar 2022 21:59:21 +0800 (CST)
Received: from huawei.com (10.175.104.82) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 23 Mar
 2022 21:59:29 +0800
From:   Baisong Zhong <zhongbaisong@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <ckeepax@opensource.cirrus.com>, <tanureal@opensource.cirrus.com>,
        <cy_huang@richtek.com>, <pierre-louis.bossart@linux.intel.com>,
        <drhodes@opensource.cirrus.com>, <pbrobinson@gmail.com>,
        <hdegoede@redhat.com>, <lukas.bulwahn@gmail.com>,
        <ricardw@axis.com>
Subject: [PATCH -next] ASoC: tlv320adc3xxx: Fix build error when GPIOLIB is not set
Date:   Wed, 23 Mar 2022 22:17:36 +0800
Message-ID: <20220323141737.211198-1-zhongbaisong@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sound/soc/codecs/tlv320adc3xxx.c:1352:21: error: implicit declaration of function ‘devm_gpiod_get’; did you mean ‘devm_gpio_free’?
sound/soc/codecs/tlv320adc3xxx.c:1352:50: error: ‘GPIOD_OUT_LOW’ undeclared (first use in this function); did you mean ‘GPIOF_INIT_LOW’?
sound/soc/codecs/tlv320adc3xxx.c:1400:2: error: implicit declaration of function ‘gpiod_set_value_cansleep’; did you mean ‘gpio_set_value_cansleep’?

Fixes: e9a3b57efd28 ("ASoC: codec: tlv320adc3xxx: New codec driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Baisong Zhong <zhongbaisong@huawei.com>
---
 sound/soc/codecs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index f46a22660103..1400fc75fd65 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1535,7 +1535,7 @@ config SND_SOC_TFA989X
 
 config SND_SOC_TLV320ADC3XXX
 	tristate "Texas Instruments TLV320ADC3001/3101 audio ADC"
-	depends on I2C
+	depends on I2C && GPIOLIB
 	help
 	 Enable support for Texas Instruments TLV320ADC3001 and TLV320ADC3101
 	 ADCs.
-- 
2.25.1

