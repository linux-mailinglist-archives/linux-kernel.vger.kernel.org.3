Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F3248B839
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244083AbiAKUSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:18:11 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:38038
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242670AbiAKUSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:18:05 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1080B4004E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641932283;
        bh=kDoTHutMEAOdfAvEQmMCvsGPLxW8/ktRUinuzsYc7Nc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=YFoMjywy5fFzvSJK7JiMLVzglnCKL0MPVP5H0cMer1CmpYVK0tPL5fy8ZK6foeShC
         gfnQ9RRZDTAk7AqIGd466lDD+zsZZ6Dm2DJo203Fx4u/kV54lUkaOkUwg90mCwQrlb
         GWGNnDKc+C+2X5ZTxCqLdPhoweQX6FFuPSB09mwNn9diYIMg6PZwFju4kDo8A//gM0
         z6P28jAP2ztdyckJcaZraJLaADr/S3yHDGgrtCivm8mPsv83Ps4TnFtnXgtE7TCUJH
         MbN7fWbBZlqOS9yyArZnjMWuZ4LFca0U739SRheccnq8arHMV3p3mYZCQLtVaVVqGB
         g9kZyki4BmWyw==
Received: by mail-ed1-f72.google.com with SMTP id i9-20020a05640242c900b003fe97faab62so192961edc.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:18:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kDoTHutMEAOdfAvEQmMCvsGPLxW8/ktRUinuzsYc7Nc=;
        b=nlmSIi8tbX2Ni+t3AIWRp51fBeo/nuSEFJugQ+ey1lVIRLH4ioF/q+OANRLF9bwiYa
         1qucGLt+748WeDYlqTeh+a/vO/KT/dGHHEobBpD5zlb2a14od7r9D0Qvoy4/AJ9hUYIG
         qrrsl3lkpAPabSqxByAjDAaf304AVDAYvStRpbAHxKR3gpAaSMnTF8EQCAusfDX7Ks+j
         DK/OVnn05EoawOc9SPG0NyEtBgQyn3+kHC4MFQFUHhPBH27aPOdjXAC5n3nv11mYL+5m
         t5rpNfHVwR2QIWaHfmM0pjxcUIbckyO5EeNSskrrpx3zZtv/qJy35oZpGk3WJ3xlPT2g
         WCqg==
X-Gm-Message-State: AOAM533/gENG62hu59PVTipMC0uOve5SXxDtMjiay/Pd5kBVpbl3ItiW
        SqAcTs0srDJTLqLXfhpk0k958k6LN/IG5eKIcsjYjF2xHIreM8Vqhm4fgbS3G64OFoOh0KhyKuY
        aHfhWzIeldFtzJ6XHyEmcbv7R2BfWjVAjjv4jzS0HCw==
X-Received: by 2002:a05:6402:2926:: with SMTP id ee38mr5851992edb.213.1641932282519;
        Tue, 11 Jan 2022 12:18:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxsuhLrTEsItilqaRBXNonfCCsK7u7PWJtW46W8/0QM8Ys5Q4lSWFlZbTeB4QhKWwzSlFxGlQ==
X-Received: by 2002:a05:6402:2926:: with SMTP id ee38mr5851985edb.213.1641932282391;
        Tue, 11 Jan 2022 12:18:02 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id e4sm4030881ejs.13.2022.01.11.12.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 12:18:01 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>,
        Alim Akhtar <alim.akhtar@gmail.com>
Subject: [PATCH v2 09/28] ARM: dts: s3c64xx: drop unneeded pinctrl wake-up interrupt mapping
Date:   Tue, 11 Jan 2022 21:17:03 +0100
Message-Id: <20220111201722.327219-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111201426.326777-1-krzysztof.kozlowski@canonical.com>
References: <20220111201426.326777-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the nodes of S3C64xx pin controller with wake-up interrupts by
removing the artificial pinctrl-interrupt-map mapping node and use
interrupts-extended.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/s3c64xx.dtsi | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/s3c64xx.dtsi b/arch/arm/boot/dts/s3c64xx.dtsi
index cb11a87dbc42..67a7a66e11d5 100644
--- a/arch/arm/boot/dts/s3c64xx.dtsi
+++ b/arch/arm/boot/dts/s3c64xx.dtsi
@@ -178,20 +178,12 @@ pinctrl0: pinctrl@7f008000 {
 			interrupt-parent = <&vic1>;
 			interrupts = <21>;
 
-			pctrl_int_map: pinctrl-interrupt-map {
-				interrupt-map = <0 &vic0 0>,
-						<1 &vic0 1>,
-						<2 &vic1 0>,
-						<3 &vic1 1>;
-				#address-cells = <0>;
-				#size-cells = <0>;
-				#interrupt-cells = <1>;
-			};
-
 			wakeup-interrupt-controller {
 				compatible = "samsung,s3c64xx-wakeup-eint";
-				interrupts = <0>, <1>, <2>, <3>;
-				interrupt-parent = <&pctrl_int_map>;
+				interrupts-extended = <&vic0 0>,
+						      <&vic0 1>,
+						      <&vic1 0>,
+						      <&vic1 1>;
 			};
 		};
 	};
-- 
2.32.0

