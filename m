Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8364AED4B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239672AbiBIIya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:54:30 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbiBIIyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:54:22 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D21E02F54E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 00:54:17 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:54c7:c522:3859:290])
        by baptiste.telenet-ops.be with bizsmtp
        id swu4260014VQqf501wu4K1; Wed, 09 Feb 2022 09:54:05 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nHijj-000DIg-CE; Wed, 09 Feb 2022 09:54:03 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nHiji-00DkLg-LU; Wed, 09 Feb 2022 09:54:02 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atishp@rivosinc.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Anup Patel <anup@brainfault.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 0/3] RISC-V: Fix cpumask rework fall-out
Date:   Wed,  9 Feb 2022 09:53:58 +0100
Message-Id: <cover.1644396407.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

This patch series fixes the fall-out from commit 26fb751ca37846c9
("RISC-V: Do not use cpumask data structure for hartid bitmap"), cfr.
the discussion in thread[1].  Most important, it fixes userspace crashes
on systems where the first CPU does not have the lowest Hart ID.

Changes compared to v1[2]:
  - Add Reviewed-by, Tested-by.

Thanks for applying!

[1] "[PATCH v3 6/6] RISC-V: Do not use cpumask data structure for hartid
     bitmap"
    https://lore.kernel.org/r/20220120090918.2646626-7-atishp@rivosinc.com/
[2] "[PATCH 0/3] RISC-V: Fix cpumask rework falloout"
    https://lore.kernel.org/all/cover.1643635156.git.geert@linux-m68k.org/

Geert Uytterhoeven (3):
  RISC-V: Fix hartid mask handling for hartid 31 and up
  RISC-V: Fix handling of empty cpu masks
  RISC-V: Fix IPI/RFENCE hmask on non-monotonic hartid ordering

 arch/riscv/kernel/sbi.c | 72 +++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 25 deletions(-)

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
