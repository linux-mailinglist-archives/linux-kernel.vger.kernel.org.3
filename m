Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBA0552185
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239100AbiFTPsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244329AbiFTPsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:48:40 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6A1FD3A;
        Mon, 20 Jun 2022 08:48:39 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25KEiC4u002735;
        Mon, 20 Jun 2022 17:48:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=zPr/nDv+NqgCll4/QE6301YdTarimLKEYjm6hZt54cU=;
 b=3QrMbbUQhJfejLee/ZUMrRps4gsh9KU/5BNqES9+Y1FM8bHXgXX3LfDRplf3l4mjVHon
 1DNovKqTAHNFtTJ6gMbtb/ncA5PoiDf4gIWlecpfU63y/qjmQeXt3eXHxNTfSxKG0QsV
 A4e94mhm5/JFdYG6AuPhPUj1A8acMdkMpMC7b/aqhU8lmDwfqPTuLoenH+3eNR/g+kNI
 w9qpwgTzjBZSu6IU6L2oJKxuFX0szRfGgrlDFuJgAioXHhGbLh11juTXP+Vj+DCz9JlK
 u4o6kXi3xeZGTVs3WnqSI4+J+X9VKwGcJApVv1rZ6L2vhD05NrLhdsZZmp+Yc4RdZ8n+ ng== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gs71tmchc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jun 2022 17:48:14 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 96F42100038;
        Mon, 20 Jun 2022 17:48:13 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 90F7722ECEF;
        Mon, 20 Jun 2022 17:48:13 +0200 (CEST)
Received: from localhost (10.75.127.119) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 20 Jun
 2022 17:48:13 +0200
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
Subject: [PATCH 2/2] iio: adc: stm32-adc: disable adc before calibration
Date:   Mon, 20 Jun 2022 17:47:38 +0200
Message-ID: <20220620154738.801706-3-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620154738.801706-1-olivier.moysan@foss.st.com>
References: <20220620154738.801706-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.119]
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

The calibration is launched from prepare callback.
The ADC state when entering this function may be unknown as the
ADC may have been left enabled by boot stage.
One prerequisite for ADC calibration is to have ADC in disabled state.
If the calibration is started when ADC is still enabled, the behavior is
unpredictable, and the calibration may fail with a timeout error.

Force ADC to disabled state in stm32h7_adc_selfcalib().
ADC enabling is ensured by stm32h7_adc_enable() call,
before leaving prepare callback.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/stm32-adc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 80e333f65ddd..3985fe972892 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1019,6 +1019,9 @@ static int stm32h7_adc_selfcalib(struct iio_dev *indio_dev)
 	if (adc->cal.calibrated)
 		return true;
 
+	/* ADC must be disabled for calibration */
+	stm32h7_adc_disable(indio_dev);
+
 	/*
 	 * Select calibration mode:
 	 * - Offset calibration for single ended inputs
-- 
2.25.1

