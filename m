Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A004E5007A2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 09:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240637AbiDNH4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 03:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237045AbiDNH4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:56:15 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEFA3969C;
        Thu, 14 Apr 2022 00:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649922831; x=1681458831;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=A0RqmVYnKdGqm9YA8s6IJukk1mqPk56Lzwpa/yVbek8=;
  b=cL9+b1Nh5KjeP/kaz/nYPaRXpun/2rxLf9eWU3pWvyCfT035IYyfU3NH
   uNeSCg/bCy2YQypNufyeTvcF7WA+8bRvoqLNmxpMgZj5HYaTjOVlHtawE
   SJSZf3LlJlPErkfXmBM7FTjvFFSfcwTda2XFissFTyc71vfgo0htay/lS
   IfnC3Zmt0GKTx4sEYPv4ASon6rhlbo+OPPa91OooAz042Wi0tH7e4IY3W
   xsYVGOArnHaGtO3PTdKkG2XNMmLFVmIyy8EYvGRTrXAE4tlaAaCjlcrA4
   hs4llOTrXgdhv40NdS9Vb9rslc4WRR68MJEtM+yASjXcmKP1RzyvPnlxZ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="349310338"
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="349310338"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 00:53:50 -0700
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="725264129"
Received: from nplaweck-mobl.ger.corp.intel.com (HELO localhost) ([10.249.149.236])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 00:53:47 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        workflows@vger.kernel.org
Subject: Re: A lot of regression reports submitted to bugzilla.kernel.org
 are apparently ignored, even bisected ones
In-Reply-To: <6808cd17-b48c-657d-de60-ef9d8bfa151e@leemhuis.info>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <6808cd17-b48c-657d-de60-ef9d8bfa151e@leemhuis.info>
Date:   Thu, 14 Apr 2022 10:53:47 +0300
Message-ID: <87lew8f6d0.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Apr 2022, Thorsten Leemhuis <linux@leemhuis.info> wrote:
> Hi! TLDR: I looked closer at every ticket filed in bugzilla.kernel.org
> over a time span of two weeks to see how well reports are handled, in
> particular those for kernel regressions. The results of this rough
> analysis are kinda devastating from my point of view. I for example
> found 8 tickets describing a regression where the reporter had even
> bisected the problem, but nevertheless the ticket afaics didn=E2=80=99t g=
et a
> single reply or any other reaction from a regular kernel developer
> within about a week; in fact out of a total of 20 reports that looked
> like regressions to me (17 if you exclude tickets where the reporter
> used an afaics lightly patched distro kernel), only one got a helpful
> reply from a developer within a week. That makes us miss valuable
> reports and puts our "no regressions" rule into a bad light. Hence,
> something IMHO should be done here to improve the situation, but I'm not
> sure myself what exactly -- that's why I'm writing this mail. A better
> warning on bugzilla=E2=80=99s frontpage suggesting to report issues by ma=
il
> maybe? And/or disable all bugzilla products and components where it's
> not clear that somebody will be looking at least once at submitted ticket=
s?
>
>
> The long story: As part of my regression tracking work I a few months
> ago started to watch out for regressions reported in
> bugzilla.kernel.org. Normally I only skim roughly through tickets when
> they are about a week old, as doing it more thoroughly would quickly
> consume all the time I can spend on regression tracking (reminder: I'm
> doing this on my own time as a volunteer, it's not part of my job or
> something!). But multiple times already I got the impression that things
> were quite amiss. I also heard complaints from users about the state of
> things; some developers also complained when I told them about reports
> they had missed.
>
> That's why I took a closer look at the tickets filed in the weeks right
> before and after Linux 5.17 was released; that's 2022-03-14 till
> 2022-03-27, which covers tickets with the IDs 215680 to 215764 (215707
> and up were filed during the first week of the merge window of 5.18).
>
>
> I excluded 31 tickets from my analysis for one reason or another (spam;
> tickets about man-pages and Trace-cmd/Kernelshark; note/reminder-to-self
> tickets filed by a developer; reports with distro-kernels heavily
> patched; ... -- see the list below for details). From the remaining
> tickets 20 looked like reports about regressions and 34 were about other
> issues; the numbers go down to 17 and 27 if one excludes tickets where
> the reporter used a distro-kernel that's afaics is only lightly patched
> (Arch, Fedora, Tumbleweed, ...). Warning, I'm just human and had to use
> my best judgment in quite a few cases, hence I might have mis-judged or
> mis-classified some tickets.
>
> Only 1 of those 20 regression tickets and 5 of the 34 other tickets
> within about a week got a reply from a kernel developer that works in
> the affected area. Don't worry, I forwarded all valid regression reports
> to the developers when I noticed the tickets were not acted upon (most
> of the time this got things moving).
>
> There is something I felt quite annoying: 8 out of those 20 tickets
> describing regressions where bisected and nevertheless were ignored in
> the first week. Among them is the (in)famous swiotlb/ath9k problem
> (https://lwn.net/Articles/889593/ ) that was recently fixed after
> someone brought it to LKML -- 4 days after the ticket was created and
> two after someone pointed to the culprit there.
>
>
> This situation afaics is in nobody's interest, as valuable regressions
> reports are ignored; and I guess the people that submitted them will
> feel ignored and likely think things like =E2=80=9Cthey claim to have a =
=E2=80=98no
> regressions rule=E2=80=99, but don't take reports about regressions serio=
usly=E2=80=9D.
>
> [Quick reminder on the state of bugzilla.kernel.org for anyone that is
> not aware of the backstory: in an ideal world, nearly all of those 20/34
> tickets about regressions/issues should never have been reported to
> bugzilla.kernel.org in the first place. Our reporting-issues text
> (https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html
> -- linked on the front page of bugzilla.kernel.org) clearly warns that
> bugzilla.kernel.org almost always is the wrong place to file
> regressions/issues. But we don't live in an ideal world and that
> document sadly is quite long, as our bug-reporting process is special
> and hard for outsiders. OTOH I guess quite a few people afaics wouldn't
> even read the text even if it was really really short.]
>
>
> I'm not sure what's the best way forward to address the situation, as
> bugzilla.kernel.org is used by some kernel developers and subsystems.
> There are for example 19 entries (out of more than 2400!) in MAINTAINERS
> referring to it as the primary place to report issues; from what I've
> heard and seen there seem to be a few other kernel developers and
> subsystems that like having bugzilla around.

First, I think we should have maintainers actually add the "B:" entries
in MAINTAINERS to indicate their preferences.

Second, I think we should have a bug reporting landing page (or maybe a
local tool as the engine) that would help reporters find the right place
in semi-automated fashion. For example, you could enter the module name
or a file name or maybe copy-paste a warning splat or give a regressing
commit, and the tool could use the kernel source to point you at the
right place. (And bugzilla shouldn't be considered unless it's
explicitly mentioned..)

I actually think the latter might not be too hard to get to a state
where it's useful and helpful. (Which might be indicative of the current
state of affairs, more than anything.)

> But as the numbers show, a lot of tickets submitted there get ignored.
> Note though, many developers imho are not to blame here, as they never
> were told that tickets that might be of interest for them were
> submitted. That's because keeping an eye on bugzilla afaik has always
> been optional for kernel developers (many components assign the tickets
> to a non-existing email address; developers only get the reports in my
> mail, if they manually tell bugzilla in their account preferences to
> monitor that non-existing email address.) That's afaics the main reason
> why valuable tickets are ignored, but there are others. Many tickets for
> example get filed against components where afaics nobody watches at all
> -- like other/other
> (https://bugzilla.kernel.org/buglist.cgi?component=3DOther&list_id=3D1110=
244&product=3DOther&resolution=3D---
> ). Some tickets are forwarded to a mailing list, but it seems nobody
> takes a look at them.
>
> Something that could help for example would be an improved and really
> prominent text for the front-page of bugzilla.kernel.org that describes
> the situation. That text for example could clearly explain that
> submitting tickets in the bugtracker is often the wrong approach when it
> comes to the Linux kernel (aka "waste of time"); at the same time it
> obviously would need to point people to the (sadly quite long)
> reporting-issues text that explains the proper approach (disclaimer:
> that text was mostly written by yours truly and designed to get the
> important facts across quite quickly).
>
> Something else that could help: Disable all bugzilla products and
> components where it's not clear that somebody will be looking at least
> once at every ticket submitted. Except maybe for one where the name and
> the description makes it totally obvious that the report won't be sent
> to anyone; such a component is useful for people that want to upload big
> files somewhere and just link to them when reporting issues by mail.

When i915 moved away from bugzilla, the Intel DRI component was disabled
for new bugs. That hasn't prevented people from filing bugs on other
components.

BR,
Jani.

>
> But as I said earlier: I=E2=80=99m not sure if that's the best angle of a=
pproach
> here. Sometimes I wonder if we should simply disallow filing new
> tickets. But then those subsystems and developers that rely on it would
> be forced to find alternatives; not to mention that afaics quite a few
> users will never report issues by mail and need something like
> bugzilla.kernel.org to get in contact with us.
>
> Does anyone have any better ideas on how to improve the situation? Or is
> this something that needs to be discussed at the next kernel/maintainers
> summit in September?
>
> Anyway, that's it from my side. Find the detailed report below if you
> want to check how I came up with the numbers mentioned above.
>
> Ciao, Thorsten
>
> P.S.: I'll try to continue keeping an eye on regressions reported to
> bugzilla.kernel.org, but I can't continue watching this closely, so some
> will slip through. Sorry.

--=20
Jani Nikula, Intel Open Source Graphics Center
