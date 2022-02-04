Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294B64AA3EE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377837AbiBDXED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:04:03 -0500
Received: from mga04.intel.com ([192.55.52.120]:27123 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377830AbiBDXEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:04:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644015841; x=1675551841;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cDlea75dcM5oWd3Z9GjyVZl7KExXwKzNlRCG52zMlrk=;
  b=KwiQPSCYCh/VCprgMjYUvX8Q3+7Zqj5XN7y4gEXvqZ5y7riYIwHrvNGg
   fh051UeBCwgZDD3gMnuHL4heSmR0HAGu8poW/AKJuUEnNlFI+CalLv1pI
   IxSUP7tT1lR8ZdbNjF2Rxn+/i5M5EIyI0SSTO0dHvuYOi1RSx/cCG6g2B
   eSePmemdCy7Rqudi67fBq5qa1VMYqlP5g3gnq6bDIGIZLy0MO+8FfkM30
   QglLVfgnz1ZcGBxuk7TYj+KEX9vZJHrgQfrXd689/rJK55FnUuifiL8Da
   pmfZJiWYq+DNuCINmZV5Uhrc31qSmtvqmeA0KGQ/lc+h80yh0HfblBGlv
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="247290619"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="247290619"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 15:04:01 -0800
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="539338882"
Received: from ahofrock-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.64.72])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 15:04:01 -0800
Message-ID: <4b97ea9a45476698a439aebca4ebcc881892e201.camel@linux.intel.com>
Subject: Re: [PATCH] tools/lib/thermal: Add a thermal library
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Viktor Rosendahl <Viktor.Rosendahl@bmw.de>,
        Sasha Levin <sashal@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>
Date:   Fri, 04 Feb 2022 15:04:00 -0800
In-Reply-To: <c610f361-14b5-6c64-ff28-7ae0442aed71@linaro.org>
References: <20220204161518.163536-1-daniel.lezcano@linaro.org>
         <CAJZ5v0gXJ8wF2ChGU1bydPiNHB4c+SVrmrTpUwxMh7ddODFV5g@mail.gmail.com>
         <d8e4c15757cd9b40fe5d47bec7e07fc997431b1a.camel@linux.intel.com>
         <c610f361-14b5-6c64-ff28-7ae0442aed71@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-02-04 at 23:16 +0100, Daniel Lezcano wrote:
> 
> Hi Srinivas,
> 
> On 04/02/2022 20:32, srinivas pandruvada wrote:
> > On Fri, 2022-02-04 at 18:11 +0100, Rafael J. Wysocki wrote:
> > > CC Rui and Srinivas
> > > 
> > > On Fri, Feb 4, 2022 at 5:15 PM Daniel Lezcano
> > > <daniel.lezcano@linaro.org> wrote:
> > > > 
> > > > The thermal framework implements a netlink notification
> > > > mechanism
> > > > to
> > > > be used by the userspace to have a thermal configuration
> > > > discovery,
> > > > trip point changes or violation, cooling device changes
> > > > notifications,
> > > > etc...
> > > > 
> > > > This library provides a level of abstraction for the thermal
> > > > netlink
> > > > notification allowing the userspace to connect to the
> > > > notification
> > > > mechanism more easily. The library is callback oriented.
> > > > 
> > > > As it is the very first iteration, the API may be subject to
> > > > changes. For this reason, the documentation will be provided
> > > > after
> > > > those are stabilized.
> > > 
> > > So shouldn't this be an RFC?
> > > 
> > > Also, I would prefer documentation to be provided or at least
> > > some
> > > intended usage examples to be given.
> > > 
> > > > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > > ---
> > > >   tools/Makefile                           |  14 +-
> > > >   tools/include/uapi/linux/thermal.h       |  91 ++++++
> > This is duplicating the file at include/uapi/linux. I know this is
> > done
> > for other tools also. In my use I am copying and using symbolic
> > link.
> 
> Why copy and symbolic link ? Should it be create a symbolic link only
> ?
Correct, symbolic only by making change in Makefile:

$(OUTPUT)include/linux/thermal.h:
../../../../include/uapi/linux/thermal.h
	mkdir -p $(OUTPUT)include/linux 2>&1 || true
	ln -sf $(CURDIR)/../../../../include/uapi/linux/thermal.h $@

Thanks,
Srinivas

> 
> > BTW I have potential usage of netlink targeted for next release in
> > linux tools.
> > 
> > https://github.com/spandruvada/linux-kernel/blob/intel-sst/tools/power/x86/intel-speed-select/hfi-events.c
> > 
> > I can replace with libthermal calls once ready. I will check the
> > code
> > below next week.
> 
> Great, thanks!
> 
> In attachment a test file as an example of the library usage.
> 
> 

