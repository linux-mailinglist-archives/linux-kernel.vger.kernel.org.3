Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD954B17BD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 22:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344722AbiBJVke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 16:40:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344701AbiBJVka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 16:40:30 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A020270B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 13:40:31 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id k13-20020a4a948d000000b003172f2f6bdfso8040129ooi.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 13:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GFjBD5pXW1oDYaZhB6JNhzufwg/iO3HkPCeezpJonjE=;
        b=iksg0xdHxV1KXnXClS6AIq8Ytp1aDbko+dvCH7ZzHG71K23Qmnr1+R0baz0UQxMCs2
         YQTWvhzGus502Nd4u11IWiGPHUnIgTfbja0rgGiY7Kn74mZ6HmbGXID4MbaE24nQL4qG
         danGWG+Lpn6iR2Jc9eq5JDuebElwhYT73dr8r8FB9XinMxsfVaO3PXz71hGqOG7ihwdc
         5UygxaTyz5DPQN7mVmw2tyAYRh8Y7UDZtPf/IHUoybfdjnnqxwAlhyxDgVDi0cyjqU/Q
         jTIeJlVIVuFVs7tIb8dMpkOctU9yNl7saXOCdqPq2OGfMDZ3RmrezmG+996Xw9JtDMN+
         VMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GFjBD5pXW1oDYaZhB6JNhzufwg/iO3HkPCeezpJonjE=;
        b=07Ql8KuVtvfyPaw/OQPYVr3dVMMPBDKMu9LPqzi/fXaVazsKYKuZCVyYzQMDqgSl7N
         aJohDYuxQUaXdA5loURvfj9V0uU991CimaPPLUufvhvermNpZogJ5zgDg2LRmaL8U7+G
         pHz7q1orucmf6X16uPVZMFViHD0yUBnqibujL2bon7K0ZTEmRblMsHgL+w7ndyl3JHuV
         MQEugNQtvpv/KJsScola1yRfkJw1LMSc8mN2cGd+MAuvEGfCFbu9rfz3Yn2TihxdzAJX
         t++jPf2+QIIEyLLpU4ImMj7OwwHd/+aDAvsSqGAKdBNhYfHRFOUXsdMTxel1/NI4pA1z
         tkaQ==
X-Gm-Message-State: AOAM531GLNkwGZkn3fF+TiPGkPJrnzt6DGuNQ4z7ZdvKqS1fiQWyYIlZ
        hzemPVEUeFZplr5tjQAtjIiZNQr3DoLHCxAv
X-Google-Smtp-Source: ABdhPJxIOW/t2XpzltCUJWHCX7cMfGm3IFWRnAKi5lDaNjDq9qMokJgcb7uSVeoQZAYVBUNcPYb07A==
X-Received: by 2002:a05:6870:3816:: with SMTP id y22mr1449908oal.210.1644529230378;
        Thu, 10 Feb 2022 13:40:30 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id u5sm8700000ooo.46.2022.02.10.13.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 13:40:29 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tsukasa OI <research_trasio@irq.a4lg.com>,
        Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 1/6] RISC-V: Correctly print supported extensions
Date:   Thu, 10 Feb 2022 13:40:13 -0800
Message-Id: <20220210214018.55739-2-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220210214018.55739-1-atishp@rivosinc.com>
References: <20220210214018.55739-1-atishp@rivosinc.com>
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

From: Tsukasa OI <research_trasio@irq.a4lg.com>

This commit replaces BITS_PER_LONG with number of alphabet letters.

Current ISA pretty-printing code expects extension 'a' (bit 0) through
'z' (bit 25).  Although bit 26 and higher is not currently used (thus never
cause an issue in practice), it will be an annoying problem if we start to
use those in the future.

This commit disables printing high bits for now.

Signed-off-by: Tsukasa OI <research_trasio@irq.a4lg.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kernel/cpufeature.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index d959d207a40d..dd3d57eb4eea 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -13,6 +13,8 @@
 #include <asm/smp.h>
 #include <asm/switch_to.h>
 
+#define NUM_ALPHA_EXTS ('z' - 'a' + 1)
+
 unsigned long elf_hwcap __read_mostly;
 
 /* Host ISA bitmap */
@@ -63,7 +65,7 @@ void __init riscv_fill_hwcap(void)
 {
 	struct device_node *node;
 	const char *isa;
-	char print_str[BITS_PER_LONG + 1];
+	char print_str[NUM_ALPHA_EXTS + 1];
 	size_t i, j, isa_len;
 	static unsigned long isa2hwcap[256] = {0};
 
@@ -133,13 +135,13 @@ void __init riscv_fill_hwcap(void)
 	}
 
 	memset(print_str, 0, sizeof(print_str));
-	for (i = 0, j = 0; i < BITS_PER_LONG; i++)
+	for (i = 0, j = 0; i < NUM_ALPHA_EXTS; i++)
 		if (riscv_isa[0] & BIT_MASK(i))
 			print_str[j++] = (char)('a' + i);
 	pr_info("riscv: ISA extensions %s\n", print_str);
 
 	memset(print_str, 0, sizeof(print_str));
-	for (i = 0, j = 0; i < BITS_PER_LONG; i++)
+	for (i = 0, j = 0; i < NUM_ALPHA_EXTS; i++)
 		if (elf_hwcap & BIT_MASK(i))
 			print_str[j++] = (char)('a' + i);
 	pr_info("riscv: ELF capabilities %s\n", print_str);
-- 
2.30.2

