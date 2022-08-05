Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC3958ABEA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 15:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238027AbiHEN5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 09:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbiHEN5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 09:57:43 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B0E51439
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 06:57:41 -0700 (PDT)
Received: from localhost.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id C6A441FAA7;
        Fri,  5 Aug 2022 15:57:39 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v2 2/5] iio: adc: qcom-spmi-adc5: Add missing VCOIN/GPIO[134] channels
Date:   Fri,  5 Aug 2022 15:57:26 +0200
Message-Id: <20220805135729.1037079-3-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220805135729.1037079-1-marijn.suijten@somainline.org>
References: <20220805135729.1037079-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These channels are specified in downstream kernels [1] and actively used
by e.g. the Sony Seine platform on the SM6125 SoC.  Note that GPIO2
isn't used on this platform and, while the definition downstream is
identical to the other GPIOx_100K_PU definitions, has been omitted for
lack of proper testing.

[1]: https://source.codeaurora.org/quic/la/kernel/msm-4.14/tree/drivers/iio/adc/qcom-spmi-adc5.c?h=LA.UM.7.11.r1-05200-NICOBAR.0#n688

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 drivers/iio/adc/qcom-spmi-adc5.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index 87438d1e5c0b..0dc4fe612433 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -526,6 +526,8 @@ static const struct adc5_channels adc5_chans_pmic[ADC5_MAX_CHANNEL] = {
 					SCALE_HW_CALIB_DEFAULT)
 	[ADC5_VBAT_SNS]		= ADC5_CHAN_VOLT("vbat_sns", 1,
 					SCALE_HW_CALIB_DEFAULT)
+	[ADC5_VCOIN]		= ADC5_CHAN_VOLT("vcoin", 1,
+					SCALE_HW_CALIB_DEFAULT)
 	[ADC5_DIE_TEMP]		= ADC5_CHAN_TEMP("die_temp", 0,
 					SCALE_HW_CALIB_PMIC_THERM)
 	[ADC5_USB_IN_I]		= ADC5_CHAN_VOLT("usb_in_i_uv", 0,
@@ -549,6 +551,12 @@ static const struct adc5_channels adc5_chans_pmic[ADC5_MAX_CHANNEL] = {
 					SCALE_HW_CALIB_THERM_100K_PULLUP)
 	[ADC5_AMUX_THM2]	= ADC5_CHAN_TEMP("amux_thm2", 0,
 					SCALE_HW_CALIB_PM5_SMB_TEMP)
+	[ADC5_GPIO1_100K_PU]	= ADC5_CHAN_TEMP("gpio1_100k_pu", 0,
+					SCALE_HW_CALIB_THERM_100K_PULLUP)
+	[ADC5_GPIO3_100K_PU]	= ADC5_CHAN_TEMP("gpio3_100k_pu", 0,
+					SCALE_HW_CALIB_THERM_100K_PULLUP)
+	[ADC5_GPIO4_100K_PU]	= ADC5_CHAN_TEMP("gpio4_100k_pu", 0,
+					SCALE_HW_CALIB_THERM_100K_PULLUP)
 };
 
 static const struct adc5_channels adc7_chans_pmic[ADC5_MAX_CHANNEL] = {
-- 
2.37.1

