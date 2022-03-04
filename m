Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE7F4CDE9B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbiCDUPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiCDUPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:15:37 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF18210460
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 12:11:26 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id bt3so8415065qtb.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 12:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qsIO2ya+cektsJMcKlRJepNqbeDF38Da8NmtSJ8s3gU=;
        b=N8FaQlw5OIEM3nPnrnG5ZP2TJJy/b2ccHKMgsAFTjSQD2qsuFgofIv2+b3o9BK1ZpN
         //j8EXvZd85ZIPGjHfXBgbqKRWSWnxfdpuL+fQK0aZMczrozI6OmH95uiuITNr3tToBt
         yo+IBGiuJ9MYEMUby4Y+iz940dgwRcjRcLlEM7LTUPJ0t2jcHcO6JqIo+/zKqJ0GRl60
         kROrc93K3cYxxoudnV2HZfdlRMDAkvxBsaT0Z5V1O3vN9b05UwxF9kyv7DdQRgFoCRC6
         YDEKxgc2mwGeYdA9wU3GErE1QEoOLqHp0DXpEukTcS8Ks0s/Bm36xscy4D8XcNBCJLSL
         7Lpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qsIO2ya+cektsJMcKlRJepNqbeDF38Da8NmtSJ8s3gU=;
        b=zV5AVE/oVBRPQNovoutJ3tt8McJQi8LmfRJCq/LOvlNf2ChguK9T0bEKscbtjHvgwv
         dLwJspVvk/euQQz/LkgZ8jXf4HXmqDODOinMo04rBsGuykjH0Ft/+lW2Uw1fpudV7VsL
         86UhuacsSVixr3OrhMZtJ2YTizRnCam8h1NbvqUgCuYUyHGRmxDDN6KyiFW5pG3Wa/yi
         SoxMqP85v42l2L9vqLQIZZEOGcvP5aWinmTn321UO20gW2o8KmU88yppXJNEOUPfo4ro
         t1KPBI2o4clhpTxbm4J0Cwse8wt2fhuWinF2ssqbMR8Onrt+fSuzCoM0iwXL6xbSs+aQ
         WHog==
X-Gm-Message-State: AOAM533Kxhiulc7CI4g8FzBIiMr+jWDa4Ci8AZV5yWBHNOv0oex9vWtJ
        ghg9JgMJrmczFEpcE2vzFT2xV5rsZO131A==
X-Google-Smtp-Source: ABdhPJyBu28CBsOFIzyM9DOgbXjnNnxtobqGHxzYB0P4cAzhg/+V3vQ13sjTBnimNgfPW2IUppEExQ==
X-Received: by 2002:a05:622a:1b8d:b0:2d1:38ca:6b1 with SMTP id bp13-20020a05622a1b8d00b002d138ca06b1mr396609qtb.688.1646424645574;
        Fri, 04 Mar 2022 12:10:45 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id 20-20020ac84e94000000b002de8f564305sm4605481qtp.1.2022.03.04.12.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 12:10:45 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [RFC PATCH v2 4/7] RISC-V: KVM: Remove 's' & 'u' as valid ISA extension
Date:   Fri,  4 Mar 2022 12:10:17 -0800
Message-Id: <20220304201020.810380-5-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220304201020.810380-1-atishp@rivosinc.com>
References: <20220304201020.810380-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no ISA extension defined as 's' & 'u' in RISC-V specifications.
The misa register defines 's' & 'u' bit as Supervisor/User privilege mode
enabled. But it should not appear in the ISA extension in the device tree.

Remove those from the allowed ISA extension for kvm.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/vcpu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 624166004e36..3ae545e7b398 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -43,9 +43,7 @@ const struct kvm_stats_header kvm_vcpu_stats_header = {
 				 riscv_isa_extension_mask(d) | \
 				 riscv_isa_extension_mask(f) | \
 				 riscv_isa_extension_mask(i) | \
-				 riscv_isa_extension_mask(m) | \
-				 riscv_isa_extension_mask(s) | \
-				 riscv_isa_extension_mask(u))
+				 riscv_isa_extension_mask(m))
 
 static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu)
 {
-- 
2.30.2

