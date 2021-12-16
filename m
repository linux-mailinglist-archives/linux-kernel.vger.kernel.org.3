Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B2C476D95
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbhLPJns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 04:43:48 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:46658 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbhLPJns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:43:48 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 00DB41F3D5;
        Thu, 16 Dec 2021 09:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639647827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dh6YC8SOSUMmMcaE4BY5DWlZcxhiBx24lrQBfIqpAxM=;
        b=nasJIIQH779rE7GupmO7O2G5ewZ6PnRiaShYGCl6qQXsvqdsDld6CEoXGKseSuiVTUOalW
        ewqd7Y5GmwLtBdtUooeKQ/YshYkDUp3XhevqMBDHkmTEEThVVMGcqgGyf0AuD/Hh8YiJTs
        utS9DKD0xeUcHM9jwjrxYoj0+C19JF0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B044E13C32;
        Thu, 16 Dec 2021 09:43:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Is8/KVIKu2GVCQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 16 Dec 2021 09:43:46 +0000
Date:   Thu, 16 Dec 2021 10:43:45 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     lkp <oliver.sang@intel.com>
Cc:     Tejun Heo <tj@kernel.org>, 0day robot <lkp@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        torvalds@linuxfoundation.org, ebiederm@xmission.com,
        axboe@kernel.dk, keescook@chromium.org, oleg@redhat.com,
        peterz@infradead.org, tglx@linutronix.de, jnewsome@torproject.org,
        legion@kernel.org, luto@amacapital.net, jannh@google.com,
        security@kernel.org, kernel-team@fb.com
Subject: Re: [cgroup]  27183b4e07: WARNING:at_mm/slab.c:#___cache_free
Message-ID: <20211216094345.GA58142@blackbody.suse.cz>
References: <20211213191833.916632-3-tj@kernel.org>
 <20211216092255.GB10708@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216092255.GB10708@xsang-OptiPlex-9020>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 05:22:55PM +0800, kernel test robot <oliver.sang@intel.com> wrote:
> commit: 27183b4e0735229f7ab300f000f78c9badf2a110 ("[PATCH 2/6] cgroup: Allocate cgroup_file_ctx for kernfs_open_file->priv")
> url: https://github.com/0day-ci/linux/commits/Tejun-Heo/cgroup-Use-open-time-credentials-for-process-migraton-perm-checks/20211214-041859
> base: https://git.kernel.org/cgit/linux/kernel/git/tj/cgroup.git for-next
> patch link: https://lore.kernel.org/lkml/20211213191833.916632-3-tj@kernel.org

TL;DR This is the v2 patch and this situation is fixed in v3 [1].

FWIW, the full log reports a BUG later:

> [   52.570729][    T1] BUG: unable to handle page fault for address: ffffffffffffffe0
> [   52.571736][    T1] #PF: supervisor read access in kernel mode
> [   52.572490][    T1] #PF: error_code(0x0000) - not-present page
> [   52.573271][    T1] PGD 542b067 P4D 542b067 PUD 542d067 PMD 0
> [   52.574056][    T1] Oops: 0000 [#1] PTI
> [   52.574580][    T1] CPU: 0 PID: 1 Comm: systemd Tainted: G        W         5.16.0-rc1-00009-g27183b4e0735 #1
> [   52.575935][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [   52.577101][    T1] RIP: 0010:cgroup_pidlist_find+0x67/0x100
> [   52.577863][    T1] Code: 03 00 00 48 8d bb c0 03 00 00 48 8d 42 e0 48 39 d7 75 17 eb 37 48 8b 50 20 48 83 05 c2 d5 5a 06 01 48 8d 42 e0 48 39 d7 74 22 <44> 39 20 75 e6 48 83 05 9c d5 5a 06 01 4c 39 68 08 75 d8 5b 48 83
> [   52.580455][    T1] RSP: 0018:ffff888100363ce0 EFLAGS: 00010286
> [   52.581260][    T1] RAX: ffffffffffffffe0 RBX: ffff888123128800 RCX: 0000000000000003
> [   52.582341][    T1] RDX: 0000000000000000 RSI: ffff888123128c38 RDI: ffff888123128bc0
> [   52.583386][    T1] RBP: ffff888100363cf8 R08: 0000000000000000 R09: 0000000000000003
> [   52.584416][    T1] R10: ffff888100363cf8 R11: ffff888123128c38 R12: 0000000000000000
> [   52.585452][    T1] R13: ffffffff8554a980 R14: ffff888123128800 R15: ffff888123090800
> [   52.586479][    T1] FS:  0000000000000000(0000) GS:ffffffff854fa000(0063) knlGS:00000000f784b6c0
> [   52.587696][    T1] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> [   52.588521][    T1] CR2: ffffffffffffffe0 CR3: 0000000129f42000 CR4: 00000000000406b0
> [   52.589543][    T1] Call Trace:
> [   52.589972][    T1]  <TASK>
> [   52.590357][    T1]  cgroup_pidlist_start+0x85/0x180
> [   52.591035][    T1]  cgroup_seqfile_start+0x29/0x40
> [   52.591706][    T1]  kernfs_seq_start+0x6e/0x100
> [   52.592355][    T1]  ? kvmalloc_node+0xd6/0x140
> [   52.593068][    T1]  seq_read_iter+0x13b/0x680
> [   52.593627][    T1]  ? up_read+0x36/0x50
> [   52.594124][    T1]  kernfs_fop_read_iter+0x4f/0x60
> [   52.594783][    T1]  new_sync_read+0x14e/0x240
> [   52.595373][    T1]  vfs_read+0x190/0x2c0
> [   52.595925][    T1]  ksys_read+0x70/0x150
> [   52.596463][    T1]  __ia32_sys_read+0x1b/0x30
> [   52.597057][    T1]  __do_fast_syscall_32+0x77/0x100
> [   52.597711][    T1]  do_fast_syscall_32+0x33/0x80
> [   52.598310][    T1]  do_SYSENTER_32+0x1f/0x30
> [   52.598890][    T1]  entry_SYSENTER_compat_after_hwframe+0x4d/0x5f
> [   52.599777][    T1] RIP: 0023:0xf7fb7549
> [   52.600308][    T1] Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
> [   52.602731][    T1] RSP: 002b:00000000fff99188 EFLAGS: 00000206 ORIG_RAX: 0000000000000003
> [   52.603796][    T1] RAX: ffffffffffffffda RBX: 0000000000000024 RCX: 00000000583ac988
> [   52.604817][    T1] RDX: 0000000000001000 RSI: 00000000583f6e10 RDI: 00000000f7c48960
> [   52.605833][    T1] RBP: 00000000fff991d8 R08: 0000000000000000 R09: 0000000000000000
> [   52.606825][    T1] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [   52.607838][    T1] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [   52.608839][    T1]  </TASK>
> [   52.609226][    T1] Modules linked in:
> [   52.609731][    T1] CR2: ffffffffffffffe0
> [   52.610242][    T1] ---[ end trace 08fad742e8d71fbb ]---

This looks very much like UAF via cgrp->pidlists which was the fixed.

Michal

[1] https://lore.kernel.org/r/Ybj0GqMfY4n2TSSn@slm.duckdns.org/
