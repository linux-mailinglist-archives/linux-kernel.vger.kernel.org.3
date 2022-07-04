Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C51565F14
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 23:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbiGDVYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 17:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbiGDVYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 17:24:21 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BD611838;
        Mon,  4 Jul 2022 14:24:17 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id pk21so18583443ejb.2;
        Mon, 04 Jul 2022 14:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LnamX1gew1r1q0GcrIpZt4+urN+4Mq6nhqE3N2XaYR4=;
        b=XLZ785HHB6mv+qYnSjQY+HnZfgvV+Ec7XEdVchP7tl1d3JBz+ziZqHPzjcYVBi0lfS
         U1J4YLPSSH2hu+TFDwTACHubDz2DxIh8I6cEosF89O/PZrGAN0CbmoXnXqjNwfzJ6NA7
         3HPa3jxNnmztV+TcrcQ64CVgFHMwHf2+8HgR9B5Ly+v69Rtp+hV4//+xMjw/AnkMHmBZ
         iXCVlnxwh9cWqgkMw+sJ9fnZyQQMhIw7q4O9LkSlXB+1n9hB2ap03DixVawLMTHpzRJe
         FG7dk20V1JnG7m7WcVDWLgPBoT9gZZpFZzMknFMqWgwD28Tjb8zyZLJvISWkTS6pIWKi
         k6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LnamX1gew1r1q0GcrIpZt4+urN+4Mq6nhqE3N2XaYR4=;
        b=dVVFVY9iuz2/wLCymEueBXI200Iz5aNbJyHTAurl7kNgcouQ6L6/GGFxsZebXd8akN
         zq1y9c16WYqX635OXtSz/AWtzpUdSjUjTg4HHHsrpNj8NZPW6ecrF4VrMLHLCwF2iybg
         OiuZIeAj0dn4VS0rf7r98PiCCgzA7v+OqwAIig6j8cL4yq+QIz+zWJd96qElDFR9QPxJ
         kd3E/epzFfgsRIXui+YauM6Kl/wzFqCMuEZHMLqciNz6WC5nWlDQL08SO+9AwOmFj2Ks
         sd+OEITTwDdhIJQTVLRM4WxheSNlQZIcfDk2U+TAM5eGGx8HuoDf6KzL60wF0GAz9I+K
         JUow==
X-Gm-Message-State: AJIora/pq7yxUs8FPlT/D+MeH33/jr9inuqciycSFjW4y03tffQBNXpe
        i9F6oVg2vQRh12kJV680bCJ+aPZqR6xtXA==
X-Google-Smtp-Source: AGRyM1t9CPlzYzeJS465exWF324D+VyMdrNX8+amewcJWlqu0rgaY1NAKJWmxmb8TnCWhFUJ5Lr80Q==
X-Received: by 2002:a17:907:3f0f:b0:726:8efa:ba81 with SMTP id hq15-20020a1709073f0f00b007268efaba81mr29637797ejc.535.1656969856197;
        Mon, 04 Jul 2022 14:24:16 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-99-90.xnet.hr. [88.207.99.90])
        by smtp.googlemail.com with ESMTPSA id k18-20020a056402049200b0042dcbc3f302sm20131117edv.36.2022.07.04.14.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 14:24:15 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, lee.jones@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        jic23@kernel.org, lars@metafoo.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v6 10/12] iio: adc: qcom-spmi-adc5: add ADC5_VREF_VADC to rev2 ADC5
Date:   Mon,  4 Jul 2022 23:24:00 +0200
Message-Id: <20220704212402.1715182-10-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220704212402.1715182-1-robimarko@gmail.com>
References: <20220704212402.1715182-1-robimarko@gmail.com>
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

