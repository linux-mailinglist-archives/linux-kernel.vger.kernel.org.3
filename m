Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BF44C65D6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbiB1Jn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbiB1JnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:43:23 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068B66351
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:42:43 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id q5so12650428oij.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lqd+uM0+AsEqEUkgyYxAHY0Z5jtxbH0DOOxZpRbhWVk=;
        b=TscrhBaDAEepfdz5Z2ltBnhHnUV1g+rV3nLy4t44yc41fnNwqn0MmQhy7DT7B2Bk0E
         ZrjZXsjxfT3EFYOMxdq3t7n+Xlq9hVZwgJeC6KSd6RjMuT5m4rvuwS+cmQSvbw3mw3hO
         ZbntkGKhK2um4h+a2Mu71f3CQxokfd5GOyyKd9yfivfNnfaBHG1vuoewiJsA2D5tcHa4
         bfcO1OAsYYoeKqg35HK6i10PhwLPII6uhFR4vVsOWcyKUcvWQLRBceRiHLbckDoUpgsK
         W4oFhtbAZdO8XecA/Kdjgp/QqkpWzu/RYdrKqXTMbj4dyTQUPDeRlEF60V1huvRiL/VU
         xQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lqd+uM0+AsEqEUkgyYxAHY0Z5jtxbH0DOOxZpRbhWVk=;
        b=bvUzbE2R3hQnh8yl1sIIUPJbQO0jbktjsCExyHGqbQsTXZfDGcG+HbW7ldi72LU9C2
         fen0WLlG42Q/7y0sGeFYMlS6KGfE9sA9xya6ljJ/t4GBNjmIrZNv3nytJ+D5YiEMj0s+
         NDkVIbnQ33Ep+/6hz5QfAJF4qBks03vid7JzyTSnaOmacoRZkBr3MMpFBFKop1pOsnTp
         FcG8TtwdPdE66QxMRT6zd6qGC7Ucg/cyKKuTkmGRSCkqevfIVma09gRFor9RS+/VWcgX
         P6MPyLcuSYrZKMJbfFfoCPsgwPtQgxE5mSFo2zHptoqp1mBQWlL5KFtnUIcf8w2Epm3d
         rLww==
X-Gm-Message-State: AOAM530vhbS7HWroK0jmK7jvpn8SMueYVp5XYiggvj2+JDhlKokrZiO8
        qlY0eYZRvh37WOS3UbVFMDlHgSxIsyN7Qg==
X-Google-Smtp-Source: ABdhPJzGVSYPURjxwKVMmt98ELmUV/vmpESUrllO+pnCtr9uHHmokFZxrEV/7bQfqVedP7L9vtOWdQ==
X-Received: by 2002:a05:6808:56b:b0:2d4:5f04:f2fa with SMTP id j11-20020a056808056b00b002d45f04f2famr9813151oig.96.1646041362018;
        Mon, 28 Feb 2022 01:42:42 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id bx10-20020a0568081b0a00b002d70da1ac54sm5936852oib.19.2022.02.28.01.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 01:42:41 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        kvm-riscv@lists.infradead.org, Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [RFC PATCH 0/6] Add Sstc extension support 
Date:   Mon, 28 Feb 2022 01:42:27 -0800
Message-Id: <20220228094234.3773153-1-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements Sstc extension support which was ratified recently.
Before the Sstc extension, an SBI call is necessary to generate timer
interrupts as only M-mode have access to the timecompare registers. Thus,
there is significant latency to generate timer interrupts at kernel.
For virtualized enviornments, its even worse as the KVM handles the SBI call
and uses a software timer to emulate the timecomapre register. 

Sstc extension solves both these problems by defining a stimecmp/vstimecmp
at supervisor (host/guest) level. It allows kernel to program a timer and
recieve interrupt without supervisor execution enviornment (M-mode/HS mode)
intervention.

To maintain backward compatibility, KVM directly updates the vstimecmp
if older kernel without sstc support is running in guest. Similary, the
M-mode firmware(OpenSBI) uses stimecmp for older kernel without sstc support. 

The PATCH 1 & 2 enables the basic infrastructure around Sstc extension while
PATCH 3 lets kernel use the Sstc extension if it is available in hardware.
PATCH 4 & 5 adds the infrastructure for KVM to use sstc while PATCH 6 actually
uses the Sstc extension if available. 

This series has been tested on Qemu(RV32 & RV64) with additional patches in
OpenSBI[2] and Qemu[3]. This series can also be found at [4].

[1] https://drive.google.com/file/d/1m84Re2yK8m_vbW7TspvevCDR82MOBaSX/view
[2] https://github.com/atishp04/opensbi/tree/sstc_v1
[3] https://github.com/atishp04/qemu/tree/sstc_v1
[3] https://github.com/atishp04/linux/tree/sstc_v1

Atish Patra (6):
RISC-V: Add SSTC extension CSR details
RISC-V: Enable sstc extension parsing from DT
RISC-V: Prefer sstc extension if available
RISC-V: Restrict the isa field in config register to base extensions
RISC-V: KVM: Introduce ISA extension register
RISC-V: KVM: Support sstc extension

arch/riscv/include/asm/csr.h            |  11 ++
arch/riscv/include/asm/hwcap.h          |   1 +
arch/riscv/include/asm/kvm_host.h       |   4 +
arch/riscv/include/asm/kvm_vcpu_timer.h |   3 +-
arch/riscv/include/asm/timex.h          |   2 +
arch/riscv/include/uapi/asm/kvm.h       |  22 ++++
arch/riscv/kernel/cpu.c                 |   1 +
arch/riscv/kernel/cpufeature.c          |   4 +-
arch/riscv/kvm/main.c                   |   8 ++
arch/riscv/kvm/vcpu.c                   | 111 ++++++++++++++++++-
arch/riscv/kvm/vcpu_sbi_replace.c       |  10 +-
arch/riscv/kvm/vcpu_timer.c             | 136 +++++++++++++++++++++++-
drivers/clocksource/timer-riscv.c       |  22 +++-
13 files changed, 323 insertions(+), 12 deletions(-)

--
2.30.2

