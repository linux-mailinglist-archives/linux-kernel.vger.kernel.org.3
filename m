Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0172A57C399
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 06:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiGUEn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 00:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiGUEn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 00:43:27 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52B074379;
        Wed, 20 Jul 2022 21:43:24 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l23so1120577ejr.5;
        Wed, 20 Jul 2022 21:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7lkbSCl4WMVF6PyAIugGhujYGS6F9o1+Rht1abC9LWI=;
        b=IKRYc7LfN4GhVKTKzErBqYb7m8h6Ng81Ugm728RiNIz3q23m9Octz3Zf6PPs6fFZvL
         ln2/6eQqsc27Z7BuqGWq0aLdViASTIWZe+GSdt+jfxKF0DOjyzjQyW8UFbfh5f84KqQx
         Wvrbk8ePrZDvJoE2HwkC4rN1W7Tg4TzWNd0FHhFgg7DcxvVRl/UIXdlvRcMu7TT5Vgw8
         5RNGDDhpOWJS/Y9p0Ow/ex/E8ZlaMT4E+QcqTeHjSGHsixld+GAlmd/rsyctjk0RtrW5
         +ys+yPZ8HjQJboTMPhclEB43fQFM1TwP4LuUzXvcjQLl9zZ34op/ZO2hZm6I/OVvsC2P
         1JVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7lkbSCl4WMVF6PyAIugGhujYGS6F9o1+Rht1abC9LWI=;
        b=Zie7gwF73Kp5jlFdvwPSCh8ZUZiiYwE9+KrPA4SAK4TzNMdguDd5kZUWuAhNhUK2jj
         RprpIvCy8TWwMGYOwi9e0ywrEPJOYTXESQWK8O4PUBhCT0LjK/BCvG5gMCBLUrHIgeuB
         sbMw7Q71lu61PGkTN3kQRS6QG5iu8cqrEN8ZNDLhbUmTs2952ji1i0dn8YDznrlzH/+h
         hNXiUGbpkMjnOtI0IvIG2CVsEiT9bGrRbpbIq+OTl0nb9euDfPuJZ0t9Nr+ltUun0z+r
         e5oglXLIBXdF05khHSjbvnvNkePUVjDYT7lFpqX62RJ7DzT6iaaVzDmyiNVYYpPZ4s1N
         Me9Q==
X-Gm-Message-State: AJIora8ozyEv8dUCUTIrVi7z/bzNxO+g+DsjHo5R+P4fgF+NhFcIvDvT
        ViKrft2qAANFDaub+f3EKa8=
X-Google-Smtp-Source: AGRyM1sM/rYuTMl9+p0TqfNhZ8iyCI/Gk2d1yYw0EQj2ga4lxAw3AQPVNPIbEqreVwJRGoIeAGTexg==
X-Received: by 2002:a17:907:1def:b0:72b:33e6:46d6 with SMTP id og47-20020a1709071def00b0072b33e646d6mr37885988ejc.414.1658378603202;
        Wed, 20 Jul 2022 21:43:23 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id p8-20020a17090653c800b00726c0e60940sm379575ejo.100.2022.07.20.21.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 21:43:22 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Lower sd speed on quartz64-b
Date:   Thu, 21 Jul 2022 06:43:06 +0200
Message-Id: <20220721044307.48641-1-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
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

The previously stated speed of sdr-104 is too high for the hardware
to reliably communicate with some fast SD cards.

Lower this to sd-uhs-sdr50 to fix this.

Fixes: dcc8c66bef79 ("arm64: dts: rockchip: add Pine64 Quartz64-B device tree")

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
index 02d5f5a8ca03..528bb4e8ac77 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
@@ -506,7 +506,7 @@ &sdmmc0 {
 	disable-wp;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
-	sd-uhs-sdr104;
+	sd-uhs-sdr50;
 	vmmc-supply = <&vcc3v3_sd>;
 	vqmmc-supply = <&vccio_sd>;
 	status = "okay";
-- 
2.37.1

