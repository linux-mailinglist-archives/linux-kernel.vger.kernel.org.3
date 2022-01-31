Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41174A4DE6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240937AbiAaSRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:17:50 -0500
Received: from mga17.intel.com ([192.55.52.151]:33534 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234205AbiAaSRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:17:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643653068; x=1675189068;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mmbfN7EWjtVJlPPYulfzzNG3cWkywCNdf+H70EZzxYE=;
  b=jQsb0qSF4KAfC33uA3kLHwheblBJ55BQcNaNjlXIGgRBDPY9ePDxhLRP
   3EKR5fyKx2xMBIurNA8fF68MPuBZPadFTodDLy6opdItIxoqWSVWswItU
   07b8qKP8vnP9potDv/OA6zIUgnF0+1/Ir2jZytnGdd5/DTt7/vLInrWbk
   nMkRJKIJgNMr2b433GrXs+7PSObe69Wrf7mWeH2+j7oq35eECUsq3u3iK
   rX1lr8TZOByFRM4xBOX8wmNs/BBqNGf0YGPfdxVkyugnX+htJg1IzEV14
   udHRcTCW0wuAZaCx6cov56YsmfwwFDB0mnNItO3NKusybgSxWsen+bhTI
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="228183146"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="228183146"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 10:17:48 -0800
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="630109993"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 10:17:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nEbEJ-00Gz3U-51;
        Mon, 31 Jan 2022 20:16:43 +0200
Date:   Mon, 31 Jan 2022 20:16:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>, kbuild-all@lists.01.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Florian Eckert <fe@dev.tdt.de>
Subject: Re: [PATCH v1 1/1] docs: process: submitting-patches: Clarify the
 Reported-by usage
Message-ID: <YfgninPOaJhq7dsZ@smile.fi.intel.com>
References: <20220127155334.47154-1-andriy.shevchenko@linux.intel.com>
 <87o83xrwk9.fsf@meer.lwn.net>
 <YfPzNNvK8Sy8YmGW@casper.infradead.org>
 <Yff9xoh873aEikY4@hovoldconsulting.com>
 <YfgBi9dn8LI8d/bo@smile.fi.intel.com>
 <YfgSpArfoL9LUaBO@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfgSpArfoL9LUaBO@hovoldconsulting.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 05:47:32PM +0100, Johan Hovold wrote:
> On Mon, Jan 31, 2022 at 05:34:35PM +0200, Andy Shevchenko wrote:
> > On Mon, Jan 31, 2022 at 04:18:30PM +0100, Johan Hovold wrote:
> > > On Fri, Jan 28, 2022 at 01:44:20PM +0000, Matthew Wilcox wrote:
> 
> > > > I think this misunderstands the problem that Andy is trying to fix.
> > > > 
> > > > The situation: I write a patch.  I post it for review.  A bot does
> > > > something and finds a bug (could be compile-error, could be boot
> > > > problem).  That bot sends a bug report with a suggestion to add
> > > > Reported-by:.  That suggestion is inappropriate because the bug never
> > > > made it upstream, so it looks like the bot reported the "problem"
> > > > that the patch "fixes".
> > > > 
> > > > It's not unique to "new feature" patches.  If I'm fixing a bug and
> > > > my fix also contains a bug spotted by a bot, adding Reported-by
> > > > makes it look like the bot spotted the original bug, rather than
> > > > spotting a bug in the fix.
> > > > 
> > > > The best thing to do in this case is nothing.  Do not credit the bot.
> > > > Maybe add a Checked-by:, but that would be a new trailer and I really
> > > > don't think we need a new kind of trailer to get wrong.
> > > 
> > > It seems like the only way to fix this is to fix the bots. Adding more
> > > documentation is unlikely to help in this case.
> > 
> > Links to the documentation at least may clarify the point in case of a
> > review.
> 
> Sure.
> 
> > > Can't we file a bug to whoever is running the bots (Intel?) and ask them
> > > to remove the suggestion to add a Reported-by when the bot is testing a
> > > patch (as opposed to mainline or even -next)?
> > 
> > The granularity here is not a repo. It's a code itself and in some cases
> > it might be easy to distinguish new feature from the code modifications,
> > but when code is already there and feature is just an extension of the
> > existing file(s), it's hard to tell. And it might be true or not.
> 
> Not sure I understand what you're saying here. Perhaps you and Matthew
> are talking about different things after all.

I'm talking about your suggestion to fix the bots. It's not easy.
The problem is the same as Matthew explained.

> But for Matthew's issue, the case where the bots are testing posted
> patches ("Thank you for the patch! Yet something to improve:) should be
> easy to fix by simply dropping or rephrasing the "kindly add following
> tag as appropriate" suggestion.

Yes, but this is not "fixing the bots", it falls into category "working around"
them, because even for a clear bug report the suggestion can be stronger.
And doing that properly without kinda AI not easy.

> When testing merged code, it may be harder to tell whether the branch in
> question can be rebased or not (and an incremental fix with a
> reported-by tag is warranted).

-- 
With Best Regards,
Andy Shevchenko


