Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6629B511F84
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240096AbiD0PoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240098AbiD0PoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:44:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5972A252
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651074058; x=1682610058;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=30GJAH8LI0FeMcoTBydu3l8Pe3095VvppqBa8fGuspY=;
  b=Sft+Z8RsiikGMyPa/nnEim01KnQzuQfLjIK58k8mP/iN0zOwa5tfchR9
   zzVFCCTKdZfyo0B6SFVMm84Tg/n33y3iMwCke/6UU5t9s9O6+/CrSmnJ9
   DynUNmppgVaBNCs4LmRxi3zaMF5Tv10ht7N1NQSp6e7OX/SUiCPgkog2s
   GkcmsjyJ4EUAx7Svv4YT71iRI2VjnYAP7J6HLEO7Fb4+VnKDh8W3j5+Pq
   NIN25KEow/p4fmvgzjluFr882a14kO+uCF6lr5jgJqJG1PZyIcQhRzsur
   kCEgs4QbDhraENnQoAq3t174Fk7S95KJMeQAW++fPuiuvbzxQUqopx8cR
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="253347956"
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="253347956"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 08:13:50 -0700
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="680823122"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 08:13:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1njjMO-008sVO-0H;
        Wed, 27 Apr 2022 18:13:44 +0300
Date:   Wed, 27 Apr 2022 18:13:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org, ying.huang@intel.com, dave.hansen@intel.com,
        Jonathan.Cameron@huawei.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, rf@opensource.cirrus.com,
        pmladek@suse.com
Subject: Re: [PATCH v3 1/2] lib/kstrtox.c: Add "false"/"true" support to
 kstrtobool()
Message-ID: <Ymldp7E3j29iVlMN@smile.fi.intel.com>
References: <20220426180203.70782-1-jvgediya@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426180203.70782-1-jvgediya@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 11:32:02PM +0530, Jagdish Gediya wrote:
> At many places in kernel, It is necessary to convert sysfs input
> to corrosponding bool value e.g. "false" or "0" need to be converted

corresponding

> to bool false, "true" or "1" need to be converted to bool true,
> places where such conversion is needed currently check the input
> string manually, kstrtobool() can be utilized at such places but
> currently it doesn't have support to accept "false"/"true".
> 
> Add support to accept "false"/"true" as valid string in kstrtobool().

Andrew, this patch still needs a bit of work.

> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
> Chnages in v2:
> - kstrtobool to kstrtobool() in commit message.
> - Split single patch into 2
> - Remove strcmp usage from kstrtobool() and instead compare 1st
>   character only.
> 
> Changes in v3:
> - Covert -> Convert in patch 2 subject
> - Collected Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
>  lib/kstrtox.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/kstrtox.c b/lib/kstrtox.c
> index 886510d248e5..465e31e4d70d 100644
> --- a/lib/kstrtox.c
> +++ b/lib/kstrtox.c
> @@ -340,7 +340,7 @@ EXPORT_SYMBOL(kstrtos8);
>   * @s: input string
>   * @res: result
>   *
> - * This routine returns 0 iff the first character is one of 'Yy1Nn0', or
> + * This routine returns 0 if the first character is one of 'YyTt1NnFf0', or

s/if/iff/ please. It's _not_ a typo!

>   * [oO][NnFf] for "on" and "off". Otherwise it will return -EINVAL.  Value
>   * pointed to by res is updated upon finding a match.
>   */
> @@ -353,11 +353,15 @@ int kstrtobool(const char *s, bool *res)
>  	switch (s[0]) {
>  	case 'y':
>  	case 'Y':
> +	case 't':
> +	case 'T':
>  	case '1':
>  		*res = true;
>  		return 0;
>  	case 'n':
>  	case 'N':
> +	case 'f':
> +	case 'F':
>  	case '0':
>  		*res = false;
>  		return 0;
> -- 
> 2.35.1
> 

-- 
With Best Regards,
Andy Shevchenko


