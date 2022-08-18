Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFD8599072
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 00:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346045AbiHRWSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 18:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244251AbiHRWSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 18:18:23 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144A23AE54;
        Thu, 18 Aug 2022 15:18:22 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id qn6so5688253ejc.11;
        Thu, 18 Aug 2022 15:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=IBirnUzHVuaTlC2C2j9giTul3u9hLHafcJQxDHnOb7o=;
        b=ecCLMqcpvH2iM6EvoE+05zw73tKeg89wKnGMTuzzZUUj77aoGbrEF3rQEhD2hb1v1V
         lo88etmHnDjU6dNip6+9Rx8CShc3HSNXa6ZEVOKArM/eS8Bsi83d583NQ3XbLIsuWK6Q
         XsLYO2Yp8V4eKuHFe6ScfWrQw7VN73/qW+5JhFFmEKHslHu0ycjh5qUvufs1C0BuC1p2
         T0M47mkQ7eDE2GTUsJP+PbLcB0sXCIgIT6QxyAdNMwFJ0IiJhIVW7VU7G9PFJyUEk4qi
         DF7RT+NXZ1WLqYXUTXKiap9shibsqsMTEiW6t3AIuqIsK1G5GcXdIv1h6DVLLnc58Xte
         ycvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=IBirnUzHVuaTlC2C2j9giTul3u9hLHafcJQxDHnOb7o=;
        b=zIXFJNKnO4xFP8ahB23vzueH8wSQ1unMVPi2NIbzjNFEwacjZYbbMDCkIo+nQaS7Ia
         YJNNG4kW8AaC89Wl9uPK9sQtTkTc004L2wFWQNPnfCSxDbcTOZgl0z+EzH3ZfD9kjmWT
         apvAYOpE4oL5qWtwC7+fyys6n9lX5MVNjqtefuE4NqsIps1beLVc6xRdOpmaw9/Nd0Ln
         bWuieNfJu4GlnU4zCOvI25LeiukWJUu9RlxUJuyDt1XTmzmHc0CJ2oD2SWt62V9Ik8NH
         JNYniyT519aBoBlBLvKBLqvyFhiNqp8v+1bqgHAzUxpBgN7XRRw1lTNWVoxhTokxGn3N
         B5hg==
X-Gm-Message-State: ACgBeo0XHjqWYmV/nIpcUXami5UHNbll/wtHRjmYM29Qd3iLQ/zu6lZN
        gdp+UkQZlX+/b3cxnl+IafMkURVT6Cw=
X-Google-Smtp-Source: AA6agR7WH3Gq9C5mHU0TKGebAMlI+NwpXha2H/FWbKVw2H8SzvoDbBbCQ5asLtYM/SD6nBorATwpxw==
X-Received: by 2002:a17:906:4bd3:b0:731:3bdf:b95c with SMTP id x19-20020a1709064bd300b007313bdfb95cmr3036137ejv.677.1660861100632;
        Thu, 18 Aug 2022 15:18:20 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-74.zg.cable.xnet.hr. [94.253.165.74])
        by smtp.googlemail.com with ESMTPSA id t19-20020a1709060c5300b00731747c3107sm1378315ejf.73.2022.08.18.15.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 15:18:20 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v8 3/5] iio: adc: qcom-spmi-adc5: add ADC5_VREF_VADC to rev2 ADC5
Date:   Fri, 19 Aug 2022 00:18:13 +0200
Message-Id: <20220818221815.346233-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220818221815.346233-1-robimarko@gmail.com>
References: <20220818221815.346233-1-robimarko@gmail.com>
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
index e96da2ef1964..821fee60a765 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -597,6 +597,8 @@ static const struct adc5_channels adc5_chans_rev2[ADC5_MAX_CHANNEL] = {
 					SCALE_HW_CALIB_DEFAULT)
 	[ADC5_1P25VREF]		= ADC5_CHAN_VOLT("vref_1p25", 0,
 					SCALE_HW_CALIB_DEFAULT)
+	[ADC5_VREF_VADC]	= ADC5_CHAN_VOLT("vref_vadc", 0,
+					SCALE_HW_CALIB_DEFAULT)
 	[ADC5_VPH_PWR]		= ADC5_CHAN_VOLT("vph_pwr", 1,
 					SCALE_HW_CALIB_DEFAULT)
 	[ADC5_VBAT_SNS]		= ADC5_CHAN_VOLT("vbat_sns", 1,
-- 
2.37.2

