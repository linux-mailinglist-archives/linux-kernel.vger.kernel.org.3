Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2896C4897B1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244941AbiAJLlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244875AbiAJLkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:40:53 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9511AC06173F;
        Mon, 10 Jan 2022 03:40:52 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1n6t2f-000747-Ab; Mon, 10 Jan 2022 12:40:49 +0100
Message-ID: <4398ddfe-9db4-bf67-902d-e0416b815878@leemhuis.info>
Date:   Mon, 10 Jan 2022 12:40:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-BS
To:     Matthias Brugger <mbrugger@suse.com>, linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
References: <cover.1641565030.git.linux@leemhuis.info>
 <f71246e0999520d681c7b35d24f7eed2f53ee2b4.1641565030.git.linux@leemhuis.info>
 <28b56512-d681-4a3a-98f0-a2eae34a217e@suse.com>
 <1126ce91-f22b-c397-4d1e-13d290a424a5@leemhuis.info>
 <8e6f07ef-10fe-381c-3a8d-db497492036c@suse.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [RFC PATCH v2 1/2] docs: add a document about regression handling
In-Reply-To: <8e6f07ef-10fe-381c-3a8d-db497492036c@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1641814852;ff1feeda;
X-HE-SMSGID: 1n6t2f-000747-Ab
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.01.22 18:44, Matthias Brugger wrote:
> On 07/01/2022 17:51, Thorsten Leemhuis wrote:
>> On 07.01.22 16:37, Matthias Brugger wrote:
>>> On 07/01/2022 15:21, Thorsten Leemhuis wrote:
>>>> Create a document explaining various aspects around regression handling
>>>> and tracking both for users and developers. Among others describe the
>>>> first rule of Linux kernel development and what it means in practice.
>>>> Also explain what a regression actually is and how to report one
>>>> properly. The text additionally provides a brief introduction to the
>>>> bot
>>>> the kernel's regression tracker uses to facilitate his work. To sum
>>>> things up, provide a few quotes from Linus to show how serious he takes
>>>> regressions.
>>>>
>>>> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
>>> [...]
>>>> +The important bits for people fixing regressions
>>>> +================================================
>>>> +
>>>> +When receiving regression reports by mail, check if the reporter CCed
>>>> `the
>>>> +regression mailing list <https://lore.kernel.org/regressions/>`_
>>>> +(regressions@lists.linux.dev). If not, forward or bounce the report
>>>> to the Linux
>>>> +kernel's regression tracker (regressions@leemhuis.info), unless you
>>>> plan on
>>>
>>> I would have expected it to be the same mailing list
>>> (regressions@lists.linux.dev), is this a typo maybe?
>>
>> Thx for taking a look. Hmm. That's possible, but I (and the grep call I
>> just ran) fail to spot the typo.
>>
>> Maybe the wording is to confusing: regressions@lists.linux.dev is the
>> list, regressions@leemhuis.info is a dedicated email address I (the
>> kernel's regression tracker) use for regression tracking (which reminds
>> me: maybe I should ask for a alias like regressions@kernel.org or
>> regression-tracker@kernel.org).
> 
> Yes it's the wording then :)
> Anyway I just wonder why you we should send the regression to the
> regressions email list, but only to the tracker email address. For me
> that's the confusing part. I'd expect to send it to the list as well and
> the tracker takes it from there. If for any reason someone does not want
> to send a regression to the list, then he can send it to the tracker
> directly. That's my understanding of how this works. If that's correct
> then I'd say we should just explain the difference.

You comments made be revisit the section and made me spot a few other
issues I found less than ideal. So I rewrote it over the weekend (more
than once, to be precise...). I hope this clears things up.

```
The important bits for people fixing regressions
================================================

When submitting fixes for regressions, add "Link:" tags pointing to all
places where the issue was reported, as tools like the Linux kernel
regression bot 'regzbot' heavily rely on these; these pointers are also
of great value for people looking into the issue some time in the
future, as explained in `Documentation/process/submitting-patches.rst`
and :ref:`Documentation/process/5.Posting.rst <development_posting>`::

       Link:
https://lore.kernel.org/r/30th.anniversary.repost@klaava.Helsinki.FI/
       Link: https://bugzilla.kernel.org/show_bug.cgi?id=1234567890

Let the Linux kernel's regression tracker and all other subscribers of
the `regression mailing list <https://lore.kernel.org/regressions/>`_
(regressions@lists.linux.dev) quickly known about newly reported
regressions:

 * When receiving a mailed report that did not CC the list, immediately
send at least a brief "Reply-all" with the list CCed to get it into the
loop; also ensure its CCed on all future replies, in case it got lost.

 * If you receive a report from a bug tracker, forward or bounce the
report to the list, unless the reporter followed
`Documentation/admin-guide/reporting-issues.rst` instructions and did it
already.

[Optional] Ensure the Linux kernel regression bot 'regzbot' tracks the
issue:

 * For mailed reports, check if the reporter included a 'regzbot
command' like the ``#regzbot introduced v5.13..v5.14-rc1`` described
above. If not, send a reply with the regressions list in CC, which
includes a paragraph like the following:

       #regzbot ^introduced v5.13..v5.14-rc1

  Note, in this case there is a caret (^) before the `introduced` to
make regzbot treat the parent mail (the one you reply to) as the report
for the regression you want to see tracked.

  Instead of specifying a version range you can also state a commit-id,
in case the reporter identified the culprit.

 * When receiving a report from a bug tracker and forwarding it to the
regressions list (see above), include a paragraph like this:

       #regzbot introduced: v5.13..v5.14-rc1
       #regzbot from: Some N. Ice Human <some.human@example.com>
       #regzbot monitor:
http://some.bugtracker.example.com/ticket?id=123456789
```

Note, regzbot does not yet support "#regzbot from" and "#regzbot monitor
<bugtracker>", but I wanted to work on that soon anyway -- and this text
will likely take weeks before it hits mailine, so this shouldn't be a
problem.

Ciao, Thorsten
