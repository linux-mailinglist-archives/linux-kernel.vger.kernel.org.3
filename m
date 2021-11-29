Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C47546209A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbhK2TiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbhK2TgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:36:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70093C0619FF
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 07:52:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59011B811EF
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 15:52:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5199CC53FAD;
        Mon, 29 Nov 2021 15:52:25 +0000 (UTC)
Date:   Mon, 29 Nov 2021 16:52:21 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     syzbot <syzbot+dfac92a50024b54acaa4@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, cxfcosmos@gmail.com,
        ebiederm@xmission.com, legion@kernel.org,
        linux-kernel@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KMSAN: uninit-value in from_kuid
Message-ID: <20211129155221.fvbtsrz6zumo5bpf@wittgenstein>
References: <000000000000a0d53f05d1c72a4c@google.com>
 <20211129114713.at2mo64hgnlmkx3x@wittgenstein>
 <CAG_fn=UGPTizsqgvYNnVkPK9TeXhyyi8f92Qnpy=cN7S4JzeCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG_fn=UGPTizsqgvYNnVkPK9TeXhyyi8f92Qnpy=cN7S4JzeCw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 04:16:21PM +0100, Alexander Potapenko wrote:
> On Mon, Nov 29, 2021 at 12:47 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > On Sat, Nov 27, 2021 at 07:50:27AM -0800, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    425295055ce6 kmsan: core: address comments to kmsan-checks.h
> > > git tree:       https://github.com/google/kmsan.git master
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1640209ab00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=2d142cdf4204061
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=dfac92a50024b54acaa4
> > > compiler:       clang version 14.0.0 (git@github.com:llvm/llvm-project.git 0996585c8e3b3d409494eb5f1cad714b9e1f7fb5), GNU ld (GNU Binutils for Debian) 2.35.2
> > > userspace arch: i386
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+dfac92a50024b54acaa4@syzkaller.appspotmail.com
> > >
> > > =====================================================
> > > BUG: KMSAN: uninit-value in map_id_up_base kernel/user_namespace.c:335 [inline]
> > > BUG: KMSAN: uninit-value in map_id_up kernel/user_namespace.c:365 [inline]
> > > BUG: KMSAN: uninit-value in from_kuid+0x51d/0xbd0 kernel/user_namespace.c:413
> > >  map_id_up_base kernel/user_namespace.c:335 [inline]
> > >  map_id_up kernel/user_namespace.c:365 [inline]
> > >  from_kuid+0x51d/0xbd0 kernel/user_namespace.c:413
> > >  p9pdu_vwritef+0x15ab/0x5120 net/9p/protocol.c:398
> > >  p9pdu_writef+0x23a/0x280 net/9p/protocol.c:539
> > >  p9pdu_vwritef+0x21f0/0x5120 net/9p/protocol.c:490
> > >  p9_client_prepare_req+0xa4b/0xff0 net/9p/client.c:709
> > >  p9_client_rpc+0x278/0x1410 net/9p/client.c:740
> > >  p9_client_setattr+0x115/0x2c0 net/9p/client.c:1899
> > >  v9fs_vfs_setattr_dotl+0x7e2/0xd70 fs/9p/vfs_inode_dotl.c:590
> > >  notify_change+0x1fe3/0x2170 fs/attr.c:410
> > >  vfs_utimes+0x8aa/0xc70 fs/utimes.c:65
> > >  do_utimes_path fs/utimes.c:98 [inline]
> > >  do_utimes fs/utimes.c:144 [inline]
> > >  __do_sys_utime32 fs/utimes.c:247 [inline]
> > >  __se_sys_utime32+0x386/0x520 fs/utimes.c:235
> > >  __ia32_sys_utime32+0x91/0xc0 fs/utimes.c:235
> > >  do_syscall_32_irqs_on arch/x86/entry/common.c:114 [inline]
> > >  __do_fast_syscall_32+0x96/0xf0 arch/x86/entry/common.c:180
> > >  do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
> > >  do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
> > >  entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
> > >
> > > Uninit was stored to memory at:
> > >  v9fs_vfs_setattr_dotl+0x58a/0xd70 fs/9p/vfs_inode_dotl.c:567
> >
> > That's a bug in the 9P2000.L implementation of .setattr.
> > It copies struct iattr values without checking ia_valid. That's causing
> > uninitalized memory to be copied. I sent a fix to 9p for this.
> >
> > Christian
> 
> Christian,
> 
> Do you think it makes sense to request a CVE for this issue?
> If so, were you going to request one? Otherwise I can do that.

I mean, it's neither my bug nor did I detect it, I just fixed it. :)
If you would like this to be a CVE then sure go ahead.

(I don't understand the rules around this well enough tbh. For example,
during the last merge window there were at least 3 or 4 NULL pointer
derefs or UAFs in newly added but already released code. Should all of
these get a CVE without a working exploit?)
