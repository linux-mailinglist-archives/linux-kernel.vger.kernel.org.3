Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191D34D14AE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345811AbiCHK11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbiCHK1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:27:25 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB1A403DD;
        Tue,  8 Mar 2022 02:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646735188; x=1678271188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8ZXez3FiH4XTUGihrwHP9hVOqrlcK4/ZLZFGF2nClaI=;
  b=Ov65txSQHUlUlSairMP+PE2omhQ5tvxPuq9LvZEuQL8sNwrPvKqStIPO
   8VgP+5rQ4E8+hppMT9A/KzQHvC+Aci+HvoVP+jCzsOxTkr+6ZOScxc26p
   jRW2V7V+R416ldsrjAZAkEhCfMgDu/+6mqUN0PKo/jBFVibBtdkbh8nqx
   e2Vj1gwwpBUUzwzeLYdBiCPoKUVcLLa/yEjSmyhuL2Ap6yrKntZUffyo6
   Vmex/DIsCjS4tPABmILRcjmz9CfZUnGaDV+slHue+8cMChyn5uLuEYmk/
   yn1hW0NACdq8DOd7vXIPHGtPLYHbrjL/ymd5Ow4s27uoRYdRyWSDd+0MX
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="234604070"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="234604070"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 02:26:28 -0800
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="643610528"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 02:26:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nRX2E-00DINI-K5;
        Tue, 08 Mar 2022 12:25:42 +0200
Date:   Tue, 8 Mar 2022 12:25:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: [PATCH v1 1/1] media: c8sectpfe: Clean up handling of
 *_buffer_aligned
Message-ID: <YicvJpTtICUFAvoe@smile.fi.intel.com>
References: <20220209182521.55632-1-andriy.shevchenko@linux.intel.com>
 <Yh+SjmGgSZGGaW/I@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh+SjmGgSZGGaW/I@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Hans (see below).

On Wed, Mar 02, 2022 at 05:51:42PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 09, 2022 at 08:25:21PM +0200, Andy Shevchenko wrote:
> > There are a few cases where code is harder than needed to read.
> > Improve those by:
> > - dropping unnecessary castings (see note below)
> > - use PTR_ALING() to be more explicit on what's going on there
> > - use proper definitions instead of hard coded values
> > 
> > Note, dropping castings will allow to perform an additional check
> > that type is not changed from void * to something else, e.g. u64,
> > which may very well break the bitmap APIs.
> 
> Any comments on it?
> Can it be applied?

-- 
With Best Regards,
Andy Shevchenko


