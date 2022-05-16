Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5291952884E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245094AbiEPPQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245051AbiEPPQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:16:45 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0DCD9F;
        Mon, 16 May 2022 08:16:43 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j25so19979239wrc.9;
        Mon, 16 May 2022 08:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HVTQV5qHFuS0fcvSzFn/v1hK/N8SUy19AKXaGffwBSA=;
        b=KPemaBxWuVQ1rIAYWCVKXov/MCUd6HPBKz48HsgUTARmkggURV/6FOUEN70Xrh5Cov
         x9V3oZZU90H8pIedbzSyfsdvlBgDzVVGgmnyOrkDaBq7/xRjfxy4V0ic/6qKuZYO3bVP
         n+kTTCzDe5p+EaYxj8rgrefMu2D3B73l0zreudUuikf/Fgc5sPKsNSD/wg1kfnJTSUlo
         jwiIZudrpm37w3pJhw21p9c9Ir9i4Ht7oGAdw7nTBxhBvxt/3aKkdx8R/ExtFonQ7LLd
         kJVwBFdwPRFNP6d/gwi3r3vO68PcENpQW+cUZoi+6GiuVnU0JZ471me5KwyV4Ir4/pKN
         ai+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HVTQV5qHFuS0fcvSzFn/v1hK/N8SUy19AKXaGffwBSA=;
        b=uR1Oa7ehx22/eCMfyiUecjiF3DySB47J/M2qotc2bvkyBFPruUoRv/qaZAxit8zut0
         +FFdAR8p45xNkznVlcpoE56fG+Aalo+Moxa5TFYA7iCwZ6xBodXe2uY4Ufw3K/rvsHoG
         7vl34YerjF9cc6XnY5/AMddMjPS5vrcB0kLC1bhlrzFs2FWWh769IypEMhds8gMPQ6UJ
         1a01BVJxumIFD3f19bVTKkeqnZZcfrxUEOtv9kIN+8o3Vzn8whJcs2avxo5odanY5u/+
         99jHEfiVUAtBWaIh047KbQ6niuo2d4PWRdPLc/4bdMVz9dAnh5f3+pJx6KJUCfvKjYdU
         597Q==
X-Gm-Message-State: AOAM5327HjzLi0JkOa17VqoiM16v0mL9ZtxteUa5Cg7aKNY49bGM1C4/
        ndOgZIouguPg0guDN9zUA0A=
X-Google-Smtp-Source: ABdhPJxE9JtdUShgYIcnY1MFsx4Ht/U1EUsaWSRetqNMiwbSzplE/vRPXAOT20I3A8TbSfY1ue4ZAw==
X-Received: by 2002:a5d:4c4e:0:b0:20a:d006:79f8 with SMTP id n14-20020a5d4c4e000000b0020ad00679f8mr14099904wrt.600.1652714201691;
        Mon, 16 May 2022 08:16:41 -0700 (PDT)
Received: from vmu1804.lan ([2a06:a003:501a:a7ce::887])
        by smtp.googlemail.com with ESMTPSA id r5-20020adfbb05000000b0020d00174eabsm6418438wrg.94.2022.05.16.08.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 08:16:41 -0700 (PDT)
From:   Mikhail Zhilkin <csharper2005@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Karim <Karimdplay@gmail.com>,
        M <x1@disroot.org>, Mikhail Zhilkin <csharper2005@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/3] dt-bindings: Add Sercomm (Suzhou) Corporation vendor prefix
Date:   Mon, 16 May 2022 15:16:37 +0000
Message-Id: <20220516151637.885324-1-csharper2005@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516151228.885222-1-csharper2005@gmail.com>
References: <20220516151228.885222-1-csharper2005@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "sercomm" vendor prefix for "Sercomm (Suzhou) Corporation".

Company website:
Link: https://www.sercomm.com/

Signed-off-by: Mikhail Zhilkin <csharper2005@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 01430973ecec..65ff22364fb3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1082,6 +1082,8 @@ patternProperties:
     description: Sensirion AG
   "^sensortek,.*":
     description: Sensortek Technology Corporation
+  "^sercomm,.*":
+    description: Sercomm (Suzhou) Corporation
   "^sff,.*":
     description: Small Form Factor Committee
   "^sgd,.*":
-- 
2.25.1

