Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498D14F6517
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbiDFQLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237550AbiDFQLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:11:23 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9EF2296FC;
        Wed,  6 Apr 2022 06:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649252385; x=1680788385;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=MR0QuVLovLHwAZvrr6TMq2mU0Gw8cRhORK9LWq219do=;
  b=l4Z8fbU86lYSLeBjF9lLaRWuIb5MQn2A3ewHyTWona6QoyCXlYT5mTO+
   sXEsAZwxocNTi8sLQnGQl86fALA3/FF/oYJuiIwKQest+DsAPdcHS4gkg
   38lHqJPVkh9qmHRbI/vrB3GcHi3Kj3TsOn2UPFVAA+CLOCWRn4293bXMC
   IqfLbAw+q/pU7zxDcShehwjk5yXORIsEDKOskSXVsiRcHDftJPnATRudq
   CmvArXXR14yo+ZhWq1oycMjoihxQ5YW63CALSpkKf6sVan6aE5Y/oiJ7+
   hsW0hRaq5LRTc0qGGz+11oOOuUYnwGWUpwDG1JoGuOQ4XcMC1su5MTYa4
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="286014249"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="286014249"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 06:39:14 -0700
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="722516790"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 06:39:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nc5qv-000EhC-0U;
        Wed, 06 Apr 2022 16:37:41 +0300
Date:   Wed, 6 Apr 2022 16:37:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: [PATCH v1 1/1] media: c8sectpfe: Clean up handling of
 *_buffer_aligned
Message-ID: <Yk2XpEaRiVylkXEt@smile.fi.intel.com>
References: <20220209182521.55632-1-andriy.shevchenko@linux.intel.com>
 <Yh+SjmGgSZGGaW/I@smile.fi.intel.com>
 <YicvJpTtICUFAvoe@smile.fi.intel.com>
 <20220308171005.GA365233@gnbcxd0016.gnb.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308171005.GA365233@gnbcxd0016.gnb.st.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 06:10:05PM +0100, Alain Volmat wrote:
> Hi Andy,
> 
> sorry for the delay.
> 
> Reviewed-by: Alain Volmat <alain.volmat@foss.st.com>

Thanks!

Can it be applied now?

> On Tue, Mar 08, 2022 at 12:25:42PM +0200, Andy Shevchenko wrote:
> > On Wed, Mar 02, 2022 at 05:51:42PM +0200, Andy Shevchenko wrote:
> > > On Wed, Feb 09, 2022 at 08:25:21PM +0200, Andy Shevchenko wrote:
> > > > There are a few cases where code is harder than needed to read.
> > > > Improve those by:
> > > > - dropping unnecessary castings (see note below)
> > > > - use PTR_ALING() to be more explicit on what's going on there
> > > > - use proper definitions instead of hard coded values
> > > > 
> > > > Note, dropping castings will allow to perform an additional check
> > > > that type is not changed from void * to something else, e.g. u64,
> > > > which may very well break the bitmap APIs.
> > > 
> > > Any comments on it?

-- 
With Best Regards,
Andy Shevchenko


