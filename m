Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4574E35F4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 02:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbiCVB1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 21:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbiCVB1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 21:27:48 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A66A3633C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 18:26:21 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2e5a3c1384cso133885627b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 18:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Zcfus1hr4rL4+XSk7ZeSMnR2CKTg6P0EKLP3F7c9nb8=;
        b=i8x6bw63C8CnBwNWToBn1ejwhs1I5sT+Qt9rGn8CdzD2q5bI6ajCe3oOQ78/3FZGIs
         qmXDGKtcf8+1xdLslk9ffOSueyPzSySWMSsk5Yq8Ly0Wd5PeXu0lxN1YBt84AS2iny0Q
         A0fzfbjqIHB/yamvOOvVSOO6Nx+KjZdAEe39VS4o1cjeZId+2Y0ZnFkqrcKqcS99Xlrs
         Y79QpCoATrBt4sBO6s619f0NsNV3loVUEwp9wTNb0aPu41sSSH+jhAKIOjE1W9ELy2l3
         Adh+H7EmKMo9H0/LyE/2qeSEKHxHjskBU9fCJeJ1yYdC3WyJDhOm4FnonjpV0MsT/W3m
         vaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Zcfus1hr4rL4+XSk7ZeSMnR2CKTg6P0EKLP3F7c9nb8=;
        b=c0Nx79ogrPTaq/y3amO9ffUVThATznGqe2Y6m0LzKamrUesV5yznNpInQXTp1GK2lO
         ATNn1T2kq1r8rpcccjx4y0bP+tZFqnLP9w5wwtyz9pNUKA7DjtG56cQsdEII5P/IdTQj
         i9cDb9X/GFTddqwQcOV4GlKnkhSktWHOUJUP+c6wjpq0oaecjhyMDG7Ue6zAHULkUT2O
         lvHHd8jqmum7n3nYXhYLgYlEe/q69seCfQceSIpDXWJ5vgDL3JLiZzVuDeMEPSjP066n
         SSIg5HMJIdkXnv6BqKnPTafDcVoLGKkYwjIVoyT1GZdHVkySFPjA6l3zNKKMJD3/eqVe
         Fb0Q==
X-Gm-Message-State: AOAM530Nt/qFTBWHQYlpWC0dKPEhOGYn6t2qlY4fSWNGzA1q5foVoTo2
        GkwTNX4BUEBoJDIMilkiF/P5rOpD0t8c
X-Google-Smtp-Source: ABdhPJxWQf3SqgA1tT/yCHPjgY7eRo1TW3y0rLfi2WTbwvt3o1LIklSxiCpYdgBDhAGwzIqiHVsde/KU8+bJ
X-Received: from maskray1.svl.corp.google.com ([2620:15c:2ce:200:b489:622a:ba50:950a])
 (user=maskray job=sendgmr) by 2002:a25:dd87:0:b0:628:e822:bd with SMTP id
 u129-20020a25dd87000000b00628e82200bdmr24014508ybg.505.1647912380832; Mon, 21
 Mar 2022 18:26:20 -0700 (PDT)
Date:   Mon, 21 Mar 2022 18:26:17 -0700
In-Reply-To: <mhng-7fe2c5d9-a8e6-4123-ac5c-0c9190792520@palmer-ri-x1c9>
Message-Id: <20220322012617.3517297-1-maskray@google.com>
Mime-Version: 1.0
References: <mhng-7fe2c5d9-a8e6-4123-ac5c-0c9190792520@palmer-ri-x1c9>
Subject: [PATCH v2] riscv module: remove (NOLOAD)
From:   Fangrui Song <maskray@google.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On ELF, (NOLOAD) sets the section type to SHT_NOBITS[1]. It is conceptually
inappropriate for .plt, .got, and .got.plt sections which are always
SHT_PROGBITS.

In GNU ld, if PLT entries are needed, .plt will be SHT_PROGBITS anyway
and (NOLOAD) will be essentially ignored. In ld.lld, since
https://reviews.llvm.org/D118840 ("[ELF] Support (TYPE=<value>) to
customize the output section type"), ld.lld will report a `section type
mismatch` error (later changed to a warning). Just remove (NOLOAD) to
fix the warning.

[1] https://lld.llvm.org/ELF/linker_script.html As of today, "The
section should be marked as not loadable" on
https://sourceware.org/binutils/docs/ld/Output-Section-Type.html is
outdated for ELF.

Link: https://github.com/ClangBuiltLinux/linux/issues/1597
Fixes: ab1ef68e5401 ("RISC-V: Add sections of PLT and GOT for kernel module")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Fangrui Song <maskray@google.com>
---
 arch/riscv/include/asm/module.lds.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/module.lds.h b/arch/riscv/include/asm/module.lds.h
index 4254ff2ff049..1075beae1ac6 100644
--- a/arch/riscv/include/asm/module.lds.h
+++ b/arch/riscv/include/asm/module.lds.h
@@ -2,8 +2,8 @@
 /* Copyright (C) 2017 Andes Technology Corporation */
 #ifdef CONFIG_MODULE_SECTIONS
 SECTIONS {
-	.plt (NOLOAD) : { BYTE(0) }
-	.got (NOLOAD) : { BYTE(0) }
-	.got.plt (NOLOAD) : { BYTE(0) }
+	.plt : { BYTE(0) }
+	.got : { BYTE(0) }
+	.got.plt : { BYTE(0) }
 }
 #endif
-- 
2.35.1.894.gb6a874cedc-goog

