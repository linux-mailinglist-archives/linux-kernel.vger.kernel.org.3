Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C2D4B5EED
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 01:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbiBOAQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 19:16:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbiBOAQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 19:16:09 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E71B10B23C;
        Mon, 14 Feb 2022 16:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644884160; x=1676420160;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wvKAq1YglJpEe9h3Kz3zHEnAV1lSCgE1d1UvSLjdlgI=;
  b=KCQ8MSVSjTF3F0/Vc81lqWgWIcCg32SkmXvrqunCPe9FOYys5cl6qX76
   ipyQI+qiy3+YU9PvCRDpLXg5LO5+eN2/eP0puysUpNGAhIu5oGyASW3Bi
   kSFVK7gXtFNZ9C0zf97Y4iTX65arYrv2ob/V5rjHzkyfT8B7/lreGjIst
   b9tSIlAo7v/pGygP8z8dYfhuwI9fuej0VDetF6hI3IfGvxGnIK9Hti/uH
   UQ7171PydGK1t+2alYJ2DXR2d9oyAtSgMdQ4ZKdHTQzuvWFlIbnV85E2z
   xXI6N3ThY3Ch2eqObYYlgfISUbEmO5rxwC2Mf/rucvQKevWREDXu8Zs4u
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="249046304"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="249046304"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 16:16:00 -0800
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="496433493"
Received: from junliao-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.133.237])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 16:15:59 -0800
Message-ID: <78026a45db94ebd91e13eb335611a1d49a25b2e7.camel@linux.intel.com>
Subject: Re: [RFC PATCH 4/4] tools/thermal: Add thermal daemon skeleton
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Date:   Mon, 14 Feb 2022 16:15:59 -0800
In-Reply-To: <f249be05-74ef-6aeb-a561-462c3a76a194@linaro.org>
References: <20220214210446.255780-1-daniel.lezcano@linaro.org>
         <20220214210446.255780-4-daniel.lezcano@linaro.org>
         <50025eeb1826c929342e9f600b5c2d91eed6d2ed.camel@linux.intel.com>
         <f249be05-74ef-6aeb-a561-462c3a76a194@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-02-15 at 00:43 +0100, Daniel Lezcano wrote:
> 
> Hi Srinivas,
> 
> On 14/02/2022 23:34, srinivas pandruvada wrote:
> > On Mon, 2022-02-14 at 22:04 +0100, Daniel Lezcano wrote:
> > > This change provides a simple daemon skeleton. It provides an
> > > example
> > > of how to use the thermal library.
> > > 
> > > The goal of this skeleton is to give a base brick for anyone
> > > interested in writing its own thermal engine.
> > > 
> > > In the future, it will evolve with more features.
> > > 
> >  From the code, doesn't seam to have a function to daemonize.
> 
> Yes, it does, see below. If the stdout output is set, then it won't 
> daemonize.
OK.

> 
> 
> > So may be not call a daemon if that is true. mainloop() is just an
> > infinite loop polling netlink messages.
> > 
> > Also thermald will confuse with the standard thermald distributed
> > with
> > every distro. May be thermal_control_sample as this a sample for
> > future
> > development.
> 
> Does thermal-engine fine ?
fine.

Thanks,
Srinivas

> 
> > > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> [ ... ]
> 
> > >   tools/thermal/thermald/thermald.c | 275
> 
> [ ... ]
> 
> > > +       if (!(options.logopt & TO_STDOUT) && daemon(0, 0))
> > > +               return 1;
> 
> [ ... ]
> 

