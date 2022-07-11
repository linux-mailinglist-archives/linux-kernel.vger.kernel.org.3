Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8565A570960
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 19:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiGKRqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 13:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiGKRqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 13:46:46 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1CF3193F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:46:43 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id g13so125587plh.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5XRxNayKB2/09n5GhBRk+xuJegv1gyBvkxUNQ9XgvpY=;
        b=Um2h0NdAmGJuqfwpNMaLuKxtCxE3/DL4xL8FJYr+MOXXhJ7du189crJIxCiHrlM+Wm
         eQV09crg+elDydbcZT/pi3KPVBt6t0i9hJb5YBoIqF4LpeODdhfV3c8/3KnvE65yCRj6
         ErppussGk//ZNRx1joA+NViPAS0cyntB80mEqPNj7h0QVanQkzBmOsWhYLaYoWKeGFAA
         05JDK5RGaJ/5s0xlLDMx/BSV+0bBqHCmk8T1fSSAoa/BB53hMYWnIG/srN9eIkCp2kgD
         HoCsbmFtX/BXptfwIKqA+uPlcng/8hU52EUdRzHegUM3ZdJfPwjppCCWH4KDnHqid7c1
         UDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5XRxNayKB2/09n5GhBRk+xuJegv1gyBvkxUNQ9XgvpY=;
        b=GIh4WOO5OawoSFp9igljlNH7RdslsHFSozq0rEBgR6KsvIqkiaFpRa6AJ8DVRoRF3J
         yOyBi2+C0z/8azNkTnA9O9DVkZWQCf6+IQjOBxoB3dwugwOGag4QtkeMvDNCBjK0X7sx
         QI2S20cWHp/ctYgvr7HkqeR2z0E0fE//j44tq8n2VoCgQuzQzyl0wY0yoQ5GjWEipOjH
         /TU0zDk71K/xWMimEDq0A3GEHi9E0pYlf6mWHCD3Ll2+a9xeo97/Y3hmzh9UiAKW4MQ8
         d+bZmuig1Sj+myJ0GkMefE75aKYQEXlRLqh7ZfUWZ1loBN6eC3+1B+8TccmbtSnum7vX
         FHtg==
X-Gm-Message-State: AJIora+pQHt3sSUQ9zGDPZB3IqmWERDCQGTGbfnUCen34TDvo0kEoell
        J0T+OrirqTOjPF9ygPBuqxfgVkeq2V1jIA==
X-Google-Smtp-Source: AGRyM1t/+6ncVipFqtlOlC5IFcREal5eiWVWO7r5Vv0m9tT727BpocTVseKaczC0lJyhnZV4gAqn2A==
X-Received: by 2002:a17:902:f64f:b0:16c:23c2:e2dd with SMTP id m15-20020a170902f64f00b0016c23c2e2ddmr19339072plg.3.1657561602710;
        Mon, 11 Jul 2022 10:46:42 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902780a00b0016be9fa6807sm3236866pll.284.2022.07.11.10.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 10:46:42 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
Subject: [v3  0/5] Miscallenous improvement & fixes for the PMU driver
Date:   Mon, 11 Jul 2022 10:46:27 -0700
Message-Id: <20220711174632.4186047-1-atishp@rivosinc.com>
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

This series fixes issues PMU driver code.
PATCH 1 & 3 are fixes for rv32 while PATCH 2 fixes a redundant
user page update issue during counter start.

PATCH 4 & 5 improves the SBI PMU definition.

Changes from v2->v3:
1. Added two more patches that fixes few typos and enable support
for perf support in KVM.

Changes from v1->v2:
1. Add proper compile time rv32 checks.

Atish Patra (5):
RISC-V: Fix counter restart during overflow for RV32
RISC-V: Update user page mapping only once during start
RISC-V: Fix SBI PMU calls for RV32
RISC-V: Move counter info definition to sbi header file
RISC-V: Improve SBI definitions

arch/riscv/include/asm/sbi.h | 32 ++++++++++++++++++++++++++++++--
drivers/perf/riscv_pmu.c     |  1 -
drivers/perf/riscv_pmu_sbi.c | 30 ++++++++++++++++--------------
3 files changed, 46 insertions(+), 17 deletions(-)

--
2.25.1

