Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2927552190
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241670AbiFTPt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244387AbiFTPsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:48:41 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5DB1BE9D;
        Mon, 20 Jun 2022 08:48:40 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25KDwmdg019734;
        Mon, 20 Jun 2022 17:48:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=FeTP5mpYBlwck24RxxFaADdquu3d8hoF9bo+/tGwtA8=;
 b=T04xrHjVLE3XGpmoZyScFR5nlgBdVk72P7oBI7vaQjdrWSy3tm8+mx1U1P6oK3G9uv/y
 41A8zvfceliOrPBxUm2py2VIoqIfdE//ac5gKMyCzDUzai0pj9hzgOSF+YyA8yj+mjoe
 mS96LUV7k8UjS8z3SJeeiTol8NetRV7TpwvZykIZzxHEOpb5kT3f8rDmIs6vopr4onDj
 31JPd90wd0nen3ZNTJRmvvLkc0Ahj+QJwkd4X+xY73PO0NrCrwiijZffqYyEqB5szmoN
 XPhLlQsFJijCYHzkLdB1YHNdQxOPmgMsc6cztl0B7vlRCnEoCKhfAHJWv4IU6ftQi824 Yw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gtp31tepn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jun 2022 17:48:13 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 117CE100034;
        Mon, 20 Jun 2022 17:48:13 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0CCF122ECEF;
        Mon, 20 Jun 2022 17:48:13 +0200 (CEST)
Received: from localhost (10.75.127.116) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 20 Jun
 2022 17:48:12 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Wan Jiabing <wanjiabing@vivo.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 1/2] iio: adc: stm32-adc: make safe adc disable
Date:   Mon, 20 Jun 2022 17:47:37 +0200
Message-ID: <20220620154738.801706-2-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620154738.801706-1-olivier.moysan@foss.st.com>
References: <20220620154738.801706-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.116]
X-ClientProxiedBy: GPXDAG2NODE5.st.com (10.75.127.69) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-20_05,2022-06-17_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From ADC reference manual the software is allowed to write the
control bit ADDIS of the ADC_CR register only if the ADC is enabled.
Return immediately from stm32h7_adc_disable() if ADC is already disabled.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/stm32-adc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index a68ecbda6480..80e333f65ddd 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -876,6 +876,9 @@ static void stm32h7_adc_disable(struct iio_dev *indio_dev)
 	int ret;
 	u32 val;
 
+	if (!(stm32_adc_readl(adc, STM32H7_ADC_CR) & STM32H7_ADEN))
+		return;
+
 	/* Disable ADC and wait until it's effectively disabled */
 	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADDIS);
 	ret = stm32_adc_readl_poll_timeout(STM32H7_ADC_CR, val,
-- 
2.25.1

