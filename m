Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BC152EFA6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351031AbiETPpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351062AbiETPpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:45:41 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F29D179969
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:45:27 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ds11so8419167pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=VE2vUXFOy2mJkujHyFNt0HPmwfcDu8WrrrqGHwab5YA=;
        b=tuEF1onridrYFom6GHGoVmHMvyrHQV/Jf6B0yeiPYn43PWuCZ4txpDmw1dqIEPI397
         t5iPNCMjW7PoX+tc8jbAUuH+BtaBGhp84qL41HRaB+DxQsJQC5EubyjCwjzedw8vRa0M
         DOZewV7xP26BcxzG8nNBVz/1ZAHv+yYAEcqmwxfbbXeF+P45JlXSS2N9YAx08Gm4/53w
         jkQMCSJDbP6WMAnG9MJccNFyCBJ6Bz0WlkimSCCLCsYlwwcNmedJ2b3qjgTg30qXLW6B
         y3T1P3I694ihOLCY/fCBx+g/6qUP2n1uyx7/SrJKVy53gR9qE31qHY2VU7Q+nBgZveBu
         z18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=VE2vUXFOy2mJkujHyFNt0HPmwfcDu8WrrrqGHwab5YA=;
        b=6VONx4GornRuXdHjIV1Y7rQNuQL7qahiScilQw6GaGLS5oMHq/C+li8hj+DXDUA5sC
         G7kMi40WAMKjOMZvGeesymY+2wKCaurSs15OkpxO4k0n2NrLdBmi28/UtvnyXyxGdzHG
         crKQlgo5vuaKXwHXFUI32QbnD1njFSZ0XE6AD8C7T4SNqllitaKAEdLFw8UGt0qRnMx8
         5yROpgnBbkkWLYWp63qnNSGyPDSRmCsPnpqB5SSqrHlLLWVDWohXbBynpuKGrjR+DrMP
         x6HKz/8h13X1rY6PQbYX9qzBpdGOEyvL28B++27tEEMpo026r7nPQnLPuTe05ENUE7Hk
         IZlQ==
X-Gm-Message-State: AOAM53038oG8YZmlK3b/JK9iOqhwSj5gSwd1mb9kCCauWnkoSdJU4Mg3
        yI2g58Qj+YjRACT+rfpQk1AEEA==
X-Google-Smtp-Source: ABdhPJxutQunHuqBnSDi1AyU5l++uXDUp12EI7aTjzru4LJnptzsRLuteBJZfMF6zOk21wIEpEwfSA==
X-Received: by 2002:a17:90b:4b02:b0:1df:d622:dd07 with SMTP id lx2-20020a17090b4b0200b001dfd622dd07mr10203411pjb.160.1653061526701;
        Fri, 20 May 2022 08:45:26 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id a12-20020a62bd0c000000b0050dc7628188sm1982140pff.98.2022.05.20.08.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 08:45:26 -0700 (PDT)
Subject: [PATCH v1 3/5] RISC-V: kexec: Use Elf64 on 64-bit targets
Date:   Fri, 20 May 2022 08:44:29 -0700
Message-Id: <20220520154430.18593-4-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220520154430.18593-1-palmer@rivosinc.com>
References: <20220520154430.18593-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        robh+dt@kernel.org, frowand.list@gmail.com, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        liaochang1@huawei.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux@rivosinc.com,
        Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     lizhengyu3@huawei.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

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

