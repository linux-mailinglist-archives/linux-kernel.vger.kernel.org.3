Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4BE4A58CB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbiBAIvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:51:55 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44678 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbiBAIvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:51:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DBE8B82D08;
        Tue,  1 Feb 2022 08:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55012C340EB;
        Tue,  1 Feb 2022 08:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643705511;
        bh=s5Cqt2e9+CPFR3gpL9MuWaixt4xYuBt3Ki52mWIXyII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OZZ585tuRILFFkFhMUV1c7Js/+jpwgkPXnffeKcdUm750LDLwfzR5xSbMqaF0gLGW
         gguhQebrUWgrfId+f12wTmkmoe7L6DQzp3iSQeOnFm1sPPgFffk3NsE6PwJQgLssUO
         yB38QYRBUoOkkS63oLcxP3Wk65XdvnBD1lGSMv+6bbyuy0IlOXeiKyohBhFK8SQsjl
         JGo9JGAuOuKhhFqRT1IEJtaXtkAG93A32uGdPODbEQj8OSL+GQu84soMVsaM6loajz
         mpbklZLfpQFDEX82QMD9MI4dFo6Yu5V3LjVodJR3cLHd/P434zf1SSS3NHeONyr6jh
         KsxIHpH3cQRRA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nEosv-0000ft-Sd; Tue, 01 Feb 2022 09:51:34 +0100
Date:   Tue, 1 Feb 2022 09:51:33 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>, kbuild-all@lists.01.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Florian Eckert <fe@dev.tdt.de>
Subject: Re: [PATCH v1 1/1] docs: process: submitting-patches: Clarify the
 Reported-by usage
Message-ID: <Yfj0lb50vS3ssrsn@hovoldconsulting.com>
References: <20220127155334.47154-1-andriy.shevchenko@linux.intel.com>
 <87o83xrwk9.fsf@meer.lwn.net>
 <YfPzNNvK8Sy8YmGW@casper.infradead.org>
 <Yff9xoh873aEikY4@hovoldconsulting.com>
 <YfgBi9dn8LI8d/bo@smile.fi.intel.com>
 <YfgSpArfoL9LUaBO@hovoldconsulting.com>
 <YfgninPOaJhq7dsZ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfgninPOaJhq7dsZ@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 08:16:42PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 31, 2022 at 05:47:32PM +0100, Johan Hovold wrote:
> > On Mon, Jan 31, 2022 at 05:34:35PM +0200, Andy Shevchenko wrote:
> > > On Mon, Jan 31, 2022 at 04:18:30PM +0100, Johan Hovold wrote:
> > > > On Fri, Jan 28, 2022 at 01:44:20PM +0000, Matthew Wilcox wrote:
> > 
> > > > > I think this misunderstands the problem that Andy is trying to fix.
> > > > > 
> > > > > The situation: I write a patch.  I post it for review.  A bot does
> > > > > something and finds a bug (could be compile-error, could be boot
> > > > > problem).  That bot sends a bug report with a suggestion to add
> > > > > Reported-by:.  That suggestion is inappropriate because the bug never
> > > > > made it upstream, so it looks like the bot reported the "problem"
> > > > > that the patch "fixes".
> > > > > 
> > > > > It's not unique to "new feature" patches.  If I'm fixing a bug and
> > > > > my fix also contains a bug spotted by a bot, adding Reported-by
> > > > > makes it look like the bot spotted the original bug, rather than
> > > > > spotting a bug in the fix.
> > > > > 
> > > > > The best thing to do in this case is nothing.  Do not credit the bot.
> > > > > Maybe add a Checked-by:, but that would be a new trailer and I really
> > > > > don't think we need a new kind of trailer to get wrong.
> > > > 
> > > > It seems like the only way to fix this is to fix the bots. Adding more
> > > > documentation is unlikely to help in this case.
> > > 
> > > Links to the documentation at least may clarify the point in case of a
> > > review.
> > 
> > Sure.
> > 
> > > > Can't we file a bug to whoever is running the bots (Intel?) and ask them
> > > > to remove the suggestion to add a Reported-by when the bot is testing a
> > > > patch (as opposed to mainline or even -next)?
> > > 
> > > The granularity here is not a repo. It's a code itself and in some cases
> > > it might be easy to distinguish new feature from the code modifications,
> > > but when code is already there and feature is just an extension of the
> > > existing file(s), it's hard to tell. And it might be true or not.
> > 
> > Not sure I understand what you're saying here. Perhaps you and Matthew
> > are talking about different things after all.
> 
> I'm talking about your suggestion to fix the bots. It's not easy.
> The problem is the same as Matthew explained.

Perhaps I'm missing something, but if you re-read Mathews description
above, it still seems to me like the issue is that the bots are trying
to claim credit for finding things that haven't been merged yet.

Your suggestion is to document that the bots should be ignored. My
suggestion is to fix the bots.
 
> > But for Matthew's issue, the case where the bots are testing posted
> > patches ("Thank you for the patch! Yet something to improve:) should be
> > easy to fix by simply dropping or rephrasing the "kindly add following
> > tag as appropriate" suggestion.
> 
> Yes, but this is not "fixing the bots", it falls into category "working around"
> them, because even for a clear bug report the suggestion can be stronger.
> And doing that properly without kinda AI not easy.

A patch has (typically) not been merged yet when the bots find problems,
but when testing a branch it's harder to tell (e.g. unless it's
mainline).

The bot already knows it is testing a patch, so the "please give me
credit" suggestion can be dropped or rephrased in that case. That's
fixing the bot. And no need for AI.

> > When testing merged code, it may be harder to tell whether the branch in
> > question can be rebased or not (and an incremental fix with a
> > reported-by tag is warranted).

Johan
