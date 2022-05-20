Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E7952EDF1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350207AbiETORX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350221AbiETORS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:17:18 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EF955238;
        Fri, 20 May 2022 07:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653056232; x=1684592232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0dhkczegwRH13BvW0cvFYHyS34naarmgkKC/BWnrwr8=;
  b=NAO5ULFVTbqNCnEIVPyWhRpN+f8Tl+bmp2QgAf02jS78eT1gdqyATt1/
   jhLl7XlHVPsGa3jsVtGk9ohBxouh+JlRarPnjvUDVZh7yrSPStSCIuwAO
   WrIFAHE9tuR1BSfTmSE+fB8NEumPCPtljcojB7UDqPoYRPa20VQ5SRIEI
   8MY4tFR4ieD/e+xCmmLnFZJbqqaZP45kJpwh35ScCryZcm/RhvVct1XUi
   anKunlil9y6liEBegH8lu0GKIQDRIkL+67lN9B8QL4JBQrmBsOr8YHt1m
   xvm2n5OuvY5w2mkv+BIlCRuB2su8A5zJyeXzw/xBj6e+5fSGlVVbQfV4t
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="271435377"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="271435377"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 07:17:11 -0700
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="607032045"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 07:17:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ns3RC-000GqM-7s;
        Fri, 20 May 2022 17:17:06 +0300
Date:   Fri, 20 May 2022 17:17:05 +0300
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     David Laight <David.Laight@aculab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@vger.kernel.org" <linux-mm@vger.kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH v2 03/28] vsprintf: %pf(%p)
Message-ID: <Yoei4RdwQ0u5HyPB@smile.fi.intel.com>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
 <20220519172421.162394-4-kent.overstreet@gmail.com>
 <141b17a257274fc38291cdb07e0e23b6@AcuMS.aculab.com>
 <20220520044924.dr2rnnbhvilxznek@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520044924.dr2rnnbhvilxznek@moria.home.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 12:49:24AM -0400, Kent Overstreet wrote:
> On Thu, May 19, 2022 at 09:06:24PM +0000, David Laight wrote:

...

> > > The goal is to replace most of our %p format extensions with this
> > > interface, and to move pretty-printers out of the core vsprintf.c code -
> > 
> > One advantage of the current scheme is that is reasonably safe
> > and easy to use.
> > Perhaps too many extra formats have been added recently.
> > This all seems like a recipe for disaster with functions being
> > called with the wrong number of parameters
> > (I can't think how you can compile-time check it).
> 
> We can't check it at compile time yet, it's true - printf format checking will
> need to be extended. But we're already talking about doing that.

I have heard about GCC plugin, which also may check the %p extension usages.


-- 
With Best Regards,
Andy Shevchenko


