Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE674E3D11
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 12:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbiCVLAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 07:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbiCVLAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 07:00:35 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7996A05A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:59:07 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id pv16so35424714ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yUV+b/24xEACk54GkH3HnyPW/i5kMSOMbJxcMoEhFbg=;
        b=z3cIP7tDUi1vx9Prw83mi0aKnubO4pri0gwbgIZWm590raPVm+XW30qFK9B4C7e1Ml
         MY+B3vpgNc+ZVqMTXMCdQq4CEy39Ue5KVRbaRpN8urimYzSZdgQAGkKNFxxax9a1+Up4
         AkOTXmQ70aPVUy0z4572x+EXH9Zv7PPO4Y/bt9YYgkjc+QnTBt7WvnYOevY5rwqkgNIN
         BTltRkACgOlvpV60U3rzJ2e1Pa2vL+GCaEE+3R9QFE/jbop04N5/fW02Q1oFN8wckNDF
         hQxmpxIIhX01aigTA/FJAEDcfAYZogZpPCqMERliAZ37NY9fbKrGGd29qglVvsAddpll
         lfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yUV+b/24xEACk54GkH3HnyPW/i5kMSOMbJxcMoEhFbg=;
        b=04AwltltvyywdRDaILJS9R3n2LMTKb23cMDcIuLfpyJsXpoR3hiiM1XudgS4Z+rdd3
         0+5SHnl5c9yduHkwZ1zV+V7KsQp/FgsuO1+mlAljYz9doBTK3B/IcWq4m/pxF5iaFGku
         Ox61QOyN/IFvVN34c+nga6ZNAQu38JJ6XMA8EImrckzilGdig7zoxf5ydHiV1juViT8F
         /tupw/buqQPIKuKJZshTwychbJvAnRz8EnCmAOdllLc0oOpQYw0bij7xIyjbWR2CRW6o
         1uALXIXRHszumydscdZXST7SWMNc/v3Uf6JUn6ylHstcNpEmoiWEMfBKaEl2n8ujGlnF
         rf5g==
X-Gm-Message-State: AOAM530ly/a0Oz+J2zuL6a9BA1eYaPCvmoLj/IWCbnJksq9m8YGXIx5o
        O5uudI65XikvvidYGOczAFjn/A==
X-Google-Smtp-Source: ABdhPJybvmrftgNEY7e5v4fLGu8QcpLRxL2IW7FJxva/IwfaMih5qFOYP4MyoNCVcUl1M7Tmgy1wsQ==
X-Received: by 2002:a17:906:dc95:b0:6df:d2cf:4d93 with SMTP id cs21-20020a170906dc9500b006dfd2cf4d93mr14794452ejc.66.1647946746489;
        Tue, 22 Mar 2022 03:59:06 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-57-cbl.xnet.hr. [94.253.144.57])
        by smtp.googlemail.com with ESMTPSA id b7-20020a056402084700b004190d2fc521sm6150240edz.89.2022.03.22.03.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 03:59:06 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, pali@kernel.org, marek.behun@nic.cz
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 2/2] arm64: dts: uDPU: correct temperature sensors
Date:   Tue, 22 Mar 2022 11:58:57 +0100
Message-Id: <20220322105857.1107016-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322105857.1107016-1-robert.marko@sartura.hr>
References: <20220322105857.1107016-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uDPU has a pair of NCT375 temperature sensors, which are TMP75C compatible
as far as the driver is concerned.

The current LM75 compatible worked as all of the LM75 compatible sensors
are backwards compatible with the original part, but it meant that lower
resolution and incorrect sample rate was being used.

The "lm75" compatible has been deprecated anyway and is meant as fallback
in order to keep older DTS-es working.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v2:
* None
---
 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
index ac64949bb53e..1f534c0c65f7 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
@@ -153,15 +153,15 @@ &i2c1 {
 	scl-gpios = <&gpionb 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	sda-gpios = <&gpionb 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 
-	lm75@48 {
+	nct375@48 {
 		status = "okay";
-		compatible = "lm75";
+		compatible = "ti,tmp75c";
 		reg = <0x48>;
 	};
 
-	lm75@49 {
+	nct375@49 {
 		status = "okay";
-		compatible = "lm75";
+		compatible = "ti,tmp75c";
 		reg = <0x49>;
 	};
 };
-- 
2.35.1

