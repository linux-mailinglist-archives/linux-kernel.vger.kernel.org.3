Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AAF4EAFE9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238310AbiC2PJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238276AbiC2PJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:09:43 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566341EF5DB;
        Tue, 29 Mar 2022 08:07:59 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id lr4so27352892ejb.11;
        Tue, 29 Mar 2022 08:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k7V/AdbtuTpQjKQKuRE/DdQ8tDFVesLcfjc5DCvosMQ=;
        b=kGiY4tb+xGIQRdl+/8PFqwgQ4fTQZmhxcTdZuggrruf6V0o6YtxYMBesBVR2vAwWmM
         q1bfRdPTBBah2FodC+hww1SZCOb2DCWoqCAnUQwMUUbzLOZ4Xh9zjlbE9xdhmPrKrIRo
         MebMdMZfDuwbOJN/bTLxm/R9WHDXW2ybB/Oa5rKIsCQ8hNhHq/5yFTPjSv7hrVfNBtKC
         /h1NWty8q+WV2r7bg4mbyO3nb55uADLf8J+0MoWtRqnCzklkn7m8j6NV59lhuohT0rwB
         1UWgofotsBTExoauAmrTu0vWrf/uuX9cRkvN1lqar+kxgqTbR79h2j+KjWQiNDQcVA9T
         H5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k7V/AdbtuTpQjKQKuRE/DdQ8tDFVesLcfjc5DCvosMQ=;
        b=6oVyOd3HAReuKThxhyzlQGjFF0n5Y3Fn/ma1G7a6jcPtbig8bDjdDsrqGo0tjc5tQo
         AL6PndeZCsoY3SPsSM3KYkRkts/nHKt//Bkz7+/Eody8TxbPHhc0xWwManRzs9R2jede
         eabMyFaVaHGABP27cH0nM6jzvRjy6liJuh8omr0WIMz1XHcuGe1y0ShKHO00rLebMDuq
         8jnaF5ZPV/O7itROWEW+3Q0TPOzuxN/8JYTvvrpcH+kgpmTHU/+/tAnlqIX/p8+JNA9k
         5LxyCaOr0sEnhsgxHAmxyFDmMdo4eW+Rf/hE1yzPC/IVhXTKY3ATg0AyyzeyEyCXxJjq
         aBVQ==
X-Gm-Message-State: AOAM532DShXJAgBGf4g9cCTK8vOEkiTWaMDTkfKt1paIxjSF5LH4oe7t
        oaU8flrvdadt2Xwve923O6I=
X-Google-Smtp-Source: ABdhPJzXbIomNhFkSZPsDocHiKap3lA3plyPy2CFIhy0FEuXIDdP4JvO30XCZ/ljVHLEF0QyEYJz/Q==
X-Received: by 2002:a17:906:c0d6:b0:6ca:457e:f1b7 with SMTP id bn22-20020a170906c0d600b006ca457ef1b7mr35045283ejb.399.1648566476904;
        Tue, 29 Mar 2022 08:07:56 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id eq7-20020a056402298700b00419d8d46a8asm3261643edb.39.2022.03.29.08.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 08:07:56 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] arm64: dts: rockchip: add clocks property to cru nodes rk3399
Date:   Tue, 29 Mar 2022 17:07:42 +0200
Message-Id: <20220329150742.22093-6-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220329150742.22093-1-jbx6244@gmail.com>
References: <20220329150742.22093-1-jbx6244@gmail.com>
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

Add clocks property to rk3399 cru nodes to fix warnings like:
'clocks' is a dependency of 'assigned-clocks'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V2:
  add clocks to pmucru node
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 01c08a2aa..56af1a1d6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1416,6 +1416,8 @@
 	pmucru: clock-controller@ff750000 {
 		compatible = "rockchip,rk3399-pmucru";
 		reg = <0x0 0xff750000 0x0 0x1000>;
+		clocks = <&xin24m>;
+		clock-names = "xin24m";
 		rockchip,grf = <&pmugrf>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
@@ -1426,6 +1428,8 @@
 	cru: clock-controller@ff760000 {
 		compatible = "rockchip,rk3399-cru";
 		reg = <0x0 0xff760000 0x0 0x1000>;
+		clocks = <&xin24m>;
+		clock-names = "xin24m";
 		rockchip,grf = <&grf>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
-- 
2.20.1

