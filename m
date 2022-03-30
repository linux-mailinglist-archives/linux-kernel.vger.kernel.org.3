Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A33D4EC41E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 14:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbiC3MeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 08:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiC3Mds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 08:33:48 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D87F6C909;
        Wed, 30 Mar 2022 05:19:54 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bh17so1646405ejb.8;
        Wed, 30 Mar 2022 05:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qb8HyCCIY1mm75j/97/iX1g/WJo7T0j9+GwbZZhw4sE=;
        b=DKRaoGpGxTy/s0SW9SYdZjbpJyfAQTHQy2WwEfeo1cOw0oE8dRay+/FVp1oOYl95Oc
         ZHswDuR5Rz5EBcejVNc3Ckx5EP//CJ+8HLltn+DZzBiyxn1e1s7vowefVUk1/dj9YLRX
         tX80/29BV0pPDv2+QZz+fco65go/6WuR+aeCmPHys8esvzcU0esgQxz+10T5TZjVK/X1
         yQCoJUj3/OeA+kdd062qXk3HEtzk+25MW/bozw6bzEI4a7LS4brKKCog5r59DqYzdtsC
         OnHlluEQGcSxqx8pfm+D5tmkzayeh1Qjb/c4JMRD46Vwm9O1wBkw9SZPX3WFt/PMAod5
         gzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qb8HyCCIY1mm75j/97/iX1g/WJo7T0j9+GwbZZhw4sE=;
        b=3ZE5F8rEA16oaUOEiXvxL0ZG7vhcrXQst8/wXTjWmzc58w/5x/TlJMshsskXmw3wck
         dqe87LdnZZamhSFuu40o2ppydXEb5EgjUaLEgaXDmtNUP3B5UrZ7GTtJ+l0fShEYyMUP
         djZKjOMzEj5xufGzhb5vzuWa8Nqth4NP/bSGrth1eXy4J/4H1QrRo7u69Jp7x4B6oLji
         bSI5W9kgUCzqa84A4RiropUlGxou46veQgjj10uRkgNsoel86zNMUBpZOBLLBkhkL+Cd
         VSAL3ydRpksuL/2nDATlDahEUi16hZN2l5mdnVxI+TquDj2qmRKiVBspVqD8fam5456r
         6MKw==
X-Gm-Message-State: AOAM530TwAW6oacHcxawXyZhUj8qCn6yvpJ8xkxSer3wVpu3L3dkwtY+
        P7SQk4PgBPIb8HPwHMXKibY4M1iTHsE=
X-Google-Smtp-Source: ABdhPJyJmqcIe58bIjV2K/BFgQhWOAt68nvMsEyokZxKqnWQPPNwBIVmAz2ndEks7uramUzGlUdu7A==
X-Received: by 2002:a17:906:c10d:b0:6e0:dc2a:338d with SMTP id do13-20020a170906c10d00b006e0dc2a338dmr24335993ejc.538.1648642771254;
        Wed, 30 Mar 2022 05:19:31 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id j21-20020a170906255500b006e08c4862ccsm7288778ejb.96.2022.03.30.05.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 05:19:30 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] ARM: dts: rockchip: add clocks property to cru node rk3228
Date:   Wed, 30 Mar 2022 14:19:22 +0200
Message-Id: <20220330121923.24240-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220330121923.24240-1-jbx6244@gmail.com>
References: <20220330121923.24240-1-jbx6244@gmail.com>
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

Add clocks and clock-names to the rk3228 cru node, because
the device has to have at least one input clock.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk322x.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 5868eb512..2547f46fe 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -484,6 +484,8 @@
 	cru: clock-controller@110e0000 {
 		compatible = "rockchip,rk3228-cru";
 		reg = <0x110e0000 0x1000>;
+		clocks = <&xin24m>;
+		clock-names = "xin24m";
 		rockchip,grf = <&grf>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
-- 
2.20.1

