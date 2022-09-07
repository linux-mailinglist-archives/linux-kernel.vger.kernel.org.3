Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0F65B04E5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiIGNNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiIGNMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:12:52 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BCB7F134;
        Wed,  7 Sep 2022 06:12:50 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b17so6992085wrq.3;
        Wed, 07 Sep 2022 06:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=LwR7/AOTal+NwY86Mp0FPWEx+VIIdg+npTDhkz4uRZA=;
        b=j9qF+fk8yh03/leBQqIXtPMvvBhD5gSXNrahxJyOe9cRJ6n5TD/11Wq8it7YInP4Sq
         9gBLObzPvIVgluWs5kKyquuPe1KuZVirw/j2xrUL5c3J6Bj8wlij7lYTMG/YKrdzgL6n
         VFKyBpEeMbBvsfI49oNtmBMQtvCTIz3+hk4OcHXlraNnOLc4xxMDEe+nID7kBgemXQ/m
         rQfeOhYr/0l9h83oswFfP40PPW8GAAB8Lt4cLHIMx0TFFKxzM1ci7zgPL84xlqmRw6zk
         pmcxGOmtUrpDQn8pPLj7SfRi4mGL3xiiup6KJIZkGqk+0O2QG35GoM+kP4kM0RS7oAto
         Fsjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LwR7/AOTal+NwY86Mp0FPWEx+VIIdg+npTDhkz4uRZA=;
        b=lOtDU0kz93p/WxYgf3BJfPlhC1ZgY4BAzCdY3EzoIbBdkHxixdKo7yDlrf/YYRB1ii
         36oUFGE2gEiY2AEn2cuHz8Zcl0oWaiN9s9SmCemgQ/q+AyTkaGq5tR8r1UYW1Eda66ly
         VwRpr0DVWFHZ/4ftg/M7BFs/aE9p6MK0BeN1l9D6Q3GqY8BdZwV1WLmmrZDWTGQv45LW
         mvsuZV4QN0qKB0Vp1g94NmS6+2TKkpFpot1CI8fvI4o7Foa6Yoy3cXPHRLmMW+KVf7td
         wWugN+RP+urUkPtlLMh9UhbMKvieVqvJGHAPsPAxI4OGTqDqs55Rnj2Vl5+zJeK01v8h
         G7WQ==
X-Gm-Message-State: ACgBeo2HlgfsRE42+Pp5lqVPtEGfVVT+h2/HbUh910tYR4+SnwtiEGF5
        imIG5GRvtPQFJymnxypYhnI+9LVwJzw=
X-Google-Smtp-Source: AA6agR4V8GZNQUSgq/mg1BWNRizQZ43PEteRk2TrUnEBu3a9kle2wJbkTv937CeaDzNABkhdnSQ9jQ==
X-Received: by 2002:a5d:6388:0:b0:228:c792:aabe with SMTP id p8-20020a5d6388000000b00228c792aabemr2041911wru.689.1662556369167;
        Wed, 07 Sep 2022 06:12:49 -0700 (PDT)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id t4-20020a05600001c400b00228aea99efcsm10398230wrx.14.2022.09.07.06.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 06:12:48 -0700 (PDT)
From:   Romain Perier <romain.perier@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] ARM: dts: mstar: Add pwm device node to infinity
Date:   Wed,  7 Sep 2022 15:12:39 +0200
Message-Id: <20220907131241.31941-4-romain.perier@gmail.com>
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
 arch/arm/boot/dts/mstar-infinity.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-infinity.dtsi b/arch/arm/boot/dts/mstar-infinity.dtsi
index 441a917b88ba..752f4c26b31c 100644
--- a/arch/arm/boot/dts/mstar-infinity.dtsi
+++ b/arch/arm/boot/dts/mstar-infinity.dtsi
@@ -38,6 +38,16 @@ opp-800000000 {
 	};
 };
 
+&soc {
+	pm_pwm: pwm@1f001da0 {
+		compatible = "mstar,msc313-pwm";
+		reg = <0x1f001da0 0xc>;
+		#pwm-cells = <2>;
+		clocks = <&xtal_div2>;
+		status = "disabled";
+	};
+};
+
 &cpu0 {
 	operating-points-v2 = <&cpu0_opp_table>;
 };
-- 
2.35.1

