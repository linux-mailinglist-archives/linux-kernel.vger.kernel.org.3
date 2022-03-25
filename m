Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F76F4E759F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 16:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353922AbiCYPDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 11:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346398AbiCYPD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 11:03:29 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6368395A1D;
        Fri, 25 Mar 2022 08:01:55 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id lr4so7496778ejb.11;
        Fri, 25 Mar 2022 08:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9VcDy2eNu6zj3ojAJOI8YY4Y8u6xcG4aGKHl4udgapM=;
        b=g6i7bgOZsjWuNr4hEdvMpSFsyEgpVdKX352ZfiMam0a60mQ6mTwBUao8hi+iT7eTDH
         HPhYBzpSMAAMp3XDwqHvLGxbRQK8meGGVGMbmfaOb/3gC0zbeOTZFUKQa1mbYbEtMvoC
         DhADMEhBMzfZ2cvViMoKmZMmeZgrvo4SsLYcPE1uUQ/AlW4HmGMkjbc+TUVAuxN6LTZg
         ommHf300SnoLf3tT3Rnj9v2qtr5Tq07D/xWPYnR4R2L7DsQjAb98GQH+XxmcpA54RPjx
         6tkCcsW8Gz/6tvs6FqerfEI8vOkN7lkHOFg/jMJewvQo6B7cbAhoF/EolmUOwtwjcXDj
         vXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9VcDy2eNu6zj3ojAJOI8YY4Y8u6xcG4aGKHl4udgapM=;
        b=EjNh0G2adNuywCUoNtj0VMjuWaIXuVxcGWm5V3TK67DGytb15DeUVHiyUqx+9uwf9O
         zGHMmMZIw5LZlNQjlVzylPbRMClNeVhhLQkOmx3Q5BHcezy6bBjZJpN03oU2ltNXF9ph
         nK0U/D1hU0fUAZMmfjD7j5hZeR2MlqNkIGhz3N9DZxcAXE+x8WMYqVq/19LysOLgcmea
         E2DDuQ5S0A8KUEsakhWzSqU3fMbK1WRhzrv4d6u0h2t2phRQ5dig46FbKTrAkFXeKIGf
         tyKZPPvFCX+3hKoGIv4ZbW9ErYvxLD3MmR4cpyaI9bPiGZa9rjnCl5jDjS2M15VR6Mr+
         5TCw==
X-Gm-Message-State: AOAM530v9P8aWtf8vK4BmHX5bq6Xd8nnZaKYF+y+SZIX0/O/2Lk+YuAb
        bNqVt1c4MfXDzNplHu0HZ4xomfCAviw=
X-Google-Smtp-Source: ABdhPJzsVdo9AHcpYNGJZibiNrkNLA6X3+BJ9fjqdBvI4f/NNLrt06Uv679Ra/o4jQoqWJt+wtgDPA==
X-Received: by 2002:a17:906:53c3:b0:6cf:742d:84de with SMTP id p3-20020a17090653c300b006cf742d84demr11800827ejo.576.1648220513889;
        Fri, 25 Mar 2022 08:01:53 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w14-20020a170906d20e00b006cee22553f7sm2455714ejz.213.2022.03.25.08.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 08:01:53 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ARM: dts: rockchip: add clocks property to cru node rk3066a/rk3188
Date:   Fri, 25 Mar 2022 16:01:46 +0100
Message-Id: <20220325150146.18638-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220325150146.18638-1-jbx6244@gmail.com>
References: <20220325150146.18638-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clocks property to rk3066a/rk3188 cru node to fix warnings like:
'clocks' is a dependency of 'assigned-clocks'

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a.dtsi | 3 ++-
 arch/arm/boot/dts/rk3188.dtsi  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index c25b9695d..de9915d94 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -202,8 +202,9 @@
 	cru: clock-controller@20000000 {
 		compatible = "rockchip,rk3066a-cru";
 		reg = <0x20000000 0x1000>;
+		clocks = <&xin24m>;
+		clock-names = "xin24m";
 		rockchip,grf = <&grf>;
-
 		#clock-cells = <1>;
 		#reset-cells = <1>;
 		assigned-clocks = <&cru PLL_CPLL>, <&cru PLL_GPLL>,
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index a94321e90..cdd4a0bd5 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -195,8 +195,9 @@
 	cru: clock-controller@20000000 {
 		compatible = "rockchip,rk3188-cru";
 		reg = <0x20000000 0x1000>;
+		clocks = <&xin24m>;
+		clock-names = "xin24m";
 		rockchip,grf = <&grf>;
-
 		#clock-cells = <1>;
 		#reset-cells = <1>;
 	};
-- 
2.20.1

