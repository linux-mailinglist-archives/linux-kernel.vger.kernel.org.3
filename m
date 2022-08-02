Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FD658807B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 18:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238328AbiHBQuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 12:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238188AbiHBQuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 12:50:07 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E35E1101FE;
        Tue,  2 Aug 2022 09:50:04 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 272Go2L7021881;
        Tue, 2 Aug 2022 18:50:02 +0200
Date:   Tue, 2 Aug 2022 18:50:02 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Dipanjan Das <mail.dipanjan.das@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Denis Efremov <efremov@linux.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        fleischermarius@googlemail.com, its.priyanka.bose@gmail.com
Subject: Re: INFO: task hung in __floppy_read_block_0
Message-ID: <20220802165002.GA21797@1wt.eu>
References: <CANX2M5ZSuHONz-TPVdGcW3q_n6Z2DKLM6M8RfG+mORA9CCQRsQ@mail.gmail.com>
 <CAKXUXMxVCCRB2uaAN68LZv6Fwe7zAkUmwCmsqB6pE=z_=cztMg@mail.gmail.com>
 <CANX2M5b9PBp9i5v_akXshQqBFRT4dTHg+PR2pWpHPa5RBOEUTg@mail.gmail.com>
 <20220731095307.GA12211@1wt.eu>
 <CANX2M5YxE31gSU804jm6U4T6uTeCTjgk1gfHM+ockpjHnXfDrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANX2M5YxE31gSU804jm6U4T6uTeCTjgk1gfHM+ockpjHnXfDrw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 01, 2022 at 10:04:46PM -0700, Dipanjan Das wrote:
> On Sun, Jul 31, 2022 at 2:53 AM Willy Tarreau <w@1wt.eu> wrote:
> >
> > Thus I'm a bit confused about what to look for. It's very likely that
> > there are still bugs left in this driver, but trying to identify them
> > and to validate a fix will be difficult if they cannot be reproduced.
> > Maybe they only happen under emulation due to timing issues.
> >
> > As such, any hint about the exact setup and how long to wait to get
> > the error would be much appreciated.
> 
> We can confirm that we were able to trigger the issue on the latest
> 5.19 (commit: 3d7cb6b04c3f3115719235cc6866b10326de34cd) with the
> C-repro within a VM. We use this:
> https://syzkaller.appspot.com/text?tag=KernelConfig&x=cd73026ceaed1402
>  config to build the kernel. The issue triggers after around 143
> seconds. For all the five times we tried, we were able to reproduce
> the issue deterministically every time. Please let us know if you need
> any other information.

Yep, I could reproduce it under qemu as well. I've added traces, and
ugly things are happening with the lock (but I haven't understood what
yet). What I saw was that process_fd_request() is first called under
lock, then we drop the lock, then __floppy_read_block_0() is called
under lock, which calls process_fd_request(), then the lock is dropped,
wait_for_completion() is called, then process_fd_request() is called
again without lock this time, and from there we're looping in
fd_wait_for_completion. I need to dig into more details but it doesn't
seem right to me that process_fd_request() is sometimes called under a
lock and sometimes out, and that __floppy_read_block_0() is called with
a lock held and it's relesed under it. I could have missed certain things
due to the concurrent accesses but in any case I should probably not be
observing this.

I'll try to dig deeper. I really don't know that area and I must confess
it's not the most exciting to rediscover each time :-)

Thanks,
Willy
