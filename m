Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E915147FDA6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 14:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbhL0Ngr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 08:36:47 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:39716
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236917AbhL0NgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 08:36:15 -0500
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 85A903FFE9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 13:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640612174;
        bh=kkUdeG5ceHrjuSuIkqkE8YNWyxg2eHSHTjUTr9KxZzk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=gm5bSJsa2DGV+Mhjm2yc7yWjzUs/JfnDEcQNcRRReIkGMRReLYQyoLMstOJ7bbfQP
         Q2IOhTtJZhyafx21tB41GdvcpLk/6BsT4RufC6SdWYfLf09CFsasD/Zp5kUPoq3jo1
         waUWDGWiRlE9+m3ovuufn/Dxzk1WSiTbVci7um8RkEUlleI57A9wYsNV37mwmIIwUC
         hVdoRWT0SQKrWDf+3k4Xbxq38IuAOTkIY3ZqKLUE8SdtWOvrDDW7BF30U4Twy8otE3
         AYvpZBtdPgm3IJGPnV0HzruuW6EmzTaEQBoFlwgTePvEUiikRP3aMpC7Y0JWB/F/s4
         g9Sd63gDwhSyA==
Received: by mail-lf1-f72.google.com with SMTP id m8-20020a0565120a8800b00425edb1a456so3678601lfu.16
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 05:36:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kkUdeG5ceHrjuSuIkqkE8YNWyxg2eHSHTjUTr9KxZzk=;
        b=YF6oVmceaMEkSS3zYqqsNb2XYL9K+IfBtk/6aWNMY1+zXzBwW2q1Cabcu6rSty4ohe
         MTGcNh5PI+cK79oWtI6OM2U1R8VN7SWZDNmIeruiCYbcnLmmOK7C5hCszPeMQ5da7zjG
         VX4NB292PdR5bCLTKJPmUP41YBnlUXFq+3Q9BT50lEGgBVS6V+0TGMvF6UGubboyvonz
         y0zfUwql+Z90ns9q4nZ6vyRfFXNk+CjDqYlP4xInOMAUmnclbuvTCqps6jkdB1NRj2WB
         2f59ULsbvMqkOIAGwN3PQbNBqCG43cr78VpzunuBDbO2tjia/3pnxvkh71PY7Dw7V7vA
         ryqQ==
X-Gm-Message-State: AOAM5318FdpS7fEUvpemxp5LAwu7lRg59FzwrPsntbVFpC42w7pSBP8K
        xL5fqO4gmskyA4IERNFRNZlWj8KJAdPXSxISp8ipyjShQ36z9swScarktmPI+hOtY53EIB8BPED
        mNET6EDw+sjQ/UsrdHut0KPmv3009EsdH7p/Ormk83w==
X-Received: by 2002:a05:651c:511:: with SMTP id o17mr8667360ljp.374.1640612173652;
        Mon, 27 Dec 2021 05:36:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzfa+8FB77JaX0hFBrtXh+MFcMU59EojnWCqXY8eabSSi6JcvyGPGjrWdRPz/yX/6OB1oYZEA==
X-Received: by 2002:a05:651c:511:: with SMTP id o17mr8667351ljp.374.1640612173507;
        Mon, 27 Dec 2021 05:36:13 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id g18sm800107ljj.124.2021.12.27.05.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 05:36:12 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 16/19] arm64: dts: stratix10: align regulator node names with dtschema
Date:   Mon, 27 Dec 2021 14:35:55 +0100
Message-Id: <20211227133558.135185-10-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
References: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devicetree specification requires that node name should be generic.
The dtschema complains if name does not match pattern, so make the
0.33 V regulator node name more generic.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts      | 2 +-
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 12392292c62c..5159cd5771dc 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -44,7 +44,7 @@ memory {
 		reg = <0 0 0 0>;
 	};
 
-	ref_033v: 033-v-ref {
+	ref_033v: regulator-v-ref {
 		compatible = "regulator-fixed";
 		regulator-name = "0.33V";
 		regulator-min-microvolt = <330000>;
diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
index 2d53a06deab5..0ab676c639a1 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
@@ -44,7 +44,7 @@ memory {
 		reg = <0 0 0 0>;
 	};
 
-	ref_033v: 033-v-ref {
+	ref_033v: regulator-v-ref {
 		compatible = "regulator-fixed";
 		regulator-name = "0.33V";
 		regulator-min-microvolt = <330000>;
-- 
2.32.0

