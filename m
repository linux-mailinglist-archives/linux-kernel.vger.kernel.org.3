Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F4B511F55
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241334AbiD0QCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241239AbiD0QCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:02:23 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EFF16B1BE
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:59:02 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id y3so4275659ejo.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eKvDuuB9QgS27uH7omTMpe+GPkov4ZRdj/Xw46TVghk=;
        b=Xj4JuGcggLnu/0KkPElctnR4Our3/z/gp+RPHn3BZYUOLqE4ghTux4rLELcw722Rxq
         Z3J4uXVYrZHPx3n6yNtdGJsn2QgJ4sF3j5ltEMKJCoKumElPOl1yGzHujd4fXNrolRIo
         f3pnaY+xyxM6XMfo26fNrK6k8J7DBYllNHEEf7YXbKzPTat0ealbgKQxyj9BRJ20EKA7
         P5RcEJJE3B+3Ej10xzgHR2jJg+C6UPQ9LWd2hzDKdJOzdhK48w8IJIaJqJYZMYenBJxQ
         sZkrmkRERanjdlFvTGQ+qmtvEE0V3LnjT0liVNOVsfQnclVRMF2OMnt1lQ13PpCfhZzT
         EYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eKvDuuB9QgS27uH7omTMpe+GPkov4ZRdj/Xw46TVghk=;
        b=M22GWIWDFWEUB/8XxMHN1ECvEEGCM19FJ6ZJG7aNQcjuDOr67XErgLei+xXc7h3qGb
         JhEVGffXcnYdBqEgKhBG3Pn6tsrcX1ESPj0fPSOMN0pk3xEsA6KGEDXjclCtpyguin0+
         k9N4ARH6kKo16BBBPICNG2UO143LggTT9+2Glx8v1E3T5gLZE8YAGj2DYr75wSEmPYkC
         LYk0nnlsRtsnqh1JYJYOcaHnXAVukctzgVqGx6Di+FdzaC0e+yfhXuvH7l/UE4fO/zAA
         lB8aD1S/vf77Yj59Aa6A3BtsX/3xl2/3tNdJG1l8gJ3vzF9AbBf7ZAbcsv/HLZbo+a38
         X3Rw==
X-Gm-Message-State: AOAM531UwSX7iFum6vox2evglVA6e21DuXKuo2SAB+6dEMtuf/+K1N4g
        fWMf/AVMmEuw63/k06i11kS8CQ==
X-Google-Smtp-Source: ABdhPJzUU6FhLxV2t/BOpMHiXfLyUyiy2Pp2RkecMzFq2opxeB5FMpvjvc+/h+NzLAfoXNvF4CQQNQ==
X-Received: by 2002:a17:907:7eaa:b0:6f3:bb9a:7f39 with SMTP id qb42-20020a1709077eaa00b006f3bb9a7f39mr6900446ejc.233.1651075136200;
        Wed, 27 Apr 2022 08:58:56 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l20-20020a1709062a9400b006ce71a88bf5sm6931993eje.183.2022.04.27.08.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 08:58:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 07/10] ARM: dts: s5pv210: use proper 'dma-channels/requests' properties
Date:   Wed, 27 Apr 2022 17:58:37 +0200
Message-Id: <20220427155840.596535-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220427155840.596535-1-krzysztof.kozlowski@linaro.org>
References: <20220427155840.596535-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pl330 DMA controller bindings documented 'dma-channels' and
'dma-requests' properties (without leading hash sign), so fix the DTS to
match the bindings.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/s5pv210.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index ac281f42e8f5..f6988ba3393d 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -125,8 +125,8 @@ pdma0: dma-controller@e0900000 {
 			clocks = <&clocks CLK_PDMA0>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
+			dma-channels = <8>;
+			dma-requests = <32>;
 		};
 
 		pdma1: dma-controller@e0a00000 {
@@ -137,8 +137,8 @@ pdma1: dma-controller@e0a00000 {
 			clocks = <&clocks CLK_PDMA1>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <32>;
+			dma-channels = <8>;
+			dma-requests = <32>;
 		};
 
 		adc: adc@e1700000 {
@@ -526,8 +526,8 @@ mdma1: dma-controller@fa200000 {
 			clocks = <&clocks CLK_MDMA>;
 			clock-names = "apb_pclk";
 			#dma-cells = <1>;
-			#dma-channels = <8>;
-			#dma-requests = <1>;
+			dma-channels = <8>;
+			dma-requests = <1>;
 		};
 
 		rotator: rotator@fa300000 {
-- 
2.32.0

