Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12ED5590C9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 07:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbiFXEuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 00:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiFXEs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 00:48:29 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959B16927E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 21:48:28 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d17so1532120pfq.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 21:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=jMCGTpB4qORgO/HAj9/J+wYW1m5dKZO1Y3zKxKtdM4E=;
        b=vKrF/uHWOix1+6Rl9MXcsk8W+kFQn6mM1CVaeA0uQogMNrgp1k5wMZQey+aLu9X84R
         BHXhsOPoUF5SO8RkvrBFWIykapEklgV+UwvVqywVNBz3I1je7hl1nHH5FqCv2/bTn5gE
         b6zmsjYCTjMu2DCbRqxal23S6foeAxjvZ0I9Vb5h7bTIL5rTPNVCdmhSv3BwnpnzJ8+h
         sFU3SoJoaQ9pnSxUOSPWi0V0Q5O82fR6fWL+FaNZd8GLx4embxn/u/LXoRJYHDE0pb8r
         gD6DJ+Rd7qA2JTDGwJ+L08FUMO2kUJU+iPqZ6+nAFU93FeYZs3QiOusK8ZsB5m3Zx5Bw
         TQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=jMCGTpB4qORgO/HAj9/J+wYW1m5dKZO1Y3zKxKtdM4E=;
        b=dpRxQ086tDjJdTkC/cPaJPcQYjLhxlwtCVWxnWKNw92+eiIp6agC1qoyjcx8InmaUs
         bxH8iTVUBKYE1o/IwsOkQsupa0ULrr6q/ZWeIJY62TlyWdZtqERseaudSckWQyRghQ0m
         ov771l890m6uNz4MVOTbhGVJqdeL4tQJtq0siXI88c5zf8dTG+U0Qkp6tpRyWBwuCG1j
         102Phz9IhSbSIK3LzONrl2cr2VlZTlcnuI2bYyC6L7nhP54fWyEl+jGvn5VRcYalAROe
         QBa+OOb0YOkJ6kguDLc2HV4SupzQCBF0Y7WbOc9ke6HXGd8EedysRYVVkWoNGqCNKw2n
         bl2Q==
X-Gm-Message-State: AJIora/gHUmhybEXiZDI209gvs0V6TeIq6fDk6Heg9l8kAfgCnpXON8P
        ba31gwbajZe/9YRLAwaf8HgwEQ==
X-Google-Smtp-Source: AGRyM1uXZHQEpXqpNCieCPKUs298Zc7ZlsXzMC3KKqzIqfHMvB+F20JyDbM4hFNh9MRoTPgZTKoG4A==
X-Received: by 2002:a63:fa41:0:b0:408:9d1b:2e57 with SMTP id g1-20020a63fa41000000b004089d1b2e57mr10364962pgk.102.1656046108122;
        Thu, 23 Jun 2022 21:48:28 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id 64-20020a621743000000b0051e7b6e8b12sm579926pfx.11.2022.06.23.21.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 21:48:27 -0700 (PDT)
Subject: [PATCH v2 3/5] RISC-V: kexec: Use Elf64 on 64-bit targets
Date:   Thu, 23 Jun 2022 21:48:09 -0700
Message-Id: <20220624044811.9682-4-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220624044811.9682-1-palmer@rivosinc.com>
References: <20220624044811.9682-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
            linux-security-module@vger.kernel.org,
            Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        linux-integrity@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the Elf macros automatically select the correct Elf type, this
converts the one explicit Elf64 usage to depend on XLEN.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/kernel/elf_kexec.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
index 9cb85095fd45..4532e3cf17a5 100644
--- a/arch/riscv/kernel/elf_kexec.c
+++ b/arch/riscv/kernel/elf_kexec.c
@@ -342,6 +342,12 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
 #define CLEAN_IMM(type, x) \
 	((~ENCODE_##type##_IMM((uint64_t)(-1))) & (x))
 
+#if __riscv_xlen == 32
+#define ELFN(T) ELF32 ## T
+#else
+#define ELFN(T) ELF64 ## T
+#endif
+
 int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 				     Elf_Shdr *section,
 				     const Elf_Shdr *relsec,
@@ -367,7 +373,7 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 		void *loc;		/* tmp location to modify */
 
 		sym = (void *)pi->ehdr + symtab->sh_offset;
-		sym += ELF64_R_SYM(relas[i].r_info);
+		sym += ELFN(_R_SYM)(relas[i].r_info);
 
 		if (sym->st_name)
 			name = strtab + sym->st_name;
-- 
2.34.1

