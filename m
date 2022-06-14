Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08F354B6C5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344801AbiFNQv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 12:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351742AbiFNQu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:50:57 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0398446C96
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655225441; x=1686761441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=diBqcvD7f9wLYA2SL3XAvPR/G55mENPCpsDt0PlTF+M=;
  b=AdBFiVwI9Y6wQ6QzFhQI4t6HlL5ZIAh5akhNH6TmS8G3Z5mtcl/A/RCF
   RNaMun+F/d1rWfyyfOB8XiA79+tcoZDYbRWMPwIA82xqy4veBN5PuwJ5i
   EW3KbBkOtCiAVL5PtMlZ1b5OiioeUg6TY5KHbNJLar7cU50uRVU2xdxif
   VNh4PN8qalVmxGJbpAdKtn5pqICGoENGd09rZ33RN5SLgKJ4WIqiM8+NJ
   mQbVFoeth5ol6LFOFXtq7PJeLRZWRdXgTN2aXrhsC0AcrSTSXa5rwVx/S
   d3KD1Ht78IHNLU2wxJEW7Rt/REv7PjvE7rBGycB+MLSvgYuolQHbCrF5j
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="258515617"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="258515617"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 09:50:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="712543320"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 09:50:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o19kL-000cbD-73;
        Tue, 14 Jun 2022 19:50:29 +0300
Date:   Tue, 14 Jun 2022 19:50:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     wang.yi59@zte.com.cn, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.liang82@zte.com.cn, Liu.Jianjun3@zte.com.cn
Subject: Re: [PATCH] bitmap: fix a unproper remap when mpol_rebind_nodemask()
Message-ID: <Yqi8VH39+1L72hw1@smile.fi.intel.com>
References: <CAAH8bW8wD_hsOqtWa-g_1SNWNi7GHzsu9RvL8feY069JPKFWBA@mail.gmail.com>
 <202206141145339651323@zte.com.cn>
 <CAAH8bW_GCviYSadmf5CUxgJixkXbq+SfL63ZJt7Lsm9OAmPjVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAH8bW_GCviYSadmf5CUxgJixkXbq+SfL63ZJt7Lsm9OAmPjVQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 09:40:08AM -0700, Yury Norov wrote:
> On Mon, Jun 13, 2022 at 8:45 PM <wang.yi59@zte.com.cn> wrote:
> > > On Mon, Jun 13, 2022 at 4:31 AM Yi Wang <wang.yi59@zte.com.cn> wrote:

...

> > > Anyways, as per name, bitmap_remap() is intended to change bit
> > > positions, and it doesn't look wrong if it does so.

Haven't read the discussion in full, but saw the function here and my 2 cents
are the following:
 1) if we don't have tests for bitmap_remap() / bitmap_bitremap(), we should;
 2) these functions are used at least in one GPIO driver, so it would be nice
    to not touch them if they are not broken (see 1 above).

-- 
With Best Regards,
Andy Shevchenko


