Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9BE4A4AB2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 16:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379696AbiAaPfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 10:35:43 -0500
Received: from mga18.intel.com ([134.134.136.126]:18947 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376980AbiAaPfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:35:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643643341; x=1675179341;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tgwBw9Bak6+Bjjl5tzG571e1mJ6rWLMksGOLOWhymFY=;
  b=imspXK4JpOTJ9Ev5peZU4GpEeuskzVS14jLP0O+5fhsnHeYuJmw7smGC
   HMXhKsBjyOM7MH2FuUKbtOS1/Ffxrg52mB2f4ggZk7JsE5G1uajkyDyot
   jknkVSuAmibxWYUzRegiwIZZ9aRJSesV42CnYMGvquCbhj67FxUxLvk+x
   FhA3Que8yhYAMtXV5gJ5fr+2ZmWk+RSHD0Tr2csX+K7xXGtUeeV4Jp2C9
   4CjMYIFvsW4n85eqy0ruVSFnHdDFwYREQ2hfn2Y3dgrX0UPZVE4tNJzty
   8z9dX/iJDpCVpLvTU8PiXKyqg/rJGUNJlKJZXL7aYetYF1VB1S4Wko1jB
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="231054127"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="231054127"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 07:35:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="598866231"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 07:35:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nEYhQ-00GuvV-Aa;
        Mon, 31 Jan 2022 17:34:36 +0200
Date:   Mon, 31 Jan 2022 17:34:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>, kbuild-all@lists.01.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Florian Eckert <fe@dev.tdt.de>
Subject: Re: [PATCH v1 1/1] docs: process: submitting-patches: Clarify the
 Reported-by usage
Message-ID: <YfgBi9dn8LI8d/bo@smile.fi.intel.com>
References: <20220127155334.47154-1-andriy.shevchenko@linux.intel.com>
 <87o83xrwk9.fsf@meer.lwn.net>
 <YfPzNNvK8Sy8YmGW@casper.infradead.org>
 <Yff9xoh873aEikY4@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yff9xoh873aEikY4@hovoldconsulting.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 04:18:30PM +0100, Johan Hovold wrote:
> On Fri, Jan 28, 2022 at 01:44:20PM +0000, Matthew Wilcox wrote:
> > On Thu, Jan 27, 2022 at 09:08:06AM -0700, Jonathan Corbet wrote:
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> > > 
> > > > It's unclear from "Submitting Patches" documentation that Reported-by
> > > > is not supposed to be used against new features. (It's more clear
> > > > in the section 5.4 "Patch formatting and changelogs" of the "A guide
> > > > to the Kernel Development Process", where it suggests that change
> > > > should fix something existing in the kernel. Clarify the Reported-by
> > > > usage in the "Submitting Patches".
> 
> > > How about instead something like "Reported-by is intended for bugs;
> > > please do not use it to credit feature requests"?
> > 
> > I think this misunderstands the problem that Andy is trying to fix.
> > 
> > The situation: I write a patch.  I post it for review.  A bot does
> > something and finds a bug (could be compile-error, could be boot
> > problem).  That bot sends a bug report with a suggestion to add
> > Reported-by:.  That suggestion is inappropriate because the bug never
> > made it upstream, so it looks like the bot reported the "problem"
> > that the patch "fixes".
> > 
> > It's not unique to "new feature" patches.  If I'm fixing a bug and
> > my fix also contains a bug spotted by a bot, adding Reported-by
> > makes it look like the bot spotted the original bug, rather than
> > spotting a bug in the fix.
> > 
> > The best thing to do in this case is nothing.  Do not credit the bot.
> > Maybe add a Checked-by:, but that would be a new trailer and I really
> > don't think we need a new kind of trailer to get wrong.
> 
> It seems like the only way to fix this is to fix the bots. Adding more
> documentation is unlikely to help in this case.

Links to the documentation at least may clarify the point in case of a review.

> Can't we file a bug to whoever is running the bots (Intel?) and ask them
> to remove the suggestion to add a Reported-by when the bot is testing a
> patch (as opposed to mainline or even -next)?

The granularity here is not a repo. It's a code itself and in some cases
it might be easy to distinguish new feature from the code modifications,
but when code is already there and feature is just an extension of the
existing file(s), it's hard to tell. And it might be true or not.


-- 
With Best Regards,
Andy Shevchenko


