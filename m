Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F089597781
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241726AbiHQUGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241706AbiHQUFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:05:55 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4141563F14
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:05:54 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id n4so17367519wrp.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=vuO3cD7vHfOoM26qaFlIa3/qXvWH4JaTB3axSBEJPBw=;
        b=aLff/SU5U5NCprD2QuW81ZfqWPcaSFXlXSbnm3nBxoThVUuC+erRdVodWmcN79GWR3
         x6K8q62Y/aYgL/FZR7jCoVAQly7asoaWMM3eg4Sn7jt91w07TL5ryQcaxYoFF6mtw7x7
         WyCWzHVrw1kx1hzhuGNSQ8Z1QZLPIxrOSVAv5jzhEYz5lNvczMpa1TQU+b0Tf7qi+ALt
         tyUURhWEo6A/4e0QPQ+c9f7f1yX97VvMESe+aAoTJFbFqSFzjrwU8WvqNZnisdvUVt5J
         zfYmHcItVD5nQhI8sOUgr2pTtd/SmXdJo6yVsTj0KdxUltsCv4tc4rsYkjw0cepkFKbm
         LQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=vuO3cD7vHfOoM26qaFlIa3/qXvWH4JaTB3axSBEJPBw=;
        b=TWucobMFoYq2d3p82IEzvT44+friI8TrckRzAZ0ZOZl5t2UH2vELGvMaIdB1t8iQdI
         aZgWoAA56z5mTeazivUAS113ztkjVg8A/jLyDr00vtqYBg4pshTbWORVJ9C16Bxhv1PF
         m2wtbPVlwgmPxqJuo7xfkLZColkS448Lw0ZVGIhM/Xtzmj9cUZE/egzYdDUe6XolpWoT
         EAFMOyXcpsMOVWg0gQaxke+MY7iNm8k5VcsVwVFqJahsf+LLpOeYj1JPs6Jab/F9xwrU
         AALa4deWrTn+6oQQDNDm/323V7DL0Kar/muq85xH/CV4QS89Q4KQDAe2ACejORvuGPuR
         6XSw==
X-Gm-Message-State: ACgBeo18lZxEzkQUWoFnIbgofEnQLVZfs6oY6EPgPwRBzhKAguvotUky
        p+DGTZK0Au9qxKPASIxKFj0hQQ==
X-Google-Smtp-Source: AA6agR6xInXHiAM2BCLKV9u+fYev1yEmFG0NjjMiZhNBeLkYTbhJq4za1Z3qh97Ys5ZCdjUKqm17DQ==
X-Received: by 2002:a05:6000:1b92:b0:220:7d86:2e30 with SMTP id r18-20020a0560001b9200b002207d862e30mr15678682wru.530.1660766752738;
        Wed, 17 Aug 2022 13:05:52 -0700 (PDT)
Received: from henark71.. ([109.76.58.63])
        by smtp.gmail.com with ESMTPSA id i133-20020a1c3b8b000000b003a531c7aa66sm3400883wma.1.2022.08.17.13.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 13:05:51 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, qemu-riscv@nongnu.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 2/4] dt-bindings: interrupt-controller: sifive,plic: add legacy riscv compatible
Date:   Wed, 17 Aug 2022 21:05:21 +0100
Message-Id: <20220817200531.988850-3-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220817200531.988850-1-mail@conchuod.ie>
References: <20220817200531.988850-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

While "real" hardware might not use the compatible string "riscv,plic0"
it is present in the driver & QEMU uses it for automatically generated
virt machine dtbs. To avoid dt-validate problems with QEMU produced
dtbs, such as the following, add it to the binding.

riscv-virt.dtb: plic@c000000: compatible: 'oneOf' conditional failed, one must be fixed:
        'sifive,plic-1.0.0' is not one of ['sifive,fu540-c000-plic', 'starfive,jh7100-plic', 'canaan,k210-plic']
        'sifive,plic-1.0.0' is not one of ['allwinner,sun20i-d1-plic']
        'sifive,plic-1.0.0' was expected
        'thead,c900-plic' was expected
riscv-virt.dtb: plic@c000000: '#address-cells' is a required property

Reported-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/linux-riscv/20220803170552.GA2250266-robh@kernel.org/
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml     | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 92e0f8c3eff2..99e01f4d0a69 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -66,6 +66,11 @@ properties:
           - enum:
               - allwinner,sun20i-d1-plic
           - const: thead,c900-plic
+      - items:
+          - const: sifive,plic-1.0.0
+          - const: riscv,plic0
+        deprecated: true
+        description: For the QEMU virt machine only
 
   reg:
     maxItems: 1
-- 
2.37.1

