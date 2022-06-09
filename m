Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3175544808
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbiFIJxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbiFIJxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:53:30 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B234818DADD;
        Thu,  9 Jun 2022 02:53:28 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2599Q9Tg024960;
        Thu, 9 Jun 2022 11:52:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=L+GV88KUXWKpKEgxaMfS4iBDvfAOOghJXwOQUjIkFY0=;
 b=lHnLI0ACqOV2zhymuW7TFjkj6nhdGoMheHwSSObfSPu92MpOObAq8gU5TpcLUYnOxUoF
 bjQcTQ0jEAwqUIIxa0XE0Tc1pmCTlFjmE1YBKKEsPcsBbCXESzHFkwyG6h6UTmIPUhvn
 G3cL2Yh9CfCUBC1T2bW6GTxCT11AfZeqy13ar3Leom1RBh+mVy7TsHGbD5Uz/q++VnH6
 enCD54s4U36SO531t1XbIzwM0UstfgM9qeRz9bObtFMp0J/x116XMy7tiRpexvoKPUBD
 sZCox2VJTASwGkAhQ8aDPvRMAfX4tvex8kV2bKhImEN0BOfbCspqJ6VOz0RScm3V09a7 NA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gjrbc0af3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jun 2022 11:52:55 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D4086100034;
        Thu,  9 Jun 2022 11:52:54 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BFCFC2138E8;
        Thu,  9 Jun 2022 11:52:54 +0200 (CEST)
Received: from localhost (10.75.127.49) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Thu, 9 Jun
 2022 11:52:54 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Paul Cercueil <paul@crapouillou.net>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] iio: adc: stm32: fix maximum clock rate for stm32mp15x
Date:   Thu, 9 Jun 2022 11:52:34 +0200
Message-ID: <20220609095234.375925-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-09_08,2022-06-07_02,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change maximum STM32 ADC input clock rate to 36MHz, as specified
in STM32MP15x datasheets.

Fixes: d58c67d1d851 ("iio: adc: stm32-adc: add support for STM32MP1")

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/stm32-adc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 142656232157..ce1a63a82034 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -805,7 +805,7 @@ static const struct stm32_adc_priv_cfg stm32h7_adc_priv_cfg = {
 static const struct stm32_adc_priv_cfg stm32mp1_adc_priv_cfg = {
 	.regs = &stm32h7_adc_common_regs,
 	.clk_sel = stm32h7_adc_clk_sel,
-	.max_clk_rate_hz = 40000000,
+	.max_clk_rate_hz = 36000000,
 	.has_syscfg = HAS_VBOOSTER | HAS_ANASWVDD,
 	.num_irqs = 2,
 };
-- 
2.25.1

