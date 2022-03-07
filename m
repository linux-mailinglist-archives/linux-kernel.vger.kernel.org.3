Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970F94D0B59
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 23:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238925AbiCGWr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 17:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343846AbiCGWrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 17:47:24 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCFF506D6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 14:46:26 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nRM7T-00032M-7m; Mon, 07 Mar 2022 23:46:23 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, mick@ics.forth.gr, samuel@sholland.org,
        cmuellner@linux.com, philipp.tomsich@vrull.eu,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 0/2] riscv: implement Zicbom-based CMO instructions + the t-head variant
Date:   Mon,  7 Mar 2022 23:46:18 +0100
Message-Id: <20220307224620.1933061-1-heiko@sntech.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on the alternatives changes done in my svpbmt series
and thus also depends on Atish's isa-extension parsing series.

It implements using the cache-management instructions from the  Zicbom-
extension to handle cache flush, etc actions on platforms needing them.

SoCs using cpu cores from T-Head like the Allwinne D1 implement a
different set of cache instructions. But while they are different,
instructions they provide the same functionality, so a variant can
easly hook into the existing alternatives mechanism on those.


Heiko Stuebner (2):
  riscv: Implement Zicbom-based cache management operations
  riscv: implement cache-management errata for T-Head SoCs

 arch/riscv/Kconfig                   |  8 +++
 arch/riscv/Kconfig.erratas           | 10 ++++
 arch/riscv/errata/thead/errata.c     |  5 ++
 arch/riscv/include/asm/errata_list.h | 78 +++++++++++++++++++++++++++-
 arch/riscv/include/asm/hwcap.h       |  1 +
 arch/riscv/kernel/cpu.c              |  1 +
 arch/riscv/kernel/cpufeature.c       | 17 ++++++
 arch/riscv/mm/Makefile               |  1 +
 arch/riscv/mm/dma-noncoherent.c      | 61 ++++++++++++++++++++++
 9 files changed, 180 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/mm/dma-noncoherent.c

-- 
2.30.2

