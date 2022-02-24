Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF804C2F8D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbiBXP0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236056AbiBXPZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:25:49 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1118A22A2B4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:25:18 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id hw13so5087278ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8bKHwHd9wrNVqM17Oa3exsITsVuSL3cS/OZaCl9ltdU=;
        b=Xu14nMrdL/kEer+3zNMAoJu75pcDa/4wbBn87Aq91UuLQXEwfPwsOfgSRU4uufnmA7
         +qKlGVqeIjGlUAbmRb1cf4snlXfZmBEg1wyREArT+I18vzgOlZgPrIyiejvoLrPPlhga
         1+poolq+DiL1yPIQ34m7Uy7poHA9pT6p2wDh9pgdWpMFaB2J9t83hJGna8kyGbkVaI1B
         3wPn7yE/bueB0kzwy2+wEtLQn/oeP2TyHvvkhgUd+VRs6UZOyWU4Ts/dvlI4YxWJuouX
         oxVktOY0T9gO2sahD52w/uNdkwU1tF2bA0zbho4nXrRHuku14R3Z2xVKoXKasOjsU2jG
         gv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=8bKHwHd9wrNVqM17Oa3exsITsVuSL3cS/OZaCl9ltdU=;
        b=ELfE5+B4slrS86V+lpQtgRAvYCGpsUAWRMLl+lWcCp7EIKNKBEDWl3uu3NL3ZC1LAh
         UNN7bsf4XqCH9TZDWvwOQY8+XbZXQmB6Moa1ZUCRzJ/Ds07q8k2TXClRBr5+rD35vywA
         3bkkg6W6FjvTjhY//RrZg9l5GKAVxfgXwyjk3hwsBcIZjs9ZCl1d7qlPcV0t6+bTOutK
         wDXv70jmIErlgDIK1eXkPKgPHTWQFQbD04w2BeMRva7cPCC1gD1F0AHP10ccLoyqgf1y
         4SjgmkBkdkqJTIcjD+6YtHiVC30G5GIR98a3fC+0oDsY7YRSvCLiS88D0UWl2vWUEPWt
         Uj/g==
X-Gm-Message-State: AOAM533jZVF/rpsxauVZLeSl6iHFp0nnut5kRh+jT+2jD9zl7f/5p2kY
        LJsLOoPGeJP6hva/JbUYp6c=
X-Google-Smtp-Source: ABdhPJzdcnTid5+1b8gpHvm6zGYUVRj5BmDXAL6rYfBuRhTnrWv3XXZCJSqhWEaGX1ZLmRLi86sJFA==
X-Received: by 2002:a17:906:8d8:b0:6d2:131d:be51 with SMTP id o24-20020a17090608d800b006d2131dbe51mr2612370eje.564.1645716316455;
        Thu, 24 Feb 2022 07:25:16 -0800 (PST)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id s11sm1509693edt.10.2022.02.24.07.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 07:25:16 -0800 (PST)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     linux-riscv@lists.infradead.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Alexandre Ghiti <alex@ghiti.fr>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/8] Add RISC-V asm/insn.h header
Date:   Thu, 24 Feb 2022 16:24:48 +0100
Message-Id: <20220224152456.493365-1-kernel@esmil.dk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a RISC-V asm/insn.h header to consolidate instruction
generation and manipulation similar to arm64's asm/insn.h.

The first three patches are preparatory patches fixing unaligned access
in module relocations and moving unneded definitions out of asm/module.h
and asm/ftrace.h.
Patch 4 adds the header and the remaining patches converts module
relocation, plt entry, jump label and dynamic ftrace code to use it.

The only obvious code left to convert is the BPF JIT(s).

This series depends on the module relocation range check fix here:
https://lore.kernel.org/linux-riscv/20220223191257.143694-1-kernel@esmil.dk/

Changes since v2:
- Split the range check fix out and send it separately.
- Convert "if (IS_DEFINED(CONFIG_32BIT))" to #ifdef to avoid compiler
  warning on rv32. Thanks kernel test robot!
- Add sp register, load/store instructions and RISCV_INSN_REG_L,
  RISCV_INSN_REG_S and RISC_INSN_SZREG macros to work on both rv32 and
  rv64 to the asm/insn.h header.
- Add patch moving unneded definitions out of out asm/ftrace.h and a
  patch converting kernel/ftrace.c to use the header.

Changes since v1:
- Send the right patches.

Emil Renner Berthing (8):
  riscv: Avoid unaligned access when relocating modules
  riscv: Remove unneeded definitions from asm/module.h
  riscv: Remove unneeded definitions from asm/ftrace.h
  riscv: Add asm/insn.h header
  riscv: Use asm/insn.h for module relocations
  riscv: Use asm/insn.h to generate plt entries
  riscv: Use asm/insn.h for jump labels
  riscv: Use asm/insn.h for dynamic ftrace

 arch/riscv/include/asm/ftrace.h     |  35 +----
 arch/riscv/include/asm/insn.h       | 151 ++++++++++++++++++
 arch/riscv/include/asm/module.h     |  87 ----------
 arch/riscv/kernel/ftrace.c          |  56 ++++---
 arch/riscv/kernel/jump_label.c      |  12 +-
 arch/riscv/kernel/module-sections.c |  71 +++++++++
 arch/riscv/kernel/module.c          | 236 +++++++++++++---------------
 7 files changed, 364 insertions(+), 284 deletions(-)
 create mode 100644 arch/riscv/include/asm/insn.h

-- 
2.35.1

