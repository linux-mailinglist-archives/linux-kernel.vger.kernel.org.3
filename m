Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64F3515826
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381421AbiD2WPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381366AbiD2WO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:14:26 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF9BDC99F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:11:06 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id q20so5330396wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0WEp4V6aZMyxWhcrxEKABYt19rBiXZcxvqKzE3SZIe0=;
        b=Keg2qgtxsT0PNgxhjstP7bYXmZKcqHZMFZ6OQJGAz4/VS7eA8idH/UxV3ZZJ0ZdE19
         aFKzPoA8oCSVmRyOjGcPEEKpK4XhyjrHZ7u7FzBWnRHoPfqJiAENT+FayNNe66CearY3
         kGfekX4RrHA3rhlvh7ZpdBnDrUUUEVNxWprtS37MvfNbVHpwgHVcgn83++PCWMXlJa/X
         lKKIzQmtKyfLylEBsr7GSuYv6LBI9JbI4BQI4RHn+dyS2OmYmfCu+1ospXcyL0dkBMy0
         QYpXNZbjIpQQAl7K1bxcAs7Cb/zOad3C0AraEAxRBz4AX4Y55gbWRXiuHOBW4Mttaptk
         ADAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0WEp4V6aZMyxWhcrxEKABYt19rBiXZcxvqKzE3SZIe0=;
        b=ksDykkg2SpA1EY8d3d1J72u76zcyLozIrPxcoECijawtLXR3jIzuZaars2CVmKhVxb
         arlHCO2Xvr/bbZcg4T+j/GxQZ3FXI4aUnwx96cRgyOayDPNFTpFpOqM6tGerSWWRBCLp
         9ZucDCaX7IpHGP81sLZsYJBzQGCVeqhgHoqcInCuSS4aT+lIO3uSeO/WqfWKsM9DOX4O
         YrxZrrU33VIa/EfVmNm4r2IRydIsV/zD8ptfqsevJLnLztjMmyDxgFOs4lc8nb2L8Syg
         REwjcXpA1SvsHfcT4STwH1mTedUN0L7ARp4VPxA50C3SYfyG2XiTQUC3pf9O3SD4OAzm
         DCAA==
X-Gm-Message-State: AOAM532RZeIvb516lXQzIueanoDZxpowzxdEw4uLULMhXk/BAm+hzf+r
        vxbwh83sbQ5Vp1BEpK3M5eO+7A==
X-Google-Smtp-Source: ABdhPJz08OJcXIZ9HOmIoOx8RtC+6enH4juHgqsBFwco6tpfuwvu9EuEHJWx7vowVSp6ol5iQ584dw==
X-Received: by 2002:a05:600c:4f90:b0:392:8de8:9deb with SMTP id n16-20020a05600c4f9000b003928de89debmr933061wmq.166.1651270264475;
        Fri, 29 Apr 2022 15:11:04 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id q7-20020a1cf307000000b003942a244ebfsm291985wmq.4.2022.04.29.15.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 15:11:03 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Jami Kettunen <jami.kettunen@somainline.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v14 08/10] arm64: dts: qcom: sdm845-db845c: enable rradc
Date:   Fri, 29 Apr 2022 23:09:03 +0100
Message-Id: <20220429220904.137297-9-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220429220904.137297-1-caleb.connolly@linaro.org>
References: <20220429220904.137297-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the Round Robin ADC for the db845c.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 28fe45c5d516..40a290b6d4f3 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -599,6 +599,10 @@ resin {
 	};
 };
 
+&pmi8998_rradc {
+	status = "okay";
+};
+
 /* QUAT I2S Uses 4 I2S SD Lines for audio on LT9611 HDMI Bridge */
 &q6afedai {
 	qi2s@22 {
-- 
2.36.0

