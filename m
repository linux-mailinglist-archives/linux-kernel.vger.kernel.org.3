Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4094D463F8A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 21:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343824AbhK3VBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 16:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343861AbhK3U7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 15:59:22 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743C9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 12:56:01 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id p19so21578740qtw.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 12:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YtBtuuKeMAZeMLgnQzbJ3vXXZ92idgns/q9JfanhveI=;
        b=WFbJXwVEnhxLMzS7Tnth74NWeuWI3CF7UYR8dZ9P3SwawJScXMMGgUabBo/JxqJoe4
         I4eESVBPhLb+hw63swrtwdgMGX+3sZGb582FHgz/ttTbWTuO0sx31T2Xf/2Ii9fChbJd
         d4+qhNvBSVwj0YaCFcKTvQAPsX3rv7sXwA7s03CfVBr7PcCrQ7n28ii4nV+2/BMxmjEv
         bTtqNPNtmOtnkGDsOniPIH3hPeYDwQ5OMO++/FbvKCPPLmF/2j9fS7dycMv7ym98Ct11
         CqC4K5KyZbe5AYi2s6gSpRX+3+C3x0naFMj3WsAESfWFAg+7EXiXHEUUJO5vtYhIGSM+
         23jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YtBtuuKeMAZeMLgnQzbJ3vXXZ92idgns/q9JfanhveI=;
        b=OZVgHJLZNKg4vqT9EKRlYlaJQCfJNLUQ39TgFlgkHQ74so3itkppjUuiS1G+D0BJGN
         BmiMHDRVwa0b+6pHfj8kzMh4Ze2j2RqSs4l0blnks0JC12jZTZAb2ZSvvJvvpHiBeOAZ
         Qt2bGLEtYzN4iVASwGW9DAh0zQ+bExtkJjY1u/p/I1qF1DUCizu4PuzYH1UBCF56KeQS
         F4tzY2KjP8c4JsbdzZgRCFETkSXFJ4kHtCT90k0XxkI5SPbszxXlEhYYgfpCRW0/y2zN
         z3SSbWaHoYFG5BB1PvrEmnpII87ieI68eaIt1hqfaRakleWZQE4oOUIbhBT71QYbvsk1
         tKBQ==
X-Gm-Message-State: AOAM530Pgi4oE1HUL/TsrbSkxonyK2K38tw0cBrzxhX+12/vAbW2z8t8
        D7i2NfhRPG7UyExrR/lm9lygFXhTeQ==
X-Google-Smtp-Source: ABdhPJwWfLE+h6IJC+f8CtMCRdjqbyx8LbdDR8H0yf6QVxp1PNA865RFPbpvsJkJzHk80A+UllNy3A==
X-Received: by 2002:a05:622a:1790:: with SMTP id s16mr2088243qtk.625.1638305760506;
        Tue, 30 Nov 2021 12:56:00 -0800 (PST)
Received: from citadel.. (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id t11sm10549356qkp.56.2021.11.30.12.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 12:56:00 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 0/6] x86-64: Stack protector and percpu improvements
Date:   Tue, 30 Nov 2021 15:55:43 -0500
Message-Id: <20211130205549.116673-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, x86-64 uses an unusual per-cpu layout, where the percpu section
is linked at absolute address 0.  The reason behind this is that older GCC
versions placed the stack protector (if enabled) at a fixed offset from the
GS segment base.  Since the GS segement is also used for percpu variables,
this forced the current layout.

GCC since version 8.1 supports a configurable location for the stack
protector value, which allows removal of the restriction on how the percpu
section is linked.

Changes from v1:
- Remove fixed location stack protector support

Brian Gerst (6):
  x86: Remove stack protector test scripts
  x86-64: Convert stack protector to normal percpu variable
  x86-64: Use relative per-cpu offsets
  x86-64: Remove inverse relocations
  kallsyms: Remove KALLSYMS_ABSOLUTE_PERCPU
  percpu: Remove PER_CPU_FIRST_SECTION

 arch/x86/Kconfig                          |   7 +-
 arch/x86/Makefile                         |  19 +--
 arch/x86/boot/compressed/misc.c           |  14 +--
 arch/x86/entry/entry_64.S                 |   2 +-
 arch/x86/include/asm/percpu.h             |  22 ----
 arch/x86/include/asm/processor.h          |  25 +---
 arch/x86/include/asm/stackprotector.h     |  36 ++----
 arch/x86/kernel/asm-offsets_64.c          |   6 -
 arch/x86/kernel/cpu/common.c              |   8 +-
 arch/x86/kernel/head_64.S                 |  10 +-
 arch/x86/kernel/irq_64.c                  |   1 -
 arch/x86/kernel/setup_percpu.c            |  12 +-
 arch/x86/kernel/vmlinux.lds.S             |  33 -----
 arch/x86/tools/relocs.c                   | 145 +---------------------
 arch/x86/xen/xen-head.S                   |  10 +-
 include/asm-generic/vmlinux.lds.h         |   1 -
 include/linux/percpu-defs.h               |  12 --
 init/Kconfig                              |  11 +-
 kernel/kallsyms.c                         |  12 +-
 scripts/gcc-x86_32-has-stack-protector.sh |   8 --
 scripts/gcc-x86_64-has-stack-protector.sh |   4 -
 scripts/kallsyms.c                        |  68 ++--------
 scripts/link-vmlinux.sh                   |   4 -
 23 files changed, 56 insertions(+), 414 deletions(-)
 delete mode 100755 scripts/gcc-x86_32-has-stack-protector.sh
 delete mode 100755 scripts/gcc-x86_64-has-stack-protector.sh

-- 
2.31.1

