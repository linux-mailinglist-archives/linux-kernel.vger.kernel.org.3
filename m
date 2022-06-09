Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6DF545294
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 19:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343692AbiFIRCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 13:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiFIRCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:02:41 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E02CAC365C;
        Thu,  9 Jun 2022 10:02:38 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 259H13QN010121;
        Thu, 9 Jun 2022 19:01:03 +0200
Date:   Thu, 9 Jun 2022 19:01:03 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Will Deacon <will@kernel.org>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Shah <aams@amazon.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Solar Designer <solar@openwall.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Subject: Re: [PATCH v2] Documentation/security-bugs: overhaul
Message-ID: <20220609170102.GC9541@1wt.eu>
References: <20220606194850.26122-1-vegard.nossum@oracle.com>
 <20220607090726.GB32282@willie-the-truck>
 <a0728939-0852-57e8-6d4b-8c11c73569bb@oracle.com>
 <20220609145127.GD3064@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609145127.GD3064@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few quick points below.

On Thu, Jun 09, 2022 at 03:51:27PM +0100, Will Deacon wrote:
> > "calendar days" -- this got changed just to make it more readable. Maybe
> > it's just me and my personal experience, but this wording seemed
> > redundant. Why would "day" default to anything but a calendar day except
> > in a business setting (which this is not)?
> 
> In the past, people were unclear as to whether this included weekends,
> public holidays etc and so being explicit helps.

In fact that's often the problem between what is known from insiders
and what is understood outside. The original 5 days used to allow to
include a Monday's fix into the Sunday's -rc. It then extended to 7
days to improve the likelyhood that participants involved the first
day were available on the release day, but that was always implicitly
"calendar days" or at least reminded as such during private discussions.
But with more and more professionals reporting bugs as part of their
job, the risk that this is implicitly understood with work days is much
more present nowadays and I think it's worth being explicit here.

> > "extension to 14 calendar days" -- I changed this after comments from
> > Willy who said too many people took this to mean that 7 days was the
> > norm and that 14 days was still an acceptable proposal in most cases. I
> > _think_ (but I'm not sure) that 14 days is not even really the absolute
> > maximum, depending on the severity of the bug.
> 
> The current text says:
> 
>  | ... an exceptional extension to 14 calendar days if it is agreed that
>  | the criticality of the bug requires more time. The only valid reason
>  | for deferring the publication of a fix is to accommodate the logistics
>  | of QA and large scale rollouts which require release coordination.
> 
> which I think is pretty clear; it states the single criterion under which
> an exceptional extension to 14 days will be considered. There's no mention
> of this in the rewrite.

Indeed, it's important to keep that sentence to make sure reporters do
not count on that upfront.

> The current document is clear that any
> agreed embargo begins only from the point where we have a robust fix:
> 
>   | Once a robust fix has been developed, the release process starts.
> 
> This is important -- if distributions mistakenly think that they have a
> maximum of seven days to describe the problem, involve the right people,
> iterate on a patch, backport it, test it and deploy it then they'll do
> all of this in private and just notify security@ at the end, at which
> point it's either a waste of time or the patch is found not to be as
> robust as they thought because the right people weren't involved.

This part is particularly important and is indeed at the core of some
of the recent trouble. We need to make it clearer that it can take more
time to develop a fix, possibly adding more and more people, but that
once the fix is confirmed, the process starts and the only reason for
an embargo is QA/rollout (which explains why there's no reason for a
long embargo since everything is ready). But that brings back the
concern that if we suggest that the reporter contacts linux-distros
after the fix is ready, he may be bound by a 2-week embargo (unless
it's fine to cut it to one week max by default). We need to make sure
to limit friction because many reporters are first-timers and it's
really unpleasant for them to be bounced between lists with different
policies and being told they can't ask for this or that.

> > It's always possible to go into more detail about what "robust" means
> > exactly or who makes this decision (and how), but I think brevity does a
> > lot to keep things readable.
> 
> What exactly is unreadable with the current doc?

I don't think there's anything unreadable, however both you (Will)
and me are on the list and have implicit knowledge of certain things.
Vegard is not and his perception is useful because it's closer to the
one from a reporter who tries to find their way through all this. Even
a feeling like "it's too difficult to grasp" can be listened to IMHO.

Just my two cents,
Willy
