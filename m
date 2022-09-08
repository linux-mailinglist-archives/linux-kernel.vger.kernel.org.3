Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6485B18C3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiIHJct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiIHJcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:32:45 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9160A8E4ED;
        Thu,  8 Sep 2022 02:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662629563; x=1694165563;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X7WUQ53W6WzyHOhXUdkgYWDqneo55gmDmJgGloAx1hQ=;
  b=Z8A6akF4Spi1KOZ3UjnSHOE7eQJ/wOBiRSR/7pEY+lmSCK2KH6MZrxEr
   wCwosOsvbNippwqbUDuZrTJtvW94yMEPnuhPUzeaNMUw3uyRq7rqSQmju
   GU5nXr7Ju2ESSMLfex2BYcH5PkmYW5yqvVAlvbmajeMwWevwaxseQe4ta
   Go2rDk2MtuOFPt9G+YSkTX8VY+pkHCwBww0e0m4sZtdkq9zIUTpW42Y4X
   2/9QfvkWNq4rhc5hQEOKNJryKJkoD2ZOzfWaqA4zTBqhE3PyagBOUrva2
   Us4UBrAs4k24qOgWAX94piAEeLZdC0kdEqyeKcjYb4nH4NvvWpflETVbD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="295856888"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="295856888"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 02:32:42 -0700
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="614825834"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 02:32:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oWDtm-00A3av-16;
        Thu, 08 Sep 2022 12:32:38 +0300
Date:   Thu, 8 Sep 2022 12:32:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 03/17] pinctrl: cy8c95x0: Allow most of the registers
 to be cached
Message-ID: <Yxm2tjFtMcgAIZiP@smile.fi.intel.com>
References: <20220902182650.83098-1-andriy.shevchenko@linux.intel.com>
 <20220902182650.83098-3-andriy.shevchenko@linux.intel.com>
 <CAHp75VcNGEVRnkWeVThaq4zNYoiZGSY-+KfbV5_9zG_5XoriMg@mail.gmail.com>
 <YxXyTCSKzL42PF1D@smile.fi.intel.com>
 <CACRpkdY4nJuXAxM7tYviWSPeqmCc6o4D--Vq0CZRPNjWNj+E_A@mail.gmail.com>
 <CACRpkda=c23ZSBAomncevzboeApSM33t08t_kZUiRaNJ4Dwe-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkda=c23ZSBAomncevzboeApSM33t08t_kZUiRaNJ4Dwe-A@mail.gmail.com>
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

On Thu, Sep 08, 2022 at 10:03:38AM +0200, Linus Walleij wrote:
> On Mon, Sep 5, 2022 at 3:30 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Mon, Sep 5, 2022 at 2:57 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Fri, Sep 02, 2022 at 09:42:00PM +0300, Andy Shevchenko wrote:
> > > > On Fri, Sep 2, 2022 at 9:36 PM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > >
> > > > > It's unclear why many of static registers were marked as volatile.
> > > >
> > > > the static (yeah, forgot it)
> > > >
> > > > > They are pretty much bidirectional and static in a sense that
> > > > > written value is kept there until a new write or chip reset.
> > > > > Drop those registers from the list to allow them to be cached.
> > > >
> > > > This patch is not correct due to indexing access. It's sneaked since I
> > > > forgot I added it into my main repo. The proper approach should be to
> > > > create virtual registers and decode them before use. This allows to
> > > > cache all ports and as a benefit to debug print all port actual
> > > > statuses.
> > >
> > > To be clear: With this one removed from the bunch the rest can be applied w.o.
> > > any change.
> >
> > I'll give Patrick a day or two to test/review and then I'll just apply
> > them all except this one, they are all pretty self-evident except ACPI
> > things which have obviously been tested on hardware so from my
> > point of view it's good to merge.
> 
> I applied all patches now except this one (3/17), some patches needed
> a bit of fuzzing because other stuff in my tree, so please check the
> result once it lands in linux-next.

Looks perfect, thanks!

-- 
With Best Regards,
Andy Shevchenko


