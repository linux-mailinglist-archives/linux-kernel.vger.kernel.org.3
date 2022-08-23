Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25AD59EC84
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbiHWThp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiHWThS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:37:18 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68FD98CAC
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:33:59 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l33-20020a05600c1d2100b003a645240a95so5838602wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=zfZqIEnKLgqKdt6yEdOe5gINIOFbq6xfPYo5xvbrixM=;
        b=f5pjcIK+H2mtPPE5b3VybQ5o01iECTvnw1E+28BxIUWO/6RjUzl2PBeS9opQx/sJtx
         yG2ysXoQtSd7WBzuZMOdXnT8YJjxr3vYR5+T/JX7WViSSLLzyWulBQl9Ko9BJ17LqXeZ
         ETGaCTo5yarZMm+oslfXmcNAi4epItnAZqaBYIMkIQm0At1DRkfT+iDb+SfVqSxBugml
         /5ZzzSEfTKoyNJSdvCwfE6CeTnMSICRVyM7qDc7zTPhZyBfqGkmjUnvVx/itr2tPYaA8
         ONtGo4StZVjqqloFXAtoKHXtIcn38GlQfWO7p9BYujiPWphKMNU0v9xU6g0zgzl9njmI
         LYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=zfZqIEnKLgqKdt6yEdOe5gINIOFbq6xfPYo5xvbrixM=;
        b=rzkhJi8y8xJc/JzV5ZwxDMMAnZUmRn6111A6pf/8MUbX2xLfqeWZeJEYnbWZXnBZnV
         HtzQtCojRWLSC+wcwbA+obhN/Sn+hqrcPD6ZcVPyc2j8P+e6qlU930YLjwxxl7G0ekqB
         QiOv/4sshcaooBU6iALHyAUP/GIh9uFxZ0MfddOJmPr2SolnGt9SrvnI22bTC2BFnd0h
         ABJ9alE5oj+e7S+7qRO+F8myS5dauNTLqzJEK/fwXnmfOjKEBSyvnAnJLFnYKBnZ6JDF
         0U1vntrwWHo7hlo4xD+9AQ5Wn11B0UrnPmAD8gX3AVdkHppXmQzw8DrHVyTgZOgAOdma
         q8rg==
X-Gm-Message-State: ACgBeo2pzLL1ARKQ+5b0e24nmuBjcr+Dw6dP0/5MHFC0hARfFK5BFI9e
        Pti1ZXX3T+l0vkvo96fKfN2CUQ==
X-Google-Smtp-Source: AA6agR5eS5/PKXnK5uN2L+sdbkehjdJJ73byQpKpkqsyKD/rDgN0AG98DD6sac0atiQVprDQeVTQwA==
X-Received: by 2002:a1c:c91a:0:b0:3a6:38bf:2c36 with SMTP id f26-20020a1cc91a000000b003a638bf2c36mr3062339wmb.38.1661279637684;
        Tue, 23 Aug 2022 11:33:57 -0700 (PDT)
Received: from henark71.. ([51.37.149.245])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c1d9000b003a5fcae64d4sm19396556wms.29.2022.08.23.11.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 11:33:57 -0700 (PDT)
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
Subject: [PATCH v4 3/4] dt-bindings: riscv: add new riscv,isa strings for emulators
Date:   Tue, 23 Aug 2022 19:33:19 +0100
Message-Id: <20220823183319.3314940-4-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220823183319.3314940-1-mail@conchuod.ie>
References: <20220823183319.3314940-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

The QEMU virt and spike machines currently export a riscv,isa string of
"rv64imafdcsuh",

While the RISC-V foundation has been ratifying a bunch of extenstions
etc, the kernel has remained relatively static with what hardware is
supported - but the same is not true of QEMU. Using the virt machine
and running dt-validate on the dumped dtb fails, partly due to the
unexpected isa string.

Rather than enumerate the many many possbilities, change the pattern
to a regex, with the following assumptions:
- ima are required
- the single letter order is fixed & we don't care about things that
  can't even do "ima"
- the standard multi letter extensions are all in a "_z<foo>" format
  where the first letter of <foo> is a valid single letter extension
- _s & _h are used for supervisor and hyper visor extensions
- convention says that after the first two chars, a standard multi
  letter extension name could be an english word (ifencei anyone?) so
  it's not worth restricting the charset
- as the above is just convention, don't apply any charset restrictions
  to reduce future churn
- vendor ISA extensions begind with _x and have no charset restrictions
- we don't care about an e extension from an OS pov
- that attempting to validate the contents of the multiletter extensions
  with dt-validate beyond the formatting is a futile, massively verbose
  or unwieldy exercise at best

The following limitations also apply:
- multi letter extension ordering is not enforced. dt-schema does not
  appear to allow for named match groups, so the resulting regex would
  be even more of a headache
- ditto for the numbered extensions

Finally, add me as a maintainer of the binding so that when it breaks
in the future, I can be held responsible!

Reported-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/linux-riscv/20220803170552.GA2250266-robh@kernel.org/
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Palmer, feel free to drop the maintainer addition. I just mostly want
to clean up my own mess on this when they decide to ratify more
extensions & this comes back up again.
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 873dd12f6e89..90a7cabf58fe 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -9,6 +9,7 @@ title: RISC-V bindings for 'cpus' DT nodes
 maintainers:
   - Paul Walmsley <paul.walmsley@sifive.com>
   - Palmer Dabbelt <palmer@sifive.com>
+  - Conor Dooley <conor@kernel.org>
 
 description: |
   This document uses some terminology common to the RISC-V community
@@ -79,9 +80,7 @@ properties:
       insensitive, letters in the riscv,isa string must be all
       lowercase to simplify parsing.
     $ref: "/schemas/types.yaml#/definitions/string"
-    enum:
-      - rv64imac
-      - rv64imafdc
+    pattern: ^rv(?:64|32)imaf?d?q?c?b?v?k?h?(?:_[hsxz](?:[a-z])+)*$
 
   # RISC-V requires 'timebase-frequency' in /cpus, so disallow it here
   timebase-frequency: false
-- 
2.37.1

