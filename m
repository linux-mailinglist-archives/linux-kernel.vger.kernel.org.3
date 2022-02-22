Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1994C0351
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 21:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbiBVUsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 15:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbiBVUst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:48:49 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88946A2F2C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 12:48:23 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id w3-20020a056830060300b005ad10e3becaso10522464oti.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 12:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=abzbFZd3TPTA4Go+lX5G5nJcRHQv2voi7TDO266GTxo=;
        b=bE1/yeOloum46YlusWndmuMHyJDVbuCOKxi7LzM43W6kLZSY5/aP7dpw83JCFGjpbg
         MuLW8oE4pbJOIDJW4KhDlBpis+FdejzShVly+iPEsgn0mTmfZRjpFhNAbpvkGWlfUbKs
         tZ+1u40aGQmj4CxRPTp9j+YNTlwuC4zcWX6Xq6t31ETRqb/3yRIKyOdHDaA/pu5XYCCv
         4N22WUTc2cDJ2UDqJQ0kwC1KPCfNuXTnqAkdBenSH7X52JG1GCgGw+KzEKzEkDdYhvc6
         S3SRfKIkttpI6b5LohIIsYWvnDcOtjz6m8b/Zu1gtsMaxJpRWUBqMrH1mJHWLn1BWBgJ
         jv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=abzbFZd3TPTA4Go+lX5G5nJcRHQv2voi7TDO266GTxo=;
        b=Fuira8P17e8k/Xv9jmHCUqyjEL4NHMBaGQrbWca+sWqaHM8EYVxlzEsROxTluWwClM
         eLkFLyjfawqlLYiArwsYZ61fht/Ed/nXgma8IlMrGScGzw5h/NR4f3u8rCtfjxXU1JJL
         o4xfgykJTJk1187y3krhVaIUWfuJadZSQGaNE1+5VK8on9rpPfI7esk6STMBGRdPviCy
         DlwUIdGhk7tLy0OvR4Zw0M7mF8yM+izaTaNexwAyW5YR4HQM5vbonY+S/zNpUEOKeIG+
         ELPLK0kpPmEboLvUhVo51kU+R8hlPf+FMGbDwY8xKnu8krBCGOMTybhQcmkPP9N1AMpk
         lPRQ==
X-Gm-Message-State: AOAM5304RQ6cejdk+aYvvuDf38DyvI0T+zJkw74jFsR3NFAzng4/UNcA
        YTDebIhTAIlsM4yxFnkMCOfs8YGuPc6swQ==
X-Google-Smtp-Source: ABdhPJwg12YQEEr0/64hFTYZhFiG9EZriyVRTIR/jLqxzfJ1/ovNNDL9pkKJyO2n8bLO2oKPpSFvqA==
X-Received: by 2002:a05:6830:2a05:b0:5af:1417:1218 with SMTP id y5-20020a0568302a0500b005af14171218mr5015956otu.237.1645562902530;
        Tue, 22 Feb 2022 12:48:22 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id o14sm16508197oaq.37.2022.02.22.12.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 12:48:21 -0800 (PST)
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
Subject: [PATCH v5 0/6] Provide a fraemework for RISC-V ISA extensions 
Date:   Tue, 22 Feb 2022 12:48:05 -0800
Message-Id: <20220222204811.2281949-1-atishp@rivosinc.com>
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

# cat /proc/cpuinfo 
processor	: 0
hart		: 0
isa		: rv64imafdch
isa-ext		: svpbmt svnapot svinval 
mmu		: sv48

processor	: 1
hart		: 1
isa		: rv64imafdch
isa-ext		: svpbmt svnapot svinval 
mmu		: sv48

processor	: 2
hart		: 2
isa		: rv64imafdch
isa-ext		: svpbmt svnapot svinval 
mmu		: sv48

processor	: 3
hart		: 3
isa		: rv64imafdch
isa-ext		: svpbmt svnapot svinval 
mmu		: sv48

Anybody adding support for any new multi-letter extensions should add an
entry to the riscv_isa_ext_id and the isa extension array. 
E.g. The patch[2] adds the support for various ISA extensions.

[1] https://lore.kernel.org/all/0f568515-a05e-8204-aae3-035975af3ee8@irq.a4lg.com/T/
[2] https://github.com/atishp04/linux/commit/e9e240c9a854dceb434ceb53bdbe82a657bee5f2 

Changes from v4->v5:
1. Improved the /proc/cpuinfo to include only valid & enabled extensions
2. Improved the multi-letter parsing by skipping the 'su' modes generated in
   Qemu as suggested by Tsukasa.

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
arch/riscv/kernel/cpu.c        |  51 ++++++++++++-
arch/riscv/kernel/cpufeature.c | 130 +++++++++++++++++++++++++++------
3 files changed, 183 insertions(+), 23 deletions(-)

--
2.30.2

