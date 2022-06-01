Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42339539B81
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 05:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349262AbiFADOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 23:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbiFADOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 23:14:34 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 558569155F;
        Tue, 31 May 2022 20:14:32 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 2513CsXI026442;
        Wed, 1 Jun 2022 05:12:54 +0200
Date:   Wed, 1 Jun 2022 05:12:54 +0200
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
Message-ID: <20220601031254.GB26318@1wt.eu>
References: <20220531230309.9290-1-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531230309.9290-1-vegard.nossum@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vegard,

On Wed, Jun 01, 2022 at 01:03:09AM +0200, Vegard Nossum wrote:
> The current instructions for reporting security vulnerabilities in the
> kernel are not clear enough, in particular the process of disclosure
> and requesting CVEs, and what the roles of the different lists are and
> how exactly to report to each of them.
> 
> Let's give this document an overhaul. Goals are stated as a comment at
> the top of the document itself (these will not appear in the rendered
> document).

Thanks for working on this, I'm having a few comments below.

> +Linux kernel security team at security@kernel.org, henceforth "the
> +security list". This is a closed list of trusted developers who will
> +help verify the bug report and develop a patch.

+ "in case none was already proposed".

There's indeed recently a tendency on the list to get a lot of first-time
reports from individuals showing that some work was done trying to make
some code parts fail, but no effort was made to try to figure how these
ought to be addressed, and that costs a lot of time, because once the
analysis was done, the person who knows best about the problem and how
to fix it is the reporter, and we must absolutely encourage that the
work is finished and a candidate patch is proposed. Usually, returning
reporters propose patches, so I think they understand the value in doing
the work properly, which makes me think that we just don't make that
obvious enough from the rules. It's also possible that many reporters
are not used to working with OSS projects and imagine it's inappropriate
of them to propose a fix. But the question that's the most commonly
asked on the list is "do you have a patch for this?".

Overall it seems that reporters are willing to do their best but that
it's never easy to engage in such a bug disclosure process which may
involve short times, and that it can be stressful for the reporters
who forget to do a lot of the parts they would do for more regular
bugs.

> +While the security list is closed, the security team may bring in
> +extra help from the relevant maintainers to understand and fix the
> +security vulnerability.
> +
> +Note that the main interest of the kernel security list is in getting
> +bugs fixed; CVE assignment, disclosure to distributions, and public
> +disclosure happens on different lists with different people.

I think it's also important to explain that sometimes some patches may
be merged ASAP to plug a hole and let them flow to stable branches,
while letting the reporter deal with the full disclosure once they
consider that enough time has elapsed. The recent "dirty pipe" fix was
one of the best examples of a report that went smoothly and allowed the
reporter to work on a nice description of the problem:

    https://dirtypipe.cm4all.com/

There's always this gray area between getting a fix merged and disclosing
all the details of the bug. A bug indeed becomes public once the fix is
merged, but that doesn't mean that all the details are shared, so the
reporter still has the opportunity to write their story about it. The
reporter must only understand that it's only a matter of time between
the merge of a fix and the moment someone will understand how to exploit
the bug and publish about it.

> +Here is a quick overview of the various lists:
> +
> +.. list-table::
> +   :widths: 35 10 20 35
> +   :header-rows: 1
> +
> +   * - List address
> +     - Open?
> +     - Purpose
> +     - Members
> +   * - security@kernel.org
> +     - Closed
> +     - Reporting; patch development
> +     - Trusted kernel developers
> +   * - linux-distros@vs.openwall.org
> +     - Closed
> +     - Coordination; CVE assignment; patch development, testing, and backporting
> +     - Linux distribution representatives
> +   * - oss-security@lists.openwall.com
> +     - Public
> +     - Disclosure
> +     - General public

While this part renders well on your HTML version, I'm afraid it's totally
unreadable here in the text version, and this document is supposed to be
the one reporters will use. I suggest to try again with an item list
instead of a table.

> +**Disclosure.** The security list prefers to merge fixes into the
> +appropriate public git repository as soon as they become available.
> +However, you or an affected party may request that the patch be
> +withheld for up to 7 calendar days from the availability of the patch,
> +with an exceptional extension to 14 calendar days if it is agreed that
> +the bug is critical enough to warrant more time. The only valid reason
> +for deferring the publication of a fix is to accommodate the logistics
> +of QA and large scale rollouts which require release coordination.

I'm still having an issue here. Originally it was something along "up
to 5 days if there's a really compelling reason". Then it was extended
to 7 days in order to better match the tuesday-to-thursday range. Then
"up to 14 days" for exceptional cases (i.e. hopefully never). But the
wording tends to make all reporters think that asking for 7 days is
normal. We really need to make it even clearer that:
  - the default is no embargo

  - if there is a *really compelling reason* (that has to be justified
    by the reporter), it may reach *up to 7 days*

  - in exceptional cases (the bug-of-the-year with a risk of massive
    exploitation requiring coordination) it may be extended to 14 days

  - "I already contacted this or that list so you must respect THEIR
    embargo" is NOT a valid justification to withhold a fix

  - dealing with embargoes is a pain, a withheld patch risks to be
    forgotten or confused with a previous version of the patch that
    appeared in discussions, it's difficult to synchronize stable
    and mainline, and the risk that it leaks by accident grows with
    time and with the number of participants in a discussion.

Just my two cents.
Willy
