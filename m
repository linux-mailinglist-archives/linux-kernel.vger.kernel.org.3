Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166CB51F124
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 22:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbiEHU3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 16:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbiEHU3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 16:29:51 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144A0BE38;
        Sun,  8 May 2022 13:26:00 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id j6so23260065ejc.13;
        Sun, 08 May 2022 13:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dls9wx30M8vanff1di+e0hUY3FreOPnMS2PbTpSJF+Y=;
        b=AWKEbn5j6vYe+ERbURHm63ghUCUdskHzA+tWJ0P90OrMViEG0+GSPC5/0yAA+U90e0
         IA3vGWZ4gmIMJh+N9eJTwjKp3J94S1uj9gkWx+A4xn5oNGaAYPVSKE0Q5BnWHXnAjPZy
         we24gpVfD76gjJk3P0COoalrDYmq+2EARzu/lf8AJ+sK4WdHMjC/GyiUJ3sZxL5PxzUn
         KdoOkB67trCPsGwxVhMjFFTLSW1pR9UVeoOoj8QiELM99mNkbKWVLsOddRFkqp+hA1S/
         OUtaj3c1eqbdFRtD2accDjdX10hbUuTPOC9oqHV64TigwmQqqUJ2uzyIbRd1+PsbMADm
         gyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dls9wx30M8vanff1di+e0hUY3FreOPnMS2PbTpSJF+Y=;
        b=za43DZqt3jlLACBQhYrhz2aEQEXmoEkTKqxJgzaDoFFfpM3SSqhgqxVRCZnFoVjLdS
         TwP09xZ6iRI4xCRA+lFxpBz97eSaoNrUL+AVGtnbZWh6Vgrr5wJ+lG+C+1KNy9xxBkGP
         tT+xVYz1kuUD17xmUpfW6J0PjxT6XCZubWGY8A2EdWt8Z3ax0waAo7LHvNVbH0OB6jXv
         OgDZ5Hy9/neVqIfS+secaXzZ8Zj1TBZpZvtO59R/BX7ay1/olAZ+Cl4o2jrtycnO9fJ2
         OnHxj0PSN4AH097n6tr9pneZgJfATOll4aXefT/G2LkS5IWruqu7cvEuwei8MenOza+r
         rh2A==
X-Gm-Message-State: AOAM530rm5guIXjW6jxpsBWnG9Ky3CNmZTHsYGe0IfkJPnpxKXA7bxu+
        pAESt2IFDTLKoG4biuqPc/M=
X-Google-Smtp-Source: ABdhPJyVbXNW970OhlMSwPXQgso3Y3BHest5yP+ACGD+ENnnXybEOjqBzDgDbBpJiJGGZXLvHpyrsQ==
X-Received: by 2002:a17:906:c10d:b0:6f4:a770:846e with SMTP id do13-20020a170906c10d00b006f4a770846emr12135921ejc.497.1652041558580;
        Sun, 08 May 2022 13:25:58 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id eo10-20020a1709069b0a00b006f3ef214e1esm4341459ejc.132.2022.05.08.13.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 13:25:58 -0700 (PDT)
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
Subject: [PATCH v2 1/3] dt-bindings: media: rockchip-vpu: Add RK3568 VEPU compatible
Date:   Sun,  8 May 2022 22:25:42 +0200
Message-Id: <20220508202544.501981-2-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220508202544.501981-1-frattaroli.nicolas@gmail.com>
References: <20220508202544.501981-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RK3568 and RK3566 have a Hantro VPU node solely dedicated to
encoding. This patch adds a compatible for it, and also allows
the bindings to only come with a vepu interrupt.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 Documentation/devicetree/bindings/media/rockchip-vpu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
index bacb60a34989..4045f107ca4e 100644
--- a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
+++ b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
@@ -22,6 +22,7 @@ properties:
           - rockchip,rk3288-vpu
           - rockchip,rk3328-vpu
           - rockchip,rk3399-vpu
+          - rockchip,rk3568-vepu
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

