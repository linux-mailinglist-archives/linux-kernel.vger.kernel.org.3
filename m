Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C856F51AF5A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378226AbiEDUji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378118AbiEDUi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:38:59 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEBE60F9
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 13:35:22 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id p7-20020a05600c358700b00393e80c59daso3145719wmq.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 13:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m85atXqhp4ztYTPocRCcI1bK28FLuljc1tOQ4ApvLt8=;
        b=BoFO9RgijG3dtSC+Asm1aOZqkvwHfxz+CW4Wm64TPnFa7FGej6gX0ZOMUNTbQ4rrM7
         4KYQ4Bjcvlc1vCOh4bp/BF1yNdOn6tRdeoOBlEjvCCY4j2HeQ/RM4E7egRLnZK2b+xwi
         iSnNJh1hooZHs4gGM1ZdfQKb8gIF12WZ620/hfPU8rGSH0qI+GgLjDpYFglChHVp8NpR
         K95vMSs3fmVUAcnP487exVHKXwKhqiUdaaYuirMivrr4jVN8EpQWRr/BBKM+80QnxVcO
         jhnmE+9BSieIb71caKB+SjXaONf/L3QncYOvQqXgCSiPY5mB66hegKOvMeExGAyIg/qk
         3rhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m85atXqhp4ztYTPocRCcI1bK28FLuljc1tOQ4ApvLt8=;
        b=UKwNQiJhfNhafs1WusDnIqU/GG9dDTGF5Wy0I4UdY2qVoImN7mZc1fRQh/lbAE8FGZ
         A8uffMRO/DguW1DOQUR1w9ldNmU/V2vm7NylrLsk/kKaQyH14AMtjxmu4ROxlmjwDfuy
         ju5fHcBu73pmmNMfoNvLS5i7vT8DNEHE4riXdyiJzS7sCHJuiTi+xWHi9GLzXKyZmSyB
         v1rISfT7e2FtpZDsQWNTYTUgc1IwDeDdhrbIpXAwYBpiWHLqr8j3aRL4aIh/8hkmMDm+
         DHjZ7Tdq6FCP9kdjISECtd9R871ypttjnTYnaNiaZkPVMxxAC+3dy3HxBbMwPlwGhKG9
         9Qeg==
X-Gm-Message-State: AOAM5329KMNFpNc6De8P18Aa40drHMoJiamW7LJeMu3Jj+4BgDYzy7gK
        nIn4i1I/JX28tM9Nztk2V41XJA==
X-Google-Smtp-Source: ABdhPJxS/9tz7EnYuOE7vwds4NgNRqe9y7xl30EkdPS6ldBVO4rTRSF4cGiHP9guGl9befwAPMej9A==
X-Received: by 2002:a05:600c:35cd:b0:392:8e1a:18b7 with SMTP id r13-20020a05600c35cd00b003928e1a18b7mr1105496wmq.112.1651696521258;
        Wed, 04 May 2022 13:35:21 -0700 (PDT)
Received: from henark71.. ([109.77.36.132])
        by smtp.gmail.com with ESMTPSA id l20-20020adfc794000000b0020c5253d8dfsm13330101wrg.43.2022.05.04.13.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 13:35:20 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     krzk+dt@kernel.org, palmer@dabbelt.com, robh+dt@kernel.org
Cc:     conor.dooley@microchip.com, Cyril.Jean@microchip.com,
        daire.mcnamara@microchip.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, palmer@rivosinc.com, arnd@arndb.de,
        heiko@sntech.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 7/8] dt-bindings: riscv: microchip: add polarberry compatible string
Date:   Wed,  4 May 2022 21:30:51 +0100
Message-Id: <20220504203051.1210355-8-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220504203051.1210355-1-mail@conchuod.ie>
References: <20220504203051.1210355-1-mail@conchuod.ie>
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

From: Conor Dooley <conor.dooley@microchip.com>

Add a binding for the Sundance Polarberry board.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/microchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/microchip.yaml b/Documentation/devicetree/bindings/riscv/microchip.yaml
index 822a711df9e9..1aa7336a9672 100644
--- a/Documentation/devicetree/bindings/riscv/microchip.yaml
+++ b/Documentation/devicetree/bindings/riscv/microchip.yaml
@@ -21,6 +21,7 @@ properties:
       - enum:
           - microchip,mpfs-icicle-kit
           - microchip,mpfs-icicle-reference-rtlv2203
+          - sundance,polarberry
       - const: microchip,mpfs
 
 additionalProperties: true
-- 
2.36.0

