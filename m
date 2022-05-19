Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081D852DE40
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 22:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244670AbiESUVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 16:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243954AbiESUVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 16:21:49 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EE911149;
        Thu, 19 May 2022 13:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652991707; x=1684527707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iRA3bBsRXMbdxcUrTBg3lPrfCJleBb7f1Q94Up1IVuY=;
  b=GR0k8a9LpBcmdIX8AloeNlfEM/5SyL/kJAN8rrox482vPSfhn5/mz/P4
   RHd1IqCHxGTHf3n6bKz8tNP5OvOahiG994B/pzD4uUQ1hVLYy9bmhD+ph
   j/zMJuKJJZCZf0sv15b0tz39C5Z0iAD446x/DfUKcGVTSRqndenB1aUH5
   SVfsuQXB9q3Rk2ZU16edmxLQVhycUMgn+3xK1qUa8wvlz0CRqoIaNwj+W
   pUNSuxK5U5RIH7IWcIspwFwqgrdajh8jIWgr9t4tG8Zt+BDOLkh4a/8oq
   DsO7IQts5SDXXEKpix7VNBAAZg7l64qNgX9UU/B9+tPQelkERtcG4x3l8
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="271187192"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="271187192"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 13:21:47 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="743112742"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 13:21:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nrmeU-000GDt-1e;
        Thu, 19 May 2022 23:21:42 +0300
Date:   Thu, 19 May 2022 23:21:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        willy@infradead.org
Subject: Re: [PATCH v2 07/28] lib/printbuf: Unit specifiers
Message-ID: <Yoam1bW/vni3srLc@smile.fi.intel.com>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
 <20220519172421.162394-8-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519172421.162394-8-kent.overstreet@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 01:24:00PM -0400, Kent Overstreet wrote:
> This adds options to printbuf for specifying whether units should be
> printed raw (default) or with human readable units, and for controlling
> whether human-readable units should be base 2 (default), or base 10.
> 
> This also adds new helpers that obey these options:
> 
>  - pr_human_readable_u64
>  - pr_human_readable_s64
> These obey printbuf->si_units
> 
>  - pr_units_u64
>  - pr_units_s64
> These obey both printbuf-human_readable_units and printbuf->si_units

...

> +void pr_human_readable_s64(struct printbuf *buf, s64 v)
> +{
> +	if (v < 0)
> +		pr_char(buf, '-');
> +	pr_human_readable_u64(buf, abs(v));

Wouldn't -v work?

> +}

...

> + * pr_human_readable_u64 - Print out a u64 according to printbuf unit options

Have you ever compile this? We have kernel doc validator running when compiling
the code...

> + * Units are either raw (default), or human reabable units (controlled via
> + * @buf->human_readable_units)
> + */
> +void pr_units_u64(struct printbuf *out, u64 v)
> +{
> +	if (out->human_readable_units)
> +		pr_human_readable_u64(out, v);
> +	else
> +		pr_buf(out, "%llu", v);
> +}
> +EXPORT_SYMBOL(pr_units_u64);
> +
> +/**
> + * pr_human_readable_s64 - Print out a s64 according to printbuf unit options

Ditto.

> + * Units are either raw (default), or human reabable units (controlled via
> + * @buf->human_readable_units)
> + */
> +void pr_units_s64(struct printbuf *out, s64 v)
> +{
> +	if (v < 0)
> +		pr_char(out, '-');
> +	pr_units_u64(out, v);

Please, start with test cases.

> +}

-- 
With Best Regards,
Andy Shevchenko


