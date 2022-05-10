Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5930F5215E9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242021AbiEJMy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242013AbiEJMxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:53:51 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272E41CEEE5
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:49:47 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ch13so4293900ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0ADwZV9MCiaFxJJZiEcHrqujdjNo6qrms2LEfpU/gHI=;
        b=QuKKYpmHYkCBDiSsS8UgFbXwel5iOAya6SX4eoYZ7G0KeEpckN1Wp1C4wVSmXiMcfX
         8ZnKsInAtFO3og1uJRwQ3TT1zDoLOo/rl7M1goYLZc1w2jnEp5ZAdfUW2zr1Jlxe45De
         Ji8nIbjAwHUQK9Y2WmjJWFAMZhF04S+d1VS3+NklKV7wb31vICdB3cpFTYJ+SP4TECKL
         SVlXKwSU7oI1SkVQw2IYlHa1KU0NVkIRLu1DjIBy5uF13fhTWziXNkbXWOP2qZWnA0DP
         qQC2O2z6UBWvxXysOjb9nb9S5urG/5eQxw17McRSxGpq9cG8IK8roXr88UNlxmyKLq40
         5slw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ADwZV9MCiaFxJJZiEcHrqujdjNo6qrms2LEfpU/gHI=;
        b=5Quw0d3KOVJ+TifMkwtq98kydcaaGAFX4Ufh5JLoOWKaFTZ1ChrkKIaV4OcpAAqQg1
         YHGW3/QEd4KTwCcgTBZ2QeHc8j1KlJ2Pr/MTK0pDClqFPf5c5XUT4UlrpDPVFW+QHj4+
         ugaAlg3Kz8PxtpaHG0UDvgMXaVanPhWbbo8gXLAdDBad7chXepxk4lFRdKAcfn/DMa4+
         7Hrr92JXz6fczfEcJLKTZl5ayKp2aoVejsJJUC/ky/wdcS9/OVc9UJevSVgZ3ViR9FiW
         0Lf3811/XCivyZvY7hXDCdIaZGWwY1QryMMPOA/Ts6Z+ifCY0hSmnyelhpL0dwezr2Bx
         KDpA==
X-Gm-Message-State: AOAM532HGOBZkysaH9TNcQnNle2Krbz3dIWeZMwaFNPzUgldXh45NHD8
        CU37cC5XlelIYjzLk9rYwY1CJQ==
X-Google-Smtp-Source: ABdhPJzsn4gIO8im22/3o9qagAgl1LvoFHePz3JQWJJLiJ9vhXW/Xfi1FXsW3f31pjQpDBup/gXChQ==
X-Received: by 2002:a17:907:7f87:b0:6f5:1c31:6b6 with SMTP id qk7-20020a1709077f8700b006f51c3106b6mr18575887ejc.248.1652186985606;
        Tue, 10 May 2022 05:49:45 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-75-cbl.xnet.hr. [94.253.144.75])
        by smtp.googlemail.com with ESMTPSA id gz14-20020a170907a04e00b006f3ef214e62sm6094290ejc.200.2022.05.10.05.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 05:49:45 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, kostap@marvell.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, pali@kernel.org,
        marek.behun@nic.cz
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 07/11] arm64: dts: marvell: uDPU: remove LED node pinctrl-names
Date:   Tue, 10 May 2022 14:49:25 +0200
Message-Id: <20220510124929.91000-7-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220510124929.91000-1-robert.marko@sartura.hr>
References: <20220510124929.91000-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using pinctrl-names requires the appropriate pinctrl-0 property, otherwise
it is not utilized at all.

Since its not required, just remove it.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
index f216777acacc..b89c7455612d 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
@@ -28,7 +28,6 @@ memory@0 {
 	};
 
 	leds {
-		pinctrl-names = "default";
 		compatible = "gpio-leds";
 
 		led-power1 {
-- 
2.36.1

