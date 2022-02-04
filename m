Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4714A99DC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354834AbiBDNXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:23:09 -0500
Received: from mga04.intel.com ([192.55.52.120]:56121 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235551AbiBDNXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643980988; x=1675516988;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TV/vGanZAMh7EU9vt4bRAQbwXvJ/Ldm53ID5furO1tw=;
  b=JwRWA76LYzJl8mxy3+QTgZQ4M/1g2c7c7VGq1bfFeTf6TfCH1a+GMYj7
   N2EOn3ebi0QMK3zZy8QtmQ9lC9zsx8seStNtmWh3q0uBRAU0fxOD1geE0
   NjHRqIAfhqMHKbQcD+DgQjuJq8xgoWlDcesf72x2fxOi/+48cbgHpO4hf
   X5++PA36J74HdSJY7Kocr+B89JGLesKxDl1f0ZzvuqXBzLq7jZvfuucAj
   hJvETrBIuNYbpoaFB4DjOICAqxRrsgM4T2mRDADR4zWJdNwl/KnYAcCB3
   fkYzrJNXnO8gPpjc6lOESeopNCjcdpVG57awCCJz4nH9viUQWnK6fcP4I
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="247198170"
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="247198170"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 05:23:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="535529645"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 04 Feb 2022 05:23:08 -0800
Received: from colson-mobl.amr.corp.intel.com (colson-mobl.amr.corp.intel.com [10.251.2.6])
        by linux.intel.com (Postfix) with ESMTP id D40EE580718;
        Fri,  4 Feb 2022 05:23:07 -0800 (PST)
Message-ID: <372f76f7b1b7cf3d0ca38a7a84bcc23322ff12ed.camel@linux.intel.com>
Subject: Re: [PATCH V5 1/3] platform/x86: Add Intel Software Defined Silicon
 driver
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Joe Perches <joe@perches.com>, hdegoede@redhat.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Date:   Fri, 04 Feb 2022 05:23:07 -0800
In-Reply-To: <aa16191c1241473fbfd55995bbba37bd2ab4a41c.camel@perches.com>
References: <20220204053046.2475671-1-david.e.box@linux.intel.com>
         <20220204053046.2475671-2-david.e.box@linux.intel.com>
         <aa16191c1241473fbfd55995bbba37bd2ab4a41c.camel@perches.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-02-04 at 02:14 -0800, Joe Perches wrote:
> On Thu, 2022-02-03 at 21:30 -0800, David E. Box wrote:
> > Intel Software Defined Silicon (SDSi) is a post manufacturing mechanism for
> > activating additional silicon features. Features are enabled through a
> > license activation process.
> 
> Why isn't this a user process and not a kernel one?

This is a mechanism for provisioning CPU features during runtime. It requires a
driver to access the functionality. That functionality is discovered on a multi
functional PCI device that is owned by the upstream intel_vsec driver.

> 
> > V5
> >   - Update kernel version to 5.18 in API doc and copyrights to 2022.
> >   - Remove unneeded prototypes.
> >   - In binary attribute handlers where ret is only used for errors,
> >     replace,
> >               return (ret < 0) ? ret : size;
> >     with,
> >               return ret ?: size;
> 
> I think this style overly tricky.
> 
> Why not the canonical:
> 
> 	if (ret < 0)
> 		return ret;
> 
> 	return size;

I can see not using the 2 parameter shortcut of the ternary operator, but the
regular 3 parameter expression is easy to read for simple operations.

David

> 
> 

