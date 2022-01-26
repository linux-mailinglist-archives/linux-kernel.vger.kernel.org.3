Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B10649CBE3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241809AbiAZOLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbiAZOLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:11:01 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4074AC06161C;
        Wed, 26 Jan 2022 06:11:01 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nCj0j-0007UV-QM; Wed, 26 Jan 2022 15:10:57 +0100
Message-ID: <c8d7228a-2df5-df92-6d53-c3e940274dad@leemhuis.info>
Date:   Wed, 26 Jan 2022 15:10:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-BS
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        regressions@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
References: <cover.1643110442.git.linux@leemhuis.info>
 <f97738d6250050bc982bf2947587f1c73f37446f.1643110442.git.linux@leemhuis.info>
 <87sftbwemg.fsf@meer.lwn.net>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v3 1/2] docs: add a document about regression handling
In-Reply-To: <87sftbwemg.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1643206261;b335d8f8;
X-HE-SMSGID: 1nCj0j-0007UV-QM
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26.01.22 00:59, Jonathan Corbet wrote:
> Thorsten Leemhuis <linux@leemhuis.info> writes:
> 
>> Create a document explaining various aspects around regression handling
>> and tracking both for users and developers. Among others describe the
>> first rule of Linux kernel development and what it means in practice.
>> Also explain what a regression actually is and how to report one
>> properly. The text additionally provides a brief introduction to the bot
>> the kernel's regression tracker uses to facilitate his work. To sum
>> things up, provide a few quotes from Linus to show how serious he takes
>> regressions.
>>
> [...]

Many thx for your feedback, much appreciated. I trimmed the reply to not
mention all the places where I fixed things as suggested.

>> +   Note: Only the content of this RST file as found in the Linux kernel sources
>> +   is available under CC-BY-4.0, as versions of this text that were processed
>> +   (for example by the kernel's build system) might contain content taken from
>> +   files which use a more restrictive license.
> 
> I wonder if we could put this boilerplate at the bottom, with a single
> "see the bottom for redistribution information" line here?  Most readers
> won't care about this stuff and shouldn't have to slog through it to get
> to what they want to read.

Totally fine with me. When I touch reporting-issues.rst the next time
I'll move it downwards as well.

>> +Regressions
>> ++++++++++++
>> +
>> +The first rule of Linux kernel development: '*We don't cause regressions*'.
>> +Linux founder and lead developer Linus Torvalds strictly enforces the rule
>> +himself. This document describes what it means in practice and how the Linux
>> +kernel's development model ensures all reported regressions are addressed.
>> +The text covers aspects relevant for both users and developers.
> 
> So that last line makes me a bit nervous; I've really been trying to get
> us to organize our documentation for the readers.  So, without having
> read what follows in depth yet, I wonder if we don't really want two
> different documents: a developer document (which maybe belongs in
> Documentation/process) and a user document?

Fun fact: I also got nervous when I added that sentence, as it lead to a
similar thought in my head already. :-/ After some internal debate I
decided that quite a few things overlap and continued to keep it in one
document, but after the text grew somewhat more I guess I have to agree.
More on this below.

>> +The important bits for people affected by regressions
>> +=====================================================
>> +
>> +It's a regression if something running fine with one Linux kernel works worse or
>> +not at all with a newer version. Note, the newer kernel has to be compiled using
>> +a similar configuration -- for this and other fine print, check out below
>> +section "What is a 'regression' and what is the 'no regressions rule'?".
> Can we be consistent with either single or double quotes?  I'd suggest
> "double quotes" but won't make a fuss about that.

Changed to "double quotes" everywhere in the text. But just to make sure
I get things right: in this particular case this will result in

...section "What is a "regression" and what is the "no regressions rule"?".

This looks a bit strange to me. Something in me really would like to
quote the section's header in single quotes, but I guess grammar rules
do not allow that, so whatever. :-D

>> +Report your regression as outlined in
>> +`Documentation/admin-guide/reporting-issues.rst`, it already covers all aspects
> No need to quote the file name.

Okay, I thought I had seen some commit or instructions that it's better
to use them in this case, but my brain must have imagined it.

>> +When submitting fixes for regressions, add "Link:" tags pointing to all places
>> +where the issue was reported, as tools like the Linux kernel regression bot
>> +'regzbot' heavily rely on them. These pointers are also of great value when
>> +looking into the issue months or years later, that's why
>> +`Documentation/process/submitting-patches.rst` and
>> +:ref:`Documentation/process/5.Posting.rst <development_posting>` mandate their
>> +use::
>> +
>> +       Link: https://lore.kernel.org/r/30th.anniversary.repost@klaava.Helsinki.FI/
>> +       Link: https://bugzilla.kernel.org/show_bug.cgi?id=1234567890
> 
> What is this literal block here for?

It's meant as an example. Should I simply add a ", e.g. like this" after
the "use"?

>> +Let the Linux kernel's regression tracker and all other subscribers of the
>> +`regression mailing list <https://lore.kernel.org/regressions/>`_
>> +(regressions@lists.linux.dev) quickly know about newly reported regressions:
> You've already linked this above, not sure it's needed again.

When I started this document I didn't mean it to be read from top to
bottom and repeated some things. But with the split this will likely
change somewhat.

>> +What is a 'regression' and what is the 'no regressions rule'?
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +It's a regression if some application or practical use case running fine with
>> +one Linux kernel works worse or not at all with a newer version compiled using a
>> +similar configuration. The 'no regressions rule' forbids this to take place; if
> 
> So this is something you already said above.

That above was more like a "TLDR", guess I'll call it that after
splitting things up.


>> +How is the rule enforced?
>> +~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +It's the duty of the subsystem maintainers, which are watched and supported by
>> +Linus Torvalds for mainline or stable/longterm tree maintainers like Greg
>> +Kroah-Hartman. All of them are supported by Thorsten Leemhuis: he's acting as
>> +'regressions tracker' for the Linux kernel and trying to ensure all regression
>> +reports are acted upon in a timely manner.
>> +
>> +The distributed and slightly unstructured nature of the Linux kernel's
>> +development makes tracking regressions hard. That's why Thorsten relies on the
>> +help of his Linux kernel regression tracking robot 'regzbot'. It watches mailing
>> +lists and git trees to semi-automatically associate regression reports with
>> +patch submissions and commits fixing the issue, as this provides all necessary
>> +insights into the fixing progress.
>> +
>> +Note, the regression tracker can only ensure no regression falls through the
>> +cracks, if someone tells him or his bot about every regression found. That's why
>> +each report needs to be CCed or forwarded to the regressions mailing list
>> +(ideally with a 'regzbot command' in the mail), as explained in the next
>> +section.
> 
> So this isn't really enforcement information, it's tracking, which is
> different...  If you really want to talk about enforcement, you might
> mention that offending patches can be reverted if they are not fixed in
> a timely manner.

Well, I'd say tracking is part of enforcing, but whatever, I see your
point and will address it in the next version.


>> +Placing such a 'regzbot command' is in your interest, as it will ensure the
>> +report won't fall through the cracks unnoticed. If you omit this, the Linux
>> +kernel's regressions tracker will take care of telling regzbot about your
>> +regression, as long as you send a copy to the regressions mailing lists. But the
>> +regression tracker is just one human which sometimes has to rest or occasionally
>> +might even enjoy some time away from computers (as crazy as that might sound).
> 
> Naw, we don't allow that, sorry :)

:-D

>> +Who needs to find the commit causing a regression?
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +It's the reporter's duty to find the culprit, but developers of the affected
>> +subsystem should offer advice and reasonably help where they can.
> 
> Is it really our policy that *reporters* need to find the offending
> commit?  That's certainly not my view of things, anyway?

Well, do we have something on that written down somewhere or a few
quotes from Linus that might help to clarify things?

Anyway: I was not totally happy with it either, as I found the first
part of the sentence to strong, and the second to soft. But I had
trouble finding something better, maybe a native speaker could help out
here. Maybe something along these lines?

```
The developers of the affected code area should try their best to
identify what's causing the regression. But that might be impossible
with reasonable effort, as quite a few regressions only occur in a
particular environment (Linux distro, hardware, configuration, ...).
That's why in the end it's often up to the reporter to locate the
culprit; to make this easy, developers should offer advice and
reasonably help where they can.
```

As that's what things boil down to in practice, don't they?

>> +More details about regressions relevant for reporters
>> +-----------------------------------------------------
>> +
>> +Does a regression need to be fixed, if it can be avoided by updating some other software?
> 
> It would be nice to keep to 80 columns if possible.  These long section
> headings aren't great for readability.

I know and already tried to keep them shorter, but I sometimes simply
failed to do so. Thing is: more descriptive section IMHO make is easier
to skim over the document and just read the sections one is interested
in (kinda FAQ style). And that was my goal, as I don't expect many
people to read the text from top to bottom in these interesting times.
That's why I think the benefits outweigh the downsides in times where we
even allow code to exceed the old 80 character limit when it makes sense.

I'll give it another shot to make them shorter, but I can't promise I'll
manage -- as as you wrote "It would be *nice* to keep" I for now assume
that's okay.

>> +How to create a configuration similar to the one of an older kernel?
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +Start a known-good kernel and configure the newer Linux version with ``make
> Start *with* a ... ?

Hmmm. I went for "Start *your machine with* a" to make it really obvious
what to start.

> OK, now that I'm at the end, I would like to suggest splitting this
> material up.  Few people will make it through that whole thing...  It
> seems to me that we need is:
> 
>  - How to report and track a regression (admin guide probably)
>  - Regression sermon for developers including Linus quotes (process)
>  - Reference guide for regzbot directives (process or tools)
> 
> That should get each of them to a manageable length where readers will
> be able to get to the information they are looking for at the time.  I
> would think this would mostly be a matter of hacking out pieces from the
> above and putting them in the proper place.
> 
> See what I'm getting at?  Does that make sense to you?

Sure, I as mentioned earlier, I had thought about this already.

But I'll try to avoid a separate document for regzbot as see how this
works out. I fear splitting this off is a bad idea, as reporters
otherwise need to look into too many documents for one task, as they
already need to deal with reporting-issue.rst as well.

Thx again!

Ciao, Thorsten
