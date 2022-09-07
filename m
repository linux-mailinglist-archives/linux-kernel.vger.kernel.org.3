Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F9E5B04E7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiIGNNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiIGNMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:12:53 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB3A7F267;
        Wed,  7 Sep 2022 06:12:51 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so9476565wms.5;
        Wed, 07 Sep 2022 06:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Cg9l8Dw5kbbaSW9iT/X0V7LIeInZuZuCPQHiyAl6l3A=;
        b=WaxsfxNy7+St/xFCEq7LB6yj5uX8QOofkkoPrnD7B01kaNBbXyjj14aMyijZX9eI5G
         iTmj9nFSUckNUW7x6cceUhVqxFrMHXAkuc/ztty+ZyEbCsXSsmcx5AxBjdSp89FUA9F1
         O0jIG3qMaAyESeUqR1waMk7oXzcKR7QKXuFKWlWNH6Lpl4nknF6Lt50ejCl9RCw6I4BE
         9/aDHlEYQK+PIvnT0tiobQZlvZhPZRGrx9JqRZBHdcS36UN89+FjwQjiImsBYTXq/ZSr
         hJYCR+MUlUUq1z8ZQ295H6dcYKc+vqxdJu9Dyx/1na33KCB09LznhkMcjeY3FJCkOQJ9
         PhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Cg9l8Dw5kbbaSW9iT/X0V7LIeInZuZuCPQHiyAl6l3A=;
        b=k8NJ8zo2wjDyFhawC74tPYxPebcpa1dFoSrO/OTO0JZQ5gZ1C69Bv8EyqJ4d0LuMRh
         2rm2S4vOvDD9+uM5Thxb8kaARqCO9LuygfnuCapoKfxms4M6R9PRJgyrFoXC8q7EI0PV
         0thPOcch4YuUKJoz8v7tMBmUmI8eFeepkcKFq+RHytL2IyatGydnZ12In+rTB+tgNuYU
         zj8qjmpO+DBmZUKTbC5JIqlg2lvZwoE8/5Ms5C95Xf1HHydqMF7L+kvFDftIUdoGqRM8
         A/Mx1uHJv9Uh2Yn488jz167O9QEn05a60WAH2k0xhNRZpAcqcs/t9bZiqp2dp7HZ0P4/
         Sy+w==
X-Gm-Message-State: ACgBeo3mazjvrEr/8kQClEkrsw5HqOgiScOHHp4A+bOEtu9+SGxYpv3a
        hZiOd2rTVX2kysi0mqfOuHwPU7zdTyc=
X-Google-Smtp-Source: AA6agR63JPlJ6/mZi4VqQFezZCqRtSgr+iT8vrl1gV+TaEHGA7RlV1QdCx55mc8jEd6KlXF3pkuycg==
X-Received: by 2002:a05:600c:34c2:b0:3a5:d2f5:9d02 with SMTP id d2-20020a05600c34c200b003a5d2f59d02mr2083482wmq.153.1662556370181;
        Wed, 07 Sep 2022 06:12:50 -0700 (PDT)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id bh5-20020a05600005c500b0021ee65426a2sm16745847wrb.65.2022.09.07.06.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 06:12:49 -0700 (PDT)
From:   Romain Perier <romain.perier@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] ARM: dts: mstar: Add pwm device node to infinity3
Date:   Wed,  7 Sep 2022 15:12:40 +0200
Message-Id: <20220907131241.31941-5-romain.perier@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220907131241.31941-1-romain.perier@gmail.com>
References: <20220907131241.31941-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the definition of the pwm device node. The PWM being able to
work with the oscillator at 12Mhz for now, it shares the same xtal than
other devices (rtc or watchdog for instance).

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/boot/dts/mstar-infinity3.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-infinity3.dtsi b/arch/arm/boot/dts/mstar-infinity3.dtsi
index a56cf29e5d82..aa26f25392d0 100644
--- a/arch/arm/boot/dts/mstar-infinity3.dtsi
+++ b/arch/arm/boot/dts/mstar-infinity3.dtsi
@@ -67,3 +67,13 @@ opp-1512000000 {
 &imi {
 	reg = <0xa0000000 0x20000>;
 };
+
+&riu {
+	pwm: pwm@3400 {
+		compatible = "mstar,msc313e-pwm";
+		reg = <0x3400 0x400>;
+		#pwm-cells = <2>;
+		clocks = <&xtal_div2>;
+		status = "disabled";
+	};
+};
-- 
2.35.1

