Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA853564006
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 14:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbiGBMAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 08:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiGBMAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 08:00:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E52612755;
        Sat,  2 Jul 2022 05:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656763245; x=1688299245;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TmBINPi4YWQq6jPhvMGuqgLplCQN4DhZzS9sXB4R8Ug=;
  b=T3OZUsPW3seQ8auOX/rgnLOo81VsMigkT6XSY0btZHDQ+26Pe3nTWPM0
   3E+GRSRf9hHD/c+OgnwwVzbcDwn2tjeubL0wNU+tEnckU6MTbZmvH1EOK
   pt+zX+ncsp3PNLIfaAH/ED3NDuj4nGx0aDZ/a+MU5H3GyLtz6XZcPkNm0
   t+DSnMAqlPgq/lySvmhenPqhMGalHFgCBI+xU1LCXVt3wXyHpwjaQfvwe
   LXKX/gvkZZJKCOn9dPrS4q74B7sis6g8ksWAl/mmz8HQwvrAZ0EtXR4mr
   kldVHaonOusR/DleT+6FyzSyuMGH85xidsGdQxBK/4tXDp2VcY8OU9UYb
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="283934003"
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="283934003"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 05:00:42 -0700
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="838343902"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 05:00:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o7bnQ-0013au-0e;
        Sat, 02 Jul 2022 15:00:20 +0300
Date:   Sat, 2 Jul 2022 15:00:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 5/8] lib/cpumask: change return types to unsigned where
 appropriate
Message-ID: <YsAzU3g2QpgmIGre@smile.fi.intel.com>
References: <20220701125430.2907638-1-yury.norov@gmail.com>
 <20220701125430.2907638-6-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701125430.2907638-6-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 05:54:27AM -0700, Yury Norov wrote:
> Switch return types to unsigned int where return values cannot be negative.

...

> -int cpumask_any_and_distribute(const struct cpumask *src1p,
> +unsigned int cpumask_any_and_distribute(const struct cpumask *src1p,
>  			       const struct cpumask *src2p);

It breaks indentation of the second line.

...

> -int cpumask_next_and(int n, const struct cpumask *src1p,
> +unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
>  		     const struct cpumask *src2p)

Ditto.

And seems a lot of cases in the series like this.

-- 
With Best Regards,
Andy Shevchenko


