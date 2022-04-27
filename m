Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761B9512572
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 00:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbiD0Wso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 18:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiD0Wsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 18:48:40 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F321C11A;
        Wed, 27 Apr 2022 15:45:27 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id y3so6094212ejo.12;
        Wed, 27 Apr 2022 15:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pyZvRC+ImUtuat2otlAa+f33aNRxDWXd/DqxIdwCo1s=;
        b=QpNFUZCPgzvdxrGKeCw1W41OpBdSFRjJwTsfaMThDGiHLWIhgzSokitg8g8IM2htVc
         YsApSbH22jVkv+rHfesfbCLj9PDAcGtoWK2fekHjf6RK5ZPvcWpUFXB0LFrZJ2wM0fhN
         PKz1VqaEDxpHiP9mHlZ25CR2gR1AACS8PjNhMoyakaagTgVDCFrDvxfwgGWTTM1yEy9i
         noQFafrImDYAxOwP+jQkxagBInbL7K+ZBDmu5hWeoIwVyxFLXC+MkBcs/D9xffKHSVc7
         SgazfLKyoewySjF/D6sXLEX+wL1ozb+foLEmuakwzMoVrW2SmzPYgFk3Vo8OWzjZSu6M
         3w/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pyZvRC+ImUtuat2otlAa+f33aNRxDWXd/DqxIdwCo1s=;
        b=sw+Td6H4FbD0gNNUaCMdlXkRGSqnvStMn/WncT0TbkF/rJEeJr/OmrwxO7nayQRp24
         N4TOAWDfeI0lMs8i53nuFCAlvK1JLOnBcKGk+y2ndAmDaKU2OAIf3g+Xph4TFXoJ7kyu
         kCjU/edqj4+5v94U9f9ucDwhj7/1LCzaa0fwJc12s8X8IlPkP5Q94Q5X/vnr+ot3fs0V
         f7eKNfOxdAqpB/gkPzo8hb0BPvdyZMV8mPQk7kHZPkoOcRNmwjfhodFYqixxzt3QXbYj
         vpt3U2uolGFyEvdJ9hEoCyjgO68DGHun4XVgWvyqkRaJmpRI9WtoAMl1CFl+jd2qGtI+
         SmNQ==
X-Gm-Message-State: AOAM532X4eq7YbpKdGjkTgSlZTH187PAaBIUS3zDC8a9BXJELP1LXpun
        C7l5A/SyAUXDIOZ32nLJ9k0=
X-Google-Smtp-Source: ABdhPJxSIML5RaPid0dIjEvzf2jN0CDXNzAePhE3vd+DNERD2jnVTiDLJbNV7Y0XeAhPFY4oIwLgIg==
X-Received: by 2002:a17:907:3ea1:b0:6f3:d6a0:e5be with SMTP id hs33-20020a1709073ea100b006f3d6a0e5bemr1607123ejc.522.1651099525898;
        Wed, 27 Apr 2022 15:45:25 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id t27-20020a1709063e5b00b006f3a94f5194sm3762594eji.77.2022.04.27.15.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 15:45:25 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: media: rockchip-vpu: Add RK3568 JPEG compatible
Date:   Thu, 28 Apr 2022 00:44:36 +0200
Message-Id: <20220427224438.335327-2-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220427224438.335327-1-frattaroli.nicolas@gmail.com>
References: <20220427224438.335327-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RK3568 and RK3566 have a VPU node solely dedicated to JPEG
encoding. This patch adds a compatible for it, and also allows
the bindings to only come with a vepu interrupt.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 Documentation/devicetree/bindings/media/rockchip-vpu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
index bacb60a34989..cd62b44c34c3 100644
--- a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
+++ b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
@@ -22,6 +22,7 @@ properties:
           - rockchip,rk3288-vpu
           - rockchip,rk3328-vpu
           - rockchip,rk3399-vpu
+          - rockchip,rk3568-jpeg-vepu
           - rockchip,px30-vpu
       - items:
           - const: rockchip,rk3188-vpu
@@ -40,6 +41,7 @@ properties:
   interrupt-names:
     oneOf:
       - const: vdpu
+      - const: vepu
       - items:
           - const: vepu
           - const: vdpu
-- 
2.36.0

