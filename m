Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA69B5757AC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 00:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238023AbiGNWcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 18:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiGNWcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 18:32:24 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CEA5466D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 15:32:22 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 22B79C01F; Fri, 15 Jul 2022 00:32:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1657837941; bh=WLDYnTfO5crNPxdekrA0P8cZ4q/DgWrOCGaTfNq2fqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZwQHzhxDxF+KCjSpVURXTpOllbAZOCpLct1byIyL8ceiWJ76/8t3DW+y3kZ/s1ph/
         Rar0jhl5wHx9byVefUyhER/eZhrVJCnoeZO/IdlyT+y/yAEtzInsmm9n9/vLzaPNwN
         LMFdJUh8GJEsT0D2uZYTR2GM67futNnWrmpLF0Rco86ACuEYyKzBJ7gTX25Yv/V/fP
         aHInE1z09DRSKQUA1jo05amh+9ADickzhPtW97byGBgAPkx9r6SNOj9h0AwL3mp8lR
         50goqOQ1jDnRR4CQ0/qdPfBNtfcFXJ2pcOvaeI+DoEDVQIBu/ymMfd0JiQm8TuYtyL
         +/r+BmBq1o6jw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 1EB42C009;
        Fri, 15 Jul 2022 00:32:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1657837939; bh=WLDYnTfO5crNPxdekrA0P8cZ4q/DgWrOCGaTfNq2fqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HjGgQf4Ou6wqyh736OABE7GrwK2vfJSQggtyMGE5c8WPegW/mzTa/mV8r3TcXJMp1
         /TtlQdtHYKXMqg302hRnlKlVsAKhIjvrDICtDuJGYujUG3YuWk6IvomWhaE7Mao0Hk
         ruf/fN/hzlWGDtC+KtbEP4uJA+W2wx9ww0Gh0tCoxCA08fxBl/71aWrT2EDDJKnDCg
         hofVK2lVrSMo9/SWiM2vLd2lNed19+tL3KYFspw4y3mTjBOCIGrdGzDTwZCqb2aOTL
         Egvq1WHtvR+izJ4m0wTeSPBHCm7atu/uElSgTS3Wv2xOoDkfRC38RACM8y/s14OsPC
         yIK/TXEP36EYQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id a6492704;
        Thu, 14 Jul 2022 22:32:09 +0000 (UTC)
Date:   Fri, 15 Jul 2022 07:31:54 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Greg Kurz <groug@kaod.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>
Subject: Re: [RFC PATCH] 9p: forbid use of mempool for TFLUSH
Message-ID: <YtCZWmPxqbL8VlTl@codewreck.org>
References: <12950409.o0bIpVV1Ut@silver>
 <20220713041700.2502404-1-asmadeus@codewreck.org>
 <2229731.hRsvSkCM7u@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2229731.hRsvSkCM7u@silver>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Schoenebeck wrote on Thu, Jul 14, 2022 at 09:16:14PM +0200:
> Patch looks fine on first impression, but I'll postpone testing this. And yes, 
> I also think that exempting Tflush should be fair. If 4k (soon) cannot be 
> allocated, then you probably have worse problems than that.

Yes, would be for a later cycle anyway -- no hurry.

> > Here's a concrete version of what I had in mind: literally just make
> > allocation fail if the initial alloc failed.
> > 
> > I can't reproduce any bad hang with a sane server here, but we still
> > risk hanging with a bad server that ignores flushes as these are still
> > unkillable (someday I'll finish my async requests work...)
> > 
> > So ultimately there are two things I'm not so happy about with mempools:
> >  - this real possibility of client hangs if a server mishandles some
> > replies -- this might make fuzzing difficult in particular, I think it's
> 
> Concrete example of such a mishap?

The example I gave Kent in another reply is just server misbehaving -- I
have had histories of troubles with ganesha in the past -- but even with
low memory qemu and fio and ^C it felt more likely to get stuck? it
looked killable e.g. pkill -9 fio would get me out of it with this
patch, but ^C ought to work in my opinion.

In particular with the io_uring engine some of the workers aren't
visible at all from userspace (I only found out about them through
qemu's gdb and lx-ps), so it's really hard to see we're stuck on an
allocation if that ever happens...

Ultimately I think mempool is great for short-lived allocations
e.g. temporary buffers, where we can be sure the memory will be freed up
after a short bounded time, but it might just not be a great fit for 9p.
I'm not sure what to suggest instead, though; this is really worst-case
thinking and just having ^c work e.g. make mempool_alloc interruptible
and failible would probably be enough to convince me.


> > easier to deal with failed IO (as long as it fails all the way back to
> > userspace) than to hang forever.
> > I'm sure there are others who prefer to wait instead, but I think this
> > should at least have a timeout or something.
> 
> Not sure if it was easy to pick an appropriate timeout value. I've seen things 
> slowing down extremely with 9p after a while. But to be fair, these were on 
> production machines with ancient kernel versions, so maybe already fixed.

I'm not sure what kind of timeframe you're thinking of, for exmple
lustre has 5 minutes timeouts in some places -- although depending on
the failure some things will also wait forever.
I was thining something similar, but realistically this isn't going to
happen anyway, at least not here, so let's not waste too much time on
this point...

> A proc interface would be useful though to be able to identify things like 
> piling up too many fids and other performance related numbers.

That would be nice, yes.
We can probably pull in some stats from either idr (requests for tags
and fids) quite easily -- that might be a nice side project if someone
wants to do this.

> >  - One of the reasons I wanted to drop the old request cache before is
> > that these caches are per mount/connection. If you have a dozen of
> > mounts that each cache 4 requests worth as here, with msize=1MB and two
> > buffers per request we're locking down 8 * 12 = 96 MB of ram just for
> > mounting.
> > That being said, as long as hanging is a real risk I'm not comfortable
> > sharing the mempools between all the clients either, so I'm not sure
> > what to suggest.
> 
> Why would a shared mempool increase the chance of a hang or worsen its 
> outcome?

In the tcp/really remote server case, if a server stops responding
that'll get these requests not freed for a while (until the user gives
up, possibly never); if the client also is under enough memory pressure
to just fail a single alloc then on a still working mount we'll
potentially have no buffer to give it and get that other working mount
stuck.

Another example would be re-exporting a network filesystem, e.g. at
previous job we'd run a 9p server re-exporting multiple lustre
mountpoints on different servers, so one could get stuck while others
still work. That this would impact the 9p client on different mounts on
the client side is a bit of a bummer.


Anyway, this is just looking for trouble and I'm sure most users would
only see improvements with this -- we're talking about some allocations
that would have failed anyway which should be rare enough in the first
place, and in the nominal case we'd get this to work when it doesn't.
I'm just not fully comfortable with the failure mode at this point.
--
Dominique
