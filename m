Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2384AF143
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiBIMRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbiBIMQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:16:48 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF189C1038CD;
        Wed,  9 Feb 2022 04:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644408179; x=1675944179;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qzspAmnxWEQRyowdPIPEhGQJavJNN5dfQzJsIpAT7nc=;
  b=kzi46IlFe97SKOdff/9Ot3xhE+XwpWQSQ792nFIef5xEMsPoBhqZtWL/
   BsN4y4YHJ8BOUyw+6AAmSVsEhEqP8BoVAj5FNfZfek/9w9du9934ac2fw
   Ku3k7UA1bb4S9kJOr1psVjTImFnK+QCemGXl2uIh/v5woMioYeYMOWX1l
   bb9TZ6VKDBGDyhwj1y1KUc4i/nj0GrsM3Y0tsFZt/ipMj1rQmC157pR2f
   2uFQ60171yktMdc8jqs5+OSC4jDUka81r4beKD0LfOzYcQPxFk8vqEMZR
   XfM18RjwucyGKfDWrgATFbtCrt8nhiVdYGGAxZ9JOmOWUO5iJpSfernsy
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="249395635"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="249395635"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 04:02:59 -0800
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="568215463"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 04:02:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1nHlfb-002bPp-CQ;
        Wed, 09 Feb 2022 14:01:59 +0200
Date:   Wed, 9 Feb 2022 14:01:59 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc:     Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
        robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/4] iio:frequency:admv1014: add support for ADMV1014
Message-ID: <YgOtN+wha+j3ZFIO@smile.fi.intel.com>
References: <20220131100102.15372-1-antoniu.miclaus@analog.com>
 <Yf7AjXsRuhFeFTpD@smile.fi.intel.com>
 <e59fce3747428f30afdf77f9839910664e3e8524.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e59fce3747428f30afdf77f9839910664e3e8524.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 09:29:54PM +0100, Nuno Sá wrote:
> On Sat, 2022-02-05 at 20:23 +0200, Andy Shevchenko wrote:
> > On Mon, Jan 31, 2022 at 12:00:59PM +0200, Antoniu Miclaus wrote:
> > > The ADMV1014 is a silicon germanium (SiGe), wideband,
> > > microwave downconverter optimized for point to point microwave
> > > radio designs operating in the 24 GHz to 44 GHz frequency range.
> > 
> > Excellent job!
> > A few comments / questions below.
> > 
> > ...
> > 
> > > +config ADMV1014
> > > +       tristate "Analog Devices ADMV1014 Microwave Downconverter"
> > > +       depends on SPI && COMMON_CLK && 64BIT
> > 
> > Why 64BIT only?
> 
> Could not resist on this one... The thing is that CCF uses unsigned
> long for rates and this part operates in high GHz values. That means,
> as CCF stands, this cannot work on 32bit.

I read it a bit differently, i.e. CCF has a bug that needs to be addressed.

-- 
With Best Regards,
Andy Shevchenko


