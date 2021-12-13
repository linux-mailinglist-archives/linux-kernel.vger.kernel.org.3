Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6334735B9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 21:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242712AbhLMUTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 15:19:18 -0500
Received: from mga07.intel.com ([134.134.136.100]:34970 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235878AbhLMUTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 15:19:15 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="302203084"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="302203084"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 12:19:15 -0800
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="505057007"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 12:19:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mwrm4-005ldn-Sj;
        Mon, 13 Dec 2021 22:18:16 +0200
Date:   Mon, 13 Dec 2021 22:18:16 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuo Liu <shuo.a.liu@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>, linux-kernel@vger.kernel.org,
        Fei Li <fei1.li@intel.com>
Subject: Re: [PATCH v1 1/1] virt: acrn: Drop internal kernel type from ABI
Message-ID: <YbeqiHg3LxIFCaAU@smile.fi.intel.com>
References: <20211001135644.1884-1-andriy.shevchenko@linux.intel.com>
 <YVcUxXJeduv1OHrz@kroah.com>
 <YVciKWdHJMaEwQu6@smile.fi.intel.com>
 <YVck0pu9wkUM++Rf@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVck0pu9wkUM++Rf@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 05:10:10PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Oct 01, 2021 at 05:58:49PM +0300, Andy Shevchenko wrote:
> > On Fri, Oct 01, 2021 at 04:01:41PM +0200, Greg Kroah-Hartman wrote:
> > > On Fri, Oct 01, 2021 at 04:56:44PM +0300, Andy Shevchenko wrote:
> > > > guid_t is internal type of the kernel which is mistakenly had been exposed
> > > > to the user space. Replace it with raw buffers.
> > > 
> > > Wait, why is it a mistake to expose it to userspace?  What does this
> > > conflict with?  Is it a namespace issue?  Or something else?
> > 
> > It is the type which is defined solely for kernel use and what user space
> > should do is to use types defined by respective libraries, such as libuuid.
> 
> But that does not work here.  We want to expose a common uuid type that
> userspace can use in these structures, as well as the kernel.  Do you
> really want to "open code" arrays all over the place?

It's not used "all over a place", the only code is recently added by this
driver.

> > If you read the commit message to the end, you will notice that I have
> > mentioned the possible scenario what happened here. They seems misusing
> > guid_t as uuid_t, but the latter is not available for the users from
> > the kernel headers (and this is good). So this is an exact example why
> > guid_t shouldn't be exposed.
> 
> Then we should create a type that we can use here.  The kernel can not
> use libuuid, so what is wrong with using the kernel variable type
> namespace for this?  __guid?  __uuid?

Why? "All over the place" except this code (okay and one more, i.e. MEI,
but this is another story) we use raw arrays in ABI. Why virt out of a
sudden need a special _kernel_ type for that? I think the author simply
missed this subtle detail that it's not supposed to be outside of the
kernel.

-- 
With Best Regards,
Andy Shevchenko


