Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40C1517DD9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 08:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiECG5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 02:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiECG4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 02:56:18 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FAA19C1B
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 23:52:10 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id a1so18842934edt.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 23:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/UG9U1ssyGyXBJOIuXlFbET9WoyyLZeeaMDTGwPECB8=;
        b=aFriaboHlOZNMvxzii9ge0kWiDCa70MwB6BRx0gmlfhd0zScqHSUTQur8tgWlmpB/C
         9aeAi9l0ji+ic+NNN3q7bK/Ua1Q2d2hobjuisqJkNHGNreohmI8x77hsxDFGu1X2lzKE
         jvPrhggSgQ8/grb4TeFHXAyFQD+r/EhTWrlmNMB4QGaFsFnxL5UceuPSuzS8L5IeiIZI
         qa6hu6DbU5M9GFzLg9DwZiajSCXBJDlllOWpxvIz1Q456xNdglVMJBfZiEAsK1/OiL8g
         fSwsyEUZDlbyJyrJzdKgje/8HiQDjo4tqjK6RXNUg/JRdp91IUyqmKItgLDoPLXKbK19
         JbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/UG9U1ssyGyXBJOIuXlFbET9WoyyLZeeaMDTGwPECB8=;
        b=EXQ3S0dyz72AXLMgwCP8qPUwhSbNJQMGc7H7I0aiAt9fUZGEHswqLL9hGbNgnLQve8
         fi4Toat1MOmo2WNKHsHQBYUPg6KkdYNW7JlsopdFOBdZQAl3+TgYDBv0GZajgDHOH9vG
         JKgPSbMOavc6d9k5ENl9ZR+USLRa5vtBJ5VAIfsmae3oo/rmj1pHyM/X2JHZz5P3Py6j
         lktyHxm8Q12hUzcm2XqpZsEkaaGsJkdnUFawjOmVK5gNACppAiRLio+aoMmQGJcde9OS
         uSTyltNXLTU6eM33aO5yHpjhPfGmk/25VMLP/4umeGGEERKxOglKK11ONmAd6QdpnOVF
         qnbw==
X-Gm-Message-State: AOAM530GUYKtkZcshiE0mq4o9dFlwMC5xJhfixwfarfmkQ7Mqxf9rZnX
        FZQgPLxT9yhw/1+IMpItXRIU2Q==
X-Google-Smtp-Source: ABdhPJzJYQyFr1obXkX9xgodEsn4UhTcBKKv+htlYUnwu8n3fxxtBVxqleymuLD6Ot339IaRDc/bVQ==
X-Received: by 2002:a05:6402:5242:b0:427:cade:4737 with SMTP id t2-20020a056402524200b00427cade4737mr7908865edd.398.1651560728391;
        Mon, 02 May 2022 23:52:08 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id hf27-20020a1709072c5b00b006f3ef214e2fsm4382915ejc.149.2022.05.02.23.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 23:52:07 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Vinod Koul <vkoul@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/6] dt-bindings: usb: da8xx-usb: deprecate '#dma-channels'
Date:   Tue,  3 May 2022 08:51:57 +0200
Message-Id: <20220503065201.51818-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220503065201.51818-1-krzysztof.kozlowski@linaro.org>
References: <20220503065201.51818-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic property, used in most of the drivers and defined in generic
dma-common DT bindings, is 'dma-channels'.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/usb/da8xx-usb.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/da8xx-usb.txt b/Documentation/devicetree/bindings/usb/da8xx-usb.txt
index 9ce22551b2b3..fb2027a7d80d 100644
--- a/Documentation/devicetree/bindings/usb/da8xx-usb.txt
+++ b/Documentation/devicetree/bindings/usb/da8xx-usb.txt
@@ -36,7 +36,8 @@ DMA
 - #dma-cells: should be set to 2. The first number represents the
   channel number (0 … 3 for endpoints 1 … 4).
   The second number is 0 for RX and 1 for TX transfers.
-- #dma-channels: should be set to 4 representing the 4 endpoints.
+- dma-channels: should be set to 4 representing the 4 endpoints.
+- #dma-channels: deprecated
 
 Example:
 	usb_phy: usb-phy {
@@ -74,7 +75,7 @@ Example:
 			reg-names = "controller", "scheduler", "queuemgr";
 			interrupts = <58>;
 			#dma-cells = <2>;
-			#dma-channels = <4>;
+			dma-channels = <4>;
 		};
 
 	};
-- 
2.32.0

