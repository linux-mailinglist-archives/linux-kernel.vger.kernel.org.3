Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D87512044
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241685AbiD0QKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242700AbiD0QJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:09:50 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5B748DEC5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:05:57 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id be20so2473639edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ILgIEY7wMcCopOsdlDifUioNzWZT1dVF0DliY6j2xA=;
        b=T4DB5lG9R3O3sQ3sn7pnH85cLUhqn6/RQbZSW20dj27Fq+ppgwj/lT1PLj6My5eb6j
         NYXwfLz610MvYk+drQvhzFa6IGwgfFwynowPQM4VlRX6pNwZ1zTZ8EMwGbPn5tUh2wZU
         OEkYPjl29hnRk8P6ZZgd33ebUC5CeVsKz+XzFQ8YtByrGjLSX+GrtgtSrU9pyPr9bW6U
         YFV3eI+XdBhWkv8XFBQuRganjmAMdLvKcBBZXiWgqPIow4pyLNU3xRDyjciaMwXYUt5t
         b+V75SjlOyPNhGeWQWCcBEATtUXfGAgO5w2X7vpyc6XUTJef/lpJ6XSu86YMlIKizp/3
         0S2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ILgIEY7wMcCopOsdlDifUioNzWZT1dVF0DliY6j2xA=;
        b=jTI7T4k6WMzaLmr0ngocUyUCepLBLD/SdsHvDBEu6y70FGvTzWi0QwzUH31xSdnAJ1
         u8qcuZwnuTidS4Wb71gvMP/0PBRn6luZabsJRYseFcG0cPWMrlFVdMLYzlAt42rEHnim
         kWS+CGnxXKbEjUpZYGZ3zitpyKyxYjJ1Mea21VZcqUebaXj/d3MTdby0y9qNQjPhnT/h
         +/cV4XWAe/pWCWVfUpgFyrg7K3ZvzT8WjZG53bKdhmaMd83uZEnCHQjaKQpxiCCQUQys
         z7rsgXAVCpQdjSl+8qV6rKwmmDfQ+S5HBojmLEnnEqgjj8L4dvEtB+/nggQXjTIhbVh+
         0Dcg==
X-Gm-Message-State: AOAM531WoKRXcpBdFRpaHZ2kUu2L5euqnIg8RZtCw8fIZC9RTt52aJ2s
        7Z5Ea8kNxjv2b7oKqfuEvbQkKQ==
X-Google-Smtp-Source: ABdhPJyvfsYi1ZhGhQXgeyMBsvg1zdskaGmnft5bTfbYhAiF0ltL3Fl0UMCLahVB1o006y6tgoWprw==
X-Received: by 2002:a05:6402:1d4e:b0:423:fd93:6466 with SMTP id dz14-20020a0564021d4e00b00423fd936466mr31112598edb.304.1651075550613;
        Wed, 27 Apr 2022 09:05:50 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b17-20020aa7dc11000000b00412ae7fda95sm8571437edu.44.2022.04.27.09.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 09:05:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] ARM: dts: dm81xx: use new 'dma-channels/requests' properties
Date:   Wed, 27 Apr 2022 18:05:38 +0200
Message-Id: <20220427160538.646044-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220427160538.646044-1-krzysztof.kozlowski@linaro.org>
References: <20220427160538.646044-1-krzysztof.kozlowski@linaro.org>
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

The '#dma-channels' and '#dma-requests' properties were deprecated in
favor of these defined by generic dma-common DT bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/dm814x.dtsi | 4 ++--
 arch/arm/boot/dts/dm816x.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/dm814x.dtsi b/arch/arm/boot/dts/dm814x.dtsi
index 7702e048e110..ab2572482ba9 100644
--- a/arch/arm/boot/dts/dm814x.dtsi
+++ b/arch/arm/boot/dts/dm814x.dtsi
@@ -167,8 +167,8 @@ cppi41dma: dma-controller@47402000 {
 				interrupts = <17>;
 				interrupt-names = "glue";
 				#dma-cells = <2>;
-				#dma-channels = <30>;
-				#dma-requests = <256>;
+				dma-channels = <30>;
+				dma-requests = <256>;
 			};
 		};
 
diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
index a9e7274806f4..317b7c74e32c 100644
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -655,8 +655,8 @@ cppi41dma: dma-controller@47402000 {
 				interrupts = <17>;
 				interrupt-names = "glue";
 				#dma-cells = <2>;
-				#dma-channels = <30>;
-				#dma-requests = <256>;
+				dma-channels = <30>;
+				dma-requests = <256>;
 			};
 		};
 
-- 
2.32.0

