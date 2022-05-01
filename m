Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BA4516777
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 21:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353892AbiEATaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 15:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353218AbiEATaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 15:30:06 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEF62E68E
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 12:26:35 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x18so17265985wrc.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 12:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod-ie.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZhDxaWvr3i8Lutw3+7ISFPD0fuiq5HlmpgA4Bsv2nIg=;
        b=LwZpQHZ3QIq89HCYQ4sEtAc5hcU8wJ6xmW2v4ckhOIpRYRvev27G+gGGlz1PoOGqrE
         w3lUDWlSsyFeKV/l4bM0YARPVI/lOOA3cSBmYskpJ2uUdZxRfuDlWpil3cIPO7ie6Ay6
         8/dH7v5XzN5D0zjrP9EQSw+OXEE95nh5ti02MXCDN/ys3NN+FRLGk031KtL2JJdhqOD/
         C1f90VdKn44ja99FZdb4oyMM8GVYsqiAJMUQ6ffjh/omVxhfjyVi5v+j+AXyUBbvPnEW
         lKMsEvGGP51Ow0wXiNDArjLLSbaOLXEKLl9dQJrXGXO7FBYJQAgSBsS4CLhm3Al4MFmr
         RWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZhDxaWvr3i8Lutw3+7ISFPD0fuiq5HlmpgA4Bsv2nIg=;
        b=GOPsBU2MfLw0IX1gm+Xkf1eul42+gjbatnp6qo3smQMER8PPxSgx6iMshN3EULDMIE
         5gu9j64U4UoaOQkOK9jrUbSxLATUzp7e8JNUNa48jJ4o24mGi6o4eGam283E9h6Vq8w8
         E2Oh4+BwUyqMXsASNkXlS2//PrEN1IqeT7Uqv/kDEKE9yoI5PYHU782TdrjM70WEHfU3
         sNFe0EYTcvfKwcUAao6RF/rhtTLkmW6CVAa1q1i97EKsV35bxvTb/Whx8W/tFH//mWSa
         CsJAln7hgnWGK2zVVV+tYUTeU6WlOB/QayJd6leVK3d9/DsHgOs/LC7RUD8L8UtPFIf6
         /5Lg==
X-Gm-Message-State: AOAM532gadDiYbJ+CtGfrnRI/RLbwgxsXqW1MnGXogszrkIxQmuEx3AJ
        Mcg2iFDm/ZqhKzXSgkmWBAH1iA==
X-Google-Smtp-Source: ABdhPJwOWSCztk3LGFlqHTWMR2rc1VvecXIzfUi510DTMW3/34FscLyHo5s4MJVmz/0yNf4C/cwAsQ==
X-Received: by 2002:adf:e904:0:b0:20a:d652:592b with SMTP id f4-20020adfe904000000b0020ad652592bmr7143640wrm.714.1651433194083;
        Sun, 01 May 2022 12:26:34 -0700 (PDT)
Received: from henark71.. ([109.77.36.132])
        by smtp.gmail.com with ESMTPSA id i14-20020adfa50e000000b0020c5253d8c6sm6448105wrb.18.2022.05.01.12.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 12:26:33 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     krzk+dt@kernel.org, palmer@dabbelt.com, robh+dt@kernel.org
Cc:     conor.dooley@microchip.com, Cyril.Jean@microchip.com,
        daire.mcnamara@microchip.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, palmer@rivosinc.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 4/8] dt-bindings: riscv: microchip: document icicle reference design
Date:   Sun,  1 May 2022 20:25:55 +0100
Message-Id: <20220501192557.2631936-5-mail@conchuod.ie>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220501192557.2631936-1-mail@conchuod.ie>
References: <20220501192557.2631936-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Add a compatible for the icicle kit's reference design. This represents
the FPGA fabric's contents & is versioned to denote which release of the
reference design it applies to.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/microchip.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/microchip.yaml b/Documentation/devicetree/bindings/riscv/microchip.yaml
index 3f981e897126..7a1f883a39b5 100644
--- a/Documentation/devicetree/bindings/riscv/microchip.yaml
+++ b/Documentation/devicetree/bindings/riscv/microchip.yaml
@@ -20,8 +20,10 @@ properties:
     items:
       - enum:
           - microchip,mpfs-icicle-kit
+          - microchip,mpfs-icicle-reference-rtlv2203
       - const: microchip,mpfs
 
+
 additionalProperties: true
 
 ...
-- 
2.36.0

