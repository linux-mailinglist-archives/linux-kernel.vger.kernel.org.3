Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5D24EC1F6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 13:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344668AbiC3L5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 07:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344441AbiC3LxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 07:53:10 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BB1262400;
        Wed, 30 Mar 2022 04:48:56 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bh17so1480213ejb.8;
        Wed, 30 Mar 2022 04:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H5VTVLY2z6i13dvk5wtcwbzRR2pZJCvwJwdziJVAOMQ=;
        b=HCuend+++KI5ObYAh+8oGZAuDnrsOdDn31plrdpo+Fo3t+SXVujiaqqqU0MKgsq87H
         pHBc9cLbcal7y/FrS2eKcC3UJcA4YbCxtd1qqWKu/MxLiV09sKnz8GA6wy+zojN9+qdl
         9X7RAOIWpv0KDT28qgzszlANqnPO8kyR1qWdms6+iiLhiP8r/fObG/zj079XptDkTJP6
         uSHc1hiHqfiBWa9ICHDT8AvNYMlY2VeW2NE9M0IMexANL8oveZG0eeVHDK1VEsN2gPSv
         WpSpcvLyl049ozh7gqbu9t5c8WbbAYqB+PnY2dktwzYB7a4/AqFp+dg8jizIbBrmhB+3
         Jagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H5VTVLY2z6i13dvk5wtcwbzRR2pZJCvwJwdziJVAOMQ=;
        b=syJkl0AUFQGlFbiKZw9d6y4ewrIjTTl3xBB0NoaqQpDmdoqzbfSo7XqksYnKbIe3QL
         o1tcwzx/MH0uFrDVZzLLtAoaIMjFkazhKHv1BMMvfIDgDtR6xq/zborb8ZGJGxxBtvgk
         VtatZ/rnycpWWegaBh7i1SZMEr3DaedjARkkiQpHLaZplnftTKuLezn7USyLj3OG9M/1
         mwAmlkKp14rJR9AQHIapV8QrlhCHygedo+TqwFDVXfMo2uypS6vFMAOmpfLfY/Vsm5PT
         AY742nGPvmFkS2UnN8sDRpGpYKbx7rBOWuHYpXMgjrHeVFmDjBN6FzwBLg8+E70lURVG
         sZnQ==
X-Gm-Message-State: AOAM531Ys+x5YwMQjh3zD0zgi7BGzAyiW3gezHhizk3mN70x+pIOtYow
        MxWLrfwGz7OSigC3yQz1MXU=
X-Google-Smtp-Source: ABdhPJw/Xl9g3IPsAOoM+4M6ZWl9RbIh1DIkd9VFUCU3+dZWBzlI38COLdIRHgd0iJ07HnsdsJadeg==
X-Received: by 2002:a17:907:8690:b0:6da:8436:2b94 with SMTP id qa16-20020a170907869000b006da84362b94mr39851667ejc.33.1648640934543;
        Wed, 30 Mar 2022 04:48:54 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g9-20020aa7c849000000b00412fc6bf26dsm9934442edt.80.2022.03.30.04.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 04:48:54 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] ARM: dts: rockchip: add clocks property to cru node rk3036
Date:   Wed, 30 Mar 2022 13:48:46 +0200
Message-Id: <20220330114847.18633-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220330114847.18633-1-jbx6244@gmail.com>
References: <20220330114847.18633-1-jbx6244@gmail.com>
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

Add clocks and clock-names to the rk3036 cru node, because
the device has to have at least one input clock.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3036.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index ba2b8891b..3894b8d2e 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -330,6 +330,8 @@
 	cru: clock-controller@20000000 {
 		compatible = "rockchip,rk3036-cru";
 		reg = <0x20000000 0x1000>;
+		clocks = <&xin24m>;
+		clock-names = "xin24m";
 		rockchip,grf = <&grf>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
-- 
2.20.1

