Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3824A5C55
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 13:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbiBAMcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 07:32:53 -0500
Received: from mga17.intel.com ([192.55.52.151]:8894 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237839AbiBAMcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 07:32:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643718768; x=1675254768;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2WKtuJJwm5/FU6ldhuWImjtTEiJUIFzc3T8FBxlJcD4=;
  b=kuDYezcjhNT6z5klcI3dFuo6vUHIX822UDN0SiPXZ4oDUhVJ4GD1xGgC
   cNHeWfDqnBu7E6hvUHqCM1UqSn2wEmxCylHS28VAjtmbM9l/Aq5VunP33
   35jeDqCydJBrnRUJ/EjDDZBqMq6BuISXqDTHRlyaYXYCzLOBySsQ8GiNm
   C8CbwNbfCDixbK/3bx3MrDodt5uB+WOiS5TGDkAxcegun1QX/D1OWwazL
   iDeIHZBu7XrKgnoRz+crFs1z/8ftXC+elDtUIa+6sflKzllL+b/jkyXji
   5aC8uEXAqBaU0MLjQIOmBPWDS7dznEUvSqg4FcgYHuHejtW/j/PdvfrSc
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="228339483"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="228339483"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 04:32:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="771092423"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 01 Feb 2022 04:32:46 -0800
Received: from lfrecald-MOBL2.amr.corp.intel.com (lfrecald-MOBL2.amr.corp.intel.com [10.212.222.127])
        by linux.intel.com (Postfix) with ESMTP id 4D53D58090D;
        Tue,  1 Feb 2022 04:32:46 -0800 (PST)
Message-ID: <0af21024ec302a8bddd6a827f57889be899e1d5b.camel@linux.intel.com>
Subject: Re: [PATCH 1/3] platform/x86: Add Intel Software Defined Silicon
 driver
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     hdegoede@redhat.com, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Date:   Tue, 01 Feb 2022 04:32:46 -0800
In-Reply-To: <YfjzEQnvpH7hUZYa@kroah.com>
References: <20220201030424.1068816-1-david.e.box@linux.intel.com>
         <20220201030424.1068816-2-david.e.box@linux.intel.com>
         <YfjzEQnvpH7hUZYa@kroah.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-02-01 at 09:45 +0100, Greg KH wrote:
> On Mon, Jan 31, 2022 at 07:04:22PM -0800, David E. Box wrote:
> > Intel Software Defined Silicon (SDSi) is a post manufacturing mechanism for
> > activating additional silicon features. Features are enabled through a
> > license activation process.  The SDSi driver provides a per socket, sysfs
> > attribute interface for applications to perform 3 main provisioning
> > functions:
> > 
> > 1. Provision an Authentication Key Certificate (AKC), a key written to
> >    internal NVRAM that is used to authenticate a capability specific
> >    activation payload.
> > 
> > 2. Provision a Capability Activation Payload (CAP), a token authenticated
> >    using the AKC and applied to the CPU configuration to activate a new
> >    feature.
> > 
> > 3. Read the SDSi State Certificate, containing the CPU configuration
> >    state.
> > 
> > The operations perform function specific mailbox commands that forward the
> > requests to SDSi hardware to perform authentication of the payloads and
> > enable the silicon configuration (to be made available after power
> > cycling).
> > 
> > The SDSi device itself is enumerated as an auxiliary device from the
> > intel_vsec driver and as such has a build dependency on CONFIG_INTEL_VSEC.
> > 
> > Link: https://github.com/intel/intel-sdsi
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > Reviewed-by: Mark Gross <markgross@kernel.org>
> > ---
> >  .../ABI/testing/sysfs-driver-intel_sdsi       |  77 +++
> >  MAINTAINERS                                   |   5 +
> >  drivers/platform/x86/intel/Kconfig            |  12 +
> >  drivers/platform/x86/intel/Makefile           |   2 +
> >  drivers/platform/x86/intel/sdsi.c             | 571 ++++++++++++++++++
> >  drivers/platform/x86/intel/vsec.c             |  12 +-
> >  6 files changed, 678 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-driver-intel_sdsi
> >  create mode 100644 drivers/platform/x86/intel/sdsi.c
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-driver-intel_sdsi
> > b/Documentation/ABI/testing/sysfs-driver-intel_sdsi
> > new file mode 100644
> > index 000000000000..126978647e9b
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-driver-intel_sdsi
> > @@ -0,0 +1,77 @@
> > +What:		/sys/bus/auxiliary/devices/intel_vsec.sdsi.X
> > +Date:		Dec 2021
> > +KernelVersion:	5.17
> 
> 5.17 merge window is long gone now.
> 
> Please be more careful.
> 

Thanks.

