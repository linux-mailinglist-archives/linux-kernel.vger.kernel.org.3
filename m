Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3E958AE2B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 18:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241289AbiHEQ3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 12:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241115AbiHEQ3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 12:29:09 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFD91704F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 09:29:08 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id l22so3808115wrz.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 09:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Bx9G8JNLiLJhDs2y+OulTQ6Arh93SHt8PJNhnkzS76A=;
        b=G8MjgRH1Dn5QHvCiGLUoHF1aRHWwuzqsY8+wvXJca/a+ZTHD0d/fJq9ByzAG71C4Gm
         brpuYzE4q5EjV6KvPCrpP4q8RpKDe6BQP38FTgiaz7FvOaWB6HnBXC7Y+QemmGTQ6XFG
         Lql/qMKUyGD9o89w4PxplbuWHyocXiBfg11Ydjl3fzyMGp0iFa5haHQaEJ6LYLEGv/VD
         VoFzWhQ3mh9Itj2HrYNPxF09k6/cIDE9Bhv/zErgH0H7Z96OQE0yeeQlrN1EThLHsKpH
         JEYKHdu+rxrhXp70NsNm7i69uxBxb+6KjfurAgrsGgo0faWi1e/J/E9qFugnQXv6KItI
         NW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Bx9G8JNLiLJhDs2y+OulTQ6Arh93SHt8PJNhnkzS76A=;
        b=enH77B53FJJeWvyv50Atapmq7Cn5K5Q5YV447atdYzaeXBiYYmINUA0AnSXXZnKLfS
         UxGnD7SU2VNBDatB4Wy+VT8jpUVooAMQ35BQSxoyM6c+MBAMFsIQTmnkQMwkC5/cz1qT
         OuwhjrF02dICB6BMReYvpo46oiAdhQo+mzYNMzYyVDJQKmHZVf6pOal5UVUu7FrlKHeT
         vw1E981eW2canVT5RMGBaLdJ6beyS1vjJBJT6D2WqggMUK1utbVx15km+5oE3lmFANA0
         fT58UThqyNW9ho0yLqkOuXidFFoGIRqSONCJSRisCmGKBD/MRMeTIEe4Uv1UYKOCPi2b
         L7zg==
X-Gm-Message-State: ACgBeo1Ju3iERhUK8aG8gElaS/qk6yHm1eEldeFUvj/OXpoMDcVm5zRf
        C770/CG98uYBcoZIR07vKP3d1w==
X-Google-Smtp-Source: AA6agR4qNHuK519Im+LmKC2Dyrt7fi+TNPv6Ialp08tZQks0jZtMsiBr2xk+CxzRIiLrK+LeQ/NxSg==
X-Received: by 2002:adf:fbc6:0:b0:21d:3fc3:99e with SMTP id d6-20020adffbc6000000b0021d3fc3099emr4737953wrs.550.1659716946942;
        Fri, 05 Aug 2022 09:29:06 -0700 (PDT)
Received: from henark71.. ([93.107.66.220])
        by smtp.gmail.com with ESMTPSA id b10-20020a056000054a00b00220633d96f2sm5210086wrf.72.2022.08.05.09.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 09:29:06 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, qemu-riscv@nongnu.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 3/3] dt-bindings: riscv: add new riscv,isa strings for emulators
Date:   Fri,  5 Aug 2022 17:28:45 +0100
Message-Id: <20220805162844.1554247-4-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220805162844.1554247-1-mail@conchuod.ie>
References: <20220805162844.1554247-1-mail@conchuod.ie>
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
"rv64imafdcsuh", but this obviously has illegal extensions in it.
The presense of "su" is a QEMU bug, so add an entry for the valid
portion of the isa string.

Reported-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/linux-riscv/20220803170552.GA2250266-robh@kernel.org/
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Although the commit message says "a" string, I have added more than one
isa string. My patched version of QEMU emits the full string with the
multi letter extensions and I am not sure what the policy is for
including them in the binding. Obviously I am more than willing to
change the patch text if needed.
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index d632ac76532e..59b942c5b9aa 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -77,6 +77,8 @@ properties:
     enum:
       - rv64imac
       - rv64imafdc
+      - rv64imafdch
+      - rv64imafdch_zicsr_zifencei_zba_zbb_zbc_zbs
 
   # RISC-V requires 'timebase-frequency' in /cpus, so disallow it here
   timebase-frequency: false
-- 
2.37.1

