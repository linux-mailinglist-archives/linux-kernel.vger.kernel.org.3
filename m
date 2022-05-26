Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF818534842
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 03:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiEZBl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 21:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345480AbiEZBlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 21:41:24 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44257A0D2E;
        Wed, 25 May 2022 18:41:24 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id q8so588750oif.13;
        Wed, 25 May 2022 18:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hc7jv3hZJcUQLLwLUp2KDqz3Muic0VZtdol2jzZbWkI=;
        b=XWTY4IxC2Rg4FRlEkV+IRfN0VsN20u9aqNBTjt9TtPm625WXwrZezLM5umTtjRgmFz
         IG+vrAI3NCMT7maF19VcCMULfyiVkuVNgZEEGSdE8PkwWJ13X5dP+PaAtP2KzFnrYOeM
         1GRQU1FrMBq8DaJhPu1Nso6oPGCNZHGvUh2CRyVpiZ5YxYcpbP+3VhGc+CX+Jd3CBdXC
         +oT8tVV+fLb2Ap/nTIhJwBawP2njY0sV3mWZqAr6Oo4pyuT/81/nbpgVaXAdmA3lsunp
         aT2N4dyMo4I+BrqGKJ+6m9R0i+BEalv7w86g8VQdn+Vgg/PUArD2hQC1XlEHkY+4sJLA
         /Xkw==
X-Gm-Message-State: AOAM533BPUajhOczQJdwuyCvkfKzxFhupPcsmLM2/ruCGLVkAtTzSuGP
        +HsV2YUi9Rfgc0nB8x/aNmpgJDOJ4A==
X-Google-Smtp-Source: ABdhPJwUKqirXo4YhJQNF69cJPz6LOoBQ9fgdw+kjKRkheUwHKz5xjnE9uOJ+fpw1MEy6wjIMJ7bpQ==
X-Received: by 2002:a05:6808:1489:b0:32b:b9a8:e6c6 with SMTP id e9-20020a056808148900b0032bb9a8e6c6mr12709oiw.50.1653529283318;
        Wed, 25 May 2022 18:41:23 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id e22-20020a056808111600b0032b42772ef9sm173211oih.50.2022.05.25.18.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 18:41:22 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: usb: snps,dwc3: Add missing 'dma-coherent' property
Date:   Wed, 25 May 2022 20:41:18 -0500
Message-Id: <20220526014118.2872057-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
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

The 'unevaluatedProperties' schema checks is not fully working and doesn't
catch some cases where there's a $ref to another schema. A fix is pending,
but results in new warnings in examples.

Some DWC3 implementations such as Xilinx are hooked up coherently and need
to set the 'dma-coherent' property.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index f4471f8bdbef..d41265ba8ce2 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -68,6 +68,8 @@ properties:
         - enum: [bus_early, ref, suspend]
         - true
 
+  dma-coherent: true
+
   iommus:
     maxItems: 1
 
-- 
2.34.1

