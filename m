Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CDE49BFCC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 00:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbiAYX70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 18:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbiAYX7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 18:59:24 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FFFC06161C;
        Tue, 25 Jan 2022 15:59:24 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A9B1B383;
        Tue, 25 Jan 2022 23:59:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A9B1B383
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1643155163; bh=focxYZCFaAaUGFtTCCGc2LwTWI8PjsOHu5cqQ5p9ECs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gh4zCtuzsKMFb9rKNEsOduVvOMNd2nQyRC2Jgxj+1PK77G5xv6f/deXfu4gZf08Zg
         v/LCUQ0sDLtAbICrnCUZmBPRHGjidBXhoEqVlpVGc3Y/dgdTZcyjYe/Dsy7JRrZ3tr
         BT8H05DvXb5YOaUCYcJhN3KaujEHHrJyHCMRE5Z1RR4l9aeT7nnU7rdtaqGlc6VmD+
         UJYQTXAlXdk2vT0xsARpc8ZkEi64NA/tsaiwerq45V1p9V3v5IylEvI5eBAw0xJdb7
         IobuDDysaLlbGmS/dVmCqtrLjXlaeHVLraqWv1UUqlC1LD0JyujrINf1OBkSvmWY6M
         +FODyV+4kXGJA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>, linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        regressions@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH v3 1/2] docs: add a document about regression handling
In-Reply-To: <f97738d6250050bc982bf2947587f1c73f37446f.1643110442.git.linux@leemhuis.info>
References: <cover.1643110442.git.linux@leemhuis.info>
 <f97738d6250050bc982bf2947587f1c73f37446f.1643110442.git.linux@leemhuis.info>
Date:   Tue, 25 Jan 2022 16:59:51 -0700
Message-ID: <87sftbwemg.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thorsten Leemhuis <linux@leemhuis.info> writes:

> Create a document explaining various aspects around regression handling
> and tracking both for users and developers. Among others describe the
> first rule of Linux kernel development and what it means in practice.
> Also explain what a regression actually is and how to report one
> properly. The text additionally provides a brief introduction to the bot
> the kernel's regression tracker uses to facilitate his work. To sum
> things up, provide a few quotes from Linus to show how serious he takes
> regressions.
>
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  Documentation/admin-guide/index.rst       |   1 +
>  Documentation/admin-guide/regressions.rst | 911 ++++++++++++++++++++++
>  MAINTAINERS                               |   1 +
>  3 files changed, 913 insertions(+)
>  create mode 100644 Documentation/admin-guide/regressions.rst
>
> diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
> index 1bedab498104..17157ee5a416 100644
> --- a/Documentation/admin-guide/index.rst
> +++ b/Documentation/admin-guide/index.rst
> @@ -36,6 +36,7 @@ problems and bugs in particular.
>  
>     reporting-issues
>     security-bugs
> +   regressions
>     bug-hunting
>     bug-bisect
>     tainted-kernels
> diff --git a/Documentation/admin-guide/regressions.rst b/Documentation/admin-guide/regressions.rst
> new file mode 100644
> index 000000000000..837b1658d149
> --- /dev/null
> +++ b/Documentation/admin-guide/regressions.rst
> @@ -0,0 +1,911 @@
> +.. SPDX-License-Identifier: (GPL-2.0+ OR CC-BY-4.0)
> +..
> +   If you want to distribute this text under CC-BY-4.0 only, please use 'The
> +   Linux kernel developers' for author attribution and link this as source:
> +   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Documentation/admin-guide/regressions.rst
> +..
> +   Note: Only the content of this RST file as found in the Linux kernel sources
> +   is available under CC-BY-4.0, as versions of this text that were processed
> +   (for example by the kernel's build system) might contain content taken from
> +   files which use a more restrictive license.

I wonder if we could put this boilerplate at the bottom, with a single
"see the bottom for redistribution information" line here?  Most readers
won't care about this stuff and shouldn't have to slog through it to get
to what they want to read.

> +Regressions
> ++++++++++++
> +
> +The first rule of Linux kernel development: '*We don't cause regressions*'.
> +Linux founder and lead developer Linus Torvalds strictly enforces the rule
> +himself. This document describes what it means in practice and how the Linux
> +kernel's development model ensures all reported regressions are addressed.
> +The text covers aspects relevant for both users and developers.

So that last line makes me a bit nervous; I've really been trying to get
us to organize our documentation for the readers.  So, without having
read what follows in depth yet, I wonder if we don't really want two
different documents: a developer document (which maybe belongs in
Documentation/process) and a user document?

> +The important bits for people affected by regressions
> +=====================================================
> +
> +It's a regression if something running fine with one Linux kernel works worse or
> +not at all with a newer version. Note, the newer kernel has to be compiled using
> +a similar configuration -- for this and other fine print, check out below
> +section "What is a 'regression' and what is the 'no regressions rule'?".

Can we be consistent with either single or double quotes?  I'd suggest
"double quotes" but won't make a fuss about that.

> +Report your regression as outlined in
> +`Documentation/admin-guide/reporting-issues.rst`, it already covers all aspects

No need to quote the file name.

> +important for regressions. Below section "How do I report a regression?"
> +highlights them for convenience.

The "How do I report a regression?" section, below, highlights...

> +The most important aspect: CC or forward the report to `the regression mailing
> +list <https://lore.kernel.org/regressions/>`_ (regressions@lists.linux.dev).

Is that really *the* most important thing? :)

> +When doing so, consider mentioning the version range where the regression
> +started using a paragraph like this::
> +
> +       #regzbot introduced v5.13..v5.14-rc1
> +
> +The Linux kernel regression tracking bot 'regzbot' will then start to track the
> +issue. This is in your interest, as it brings the report on the radar of people
> +ensuring all regressions are acted upon in a timely manner.
> +
> +The important bits for people fixing regressions
> +================================================
> +
> +When submitting fixes for regressions, add "Link:" tags pointing to all places
> +where the issue was reported, as tools like the Linux kernel regression bot
> +'regzbot' heavily rely on them. These pointers are also of great value when
> +looking into the issue months or years later, that's why
> +`Documentation/process/submitting-patches.rst` and
> +:ref:`Documentation/process/5.Posting.rst <development_posting>` mandate their
> +use::
> +
> +       Link: https://lore.kernel.org/r/30th.anniversary.repost@klaava.Helsinki.FI/
> +       Link: https://bugzilla.kernel.org/show_bug.cgi?id=1234567890

What is this literal block here for?

> +Let the Linux kernel's regression tracker and all other subscribers of the
> +`regression mailing list <https://lore.kernel.org/regressions/>`_
> +(regressions@lists.linux.dev) quickly know about newly reported regressions:

You've already linked this above, not sure it's needed again.

> + * When you receive a mailed report that did not CC the list, immediately send
> +   at least a brief "Reply-all" which get the list into the loop; also ensure
> +   it's CCed on all future replies.
> +
> + * If you get a report from a bug tracker, forward or bounce the report to the
> +   list, unless the reporter did that already as outlined by
> +   `Documentation/admin-guide/reporting-issues.rst`.
> +
> +Ensure regzbot tracks the issue (this is optional, but recommended):
> +
> + * For mailed reports, check if the reporter included a 'regzbot command' like
> +   the ``#regzbot introduced v5.13..v5.14-rc1`` described above. If not, send a
> +   reply (with the regressions list in CC) with a paragraph like the following,
> +   which brings regzbot into the loop by specifying the version range or commit
> +   when the issue started to happen::
> +
> +       #regzbot ^introduced 1f2e3d4c5b6a
> +
> + * When receiving a report from a bug tracker and forwarding it to the
> +   regressions list (see above), include a paragraph like the following, which
> +   brings regzbot into the loop by specifying the version range or commit when
> +   the issue started to happen::
> +
> +       #regzbot introduced: v5.13..v5.14-rc1
> +       #regzbot from: Some N. Ice Human <some.human@example.com>
> +       #regzbot monitor: http://some.bugtracker.example.com/ticket?id=123456789
> +
> +All the details on handling Linux kernel regressions
> +====================================================
> +
> +The important basics
> +--------------------
> +
> +What is a 'regression' and what is the 'no regressions rule'?
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +It's a regression if some application or practical use case running fine with
> +one Linux kernel works worse or not at all with a newer version compiled using a
> +similar configuration. The 'no regressions rule' forbids this to take place; if

So this is something you already said above.  This document is quite
long, we're asking a lot for people to read through the whole thing.
Repeating yourself and making it longer may not help that cause.

> +it happens by accident, developers that caused it are expected to quickly fix
> +the issue.
> +
> +It thus is a regression when a WiFi driver from Linux 5.13 works fine, but with
> +5.14 doesn't work at all, works significantly slower, or misbehaves somehow.
> +It's also a regression if a perfectly working application suddenly shows erratic
> +behavior with a newer kernel version, which can be caused by changes in procfs,
> +sysfs, or one of the many other interfaces Linux provides to userland software.
> +But keep in mind, as mentioned earlier: 5.14 in this example needs to be built
> +from a configuration similar to the one from 5.13. This can be achieved using
> +``make olddefconfig``, as explained in more detail below.
> +
> +Note the 'practical use case' in the first sentence of this section: developers
> +despite the 'no regressions' rule are free to change any aspect of the kernel
> +and even APIs or ABIs to userland, as long as no existing application or use
> +case breaks.
> +
> +Also be aware the 'no regressions' rule covers only interfaces the kernel
> +provides to the userland. It thus does not apply to kernel-internal interfaces
> +like the module API, which some externally developed drivers use to hook into
> +the kernel.
> +
> +What is the goal of the 'no regressions rule'?
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Users should feel safe when updating kernel versions and not have to worry
> +something might break. This is in the interest of the kernel developers to make
> +updating attractive: they don't want users to stay on stable or longterm Linux
> +series that are either abandoned or more than one and a half year old. That's in
> +everybody's interest, as `those series might have known bugs, security issues,
> +or other problematic aspects already fixed in later versions
> +<http://www.kroah.com/log/blog/2018/08/24/what-stable-kernel-should-i-use/>`_.
> +Additionally, the kernel developers want to make it simple and appealing for
> +users to test the latest pre-release or regular release. That's also in
> +everybody's interest, as it's a lot easier to track down and fix problems, if
> +they are reported shortly after being introduced.
> +
> +
> +How hard is the rule enforced?
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Extraordinarily strict, as can be seen by many mailing list posts from Linux
> +creator and lead developer Linus Torvalds, some of which are quoted at the end
> +of this document.
> +
> +Exceptions to this rule are extremely rare; in the past developers almost always
> +turned out to be wrong when they assumed a particular situation was warranting
> +an exception.
> +
> +How is the rule enforced?
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +It's the duty of the subsystem maintainers, which are watched and supported by
> +Linus Torvalds for mainline or stable/longterm tree maintainers like Greg
> +Kroah-Hartman. All of them are supported by Thorsten Leemhuis: he's acting as
> +'regressions tracker' for the Linux kernel and trying to ensure all regression
> +reports are acted upon in a timely manner.
> +
> +The distributed and slightly unstructured nature of the Linux kernel's
> +development makes tracking regressions hard. That's why Thorsten relies on the
> +help of his Linux kernel regression tracking robot 'regzbot'. It watches mailing
> +lists and git trees to semi-automatically associate regression reports with
> +patch submissions and commits fixing the issue, as this provides all necessary
> +insights into the fixing progress.
> +
> +Note, the regression tracker can only ensure no regression falls through the
> +cracks, if someone tells him or his bot about every regression found. That's why
> +each report needs to be CCed or forwarded to the regressions mailing list
> +(ideally with a 'regzbot command' in the mail), as explained in the next
> +section.

So this isn't really enforcement information, it's tracking, which is
different...  If you really want to talk about enforcement, you might
mention that offending patches can be reverted if they are not fixed in
a timely manner.

> +How do I report a regression?
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Just report the issue as outlined in
> +`Documentation/admin-guide/reporting-issues.rst`, it already describes the
> +important points. The following aspects described there are especially relevant
> +for regressions:
> +
> + * When checking for existing reports to join, first check the `archives of the
> +   Linux regressions mailing list <https://lore.kernel.org/regressions/>`_ and
> +   `regzbot's web-interface <https://linux-regtracking.leemhuis.info/regzbot/>`_.
> +
> + * In your report, mention the last kernel version that worked fine and the
> +   first broken one. Even better: try to find the commit causing the regression
> +   using a bisection.
> +
> + * Remember to let the Linux regressions mailing list
> +   (regressions@lists.linux.dev) know about your report:
> +
> +  * If you report the regression by mail, CC the regressions list.
> +
> +  * If you report your regression to some bug tracker, forward the filed report
> +    by mail to the regressions list while CCing the maintainer and the mailing
> +    list for the subsystem in question.
> +
> +Additionally, you in both cases should directly tell the aforementioned Linux
> +kernel regression tracking bot about your report. To do that, include a
> +paragraph like this in your report to tell the bot when the regression started
> +to happen::
> +
> +       #regzbot introduced: v5.13..v5.14-rc1
> +
> +In this example, v5.13 was the last version that worked, while v5.14-rc1 was the
> +first broken one. The smaller the range, the better, as that makes it easier to
> +find out what's wrong and who's responsible. That's why you ideally should
> +perform a bisection to find the commit causing the regression (the 'culprit').
> +If you did, specify it instead::
> +
> +       #regzbot introduced: 1f2e3d4c5d
> +
> +Placing such a 'regzbot command' is in your interest, as it will ensure the
> +report won't fall through the cracks unnoticed. If you omit this, the Linux
> +kernel's regressions tracker will take care of telling regzbot about your
> +regression, as long as you send a copy to the regressions mailing lists. But the
> +regression tracker is just one human which sometimes has to rest or occasionally
> +might even enjoy some time away from computers (as crazy as that might sound).

Naw, we don't allow that, sorry :)

> +Relying on this person thus will result in an unnecessary delay before the
> +regressions becomes mentioned `on the list of tracked and unresolved Linux
> +kernel regressions <https://linux-regtracking.leemhuis.info/regzbot/>`_ and the
> +weekly regression reports sent by regzbot. Such delays can result in Linus
> +Torvalds being unaware of important regressions when deciding between 'continue
> +development or call this finished and release the final?'.
> +
> +How to add a regression to regzbot's tracking somebody else reported?
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +It depends on the report:
> +
> + * If the regression was reported by mail, reply using your mailers 'Reply-all'
> +   function with the regressions mailing list (regressions@lists.linux.dev) in
> +   CC. In your reply, include a paragraph with a regzbot command like this::
> +
> +       #regzbot ^introduced: v5.13..v5.14-rc1
> +
> +   The caret (^) before the 'introduced' tells regzbot to treat the parent mail
> +   (the one you reply to) as the initial report for the regression you want to
> +   see tracked; regzbot then will automatically associate any patches with this
> +   regression that point to the report using 'Link:' tags.
> +
> + * If the regressions was reported to a bug tracker, forward it to the
> +   regressions list and include a paragraph with these regzbot commands::
> +
> +       #regzbot introduced: v5.13..v5.14-rc1
> +       #regzbot from: Some N. Ice Human <some.human@example.com>
> +       #regzbot monitor: http://some.bugtracker.example.com/ticket?id=123456789
> +
> +   Regzbot will automatically associate patches with the report that use 'Link:'
> +   tags pointing to your mail or the mentioned ticket.
> +
> +In both cases you can specify a commit-id instead of a version range, as the
> +previous section outlines in more detail.
> +
> +In case you are having trouble, simply forward the report or a pointer to it
> +without further ado to Thorsten Leemhuis (regressions@leemhuis.info), he then
> +will handle things.
> +
> +Are really all regressions fixed?
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Nearly all of them are, as long as the change causing the regression (the
> +'culprit commit') is reliably identified. Some regressions can be fixed without
> +this, but often it's required.
> +
> +Who needs to find the commit causing a regression?
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +It's the reporter's duty to find the culprit, but developers of the affected
> +subsystem should offer advice and reasonably help where they can.

Is it really our policy that *reporters* need to find the offending
commit?  That's certainly not my view of things, anyway?

> +How can I find the change causing a regression?
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Perform a bisection, as roughly outlined in `Documentation/admin-guide/reporting-issues.rst`
> +and described in more detail by `Documentation/admin-guide/bug-bisect.rst`.
> +It might sound like a lot of work, but in many cases finds the culprit
> +relatively quickly. If it's hard or time-consuming to reliably reproduce the
> +issue, consider teaming up with others affected by the problem to narrow down
> +the search range together.
> +
> +Who can I ask for advice when it comes to regressions?
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Send a mail to the regressions mailing list (regressions@lists.linux.dev) while
> +CCing the Linux kernel's regression tracker (regressions@leemhuis.info); if the
> +issue might better be dealt with in private, feel free to omit the list.
> +
> +
> +More details about regressions relevant for reporters
> +-----------------------------------------------------
> +
> +Does a regression need to be fixed, if it can be avoided by updating some other software?

It would be nice to keep to 80 columns if possible.  These long section
headings aren't great for readability.

> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Almost always: yes. If a developer tells you otherwise, ask the regression
> +tracker for advice as outlined above.
> +
> +Does it qualify as a regression if a newer kernel works slower or makes the system consume more energy?
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +It does, but the difference has to be significant. A five percent slow-down in a
> +micro-benchmark thus is unlikely to qualify as regression, unless it also
> +influences the results of a broad benchmark by more than one percent. If in
> +doubt, ask for advice.
> +
> +Is it a regression, if an externally developed kernel module is incompatible with a newer kernel?
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +No, as the 'no regression' rule is about interfaces and services the Linux
> +kernel provides to the userland. It thus does not cover building or running
> +externally developed kernel modules, as they run in kernel-space and hook into
> +the kernel using internal interfaces occasionally changed.
> +
> +How are regressions handled that are caused by a fix for security vulnerability?
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +In extremely rare situations security issues can't be fixed without causing
> +regressions; those are given way, as they are the lesser evil in the end.
> +Luckily this almost always can be avoided, as key developers for the affected
> +area and often Linus Torvalds himself try very hard to fix security issues
> +without causing regressions.
> +
> +If you nevertheless face such a case, check the mailing list archives if people
> +tried their best to avoid the regression; if in doubt, ask for advice as
> +outlined above.
> +
> +What happens if fixing a regression is impossible without causing another regression?
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Sadly these things happen, but luckily not very often; if they occur, expert
> +developers of the affected code area should look into the issue to find a fix
> +that avoids regressions or at least their impact. If you run into such a
> +situation, do what was outlined already for regressions caused by security
> +fixes: check earlier discussions if people already tried their best and ask for
> +advice if in doubt.
> +
> +A quick note while at it: these situations could be avoided, if people would
> +regularly give mainline pre-releases (say v5.15-rc1 or -rc3) from each cycle a
> +test run. This is best explained by imagining a change integrated between Linux
> +v5.14 and v5.15-rc1 which causes a regression, but at the same time is a hard
> +requirement for some other improvement applied for 5.15-rc1. All these changes
> +often can simply be reverted and the regression thus solved, if someone finds
> +and reports it before 5.15 is released. A few days or weeks later this solution
> +can become impossible, as some software might have started to rely on aspects
> +introduced by one of the follow-up changes: reverting all changes would then
> +cause a regression for users of said software and thus is out of the question.
> +
> +A feature I relied on was removed months ago, but I only noticed now. Does that qualify as regression?
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +It does, but often it's hard to fix them due to the aspects outlined in the
> +previous section. It hence needs to be dealt with on a case-by-case basis. This
> +is another reason why it's in everybody's interest to regularly test mainline
> +pre-releases.
> +
> +Does the 'no regression' rule apply if I seem to be the only person in the world that is affected by a regression?
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +It does, but only for practical usage: the Linux developers want to be free to
> +remove support for hardware only to be found in attics and museums anymore.
> +
> +Note, sometimes regressions can't be avoided to make progress -- and the latter
> +is needed to prevent Linux from stagnation. Hence, if only very few users seem
> +to be affected by a regression, it for the greater good might be in their and
> +everyone else's interest to not insist on the rule. Especially if there is an
> +easy way to circumvent the regression somehow, for example by updating some
> +software or using a kernel parameter created just for this purpose.
> +
> +Does the regression rule apply for code in the staging tree as well?
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Not according to the `help text for the configuration option covering all
> +staging code <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/staging/Kconfig>`_,
> +which since its early days states::
> +
> +       Please note that these drivers are under heavy development, may or
> +       may not work, and may contain userspace interfaces that most likely
> +       will be changed in the near future.
> +
> +The staging developers nevertheless often adhere to the 'no regressions' rule,
> +but sometimes bend it to make progress. That's for example why some users had to
> +deal with (often negligible) regressions when a WiFi driver from the staging
> +tree was replaced by a totally different one written from scratch.
> +
> +Why do later versions have to be 'compiled with a similar configuration'?
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Because the Linux kernel developers sometimes integrate changes known to cause
> +regressions, but make them optional and disable them in the kernel's default
> +configuration. This trick allows progress, as the 'no regressions' rule
> +otherwise would lead to stagnation.
> +
> +Consider for example a new security feature blocking access to some kernel
> +interfaces often abused by malware, which at the same time are required to run a
> +few rarely used applications. The outlined approach makes both camps happy:
> +people using these applications can leave the new security feature off, while
> +everyone else can enable it without running into trouble.
> +
> +How to create a configuration similar to the one of an older kernel?
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Start a known-good kernel and configure the newer Linux version with ``make

Start *with* a ... ?

> +olddefconfig``. This makes the kernel's build scripts pick up the configuration
> +file (the `.config` file) from the running kernel as base for the new one you
> +are about to compile; afterwards they set all new configuration options to their
> +default value, which should disable new features that might cause regressions.
> +
> +Can I report a regression to the upstream developers I found in a pre-compiled vanilla kernel?
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +You need to ensure the newer kernel was compiled with a similar configuration
> +file as the older one (see above), as the one that built them might have enabled
> +some known-to-be incompatible feature for the newer kernel. If in a doubt,
> +report this problem to the kernel's provider and ask for advice.
> +
> +
> +More details about regressions relevant for developers
> +------------------------------------------------------
> +
> +What should I do, if I suspect a change I'm working on might cause regressions?
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Evaluate how big the risk of regressions is, for example by performing a code
> +search in Linux distributions and Git forges. Also consider asking other
> +developers or projects likely to be affected to evaluate or even test the
> +proposed change; if problems surface, maybe some middle ground acceptable for
> +all can be found.
> +
> +If the risk of regressions in the end seems to be relatively small, go ahead
> +with the change, but let all involved parties know about the risk. Hence, make
> +sure your patch description makes this aspect obvious. Once the change is
> +merged, tell the Linux kernel's regression tracker and the regressions mailing
> +list about the risk, so everyone has the change on the radar in case reports
> +trickle in. Depending on the risk, you also might want to ask the subsystem
> +maintainer to mention the issue in his mainline pull request.
> +
> +
> +Everything developers need to know about regression tracking
> +------------------------------------------------------------
> +
> +Do I have to use regzbot?
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +It's in the interest of everyone if you do, as kernel maintainers like Linus
> +Torvalds partly rely on regzbot's tracking in their work -- for example when
> +deciding to release a new version or extend the development phase. For this they
> +need to be aware of all unfixed regression; to do that, Linus is known to look
> +into the weekly reports sent by regzbot.
> +
> +Do I have to tell regzbot about every regression I stumble upon?
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Ideally yes: we are all humans and easily forget problems when something more
> +important unexpectedly comes up -- for example a bigger problem in the Linux
> +kernel or something in real life that's keeping us away from keyboards for a
> +while. Hence, it's best to tell regzbot about every regression, except when you
> +immediately write a fix and commit it to a tree regularly merged to the affected
> +kernel series.
> +
> +Why does the Linux kernel need a regression tracker, and why does he utilize regzbot?
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

s/he/it/  (or "why is regzbot used?")

> +Rules like 'no regressions' need someone to enforce them, otherwise they are
> +broken either accidentally or on purpose. History has shown that this is true
> +for the Linux kernel as well. That's why Thorsten volunteered to keep an eye on
> +things.

[...]

> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea3e6c914384..03bb629302cb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10438,6 +10438,7 @@ KERNEL REGRESSIONS
>  M:	Thorsten Leemhuis <linux@leemhuis.info>
>  L:	regressions@lists.linux.dev
>  S:	Supported
> +F:	Documentation/admin-guide/regressions.rst
>  
>  KERNEL SELFTEST FRAMEWORK
>  M:	Shuah Khan <shuah@kernel.org>

OK, now that I'm at the end, I would like to suggest splitting this
material up.  Few people will make it through that whole thing...  It
seems to me that we need is:

 - How to report and track a regression (admin guide probably)
 - Regression sermon for developers including Linus quotes (process)
 - Reference guide for regzbot directives (process or tools)

That should get each of them to a manageable length where readers will
be able to get to the information they are looking for at the time.  I
would think this would mostly be a matter of hacking out pieces from the
above and putting them in the proper place.

See what I'm getting at?  Does that make sense to you?

Thanks,

jon
