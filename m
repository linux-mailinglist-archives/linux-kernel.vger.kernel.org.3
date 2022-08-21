Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9388659B45F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 16:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiHUOSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 10:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiHUOSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 10:18:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DBFA18B
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 07:18:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10E2860ED9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 14:18:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E092C433D6;
        Sun, 21 Aug 2022 14:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661091511;
        bh=sdwpwSSJkNEgWy/Lv/s04spV+PKzs77/UypcZYQvt/I=;
        h=From:To:Cc:Subject:Date:From;
        b=ml7H9mfMsOgq3mL7UmcExeWD8n+Y/Fu0exLpwz72WBT9DFOFg6Sl7+5irG3G5jCec
         uwwxoO2rVndvczdIvjog9uMC0FbaSFgwDTKdSTUOWGUpuG6ttRM1DYe9Tsh3Mwmtep
         q9tUdgtk0t0QP7gWLlwIma22e90tluRKq4V10tbxjrx36aTv4b5zxn2+Oe1by+YTl9
         tgc0Mh0BGzhQIQpX5DjiPzUn6EcfyLI0fVrEe7YDSeJp6ve/JqsNIxgKgH3oS0W4KN
         YQeDDzQOPIGOfTdH36ZNk27tGSWDXibJ5IMI2727ebE43I/NwmzLS+fxWi26P+qFH4
         iAGQgJqtLD9Fg==
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
Subject: [PATCH v6 RESEND 0/2] use static key to optimize pgtable_l4_enabled
Date:   Sun, 21 Aug 2022 22:09:16 +0800
Message-Id: <20220821140918.3613-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Since v5:
 - Use DECLARE_STATIC_KEY_FALSE

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

