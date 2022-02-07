Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6874AB7B9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350287AbiBGJ11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 04:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241258AbiBGJ0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:26:25 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 01:26:24 PST
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3C2C043185;
        Mon,  7 Feb 2022 01:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644225984; x=1675761984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jOaWn8eBeotYB78WK3ufQ611JINmtK4Y3HLF7Flk3bw=;
  b=guXIK2ny5cITLhV3dPm7z5HQkeiftJwpP82TMRlDf3H1/x2FrUh7Pv02
   ZFZMGgqlZ3SJXBki3e4N5VSkXjoA3FhZORVWZXtF/eE+ZRawlGllGIEQu
   3Vrcp1IBjDcMdHAz+AZr/FVfzthN8Xs9+7HuUeUuxF/juk2zEyPalOEP3
   0Xjl3MuAp10NYa5CwaGopmxbGqv0a0/rtKjSnMKXFuWYBZqatdDlUfjbK
   zk9115fIPkrJpVl64UHJgYJx538jX7SSylzgwnuOEOvDfu1ENky+Mt2nT
   5nRVUdXFJ4xIKorB47dwCldxDZS7OBr4LjAHxk3rcpGA5LKxBdBFArMue
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="311977936"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="311977936"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 01:25:21 -0800
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="484357501"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 01:25:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nH0Fw-001poW-Th;
        Mon, 07 Feb 2022 11:24:20 +0200
Date:   Mon, 7 Feb 2022 11:24:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 2/2] iio: temperature: ltc2983: Make use of device
 properties
Message-ID: <YgDlRFmiys/Djgdx@smile.fi.intel.com>
References: <20220203114506.53904-1-andriy.shevchenko@linux.intel.com>
 <20220203114506.53904-2-andriy.shevchenko@linux.intel.com>
 <20220205171454.49a7225c@jic23-huawei>
 <Yf7ArwPrN34drkcv@smile.fi.intel.com>
 <PH0PR03MB6786C5F8E528249EBA938070992B9@PH0PR03MB6786.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR03MB6786C5F8E528249EBA938070992B9@PH0PR03MB6786.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2022 at 12:51:00PM +0000, Sa, Nuno wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Saturday, February 5, 2022 7:24 PM
> > On Sat, Feb 05, 2022 at 05:14:54PM +0000, Jonathan Cameron wrote:
> > > On Thu,  3 Feb 2022 13:45:06 +0200
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> > > > +#include <asm/byteorder.h>
> > > > +#include <asm/unaligned.h>
> > 
> > > This may well be a valid addition but it's not called out in the patch
> > > description.
> > 
> > This is a side effect of the change. Below I will try to explain, tell me if
> > that is what you want to be added to the commit message (feel free to
> > correct
> > my English).
> > 
> > The conversion slightly changes the logic behind property reading for
> > the
> > configuration values. Original code allocates just as much memory as
> > needed.
> > Then for each separate 32- or 64-bit value it reads it from the property
> > and converts to a raw one which will be fed to the sensor. In the new
> > code
> > we allocated the amount of memory needed to retrieve all values at
> > once from
> > the property and then convert them as required.
> 
> Yeah, I understood what you are doing... We allocate some extra bytes so
> that we can simplify a lot the logic to get, convert and put back the properties
> in the table... And since we are only writing the __real__ table size into the device
> I'm fairly positive this works. However, I do agree with Jonathan and I would
> be more confident to give this a test before being applied...
> 
> That said, I'm off till the end of the month (just doing minor stuff like replying
> to emails :)), so if we can hold this one, I will test it first thing I'm back in the
> office.

Will wait for your testing. Meanwhile I address all other comments and send v3
for further review.

-- 
With Best Regards,
Andy Shevchenko


