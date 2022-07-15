Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB537576338
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 15:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbiGON5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 09:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiGON5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 09:57:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F6066ADF
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 06:57:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2199E623DB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54BCC34115;
        Fri, 15 Jul 2022 13:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657893469;
        bh=EG4+eyeSWG6p8MlL7myTufaqwBpKi2OXqFxrvHcxxqk=;
        h=From:To:Cc:Subject:Date:From;
        b=H/NtYc2qH5vOLGbu9x44ie3b74tKGwAGm9igLGf1rL2YHQLeiQk7Yab1Z4PzzvBLx
         IPBeVog8S0aW1Rr4XGEQQ3Y20eVg1AyKNFAiFOzpm+g5cqxPz8CYss56D40SG31bAY
         tbAOUaJnHeqCRFvu2VfmLXXaSQJdH38IJL8C9xo/UzghG7qIdvny8Q0tpgQxuZPk7M
         n4DGWUWlt/AjMg1CLlxDEhvtQysZBjTJCRAHjc9Ib/FrBKFp7Ky8BB7hlCciP+/PRQ
         d8SJzg9IIU3nz7t226BI1Y667Dxz5ZUOevXDaNO78XPiSTdvq61ZVmCXeNFJe3SdWk
         17zWo0xQl+rEQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: [PATCH v5 0/2] use static key to optimize pgtable_l4_enabled
Date:   Fri, 15 Jul 2022 21:48:45 +0800
Message-Id: <20220715134847.2190-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pgtable_l4|[l5]_enabled check sits at hot code path, performance
is impacted a lot. Since pgtable_l4|[l5]_enabled isn't changed after
boot, so static key can be used to solve the performance issue[1].

An unified way static key was introduced in [2], but it only targets
riscv isa extension. We dunno whether SV48 and SV57 will be considered
as isa extension, so the unified solution isn't used for
pgtable_l4[l5]_enabled now.

patch1 fixes a NULL pointer deference if static key is used a bit earlier.
patch2 uses the static key to optimize pgtable_l4|[l5]_enabled.

[1] http://lists.infradead.org/pipermail/linux-riscv/2021-December/011164.html
[2] https://lore.kernel.org/linux-riscv/20220517184453.3558-1-jszhang@kernel.org/T/#t

Since v4:
 - rebased on v5.19-rcN
 - collect Reviewed-by tags
 - Fix kernel panic issue if SPARSEMEM is enabled by moving the
   riscv_finalise_pgtable_lx() after sparse_init()

Since v3:
 - fix W=1 call to undeclared function 'static_branch_likely' error

Since v2:
 - move the W=1 warning fix to a separate patch
 - move the unified way to use static key to a new patch series.

Since v1:
 - Add a W=1 warning fix
 - Fix W=1 error
 - Based on v5.18-rcN, since SV57 support is added, so convert
   pgtable_l5_enabled as well.


Jisheng Zhang (2):
  riscv: move sbi_init() earlier before jump_label_init()
  riscv: turn pgtable_l4|[l5]_enabled to static key for RV64

 arch/riscv/include/asm/pgalloc.h    | 16 ++++----
 arch/riscv/include/asm/pgtable-32.h |  3 ++
 arch/riscv/include/asm/pgtable-64.h | 60 ++++++++++++++++++---------
 arch/riscv/include/asm/pgtable.h    |  5 +--
 arch/riscv/kernel/cpu.c             |  4 +-
 arch/riscv/kernel/setup.c           |  2 +-
 arch/riscv/mm/init.c                | 64 ++++++++++++++++++-----------
 arch/riscv/mm/kasan_init.c          | 16 ++++----
 8 files changed, 104 insertions(+), 66 deletions(-)

-- 
2.34.1

