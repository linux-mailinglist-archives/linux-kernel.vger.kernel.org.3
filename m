Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF34508828
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 14:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378541AbiDTMdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 08:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353229AbiDTMdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 08:33:52 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2B93FDA1;
        Wed, 20 Apr 2022 05:31:03 -0700 (PDT)
Received: from [2a02:8108:963f:de38:6624:6d8d:f790:d5c]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nh9U3-0007Xt-8M; Wed, 20 Apr 2022 14:30:59 +0200
Message-ID: <cd982909-d0bd-7003-016a-8357027ec9e5@leemhuis.info>
Date:   Wed, 20 Apr 2022 14:30:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Jani Nikula <jani.nikula@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        workflows@vger.kernel.org
References: <6808cd17-b48c-657d-de60-ef9d8bfa151e@leemhuis.info>
 <87lew8f6d0.fsf@intel.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: A lot of regression reports submitted to bugzilla.kernel.org are
 apparently ignored, even bisected ones
In-Reply-To: <87lew8f6d0.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1650457863;33218afe;
X-HE-SMSGID: 1nh9U3-0007Xt-8M
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.04.22 09:53, Jani Nikula wrote:
> On Wed, 06 Apr 2022, Thorsten Leemhuis <linux@leemhuis.info> wrote:
>> Hi! TLDR: I looked closer at every ticket filed in bugzilla.kernel.org
>> over a time span of two weeks to see how well reports are handled, in
>> particular those for kernel regressions. The results of this rough
>> analysis are kinda devastating from my point of view. I for example
>> found 8 tickets describing a regression where the reporter had even
>> bisected the problem, but nevertheless the ticket afaics didn’t get a
>> single reply or any other reaction from a regular kernel developer
>> within about a week; in fact out of a total of 20 reports that looked
>> like regressions to me (17 if you exclude tickets where the reporter
>> used an afaics lightly patched distro kernel), only one got a helpful
>> reply from a developer within a week. That makes us miss valuable
>> reports and puts our "no regressions" rule into a bad light. Hence,
>> something IMHO should be done here to improve the situation, but I'm not
>> sure myself what exactly -- that's why I'm writing this mail. A better
>> warning on bugzilla’s frontpage suggesting to report issues by mail
>> maybe? And/or disable all bugzilla products and components where it's
>> not clear that somebody will be looking at least once at submitted tickets?
>>
>>
>> The long story: As part of my regression tracking work I a few months
>> ago started to watch out for regressions reported in
>> bugzilla.kernel.org. Normally I only skim roughly through tickets when
>> they are about a week old, as doing it more thoroughly would quickly
>> consume all the time I can spend on regression tracking (reminder: I'm
>> doing this on my own time as a volunteer, it's not part of my job or
>> something!). But multiple times already I got the impression that things
>> were quite amiss. I also heard complaints from users about the state of
>> things; some developers also complained when I told them about reports
>> they had missed.
>>
>> That's why I took a closer look at the tickets filed in the weeks right
>> before and after Linux 5.17 was released; that's 2022-03-14 till
>> 2022-03-27, which covers tickets with the IDs 215680 to 215764 (215707
>> and up were filed during the first week of the merge window of 5.18).
>>
>>
>> I excluded 31 tickets from my analysis for one reason or another (spam;
>> tickets about man-pages and Trace-cmd/Kernelshark; note/reminder-to-self
>> tickets filed by a developer; reports with distro-kernels heavily
>> patched; ... -- see the list below for details). From the remaining
>> tickets 20 looked like reports about regressions and 34 were about other
>> issues; the numbers go down to 17 and 27 if one excludes tickets where
>> the reporter used a distro-kernel that's afaics is only lightly patched
>> (Arch, Fedora, Tumbleweed, ...). Warning, I'm just human and had to use
>> my best judgment in quite a few cases, hence I might have mis-judged or
>> mis-classified some tickets.
>>
>> Only 1 of those 20 regression tickets and 5 of the 34 other tickets
>> within about a week got a reply from a kernel developer that works in
>> the affected area. Don't worry, I forwarded all valid regression reports
>> to the developers when I noticed the tickets were not acted upon (most
>> of the time this got things moving).
>>
>> There is something I felt quite annoying: 8 out of those 20 tickets
>> describing regressions where bisected and nevertheless were ignored in
>> the first week. Among them is the (in)famous swiotlb/ath9k problem
>> (https://lwn.net/Articles/889593/ ) that was recently fixed after
>> someone brought it to LKML -- 4 days after the ticket was created and
>> two after someone pointed to the culprit there.
>>
>>
>> This situation afaics is in nobody's interest, as valuable regressions
>> reports are ignored; and I guess the people that submitted them will
>> feel ignored and likely think things like “they claim to have a ‘no
>> regressions rule’, but don't take reports about regressions seriously”.
>>
>> [Quick reminder on the state of bugzilla.kernel.org for anyone that is
>> not aware of the backstory: in an ideal world, nearly all of those 20/34
>> tickets about regressions/issues should never have been reported to
>> bugzilla.kernel.org in the first place. Our reporting-issues text
>> (https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html
>> -- linked on the front page of bugzilla.kernel.org) clearly warns that
>> bugzilla.kernel.org almost always is the wrong place to file
>> regressions/issues. But we don't live in an ideal world and that
>> document sadly is quite long, as our bug-reporting process is special
>> and hard for outsiders. OTOH I guess quite a few people afaics wouldn't
>> even read the text even if it was really really short.]
>>
>>
>> I'm not sure what's the best way forward to address the situation, as
>> bugzilla.kernel.org is used by some kernel developers and subsystems.
>> There are for example 19 entries (out of more than 2400!) in MAINTAINERS
>> referring to it as the primary place to report issues; from what I've
>> heard and seen there seem to be a few other kernel developers and
>> subsystems that like having bugzilla around.
> 
> First, I think we should have maintainers actually add the "B:" entries
> in MAINTAINERS to indicate their preferences.

Yeah, maybe there are still a few developers/subsystems that really rely
on bugzilla.kernel.org but haven't added such an line. But my impression
is that a few actually handle tickets submitted there, but don't want to
make it really official; but as I said, it's just an impression, so
maybe I'm wrong there.

> Second, I think we should have a bug reporting landing page (or maybe a
> local tool as the engine) that would help reporters find the right place
> in semi-automated fashion. For example, you could enter the module name
> or a file name or maybe copy-paste a warning splat or give a regressing
> commit, and the tool could use the kernel source to point you at the
> right place. (And bugzilla shouldn't be considered unless it's
> explicitly mentioned..)
> 
> I actually think the latter might not be too hard to get to a state
> where it's useful and helpful. (Which might be indicative of the current
> state of affairs, more than anything.)

Yeah, I had thought about something like that as well, but at least in
the past two years and the foreseeable future it's something that not
even once made it to the middle of my "list of things to work on when
there is some spare time".

>> But as the numbers show, a lot of tickets submitted there get ignored.
>> Note though, many developers imho are not to blame here, as they never
>> were told that tickets that might be of interest for them were
>> submitted. That's because keeping an eye on bugzilla afaik has always
>> been optional for kernel developers (many components assign the tickets
>> to a non-existing email address; developers only get the reports in my
>> mail, if they manually tell bugzilla in their account preferences to
>> monitor that non-existing email address.) That's afaics the main reason
>> why valuable tickets are ignored, but there are others. Many tickets for
>> example get filed against components where afaics nobody watches at all
>> -- like other/other
>> (https://bugzilla.kernel.org/buglist.cgi?component=Other&list_id=1110244&product=Other&resolution=---
>> ). Some tickets are forwarded to a mailing list, but it seems nobody
>> takes a look at them.
>>
>> Something that could help for example would be an improved and really
>> prominent text for the front-page of bugzilla.kernel.org that describes
>> the situation. That text for example could clearly explain that
>> submitting tickets in the bugtracker is often the wrong approach when it
>> comes to the Linux kernel (aka "waste of time"); at the same time it
>> obviously would need to point people to the (sadly quite long)
>> reporting-issues text that explains the proper approach (disclaimer:
>> that text was mostly written by yours truly and designed to get the
>> important facts across quite quickly).
>>
>> Something else that could help: Disable all bugzilla products and
>> components where it's not clear that somebody will be looking at least
>> once at every ticket submitted. Except maybe for one where the name and
>> the description makes it totally obvious that the report won't be sent
>> to anyone; such a component is useful for people that want to upload big
>> files somewhere and just link to them when reporting issues by mail.
> When i915 moved away from bugzilla, the Intel DRI component was disabled
> for new bugs. That hasn't prevented people from filing bugs on other
> components.

Yeah, I guess that's just how it is and will always happen in one way or
another. Something that might help could be: remove/deactivate all
products and components that don't have a proper and active assignee and
then create one called something like "everything else (nobody will be
told about this report, but it can be found by a search)".

Ciao, Thorsten

>> But as I said earlier: I’m not sure if that's the best angle of approach
>> here. Sometimes I wonder if we should simply disallow filing new
>> tickets. But then those subsystems and developers that rely on it would
>> be forced to find alternatives; not to mention that afaics quite a few
>> users will never report issues by mail and need something like
>> bugzilla.kernel.org to get in contact with us.
>>
>> Does anyone have any better ideas on how to improve the situation? Or is
>> this something that needs to be discussed at the next kernel/maintainers
>> summit in September?
>>
>> Anyway, that's it from my side. Find the detailed report below if you
>> want to check how I came up with the numbers mentioned above.
>>
>> Ciao, Thorsten
>>
>> P.S.: I'll try to continue keeping an eye on regressions reported to
>> bugzilla.kernel.org, but I can't continue watching this closely, so some
>> will slip through. Sorry.
> 
