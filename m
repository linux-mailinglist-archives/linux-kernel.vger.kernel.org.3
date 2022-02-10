Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE044B17B7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 22:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344710AbiBJVkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 16:40:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344699AbiBJVka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 16:40:30 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB582707
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 13:40:29 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id v17-20020a4ac911000000b002eac41bb3f4so7989061ooq.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 13:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sYxNbm3oeGTvOZBjs/cPB3osaO0SDrWrhLkY+LP7ILU=;
        b=mXt7X2fqMXlhgBdk2hQKdn+EPzT3nfrG298GNRe+727egR9dlEBR0Q3Xr93bBxgAgU
         BV/wjgb6Ro/lOB8MDyuCy3w5SE+V5PRgO0IYRriAhXqHpGLGyHxAtNHTH6rHP+CYJ/I+
         ZlDAw8G4Chdvvicn+kKxX61+BzJRBJen+FaAQjo1sMAM7EEH/anqxQIKN6SA3YIy+ol6
         L7cDclRNMEpauUUJt6IxQxQZZBwBJr1/1Q5Quzv2AmMuBjSisQuXMN8Gi2yryJffeDX4
         aKqF62yXhDffpfKKXAFuiq/5mJL8rvzrTpMmkuEmD4yqWoF37X4xIT7TF3K7J/fFB40I
         5P1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sYxNbm3oeGTvOZBjs/cPB3osaO0SDrWrhLkY+LP7ILU=;
        b=gTh1+xHXm+GDNyyW22kVc1puyv+2XDLGA57YWrK3uKqPAuRj9MhY3Wc/1RhRfHY7D5
         NKv7p+PNo2Oi7xlIAV5AW8pv+/i/rpGFdE85ib3q69TRo87cW2ouPHFjSGbNCMjQAhlS
         po6rd7i7h2Q+JLd5xM+vJ5/1cdGr4z4bg5STNCBMyFXHF0xsxmTX5R+t+ktA3tGHuxEm
         ywrZ7opp8xXHf3S7JiP5KGe/dM2MAM2eQaVVZUvzH2nQuNkRwbElCd3nR6lt5cBZ6umO
         ks4/LXQuTTn8kw/MjP2kiGwJe5PWbhsdiUNM8oAUej32X8M00kePW2qYdwPgvaWdozbC
         cyQA==
X-Gm-Message-State: AOAM533vCy1KIcPii4Wjh3oYHX6ghCzROUkb3fVS4SWI2KSWtQSBQYEf
        4/163sdL7dPe8C9qlfLaXHz2Jy49ADN/aJjZ
X-Google-Smtp-Source: ABdhPJyNy85sqXA9jkFA6VdYAx9vnjI1G5u4976z/UV8JDAiyvnszJFiLyt6VW/DI+LwnbfYF54FWQ==
X-Received: by 2002:a05:6870:e743:: with SMTP id t3mr1394603oak.265.1644529228715;
        Thu, 10 Feb 2022 13:40:28 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id u5sm8700000ooo.46.2022.02.10.13.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 13:40:28 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
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
Subject: [PATCH v2 0/6] Provide a fraemework for RISC-V ISA extensions 
Date:   Thu, 10 Feb 2022 13:40:12 -0800
Message-Id: <20220210214018.55739-1-atishp@rivosinc.com>
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

This series implements a generic framework to parse multi-letter ISA
extensions. This series is based on Tsukasa's v3 isa extension improvement
series[1]. I have fixed few bugs and improved comments from that series
(PATCH1-3). I have not used PATCH 4 from that series as we are not using
ISA extension versioning as of now. We can add that later if required.

PATCH 4 allows the probing of multi-letter extensions via a macro.
It continues to use the common isa extensions between all the harts.
Thus hetergenous hart systems will only see the common ISA extensions.

PATCH 6 improves the /proc/cpuinfo interface for the available ISA extensions
via /proc/cpuinfo.

Here is the example output of /proc/cpuinfo:
(with debug patches in Qemu and Linux kernel)

/ # cat /proc/cpuinfo
processor	: 0
hart		: 0
isa		: rv64imafdcsu
isa-ext		: sstc,sscofpmf
mmu		: sv48

processor	: 1
hart		: 1
isa		: rv64imafdcsu
isa-ext		: sstc,sscofpmf
mmu		: sv48

processor	: 2
hart		: 2
isa		: rv64imafdcsu
isa-ext		: sstc,sscofpmf
mmu		: sv48

processor	: 3
hart		: 3
isa		: rv64imafdcsu
isa-ext		: sstc,sscofpmf
mmu		: sv48

Anybody adding support for any new multi-letter extensions should add an
entry to the riscv_isa_ext_id and the isa extension array. 
E.g. The patch[2] adds the support for sstc extension.

[1] https://lore.kernel.org/all/0f568515-a05e-8204-aae3-035975af3ee8@irq.a4lg.com/T/
[2] https://github.com/atishp04/linux/commit/dfc9b0d16f5a6e4695f0b3ca2f6e3f99654992db 


Changes from v1->v2:
1. Instead of adding a separate DT property use the riscv,isa property.
2. Based on Tsukasa's v3 isa extension improvement series.

Atish Patra (3):
RISC-V: Implement multi-letter ISA extension probing framework
RISC-V: Do no continue isa string parsing without correct XLEN
RISC-V: Improve /proc/cpuinfo output for ISA extensions

Tsukasa OI (3):
RISC-V: Correctly print supported extensions
RISC-V: Minimal parser for "riscv, isa" strings
RISC-V: Extract multi-letter extension names from "riscv,isa"

arch/riscv/include/asm/hwcap.h |  25 +++++++
arch/riscv/kernel/cpu.c        |  44 ++++++++++-
arch/riscv/kernel/cpufeature.c | 132 ++++++++++++++++++++++++++++-----
3 files changed, 180 insertions(+), 21 deletions(-)

--
2.30.2

