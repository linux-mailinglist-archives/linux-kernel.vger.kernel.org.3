Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C02E5AEF72
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbiIFPwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbiIFPvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:51:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F377C1DA;
        Tue,  6 Sep 2022 08:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662476928; x=1694012928;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=itE7kZ47RvKv7aOih+1Wnx/AC33Uqv9KiENi43eLSX8=;
  b=cj82i0/BazHZcTncG3KsbfdsHF/IN0ujWu4ZyBcNqE3T2QTuKsSqAVNy
   r2O65IDkqkd2OJ5tz+feVMREnvmk7c8UD2YZmc4CvCFMkjfbGw4rdz3Dv
   Ei5ZileHqArv4zfsENoRGE0cQlbLsJyowd5IzMHlE2BFN5zThieOos76M
   F0Ht6w5q/n2kxbpZwH6ImjSJEg82MeSSXTSdeGE2O1d8sJ7rnzWv12ZYg
   PYbVRu9PfmE9WrzTyTAF094L+nBBe0tS4Ef8gWqSkr22T0IvSq070i7cn
   CL4xqH8eFUh9RkXM71Un9X7ekhvPKa04sGZ+JYc9JassoHyrru7IvrQp6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="283594159"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="283594159"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 07:01:21 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="614102740"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 07:01:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oVZ8d-00995i-2a;
        Tue, 06 Sep 2022 17:01:15 +0300
Date:   Tue, 6 Sep 2022 17:01:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "Farber, Eliav" <farbere@amazon.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        p.zabel@pengutronix.de, rtanwar@maxlinear.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hhhawa@amazon.com, jonnyc@amazon.com
Subject: Re: [PATCH v4 05/21] hwmon: (mr75203) fix voltage equation for
 negative source input
Message-ID: <YxdSqw6STdkbDESV@smile.fi.intel.com>
References: <20220906083356.21067-1-farbere@amazon.com>
 <20220906083356.21067-6-farbere@amazon.com>
 <Yxc3GeFc5gDKrYyP@smile.fi.intel.com>
 <29fa5c01-aad0-04ff-e1a9-1510858eff7e@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29fa5c01-aad0-04ff-e1a9-1510858eff7e@amazon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 04:27:13PM +0300, Farber, Eliav wrote:
> On 9/6/2022 3:03 PM, Andy Shevchenko wrote:
> > On Tue, Sep 06, 2022 at 08:33:40AM +0000, Eliav Farber wrote:

...

> > > -             *val = (PVT_N_CONST * n - PVT_R_CONST) >> PVT_CONV_BITS;
> > > +             *val = (PVT_N_CONST * (long)n - PVT_R_CONST) / (1 <<
> > > PVT_CONV_BITS);
> > 
> > Wondering if we can use BIT(PVT_CONV_BITS) for two (quite unlikely to
> > happen,
> > I hope) purposes:
> > 
> > 1) Somebody copies such code where PVT_CONV_BITS analogue can be 31,
> >   which is according to C standard is UB (undefined behaviour).
> > 
> > 2) It makes shorter the line and also drops the pattern where some
> >   dumb robot may propose a patch to basically revert the division
> >   change.
> I originally tried to use BIT(PVT_CONV_BITS) but it gave a different
> result.
> e.g.
> If n = 2720
> *val = (PVT_N_CONST * (long)n - PVT_R_CONST) / (1 << PVT_CONV_BITS) = 0
> *val = (PVT_N_CONST * (long)n - PVT_R_CONST) / BIT(PVT_CONV_BITS) =
> 18014398509481983
> 
> I can try fitting it in one line, either by adding a define for
> (1 << PVT_CONV_BITS) or exceeding 80 characters, but keep in mind that
> in a later patch (#15) it gets even longer (and I must use more than
> one line) since it is multiplied by a pre-scaler factor.

Don't get me wrong, it's not about style, it's about preventing
followup "fixes" of this. All the problems here due to (hidden)
unsigned type(s).

What you can do is to add a good comment on top of that line
explaining why division instead of right shift and why BIT()
may not be used (because it's unsigned).

-- 
With Best Regards,
Andy Shevchenko


