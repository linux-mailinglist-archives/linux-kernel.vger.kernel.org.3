Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A027533FF5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243251AbiEYPLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242439AbiEYPL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:11:27 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95175AFAE4
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:11:24 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id u12-20020a17090a1d4c00b001df78c7c209so1933595pju.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bRYOEpeP8mCOnNEZuD4+iCUOqYnaouRYbges9HW9UzU=;
        b=fB7U5PYG4dbc2mUatzOeTVyMCW80Xn1V5J4gnethuZNXdHnYuttFdcoU/AEphupbov
         zUGFLG9Mz+1uQtzY+8NGIAiNJ0D8OgrbJsMASU26h3tP45Rweo+eTPyfXXabYZpPqqt6
         e1r7cajKXogHIIKNu1pM5zWSAUQt9oc1lFNfIYYghr5SdCvUNmGfxu5vuigKuuccNGaA
         uD9Ln7t1Y5xARYxWZaXXDJFKLCdnHi102CkaLnBAM9jb2TFz81aI735OVi0D3oC0HDDQ
         TtM3LRl9f+CGL1+gZSBvJ/SGRyaxfMxbfwIxwG19xqVPJkEzhEaMXn6E0y9BmGQS2x65
         Iz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bRYOEpeP8mCOnNEZuD4+iCUOqYnaouRYbges9HW9UzU=;
        b=WY6tN2lgDCfEqSykNRl/E+xETfGRrflmnZP5GcOEeEEO/+ER52iqevh3o9t5rE9Zdo
         QGqq5F6z95EHBbOLCjzcCQu9SkPeUMbmGm7TGwuda9WTqIBvAoNpGlI0yebVG62t2q/c
         v7pHKrYZaKHbkVK9WgDnIDyyMQWt4rP0ADIaXASuKXD5qLmUSSCpiT/1u69m/ERoomh0
         bkFuMfxnIsYgqK53la1e6o4i171MSvB+bZW8QEn757TwJWbwbJ0AHfHfzYHosOHY+xy8
         ld+fnvQRdQZTZox3ADbsjJ5nEln6/rSRUBydeFRyqKf94FopSEHBALObSQOJdAzPT9s5
         rEEw==
X-Gm-Message-State: AOAM530zIRC6emCij30GX+92OQSRkdfODr60nfrdJQK7Knyx8Bwh/6JG
        OY63XYDn8ExappPg7iEmQDG56A==
X-Google-Smtp-Source: ABdhPJyvLJhZ25tdT27CnU0AAM2lFzx+JKOH7YUo/53c5dnjCKRLax1PKiPS3cY+JYL3ORleGvObXw==
X-Received: by 2002:a17:902:d154:b0:163:5b66:564a with SMTP id t20-20020a170902d15400b001635b66564amr3395194plt.37.1653491483527;
        Wed, 25 May 2022 08:11:23 -0700 (PDT)
Received: from kerodipc.Dlink ([49.206.9.238])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902eb9000b00161b50c3db4sm9383129plg.94.2022.05.25.08.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 08:11:23 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Anup Patel <apatel@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, Sunil V L <sunil.vl@gmail.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 1/5] riscv: cpu_ops_sbi: Support for 64bit hartid
Date:   Wed, 25 May 2022 20:41:02 +0530
Message-Id: <20220525151106.2176147-2-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525151106.2176147-1-sunilvl@ventanamicro.com>
References: <20220525151106.2176147-1-sunilvl@ventanamicro.com>
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

The hartid can be a 64bit value on RV64 platforms. This patch modifies
the hartid variable type to unsigned long so that it can hold 64bit
value on RV64 platforms.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/kernel/cpu_ops_sbi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/cpu_ops_sbi.c b/arch/riscv/kernel/cpu_ops_sbi.c
index 4f5a6f84e2a4..efa0f0816634 100644
--- a/arch/riscv/kernel/cpu_ops_sbi.c
+++ b/arch/riscv/kernel/cpu_ops_sbi.c
@@ -65,7 +65,7 @@ static int sbi_hsm_hart_get_status(unsigned long hartid)
 static int sbi_cpu_start(unsigned int cpuid, struct task_struct *tidle)
 {
 	unsigned long boot_addr = __pa_symbol(secondary_start_sbi);
-	int hartid = cpuid_to_hartid_map(cpuid);
+	unsigned long hartid = cpuid_to_hartid_map(cpuid);
 	unsigned long hsm_data;
 	struct sbi_hart_boot_data *bdata = &per_cpu(boot_data, cpuid);
 
@@ -107,7 +107,7 @@ static void sbi_cpu_stop(void)
 static int sbi_cpu_is_stopped(unsigned int cpuid)
 {
 	int rc;
-	int hartid = cpuid_to_hartid_map(cpuid);
+	unsigned long hartid = cpuid_to_hartid_map(cpuid);
 
 	rc = sbi_hsm_hart_get_status(hartid);
 
-- 
2.25.1

