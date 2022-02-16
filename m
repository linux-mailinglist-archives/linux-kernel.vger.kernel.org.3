Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE52C4B7BE5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 01:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243398AbiBPA3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 19:29:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242611AbiBPA3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 19:29:30 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D62F70E3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 16:29:20 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id x5so556880qtw.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 16:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t27W0lbEILJrau95kLpEzbRPsuMMyCdiCi9PRIKKX+I=;
        b=eQuqnBRjXks3RQAght3ysumGeCoEcge074hYULSJQ5BdL36eSTPwMH5s6+g7vkB9+3
         9xaXVngmy5BVOF7nQHPFp+ZMwNSi45WD5d5vRJEE86jQ4swP1l1ROwcpm6AjXLS+bfvH
         NjXOA8ONPR9TPYOpfdFqGO/ufNY3CRqYqtaIBJ2ctVI0x/fX39iHa6UglWgrGkua725y
         AFcht3eKhDr3jRvABwfhykU2YAKAD1JLRZDFzvmi0R+2tHF8wB9t+l7RNkxKUjlOG/O4
         ngy1yhUI3yubQ0sZVlFv0hbXWF+WoR6dN5YhShYMp0zN8ToccrsfbXAjt7+pOknbeodD
         HIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t27W0lbEILJrau95kLpEzbRPsuMMyCdiCi9PRIKKX+I=;
        b=Wx51d2gvejrYV1dAS4UiqERcUdNjZnfj7oiz+Knis27VWgETVZlhkk0PNGbh4QXg5d
         dl4H/YsiNrCDxufmfABTrDwzUpvohNRZt9GWqgJBaZRDV40HIX1eTMXdAjtVzlxZ7Gar
         CnKwJP4MIDUmUw+zxu0QDvjaLY6Xh6OkuEPjqoUSSwbyQ9ATld2pxmTpUSVD9nkSFDT8
         ccEeVrX4ZYkWzRBwxs4QpXbMl4qsID9glKIVv80BJIgOYwVSiRmp31sxookmTXWwHcY/
         AdrmvHmLQxHV39SooNs46J8Pk0QllzucX0hR5NN8FQ0SXYoCv6uPMiImYYac2ihxZNyh
         wi3A==
X-Gm-Message-State: AOAM532KZH02BtdUw/qPMBAyCJXhMNaUJq1Bubul9BT4Y7BOU7+8/ZyS
        6I94isqOiw9ymoxH3yiE7IchAdwkpVVsfGpK
X-Google-Smtp-Source: ABdhPJz6iUpspGO34CrAyvWt5Q9xzqsyD/4nhf2iPphxkyF/qAVY0xVAe8eJ9Vf3s78QLWe7mqb9pA==
X-Received: by 2002:a05:622a:4f:b0:2c9:a3f9:debd with SMTP id y15-20020a05622a004f00b002c9a3f9debdmr385246qtw.689.1644971358926;
        Tue, 15 Feb 2022 16:29:18 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id g21sm20882584qtb.70.2022.02.15.16.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 16:29:18 -0800 (PST)
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
        Paul Walmsley <paul.walmsley@sifive.com>, heiko@sntech.de,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 0/6] Provide a fraemework for RISC-V ISA extensions 
Date:   Tue, 15 Feb 2022 16:29:05 -0800
Message-Id: <20220216002911.1219593-1-atishp@rivosinc.com>
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
[2] https://github.com/atishp04/linux/commit/e9e240c9a854dceb434ceb53bdbe82a657bee5f2 


Changes from v3->v4:
1. Changed temporary variable for current hart isa to a bitmap
2. Added reviewed-by tags.
3. Improved comments

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
arch/riscv/kernel/cpu.c        |  44 +++++++++++-
arch/riscv/kernel/cpufeature.c | 125 +++++++++++++++++++++++++++------
3 files changed, 171 insertions(+), 23 deletions(-)

--
2.30.2

