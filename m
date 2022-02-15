Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD1C4B66DE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbiBOJCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:02:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbiBOJCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:02:44 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF66115952
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:02:33 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id e16so17958655qtq.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6U4rijSjm5U8GLHq/t1MdTXdgQmgucjQmV8Ymo3NwgE=;
        b=d6AqXpyQAUkwb7NXhHhPGHpTrpz3kInmKc5l+9JKzydHa1Yjbsy2BRjVcrrntoh+uV
         YSQEMzX9r2CZNmJmFCHPm+X5kRBzgTrZM02dq9yoSvrYlt7uRDIMi7wlJLYJE7nizXzu
         aYhyLgumMIBE/xOUIwG9y/Z4cXW7mmh0UdF/CzdS7XB+Ck7zFP01JNJ19/P1gKt7YD3D
         7hyGx4x7oSLcY1P5xdXeceqdoBd7KXOMfRoYuKL1/FOYYXCS14RqfWH01+GK6FFBzypt
         8KllIXTC2VopZSJX1gQ/d3NwidFhmksqid4R56q62/Y6aJliP/uD5fXLPByPaBNiDRGF
         +DyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6U4rijSjm5U8GLHq/t1MdTXdgQmgucjQmV8Ymo3NwgE=;
        b=U/r/d4MJBWN47qwlvmZBUEt/ZwWreU0lijDF64YiBIN6mOgUSoKNcBWEB5p25mI+f6
         fu76vcwsL97nf6LtXQYPCI1LLJDNI/cc7Y05S5Kkhtr4k3yuReR6Ix3tY4HtO72eUBKZ
         vTQcYpqlQSx849qbzohV3wc6jPkcZkrO/JsdPc0c+GpUkcJy8E/ZuTsoyzoShtXKHR2t
         M1atqX6ymxVDsyVPn5vhM+OePXUMDfaApQRQ4+GMM5rdWszQjFSgCBKL6bO5RE5oNQJ2
         X3GMUNuF5Url9JlSLdJgVoNvwRW47UIwz9On2/n0Ka55SqcsV/gt4EwsjOaJkL5vaO8T
         l0uQ==
X-Gm-Message-State: AOAM532PDZVnLeZBeMXJYnPCCQk59PxnX3O5N60dGfWGAA2Ccq1v54eA
        Q7bUTG8tt+hbIAyc4BWlMxlfDmasCMNpMkEP
X-Google-Smtp-Source: ABdhPJx4/yvXhJ/ovAf24/YgwDAEuc6OS7o3jsbBhcLP6CiFPWkQQ7xGpHWTW3PyyVI01ETcK1YUEw==
X-Received: by 2002:a05:622a:1350:: with SMTP id w16mr1988487qtk.320.1644915752185;
        Tue, 15 Feb 2022 01:02:32 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id w4sm17711158qko.123.2022.02.15.01.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 01:02:31 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tsukasa OI <research_trasio@irq.a4lg.com>,
        Atish Patra <atishp@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
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
Subject: [PATCH v3 1/6] RISC-V: Correctly print supported extensions
Date:   Tue, 15 Feb 2022 01:02:06 -0800
Message-Id: <20220215090211.911366-2-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220215090211.911366-1-atishp@rivosinc.com>
References: <20220215090211.911366-1-atishp@rivosinc.com>
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
Tested-by: Heiko Stuebner <heiko@sntech.de>
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

