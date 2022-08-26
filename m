Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AB95A301E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 21:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344640AbiHZTl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 15:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbiHZTlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 15:41:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845C081685;
        Fri, 26 Aug 2022 12:41:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46D35B8321C;
        Fri, 26 Aug 2022 19:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF17C433C1;
        Fri, 26 Aug 2022 19:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661542911;
        bh=IArRZaFN1D+1gYL9idbVQ+jcfSdbsGcEgrIb0exuq4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q3O7YcoP2ZzwBhqdDhGxMFobtuLRCxcJTF+awe9rvyNOscwZrZhyc5c9BEQuiEug0
         cxibM2cYZPVGXZsJQBw39uNAXH0s70uWLgyi3bbyw9hNSEmnw+j1DunnaPRE1lotOp
         +M4aEz5WaoIFr0/4OpPERmE9Je8nlGTNej7q6uN7NGa/lDCtTNGuQmwQQdrJ0CIWlc
         IvnvBiKOvns9XjJtiv3Xmcqh9gpReOgGr6xpdOdKEeX7HnLE689/gpZucXMucD3w1s
         f1pwon86LfT0QkLs7QoCBu7H8qSXEco7vUsy0sM45IxQ/97q8D5xknLfcFlYdqN6yP
         1XLEKuHs63Uxg==
Date:   Fri, 26 Aug 2022 22:41:44 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-sgx@vger.kernel.org,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] x86/sgx: Do not consider unsanitized pages an error
Message-ID: <Ywkh+ChYvUW3zwfD@kernel.org>
References: <20220826014126.291156-1-jarkko@kernel.org>
 <fd6f124d-1d7d-0e73-10bd-f7aaae45ee68@molgen.mpg.de>
 <4645fdb3-2836-0028-dee9-7a9321f1ebf2@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4645fdb3-2836-0028-dee9-7a9321f1ebf2@molgen.mpg.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 07:21:44PM +0200, Paul Menzel wrote:
> Dear Jarkko,
> 
> 
> Am 26.08.22 um 14:51 schrieb Paul Menzel:
> 
> […]
> 
> > Am 26.08.22 um 03:41 schrieb Jarkko Sakkinen:
> > > In sgx_init(), if misc_register() for the provision device fails, and
> > > neither sgx_drv_init() nor sgx_vepc_init() succeeds, then ksgxd will be
> > > prematurely stopped.
> > > 
> > > This triggers WARN_ON() because sgx_dirty_page_list ends up being
> > > non-empty. Ultimately this can crash the kernel, depending on the kernel
> > > command line, which is not correct behavior because SGX driver is not
> > > working incorrectly.
> > 
> > Maybe paste the WARN_ON trace, so `git log` can be searched for the
> > trace too.
> > 
> > > Print simple warning instead, and improve the output by printing the
> > > number of unsanitized pages.
> > 
> > See below, but no warning seems to be logged in my case now. (I should
> > test Linus’ current master too.)
> 
> Just for the record, the problem still exists in Linus’ master branch:
> 
> ```
> [    0.000000] Linux version 6.0.0-rc2 (root@4beb429beb4a) (gcc (Debian
> 11.3.0-3) 11.3.0, GNU ld (GNU Binutils for Debian) 2.38) #382 SMP
> PREEMPT_DYNAMIC Fri Aug 26 12:52:15 UTC 2022
> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.0.0-rc2
> root=UUID=56f398e0-1e25-4fda-aa9f-611dece4b333 ro quiet
> module_blacklist=psmouse initcall_debug log_buf_len=4M cryptomgr.notests
> […]
> [    0.268089] calling  sgx_init+0x0/0x409 @ 1
> [    0.268103] sgx: EPC section 0x40200000-0x45f7ffff
> [    0.268591] ------------[ cut here ]------------
> [    0.268592] WARNING: CPU: 6 PID: 83 at arch/x86/kernel/cpu/sgx/main.c:401
> ksgxd+0x1b7/0x1d0
> [    0.268598] Modules linked in:
> [    0.268600] CPU: 6 PID: 83 Comm: ksgxd Not tainted 6.0.0-rc2 #382
> [    0.268603] Hardware name: Dell Inc. XPS 13 9370/0RMYH9, BIOS 1.21.0
> 07/06/2022
> [    0.268604] RIP: 0010:ksgxd+0x1b7/0x1d0
> [    0.268607] Code: ff e9 f2 fe ff ff 48 89 df e8 75 07 0e 00 84 c0 0f 84
> c3 fe ff ff 31 ff e8 e6 07 0e 00 84 c0 0f 85 94 fe ff ff e9 af fe ff ff <0f>
> 0b e9 7f fe ff ff e8 dd 9c 95 00 66 66 2e 0f 1f 84 00 00 00 00
> [    0.268608] RSP: 0000:ffffb6c7404f3ed8 EFLAGS: 00010287
> [    0.268610] RAX: ffffb6c740431a10 RBX: ffff8dcd8117b400 RCX:
> 0000000000000000
> [    0.268612] RDX: 0000000080000000 RSI: ffffb6c7404319d0 RDI:
> 00000000ffffffff
> [    0.268613] RBP: ffff8dcd820a4d80 R08: ffff8dcd820a4180 R09:
> ffff8dcd820a4180
> [    0.268614] R10: 0000000000000000 R11: 0000000000000006 R12:
> ffffb6c74006bce0
> [    0.268615] R13: ffff8dcd80e63880 R14: ffffffffa8a60f10 R15:
> 0000000000000000
> [    0.268616] FS:  0000000000000000(0000) GS:ffff8dcf25580000(0000)
> knlGS:0000000000000000
> [    0.268617] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.268619] CR2: 0000000000000000 CR3: 0000000213410001 CR4:
> 00000000003706e0
> [    0.268620] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [    0.268621] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [    0.268622] Call Trace:
> [    0.268624]  <TASK>
> [    0.268627]  ? _raw_spin_lock_irqsave+0x24/0x60
> [    0.268632]  ? _raw_spin_unlock_irqrestore+0x23/0x40
> [    0.268634]  ? __kthread_parkme+0x36/0x90
> [    0.268637]  kthread+0xe5/0x110
> [    0.268639]  ? kthread_complete_and_exit+0x20/0x20
> [    0.268642]  ret_from_fork+0x1f/0x30
> [    0.268647]  </TASK>
> [    0.268648] ---[ end trace 0000000000000000 ]---
> [    0.268694] initcall sgx_init+0x0/0x409 returned -19 after 603 usecs
> ```
> 
> Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>

Thank you.

BR, Jarkko
