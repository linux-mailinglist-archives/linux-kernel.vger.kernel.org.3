Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B854A9D46
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376710AbiBDRBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:01:09 -0500
Received: from mga18.intel.com ([134.134.136.126]:18542 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233140AbiBDRBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:01:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643994068; x=1675530068;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SjTd2W8zwH4XR40/3bPYFlpLsz+WD9O8mmJISj+9wIg=;
  b=K5IhTlRo5JXuidEGh+TakVxPU+LkAgNMnf/d+o5m+XNRtQZQj4cD4aRU
   /E5NN8GKaSg/Lp6xl4m7jFYXSYezeR7C6vQG/DJvWKcNqLf1gTaNRh3dI
   MJkakVZfaiJ8oHHz4EaMpGdGfnpbtzHoh5REZojRpNPLEPvP6I0XbDs/a
   eksVGfq7RwS5+HShVKk3uKyMephjnRaoEoHIZHbeUoTKOvlmySnCrqPhd
   1VzJLGOS+27m6fm4BGvKDV13HYNjjGjStJ70tYJx3ymVX7DTMm5hXvVA5
   kxTCLgZqidK1BCldaQLjN8Zu/yniarKaTQW0XVvYeLvlrP1i3avYk2Fps
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="231968259"
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="231968259"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 09:01:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="566790056"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 04 Feb 2022 09:01:08 -0800
Received: from tjjang-mobl.amr.corp.intel.com (unknown [10.255.231.211])
        by linux.intel.com (Postfix) with ESMTP id CCD2B580279;
        Fri,  4 Feb 2022 09:01:07 -0800 (PST)
Message-ID: <682714ab20540935c972adfa9304482ba6999a0c.camel@linux.intel.com>
Subject: Re: [PATCH V5 1/3] platform/x86: Add Intel Software Defined Silicon
 driver
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Joe Perches <joe@perches.com>, hdegoede@redhat.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Date:   Fri, 04 Feb 2022 09:01:07 -0800
In-Reply-To: <71d3f97b4d4937b6e57772a56603766be7dd1ac8.camel@perches.com>
References: <20220204053046.2475671-1-david.e.box@linux.intel.com>
         <20220204053046.2475671-2-david.e.box@linux.intel.com>
         <aa16191c1241473fbfd55995bbba37bd2ab4a41c.camel@perches.com>
         <372f76f7b1b7cf3d0ca38a7a84bcc23322ff12ed.camel@linux.intel.com>
         <71d3f97b4d4937b6e57772a56603766be7dd1ac8.camel@perches.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-02-04 at 06:01 -0800, Joe Perches wrote:
> On Fri, 2022-02-04 at 05:23 -0800, David E. Box wrote:
> > On Fri, 2022-02-04 at 02:14 -0800, Joe Perches wrote:
> > > On Thu, 2022-02-03 at 21:30 -0800, David E. Box wrote:
> []
> > > >   - In binary attribute handlers where ret is only used for errors,
> > > >     replace,
> > > >               return (ret < 0) ? ret : size;
> > > >     with,
> > > >               return ret ?: size;
> > > 
> > > I think this style overly tricky.
> > > 
> > > Why not the canonical:
> > > 
> > > 	if (ret < 0)
> > > 		return ret;
> > > 
> > > 	return size;
> > 
> > I can see not using the 2 parameter shortcut of the ternary operator, but
> > the
> > regular 3 parameter expression is easy to read for simple operations.
> 
> The issue to me is it combines an error test and error return
> with the common return.

Ah, okay.

> 
> it's also being used and avoided / naked with the similar
> 
> 	return min(ret, size);
> 
> https://lore.kernel.org/lkml/20211116121014.1675-1-zhaoxiao@uniontech.com/T/

Thanks.

