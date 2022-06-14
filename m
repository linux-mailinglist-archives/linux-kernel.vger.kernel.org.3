Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AE354B840
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 20:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242563AbiFNSF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 14:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238035AbiFNSFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 14:05:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8774666C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 11:05:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 49C601F8D7;
        Tue, 14 Jun 2022 18:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655229952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GIzC5m4VIawCPqN9AdaqRh8x0GtJQ/9Kc4xrd4raz1Q=;
        b=oH5k1z4RYZNWwR0xlp0zAraLdDxW7DNqsZ1A175H2B8MV3M0P/VcjaJd3fL/LDNIb21VuT
        EP3Uq9fLn+ZUBi8SGH6fDvbJ/2aqbdtq+CYczy5Gq6xTdZsHAB0xJDxPduCwX7kG+ulszX
        ojzRXSqXgFkiWZ9kYvjYIoG7LcUQwVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655229952;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GIzC5m4VIawCPqN9AdaqRh8x0GtJQ/9Kc4xrd4raz1Q=;
        b=bwHGEJzpqp6ZmbWScv3JU0i6kulB9ipvoO7GyJaZwStxr4HvxeHSghDE/sXYCji2oBwUoM
        RsLs3hBZdDqv3BDg==
Received: from quack3.suse.cz (jack.udp.ovpn1.nue.suse.de [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 06A532C141;
        Tue, 14 Jun 2022 18:05:52 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 39D3AA062E; Tue, 14 Jun 2022 20:05:49 +0200 (CEST)
Date:   Tue, 14 Jun 2022 20:05:49 +0200
From:   Jan Kara <jack@suse.cz>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jchao Sun <sunjunchao2870@gmail.com>, Jan Kara <jack@suse.cz>
Subject: Re: Linux 5.19-rc2
Message-ID: <20220614180549.lkcvi2qfnsy7d3gq@quack3.lan>
References: <CAHk-=wiLDbZ9ch9vSLxrYBdr-bBujr5sehH_HszWzSah54UiQw@mail.gmail.com>
 <20220613154640.GA3881687@roeck-us.net>
 <20220614170316.GA3690098@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614170316.GA3690098@roeck-us.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 14-06-22 10:03:16, Guenter Roeck wrote:
> On Mon, Jun 13, 2022 at 08:46:42AM -0700, Guenter Roeck wrote:
> > 
> > There are also various UAF and "spinlock bad magic" BUG/WARNING logs in arm
> > boot tests. I don't know if those are new or if I just see them now because
> > I enabled KFENCE. Here is an (incomplete) sample.
> > 
> > [    0.430290] printk: console [ramoops-1] printing thread started
> > [    0.436219] BUG: spinlock bad magic on CPU#0, kdevtmpfs/23
> > [    0.436250]  lock: noop_backing_dev_info+0x6c/0x3b0, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> > [    0.436808] CPU: 0 PID: 23 Comm: kdevtmpfs Not tainted 5.19.0-rc2 #1
> > 
> 
> This is caused by commit 10e14073107dd0 ("writeback: Fix inode->i_io_list
> not be protected by inode->i_lock error"). Reverting this commit fixes
> the problem. Here is a complete backtrace:

Yeah, I've already queued a fix into my tree, I'll send it to Linus
tomorrow. With kdevtmpfs inode gets dirtied before noop_backing_dev_info is
initialized...

								Honza

> 
> BUG: spinlock bad magic on CPU#0, kdevtmpfs/16
>  lock: noop_backing_dev_info+0x6c/0x3b0, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> CPU: 0 PID: 16 Comm: kdevtmpfs Not tainted 5.19.0-rc2-00001-g8bd0807eb95c #1
> Hardware name: ARM RealView Machine (Device Tree Support)
>  unwind_backtrace from show_stack+0x10/0x14
>  show_stack from dump_stack_lvl+0x68/0x90
>  dump_stack_lvl from do_raw_spin_lock+0xa8/0xf4
>  do_raw_spin_lock from __mark_inode_dirty+0x1a4/0x664
>  __mark_inode_dirty from simple_setattr+0x44/0x5c
>  simple_setattr from notify_change+0x404/0x460
>  notify_change from devtmpfsd+0x1ec/0x2b8
>  devtmpfsd from kthread+0xe0/0x104
>  kthread from ret_from_fork+0x14/0x24
> Exception stack(0xe0851fb0 to 0xe0851ff8)
> 1fa0:                                     00000000 00000000 00000000 00000000
> 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> 
> Guenter
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
