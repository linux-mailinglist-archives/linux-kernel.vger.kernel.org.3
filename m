Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4287547CF59
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239810AbhLVJfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:35:05 -0500
Received: from mga02.intel.com ([134.134.136.20]:28482 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229987AbhLVJfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:35:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640165704; x=1671701704;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qZUDc1T9LV4wFwF8706CO5P2w8QLmoRAzlSwfpbYtGo=;
  b=EdtrB2uIitEkMptxUmSWeQjhDQ0UiJYWYw1RMyPdSAG8ZXvaWXsHqYjw
   OQ8iI0I1QnG5bC2oBSe0Z311ZaP5vE84M5tREH9m5QWhV8jpQp6C4d43d
   jt47apMG0Z4ZP+g/fCy67/oVAZi33+r8SfPGLk+X8VLymUY1yHS4pgE8C
   7iKo4aZ0dD3FYAAMPvcXJ05dVnfPE+r7/KMw3XVcCcvBWZGToVajAq+C7
   pTbSQPRdxSICp0Qtz0W3DDZU96pCNmh1FC43U4z1QeTxc7SOooctMANW6
   hk1CoCl1/OgPqDTzwcu8rwTrB7waujARc6NMGd6shQ71wJQiAmehiZTxl
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="227881944"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="227881944"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 01:35:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="586966983"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 01:35:01 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 582C7201AA;
        Wed, 22 Dec 2021 11:34:59 +0200 (EET)
Date:   Wed, 22 Dec 2021 11:34:59 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] software node: fix wrong node passed to find nargs_prop
Message-ID: <YcLxQ+X3I6hAJ9RY@paasikivi.fi.intel.com>
References: <20211220210533.3578678-1-clement.leger@bootlin.com>
 <CAHp75Vf+F2L4EFmokRYD+-M9hSuz+SbiiWnqHvFZttRyfKS-mg@mail.gmail.com>
 <d9f5b201-2a00-799d-3a0f-7c9709d77102@gmail.com>
 <YcGfky32lSXeABEF@kroah.com>
 <YcGiIHAJS7/qXcJv@paasikivi.fi.intel.com>
 <800d89c5-c9e3-d969-ea9a-08ec0362a90c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <800d89c5-c9e3-d969-ea9a-08ec0362a90c@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Tue, Dec 21, 2021 at 10:09:45PM +0000, Daniel Scally wrote:
> Hi Sakari
> 
> On 21/12/2021 09:45, Sakari Ailus wrote:
> > Hi Greg, Andy,
> > 
> > On Tue, Dec 21, 2021 at 10:34:11AM +0100, Greg Kroah-Hartman wrote:
> >> On Mon, Dec 20, 2021 at 11:37:07PM +0000, Daniel Scally wrote:
> >>> Thanks Andy
> >>>
> >>> On 20/12/2021 22:13, Andy Shevchenko wrote:
> >>>> + Sakari, Dan
> >>>>
> >>>> On Monday, December 20, 2021, Clément Léger <clement.leger@bootlin.com
> >>>> <mailto:clement.leger@bootlin.com>> wrote:
> >>>>
> >>>>     nargs_prop refers to a property located in the reference that is found
> >>>>     within the nargs property.
> >>>
> >>> I think this is right (it's not used in the ACPI version, and the OF
> >>> version is quite convoluted so a bit hard to follow)...but also I note
> >>> that none of the users of fwnode_property_get_reference_args() pass
> >>> anything to nargs_prop anyway...do we even need this?
> >>
> >> Looks like it is unused, please just remove it.
> > 
> > If you remove nargs_prop argument, then callers will have to use OF
> > property API instead to parse references with property-defined number of
> > arguments. The goal has been to cover all functionality in a
> > firmware-independent way.
> 
> My mistake, I missed that of_parse_phandle_with_args() has a ton of
> direct users. I guess we should try to replace those with
> fwnode_property_get_reference_args() where appropriate.

I'd say at least when the code is otherwise using fwnode property API.

I guess most of the reference users are OF-based originally while cameras
are perhaps a bit of an exception to this. :-)

-- 
Regards,

Sakari Ailus
