Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4044AAFBD
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 14:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242048AbiBFN64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 08:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiBFN62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 08:58:28 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCA6C0401D5
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 05:58:23 -0800 (PST)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 56A3540304
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 13:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644155898;
        bh=lR5QuC/RulAMRDxY+ifBfJU5LKjeK10Pu1tPwMpMBhw=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Zw49PEwymBu2HPOYEVfS7PPwK6Itm6mspmAL+lqfwOxpWRKrN0ls9CbrI1+He8HVp
         aMLliKGyPgS65DqxRjv1mWttQXAW3vDyEo8ha6d8tqIozJ+XLMZQvx/2qxeNjRypt5
         C2fzJ/2SgCQCG1GgB2wsnW/UaB4GdsawIx7bGxC2lpAWG0zg04SfSPWY9qRi3j2Hqs
         TwKcW9itj4D7L4kUhrGZ4jUBUHzZfNgv4aMJE8IUu7N1cYFEqtiG6GkapLs9/RwWKt
         aDNYnsbH4JtLSZoNK9l/yT/wtfs6P1+nfi2HZKhVrfcQwYZylxl9vEEmba6qWEucDL
         hbJujCjh8gEXQ==
Received: by mail-wm1-f70.google.com with SMTP id l4-20020a05600c4f0400b0037bb2ce79d8so2271386wmq.9
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 05:58:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lR5QuC/RulAMRDxY+ifBfJU5LKjeK10Pu1tPwMpMBhw=;
        b=TIMfDXRGINznpvDtfXkhZPAwvG7Ujb4QP8EA6NcQOuK9Nu4tttmTvMVMy3rKmcYDU3
         aRymVlZFM8Kfp8CSobZcxWvf2I050mzrJ3KEiOIP2OAwFuYP6f1rF9NKesXtfRO8CBpe
         sxNOfkq54YxW63JjriHlG7oRwSrtknDKrmo+zisg6dz9Lt0Xr4EPitKlCRG1owvt2oSi
         8LyBio2WowlcO5t0e84pE6RU64KyJZgfSM9SneOkt6RAt0sp0INdCEtt4w/1kIQKimc1
         uQr0KDN3WBFV70Ncgx6NCZ78HBXB3ojG8LxqcfsQjF4g/D/3mIiqlw2N/WubVTaBVSfk
         nMyQ==
X-Gm-Message-State: AOAM532syYgjCJ3CrafV2ehrL/UT9MHL6MSowTVp7gdBfSSUFPq8Hzja
        oH5/JZwlKG3efnth5MvucATz2Z/Btg/HZqRN1dDnTHGBnvaOBd3TIqHNppWrSBOJP6OlY5kAeEr
        or6GR0WjaytioBr8NPhzCpO+jbA5zVi93owR2RLyYXQ==
X-Received: by 2002:a05:600c:3d0c:: with SMTP id bh12mr10822060wmb.179.1644155896245;
        Sun, 06 Feb 2022 05:58:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwTX+molkn93Ebp+4k6R2HYipWuqcMWZxzQzfvUagW0IQOkjly+1ESbyJzirwTgRGM+iphQMw==
X-Received: by 2002:a05:600c:3d0c:: with SMTP id bh12mr10822054wmb.179.1644155896117;
        Sun, 06 Feb 2022 05:58:16 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id e9sm8296888wrg.60.2022.02.06.05.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 05:58:15 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 4/8] dt-bindings: memory: lpddr3: adjust IO width to spec
Date:   Sun,  6 Feb 2022 14:58:03 +0100
Message-Id: <20220206135807.211767-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220206135807.211767-1-krzysztof.kozlowski@canonical.com>
References: <20220206135807.211767-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to JEDEC Standard No. 209-3 (table 3.4.1 "Mode Register
Assignment and Definition in LPDDR3 SDRAM"), the LPDDR3 supports only
16- and 32-bit IO width.  Drop the unsupported others.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/memory-controllers/ddr/jedec,lpddr3.yaml           | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
index e36f3607e25a..d6787b5190ee 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
@@ -34,10 +34,8 @@ properties:
     description: |
       IO bus width in bits of SDRAM chip.
     enum:
-      - 64
       - 32
       - 16
-      - 8
 
   manufacturer-id:
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.32.0

