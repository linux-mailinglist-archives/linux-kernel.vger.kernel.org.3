Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439B757786B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 23:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiGQVhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 17:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbiGQVgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 17:36:46 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9EE12D1C;
        Sun, 17 Jul 2022 14:36:32 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a9so16488773lfk.11;
        Sun, 17 Jul 2022 14:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BUHGAX6zaDDfsQ7flEjSXThPVWPbvGeWlLy7ZGfnTTY=;
        b=qviVcLohDxmqvrdpZd0OjBPdXb4Y6WH4lbHhzDD9LGYErXfz4Pc4iZLBm0+YIZPZSU
         i5BQQ7trcw1L1N2t8AQEwbditF9UrmkpLnKHNaj5J/5/JlW/aexnMXAAN2wTsJDqmUuF
         IPNUQijeeo+12PMJYj2pI/8oX8qWomU1GTgoiYiXQhAtXJ6Nwpuwubr/G3H1/tbtfPyL
         cpQRZeiHuiP0UjaF5GH/E5OxTy/fQsiQzfTOeZgypp0Vy/AnCwUr89FZMvAJhX6mqkxr
         Js8Sw807uEUEB+xAyS7qz6bxDkwBuT/i2ht0XAtAyjicokQDVCuJr5N2RxSg6riF9Qfw
         Bjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BUHGAX6zaDDfsQ7flEjSXThPVWPbvGeWlLy7ZGfnTTY=;
        b=PDJEU9eoao8tyohZ2GeKpjqYgtIKGM+t7L/w7BsxFY3F3/OTEU9CLZbJ2oZmE6bwry
         /DMqdRAuUStnlPvKcWdzpoLvkyIYrqbTkzEVHuX021R/pmzN+6ESW1Soe8vvnF4YzWY8
         3tX+M2DpS6TAVmwjct9Syn9D/M89JDlt98V1ynxeRaPI3S2SdNXy4xdpCc9N66JYsUoO
         eo/n5W7bmzgUsJot+p281NfqVChgjFbFeriphI4O8yGI7ZsiiRCDCJiKDBtrkJVbaPPQ
         f9MM21dz+SZF9fAOKQkFjyxRLSu/wvGI4HO5M5rx3m3D0h0B5q2K1U9lPymsj6HKoN3r
         x55Q==
X-Gm-Message-State: AJIora+89lfggwdWe+FqHt+W0+25eK0h2+fY8SJAgh4Wbc2jmTjkffyy
        RBT0VURTpBQyoE3uuixE3rjcKTPDLuBZCIzRodFIiw==
X-Google-Smtp-Source: AGRyM1vuopOtzTS/RGiJtHuP1lwTSnPYiv5DAcomiO3uSCDGJBcIz9YE2q6qT721Bt0iIqg3cIFHEg==
X-Received: by 2002:a05:6512:b1d:b0:48a:468d:6f0d with SMTP id w29-20020a0565120b1d00b0048a468d6f0dmr26192lfu.596.1658093791004;
        Sun, 17 Jul 2022 14:36:31 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-5673c7-93.dhcp.inet.fi. [86.115.199.93])
        by smtp.gmail.com with ESMTPSA id w16-20020a05651234d000b00485caa0f5dfsm2251088lfr.44.2022.07.17.14.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 14:36:30 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ARM: dts: qcom: pm8226: Add node for the GPIOs
Date:   Mon, 18 Jul 2022 00:34:29 +0300
Message-Id: <20220717213432.134486-2-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220717213432.134486-1-matti.lehtimaki@gmail.com>
References: <20220717213432.134486-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PM8226 provides 8 GPIOs. Add a node to support them.

Signed-off-by: Matti LehtimÃ¤ki <matti.lehtimaki@gmail.com>
---
 arch/arm/boot/dts/qcom-pm8226.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-pm8226.dtsi b/arch/arm/boot/dts/qcom-pm8226.dtsi
index 9b7d9d04ded6..235df06a0369 100644
--- a/arch/arm/boot/dts/qcom-pm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8226.dtsi
@@ -90,6 +90,16 @@ pm8226_mpps: mpps@a000 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
+
+		pm8226_gpios: gpios@c000 {
+			compatible = "qcom,pm8226-gpio", "qcom,spmi-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pm8226_gpios 0 0 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
 	};
 
 	pm8226_1: pm8226@1 {
-- 
2.34.1

