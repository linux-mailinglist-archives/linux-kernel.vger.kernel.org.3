Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7565D4B66D7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbiBOJCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:02:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbiBOJCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:02:42 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50150114FDF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:02:31 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id x3so11353905qvd.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=94zuPq2u7S7IuvdQC3T3gt4sxQz8uNo1pA51T1QzfOM=;
        b=oXqITTtyvfd9bHj1UUEuwmPenKxCQ5523q9nzwEO8w5VJCBGzM9ghj2KUA5i0TjLFx
         Ys12W+pBymEITarI/Mt2wWZlxCb9r+0ZbJvahV7goHiEwztoJzjZz9HkbhU2/y1ZxjWm
         Gkdakdeo+UKhfCbL99UQyRy8XK6Llrpv53n8cHI/rydrfz8IUoLPxwbcIYaU0abEiWxF
         hmub8pVPRIS05ocu3J/0jpsILbBMGht6GEGMypdtGG13zkdEl41Ec1rqHilNUq8bkYo5
         fx24g/02Shkj9e9P0tG8RgjqGp1EX1yEi815/fkcBpz3DlTF3/k+KqTilxk7w7qm4KRH
         Rg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=94zuPq2u7S7IuvdQC3T3gt4sxQz8uNo1pA51T1QzfOM=;
        b=AZribKxmmfcuWvpl9Gm09EqXk6kYFa+jnUQLYwFVV65W8lSWj+bDAufBXeOvqpXT3u
         BUDhl0uKfWbw59ELgUQ1mKesKJTQWdAWIoIcSG5/N1BWT5pZgg0/NRnwusacag5NGRh0
         DuSBBF8HvQOEYI1fBOh/I6f4zxn6pjKHmlR3LDI98Is9vETPH1WSLJk/oXkZOjrQo438
         zcPj9bT9ezpn4klhP0YB/8m8rrpJE4afQpj2dQ0+dKL2oGQJcWThD2jkot6mOoYWYhtN
         qpsE4I6W71NmiQTHYwTbmTnc979SEMyWVRm2AIZEMTmlw8stXYscR3zTVP9KXYrK7+Bb
         mnMA==
X-Gm-Message-State: AOAM531LEkzQ537gCQsoyUldumGX+HUL0dCMe4d4ePIHeDNMl7utr9PN
        Y1dnYZDLWoUNmSSKstSTu3SCvFBQ8xnpHp5+
X-Google-Smtp-Source: ABdhPJwdwNZpshpGezRK0j6kwzSGlQR6i2H2/tl7sT0mgs1i5UvXYIdnGb/gj8f0ZjhiTY3Ommk/rA==
X-Received: by 2002:a05:6214:21a5:: with SMTP id t5mr1975944qvc.51.1644915750023;
        Tue, 15 Feb 2022 01:02:30 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id w4sm17711158qko.123.2022.02.15.01.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 01:02:29 -0800 (PST)
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
Subject: [PATCH v3 0/6] Provide a fraemework for RISC-V ISA extensions 
Date:   Tue, 15 Feb 2022 01:02:05 -0800
Message-Id: <20220215090211.911366-1-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
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
E.g. The patch[2] adds the support for various ISA extensions.

[1] https://lore.kernel.org/all/0f568515-a05e-8204-aae3-035975af3ee8@irq.a4lg.com/T/
[2] https://github.com/atishp04/linux/commit/dc6f9200033bb5a72d8fd1a179bb272c6ade17e6 


Changes from v2->v3:
1. Updated comments to mark clearly a fix required for Qemu only.
2. Fixed a bug where the 1st multi-letter extension can be present without _
3. Added Tested by tags. 

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
RISC-V: Extract multi-letter extension names from "riscv, isa"

arch/riscv/include/asm/hwcap.h |  25 +++++++
arch/riscv/kernel/cpu.c        |  44 ++++++++++-
arch/riscv/kernel/cpufeature.c | 130 ++++++++++++++++++++++++++++-----
3 files changed, 178 insertions(+), 21 deletions(-)

--
2.30.2

