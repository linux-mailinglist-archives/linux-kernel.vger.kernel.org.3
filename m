Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A284D149B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345802AbiCHKUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbiCHKUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:20:07 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A4A220CC;
        Tue,  8 Mar 2022 02:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646734752; x=1678270752;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xF+r8ZNHE9MnTYvem0p9ys5ZewguArXpAyRAIBUOibg=;
  b=gbxd0BHe7egBhvGThrY4pWKsomySijg1/8zyPjQfF1kvpsxJ133ijzHm
   C6gyHHy8CRWneM8d0/q4fEtOludxJ7gHuKdXiOS5YUg9Os8SLMxjz6uPe
   JQwkWUQEdZZaIYN8hY5/LpZucu8an5gnslj/HpH9YxOjJIhsIAIjRSKCa
   H10kVa7VAGciCjqtEoL2hM2ETasfjZA2iaHcsVD+3nUyYgw/f516ZKVTZ
   v7mSZ4cOKf38HK3WglgEiWKnVzqXMMlFuWBc1yjboh+Hd8T/xEcl6TbFa
   TaTdyBWNDqY1dBvhn7OcYJK0iwcXCjwDSelGWLqnfQ/Zm1xMka21eVUBd
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="254839270"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="254839270"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 02:19:11 -0800
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="643608952"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 02:19:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nRWvB-00DIEg-BO;
        Tue, 08 Mar 2022 12:18:25 +0200
Date:   Tue, 8 Mar 2022 12:18:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v1 1/1] staging: fbtft: Consider type of init sequence
 values in fbtft_init_display()
Message-ID: <Yictcf0BCvveVT+V@smile.fi.intel.com>
References: <20220304193414.88006-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304193414.88006-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Helge

Maybe you can pick this up?

On Fri, Mar 04, 2022 at 09:34:14PM +0200, Andy Shevchenko wrote:
> In the fbtft_init_display() the init sequence is printed for
> the debug purposes. Unfortunately the current code doesn't take
> into account that values in the buffer are of the s16 type.
> 
> Consider that and replace the printing code with fbtft_par_dbg_hex()
> call.
> 
> Fixes: b888897014a9 ("staging/fbtft: Remove all strcpy() uses")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/staging/fbtft/fbtft-core.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
> index 4a35347b3020..b28a059ad3b4 100644
> --- a/drivers/staging/fbtft/fbtft-core.c
> +++ b/drivers/staging/fbtft/fbtft-core.c
> @@ -1035,10 +1035,9 @@ int fbtft_init_display(struct fbtft_par *par)
>  			for (j = 0; par->init_sequence[i + 1 + j] >= 0; j++)
>  				;
>  
> -			fbtft_par_dbg(DEBUG_INIT_DISPLAY, par,
> -				      "init: write(0x%02X) %*ph\n",
> -				      par->init_sequence[i], j,
> -				      &par->init_sequence[i + 1]);
> +			fbtft_par_dbg_hex(DEBUG_INIT_DISPLAY, par, par->info->device,
> +					  s16, &par->init_sequence[i + 1], j,
> +					  "init: write(0x%02X)", par->init_sequence[i]);
>  
>  			/* Write */
>  			j = 0;
> -- 
> 2.34.1
> 

-- 
With Best Regards,
Andy Shevchenko


