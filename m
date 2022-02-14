Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF20A4B43EF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 09:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242022AbiBNIUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 03:20:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241943AbiBNIUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:20:06 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9C825C53
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:19:58 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BE2E840518
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644826797;
        bh=o/YgTPBdxwkk76YIPJfDwO9KLR8OIlu6EoGrWBDU/GQ=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=EwTyN5N67UAQHLpprepPlAdArEoxH9FHAtFV+b2v/8mCpJO9jzmVzcILyPM1QfAbE
         mcYvaKAxFLktyuhN6d8z+h5Ije00wbvaMxqdQcusXQUlfOszPBuuMobs1BrXaKaANb
         9dlfmVgYjSoQt2dKnfeJ/ZSY+y1qzxVO9Fjhv7VR++Dy8m0dWIbJnuE5jhsBzkGIA1
         n+qAYg2y5g/hq71m0WQZbiuHAxmVjasQzBlAgOptKuU9jy81ta9rak5q4puZxmImiQ
         QzRXART7ckrtwQCvBQSSU96TSsvUzC9xC0sKw2KEQYTwjoP0Ah9DwcJioZJ7+YEa0R
         8mDjyxKbwq3Dg==
Received: by mail-ej1-f71.google.com with SMTP id m4-20020a170906160400b006be3f85906eso5483654ejd.23
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:19:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o/YgTPBdxwkk76YIPJfDwO9KLR8OIlu6EoGrWBDU/GQ=;
        b=2F2LSevu8VNjnjLvmTuSvjtiumRaiT22/M9xTvoSRbXHfN0C/xAzHq6el75MAPsQyQ
         xvky++UqVue5Of3UcOL5sE+3UgX/Aai93MiSpggCNMQ2VWL6n4fDVCngM89MILEFTjrL
         iKfzaH7BiwLiTfSgn+8aZF9cQi3UWtBN1JL5oGM9SygHmi8PRpiK0HZeYA31kGC+DOl6
         8A8cFyPay5BBj1GtlejcTWB8wJ1mfafAeTynwzjSF1G2Xw4PdQTpOVfTa+vixAjN+0id
         4nXHM1a+jDS5xk7bVx+l4ogzAL1g45O8NZ9QiSB+ltQoIrG1Kn+YMzHmfa4gxwc65q2B
         aWfg==
X-Gm-Message-State: AOAM532pDNYwCK1OCHvmMhKrJB750AJL20q+Kdl9FJjlvdD7WPa/3Ir3
        UU0+3695kNtVaMBDSQXa2A0ilnvz5umD/ARbQpz7SL1r/UbeX5GD9n+scEdIzdvWZwXQbIGrYjN
        5ijEf33J5EfGWmux6HZYMGsXelHcPlhLLheY3B+vI/w==
X-Received: by 2002:a17:907:6091:: with SMTP id ht17mr10718089ejc.607.1644826797392;
        Mon, 14 Feb 2022 00:19:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwkFPJeiJWjmWYMYKnbVg1bBwxgaPTZV+oh4RSUxGNA67GTozBuexvPDdoyT1VdY/d6fUhgGw==
X-Received: by 2002:a17:907:6091:: with SMTP id ht17mr10718069ejc.607.1644826797215;
        Mon, 14 Feb 2022 00:19:57 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id b20sm2022941ede.23.2022.02.14.00.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 00:19:56 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 4/4] arm64: dts: rk3399: align Google CROS EC PWM node name with dtschema
Date:   Mon, 14 Feb 2022 09:19:16 +0100
Message-Id: <20220214081916.162014-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220214081916.162014-1-krzysztof.kozlowski@canonical.com>
References: <20220214081916.162014-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dtschema expects PWM node name to be a generic "pwm".  This also matches
Devicetree specification requirements about generic node names.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
index 9b2c679f5eca..3355fb90fa54 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
@@ -462,7 +462,7 @@ ap_i2c_tp: &i2c5 {
 };
 
 &cros_ec {
-	cros_ec_pwm: ec-pwm {
+	cros_ec_pwm: pwm {
 		compatible = "google,cros-ec-pwm";
 		#pwm-cells = <1>;
 	};
-- 
2.32.0

