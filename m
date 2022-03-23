Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA174E5A97
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 22:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241081AbiCWVZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 17:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiCWVZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 17:25:16 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94B7B10FFF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 14:23:46 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 7276F92009C; Wed, 23 Mar 2022 22:23:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 6C84E92009B;
        Wed, 23 Mar 2022 21:23:44 +0000 (GMT)
Date:   Wed, 23 Mar 2022 21:23:44 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] x86/irq for v5.18-rc1
In-Reply-To: <CAHk-=wg_Kyh4zVmBSc4H79jH+yv9wN7dMsf-5x=EDrORbL3fuQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2203232114180.52439@angie.orcam.me.uk>
References: <164786042536.122591.4459156564791679956.tglx@xen13> <164786043041.122591.4693682080153649212.tglx@xen13> <CAHk-=wg_Kyh4zVmBSc4H79jH+yv9wN7dMsf-5x=EDrORbL3fuQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2022, Linus Torvalds wrote:

> Because that stupid IRT routing table code already been reported to cause bugs:
> 
>     https://lore.kernel.org/all/a2791312-2957-27e6-43af-c805bbb90266@collabora.com/
> 
> which seems to be because the $IRT signature check is complete garbage:
> 
> > +       for (addr = (u8 *)__va(0xf0000); addr < (u8 *)__va(0x100000); addr++) {
> > +               rt = pirq_convert_irt_table(addr);
> > +               if (rt)
> > +                       return rt;
> 
> The above doesn't seem like it could really ever have been tested
> properly, since it will walk off the end of that __va(0x100000)
> address: it will walk every byte up to the 1MB physical address, and
> it will try to find that $IRT signature there, but if it never finds
> it, IT WILL CHECK THE SIGNATURE PAST THE 1MB mark!

 Drat!  I did verify this code in a simulated environment that does supply 
a $IRT table (for a reporter who has an actual system; I'm not lucky 
enough to have one), however somehow I didn't think of verifying it with a 
setup that has neither a $PIR nor a $IRT table.  Therefore this issue has 
slipped ($PIR scanner works in 16-byte intervals, so it escapes the range
overrun), and then of course things started moving only while I am away 
enjoying Italian mountains.  Oh well, nobody's perfect.

 Thanks for narrowing this down, I'll post a fixed version on or shortly 
after this coming weekend.  And sorry for the mess-up!

  Maciej
