Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC94544FD5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbiFIOvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242565AbiFIOvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:51:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E7B12E320;
        Thu,  9 Jun 2022 07:51:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3195CB82D86;
        Thu,  9 Jun 2022 14:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CC0C34114;
        Thu,  9 Jun 2022 14:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654786295;
        bh=Jl1wARRzIGscfE9RnY2ykDsKt6OEvvPnb6aHDFAEubw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FMjvi0XtpKCnJruyKEyQJTCml464PQVCuo25NgGqpVik74JobR6IqpOxSM/48HB2F
         8dSFCyBW/KXMLynBu3KKgFQiO/wHm0yuJQSdgwfjJDssfVlr6gJ2WW/Q2SGri/Oy/8
         zowWo8LwHXKwb+kpE2qeobALeEPWAJjQBqY5R3P+yUn8C5e+tJE1PT2bZEJUeYJAH4
         5aUl7OwNk7NaTOFYAxHTClb39KaxO4fbSCMNAHOo+u1w0/EJ2zbTe1XGEZ56Y2lw5L
         /9OqYVDMPtWxOb09VosUhrAHRLP1zX0PPbmmd2ud28ZqGtZ8Nj7WeqLWl+vtQF3fXh
         5b1MIy/41yfVg==
Date:   Thu, 9 Jun 2022 15:51:27 +0100
From:   Will Deacon <will@kernel.org>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
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
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH v2] Documentation/security-bugs: overhaul
Message-ID: <20220609145127.GD3064@willie-the-truck>
References: <20220606194850.26122-1-vegard.nossum@oracle.com>
 <20220607090726.GB32282@willie-the-truck>
 <a0728939-0852-57e8-6d4b-8c11c73569bb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0728939-0852-57e8-6d4b-8c11c73569bb@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 03:06:37PM +0200, Vegard Nossum wrote:
> On 6/7/22 11:07, Will Deacon wrote:
> > On Mon, Jun 06, 2022 at 09:48:50PM +0200, Vegard Nossum wrote:
> >> +**Disclosure.** The security list strongly prefers to have patches posted
> >> +for review and testing on public mailing lists and and merged into the
> > 
> > typo: "and and"
> 
> Fixed, thanks.
> 
> >> +appropriate public git repository as soon as they become available.
> >> +However, in exceptional cases, you or an affected party may request that
> >> +the patch be withheld for some days; as a rule, the maximum is 7 days.
> >> +Only in truly exceptional cases will the security list consider deferring
> >> +the publication of a fix beyond this, and the only valid reason for doing
> >> +so would be to accommodate the logistics of QA and large scale rollouts
> >> +that require release coordination.
> > 
> > I think there's a semantic change here, and I tend to feel that these sort
> > of changes would be much easier to review if the semantic changes were done
> > separately from the reformatting or the addition of entirely new sections.
> > As it stands, the whole doc is effectively being replaced, but what we
> > currently have has been tweaked over the years (often as a result of
> > spirited debate) and I'm keen not to open up some of the issues we had
> > previously if at all possible.
> 
> My goal with the rewrite was to clarify the policy for reporters,
> include the updates to linux-distros policy, and turn the document into
> more of a step-by-step guide for reporters that corresponds to both what
> happens in reality and what the "ideal" flow for a security bug report
> is. It's not my intention here to modify the policy itself.

Oh, for-sure, I'm not trying to suggest there's any malice involved here.
Rather, my heart sinks at the prospect of reopening old (and, frankly,
tedious) discussions around the finer details of what is in that doc.

> My impression of the current document is that it's a little bit chaotic
> and difficult to follow -- perhaps exactly because of tweaking over the
> years rather than writing for the reader/reporter.

That's a fair criticism, but a straight-up rewrite won't solve that imo; the
thing will still get tweaked until the next rewrite comes along etc etc

> > Case in point: the new text above removes both the mention of "calendar
> > days" which is a useful disambiguation as well as removing the "extension
> > to 14 calendar days" which is a useful upper bound. Why are you removing
> > these?
> 
> "calendar days" -- this got changed just to make it more readable. Maybe
> it's just me and my personal experience, but this wording seemed
> redundant. Why would "day" default to anything but a calendar day except
> in a business setting (which this is not)?

In the past, people were unclear as to whether this included weekends,
public holidays etc and so being explicit helps.

> That said, I agree if this has been contentious in the past there is
> value in being explicit. My goal was maximum clarity, so if this could
> be unclear to anybody then it's better to leave it in -- however, if I
> leave it in, then I should also change all other occurrences of the word
> "days" to also be "calendar days" so that the reader is not left
> wondering why it's specified as calendar days in one place and
> unspecified in another.

Right, and I think _that_ would be a reviewable change on its own.

> "extension to 14 calendar days" -- I changed this after comments from
> Willy who said too many people took this to mean that 7 days was the
> norm and that 14 days was still an acceptable proposal in most cases. I
> _think_ (but I'm not sure) that 14 days is not even really the absolute
> maximum, depending on the severity of the bug.

The current text says:

 | ... an exceptional extension to 14 calendar days if it is agreed that
 | the criticality of the bug requires more time. The only valid reason
 | for deferring the publication of a fix is to accommodate the logistics
 | of QA and large scale rollouts which require release coordination.

which I think is pretty clear; it states the single criterion under which
an exceptional extension to 14 days will be considered. There's no mention
of this in the rewrite.

> In my mind, this document is more for reporters of security issues and
> less a formal standard for the security list members and so the "Only in
> truly exceptional cases will the security list consider deferring the
> publication of a fix beyond this" already covers what happens if
> somebody wants or request that the patch be withheld for more than 7
> days -- it's basically up to the list members to decide whether to
> honour requests beyond the stated maximum.
> 
> Any new thoughts with all this in mind..?

I think the document provides a useful set of "ground rules" which mean
that reporters can engage with security@ with a reasonable expectation
of how the process is going to go ahead of time. I'm all for reworking
phrasing, stylistic changes and adding extra information to make the
document more useful, but I really don't think a rewrite is warranted.
It will cause more problems than it solves. Please work with the text
that is already there instead.

> > You have also removed use of the term "robust fix", which I think was
> > useful. That is, security@ isn't going to post a broken patch to the public
> > list just because it's been available for 7 days; that period should only
> > begin (if it is even needed) once the fix is ready to go.
> 
> Okay, how about changing it like this:
> 
> -**Disclosure.** The security list strongly prefers to have patches posted
> -for review and testing on public mailing lists and and merged into the
> -appropriate public git repository as soon as they become available.
> +**Disclosure.** When a robust patch or patchset has been developed, the
> +security list strongly prefers to have these posted for review and testing
> +on public mailing lists and merged into the appropriate public git
> +repository as soon as possible.

This isn't addressing my concern. The current document is clear that any
agreed embargo begins only from the point where we have a robust fix:

  | Once a robust fix has been developed, the release process starts.

This is important -- if distributions mistakenly think that they have a
maximum of seven days to describe the problem, involve the right people,
iterate on a patch, backport it, test it and deploy it then they'll do
all of this in private and just notify security@ at the end, at which
point it's either a waste of time or the patch is found not to be as
robust as they thought because the right people weren't involved.

> It's always possible to go into more detail about what "robust" means
> exactly or who makes this decision (and how), but I think brevity does a
> lot to keep things readable.

What exactly is unreadable with the current doc?

Will
