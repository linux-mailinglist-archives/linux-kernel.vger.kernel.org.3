Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6C25A2D23
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344756AbiHZRMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiHZRMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:12:45 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF25DCE4AC;
        Fri, 26 Aug 2022 10:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661533964; x=1693069964;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BhJRRUFziUNzOcXvUZjv5pQU3PXRrJozjSPAvlt9I7g=;
  b=MRBRzzYN9f8oqKJFOAVeUSfgCWehmzpGa1tCinf1jACr/IRpSK3YsJ5c
   t7PTzei1+UYBC7iBHVBEDwFWTlpVmiad9BqzZCL2KewD6cO6RNB6Oz1FT
   VrCUt8NoF+aZU7Z5xy9aTRBedOTQbwfrYnZ8Q04dbibYVzkuM3nO9ntim
   Jc4AtMw5LkJhsvXi82D6YXbG5fyPLkK4l92xbo0QVwIl6xZSnNChWT7Tw
   LcRW1STjk2gYfnyPqQSsQMyIJk04IjAYJguTlCaKVgFad8a1SVNLKmioh
   OVP3doqBrzvCir5DcK3P4J67CO1NfsHqfhmx4OJFaDSXlDJAoutY4QnN5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="294559754"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="294559754"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 10:12:44 -0700
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="587369245"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 10:12:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oRcsq-003z9s-0C;
        Fri, 26 Aug 2022 20:12:40 +0300
Date:   Fri, 26 Aug 2022 20:12:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 5/5] ACPI: bus: Use the matching table, if ACPI driver
 has it
Message-ID: <Ywj/Bxvv+Dtt/Dy0@smile.fi.intel.com>
References: <20220825164103.27694-1-andriy.shevchenko@linux.intel.com>
 <20220825164103.27694-5-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0if_gZpibSWx5mfoVpGXtF0sGe7MY+eRQJr09ONX0Q1rQ@mail.gmail.com>
 <CAHp75VcQkyCOo9jkKKmu=zgHgQiHD96QhTa9Ann3syTaVnBokQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcQkyCOo9jkKKmu=zgHgQiHD96QhTa9Ann3syTaVnBokQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 08:17:11PM +0300, Andy Shevchenko wrote:
> On Thu, Aug 25, 2022 at 8:05 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Thu, Aug 25, 2022 at 6:41 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > In case we have an ACPI driver, check its ID table for matching,
> > > This allows to use some generic device property APIs in such
> > > drivers.
> >
> > No new provisions for ACPI drivers, please.
> 
> OK! I will think about how to refactor a driver in question, so it
> won't need this kind of trick. Meanwhile patches 1-3 can be applied
> independently, if you have no objections.

I see that you applied an equivalent patch to what I had here as patch 3.
Taking into account rejection of patches 4 and 5 I will send a v2 with
patch 1 and (modified due to drop of the 5) 2 for your convenience.

-- 
With Best Regards,
Andy Shevchenko


