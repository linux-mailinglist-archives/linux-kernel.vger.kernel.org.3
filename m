Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06204C97BA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 22:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238584AbiCAVYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 16:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238572AbiCAVYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 16:24:50 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99046A052;
        Tue,  1 Mar 2022 13:24:08 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id 12so17366762oix.12;
        Tue, 01 Mar 2022 13:24:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H5jfpYzdGFwqse4FWUnR7wwo36jxF9lnZflDBC+WReE=;
        b=KUXjPtohu56Y3E2060hGnKvDzXY7Ry1rEB9Yiw4uMliL0kgqwpxiGMrmRQIteyRoz6
         MCeFs175GvLJxxvHk7bjOBBL9mevlz4/O8FzRwVediOeUe/ravb0gp2rPCgypKvcr6DN
         mVqhxLUKE22z/JuTOe2Cur7FA2Wiic7FfW7r79bfQDROnlniKekDuQEFrVp9Delu+1qM
         oPNVJOI4/b3qLxZwqWZ4fDdcdJuWo3HMwqZPX5WGEWRwLXaj+tjhKgtMLKOgauvFxMWp
         kNY9G1zwtWAcEw7UCptgRZbNhfjfM+0JypifomRPk4zj7jfNnvoHkGrQs1hklASQ5wvR
         WQxA==
X-Gm-Message-State: AOAM531mQVx7l4VKO8TReSXhjCSiDWCJherlk/kXtOPyDSlx4O9RhGX2
        375H3HshmCl5wyyZaEDNDg==
X-Google-Smtp-Source: ABdhPJzmSm1l9KeZ7xin3mM3VRpjOgzsfhTJVT5XJXunHLlw3L7+E8CSBQCNd27nsxA6+jJBbAA/5A==
X-Received: by 2002:a05:6808:220d:b0:2d4:99cb:3849 with SMTP id bd13-20020a056808220d00b002d499cb3849mr15214493oib.63.1646169848201;
        Tue, 01 Mar 2022 13:24:08 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id x9-20020a9d6d89000000b005af61bd7e93sm6959942otp.23.2022.03.01.13.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 13:24:07 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Leilk Liu <leilk.liu@mediatek.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: dt-bindings: mediatek: Set min size for 'mediatek,pad-select'
Date:   Tue,  1 Mar 2022 15:23:57 -0600
Message-Id: <20220301212358.1887668-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The minimum array length defaults to the same size as the maximum. For
'mediatek,pad-select', the example has a length of 2 and in-tree .dts
files have a length of 1, but the schema says the length must be 4.

There's currently no warning in the example because the schema fixups
are not handling this case correctly.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
index bfa44acb1bdd..ac9ff12ae27a 100644
--- a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
@@ -62,6 +62,7 @@ properties:
 
   mediatek,pad-select:
     $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
     maxItems: 4
     items:
       enum: [0, 1, 2, 3]
-- 
2.32.0

