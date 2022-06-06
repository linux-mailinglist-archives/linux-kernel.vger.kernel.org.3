Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65CC53E767
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbiFFKhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbiFFKhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:37:52 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E4B12AD5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 03:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654511870; x=1686047870;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qQ/9qGTYF8uA8ohG6pw+Jukr0gB7zxV+urlvatt/wBQ=;
  b=YCtJbTlQ24rwS39skT52geFP3fPkLQRPD/SXZ2o8FpYbd93rYyheMYBL
   WK+uzou7aV5ggEtRar3qo1VdmvXDeilDw9qUWynNK8+9Yew+bwNVkg31A
   xQR9x5ZI0ygCrPkmE2NlK5mnOSLQ9wwRW5DEmauhc3TLj8jNEr7RS+eks
   XLUJNzxkF1XnjBQoTemMHptrFlPxhJBRo6SAkbVvlLIxvoTlXbhV/y8Ny
   EqQ8SlQSQM09nZY14DMjwv+Z876kCoCJPN7UUZZXUzFF+UpxO1zUGu9eA
   76cPYwDfwMh3FdowguFqt7pNVFpIm3lbixxuex5Jg5CCQstDff14JWh6D
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="275423164"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="275423164"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:37:48 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="532080265"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:37:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nyA7B-000UaB-V7;
        Mon, 06 Jun 2022 13:37:41 +0300
Date:   Mon, 6 Jun 2022 13:37:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] cpumask: Update cpumask_next_wrap() signature
Message-ID: <Yp3Y9YRqg7qgVSjd@smile.fi.intel.com>
References: <cover.1654410109.git.sander@svanheule.net>
 <52c0f58d879f9f12fc2a9230ee08da219dc5298c.1654410109.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52c0f58d879f9f12fc2a9230ee08da219dc5298c.1654410109.git.sander@svanheule.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 05, 2022 at 08:22:41AM +0200, Sander Vanheule wrote:
> The extern specifier is not needed for this declaration, so drop it. The
> function also depends only on the input parameters, and has no side
> effects, so it can be marked __pure like other functions in cpumask.h

Missed period.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Sander Vanheule <sander@svanheule.net>
> ---
>  include/linux/cpumask.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 7ccddbc27ac3..f37ce00741a3 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -210,7 +210,7 @@ int cpumask_any_distribute(const struct cpumask *srcp);
>  		(cpu) = cpumask_next_zero((cpu), (mask)),	\
>  		(cpu) < nr_cpu_ids;)
>  
> -extern int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap);
> +int __pure cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap);
>  
>  /**
>   * for_each_cpu_wrap - iterate over every cpu in a mask, starting at a specified location
> -- 
> 2.36.1
> 

-- 
With Best Regards,
Andy Shevchenko


