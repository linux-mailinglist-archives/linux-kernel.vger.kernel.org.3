Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2915359E425
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 15:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240940AbiHWNKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 09:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241958AbiHWNJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 09:09:35 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E908133B9B
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 03:11:24 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bq23so9956182lfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 03:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=ZQTlzZhSz/F6Dyvy8ent1rccjYe8xNJQ3KifGL8COg8=;
        b=xdzD51NB6krEq2oSamBwJSqBmPConyxmXnOPIM2tI2HBKOxUv7620iJReAQX4+6ggD
         BjzkooN73GabBqwLc+zUjIWz2djjaLSR5UB5D0cBZofADRLsDJnMS4C99xqVHKGF7Rdi
         Bu8n5tx/Skd2MItQwGQcStTFSXtU+33U3vOxaLqdEzgiWQKCl+waW4MwyIo4lWeHpVz+
         cirMi9NxZWWm8QbJcRJjbffzrSwpf71cqxPl+MOzKhggBImETjovYgL0GUiwP9N5O7hy
         FStxMNxqnSzQIhg00KU0PdZU/lSNsw4Du4CkazOCKfkl8fT59Oi1obPyTMPVhNnvjnc7
         /eug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ZQTlzZhSz/F6Dyvy8ent1rccjYe8xNJQ3KifGL8COg8=;
        b=pN2XxzHNOQV2/TEUXO21nDMZLSiK1k2AKflxhHmcBHRMD5IYYFZQgLJYxHKwljWWCU
         G8CxVQBsCnu4oyVh5Ic399gExx0AY1ol1261Z3JVsQP8EeKjQt7wnAfvkqzl44DBPcr8
         /gTyKNbYJLflhZtBe1y8Fp9kXngFHnO11E46tueaCp9JushXNeTURPTsXMxWXh4osvIa
         S58/GZZwHO68t/CzFJvX854kSazyshok13E5ZHvrfPIsiqz0+2PcSfiydMmJTQqedjIr
         UuoRiRHTot9Olof6gkLqgqdcmnEDJfJRI8c7yeupVyjakSShGu+rD0ZHwAerQbDNexIa
         4gew==
X-Gm-Message-State: ACgBeo3w9eGHInKpFMakV37pv3ejAuG3owqASG7FsYbobCRDJSQP0n8D
        ZQCDqx/aXqz35cQ2+GrAleImcw==
X-Google-Smtp-Source: AA6agR5fDnH2XcXgR+T6xdK3Nc9HZ8ROsCJIQuD4B0AHH6qkWJfXdbFgMHgnduR4NDjt9ZBTuBdLkQ==
X-Received: by 2002:a05:6512:aca:b0:492:7db6:95f1 with SMTP id n10-20020a0565120aca00b004927db695f1mr8993150lfu.433.1661249435995;
        Tue, 23 Aug 2022 03:10:35 -0700 (PDT)
Received: from krzk-bin.. (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id z15-20020a056512370f00b0048af39ff3edsm2426771lfr.122.2022.08.23.03.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 03:10:35 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: display: synopsys,dw-hdmi: drop ref from reg-io-width
Date:   Tue, 23 Aug 2022 13:10:31 +0300
Message-Id: <20220823101031.387082-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

reg-io-width is a standard property, so no need for defining its type
with $ref.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml     | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml b/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml
index b00246faea57..4b7e54a8f037 100644
--- a/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml
@@ -26,7 +26,6 @@ properties:
   reg-io-width:
     description:
       Width (in bytes) of the registers specified by the reg property.
-    $ref: /schemas/types.yaml#/definitions/uint32
     enum: [1, 4]
     default: 1
 
-- 
2.34.1

