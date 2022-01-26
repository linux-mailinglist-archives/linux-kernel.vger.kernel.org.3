Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B2D49CAEF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240233AbiAZNfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:35:52 -0500
Received: from mga06.intel.com ([134.134.136.31]:27196 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235061AbiAZNfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:35:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643204151; x=1674740151;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cXGNTr5J5iMmzg+/ShSMdmmAjgQmyI/sGWK0ORhpF3k=;
  b=FXimzd0aKattG8fitN7WHaDaAYQzlKj1tBGpuxLh4IUqGP+ecAPPw0oL
   /ToFS6cYGZ8x0iwQIbm5WJqd67DSvxD8svttwcOupD8vQY2PYE6HoLhcy
   daZppcFFUpnHZscQTTmHPX7PcDg7ydV7Rv1jaapABRTIkqM1qiSlW6QUU
   PoL2CvNOnji/G8FUbaA+QZ10z7XrVtv9YL6xqN7Ou5+jNFuQaD6OTiPXt
   YH59ujHlARYkMFDWMgP3zAOReei6qFyxC99VY0o8TP/R7T4953Umjy8Vu
   LKqURb95pTdxHoInOzDBd2MAmPkyi4GuHsGdpplyd7k6gb1ias0/7ve/D
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="307263605"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="307263605"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 05:35:50 -0800
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="628303941"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 05:35:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nCiRd-00Ebvw-G8;
        Wed, 26 Jan 2022 15:34:41 +0200
Date:   Wed, 26 Jan 2022 15:34:41 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wander Costa <wcosta@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Wander Lairson Costa <wander@redhat.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Johan Hovold <johan@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH] tty: serial: Use fifo in 8250 console driver
Message-ID: <YfFN8Q0o2RxXcE7y@smile.fi.intel.com>
References: <8e57400f-d6a8-bd42-6214-fca1fe37a972@kernel.org>
 <11ec4350-b890-4949-cf8f-bc62d530d64f@nvidia.com>
 <CAAq0SU=9R3Y_SAdM+HaqavzWBRd1Li-b5bnZZLd5Opfgd0vnkQ@mail.gmail.com>
 <fa42a60c-954a-acc0-3962-f00427153f78@nvidia.com>
 <YfArHDfrVHw7ApDx@smile.fi.intel.com>
 <YfArWaKJ13+OC/7w@smile.fi.intel.com>
 <CAAq0SU=U3UY+DUdd1fjj25Yt_QZriShZTSFTsq5B4tPnOYhQvQ@mail.gmail.com>
 <YfELyq5AmxiZxjme@kroah.com>
 <YfE6AiIgXrd+5qvk@smile.fi.intel.com>
 <CAAq0SU=ivwiGPZoD=BsD67A4A4pvuh0S02L2Udhg8vmjnmCAAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAq0SU=ivwiGPZoD=BsD67A4A4pvuh0S02L2Udhg8vmjnmCAAw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 10:23:57AM -0300, Wander Costa wrote:
> On Wed, Jan 26, 2022 at 9:10 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Jan 26, 2022 at 09:52:26AM +0100, Greg Kroah-Hartman wrote:

...

> > Wander, if you need a test for something new, I may help to perform on
> > our (sub)set of x86 machines.
> 
> Thanks, Andy. I will let you know when I have new patches.

Just Cc me that time.

-- 
With Best Regards,
Andy Shevchenko


