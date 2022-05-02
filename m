Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B91516E61
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 12:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384590AbiEBKwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 06:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358404AbiEBKwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 06:52:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2AF1B6
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 03:49:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5728EB810C6
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 10:49:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC88C385A4;
        Mon,  2 May 2022 10:49:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="axGemv1N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651488542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BDxeUUQ1mW3QD3Cl4K2XoeRHmRJQjJKbTLQKrompsuo=;
        b=axGemv1NqcfwCtwBjuEOsP03dYWRyUyP3O4BWrlsUTWNlcyQwuxwJ0q3nmQo+jFdSAfn8I
        BKyX6FBJgeo0hOciySfNZEnRo+bD4WgAgILBO7e+HFdsfbcYVpoI6OPSoDxfiJmeclFUr2
        bIJBCwJEuKDMpR/fS5wJMIWUfhocREg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e82d0061 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 2 May 2022 10:49:02 +0000 (UTC)
Date:   Mon, 2 May 2022 12:49:00 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: Changes in kernel 5.18-rc1 leads to crashes in VirtualBox
 Virtual Machines
Message-ID: <Ym+3HHaSBeeekuvz@zx2c4.com>
References: <7f01221d-f693-adf8-f5a5-d71944b44162@lwfinger.net>
 <Ym7Hw9GDPP838JoH@zx2c4.com>
 <6bd35831-2d7a-77ee-55e9-755ca752b0c8@lwfinger.net>
 <Ym8YlXYM4HQg8tq7@zx2c4.com>
 <Ym8hoW7J60xAQv8f@zx2c4.com>
 <Ym8uPcuQpq1xBS6d@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ym8uPcuQpq1xBS6d@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Larry,

On Mon, May 2, 2022 at 4:55 AM Larry Finger <Larry.Finger@lwfinger.net> wrote:
> On 5/1/22 20:05, Jason A. Donenfeld wrote:
> > Hi Larry,
> >
> > On Mon, May 02, 2022 at 02:11:13AM +0200, Jason A. Donenfeld wrote:
> >> Hey again,
> >>
> >> I just installed VirtualBox ontop of 5.18-rc4, and then I made a new VM
> >> with a fresh install of OpenSUSE, and everything is fine. No issues at
> >> all.
> >>
> >> So you're going to have to provide more information.
> >>
> >> Jason
> >
> > With still no more information provided from you, I've gone scouring and
> > found your much more informative bug report here:
> > https://www.virtualbox.org/ticket/20914 along with a larger log here
> > https://www.virtualbox.org/attachment/ticket/20914/Windows%2010%20Clone-2022-04-24-20-55-56.log
> >
> > Why would you not have sent me all this information right away? Surely
> > you know how to report bugs. If you're going to concern me with the
> > possibility that I've broken something, at least give me enough detail
> > to be able to do something. Otherwise it's pure frustration.
> >
> > Anyway, it's still too little information, but I could extract the
> > Windows build from that log file, pull down ntoskrnl.exe and hope it
> > roughly matches, and then go to work in IDA Pro trying to figure out
> > what's going on at ntoskrnl.exe+3f7d50, and if I managed to grab the
> > right build -- which I more than likely did not -- then that's a `mov
> > byte ptr gs:853h, 0` in KiInterruptDispatch, which seems entirely
> > unrelated to the change you mentioned.
> >
> > So I think it'd be a good moment for you to show your bisect logs so we
> > can be certain we're after the right thing.
>
> LKML removed from cc due to large files.
>
> Yes, I do know how to report bugs. If you remember my first E-mail, I was just
> looking for some suggestions on how using rdrand and rdseed could conflict with
> your changes. I'm sorry that you think I'm wasting your time.
>
> Where did you get your copy of VirtualBox? Perhaps they have some fixes that I
> do not know about.

I patched
<https://dev.gentoo.org/~polynomial-c/virtualbox/vbox-kernel-module-src-6.1.34.tar.xz>
using <https://xn--4db.cc/AtB1jwli>.

> My bisect logs are gone. I will need to recreate them and I should have them
> tomorrow. I do have my paper log to create the bisect. I will have it for you
> tomorrow.
>
> I ran the VM again and got a slightly different result. The kernel exception was
> at ntoskrnl.exe+458647.The mini dump is attached. The ntosknl.exe is available
> at https:/lwfinger.com/download/ntosknl.exe.gz.

You spelled your URL wrong in two places. Had to guess how to fix it.
Please spend more time with your bug reports. This is already more
painful than it should be.

From looking at the minidump you sent, I don't see how this is related
to the RNG. Maybe something else is wrong with your VirtualBox, and
you're just experiencing a 5.17->5.18 transition. The VirtualBox team
themselves said they haven't released the modules for 5.18 yet.
Then on top of that, maybe you're bisecting wrong.

Anyway, from that minidump...

PROCESS_NAME:  svchost.exe
STACK_TEXT:
ffff8603`177407f8 fffff806`30464647     : 00000000`0000001e ffffffff`c0000005 fffff806`3062797c 00000000`00000000 : nt!KeBugCheckEx
ffff8603`17740800 fffff806`30415dac     : 00000000`00001000 ffff8603`177410a0 ffff8000`00000000 00000000`00000000 : nt!KiDispatchException+0x17c287
ffff8603`17740ec0 fffff806`30411f43     : 00000000`00000001 ffffa20d`a3e00340 00000000`00000060 00000000`00000000 : nt!KiExceptionDispatch+0x12c
ffff8603`177410a0 fffff806`3062797c     : 00000000`000000c8 fffff806`30248da4 00000000`00000000 00000000`00000001 : nt!KiPageFault+0x443
ffff8603`17741230 fffff806`3064606e     : 00000000`00000000 ffffdd8e`e4fe9970 00000000`00000000 00000000`00000000 : nt!MiPfPrepareReadList+0x4c
ffff8603`17741320 fffff806`30645de4     : ffffa20d`ac52dcc0 00000000`00000000 00000000`00000000 ffffdd8e`e4fe9970 : nt!MmPrefetchPagesEx+0x96
ffff8603`17741390 fffff806`3064b349     : 00000000`00000000 ffff8603`00000000 ffffa20d`00000000 00000000`00000006 : nt!PfpPrefetchFilesTrickle+0x2a8
ffff8603`17741480 fffff806`3064bb6e     : ffffa20d`abf59000 ffffa20d`abf59000 ffff8603`177416a0 00000000`00000000 : nt!PfpPrefetchRequestPerform+0x299
ffff8603`177415f0 fffff806`30651679     : 00000000`00000001 fffff806`302c0c01 ffffdd8e`e9e81760 ffffa20d`abf59000 : nt!PfpPrefetchRequest+0x132
ffff8603`17741670 fffff806`3065050d     : ffffdd8e`00000000 00000000`00000000 00000000`1d16c86a 00000000`1d16c801 : nt!PfSetSuperfetchInformation+0x155
ffff8603`17741770 fffff806`304156b5     : 00000000`00000000 00000000`00000000 ffff8603`17741b80 00000000`00000000 : nt!NtSetSystemInformation+0x9bd
ffff8603`17741b00 00007fff`5b9b0274     : 00000000`00000000 00000000`00000000 00000000`00000000 00000000`00000000 : nt!KiSystemServiceCopyEnd+0x25
00000075`ba37f9c8 00000000`00000000     : 00000000`00000000 00000000`00000000 00000000`00000000 00000000`00000000 : 0x00007fff`5b9b0274
SYMBOL_NAME:  nt!MiPfPrepareReadList+4c
MODULE_NAME: nt
IMAGE_VERSION:  10.0.19041.1682

Loading up the kernel image, we see:

PAGE:000000014061B946                 mov     r13, rcx
[...]
PAGE:000000014061B96F                 mov     rax, [r13+0]
[...]
PAGE:000000014061B97C                 mov     rdx, [rax+28h]

So it dereferences the first argument of MiPfPrepareReadList(), and then
dereferences offset 0x28 of that, and crashes there. Looks like the same
thing happens in your other traces too, based on the bugcheck code
showing offset 0x28 in those too.

Anyway, until I can see that bisect log, this is beginning to smell like
a big waste of time.

Jason
