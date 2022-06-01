Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1444B539C0D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 06:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239312AbiFAESe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 00:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235163AbiFAESa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 00:18:30 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DBB5931F;
        Tue, 31 May 2022 21:18:28 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gi33so1238007ejc.3;
        Tue, 31 May 2022 21:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=RSw8k1d0PMD6wj66n+1hU8B9FRDPkW1CFpjiF9rIWpo=;
        b=TrjwgnTl3ploNX8zp6ORq5aPD3FqDvLo44Q/ZISeWjgM9LzKROEkGRYve2Aw1eG9i0
         bSsVkwTt3Q/6UxVCLBY3LvzMdzxs7gGQBwE8zZx4/g5BcYgS1tZNun5uhrmI+J/rGAsY
         Hpgcezyg6qs7qwlyvuf5l8c0UaJdiN9e+YItj1Z7MvD1UOVjQY1ZQbTqk5YlFvMulQai
         cQRtbuvXCwZZTYBpJ8cpL24BqRqj2flVyj6FgcEjJdpoyam20SSW0WqWT4RXOxsOGqsi
         gfYoTo45CiLzohoTeFnVcEzE9/YlcnSjis36EqgKLPvQmgDzXKtYGPDGg2w48IlD9OGq
         CvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RSw8k1d0PMD6wj66n+1hU8B9FRDPkW1CFpjiF9rIWpo=;
        b=1iJitOcItwMo7LD9WBwymqbAGz5/xMx/HlNnmWewgx4okfrXzXJ2p7XZrHaQ2t549h
         /ASS/bjmB+Xvs4n+wFpw1TSA95DEm37o/FiwjZT0qBQtXARgRBUCVF4T5osABi9xPERW
         JftddGlUx6XAca8uk5yU2vElAzSHdOMAjDMpaIgqooHxaC4OPO1q4NOiDmnyOvW6l9Tu
         lREKYHbBNhSoWV8bG6EmQMagFlKIA04MQS3ujDFuFE355arubzZhx7QYYkQ01YnevGQd
         WSqk5kxJjNX0LqtfjzIL24ceRdWyPTRH8uzHjErx4RBYqHw6zUUlxuSrF1crmijYTr3e
         fGWw==
X-Gm-Message-State: AOAM531rMUlpbNcuci1626HA4tZ+NuATUuuRXHmuudFnzXuSKab7nikT
        H3YV2yvlWaoZTc0VcykgqiY=
X-Google-Smtp-Source: ABdhPJwgyhU+ZXDOZckYUwEphewTltQH7fIGAK729jV57SMSjG84XZZdUm4VashgG42xtDimZYYf/A==
X-Received: by 2002:a17:906:9749:b0:6f5:38d:d4d8 with SMTP id o9-20020a170906974900b006f5038dd4d8mr57000119ejy.405.1654057106397;
        Tue, 31 May 2022 21:18:26 -0700 (PDT)
Received: from felia.fritz.box (200116b82620c00028af88788fa7d286.dip.versatel-1u1.de. [2001:16b8:2620:c000:28af:8878:8fa7:d286])
        by smtp.gmail.com with ESMTPSA id t4-20020a056402020400b0042ab1735552sm279952edv.66.2022.05.31.21.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 21:18:25 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Andre Przywara <andre.przywara@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Liviu Dudau <liviu.dudau@arm.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        James Wang <james.qian.wang@arm.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, malidp@foss.arm.com,
        kernel-janitors@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: rectify entries for ARM DRM DRIVERS after dt conversion
Date:   Wed,  1 Jun 2022 06:17:46 +0200
Message-Id: <20220601041746.22986-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The three commits:

  36fd2a65bcaf ("dt-bindings: display: convert Arm HDLCD to DT schema")
  0f6983509ea1 ("dt-bindings: display: convert Arm Komeda to DT schema")
  2c8b082a3ab1 ("dt-bindings: display: convert Arm Mali-DP to DT schema")

convert the arm display dt-bindings, arm,*.txt to arm,*.yaml, but miss to
adjust its reference in MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about
broken references.

Repair these file references in ARM HDLCD DRM DRIVER, ARM KOMEDA DRM-KMS
DRIVER and ARM MALI-DP DRM DRIVER.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Andre, please ack.
Rob, Krzysztof, please pick this minor non-urgent clean-up patch in
your -next dt tree.

 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ae685aaf8850..58e751b9346e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1510,7 +1510,7 @@ F:	drivers/clocksource/arm_arch_timer.c
 ARM HDLCD DRM DRIVER
 M:	Liviu Dudau <liviu.dudau@arm.com>
 S:	Supported
-F:	Documentation/devicetree/bindings/display/arm,hdlcd.txt
+F:	Documentation/devicetree/bindings/display/arm,hdlcd.yaml
 F:	drivers/gpu/drm/arm/hdlcd_*
 
 ARM INTEGRATOR, VERSATILE AND REALVIEW SUPPORT
@@ -1545,7 +1545,7 @@ M:	Mihail Atanassov <mihail.atanassov@arm.com>
 L:	Mali DP Maintainers <malidp@foss.arm.com>
 S:	Supported
 T:	git git://anongit.freedesktop.org/drm/drm-misc
-F:	Documentation/devicetree/bindings/display/arm,komeda.txt
+F:	Documentation/devicetree/bindings/display/arm,komeda.yaml
 F:	Documentation/gpu/komeda-kms.rst
 F:	drivers/gpu/drm/arm/display/include/
 F:	drivers/gpu/drm/arm/display/komeda/
@@ -1567,7 +1567,7 @@ M:	Brian Starkey <brian.starkey@arm.com>
 L:	Mali DP Maintainers <malidp@foss.arm.com>
 S:	Supported
 T:	git git://anongit.freedesktop.org/drm/drm-misc
-F:	Documentation/devicetree/bindings/display/arm,malidp.txt
+F:	Documentation/devicetree/bindings/display/arm,malidp.yaml
 F:	Documentation/gpu/afbc.rst
 F:	drivers/gpu/drm/arm/
 
-- 
2.17.1

