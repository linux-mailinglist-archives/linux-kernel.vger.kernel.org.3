Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA5F54A011
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346691AbiFMUsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350969AbiFMUqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:46:17 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4907B272C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 12:57:31 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id z14so2358516pgh.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 12:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kwsOcdJyzi4VFYxBCTzUn3k4YPAv5NziRQo39dPYRYw=;
        b=5NouKk1RoKP/ZQdfEFImqZI4UVH4ulIfQu/RBQ68QxbQya7CB9JPSw0aNH+o1fq806
         9Sny1eWhk68b1G2UCx3qq9RDcyqT/iQZOS+wVocsBAjJNdkEKEKkQ9QEfajVu/nZuZcP
         Q27VQ8Wqg4sVFMsVqoChZyJoM6cxO2O53LT4vDw9yQOYKoH3CgSVOfdSHTZYySRQa2HX
         Z1AwUEhBLaCS6yvw/BmRCgxqFqomZShiZ4XhPClTyO0TV0SMkdA2xyCI2aHMR1amQEsS
         rc9aFy8tF0ggmONtwpXl5JZyNq3gsgDOnoHwGy5qY7RPE2U0S1SabobXj9Zn5JnIlRbH
         zb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kwsOcdJyzi4VFYxBCTzUn3k4YPAv5NziRQo39dPYRYw=;
        b=UHyZCX6yBh2oeZbGoDhQXBxZ4ACkhIybnts2Qnd2YU7omdHyjpGhyyQrpsoJ8pPGge
         fGpjVmI45xbrEHAiair4DP8YgpW4BO7oLf4re6wx/INafKK1QlNBvnPHxoWKN5Q32Z3i
         QXIY19aJcT10zq0wjUgH3HR2Gx1dB2o360jMap5wO+ZUALUa6zqG42ISD5lmgp4UVC2c
         Wg8x0o2ko6Eo/D1Ga6wJ3ecreiqmyPKbMm+/oT1boe75CrEPH7XsikbSi7UkoLrSZpQc
         YoXEjuLB9j9QDB98gjuUKdi4o9WhHM3+Qv663qYjqiAY9sCPQ+WaKNTzNUHRMfoTNNEh
         jq9g==
X-Gm-Message-State: AOAM5335YspkRHqYzjcO7UIBNl1u0xxCu9WP1h3drIaMFxKyRopm+IEi
        XdT/xuLDuBxsi1PGjW3uENE+Ig==
X-Google-Smtp-Source: ABdhPJwJjQXg4744yK1h6U80q2hA9yxTnOTwO3ZYxn9H8X5O7gLQQxaJwrsWn3XeabNgcM5kMe0KHg==
X-Received: by 2002:aa7:88c6:0:b0:51c:6e36:fad7 with SMTP id k6-20020aa788c6000000b0051c6e36fad7mr1005972pff.2.1655150250573;
        Mon, 13 Jun 2022 12:57:30 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id q21-20020a170902edd500b0016797c33b6csm5509357plk.116.2022.06.13.12.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 12:57:30 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, brad@pensando.io,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 04/15] dt-bindings: spi: dw: Add AMD Pensando Elba SoC SPI Controller bindings
Date:   Mon, 13 Jun 2022 12:56:47 -0700
Message-Id: <20220613195658.5607-5-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220613195658.5607-1-brad@pensando.io>
References: <20220613195658.5607-1-brad@pensando.io>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brad Larson <blarson@amd.com>

The AMD Pensando Elba SoC has integrated the DW APB SPI Controller

Signed-off-by: Brad Larson <blarson@amd.com>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index e25d44c218f2..2a55b947cffc 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -73,6 +73,8 @@ properties:
               - renesas,r9a06g032-spi # RZ/N1D
               - renesas,r9a06g033-spi # RZ/N1S
           - const: renesas,rzn1-spi   # RZ/N1
+      - description: AMD Pensando Elba SoC SPI Controller
+        const: amd,pensando-elba-spi
 
   reg:
     minItems: 1
-- 
2.17.1

