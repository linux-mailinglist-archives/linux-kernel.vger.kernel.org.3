Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9A64C1173
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240005AbiBWLiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240041AbiBWLh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:37:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DA856764;
        Wed, 23 Feb 2022 03:37:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66AF0B81F01;
        Wed, 23 Feb 2022 11:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3F8C340E7;
        Wed, 23 Feb 2022 11:37:27 +0000 (UTC)
Date:   Wed, 23 Feb 2022 11:37:23 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Will Deacon <will@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] arm64: Change elfcore for_each_mte_vma() to use VMA
 iterator
Message-ID: <YhYcc+CGWuO0tUG+@arm.com>
References: <20220218014642.lop2ohx4ov6fekyl@revolver>
 <20220218023650.672072-1-Liam.Howlett@oracle.com>
 <YhPUuu+6TPMKjhwk@arm.com>
 <20220222142557.6oykxjz3j7fq4mrn@revolver>
 <20220222162016.GA16436@willie-the-truck>
 <YhUcywqIhmHvX6dG@arm.com>
 <20220222185401.jntcd4g62pamfxvr@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222185401.jntcd4g62pamfxvr@revolver>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 06:54:38PM +0000, Liam Howlett wrote:
> Once the maple tree is upstream, then you can take the patch I posted.

BTW, on the maple tree branch alone
(https://github.com/oracle/linux-uek.git maple/mainline), I get the
warning below and no core file generated. It's not MTE related as it
doesn't have my patches.

[   67.887638] WARNING: CPU: 1 PID: 528 at fs/coredump.c:1116 dump_vma_snapshot+0x98/0x18c
[   67.888594] Modules linked in: crct10dif_ce sm3_ce sm3_generic sha3_ce sha3_generic sha512_ce sha512_arm64 drm fuse ip_tables x_tables ipv6
[   67.890017] CPU: 1 PID: 528 Comm: mte-coredump Not tainted 5.17.0-rc4-00071-gc8cf067d6a99 #1
[   67.890494] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
[   67.891054] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   67.891469] pc : dump_vma_snapshot+0x98/0x18c
[   67.891787] lr : dump_vma_snapshot+0x74/0x18c
[   67.892071] sp : ffff80000839b8f0
[   67.892278] x29: ffff80000839b8f0 x28: ffffd4a81d76255c x27: 0000000000000000
[   67.892894] x26: ffffd4a81da308e0 x25: 0000000000000000 x24: ffff80000839bc78
[   67.893436] x23: ffff00000557cf00 x22: ffff00000557cf60 x21: ffff80000839b9e0
[   67.893922] x20: ffff80000839b9e8 x19: ffff80000839b9dc x18: 0000000000000000
[   67.894497] x17: 0000000000000000 x16: 0000ffff9e8effff x15: 0000000000000000
[   67.895061] x14: 0000000000000000 x13: ffff0000025f9000 x12: ffff000001a2eb94
[   67.895590] x11: ffff80000839b100 x10: ffff80000839b108 x9 : 0000000000000000
[   67.896057] x8 : ffff80000839bb68 x7 : 0000000000000000 x6 : 0000000000896101
[   67.896537] x5 : ffff0000016bf000 x4 : ffff80000839b8b0 x3 : 0000000000000001
[   67.896961] x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000000011
[   67.897493] Call trace:
[   67.897679]  dump_vma_snapshot+0x98/0x18c
[   67.898034]  elf_core_dump+0x50/0xcf0
[   67.898274]  do_coredump+0xbdc/0xfc4
[   67.898553]  get_signal+0x524/0x7f0
[   67.898775]  do_notify_resume+0x224/0x1330
[   67.899046]  el0_da+0x50/0x60
[   67.899431]  el0t_64_sync_handler+0xec/0x130
[   67.899726]  el0t_64_sync+0x1a0/0x1a4

-- 
Catalin
