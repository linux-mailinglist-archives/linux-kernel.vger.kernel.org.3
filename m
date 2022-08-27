Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D745F5A36E5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 12:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbiH0KHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 06:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiH0KHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 06:07:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC8B4331C
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 03:07:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6250B81D45
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 10:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289F9C433C1;
        Sat, 27 Aug 2022 10:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661594847;
        bh=x4/mGVMacC5xRI5YrwqxL+YnyXrMhkteEEVlNDKVYpY=;
        h=From:To:Cc:Subject:Date:From;
        b=QOI9LDoNkrsYJpyEwmZKcrb7VofNKKRStmjAR1DER05HCs3v6ckfZNzg3q318UFuE
         SKQBRURtBtyz4fCp/hOaAv+hyYUWNobgl0V2gMIzP6sfZXMavzq577wFVN469A1kSf
         vyGS2T9vMoh5ackyGaxk5etTvY4H+X7nwSpX0n2wEnttG1TepJFiP8zoGW92Kltmx8
         z7SUEQlGAVBuZQKioaIe17P7HNyJhlSCw3IxE95IDw/7/V+K74b/TGBPBC277LuW8j
         fVAC6ODypiiZ3bQPKiCiWqNCGxeLRqtAWjKlDQUBkmDOgXIFawQv0AgkNCy0ZckHPX
         fXak6rJbJvrqA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v2] riscv: enable THP_SWAP for RV64
Date:   Sat, 27 Aug 2022 17:58:15 +0800
Message-Id: <20220827095815.698-1-jszhang@kernel.org>
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

I have a Sipeed Lichee RV dock board which only has 512MB DDR, so
memory optimizations such as swap on zram are helpful. As is seen
in commit d0637c505f8a ("arm64: enable THP_SWAP for arm64") and
commit bd4c82c22c367e ("mm, THP, swap: delay splitting THP after
swapped out"), THP_SWAP can improve the swap throughput significantly.

Enable THP_SWAP for RV64, testing the micro-benchmark which is
introduced by commit d0637c505f8a ("arm64: enable THP_SWAP for arm64")
shows below numbers on the Lichee RV dock board:

thp swp throughput w/o patch: 66908 bytes/ms (mean of 10 tests)
thp swp throughput w/ patch: 322638 bytes/ms (mean of 10 tests)

Improved by 382%!

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
Since v1:
 - collect reviewed-by tag
 - make ARCH_WANTS_THP_SWAP rely on HAVE_ARCH_TRANSPARENT_HUGEPAGE
   instead

 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ed66c31e4655..79e52441e18b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -45,6 +45,7 @@ config RISCV
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_GENERAL_HUGETLB
 	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
+	select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
 	select BUILDTIME_TABLE_SORT if MMU
 	select CLONE_BACKWARDS
-- 
2.34.1

