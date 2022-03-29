Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C867A4EAC06
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 13:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbiC2LQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 07:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbiC2LPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 07:15:51 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1156745042;
        Tue, 29 Mar 2022 04:14:08 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id a17so20279835edm.9;
        Tue, 29 Mar 2022 04:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9VcDy2eNu6zj3ojAJOI8YY4Y8u6xcG4aGKHl4udgapM=;
        b=V5QsH+2onl3V2K7/qMMnP3xRE7D2OQSwXl+udTtOIeKGKu52DRJkFiQs9pRlTb9VXz
         MUIL91319MYihfoMWGVum2bYCPSgWBUy6xbVZ18NfDwN7VpUroxuxcFaxkO/ckvIxkkc
         LdbvnX1OrkJHaXzW4yscUl1oxvh9YvXS4Tu+hSRKa6kfy1iRouEfI/tB0n3IF8GYuUN9
         7Z09PAnMGQ6A3SIgNXVVsVSMrD6dqav7oCZQuNKV6BnnTkYo/cftyq9FxOPcxdqx6Qvb
         aUhj/8KducT6DxqRjlUUUbGdD4YqCUmisPnGr3DS5tTKFvx3WKTN4o61RoBngQOXEzr2
         np/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9VcDy2eNu6zj3ojAJOI8YY4Y8u6xcG4aGKHl4udgapM=;
        b=1wWRl7rzLCAznt51klJkiLxlTpEkLRZ2cMzzubPnhN5z/DVjlHA2o+KlX0kx5Hl1Ia
         H5T75KbzEvbf6DFPPBYkGmHTLlfyTiJUuRr/B6ZU2qYcjT/efIWATGTmugus8ePQ5ZdJ
         oWJjWb9J1New+BEtuFNI326Pd6rTmwdfmVBCge4CDfqtas7AeEXwgE2yiKMHfgAzF+mt
         wbKr1WYm2RSWH9JnmWZbExr75iEnwQI5ryEMx41nCX2Vzwf3gvI1vxODxg1M3p7CsEo9
         5qJHODTVSuWqnu9r4VpS2sNqwlaYrni7IT9GgkMIbst82/tr2onf1V+el3m8DTTQqfrv
         XukA==
X-Gm-Message-State: AOAM531ajeNMFPt81fIhdAJq5MOSGCoA0yUIifryRLLsVk+g0EZvH6Vq
        CWuN+zvOXr6hlwxUlViK+3Y=
X-Google-Smtp-Source: ABdhPJyGYRSeP/JOed6F3ZwWdEuBiK2pphyO1xSQQf4WX4orYSxfJ8d/HQYcUZ58o/BQHrXIji52Qg==
X-Received: by 2002:a50:bac3:0:b0:418:edb0:4ae8 with SMTP id x61-20020a50bac3000000b00418edb04ae8mr3749755ede.219.1648552446475;
        Tue, 29 Mar 2022 04:14:06 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090657c300b006d01de78926sm7006844ejr.22.2022.03.29.04.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 04:14:06 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] ARM: dts: rockchip: add clocks property to cru node rk3066a/rk3188
Date:   Tue, 29 Mar 2022 13:13:23 +0200
Message-Id: <20220329111323.3569-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220329111323.3569-1-jbx6244@gmail.com>
References: <20220329111323.3569-1-jbx6244@gmail.com>
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

