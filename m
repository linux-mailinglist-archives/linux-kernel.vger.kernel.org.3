Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563FC57F207
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 01:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238920AbiGWXIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 19:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiGWXIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 19:08:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481071AF3C
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 16:08:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBBF1B80923
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 23:08:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A7DC341C7
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 23:08:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=fail reason="key not found in DNS" (0-bit key) header.d=linaro.org header.i=@linaro.org header.b="CLSWr7ut"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=20210105;
        t=1658617726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rT3X/1+4oOgsCcnsvbG+qN0na6nBXc8A0Iovb+syBCE=;
        b=CLSWr7utMbwwdcL2L+Kwys6/2lHAAo/WjB2EWYrYPuWG3XxdTXqlyQXtpTPss5G5cMx6Rz
        zHK6/IrF8vndKusELUjkZKwp11MBPk/mLhHdqQy/PLIZggVqO4tZqIHXvCgPnS0ykvWvr/
        VQELLVSgLdpR3NPkkToy5f7rd7UcrEs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6866d27b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Sat, 23 Jul 2022 23:08:46 +0000 (UTC)
Message-ID: <6bf352e9-1312-40de-4733-3219721b343c@linaro.org>
Date:   Sat, 23 Jul 2022 14:39:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.3
Subject: Re: arc4random - are you sure we want these?
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>, libc-alpha@sourceware.org,
        Florian Weimer <fweimer@redhat.com>,
        Yann Droneaud <ydroneaud@opteya.com>, jann@thejh.net,
        Michael@phoronix.com, Paul Eggert <eggert@cs.ucla.edu>
Cc:     linux-crypto@vger.kernel.org
References: <YtwgTySJyky0OcgG@zx2c4.com> <Ytwg8YEJn+76h5g9@zx2c4.com>
From:   Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <Ytwg8YEJn+76h5g9@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/07/22 13:25, Jason A. Donenfeld wrote:
> [Resending to right address.]
> 
> Hi glibc developers,
> 
> I learned about the addition of the arc4random functions in glibc this
> morning, thanks to Phoronix. I wish somebody would have CC'd me into
> those discussions before it got committed, but here we are.

Florian has sent the initial version about four years ago in on libc
alpha (libc-alpha@sourceware.org). This is the maillist used for glibc
development, RFC, and general discussions.

> 
> I really wonder whether this is a good idea, whether this is something
> that glibc wants, and whether it's a design worth committing to in the
> long term.

I think so, this is something developers have been asking us since 
2007 [1] and used and ported on multiples OS (OpenBSD, FreeBSD, MAcOSX).

> 
> Firstly, for what use cases does this actually help? As of recent
> changes to the Linux kernels -- now backported all the way to 4.9! --
> getrandom() and /dev/urandom are extremely fast and operate over per-cpu
> states locklessly. Sure you avoid a syscall by doing that in userspace,
> but does it really matter? Who exactly benefits from this?

Mainly performance, since glibc both export getrandom and getentropy. 
There were some discussion on maillist and we also decided to explicit
state this is not a CSRNG on our documentation.

> 
> Seen that way, it seems like a lot of complexity for nothing, and
> complexity that will lead to bugs and various oversights eventually.
> 
> For example, the kernel reseeds itself when virtual machines fork using
> an identifier passed to the kernel via ACPI. It also reseeds itself on
> system resume, both from ordinary S3 sleep but also, more importantly,
> from hibernation. And in general, being the arbiter of entropy, the
> kernel is much better poised to determine when it makes sense to reseed.
> 
> Glibc, on the other hand, can employ some heuristics and make some
> decisions -- on fork, after 16 MiB, and the like -- but in general these
> are lacking, compared to the much wider array of information the kernel
> has.
> 
> You miss out on this with arc4random, and if that information _is_ to be
> exported to userspace somehow in the future, it would be awfully nice to
> design the userspace interface alongside the kernel one.
> 
> For that reason, past discussion of having some random number generation
> in userspace libcs has geared toward doing this in the vDSO, somehow,
> where the kernel can be part and parcel of that effort.
> 
> Seen from this perspective, going with OpenBSD's older paradigm might be
> rather limiting. Why not work together, between the kernel and libc, to
> see if we can come up with something better, before settling on an
> interface with semantics that are hard to walk back later?

Mainly because there are some programs out there that can still benefit
from a wide-spread interface instead of relying on a not yet implemented
interface that will be only available in a future kernel.  But at same
time there nothing prevents us to either use the vDSO-like interface or
improve our implementation with better heuristics or even use a different
cipher algorithm.

There are even some discussion on making arc4random fallback to getrandom
if a tunable or if kernel is set on some strict manner.

> 
> As-is, it's hard to recommend that anybody really use these functions.
> Just keep using getrandom(2), which has mostly favorable semantics.
> 
> Yes, I get it: it's fun to make a random number generator, and so lots
> of projects figure out some way to make yet another one somewhere
> somehow. But the tendency to do so feels like a weird computer tinkerer
> disease rather something that has ever helped the overall ecosystem.

I did not added because it was 'fun' not I was trying to be clever here,
my initial plan was to use a de-facto implementation based on OpenBSD 
exactly to avoid  the pitfalls on trying to come up a new RNG scheme.

> 
> So I'm wondering: who actually needs this, and why? What's the
> performance requirement like, and why is getrandom(2) insufficient? And
> is this really the best approach to take? If this is something needed,
> how would you feel about working together on a vDSO approach instead? Or
> maybe nobody actually needs this in the first place?

The vDSO approach would be good think and if even the kernel provides it
I think it would feasible to wire-up arc4random to use it if the  underlying
kernel supports it.  The OpenBSD, for instance, has a feature to instruct 
kernel provide direct random data to ELF segment [4]; and they use it to 
seed various libc hardening features (way more versatile than AT_RANDOM
and more fail proff than getrandom, as we saw on some environment where).

> 
> And secondly, is there anyway that glibc can *not* do this, or has that
> ship fully sailed, and I really missed out by not being part of that
> discussion whenever it was happening?

Well, we are in fact discussing adding arc4random since Florian initial
proposal [2], roughly 4 years ago; and the initial bug report asking is
from 15 years ago.

I still think it is a good addition to provide arc4random for the same
reason we are adding proposing using strlcpy [3]: developers still use
such interface, being source-code compatibility with the BSDs might 
help developer to avoid rollout their out implementation (even if some
developers do agree that are not the best interface), and focusing on
one implementation might improve the general ecosystem.  As Paul noted,
coreutils has its own RNG, while having a arc4random like interface
might free it to so (at least on glibc systems).

But in the end I think if we are clear about in on the documentation,
and provide alternative when the users are aware of the limitation, I do
not think it is bad decision.

> 
> Thanks,
> Jason

[1] https://sourceware.org/bugzilla/show_bug.cgi?id=4417
[2] https://sourceware.org/pipermail/libc-alpha/2018-March/092081.html
[3] https://sourceware.org/pipermail/libc-alpha/2022-June/140093.html
[4] https://github.com/openbsd/src/blob/master/libexec/ld.so/SPECS.randomdata
