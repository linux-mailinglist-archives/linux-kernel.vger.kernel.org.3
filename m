Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2160A511D11
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243599AbiD0Q4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243545AbiD0Q4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:56:32 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 446DF5BD1F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:53:20 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id BB16792009C; Wed, 27 Apr 2022 18:53:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id AFF0592009B;
        Wed, 27 Apr 2022 17:53:18 +0100 (BST)
Date:   Wed, 27 Apr 2022 17:53:18 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Jean Delvare <JDelvare@suse.com>
cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PING^6][PATCH 0/2] firmware: dmi: Avoid (some) empty names in
 kernel log
In-Reply-To: <d74f3f4b26c5620d726f0eebe4b0d14d923bea2b.camel@suse.com>
Message-ID: <alpine.DEB.2.21.2204271624530.9383@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2201020127140.56863@angie.orcam.me.uk>  <alpine.DEB.2.21.2204202019380.9383@angie.orcam.me.uk>  <alpine.DEB.2.21.2204271211090.9383@angie.orcam.me.uk> <d74f3f4b26c5620d726f0eebe4b0d14d923bea2b.camel@suse.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jean,

> >  I don't know if Jean means to continue maintaining the DMI subsystem, but 
> > either way it looks to me like a stalemate.  I don't feel like it's a set 
> > of changes that requires a lot of consideration, the situation is IMO 
> > quite straightforward here and the result a clear improvement.
> 
> If you genuinely think that kernel patches should be applied without
> being reviewed because they are "quite straightforward and the result
> is a clear improvement" then I advise you refrain from touching kernel
> code at all.

 Well, I have worked with Linux (and other free software projects) both as 
a code contributor and a reviewer/maintainer for some 25 years now and I 
know very well what the responsibilities are for both sides.

 And surely I have not asked for this particular patch set to be accepted 
without a review, but for assistance with the review.  I do hope I have 
made it clear enough in my message.

> Jean is busy doing things that matter in other areas, things which
> surprisingly are always more important than adding code to the kernel
> to essentially slightly improve the format of an informative line in
> the boot log of a 20-year old systems with crappy DMI data.

 The incentive for my proposal was the lack of good identification given 
it the kernel log: <https://pastebin.com/QXaUsCV4>, which is generally the 
only source that can be reliably referred via Internet searches; people do 
not publish their sysfs data.

 Said log was posted in the course of investigating an IRQ routing bug: 
<https://lore.kernel.org/r/60B24AC2.9050505@gmail.com>, 
<https://lore.kernel.org/r/60E726E2.2050104@gmail.com/>, and ultimately I 
have sorted the problem in a generic way that does not require a DMI quirk 
to be added; cf.:
<https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=ac7cd5e16df8696c39e29b03dfedf069a025b822>, 
<https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=5a0e5fa957db79177baa851d687b6f6aa5a0be96>, 
<https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=fe62bc23620fa027162e05594a610ff5e556496a>.

 However that does not mean we should continue logging crappy data.  This 
is because evidently people still want to use these systems, and next time 
we may not be so lucky as to avoid relying on DMI data, however limited.

> If you think this is the best use of your own time then you can keep
> pinging me every other week for another year, but that's not going to
> change my priorities. I'll eventually get to your patches when I have
> less on my plate, regardless.

 We all are busy, aren't we?  If you cannot perform your maintainer's 
duties for a given subsystem in a timely manner, not even to send a note 
that the waiting queue is long, then perhaps you should reconsider if you 
can afford the post?

 NB I have fixed Nikolai's problem even though I am not a maintainer for 
the relevant subsystem, so I have no obligation of any kind there, unlike 
actual maintainers.

> >  Can you therefore please advise who can review this patch series (I can 
> > re-repost if needed) or otherwise how to proceed with this submission?
> 
> And no, bothering Linus to solve that kind of situation is NOT how
> things work. Your patches have been posted publicly several times,
> pinged way too many times already, yet nobody has shown any interest in
> them. Maybe this means something.

 Whatever your priorities are it does mean exactly what I have implied in 
my message: that evidence shows the maintenance of the DMI subsystem does 
not work.

 Therefore I have referred to the chief maintainer of the project, the 
only sensible action given the state of affairs.  This is because as you 
have correctly observed this patch set has been already pinged too many 
times and (as a general life rule) you can't expect a different outcome 
from the same action repeated, so if things repeatedly do not work, then 
you need to try something else.

 Please refer to this paragraph:

"Once upon a time, patches used to disappear into the void without comment,
but the development process works more smoothly than that now.  You should
receive comments within a week or so; if that does not happen, make sure
that you have sent your patches to the right place.  Wait for a minimum of
one week before resubmitting or pinging reviewers - possibly longer during
busy times like merge windows."

in Documentation/process/submitting-patches.rst too, which I think gives a 
good overview of the practices and timelines expected from submitters and 
maintainers.  I have to admit that I waited a bit longer than a week 
before I started pinging though.

 In most free software projects the general/head maintainter(s) step in by 
themselves with overdue reviews if subsystem-specific ones are too busy to 
handle submissions in a timely manner, however I do realise Linux has 
grown too large for this approach to be feasible.

 Thank you for your time spent to write your reply.

 NB it is generally accepted that publishing messages sent privately is 
inappropriate without obtaining consent first from the involved parties.  
Please assume my previous consent for your posting on this occasion 
though.

  Maciej
