Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A208754E8E6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236657AbiFPRvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 13:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbiFPRvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 13:51:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5EC4C787
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 10:51:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA0FB61B60
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 17:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0684AC34114;
        Thu, 16 Jun 2022 17:51:05 +0000 (UTC)
Date:   Thu, 16 Jun 2022 18:51:02 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] KVM: arm64: Prevent kmemleak from accessing pKVM memory
Message-ID: <YqtthvVxgQ6K0nEt@arm.com>
References: <20220616161135.3997786-1-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616161135.3997786-1-qperret@google.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 04:11:34PM +0000, Quentin Perret wrote:
> Commit a7259df76702 ("memblock: make memblock_find_in_range method
> private") changed the API using which memory is reserved for the pKVM
> hypervisor. However, it seems that memblock_phys_alloc() differs
> from the original API in terms of kmemleak semantics -- the old one
> excluded the reserved regions from kmemleak scans when the new one
> doesn't seem to. Unfortunately, when protected KVM is enabled, all
> kernel accesses to pKVM-private memory result in a fatal exception,
> which can now happen because of kmemleak scans:
> 
> $ echo scan > /sys/kernel/debug/kmemleak
> [   34.991354] kvm [304]: nVHE hyp BUG at: [<ffff800008fa3750>] __kvm_nvhe_handle_host_mem_abort+0x270/0x290!
> [   34.991580] kvm [304]: Hyp Offset: 0xfffe8be807e00000
> [   34.991813] Kernel panic - not syncing: HYP panic:
> [   34.991813] PS:600003c9 PC:0000f418011a3750 ESR:00000000f2000800
> [   34.991813] FAR:ffff000439200000 HPFAR:0000000004792000 PAR:0000000000000000
> [   34.991813] VCPU:0000000000000000
> [   34.993660] CPU: 0 PID: 304 Comm: bash Not tainted 5.19.0-rc2 #102
> [   34.994059] Hardware name: linux,dummy-virt (DT)
> [   34.994452] Call trace:
> [   34.994641]  dump_backtrace.part.0+0xcc/0xe0
> [   34.994932]  show_stack+0x18/0x6c
> [   34.995094]  dump_stack_lvl+0x68/0x84
> [   34.995276]  dump_stack+0x18/0x34
> [   34.995484]  panic+0x16c/0x354
> [   34.995673]  __hyp_pgtable_total_pages+0x0/0x60
> [   34.995933]  scan_block+0x74/0x12c
> [   34.996129]  scan_gray_list+0xd8/0x19c
> [   34.996332]  kmemleak_scan+0x2c8/0x580
> [   34.996535]  kmemleak_write+0x340/0x4a0
> [   34.996744]  full_proxy_write+0x60/0xbc
> [   34.996967]  vfs_write+0xc4/0x2b0
> [   34.997136]  ksys_write+0x68/0xf4
> [   34.997311]  __arm64_sys_write+0x20/0x2c
> [   34.997532]  invoke_syscall+0x48/0x114
> [   34.997779]  el0_svc_common.constprop.0+0x44/0xec
> [   34.998029]  do_el0_svc+0x2c/0xc0
> [   34.998205]  el0_svc+0x2c/0x84
> [   34.998421]  el0t_64_sync_handler+0xf4/0x100
> [   34.998653]  el0t_64_sync+0x18c/0x190
> [   34.999252] SMP: stopping secondary CPUs
> [   35.000034] Kernel Offset: disabled
> [   35.000261] CPU features: 0x800,00007831,00001086
> [   35.000642] Memory Limit: none
> [   35.001329] ---[ end Kernel panic - not syncing: HYP panic:
> [   35.001329] PS:600003c9 PC:0000f418011a3750 ESR:00000000f2000800
> [   35.001329] FAR:ffff000439200000 HPFAR:0000000004792000 PAR:0000000000000000
> [   35.001329] VCPU:0000000000000000 ]---
> 
> Fix this by explicitly excluding the hypervisor's memory pool from
> kmemleak like we already do for the hyp BSS.
> 
> Cc: Mike Rapoport <rppt@kernel.org>
> Fixes: a7259df76702 ("memblock: make memblock_find_in_range method private")
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
> An alternative could be to actually exclude memory allocated using
> memblock_phys_alloc_range() from kmemleak scans to revert back to the
> old behaviour. But nobody else has complained about this AFAIK, so I'd
> be inclined to keep this local to pKVM. No strong opinion.

This works for me, I haven't heard anyone else complaining.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
