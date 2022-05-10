Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2E85215E5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241593AbiEJMyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242000AbiEJMxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:53:53 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A0324F0C6
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:49:48 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g23so19864054edy.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iyLgDkdQHyZAkcqdjwAb1osRIT28CWJKpvenchINumw=;
        b=S/9C6tTjilIllx3hKGjNVbVdwZE/WIwdAeaCq1DAvhD68dTpygYBIViGwpw/qYEm/F
         D2+BYp8ClIZsXxjFAElPR/gb9v1BZ5u4Oa0k9IQftWPDhB+qaIWMb1td1IEbXoPGGr7K
         nGjzvq8zXpKFes8c49ovWhSJH/2f8Cc/ecz9OEnosg8LCL50Ukg0we4phakU65/4Abw9
         JfxhOTQgmPqNK9aJHAiTq3eN4tpX0eFH4AURlzFLc0bUF48h+w6mPMeAEl/4Kac5evyZ
         KwqLVLHTM4JR8TvXRSF1uwPulxIGrH1jxHrztGPTMMSDxhlEe5vIB8oVhtg1I3FvqUxs
         Kyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iyLgDkdQHyZAkcqdjwAb1osRIT28CWJKpvenchINumw=;
        b=VGrpQekQJnFUFz+RLXvzeXroXv0Jutg90Nub0auhDeEifC/t319q2G85DFf15J5Edg
         N1ke7jnZh3UVSbwLGEz9J2Y+EQdXCLDkQvIojFrrcgCFhgfLIZrSx/pHPlvCUG3cUnce
         rOQwI90mvhZfTOywo3V98Vm3fVRR8nIcI8ABNhLs29zqzqnskxE02lT+9kppxLkuO08E
         HniIC+/gZGCYBcAVKL/F7dooKOohZIdZb1rCBECUJRqwUq5GrfBUOBc89Amxov7pzvk4
         5hYk3OuY6MwAtKzHIfkIAUsN3NGsZVPA+3/Blb/OnWQxa38SUnx5ZisLSVfRCdl/GvnL
         EeFQ==
X-Gm-Message-State: AOAM5323ItjbGtqmMTnAR29fCVCLWomJ5Nien/hRviQaM9XxWuZ66pmK
        z3X44AYRa8JfAqaOAt+WqAdllg==
X-Google-Smtp-Source: ABdhPJzdd4GU8i6g4QDB7KWJtBGH6JkMQiZ94Gq0JHyrk0grWZX3gGVCXrte4xYxoQY+Uz8PJW4+qg==
X-Received: by 2002:a05:6402:40d4:b0:427:de1e:6ce0 with SMTP id z20-20020a05640240d400b00427de1e6ce0mr23222198edb.227.1652186987212;
        Tue, 10 May 2022 05:49:47 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-75-cbl.xnet.hr. [94.253.144.75])
        by smtp.googlemail.com with ESMTPSA id gz14-20020a170907a04e00b006f3ef214e62sm6094290ejc.200.2022.05.10.05.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 05:49:46 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, kostap@marvell.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, pali@kernel.org,
        marek.behun@nic.cz
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 08/11] arm64: dts: marvell: rename temp sensor nodes
Date:   Tue, 10 May 2022 14:49:26 +0200
Message-Id: <20220510124929.91000-8-robert.marko@sartura.hr>
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

Rename the temperature sensor nodes to use "temp-sensor" which matches
their device class instead of IC specific naming.

Remove the status = "okay" which is not required as its default anyway.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
index b89c7455612d..f21a855fc608 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
@@ -152,14 +152,12 @@ &i2c1 {
 	scl-gpios = <&gpionb 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	sda-gpios = <&gpionb 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 
-	nct375@48 {
-		status = "okay";
+	temp-sensor@48 {
 		compatible = "ti,tmp75c";
 		reg = <0x48>;
 	};
 
-	nct375@49 {
-		status = "okay";
+	temp-sensor@49 {
 		compatible = "ti,tmp75c";
 		reg = <0x49>;
 	};
-- 
2.36.1

