Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7712F54482A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241083AbiFIJ7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbiFIJ7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:59:52 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7603F325;
        Thu,  9 Jun 2022 02:59:49 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2598ebeY003698;
        Thu, 9 Jun 2022 11:59:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=TuTxZxiUi321C75mKu2LGVEA3u3oEuyL849QSeLwgoo=;
 b=KPtN57hBQEYZoFl9JHgioqJAwhGv3I5qRS9t8KjDvg5YNxBf4XJjfXZwEqa0NlzfpPL9
 RvtC7HGMc8ZxnTbKHssY6KG4UA+KEi8ZSMutqxZ466HKgR6rj/1Vvsj+MZeGwo6torHl
 kdxiVRLICBHOonMSwoSU1mmi5Lt07u7ML8AZDpOjRDG07Hll/mwzlDORtMs0/Q7mXjJ2
 wgDSH6l/mODwTAZHZVP+2qiZ6zeCtUK9r80VynSnigUGlrXgX2E83yx5mwbhkoYWZ2Pf
 d9r/Uczm1Y3opPu61FYCPxjcbiyOeBDOIv0/JacSgCPE0mPoaf5rzUQjW+ePfEPiR/2o fg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gjqqw0sb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jun 2022 11:59:19 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BF1A910002A;
        Thu,  9 Jun 2022 11:59:17 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B64DC2138FF;
        Thu,  9 Jun 2022 11:59:17 +0200 (CEST)
Received: from localhost (10.75.127.49) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Thu, 9 Jun
 2022 11:59:17 +0200
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
Subject: [PATCH] iio: adc: stm32: fix vrefint wrong calibration value handling
Date:   Thu, 9 Jun 2022 11:58:56 +0200
Message-ID: <20220609095856.376961-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-09_08,2022-06-09_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the vrefint calibration is zero, the vrefint channel output value
cannot be computed. Currently, in such case, the raw conversion value
is returned, which is not relevant.
Do not expose the vrefint channel when the output value cannot be
computed, instead.

Fixes: 0e346b2cfa85 ("iio: adc: stm32-adc: add vrefint calibration support")

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/stm32-adc.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index a68ecbda6480..f13c112f540f 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1365,7 +1365,7 @@ static int stm32_adc_read_raw(struct iio_dev *indio_dev,
 		else
 			ret = -EINVAL;
 
-		if (mask == IIO_CHAN_INFO_PROCESSED && adc->vrefint.vrefint_cal)
+		if (mask == IIO_CHAN_INFO_PROCESSED)
 			*val = STM32_ADC_VREFINT_VOLTAGE * adc->vrefint.vrefint_cal / *val;
 
 		iio_device_release_direct_mode(indio_dev);
@@ -1979,10 +1979,10 @@ static int stm32_adc_populate_int_ch(struct iio_dev *indio_dev, const char *ch_n
 
 	for (i = 0; i < STM32_ADC_INT_CH_NB; i++) {
 		if (!strncmp(stm32_adc_ic[i].name, ch_name, STM32_ADC_CH_SZ)) {
-			adc->int_ch[i] = chan;
-
-			if (stm32_adc_ic[i].idx != STM32_ADC_INT_CH_VREFINT)
-				continue;
+			if (stm32_adc_ic[i].idx != STM32_ADC_INT_CH_VREFINT) {
+				adc->int_ch[i] = chan;
+				break;
+			}
 
 			/* Get calibration data for vrefint channel */
 			ret = nvmem_cell_read_u16(&indio_dev->dev, "vrefint", &vrefint);
@@ -1990,10 +1990,15 @@ static int stm32_adc_populate_int_ch(struct iio_dev *indio_dev, const char *ch_n
 				return dev_err_probe(indio_dev->dev.parent, ret,
 						     "nvmem access error\n");
 			}
-			if (ret == -ENOENT)
-				dev_dbg(&indio_dev->dev, "vrefint calibration not found\n");
-			else
-				adc->vrefint.vrefint_cal = vrefint;
+			if (ret == -ENOENT) {
+				dev_dbg(&indio_dev->dev, "vrefint calibration not found. Skip vrefint channel\n");
+				return ret;
+			} else if (!vrefint) {
+				dev_dbg(&indio_dev->dev, "Null vrefint calibration value. Skip vrefint channel\n");
+				return -ENOENT;
+			}
+			adc->int_ch[i] = chan;
+			adc->vrefint.vrefint_cal = vrefint;
 		}
 	}
 
@@ -2030,7 +2035,9 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
 			}
 			strncpy(adc->chan_name[val], name, STM32_ADC_CH_SZ);
 			ret = stm32_adc_populate_int_ch(indio_dev, name, val);
-			if (ret)
+			if (ret == -ENOENT)
+				continue;
+			else if (ret)
 				goto err;
 		} else if (ret != -EINVAL) {
 			dev_err(&indio_dev->dev, "Invalid label %d\n", ret);
-- 
2.25.1

