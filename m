Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F53A4A480D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 14:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378792AbiAaN0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 08:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348723AbiAaN0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 08:26:32 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25573C06173D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 05:26:31 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:58b3:216b:d287:833])
        by michel.telenet-ops.be with bizsmtp
        id pRSU2600b2lsq0X06RSUsG; Mon, 31 Jan 2022 14:26:29 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nEWhQ-00CaW7-Kc; Mon, 31 Jan 2022 14:26:28 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nEWhP-00H7GS-To; Mon, 31 Jan 2022 14:26:27 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 0/3] RISC-V: Fix cpumask rework falloout
Date:   Mon, 31 Jan 2022 14:26:19 +0100
Message-Id: <cover.1643635156.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

This patch series intends to fix the fall-out from commit
26fb751ca37846c9 ("RISC-V: Do not use cpumask data structure for hartid
bitmap"), cfr. the discussion in thread[1].

Thanks for your comments!

[1] "[PATCH v3 6/6] RISC-V: Do not use cpumask data structure for hartid
     bitmap"
    https://lore.kernel.org/r/20220120090918.2646626-7-atishp@rivosinc.com/

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
