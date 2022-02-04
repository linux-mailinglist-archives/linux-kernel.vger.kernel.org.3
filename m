Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E264A9AA7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 15:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358910AbiBDOGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 09:06:39 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51992 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbiBDOGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 09:06:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB7D860AFD;
        Fri,  4 Feb 2022 14:06:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67452C004E1;
        Fri,  4 Feb 2022 14:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643983597;
        bh=RyIR8dJMc1IOcmZizEww/InxQ1bBAmYfnuCHIM1TwrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KGOrqyOrclHpuY//lkGpSrXAgd+1/lmaoLA3C4sQEGbyJ48BfRQM37xUmncb7bYFP
         gD6YyG59Y6eHrX9NKVKAMA/aMgQVtOm+JO/dT9hm98kl+BMIkAbwI6OgFxByAD/A3Y
         gNNS31Tk5WCehSMMv3hFb9192ZfLmGCe8jNYqNDQ=
Date:   Fri, 4 Feb 2022 14:43:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     Joe Perches <joe@perches.com>, hdegoede@redhat.com,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH V5 1/3] platform/x86: Add Intel Software Defined Silicon
 driver
Message-ID: <Yf0taBe4PwTNbu9g@kroah.com>
References: <20220204053046.2475671-1-david.e.box@linux.intel.com>
 <20220204053046.2475671-2-david.e.box@linux.intel.com>
 <aa16191c1241473fbfd55995bbba37bd2ab4a41c.camel@perches.com>
 <372f76f7b1b7cf3d0ca38a7a84bcc23322ff12ed.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <372f76f7b1b7cf3d0ca38a7a84bcc23322ff12ed.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 05:23:07AM -0800, David E. Box wrote:
> On Fri, 2022-02-04 at 02:14 -0800, Joe Perches wrote:
> > On Thu, 2022-02-03 at 21:30 -0800, David E. Box wrote:
> > > Intel Software Defined Silicon (SDSi) is a post manufacturing mechanism for
> > > activating additional silicon features. Features are enabled through a
> > > license activation process.
> > 
> > Why isn't this a user process and not a kernel one?
> 
> This is a mechanism for provisioning CPU features during runtime. It requires a
> driver to access the functionality. That functionality is discovered on a multi
> functional PCI device that is owned by the upstream intel_vsec driver.
> 
> > 
> > > V5
> > >   - Update kernel version to 5.18 in API doc and copyrights to 2022.
> > >   - Remove unneeded prototypes.
> > >   - In binary attribute handlers where ret is only used for errors,
> > >     replace,
> > >               return (ret < 0) ? ret : size;
> > >     with,
> > >               return ret ?: size;
> > 
> > I think this style overly tricky.
> > 
> > Why not the canonical:
> > 
> > 	if (ret < 0)
> > 		return ret;
> > 
> > 	return size;
> 
> I can see not using the 2 parameter shortcut of the ternary operator, but the
> regular 3 parameter expression is easy to read for simple operations.

Not always.  Spell it out please and be obvious.

thanks,

greg k-h
