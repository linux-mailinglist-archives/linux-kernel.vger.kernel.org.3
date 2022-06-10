Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA28C545940
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 02:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345758AbiFJAnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 20:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239961AbiFJAnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 20:43:33 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FDE3BE137;
        Thu,  9 Jun 2022 17:43:28 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1nzSk6-0001oS-NK; Fri, 10 Jun 2022 02:43:14 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, hch@lst.de, samuel@sholland.org,
        atishp@atishpatra.org, anup@brainfault.org, mick@ics.forth.gr,
        robh+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org,
        drew@beagleboard.org, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v3 0/3] riscv: implement Zicbom-based CMO instructions + the t-head variant
Date:   Fri, 10 Jun 2022 02:43:05 +0200
Message-Id: <20220610004308.1903626-1-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
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


An ongoing discussion is about the currently used pre-coded
instructions. Palmer's current thinking is that we should wait
until the relevant instructions have landed in binutils.

On the other hand this would result in massive waiting times
for all new instructions in the future as well, as it isn't only
the time till a binutils patch is accepted but also then the
wait for the next release and _after_ that the wait until these
new releases are available in regular distributions.

So ideally it would be nice to find some sort of compromise
in the middle somewhere.


The series sits on top of my svpbmt fixup series, which
for example includes the conversion away from function pointers
for the check-functions. And also uses my nops-series.


changes in v3:
- rebase onto 5.19-rc1 + svpbmt-fixup-series
- adapt wording for block-size binding
- include asm/cacheflush.h into dma-noncoherent to fix the
  no-prototype error clang seems to generate
- use __nops macro for readability
- add some received tags
- add a0 to the clobber list

changes in v2:
- cbom-block-size is hardware-specific and comes from firmware
- update Kconfig name to use the ISA extension name
- select the ALTERNATIVES symbol when enabled
- shorten the line lengths of the errata-assembly

Heiko Stuebner (3):
  dt-bindings: riscv: document cbom-block-size
  riscv: Implement Zicbom-based cache management operations
  riscv: implement cache-management errata for T-Head SoCs

 .../devicetree/bindings/riscv/cpus.yaml       |  5 +
 arch/riscv/Kconfig                            | 15 +++
 arch/riscv/Kconfig.erratas                    | 10 ++
 arch/riscv/errata/thead/errata.c              | 15 +++
 arch/riscv/include/asm/cacheflush.h           |  6 ++
 arch/riscv/include/asm/errata_list.h          | 76 ++++++++++++++-
 arch/riscv/include/asm/hwcap.h                |  1 +
 arch/riscv/kernel/cpu.c                       |  1 +
 arch/riscv/kernel/cpufeature.c                | 18 ++++
 arch/riscv/kernel/setup.c                     |  2 +
 arch/riscv/mm/Makefile                        |  1 +
 arch/riscv/mm/dma-noncoherent.c               | 93 +++++++++++++++++++
 12 files changed, 241 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/mm/dma-noncoherent.c

-- 
2.35.1

