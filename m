Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE0D5A4FCF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 17:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiH2PHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 11:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiH2PHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 11:07:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1DD86B54
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 08:07:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F62AB810A8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 15:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954FDC433C1;
        Mon, 29 Aug 2022 15:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661785618;
        bh=K2Sqs5g2tp+43xxFZspN1D8v3qOT6RryXTyaXO3QnJY=;
        h=From:To:Cc:Subject:Date:From;
        b=YYXlnOUgStpRCiFT6xNptSzJyFRT4JucbhZeoUfkRrgmPajuUSeKoR2RX375IVAwW
         fWUicxuedS/yJYoXbHl4oSA/B2FW4Hz1VP9bGfUEJlbJX8b/18ozyR5dvuBNk65C/1
         0qtiP53v9e830gxaaZCnzYMnKam3CbPRjQ4nOKmzqo5F3Jj+l1hxIot9mlt3Y0BGiL
         fKvlG2pZGtIPoSDEMmqaV1Mh/qCP9u7wSb8asYue/vJJuJQ8Lc0UToDR4WpIVVJLP9
         Ew2MdR07uCX8N1dG2rJ8pMmJIueJ2b/CS8S5qxyNZBtoIJx5RjYNRLyepRzDAfq1Qb
         SMTZRKKlK8L/g==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3] riscv: enable THP_SWAP for RV64
Date:   Mon, 29 Aug 2022 22:57:42 +0800
Message-Id: <20220829145742.3139-1-jszhang@kernel.org>
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

swp out bandwidth w/o patch: 66908 bytes/ms (mean of 10 tests)
swp out bandwidth w/ patch: 322638 bytes/ms (mean of 10 tests)

Improved by 382%!

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
Since v2:
 - correct reviewed-by tag
 - update commit msg

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

