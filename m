Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD1F49C955
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 13:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241113AbiAZMKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 07:10:50 -0500
Received: from mga12.intel.com ([192.55.52.136]:10802 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241091AbiAZMKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 07:10:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643199048; x=1674735048;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0cSewon31q9T9uMO3sD6+fCdAQ/YjIB/6kr07CYlyLs=;
  b=QAXiI8TmZ92CG++ppIMpvAaAUC6w/+jB1yPxIKyjRiqX2prkJm4rs7Ee
   YRIaSDJlCRzR6eVLwvIg69/nhFqsYAcN+NGqCU91/uKjpXoXV6DEchDeF
   d/m19i8wGgH9PYFee+csLzu4FEXSeffD+i8mZhCas0L4HPXBW+fF7asTN
   KM2N54BM4EgnTsPUvFvopdi/FrNa+kCRlkdS8glisCfuNfWQfhf1uKcv7
   kEinAZh+xjoMSj736wAIlhm4c1iXebNCPeJwrzaYoSJ4jlPpgec6LUddP
   5ArpeV00ptOgTYIwAmJ5+NuwHc6LGSiO+rufwKOYgWeTtuChvOwy0lNh0
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="226513224"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="226513224"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 04:10:48 -0800
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="495339226"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 04:10:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nCh7L-00EaeP-Bp;
        Wed, 26 Jan 2022 14:09:39 +0200
Date:   Wed, 26 Jan 2022 14:09:38 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Wander Costa <wcosta@redhat.com>,
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
Message-ID: <YfE6AiIgXrd+5qvk@smile.fi.intel.com>
References: <a1ac6254-f79e-d131-fa2a-c7ad714c6d4a@nvidia.com>
 <f451e67d-adb9-01e8-bd11-bf7804863b4b@kernel.org>
 <8e57400f-d6a8-bd42-6214-fca1fe37a972@kernel.org>
 <11ec4350-b890-4949-cf8f-bc62d530d64f@nvidia.com>
 <CAAq0SU=9R3Y_SAdM+HaqavzWBRd1Li-b5bnZZLd5Opfgd0vnkQ@mail.gmail.com>
 <fa42a60c-954a-acc0-3962-f00427153f78@nvidia.com>
 <YfArHDfrVHw7ApDx@smile.fi.intel.com>
 <YfArWaKJ13+OC/7w@smile.fi.intel.com>
 <CAAq0SU=U3UY+DUdd1fjj25Yt_QZriShZTSFTsq5B4tPnOYhQvQ@mail.gmail.com>
 <YfELyq5AmxiZxjme@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfELyq5AmxiZxjme@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 09:52:26AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 25, 2022 at 03:40:36PM -0300, Wander Costa wrote:
> > On Tue, Jan 25, 2022 at 1:56 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Tue, Jan 25, 2022 at 06:53:48PM +0200, Andy Shevchenko wrote:
> > > > On Tue, Jan 25, 2022 at 12:40:27PM +0000, Jon Hunter wrote:
> > > > > On 25/01/2022 10:29, Wander Costa wrote:
> > >
> > > ...
> > >
> > > > > Andy, does this work for X86?
> > > >
> > > > Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > >
> > > > No, it does NOT fix an issue (I see it on a handful x86) with the legacy UART
> > > > (means the 8250_pnp is in use). And I believe the same will be the case on LPSS
> > > > ones (8250_dw / 8250_lpss) and HSU (8250_mid), because the patch influences on
> > > > all of them.
> > >
> > > Shall I send a revert and we can continue with a new approach later on?
> > >
> > 
> > Tomorrow (or maybe after tomorrow) I am going to post the fixes I
> > already have, and an additional patch adding a build option
> > (disabled to default) so people maybe if they want to use the FIFO on
> > console write. But I understand if people decide to go
> > ahead and revert the patch.
> 
> Let me revert this for now.  And no new config options please, this
> should "just work".

Thanks!

Wander, if you need a test for something new, I may help to perform on
our (sub)set of x86 machines.

-- 
With Best Regards,
Andy Shevchenko


