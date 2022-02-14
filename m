Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427D14B43F6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 09:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241965AbiBNIUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 03:20:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241898AbiBNIUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:20:03 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AB225C44
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:19:56 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6F73040526
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644826795;
        bh=23CQAl/07AaN2dxN1TfTdDj5so/NCdWTbjb57ZtNLwo=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Ah1UupAoINeRCa+UtdPXztTePkYfs2ooX5tQRF6YqDHLCj4fOsLrLszYyo1SzXCyq
         axMRDOzHIudG+Pqc0ec6ebKh4zmyKcerOvHSWvpFsbPW1YBYwnjGWpY7zVcRZHWhNe
         OaNIWiFdGgZPeE5n3cjNx1f3goxIl7Fp2KpN8B9BniBYhXMv4Ferp1VQhCznIrLVdy
         LE2uktIzvLNe2G04mkiN0IDujzL7SkBspAqMUePvKEv2g0zqb9XiwMEpvmQDavRPyO
         +4WpWvTRdL15qFsiBc1D+9I87h2YPFqisEBAeWqc7GlVwK6qDLc1rhee4/NHUBylnn
         nRJ1FYkb1mKAg==
Received: by mail-ed1-f70.google.com with SMTP id z21-20020a05640235d500b0041092b29ad6so3544070edc.19
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:19:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=23CQAl/07AaN2dxN1TfTdDj5so/NCdWTbjb57ZtNLwo=;
        b=P0cgDpoisvfy34S0BuHKUuM5Wx6dkC4IVysQjQ0br8ida46flvTSGyk3IA2Ukticmj
         KF+636tAr7fsnUNyyuVigPbQiATTpjtCrCsLjJxwwyc/Wfe1ZyYtuoNyLN+f7mPyshJC
         seAFffi2vF7CHtTCePTGKDt8NJ8FYcx/jAhSXkui6Z0HjnSZ8tsa2sUH1uW5dDtTcCoh
         ZfMkqP6pUseRNBXTQl6zL/XYgMue6cC9Xqv1NKKc5H8RBrBGx8czKjulYWOfgW4bEZqA
         bk4COPuMT/mUyFOufGQzFoezdBcoYhuQwwiV+F337ajKoPATNkqidTFd9EYc2LMkG74E
         t+8g==
X-Gm-Message-State: AOAM530l9Ovyjl8//9Qp6K5M3o44tYSbce6OKGrKlTeUXVrbxrG0+OFW
        f7Va8DceP5IFpI4gqAGcYC8n+K4dhn9e9tIbrp6RS2mQrAISq9EHBXWXEgzFZ+vxYsgBKcHV3cb
        jywiC64Za/BHlVehVTXYLqIj+HDSIptk9XoB1kFBL8w==
X-Received: by 2002:a17:907:3d01:: with SMTP id gm1mr10671213ejc.695.1644826795050;
        Mon, 14 Feb 2022 00:19:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyduVMGZqiqcBn+5NbYVmKbo23S2Kx2GnaG0uOcebe1lzeD4dxVvKdv5SiQHDzJAeAj67dMnw==
X-Received: by 2002:a17:907:3d01:: with SMTP id gm1mr10671188ejc.695.1644826794896;
        Mon, 14 Feb 2022 00:19:54 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id b20sm2022941ede.23.2022.02.14.00.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 00:19:54 -0800 (PST)
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
Subject: [PATCH 2/4] arm64: dts: mt8183: align Google CROS EC PWM node name with dtschema
Date:   Mon, 14 Feb 2022 09:19:14 +0100
Message-Id: <20220214081916.162014-3-krzysztof.kozlowski@canonical.com>
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
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
index 8f7bf33f607d..2d7a193272ae 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
@@ -92,7 +92,7 @@ volume_up {
 };
 
 &cros_ec {
-	cros_ec_pwm: ec-pwm {
+	cros_ec_pwm: pwm {
 		compatible = "google,cros-ec-pwm";
 		#pwm-cells = <1>;
 		status = "disabled";
-- 
2.32.0

