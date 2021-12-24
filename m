Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F5D47F12C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 22:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353541AbhLXVQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 16:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344365AbhLXVQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 16:16:47 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B796C061757
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 13:16:47 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id f138so9153845qke.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 13:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AhdazWj7E7mP5lpQoH/Hlj6un/O7qxYC1hCrM4oG9J4=;
        b=mT9uij2tqEoq8C1DWMJWrz6FiHUEhP4vS4/RipfbDrcoEtaNu1JmX2fGlpJ91b6YMc
         1UDUDgVJl3VsW95/VIGAcjp+GVv182dDzIAGuBh+PmK2OIl0fH//dX9uKSAYzoz6RxPv
         UrOTdvCxGgmg6mEQXYwCeNVdlpSiKrnsm7bWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AhdazWj7E7mP5lpQoH/Hlj6un/O7qxYC1hCrM4oG9J4=;
        b=GO8X8HUifUwsC627bo3Wf4MSlS46HoLbwKjfN0oOoZNfovJ4xYJCiuX15P2Bb/JSqw
         hj2PU1Y6xy3XUwxh8898J1wvSUr6PGVqmSI3WBy4lQR/azau51S7PKuLmluLrFVY3gFK
         JITbzBHUeqVYMf+Fncgmvxhbtao7frKCS5dejph/jokihjV1p2Co3CIQQLrQeQuVI8ug
         JS7icbVdYi+M23Qam5UmAq3oN2KKa1aqHBCTCzQCAY/9naEKFTllYAvPvPoT0g8bBteq
         X2B5ATa0fxTh64bepmIU9gKHTTDTgPER3N40LHMX0LARdp30ESpCE9lpg8fU66UM3tKt
         c1dw==
X-Gm-Message-State: AOAM530czL+rQ6n4qxXgDHlSXqu7gF2+5EGzj/bZCTwLjTeFXPmjz3xt
        iT4V0cesSPFWT1udvLbUGpFnd4WyEiUy
X-Google-Smtp-Source: ABdhPJz65i5I0vRRJZRYggvczL1rK5geWBE650taAK2VtqLZTwr+BIm+WLoqvaWXZvHF8ett7iAUCA==
X-Received: by 2002:a05:620a:318d:: with SMTP id bi13mr5833578qkb.279.1640380605615;
        Fri, 24 Dec 2021 13:16:45 -0800 (PST)
Received: from fedora.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id m15sm7661069qkp.76.2021.12.24.13.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 13:16:45 -0800 (PST)
From:   Atish Patra <atishp@atishpatra.org>
X-Google-Original-From: Atish Patra <atishp@rivosinc.com>
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
Subject: [PATCH v1 0/2] Provide a fraemework for RISC-V ISA extensions 
Date:   Fri, 24 Dec 2021 13:16:30 -0800
Message-Id: <20211224211632.1698523-1-atishp@rivosinc.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements a generic framework to parse multi-letter ISA
extensions. It introduces a new DT node that can be under /cpus or
individual cpu depends on the platforms with homogeneous or heterogeneous 
harts. This version of the series only allows adds support for homogeneous
harts as there are no platforms with heterogeneous harts yet. However,
the DT binding allows both. 

The patch also indicates the user space about the available ISA extensions
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
E.g. The patch[1] adds the support for sscofpmf extension.

[1] https://github.com/atishp04/linux/commit/a23157264118d6fd905fd08d8717c7df03078bb1

Atish Patra (2):
RISC-V: Provide a framework for parsing multi-letter ISA extensions
dt-bindings: riscv: Add DT binding for RISC-V ISA extensions

.../devicetree/bindings/riscv/cpus.yaml       |  9 +++
arch/riscv/include/asm/hwcap.h                | 31 ++++++++++
arch/riscv/kernel/cpu.c                       | 16 +++++
arch/riscv/kernel/cpufeature.c                | 58 ++++++++++++++++++-
4 files changed, 113 insertions(+), 1 deletion(-)

--
2.33.1

