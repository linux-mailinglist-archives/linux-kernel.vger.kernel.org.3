Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362FD53F917
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238965AbiFGJHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237225AbiFGJHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:07:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3206005E;
        Tue,  7 Jun 2022 02:07:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A721260A55;
        Tue,  7 Jun 2022 09:07:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68392C385A5;
        Tue,  7 Jun 2022 09:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654592854;
        bh=oy94gBKclPiSri9iMSjQIooenS5qZDCAuitKuHsxNOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZzBmvUn+fG4lGAvIz4wMYcplKFGUdvZFb1+Gj1SX+HehCyaHuI281+tZNwt69ldLe
         q2gjrFCn4cfnJHiovIdkVXuVmZF7wCjfy8FQoHPmZaA5W05HHm7NHr4SHuYz059ma9
         MhbT/J8rtJTRhvoCSX8vmo3fY8H9x0DOzok4QZoJUDOeX3tQcg+igGe7x1GeaQL5v0
         iH8Jefmh2+Y395HEc9oagBh0tqNzlUFzbVFFAUr9mnIjcWtubs3enzuNKb5Y9BKl8E
         muQVE5Q5ABUs5+LFh1dkmnuVJG5LCud2TZ+t/Gk0Ab/BJeY4Nqc0tDbnQwyPI4LlYd
         IseQ6nh5lY+cQ==
Date:   Tue, 7 Jun 2022 10:07:26 +0100
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
Message-ID: <20220607090726.GB32282@willie-the-truck>
References: <20220606194850.26122-1-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606194850.26122-1-vegard.nossum@oracle.com>
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

Hi,

On Mon, Jun 06, 2022 at 09:48:50PM +0200, Vegard Nossum wrote:
> The current instructions for reporting security vulnerabilities in the
> kernel are not clear enough, in particular the process of disclosure
> and requesting CVEs, and what the roles of the different lists are and
> how exactly to report to each of them.
> 
> Let's give this document an overhaul. Goals are stated as a comment at
> the bottom of the document; these will not appear in the rendered HTML
> document.
> 
> v2: address feedback from Willy Tarreau and Jonathan Corbet
> 
> Link: https://seclists.org/oss-sec/2022/q2/133
> Cc: Amit Shah <aams@amazon.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Cc: Jiri Kosina <jkosina@suse.cz>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Laura Abbott <labbott@kernel.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Solar Designer <solar@openwall.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Thorsten Leemhuis <linux@leemhuis.info>
> Cc: Tyler Hicks <tyhicks@linux.microsoft.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Willy Tarreau <w@1wt.eu>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  Documentation/admin-guide/security-bugs.rst | 252 +++++++++++++-------
>  1 file changed, 167 insertions(+), 85 deletions(-)
> 
> v1 thread:
> https://lore.kernel.org/all/20220531230309.9290-1-vegard.nossum@oracle.com/T/#u
> 
> Updated rendered HTML:
> https://vegard.github.io/security/Documentation/output/admin-guide/security-bugs-v2.html
> 
> diff --git a/Documentation/admin-guide/security-bugs.rst b/Documentation/admin-guide/security-bugs.rst
> index 82e29837d5898..c63eeb1e89ffd 100644
> --- a/Documentation/admin-guide/security-bugs.rst
> +++ b/Documentation/admin-guide/security-bugs.rst
> @@ -1,96 +1,178 @@
> +
>  .. _securitybugs:
>  
> -Security bugs
> -=============
> +Reporting security bugs
> +=======================
>  
>  Linux kernel developers take security very seriously.  As such, we'd
>  like to know when a security bug is found so that it can be fixed and
>  disclosed as quickly as possible.  Please report security bugs to the
> -Linux kernel security team.
> -
> -Contact
> --------
> -
> -The Linux kernel security team can be contacted by email at
> -<security@kernel.org>.  This is a private list of security officers
> -who will help verify the bug report and develop and release a fix.
> -If you already have a fix, please include it with your report, as
> -that can speed up the process considerably.  It is possible that the
> -security team will bring in extra help from area maintainers to
> -understand and fix the security vulnerability.
> -
> -As it is with any bug, the more information provided the easier it
> -will be to diagnose and fix.  Please review the procedure outlined in
> -'Documentation/admin-guide/reporting-issues.rst' if you are unclear about what
> -information is helpful.  Any exploit code is very helpful and will not
> -be released without consent from the reporter unless it has already been
> -made public.
> -
> -Please send plain text emails without attachments where possible.
> -It is much harder to have a context-quoted discussion about a complex
> -issue if all the details are hidden away in attachments.  Think of it like a
> -:doc:`regular patch submission <../process/submitting-patches>`
> -(even if you don't have a patch yet): describe the problem and impact, list
> +Linux kernel security team at security@kernel.org, henceforth "the
> +security list". This is a closed list of trusted developers who will
> +help verify the bug report and develop a patch in case none was already
> +proposed.
> +
> +While the security list is closed, the security team may bring in
> +extra help from the relevant maintainers to understand and fix the
> +security vulnerability.
> +
> +Note that the main interest of the kernel security list is in getting
> +bugs fixed and getting patches reviewed, tested, and merged; CVE
> +assignment, disclosure to distributions, and public disclosure happen
> +on different lists with different people, as described below.
> +
> +Here is a quick overview of the various lists:
> +
> + =============================== ===== =================== ===============
> + List address                    Open? Purpose             Members
> + =============================== ===== =================== ===============
> + security@kernel.org                no | Reporting         Trusted kernel
> +                                       | Patch development developers
> + ------------------------------- ----- ------------------- ---------------
> + linux-distros@vs.openwall.org      no | Coordination      Distribution
> +                                       | CVE assignment    representatives
> +                                       | Backporting
> +                                       | Testing
> + ------------------------------- ----- ------------------- ---------------
> + oss-security@lists.openwall.com   yes | Disclosure        General public
> + =============================== ===== =================== ===============
> +
> +The following sections give a step-by-step guide to reporting and
> +disclosure.
> +
> +Contacting the security list
> +----------------------------
> +
> +As it is with any bug, the more information provided the easier it will
> +be to diagnose and fix; please review the procedure outlined in
> +Documentation/admin-guide/reporting-issues.rst if you are unclear about
> +what information is helpful. Any exploit code is very helpful and will
> +not be released without consent from the reporter unless it has already
> +been made public. Reporters are encouraged to propose patches, participate
> +in the discussions of a fix, and test patches.
> +
> +The security team does not assign CVEs, nor does it require them
> +for reports or fixes. CVEs may be requested when the issue is reported to
> +the linux-distros list.
> +
> +**Disclosure.** The security list strongly prefers to have patches posted
> +for review and testing on public mailing lists and and merged into the

typo: "and and"

> +appropriate public git repository as soon as they become available.
> +However, in exceptional cases, you or an affected party may request that
> +the patch be withheld for some days; as a rule, the maximum is 7 days.
> +Only in truly exceptional cases will the security list consider deferring
> +the publication of a fix beyond this, and the only valid reason for doing
> +so would be to accommodate the logistics of QA and large scale rollouts
> +that require release coordination.

I think there's a semantic change here, and I tend to feel that these sort
of changes would be much easier to review if the semantic changes were done
separately from the reformatting or the addition of entirely new sections.
As it stands, the whole doc is effectively being replaced, but what we
currently have has been tweaked over the years (often as a result of
spirited debate) and I'm keen not to open up some of the issues we had
previously if at all possible.

Case in point: the new text above removes both the mention of "calendar
days" which is a useful disambiguation as well as removing the "extension
to 14 calendar days" which is a useful upper bound. Why are you removing
these?

You have also removed use of the term "robust fix", which I think was
useful. That is, security@ isn't going to post a broken patch to the public
list just because it's been available for 7 days; that period should only
begin (if it is even needed) once the fix is ready to go.

Thanks,

Will
