Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D115C46BC88
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 14:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237137AbhLGNcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 08:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237097AbhLGNb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:31:58 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B94C061748
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 05:28:28 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J7h2M0X1Yz4xgs;
        Wed,  8 Dec 2021 00:28:27 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Erhard Furtner <erhard_f@mailbox.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <93c9b84d6ec76aaf7b4f03468e22433a6d308674.1638267035.git.christophe.leroy@csgroup.eu>
References: <93c9b84d6ec76aaf7b4f03468e22433a6d308674.1638267035.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/modules: Don't WARN on first module allocation tentative
Message-Id: <163888363074.3690807.14433778326427790491.b4-ty@ellerman.id.au>
Date:   Wed, 08 Dec 2021 00:27:10 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2021 11:10:43 +0100, Christophe Leroy wrote:
> module_alloc() first tries to allocate module text within
> 24 bits direct jump from kernel text, and tries a wider
> allocation if first one fails.
> 
> When first allocation fails the following is observed in kernel logs:
> 
> vmap allocation for size 2400256 failed: use vmalloc=<size> to increase size
> systemd-udevd: vmalloc error: size 2395133, vm_struct allocation failed, mode:0xcc0(GFP_KERNEL), nodemask=(null)
> CPU: 0 PID: 127 Comm: systemd-udevd Tainted: G        W         5.15.5-gentoo-PowerMacG4 #9
> Call Trace:
> [e2a53a50] [c0ba0048] dump_stack_lvl+0x80/0xb0 (unreliable)
> [e2a53a70] [c0540128] warn_alloc+0x11c/0x2b4
> [e2a53b50] [c0531be8] __vmalloc_node_range+0xd8/0x64c
> [e2a53c10] [c00338c0] module_alloc+0xa0/0xac
> [e2a53c40] [c027a368] load_module+0x2ae0/0x8148
> [e2a53e30] [c027fc78] sys_finit_module+0xfc/0x130
> [e2a53f30] [c0035098] ret_from_syscall+0x0/0x28
> --- interrupt: c00 at 0x25df10
> NIP:  0025df10 LR: 00416180 CTR: 00000000
> REGS: e2a53f40 TRAP: 0c00   Tainted: G        W          (5.15.5-gentoo-PowerMacG4)
> MSR:  0000d032 <EE,PR,ME,IR,DR,RI>  CR: 2822242c  XER: 20000000
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/modules: Don't WARN on first module allocation tentative
      https://git.kernel.org/powerpc/c/f1797e4de1146009c888bcf8b6bb6648d55394f1

cheers
