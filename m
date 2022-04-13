Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD4D4FFDB2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237100AbiDMS0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237243AbiDMS0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:26:07 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7D339B93;
        Wed, 13 Apr 2022 11:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649874225; x=1681410225;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Co60nO+I1JTIOO+/f6mG6/MORhLQ4XAMclSNvF/UwwE=;
  b=UgF6H1cikzjxTZSd+5zQBqMDAwB9JuWEEf1JTZ0eWKb9Vw3jeeuGL8MH
   FiIERq8lX2oOC8LM2NLReGXhf2xai7ZhncmbrHJvayhxFHRkx4Z0t91Ca
   b2Uau4YEDU8izrWW/q9cHnAQdFUvqtFukj0ZrLiqW5pYr+VHX98jKaAPE
   oYRhec/fwEnVN3e3y5SF4OrDfQGvvrlKswl/jWEKjTCzaqvQwTe1LDB1p
   5DqcIHJCJ+aJDrEB/CtP9blIukk9HTUG3Zs64csrw1MAEAbP90B90u5Si
   4fOhedfrFuZuz5g05cr8wvtDLaYjvjwORYWDAU5pODPgX/OsSyD9jgqOf
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="243328801"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="243328801"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 11:23:45 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="655667435"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 11:23:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nehb1-001xcN-3q;
        Wed, 13 Apr 2022 21:20:03 +0300
Date:   Wed, 13 Apr 2022 21:20:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v6 1/5] device property: Allow error pointer to be passed
 to fwnode APIs
Message-ID: <YlcUUoJQme5wWYEj@smile.fi.intel.com>
References: <20220408184844.22829-1-andriy.shevchenko@linux.intel.com>
 <YlQyEz3/J0rb2Hew@smile.fi.intel.com>
 <YlQ69jMduq/evgTt@kroah.com>
 <YlRNPyxHcNRQE/5A@smile.fi.intel.com>
 <CAJZ5v0gGc8cVzGgXVuHW6hQ67h9b+HfSj_EqFPCOrTfjYGVOUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gGc8cVzGgXVuHW6hQ67h9b+HfSj_EqFPCOrTfjYGVOUg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 08:06:27PM +0200, Rafael J. Wysocki wrote:
> On Mon, Apr 11, 2022 at 5:49 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Apr 11, 2022 at 04:28:06PM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Apr 11, 2022 at 04:50:11PM +0300, Andy Shevchenko wrote:
> > > > On Fri, Apr 08, 2022 at 09:48:40PM +0300, Andy Shevchenko wrote:

...

> > > > Rafael and Greg, if this okay for you, can the first three patches be
> > > > applied, so we will have at least the fix in and consider constification
> > > > a further work?
> > >
> > > Give us a chance, you sent this on friday and are asking about it first
> > > thing Monday morning?
> > >
> > > Please go and review other patches sent on the list to help us catch up.
> >
> > OK! Reviewed (actually commented on) a few patches so far.
> 
> I've just queued up the first three patches in the series for 5.19.

Thank you!

-- 
With Best Regards,
Andy Shevchenko


