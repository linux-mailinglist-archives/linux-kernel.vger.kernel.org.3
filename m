Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9B449FAFF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239706AbiA1Noa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiA1NoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:44:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF13C061714;
        Fri, 28 Jan 2022 05:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=66KUqfGLKCCNfUmx01Wi6r7gGMm9QxBTDybB4Toi49o=; b=l+n+LtEfP4LjwSALB4NpmCbGtZ
        W7f4AsugfZTwtz8tI8KheXuJEEu7WtXqFod3hu0vctGYF73d+UHPSUOAxroh8SoRjD7p8E33qOhlf
        FgJMneZem2cPQiTAJQhPlQnQVbDf97QNCqLw32JdGmw3eplgcHWN/Ci5VjWVVjNl8iXhIryxvAvzj
        Hsom1U6iqzsVb9dlLE/cTDLuMgnH7z65d8EufrqcZll/TwC8OfL4vr1Xzf4q3AqWRS7PpuSs0yK5m
        0UTr39f58PSMHkITvgN4+Z3oBvtyFYmoCBFMVlvn/OURbc/Ckk+hHrVNYZFzD7ZJqQBiMB7RCyPgu
        XmxZec9A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nDRY4-006Rrg-Ou; Fri, 28 Jan 2022 13:44:20 +0000
Date:   Fri, 28 Jan 2022 13:44:20 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Eckert <fe@dev.tdt.de>
Subject: Re: [PATCH v1 1/1] docs: process: submitting-patches: Clarify the
 Reported-by usage
Message-ID: <YfPzNNvK8Sy8YmGW@casper.infradead.org>
References: <20220127155334.47154-1-andriy.shevchenko@linux.intel.com>
 <87o83xrwk9.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o83xrwk9.fsf@meer.lwn.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 09:08:06AM -0700, Jonathan Corbet wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> 
> > It's unclear from "Submitting Patches" documentation that Reported-by
> > is not supposed to be used against new features. (It's more clear
> > in the section 5.4 "Patch formatting and changelogs" of the "A guide
> > to the Kernel Development Process", where it suggests that change
> > should fix something existing in the kernel. Clarify the Reported-by
> > usage in the "Submitting Patches".
> >
> > Reported-by: Florian Eckert <fe@dev.tdt.de>
> 
> You're sure this added documentation isn't a new feature that shouldn't
> have a Reported-by? :)
> 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  Documentation/process/submitting-patches.rst | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> > index 31ea120ce531..24c1a5565385 100644
> > --- a/Documentation/process/submitting-patches.rst
> > +++ b/Documentation/process/submitting-patches.rst
> > @@ -495,7 +495,8 @@ Using Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: and Fixes:
> >  The Reported-by tag gives credit to people who find bugs and report them and it
> >  hopefully inspires them to help us again in the future.  Please note that if
> >  the bug was reported in private, then ask for permission first before using the
> > -Reported-by tag.
> > +Reported-by tag. A new feature can't be reported since there is no code in the
> > +kernel to fix.
> 
> How about instead something like "Reported-by is intended for bugs;
> please do not use it to credit feature requests"?

I think this misunderstands the problem that Andy is trying to fix.

The situation: I write a patch.  I post it for review.  A bot does
something and finds a bug (could be compile-error, could be boot
problem).  That bot sends a bug report with a suggestion to add
Reported-by:.  That suggestion is inappropriate because the bug never
made it upstream, so it looks like the bot reported the "problem"
that the patch "fixes".

It's not unique to "new feature" patches.  If I'm fixing a bug and
my fix also contains a bug spotted by a bot, adding Reported-by
makes it look like the bot spotted the original bug, rather than
spotting a bug in the fix.

The best thing to do in this case is nothing.  Do not credit the bot.
Maybe add a Checked-by:, but that would be a new trailer and I really
don't think we need a new kind of trailer to get wrong.
