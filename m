Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C00570C01
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbiGKUeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbiGKUeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:34:18 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903A6422F9;
        Mon, 11 Jul 2022 13:34:17 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id k30so7676796edk.8;
        Mon, 11 Jul 2022 13:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8kffmDQRv74NOVeeXFSx1e5OFvyn8uWZD+7MCMw1lKs=;
        b=INFoDWlRap9cPHlvXq6yIJ5ELMlS7dRyXDIrxHoj9Nf8EjfKoSEhkr0o1BW7v9FCFZ
         qo+3k6MWB33m1AJLRcJ+9W423PMXg4Us0u3z6PbVQyyHw3pdJJQzP3/k1WudvLMUA0D3
         AuoaYawAzHXS2YG3xMfG1aR+p9KEmJRgaoz2y9Bgyctb+ddL6P/C+FXOv4k45UYD+sWI
         8ZTxf+vLej813FljseCi4QBsj3Upy/J8nzqVr40hp1xLn9j/pSA4DnANIBab4jRNIy7a
         yQ8S1W4TdsqdtbFNeXofUlYv5VumFThvLKmykJ3O0jaDQ/0Am5XOKlf23C9WMxhWZEyl
         s19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8kffmDQRv74NOVeeXFSx1e5OFvyn8uWZD+7MCMw1lKs=;
        b=nf451yRUgVzOhWfc64zwLsYOfZqNodji4h/4bdCAA+BdQNquNU9XexmBb43wd+PDD/
         9Sl2ppcwPmYIVXXVaRRC5BkExhIdUFfHwcpGTVv6oCO0MdoYUtbbZ/8wS5dNKHM53bmZ
         7NoUiUJwJpdxC2NYzEmWA89RGa3/YW95wwsRE9kLTDMGr3Y50SjtY6lxASXjfQz4spWD
         6rgZNIJJlf2NRdxUFnRPEX35ezfapUMLVRNKHr6SnQpfAxDif5wuJRZ66s6DkbevCIJ9
         tH/ZD9msFfDkqQkdzHUEYhiKnYVvserDH1pZKYndKKIFsS3zd4omyA/2pEMI9BVhG6VD
         QCVw==
X-Gm-Message-State: AJIora844Zzd7YQNNJTyx6x56lf8u71p0/VzGI0zL7dFDy+7dhSXTW6Y
        +dFYsS9koR1NdoVzkk19oJ2diMt4rHAQOw==
X-Google-Smtp-Source: AGRyM1s3h9+ym9TFBCssh9IBPjja+dOT2TvKp6aad2WD8sVVDtpUMlNT9cNpYoH1xUu2KVMSBT9rfA==
X-Received: by 2002:a05:6402:428a:b0:42e:8f7e:1638 with SMTP id g10-20020a056402428a00b0042e8f7e1638mr27602671edc.228.1657571657179;
        Mon, 11 Jul 2022 13:34:17 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-104.zg.cable.xnet.hr. [94.253.165.104])
        by smtp.googlemail.com with ESMTPSA id l11-20020a056402124b00b0043a422801f8sm4936264edw.87.2022.07.11.13.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 13:34:16 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, lee.jones@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, jic23@kernel.org, lars@metafoo.de,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v7 5/7] iio: adc: qcom-spmi-adc5: add ADC5_VREF_VADC to rev2 ADC5
Date:   Mon, 11 Jul 2022 22:34:06 +0200
Message-Id: <20220711203408.2949888-5-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220711203408.2949888-1-robimarko@gmail.com>
References: <20220711203408.2949888-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ADC5_VREF_VADC channel to rev2 ADC5 channel list.
This channel measures the VADC reference LDO output.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/qcom-spmi-adc5.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index 87438d1e5c0b..7bd3745884f0 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -589,6 +589,8 @@ static const struct adc5_channels adc5_chans_rev2[ADC5_MAX_CHANNEL] = {
 					SCALE_HW_CALIB_DEFAULT)
 	[ADC5_1P25VREF]		= ADC5_CHAN_VOLT("vref_1p25", 0,
 					SCALE_HW_CALIB_DEFAULT)
+	[ADC5_VREF_VADC]	= ADC5_CHAN_VOLT("vref_vadc", 0,
+					SCALE_HW_CALIB_DEFAULT)
 	[ADC5_VPH_PWR]		= ADC5_CHAN_VOLT("vph_pwr", 1,
 					SCALE_HW_CALIB_DEFAULT)
 	[ADC5_VBAT_SNS]		= ADC5_CHAN_VOLT("vbat_sns", 1,
-- 
2.36.1

