Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D1F535876
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 06:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241538AbiE0E3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 00:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiE0E3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 00:29:52 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7E6EC32A
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 21:29:50 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h186so2979641pgc.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 21:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AxyOYIUtWsKWwOM7sIj1O327JELUP9E08IQ32gOiwio=;
        b=xFRZVGwwriXl8/nPznIDsTMM5kipdKDj1JQbcaURQIH9eRjN9P8KlFbr1joz/HFqwn
         /BWnk1sh3nYj9WJkWrXwTAzmCT3pD44rNn53vOOKYk58hItdQwml/tGiy5rUICVQcb3d
         fb+my9arL+X/kgG/2WlVIVG2tl6sZGw1azwlV6QkU6rlbMy4xGpGCJUUlD+kHkb3U2u0
         G2WwFOhvlu4Jt7ocs2BQI3B2BkjRKwKY1C90CaviptMWpmSYW/N87QA6QiNTYhmRNhGi
         jqzs4byOF6Bm8Jr9cqkZieXPQJ3VMBylDqXGOCdAkd0RVPhdfTOJ4fGLsCV6HCFGVMiS
         90TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AxyOYIUtWsKWwOM7sIj1O327JELUP9E08IQ32gOiwio=;
        b=uyl/aBjUwJBcEJyvTTHRH1CRvQFlrp3a7i06H4qsJ/HmsU9Z0aSXSKuArCLrpOe8uj
         YPEqyqMOlydpDsyCbYMJ8kBBFKhXMVqmQMn/BdvVjWussVnekoXMhHKurr60OJ0liUac
         o43J3PF8x02XNg9yNRdwF/wZGWmmtGggEN+eHEZ/FTFy/LmR7TJ6xGsDhg3/wwwLQtVh
         ZvPe/aQtpJsLMpGOiS+z5XU8GUUSwf/R0IR9CWyE2mXNV+jJnujtchaHtF7J/xaU36/M
         P3gh+6Gwgv/mhNIohjaIKViDNHBTMGv0G/1BA0AM/NDvBc8clOUx8i4+mH7z3839Fbxf
         IFIw==
X-Gm-Message-State: AOAM533SMWpHVylO/f8TGdL5Phcq+7W5p/J8Ai+GRnWV6f+ktQ2UVupA
        k3TyZvw2ZTDUQl6RDz+IVYCQis5HmhNV0Q==
X-Google-Smtp-Source: ABdhPJzGT2jToXkh7UQIbyzaAakeoBkWusV6gSTx0SdU1ohBIMPVXGfH3n2hPirSRiKCAenoMKDW2Q==
X-Received: by 2002:a65:4149:0:b0:3fb:1476:d0dc with SMTP id x9-20020a654149000000b003fb1476d0dcmr5500060pgp.373.1653625789745;
        Thu, 26 May 2022 21:29:49 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id y63-20020a638a42000000b003fadfd7be5asm2352307pgd.18.2022.05.26.21.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 21:29:49 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 0/4] Add Sstc extension support 
Date:   Thu, 26 May 2022 21:29:33 -0700
Message-Id: <20220527042937.1124009-1-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
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

KVM directly updates the vstimecmp as well if the guest kernel invokes the SBI
call instead of updating stimecmp directly. This is required because KVM will
enable sstc extension if the hardware supports it unless the VMM explicitly
disables it for that guest. The hardware is expected to compare the
vstimecmp at every cycle if sstc is enabled and any stale value in vstimecmp
will lead to spurious timer interrupts. This also helps maintaining the
backward compatibility with older kernels.

Similary, the M-mode firmware(OpenSBI) uses stimecmp for older kernel
without sstc support as STIP bit in mip is read only for hardware with sstc. 

The PATCH 1 & 2 enables the basic infrastructure around Sstc extension while
PATCH 3 lets kernel use the Sstc extension if it is available in hardware.
PATCH 4 implements the Sstc extension in KVM.

This series has been tested on Qemu(RV32 & RV64) with additional patches in
Qemu[2]. This series can also be found at [3].

Changes from v3->v4:
1. Rebased on 5.18-rc6
2. Unified vstimemp & next_cycles.
3. Addressed comments in PATCH 3 & 4.

Changes from v2->v3:
1. Dropped unrelated KVM fixes from this series.
2. Rebased on 5.18-rc3.

Changes from v1->v2:
1. Separate the static key from kvm usage
2. Makde the sstc specific static key local to the driver/clocksource
3. Moved the vstimecmp update code to the vcpu_timer
4. Used function pointers instead of static key to invoke vstimecmp vs
   hrtimer at the run time. This will help in future for migration of vms
   from/to sstc enabled hardware to non-sstc enabled hardware.
5. Unified the vstimer & timer to 1 timer as only one of them will be used
   at runtime.

[1] https://drive.google.com/file/d/1m84Re2yK8m_vbW7TspvevCDR82MOBaSX/view
[2] https://github.com/atishp04/qemu/tree/sstc_v3
[3] https://github.com/atishp04/linux/tree/sstc_v4

Atish Patra (4):
RISC-V: Add SSTC extension CSR details
RISC-V: Enable sstc extension parsing from DT
RISC-V: Prefer sstc extension if available
RISC-V: KVM: Support sstc extension

arch/riscv/include/asm/csr.h            |  11 ++
arch/riscv/include/asm/hwcap.h          |   1 +
arch/riscv/include/asm/kvm_vcpu_timer.h |   8 +-
arch/riscv/include/uapi/asm/kvm.h       |   1 +
arch/riscv/kernel/cpu.c                 |   1 +
arch/riscv/kernel/cpufeature.c          |   1 +
arch/riscv/kvm/main.c                   |  12 +-
arch/riscv/kvm/vcpu.c                   |   5 +-
arch/riscv/kvm/vcpu_timer.c             | 144 +++++++++++++++++++++++-
drivers/clocksource/timer-riscv.c       |  24 +++-
10 files changed, 198 insertions(+), 10 deletions(-)

--
2.25.1

