Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B262D4C530A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 02:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiBZBa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 20:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiBZBax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 20:30:53 -0500
X-Greylist: delayed 521 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Feb 2022 17:30:17 PST
Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDB0200CE4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 17:30:17 -0800 (PST)
Received: from [192.168.0.150] (84-115-212-199.cable.dynamic.surfer.at [84.115.212.199])
        by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4K584850BPz1LB1y;
        Sat, 26 Feb 2022 02:21:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailrelay.tugraz.at 4K584850BPz1LB1y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
        s=mailrelay; t=1645838488;
        bh=JtxQBHGEAzIYAf/Gq9ZY0ULnok3B/VixYtuQyWB80mo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=M+ShaYFM/pi38akxc4bYa4JmVorK7ZOp2rLvbt3mp3/5IvasM+MUThaqM/KjoZZHz
         tgVULih0qKevibOU8qDcAGA8P6KnK3mZpsHRD+gwOHOOivVRbIPhJ/rsLE6XuyiDkz
         y+FPmGCtNeK8FW0srU9RtoXcG1XmVK9INPEcl3Dw=
Message-ID: <979af7ae9b7e8baf080ef6f8d42d48d7f5d2c5b4.camel@tugraz.at>
Subject: Re: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
From:   Martin Uecker <uecker@tugraz.at>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Sat, 26 Feb 2022 02:21:27 +0100
In-Reply-To: <CAHk-=whFMxks63sfMQ-0_YO1GsTmoLfsO4ciMtoiCHNgaG_+GA@mail.gmail.com>
References: <CAHk-=wjtZG_0zjgVt0_0JDZgq=xO4LHYAbH764HTQJsjHTq-oQ@mail.gmail.com>
         <bd43bd47c8eaa4c22c1a1549cee66f7ef960b1fc.camel@med.uni-goettingen.de>
         <CAHk-=whFMxks63sfMQ-0_YO1GsTmoLfsO4ciMtoiCHNgaG_+GA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TUG-Backscatter-control: G/VXY7/6zeyuAY/PU2/0qw
X-Spam-Scanner: SpamAssassin 3.003001 
X-Spam-Score-relay: -1.9
X-Scanned-By: MIMEDefang 2.74 on 129.27.10.117
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, den 25.02.2022, 14:02 -0800 schrieb Linus Torvalds:
> On Fri, Feb 25, 2022 at 1:36 PM Uecker, Martin
> <Martin.Uecker@med.uni-goettingen.de> wrote:
> > Implementation-defined only means that it needs to be
> > documented (and clang does not even do this), so
> > I am not sure what difference this would make.
> 
> No, implementation-defined means something *much* more than "undefined".
> 
> Yes, it means that the behavior has to be documented.
> 
> But that's not actually the big deal from a user standpoint (although
> it might be a big annoyance from a compiler writer's standpoint -
> compiler writers would probably much prefer "let me do the obvious
> sane thing" over "let me do the obvious sane thing and then have to
> write documentation about how obviously sane it is").
> 
> From a user standpoint, the big thing is that "implementation-defined"
> means that the behavior has to have *SOME* well-defined behavior.
> Documentation is irrelevant. But RELIABILITY is relevant.
> 
> See?

In principle, a compiler writer could document
implementation-defined behavior to do something
crazy and promise that something the standard
leaves undefined has useful and consistent behavior.

But I think you are right that this still makes
a huge difference in practice because the two
notions encourage different things.

...

> In contrast, "undefined" means that the same C code can do two totally
> different things with different optimization options, or based on just
> any random thing - like some random register allocation issue.
> 
> So "undefined" behavior means that changes to code that isn't even
> near the code in question can change what the code generation for that
> code is. And the compiler may not even report it.

Yes, it means the compiler is free to do this.

But it does not mean a compiler *has* to do this.

Compiler writers represented in the committee want
to have the UB because some customers seem to like
those optimizations. At the same time, a programmer
who complains about some undesired effect of such
an UB-based optimization is typically told that the
program has UB according to the C standard so
nothing can be done (bug report closed).

You see what is happening here?

Roughly the same group of people / companies that
write the compilers also control what goes into the
standard. They then like to point to the standard
and reject all responsibility for *their*
implementation choices.  By complaining about
the standard, one detracts from the fact that
the compiler writers make these choices and
also largely control what goes in the standard.


> That is a complete disaster. It's a disaster from a security
> standpoint, it's a disaster from a maintenance standpoint, it's just
> *bad*.

It is sometimes pure necessity. An unbounded write
has unbounded consequences and there is no realistic
way to give it defined behavior (in the context
of C).  But for many other cases of UB, I completely
agree with you.

> And the C standards committee has traditionally used to think it was a
> good thing, because they listened to compiler writers that claimed
> that it allowed them to do wild optimizations and improve code
> generation.

There are many compiler people in the standards committee,
so there is no surprise here.

> Example: the completely broken type-based aliasing rules that changed
> semantics of C for the worse.

I do not really know the history of this, but
I think these rules existed even before compilers
really exploited them for optimization.

> Reality: it doesn't actually improve code generation all that much.
> Instead it just results in a lot of problems, and any sane C code base
> that cares about security and stability will just turn that off.
> 
> Same goes for integer overflow etc.

For signed overflow, I am not entirely sure what the
right choice is.  Wrapping for signed overflow also seems
dangerous. I use UBsan to find such issues in my code, and
this would not really work if signed overflow was defined
to wrap.

...
> > > Hey, some more googling on my part seems to say that somebody saw the
> > > light, and it's likely getting fixed in newer C standard version.
> > 
> > I don't think it is changed. But C23 will require
> > integers to be repreeted using two's complement,
> > so there is a better chance to fix things
> > like this in the future.
> 
> If integers are guaranteed to be two's complement, then the only
> possible explanation for "left shift is undefined" goes away. So
> presumably the thing goes hand-in-hand with just making (the de-facto)
> negative shifting well-defined.

I think there is a fairy good chance to get this
changed.

> (Btw, shifting *by* a negative number - or by amounts bigger than the
> width of the type - is different. There are at least real reasons to
> complain about that, although I think "implementation defined" would
> still be hugely preferred over "undefined")
> 
> > The right people to complain to are the
> > compiler vendors, because they decide what
> > UB does in their implementation.
> 
> No. The bug was in the spec to begin with. The people to complain
> about are the incompetents that literally changed the C standard to be
> less well-specified.
>
> As far as I know, no actual compiler has ever made integer left-shift
> done anything bad. You'd literally have to do extra work for it, so
> there's no reason to do so.

I agree that the standard should be changed. But 
this example also shows that UB in the standard
does not inevitably causes the compilers to do
something stupid. It is still their choice.

> But because the standards committee messed up, the compiler writers
> *did* do the extra work to warn about the fact (for the trivial
> "negative constant" case - never mind that technically it's undefined
> for non-constants: that would have been too much work).

Compilers do *not* warn about a lot of undefined behavior 
(even where it would be easily possible and make perfect
sense). So why here?


Martin


