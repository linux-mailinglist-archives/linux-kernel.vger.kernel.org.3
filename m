Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574A44F6286
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235198AbiDFPD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235981AbiDFPDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:03:18 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB652440980;
        Wed,  6 Apr 2022 05:36:00 -0700 (PDT)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nc4sP-0002uI-Ln; Wed, 06 Apr 2022 14:35:09 +0200
Message-ID: <6808cd17-b48c-657d-de60-ef9d8bfa151e@leemhuis.info>
Date:   Wed, 6 Apr 2022 14:35:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Content-Language: en-US
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        workflows@vger.kernel.org
Subject: A lot of regression reports submitted to bugzilla.kernel.org are
 apparently ignored, even bisected ones
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1649248562;71258c03;
X-HE-SMSGID: 1nc4sP-0002uI-Ln
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! TLDR: I looked closer at every ticket filed in bugzilla.kernel.org
over a time span of two weeks to see how well reports are handled, in
particular those for kernel regressions. The results of this rough
analysis are kinda devastating from my point of view. I for example
found 8 tickets describing a regression where the reporter had even
bisected the problem, but nevertheless the ticket afaics didn’t get a
single reply or any other reaction from a regular kernel developer
within about a week; in fact out of a total of 20 reports that looked
like regressions to me (17 if you exclude tickets where the reporter
used an afaics lightly patched distro kernel), only one got a helpful
reply from a developer within a week. That makes us miss valuable
reports and puts our "no regressions" rule into a bad light. Hence,
something IMHO should be done here to improve the situation, but I'm not
sure myself what exactly -- that's why I'm writing this mail. A better
warning on bugzilla’s frontpage suggesting to report issues by mail
maybe? And/or disable all bugzilla products and components where it's
not clear that somebody will be looking at least once at submitted tickets?


The long story: As part of my regression tracking work I a few months
ago started to watch out for regressions reported in
bugzilla.kernel.org. Normally I only skim roughly through tickets when
they are about a week old, as doing it more thoroughly would quickly
consume all the time I can spend on regression tracking (reminder: I'm
doing this on my own time as a volunteer, it's not part of my job or
something!). But multiple times already I got the impression that things
were quite amiss. I also heard complaints from users about the state of
things; some developers also complained when I told them about reports
they had missed.

That's why I took a closer look at the tickets filed in the weeks right
before and after Linux 5.17 was released; that's 2022-03-14 till
2022-03-27, which covers tickets with the IDs 215680 to 215764 (215707
and up were filed during the first week of the merge window of 5.18).


I excluded 31 tickets from my analysis for one reason or another (spam;
tickets about man-pages and Trace-cmd/Kernelshark; note/reminder-to-self
tickets filed by a developer; reports with distro-kernels heavily
patched; ... -- see the list below for details). From the remaining
tickets 20 looked like reports about regressions and 34 were about other
issues; the numbers go down to 17 and 27 if one excludes tickets where
the reporter used a distro-kernel that's afaics is only lightly patched
(Arch, Fedora, Tumbleweed, ...). Warning, I'm just human and had to use
my best judgment in quite a few cases, hence I might have mis-judged or
mis-classified some tickets.

Only 1 of those 20 regression tickets and 5 of the 34 other tickets
within about a week got a reply from a kernel developer that works in
the affected area. Don't worry, I forwarded all valid regression reports
to the developers when I noticed the tickets were not acted upon (most
of the time this got things moving).

There is something I felt quite annoying: 8 out of those 20 tickets
describing regressions where bisected and nevertheless were ignored in
the first week. Among them is the (in)famous swiotlb/ath9k problem
(https://lwn.net/Articles/889593/ ) that was recently fixed after
someone brought it to LKML -- 4 days after the ticket was created and
two after someone pointed to the culprit there.


This situation afaics is in nobody's interest, as valuable regressions
reports are ignored; and I guess the people that submitted them will
feel ignored and likely think things like “they claim to have a ‘no
regressions rule’, but don't take reports about regressions seriously”.

[Quick reminder on the state of bugzilla.kernel.org for anyone that is
not aware of the backstory: in an ideal world, nearly all of those 20/34
tickets about regressions/issues should never have been reported to
bugzilla.kernel.org in the first place. Our reporting-issues text
(https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html
-- linked on the front page of bugzilla.kernel.org) clearly warns that
bugzilla.kernel.org almost always is the wrong place to file
regressions/issues. But we don't live in an ideal world and that
document sadly is quite long, as our bug-reporting process is special
and hard for outsiders. OTOH I guess quite a few people afaics wouldn't
even read the text even if it was really really short.]


I'm not sure what's the best way forward to address the situation, as
bugzilla.kernel.org is used by some kernel developers and subsystems.
There are for example 19 entries (out of more than 2400!) in MAINTAINERS
referring to it as the primary place to report issues; from what I've
heard and seen there seem to be a few other kernel developers and
subsystems that like having bugzilla around.

But as the numbers show, a lot of tickets submitted there get ignored.
Note though, many developers imho are not to blame here, as they never
were told that tickets that might be of interest for them were
submitted. That's because keeping an eye on bugzilla afaik has always
been optional for kernel developers (many components assign the tickets
to a non-existing email address; developers only get the reports in my
mail, if they manually tell bugzilla in their account preferences to
monitor that non-existing email address.) That's afaics the main reason
why valuable tickets are ignored, but there are others. Many tickets for
example get filed against components where afaics nobody watches at all
-- like other/other
(https://bugzilla.kernel.org/buglist.cgi?component=Other&list_id=1110244&product=Other&resolution=---
). Some tickets are forwarded to a mailing list, but it seems nobody
takes a look at them.

Something that could help for example would be an improved and really
prominent text for the front-page of bugzilla.kernel.org that describes
the situation. That text for example could clearly explain that
submitting tickets in the bugtracker is often the wrong approach when it
comes to the Linux kernel (aka "waste of time"); at the same time it
obviously would need to point people to the (sadly quite long)
reporting-issues text that explains the proper approach (disclaimer:
that text was mostly written by yours truly and designed to get the
important facts across quite quickly).

Something else that could help: Disable all bugzilla products and
components where it's not clear that somebody will be looking at least
once at every ticket submitted. Except maybe for one where the name and
the description makes it totally obvious that the report won't be sent
to anyone; such a component is useful for people that want to upload big
files somewhere and just link to them when reporting issues by mail.

But as I said earlier: I’m not sure if that's the best angle of approach
here. Sometimes I wonder if we should simply disallow filing new
tickets. But then those subsystems and developers that rely on it would
be forced to find alternatives; not to mention that afaics quite a few
users will never report issues by mail and need something like
bugzilla.kernel.org to get in contact with us.

Does anyone have any better ideas on how to improve the situation? Or is
this something that needs to be discussed at the next kernel/maintainers
summit in September?

Anyway, that's it from my side. Find the detailed report below if you
want to check how I came up with the numbers mentioned above.

Ciao, Thorsten

P.S.: I'll try to continue keeping an eye on regressions reported to
bugzilla.kernel.org, but I can't continue watching this closely, so some
will slip through. Sorry.


---
Detailed analysis:

____________________________________________________________

# Section 1: Regression reports

1 out of 20 tickets mentioned in this section got a reply from a
developer within round about a week

____________________

## Clearly reports about upstream regressions where a developer replied
within roundabout one week

1 ticket:

* https://bugzilla.kernel.org/show_bug.cgi?id=215713

  Not bisected, but a fix was already available, apparently developed
independently.

____________________

## Clearly reports about upstream regression that were bisected where no
developer replied within roundabout one week

8 tickets:

* https://bugzilla.kernel.org/show_bug.cgi?id=215689
* https://bugzilla.kernel.org/show_bug.cgi?id=215703

  Fun fact: that's the (in)famous swiotlb/ath9k problem
(https://lwn.net/Articles/889593/ ("A security fix briefly breaks DMA"))
that was reported properly to LKML by Oleksandr Natalenko
(https://lore.kernel.org/lkml/1812355.tdWV9SEqCh@natalenko.name/ ) *four
days* after this ticket was filed and *two days* after someone had
identified and mentioned the culprit in the ticket.

* https://bugzilla.kernel.org/show_bug.cgi?id=215715
* https://bugzilla.kernel.org/show_bug.cgi?id=215720
* https://bugzilla.kernel.org/show_bug.cgi?id=215726
* https://bugzilla.kernel.org/show_bug.cgi?id=215734
* https://bugzilla.kernel.org/show_bug.cgi?id=215742
* https://bugzilla.kernel.org/show_bug.cgi?id=215744
____________________

## Clearly reports about upstream regression where no developer replied
within roundabout one week

3 tickets:

* https://bugzilla.kernel.org/show_bug.cgi?id=215711
* https://bugzilla.kernel.org/show_bug.cgi?id=215725
* https://bugzilla.kernel.org/show_bug.cgi?id=215743

____________________

## Reports that look a lot like a regression, but might not be one;
after no kernel developer replied within one week the regression tracker
asked for clarification and got confirmation it's a regression

1 ticket:

* https://bugzilla.kernel.org/show_bug.cgi?id=215747

____________________

## tickets with reports that look a lot like regressions, but might not
be; after no kernel developer replied within one week the regression
tracker asked for clarification, but the reporter didn't respond (yet)

4 tickets:

* https://bugzilla.kernel.org/show_bug.cgi?id=215682
* https://bugzilla.kernel.org/show_bug.cgi?id=215691
* https://bugzilla.kernel.org/show_bug.cgi?id=215719
* https://bugzilla.kernel.org/show_bug.cgi?id=215761

____________________

## tickets about regressions occurring with distro kernels that are
known to be close to upstream (some of these problems might be present
in upstream, too)

3 tickets:

* https://bugzilla.kernel.org/show_bug.cgi?id=215681
* https://bugzilla.kernel.org/show_bug.cgi?id=215696
* https://bugzilla.kernel.org/show_bug.cgi?id=215697



____________________________________________________________

# Section 2: tickets that don't look like regressions reports,
nevertheless might be worth investigating

Note: 5 out of 34 tickets mentioned in this section got a reply from a
developer within roundabout a week.

____________________

## tickets where a developer replied within round about a week

5 tickets:

* https://bugzilla.kernel.org/show_bug.cgi?id=215709

* https://bugzilla.kernel.org/show_bug.cgi?id=215712

* https://bugzilla.kernel.org/show_bug.cgi?id=215729

* https://bugzilla.kernel.org/show_bug.cgi?id=215730

* https://bugzilla.kernel.org/show_bug.cgi?id=215763

____________________

## Reports about circular locking and sanitizer warnings that didn't get
a reply from a developer within round about a week

2 tickets:

* https://bugzilla.kernel.org/show_bug.cgi?id=215746
* https://bugzilla.kernel.org/show_bug.cgi?id=215748

____________________

## other issues that don't look like regressions (but might be!) that
didn't get a reply from a developer within round about a week

16 tickets:

* https://bugzilla.kernel.org/show_bug.cgi?id=215683
* https://bugzilla.kernel.org/show_bug.cgi?id=215686
* https://bugzilla.kernel.org/show_bug.cgi?id=215684
* https://bugzilla.kernel.org/show_bug.cgi?id=215685
* https://bugzilla.kernel.org/show_bug.cgi?id=215688
* https://bugzilla.kernel.org/show_bug.cgi?id=215695
* https://bugzilla.kernel.org/show_bug.cgi?id=215698
* https://bugzilla.kernel.org/show_bug.cgi?id=215714
* https://bugzilla.kernel.org/show_bug.cgi?id=215732
* https://bugzilla.kernel.org/show_bug.cgi?id=215733
* https://bugzilla.kernel.org/show_bug.cgi?id=215739
* https://bugzilla.kernel.org/show_bug.cgi?id=215749
* https://bugzilla.kernel.org/show_bug.cgi?id=215750
* https://bugzilla.kernel.org/show_bug.cgi?id=215760
* https://bugzilla.kernel.org/show_bug.cgi?id=215762
* https://bugzilla.kernel.org/show_bug.cgi?id=215764

____________________

## tickets about issues occurring with distro kernels known to be close
to upstream (some of these problems thus might be present in upstream, too)

7 tickets:

* https://bugzilla.kernel.org/show_bug.cgi?id=215680
* https://bugzilla.kernel.org/show_bug.cgi?id=215699
* https://bugzilla.kernel.org/show_bug.cgi?id=215700
* https://bugzilla.kernel.org/show_bug.cgi?id=215705
* https://bugzilla.kernel.org/show_bug.cgi?id=215708
* https://bugzilla.kernel.org/show_bug.cgi?id=215727
* https://bugzilla.kernel.org/show_bug.cgi?id=215745

_______________________________________

## ticket about issues when mounting corrupted fs images (some of them
might be regressions, but do we handle them as such? Related:
https://lwn.net/Articles/796687/ )

4 tickets:

* https://bugzilla.kernel.org/show_bug.cgi?id=215716
* https://bugzilla.kernel.org/show_bug.cgi?id=215717
* https://bugzilla.kernel.org/show_bug.cgi?id=215718
* https://bugzilla.kernel.org/show_bug.cgi?id=215722



____________________________________________________________

# Section 3: other tickets that for one reason or another would be
misleading to count them in Sections 1 or 2

31 tickets

____________________

## regression reports

5 tickets:

* https://bugzilla.kernel.org/show_bug.cgi?id=215687

  Reporter brought the regression to IRC shortly after filing the bug,
so developers might be aware that this ticket was safe to ignore.

* https://bugzilla.kernel.org/show_bug.cgi?id=215693

  Reporter brought the regression to IRC shortly after filing the bug,
so developers might be aware that this ticket was safe to ignore.

* https://bugzilla.kernel.org/show_bug.cgi?id=215721

  Regression with a maintainers dev tree, developer replied.

* https://bugzilla.kernel.org/show_bug.cgi?id=215728

  This looked like a regression, but the reporter after one day noticed
on his own it in fact was a bug in openZFS.

* https://bugzilla.kernel.org/show_bug.cgi?id=215740

  Hard to see that this is actually a regression; and when the
regression tracker got the developers involved it turned out that this
is caused by a change adding a warning that made an older problem now
obvious.

____________________

## issues

7 tickets:

* https://bugzilla.kernel.org/show_bug.cgi?id=215701

  RHEL/CentOS kernel (known to contain quite a few patches)

* https://bugzilla.kernel.org/show_bug.cgi?id=215702

  RHEL/CentOS kernel (known to contain quite a few patches)

* https://bugzilla.kernel.org/show_bug.cgi?id=215707

  Arch Zen Kernel (seems to contains quite a few patches)

* https://bugzilla.kernel.org/show_bug.cgi?id=215723

  "dirty"(?) kernel (whatever that is)

* https://bugzilla.kernel.org/show_bug.cgi?id=215724

  Reporter marked it as a duplicate of 215730 (a ticket filed by the
same reporter where a developer replied).

* https://bugzilla.kernel.org/show_bug.cgi?id=215731

   RHEL/CentOS kernel (known to contain quite a few patches) (a
developer nevertheless replied within round about a week)

* https://bugzilla.kernel.org/show_bug.cgi?id=215741

  Very old kernel version

____________________

## tickets submitted from a developer as a kind of note/reminder-to-self

10 tickets:


* https://bugzilla.kernel.org/show_bug.cgi?id=215690
* https://bugzilla.kernel.org/show_bug.cgi?id=215751
* https://bugzilla.kernel.org/show_bug.cgi?id=215752
* https://bugzilla.kernel.org/show_bug.cgi?id=215753
* https://bugzilla.kernel.org/show_bug.cgi?id=215754
* https://bugzilla.kernel.org/show_bug.cgi?id=215755
* https://bugzilla.kernel.org/show_bug.cgi?id=215756
* https://bugzilla.kernel.org/show_bug.cgi?id=215757
* https://bugzilla.kernel.org/show_bug.cgi?id=215758
* https://bugzilla.kernel.org/show_bug.cgi?id=215759

____________________

## Tickets either inaccessible or covering things like man-pages,
Trace-cmd/Kernelshark, etc.

9 tickets:

* https://bugzilla.kernel.org/show_bug.cgi?id=215692
* https://bugzilla.kernel.org/show_bug.cgi?id=215694
* https://bugzilla.kernel.org/show_bug.cgi?id=215704
* https://bugzilla.kernel.org/show_bug.cgi?id=215706
* https://bugzilla.kernel.org/show_bug.cgi?id=215710
* https://bugzilla.kernel.org/show_bug.cgi?id=215735
* https://bugzilla.kernel.org/show_bug.cgi?id=215736
* https://bugzilla.kernel.org/show_bug.cgi?id=215737
* https://bugzilla.kernel.org/show_bug.cgi?id=215738


