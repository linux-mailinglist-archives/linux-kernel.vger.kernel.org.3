Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF39149DD70
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238302AbiA0JMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:12:14 -0500
Received: from mga18.intel.com ([134.134.136.126]:50473 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232420AbiA0JMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:12:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643274732; x=1674810732;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=YQKKweKIW5Doo9DUiY0jWMnPIBUKbMijewzE2RXmCxc=;
  b=LhdJIrfihnzhPIC/oRnPQeYAg6VDORq/DYIu65ZR2+spkeC4jUHsXTNN
   CgBMVyCKjKo2yV2MDSDLUn9tXvnVKjNrmHhaH6CsOe95/ZmRdBEbfMOap
   xzHd99EKV++Cvcfqo786qc17MZSLpFY8Ms8P3XN7kCkG1ttRf1juIZZ/f
   iwXKN+e/yKf5dVQdUxf67iPiT9dMZOLRla3RuMx6OviK3LCHpZRZjO7/E
   eQLVPAVwL7FGPmnOul5LMTGyjeDe5Qw8uqMs9YJyj5IZO3kl+t4KLuFy1
   9BK766RoVjQC1E6DHJ8XF+Fo+eungC6UwxWjUNLKF6DWbKIUnGCDVJ/ci
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="230370746"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="230370746"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 01:12:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="581408275"
Received: from johnlyon-mobl.ger.corp.intel.com (HELO localhost) ([10.252.16.209])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 01:12:07 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/5] mei: add support for graphics system controller
 (gsc) devices
In-Reply-To: <MW3PR11MB4651EAD45375963B6A43CF8AED219@MW3PR11MB4651.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220119155807.222657-1-alexander.usyskin@intel.com>
 <20220119155807.222657-3-alexander.usyskin@intel.com>
 <YfGNbK6n3Ag/ORFJ@kroah.com>
 <MW3PR11MB4651EAD45375963B6A43CF8AED219@MW3PR11MB4651.namprd11.prod.outlook.com>
Date:   Thu, 27 Jan 2022 11:12:03 +0200
Message-ID: <878rv1y23g.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022, "Usyskin, Alexander" <alexander.usyskin@intel.com> wrote:
>> -----Original Message-----
>> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Sent: Wednesday, January 26, 2022 20:06
>> To: Usyskin, Alexander <alexander.usyskin@intel.com>
>> Cc: Jani Nikula <jani.nikula@linux.intel.com>; Joonas Lahtinen
>> <joonas.lahtinen@linux.intel.com>; Vivi, Rodrigo <rodrigo.vivi@intel.com>;
>> David Airlie <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>; Winkler,
>> Tomas <tomas.winkler@intel.com>; Lubart, Vitaly <vitaly.lubart@intel.com>;
>> intel-gfx@lists.freedesktop.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v2 2/5] mei: add support for graphics system controller
>> (gsc) devices
>> 
>> On Wed, Jan 19, 2022 at 05:58:04PM +0200, Alexander Usyskin wrote:
>> > From: Tomas Winkler <tomas.winkler@intel.com>
>> >
>> > GSC is a graphics system controller, based on CSE, it provides
>> > a chassis controller for graphics discrete cards, as well as it
>> > supports media protection on selected devices.
>> >
>> > mei_gsc binds to a auxiliary devices exposed by Intel discrete
>> > driver i915.
>> >
>> > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
>> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
>> > ---
>> >  drivers/misc/mei/Kconfig  |  14 +++
>> >  drivers/misc/mei/Makefile |   3 +
>> >  drivers/misc/mei/gsc-me.c | 192
>> ++++++++++++++++++++++++++++++++++++++
>> >  drivers/misc/mei/hw-me.c  |  27 +++++-
>> >  drivers/misc/mei/hw-me.h  |   2 +
>> >  5 files changed, 236 insertions(+), 2 deletions(-)
>> >  create mode 100644 drivers/misc/mei/gsc-me.c
>> >
>> > diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig
>> > index 0e0bcd0da852..ec119bb98251 100644
>> > --- a/drivers/misc/mei/Kconfig
>> > +++ b/drivers/misc/mei/Kconfig
>> > @@ -46,6 +46,20 @@ config INTEL_MEI_TXE
>> >  	  Supported SoCs:
>> >  	  Intel Bay Trail
>> >
>> > +config INTEL_MEI_GSC
>> > +	tristate "Intel MEI GSC embedded device"
>> > +	select INTEL_MEI
>> > +	select INTEL_MEI_ME
>> 
>> Please don't select, why not just depend on?
>
> These are hard dependencies. If user wants to have INTEL_GSC,
> user should enable INTEL_MEI and INTEL_MEI_ME anyway.

Isn't that exactly what depends on conveys?

> INTEL_MEI_ME selects INTEL_MEI in this file and it was taken as example.
>
> What is wrong with select? Why to avoid it use?

Documentation/kbuild/kconfig-language.rst:

  Note:
	select should be used with care. select will force
	a symbol to a value without visiting the dependencies.
	By abusing select you are able to select a symbol FOO even
	if FOO depends on BAR that is not set.
	In general use select only for non-visible symbols
	(no prompts anywhere) and for symbols with no dependencies.
	That will limit the usefulness but on the other hand avoid
	the illegal configurations all over.

If we followed that rule, we'd have a lot less kconfig dependency
issues.

If I had the time, I'd add a lint/verbose mode to scripts/kconfig tool
to warn about selecting symbols that are visible or have dependencies.


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
