Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8806753C536
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 08:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241675AbiFCGyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 02:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241525AbiFCGy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 02:54:28 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 58D2F36691;
        Thu,  2 Jun 2022 23:54:25 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 2536nOOA029806;
        Fri, 3 Jun 2022 08:49:24 +0200
Date:   Fri, 3 Jun 2022 08:49:24 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Shah <aams@amazon.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Solar Designer <solar@openwall.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Tyler Hicks <tyhicks@canonical.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] Documentation/security-bugs: overhaul
Message-ID: <20220603064924.GC29741@1wt.eu>
References: <20220531230309.9290-1-vegard.nossum@oracle.com>
 <20220601031254.GB26318@1wt.eu>
 <42200c3e-fb39-ddab-3d68-5dfb5eb89451@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42200c3e-fb39-ddab-3d68-5dfb5eb89451@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 05:34:48PM +0200, Vegard Nossum wrote:
> > Overall it seems that reporters are willing to do their best but that
> > it's never easy to engage in such a bug disclosure process which may
> > involve short times, and that it can be stressful for the reporters
> > who forget to do a lot of the parts they would do for more regular
> > bugs.
> 
> I think there's also an argument for encouraging reports whether the
> person has a patch or not, presumably it is better to know about an
> issue so it can be prioritized against all other known issues, no?

It depends. For a few months now we've seen a huge increase of reports
for things ranging from "if I modify this driver this way I can make it
fail so I think it could be insecure" to "this outdated driver that is
not enabled in any distro anymore has a one-byte info leak bug, can I
get my CVE". There have been weeks with 2 of them every single day. It's
obvious that there's a quest of a CVE to be held as a trophee, and that
for a CVE, a security bug is needed, and that for this it ought to be
demonstrated that some random bugs in certain circumstances could have
a security impact. Thus there is a huge bias.

I would really like it if we could get back to what works fine: use
the security list only for currently exploitable bugs that are not
trivially worked around, and please use public lists for everything
else. It takes way longer to fix a bug in a small team having to
forward messages to maintainers, trying to fix in a small group without
knowing if we're going to break someone's use case than it takes when
a non-critical issue is discussed publicly. And security fixes that
cause regressions are the worst that can happen because they discourage
users from regularly applying fixes. As such the vast majority of bugs
ought to be discussed publicly, on the relevant lists. Bug given that
some reporters are not interested in getting a bug fixed but just in
getting a trophee, that's difficult to get a patch from them and to
move the discussion to a public place where the fix will just be
handled like with any regular bug.

But by doing this we'd get more time to work on real problems. Usually
researchers who found complex problems have some patches to propose
because that was needed to confirm their analysis. It's common that
these patches are not suitable for merging but they illustrate the
problem and help bring in the relevant people. Also they give many
ideas of things to look for much faster than by trying a reproducer,
which many times only works in a specific context. Maybe we should
mention this point by the way, that we're not necessarily asking for
a final patch but at least a candidate or an illustrative one.

> In any case, I have amended the text like this:
> 
> +Reporters are encouraged to propose patches, participate in the
> +discussions of a fix, and test patches.

Looks good.

> > There's always this gray area between getting a fix merged and disclosing
> > all the details of the bug. A bug indeed becomes public once the fix is
> > merged, but that doesn't mean that all the details are shared, so the
> > reporter still has the opportunity to write their story about it. The
> > reporter must only understand that it's only a matter of time between
> > the merge of a fix and the moment someone will understand how to exploit
> > the bug and publish about it.
> 
> I've changed the bit above to address Jon's comments as well:
> 
> +Note that the main interest of the kernel security list is in getting
> +bugs fixed and getting patches reviewed, tested, and merged; CVE
> +assignment, disclosure to distributions, and public disclosure happen
> +on different lists with different people, as described below.

Looks good.

> We could maybe add something like this to the "Disclosure" section of
> "Contacting the security list":
> 
> +Please note that although a fix is public, there may still be value
> +in withholding the details of its security relevance and/or how to exploit
> +it for another while; see below for when and how to properly disclose the
> +security impact of your findings.
> 
> I'm not totally happy with the wording here, probably because I don't
> really agree that patches should be published ahead of disclosure in the
> first place. Anyway, happy to take other suggestions as long as we can
> keep it short.

I don't know how to adjust the wording but I think that the spirit is
there. By the way there's something I would like to see added as well
to this, which is the the ultimate goal is that a bug fixed is perfectly
understood and documented. So either the details of the cause of the bug
are in the commit message, or the researchers prefer not to publish them
yet because they intend to present them at a conference or in a blog
article (pretty common), which will serve as a reference for to get all
the gory details. But in this case there must be a reasonable delay, it's
not acceptable that the details of the problem are withheld for months.

As such I think that we could mention something along:

  Upon reporters' request in case a forthcoming presentation of the issue
  is planned, it may occasionally be accepted to temporarily keep out some
  of the detailed impacts of the issue, however the security team reserves
  the right to publicize these details if no other publication happens in
  a reasonable time frame or as soon as the fixes are found to cause a
  regression.

Because quite frankly, not being able to explain exactly why a patch is
done this way and not slightly differently is not acceptable.

> >> +Here is a quick overview of the various lists:
> >> +
> >> +.. list-table::
> [snip]
> > While this part renders well on your HTML version, I'm afraid it's totally
> > unreadable here in the text version, and this document is supposed to be
> > the one reporters will use. I suggest to try again with an item list
> > instead of a table.
> 
> Jon had a good way to do this that looks good in both text and HTML.

Yeah I liked it as well, thanks Jon!

> >> +**Disclosure.** The security list prefers to merge fixes into the
> >> +appropriate public git repository as soon as they become available.
> >> +However, you or an affected party may request that the patch be
> >> +withheld for up to 7 calendar days from the availability of the patch,
> >> +with an exceptional extension to 14 calendar days if it is agreed that
> >> +the bug is critical enough to warrant more time. The only valid reason
> >> +for deferring the publication of a fix is to accommodate the logistics
> >> +of QA and large scale rollouts which require release coordination.
> > 
> > I'm still having an issue here. Originally it was something along "up
> > to 5 days if there's a really compelling reason". Then it was extended
> > to 7 days in order to better match the tuesday-to-thursday range. Then
> > "up to 14 days" for exceptional cases (i.e. hopefully never). But the
> > wording tends to make all reporters think that asking for 7 days is
> > normal. We really need to make it even clearer that:
> >   - the default is no embargo
> > 
> >   - if there is a *really compelling reason* (that has to be justified
> >     by the reporter), it may reach *up to 7 days*
> > 
> >   - in exceptional cases (the bug-of-the-year with a risk of massive
> >     exploitation requiring coordination) it may be extended to 14 days
> > 
> >   - "I already contacted this or that list so you must respect THEIR
> >     embargo" is NOT a valid justification to withhold a fix
> > 
> >   - dealing with embargoes is a pain, a withheld patch risks to be
> >     forgotten or confused with a previous version of the patch that
> >     appeared in discussions, it's difficult to synchronize stable
> >     and mainline, and the risk that it leaks by accident grows with
> >     time and with the number of participants in a discussion.
> 
> I've changed this section to:
> 
> +**Disclosure.** The security list strongly prefers to have patches posted
> +for review and testing on public mailing lists and and merged into the
> +appropriate public git repository as soon as they become available.
> +However, in exceptional cases, you or an affected party may request that
> +the patch be withheld for some days; as a rule, the maximum is 7 days.
> +Only in truly exceptional cases will the security list consider deferring
> +the publication of a fix beyond this, and the only valid reason for doing
> +so would be to accommodate the logistics of QA and large scale rollouts
> +that require release coordination.

I think that's better that way already, thanks!

> Note that I'm only trying to clarify the existing policy here -- I'm not
> in a position to change it.

Of course, rest assured I'm not asking for this, I only mentioned it to
illustrate the existing drift already that happened due to the need to
coordinate, and that I wouldn't like to see the vendor-sec mess resurrected.

> There is no mention of 5 days in the current
> document, which is why I've kept the wording of "the maximum is 7 days".

Of course (that was the good old days when there was less bureaucracy
in the supply chain :-)).

> The justification for the current wording was given in commit
> 544b03da39e2d7b4961d3163976ed4bfb1fac509. If there's a consensus to
> change it back to 5 days then I can incorporate that, or somebody can do
> an incremental patch.

I don't think anyone is asking for this. We just need to make people
understandthat 7 days is already not a normal delay for the vast majority
of bugs, and the reasons Will explained in the commit above definitely
apply to critical bugs that require immediate action, not the "look, I
can make this webcam driver oops".

> In any case, I would assume these are also things that can/should be
> discussed on a per-bug basis as long as the overarching rules have been
> given here. What do you think?

It's already the case, but many reporters are first-timers, and as you
know, security reporting rules are complex things which put a lot of
stress on them (especially when the wording of rules like linux-distros
make them engage on disclosing at certain steps), so they tend to take
the words they read as being very strict and the default rules. Most
returning reporters are completely relaxed about delays and usually
do not even ask for one. And conversely some bugs take a long time to
figure a fix and can drag for a month or more because they're too
difficult. So that's definitely on a case-by-base basis, and I think
it's important that the reporters understand what options are left to
them once they sent their message. Everyone wants efficiency there.

Cheers,
Willy
