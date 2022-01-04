Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788E7484747
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 18:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbiADR51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 12:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiADR50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 12:57:26 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC86C061761;
        Tue,  4 Jan 2022 09:57:26 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1n4o3m-0006GG-Ol; Tue, 04 Jan 2022 18:57:23 +0100
Message-ID: <72fcaa40-5884-710f-58b6-bf40a1f58e57@leemhuis.info>
Date:   Tue, 4 Jan 2022 18:57:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-BS
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <cover.1641203216.git.linux@leemhuis.info>
 <7b71a1262b8b72d30154203bb14f00db7d4170ef.1641203216.git.linux@leemhuis.info>
 <CAKXUXMy-RT5kc5yzafQyxRQ1pfY2-K3KE9iAxFXvcB2o0V+ceQ@mail.gmail.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [RFC PATCH v1 1/2] docs: add a document about regression handling
In-Reply-To: <CAKXUXMy-RT5kc5yzafQyxRQ1pfY2-K3KE9iAxFXvcB2o0V+ceQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1641319046;2e4bdc63;
X-HE-SMSGID: 1n4o3m-0006GG-Ol
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.01.22 15:17, Lukas Bulwahn wrote:
> On Mon, Jan 3, 2022 at 3:23 PM Thorsten Leemhuis <linux@leemhuis.info> wrote:
>>
>> Create a document explaining various aspects around regression handling
>> and tracking both for users and developers. Among others describe the
>> first rule of Linux kernel development and what it means in practice.
>> Also explain what a regression actually is and how to report them
>> properly. The text additionally provides a brief introduction to the bot
>> the kernel's regression tracker users to facilitate the work. To sum
>> things up, provide a few quotes from Linus to show how serious the he
>> takes regressions.
>>
>> [...]
>
> [lots of helpful suggestions for fixes and small improvements]

Many thx, addressed all of them, not worth commenting on each of them
individually.


>> +What is the goal of the 'no regressions rule'?
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +Users should feel safe when updating kernel versions and not have to worry
>> +something might break. This is in the interest of the kernel developers to make
>> +updating attractive: they don't want users to stay on stable or longterm Linux
>> +series either abandoned or more than one and a half year old, as `those might
>> +have known problems, security issues, or other aspects already improved in later
>> +versions
>> +<http://www.kroah.com/log/blog/2018/08/24/what-stable-kernel-should-i-use/>`_.
>> +
> Maybe add something like this:
> 
> A larger user community means more exposure and more confidence that
> any critical bug introduced is likely to be found closer to the point
> in time it was introduced, and hence the shipped kernels have less
> critical bugs.
> 
> Just to close the line of thought here.

Hmmm. How about this instead:

The kernel developers also want to make it simple and appealing for
users to test the latest (pre-)release, as it's a lot easier to track
down and fix problems, if they are reported shortly after being introduced.
> Okay, that is how far I got reading for now.

Great, many thx for your help, much appreciated. FWIW, find below the
current version of the plain text which contains a few more fixes. Note,
thunderbird will insert wrong line breaks here.

Ciao, Thorsten



Does it qualify as a regression if a newer kernel works slower or makes
the system consume more energy?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

It does, but the difference has to be significant. A five percent
slow-down in a micro-benchmark thus is unlikely to qualify as
regression, unless it also influences the results of a broad benchmark
by more than one percent. If in doubt, ask for advice.

Is it a regression, if an externally developed kernel module is
incompatible with a newer kernel?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

No, as the 'no regression' rule is about interfaces and services the
Linux kernel provides to the userland. It thus does not cover building
or running externally developed kernel modules, as they run in
kernel-space and use occasionally changed internal interfaces to hook
into the kernel.

How are regressions handled that are caused by a fix for security
vulnerability?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In extremely rare situations security issues can't be fixed without
causing regressions; those are given way, as they are the lesser evil in
the end. Luckily this almost always can be avoided, as key developers
for the affected area and often Linus Torvalds himself try very hard to
fix security issues without causing regressions.

If you nevertheless face such a case, check the mailing list archives if
people tried their best to avoid the regression; if in doubt, ask for
advice as outlined above.

What happens if fixing a regression is impossible without causing
another regression?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Sadly these things happen, but luckily not very often; if they occur,
expert developers of the affected code area should look into the issue
to find a fix that avoids regressions or at least their impact. If you
run into such a situation you thus do what was outlined already for
regressions caused by security fixes: check earlier discussions if
people already tried their best and ask for advice if in doubt.

A quick note while at it: these situations could be avoided, if you
would regularly give mainline pre-releases (say v5.15-rc1 or -rc3) from
each cycle a test run. This is best explained by imagining a change
integrated between Linux v5.14 and v5.15-rc1 which causes a regression,
but at the same time is a hard requirement for some other improvement
applied for 5.15-rc1. All these changes often can simply be reverted and
the regression thus solved, if someone finds and reports it before 5.15
is released. A few days or weeks later after the release this solution
might become impossible, if some software starts to rely on aspects
introduced by one of the follow-up changes: reverting all changes would
cause regressions for users of said software and thus out of the question.

A feature I relied on was removed months ago, but I only noticed now.
Does that qualify as regression?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

It does, but often it's hard to fix them due to the aspects outlined in
the previous section. It hence needs to be dealt with on a case-by-case
basis; this is another reason why it's in your interest to regularly
test mainline releases.

Does the 'no regression' rule apply if I seem to be the only person in
the world that is affected by a regression?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

It does, but only for practical usage: the Linux developers want to be
free to remove support for hardware only to be found in attics and
museums anymore.

Note, sometimes regressions can't be avoided to make progress -- and the
latter is needed to prevent Linux from stagnation. Hence, if only very
few users seem to be affected by a regression, it for the greater good
might be in their and everyone else's interest to not insist on the
rule. Especially if there is an easy way to circumvent the regression
somehow, for example by updating some software or using a kernel
parameter created just for this purpose.

Does the regression rule apply for code in the staging tree as well?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Not according to the `help text for the configuration option covering
all staging code
<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/staging/Kconfig>`_,
which since its early days states::

       Please note that these drivers are under heavy development, may or
       may not work, and may contain userspace interfaces that most likely
       will be changed in the near future.

The staging developers nevertheless often adhere to the 'no regressions'
rule, but sometimes bend it to make progress. That's for example why
some users had to deal with (often negligible) regressions when a WiFi
driver from the staging tree was replaced by a totally different one
written from scratch.

Why do later versions have to be 'compiled with a similar configuration'?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Because the Linux kernel developers sometimes integrate changes known to
cause regressions, but make them optional and disable them in the
kernel's default configuration. This trick allows progress, as the 'no
regressions' rule otherwise would lead to stagnation. Consider for
example a new security feature which blocks access to some kernel
interfaces often abused by malware, but at the same time are required to
run a few rarely used applications. The outlined trick makes both camps
happy: people using these applications can leave the new security
feature off, while everyone else can enable it without running into trouble.

How to create a configuration similar to the one of an older kernel?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Start a known-good kernel and configure the newer Linux version with
``make olddefconfig``. This makes the kernel's build scripts pick up the
configuration file (the `.config` file) from the running kernel as base
for the new one you are about to compile; afterwards they set all new
configuration options to their default value, which disables new
features that might cause regressions.

Can I report a regression with vanilla kernels provided by someone else
to the upstream Linux kernel developers?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Only if the newer kernel was compiled with a similar configuration file
as the older one (see above), as your provider might have enabled some
known-to-be incompatible feature in the newer kernel. If in a doubt,
report this problem to the provider and ask for advice.


More details about regressions relevant for developers
------------------------------------------------------

What should I do, if I suspect a change I'm working on might cause
regressions?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Evaluate how big the risk of regressions is, for example by performing a
code search in Linux distributions and Git forges. Also consider asking
other developers or projects likely to be affected to evaluate or even
test the proposed change; if problems surface, maybe some middle ground
acceptable for all can be found.

If the risk of regressions in the end seems to be relatively small, go
ahead with the change, but let all involved parties know about the risk.
Hence, make sure your patch description makes this aspect obvious. Once
the change is merged, tell the Linux kernel's regression tracker and the
regressions mailing list about the risk, so everyone has the change on
the radar in case reports trickle in. Depending on the risk, you also
might want to ask the subsystem maintainer to mention the issue in his
pull request to mainline.


Everything developers need to know about regression tracking
------------------------------------------------------------

Do I have to use regzbot?
~~~~~~~~~~~~~~~~~~~~~~~~~

It's in the interest of everyone if you do, as kernel maintainers like
Linus Torvalds partly rely on regzbot's tracking in their work -- for
example when deciding to release a new version or extend the development
phase. For this they need to be aware of all unfixed regression; to do
that, Linus is known to look into the weekly reports sent by regzbot.

Do I have to tell regzbot about every regression I stumble upon?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ideally yes: we are all humans and easily forget problems when something
more important unexpectedly comes up -- for example a bigger problem in
the Linux kernel or something in real life that's keeping us away from
keyboards for a while. Hence, it's best to tell regzbot about every
regression, except when you immediately write a fix and commit it to a
tree regularly merged to the affected kernel series.

Why does the Linux kernel need a regression tracker, and why does he
utilize regzbot?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Rules like 'no regressions' need someone to enforce them, otherwise they
are broken either accidentally or on purpose. History has shown that
this is true for the Linux kernel as well. That's why Thorsten
volunteered to keep an eye on things.

Tracking regressions completely manually has proven to be exhausting and
demotivating, which is why earlier attempts to establish it failed after
a while. To prevent this from happening again, Thorsten developed
Regzbot to facilitate the work, with the long term goal to automate
regression tracking as much as possible for everyone involved.

How does regression tracking work with regzbot?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The bot keeps track of all the reports and monitors their fixing
progress. It tries to do that with as little overhead as possible for
both reporters and developers.

In fact, only reporters or someone helping them are burdened with an
extra duty: they need to tell regzbot about the regression report using
one of the ``#regzbot introduced`` commands outlined above.

For developers there normally is no extra work involved, they just need
to do something that's expected from them already: add 'Link:' tags to
the patch description pointing to all reports about the issue fixed.

Thanks to these tags regzbot can associate regression reports with
patches to fix the issue, whenever they are posted for review or applied
to a git tree. The bot additionally watches out for replies to the
report. All this data combined provides a good impression about the
current status of the fixing process.

How to see which regressions regzbot tracks currently?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Check `regzbot's web-interface
<https://linux-regtracking.leemhuis.info/regzbot/>`_ for the latest
info; alternatively, `search for the latest regression report
<https://lore.kernel.org/lkml/?q=%22Linux+regressions+report%22+f%3Aregzbot>`_,
which regzbot normally sends out once a week on Sunday evening (UTC),
which is a few hours before Linus usually publishes new (pre-)releases.

What places is regzbot monitoring?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Regzbot is watching the most important Linux mailing lists as well as
the linux-next, mainline and stable/longterm git repositories.

How to interact with regzbot?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Everyone can interact with the bot using mails containing `regzbot
commands`, which need to be in their own paragraph (IOW: they need to be
separated from the rest of the mail using blank lines). One such command
is ``#regzbot introduced <version or commit>``, which adds a report to
the tracking, as already described above; ``#regzbot ^introduced
<version or commit>`` is another such command, which makes regzbot
consider the parent mail as a report for a regression which it starts to
track.

Once one of those two commands has been utilized, other regzbot commands
can be used. You can write them below one of the `introduced` commands
or in replies to the mail that used one of them or itself is a reply to
that mail:

 * Set or update the title::

       #regzbot title: foo

 * Link to a related discussion (for example the posting of a patch to
fix the issue) and monitor it::

       #regzbot monitor:
https://lore.kernel.org/all/30th.anniversary.repost@klaava.Helsinki.FI/

   Monitoring only works for lore.kernel.org; regzbot will consider all
messages in that thread as related to the fixing process.

 * Point to a place with further details, like a bug tracker or a
related mailing list post::

       #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=123456789

 * Mark a regression as fixed by a commit that is heading upstream or
already landed::

       #regzbot fixed-by: 1f2e3d4c5d

 * Mark a regression as a duplicate of another one already tracked by
regzbot::

       #regzbot dup-of:
https://lore.kernel.org/all/30th.anniversary.repost@klaava.Helsinki.FI/

 * Mark a regression as invalid::

       #regzbot invalid: wasn't a regression, problem has always existed

Is there more to tell about regzbot and its commands?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

More detailed and up-to-date information about the Linux kernels
regression tracking bot can be found on its `project page
<https://gitlab.com/knurd42/regzbot>`_, which among others contains a
`getting started guide
<https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md>`_
and `reference documentation
<https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md>`_
which both are more in-depth.
