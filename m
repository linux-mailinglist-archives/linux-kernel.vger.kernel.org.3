Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E714ABEEE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448783AbiBGNM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443097AbiBGMWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 07:22:06 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB147C03C1AD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 04:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644236190; x=1675772190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1vCj/FFG9pSnPF/Iv806R/ZlY0+1L2qMpTxrhPDp3JE=;
  b=QI70Pxkd2c1uAnspQUMZl9vc4Ttdppz7zfKumBp1OCApKOomP1ACgQ1i
   aRI+4O9s0DPtpLkjtMoOQsOyGwnh/CREdnBY7VULlVmefDRyLefPbtE3j
   j+5SqvxWiAyMATlUFNil2PlKascZm7KuskZDBGGm7qOycrQq4Sl9ZIYvd
   P0iU+WERKIWqZZqx6TkBil3nnyuOPXzptp6GmULuQ9BE7a3QRNSY2go1N
   rzvaNODKOega7e7QePYgRzkmf80bmCx0wJQjEI4PMswiLBO3TW/d2gw2r
   PQ0tFFt2Uzk84TICyKSQmj8tZB0Ur0qYcNP0WOKc5xEfvOuxIvNOHvdz/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="248914436"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="248914436"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 04:16:30 -0800
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="700444170"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 04:16:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nH2va-001tWE-7Y;
        Mon, 07 Feb 2022 14:15:30 +0200
Date:   Mon, 7 Feb 2022 14:15:29 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     andy@kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] lib/test_string.c: return -ENOMEM on memset16_selftest
 allocation failure
Message-ID: <YgENYYPT2gs7sX8H@smile.fi.intel.com>
References: <20220207103626.103256-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207103626.103256-1-jiapeng.chong@linux.alibaba.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 06:36:26PM +0800, Jiapeng Chong wrote:
> Clean up the following smatch warning:
> 
> lib/test_string.c:14 memset16_selftest() warn: returning -1 instead of
> -ENOMEM is sloppy.

It's not that makes much difference, but fine
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  lib/test_string.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/test_string.c b/lib/test_string.c
> index 9dfd6f52de92..f23d6cd2d9c7 100644
> --- a/lib/test_string.c
> +++ b/lib/test_string.c
> @@ -11,7 +11,7 @@ static __init int memset16_selftest(void)
>  
>  	p = kmalloc(256 * 2 * 2, GFP_KERNEL);
>  	if (!p)
> -		return -1;
> +		return -ENOMEM;
>  
>  	for (i = 0; i < 256; i++) {
>  		for (j = 0; j < 256; j++) {
> -- 
> 2.20.1.7.g153144c
> 

-- 
With Best Regards,
Andy Shevchenko


