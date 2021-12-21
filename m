Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D2A47BD1C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236515AbhLUJpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:45:15 -0500
Received: from mga07.intel.com ([134.134.136.100]:59067 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231710AbhLUJpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640079914; x=1671615914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/uvKmkz952zDqvr2rf+02z0n2M4cj8bmt3XUsQVfh44=;
  b=YT0BN2ySEkVCsMCtstGLJIMz6wKAhDUa27eYGpIujCr1HTKjSsiweeOp
   awMMGeviJd4l/ThCuikkRgNaxEXV/qR/rfs14ZHu9fZWRRFSLx6B1DdJm
   VDMDNsoeSoz2sfp69EcInf7m94d77h0RvjNsqhGpeNMH7yTHKmYKUzF/B
   8VlHpTGrNJ1K94777EBblXfI+yLOFSX/pcRIxitNU2GKdR7CZhVH8tbCY
   R8CrMhKY1LuME0Gj8UNzb/zOoOQeDSpFlQZVzIhvFmGs1cxHTPdpZQ5yk
   0cAEvoAaIzSwqqsq907TLMoVEVOZoubuj8VYaw8Hv3io7t8Ce3FMtuU1w
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="303732697"
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="303732697"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 01:45:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="616711939"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 01:45:06 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 2CE56201AA;
        Tue, 21 Dec 2021 11:45:04 +0200 (EET)
Date:   Tue, 21 Dec 2021 11:45:04 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] software node: fix wrong node passed to find nargs_prop
Message-ID: <YcGiIHAJS7/qXcJv@paasikivi.fi.intel.com>
References: <20211220210533.3578678-1-clement.leger@bootlin.com>
 <CAHp75Vf+F2L4EFmokRYD+-M9hSuz+SbiiWnqHvFZttRyfKS-mg@mail.gmail.com>
 <d9f5b201-2a00-799d-3a0f-7c9709d77102@gmail.com>
 <YcGfky32lSXeABEF@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YcGfky32lSXeABEF@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, Andy,

On Tue, Dec 21, 2021 at 10:34:11AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Dec 20, 2021 at 11:37:07PM +0000, Daniel Scally wrote:
> > Thanks Andy
> > 
> > On 20/12/2021 22:13, Andy Shevchenko wrote:
> > > + Sakari, Dan
> > > 
> > > On Monday, December 20, 2021, Clément Léger <clement.leger@bootlin.com
> > > <mailto:clement.leger@bootlin.com>> wrote:
> > > 
> > >     nargs_prop refers to a property located in the reference that is found
> > >     within the nargs property.
> > 
> > I think this is right (it's not used in the ACPI version, and the OF
> > version is quite convoluted so a bit hard to follow)...but also I note
> > that none of the users of fwnode_property_get_reference_args() pass
> > anything to nargs_prop anyway...do we even need this?
> 
> Looks like it is unused, please just remove it.

If you remove nargs_prop argument, then callers will have to use OF
property API instead to parse references with property-defined number of
arguments. The goal has been to cover all functionality in a
firmware-independent way.

-- 
Regards,

Sakari Ailus
