Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9BA512020
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241566AbiD0QKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242653AbiD0QJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:09:49 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DC648BD52
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:05:53 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id p4so2543571edx.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TVilUoRevfZDW2H5vRfurHd/Fm2AVNqP5L2gftL/36g=;
        b=qpVbyeYuO4LCJ5SSsF5RijFwZxkYPRC0v6k/uMkgp5wOFL+4LEtCWQlL44qoPvPCfa
         sI2sGnEFkD1rSmeh5RqWZcG9Qdwggdi0AvSVFX38EFDDGaj+Jhd863UvACC8xAmC6Wsi
         3nR6vH8SeaMPmz0HCcaasimo/9rqkwMa8JxZXUtEXPOfVLQ7G77zfjKT8brewxL9bfdF
         tTqMK/Sp6FlYMAqnzoQBJQGRfbe6zsTQa4P2ZWTQpSRQFpNpktvTDoDc7E5kqrwe8xYc
         tbKVAScrZ9rrBdbsUwR1IzcLkRHarVsN+WHCwnXjt0uNK7jJ6rdw0tbUWi6JSL+hJ8/X
         ZqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TVilUoRevfZDW2H5vRfurHd/Fm2AVNqP5L2gftL/36g=;
        b=M/7eFlKmkvY+CXy3UVSC4LbFHwJUnWUjTvjPZnLIBOkcPYoPEXxWslU/6q6j6a/ra3
         SCVWUuTSdrnxRe0YVm+mVHiKj1cRWwCH3sWNxItawZDNsVE10yWPXP+1mmwVUztFDXHJ
         0Kz6Ka3+4Z9bTcTZJAg8XCUvdBIMBpc48UWiIwEAVNVILsjLbeqyDsoxbWAPKT/H2Yng
         58TEM+0Vo6B9Kyt/iYL1nkvk8tack9xh16MRnW+UoF6yulZE431uXtdW9XSF+LgxRxXh
         g66Ts0qmkHlM2aUUtpk2ZjTzpfjIp+0KiLWM+x4DidrsmGPi5VMQ8pgkkaEvOyjfMcgE
         wF9w==
X-Gm-Message-State: AOAM532GNNEcmY864qlUx9q5uMLT1ODoetyChO/6+n5HY/6SLiUFuNmU
        4IWzd3Ragui+0AHJGuRs8KfKZA==
X-Google-Smtp-Source: ABdhPJwM944DVN2HVU25GzB2ouiP2jllWWb9bWolo4DktBx2+XEqObqS5DA32Eccp9haJmC4z2DrYw==
X-Received: by 2002:a05:6402:254e:b0:424:244:faf with SMTP id l14-20020a056402254e00b0042402440fafmr31144868edb.260.1651075548037;
        Wed, 27 Apr 2022 09:05:48 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b17-20020aa7dc11000000b00412ae7fda95sm8571437edu.44.2022.04.27.09.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 09:05:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] dt-bindings: usb: da8xx-usb: deprecate '#dma-channels'
Date:   Wed, 27 Apr 2022 18:05:36 +0200
Message-Id: <20220427160538.646044-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220427160538.646044-1-krzysztof.kozlowski@linaro.org>
References: <20220427160538.646044-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The generic property, used in most of the drivers and defined in generic
dma-common DT bindings, is 'dma-channels'.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

