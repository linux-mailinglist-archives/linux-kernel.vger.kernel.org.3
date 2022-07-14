Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588F3574C3F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238972AbiGNLfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238965AbiGNLfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:35:34 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B62599FE;
        Thu, 14 Jul 2022 04:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657798533; x=1689334533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DyXB1n5qWup8pCu/YKdjbcr2alBTXtII9082twyRCsM=;
  b=hDdb4nrQEOYt24tjOm6zXRRmcqoFWdkQv/27gmGsSw2RrfyZ3FAR0wCj
   nmf7/EBWvkhWJSXqRkNB70Uqkv+TdswYH8NXnE5UjZQX6UBqZ9G2ZxzqE
   8pf5+34k+5PQl2RlcHgByN3VhxzqqsQWSQ4rdzjnZqIi5gnGlGP0aBLhU
   06jiy6vPEd0uCqxFJm/xey/HlVfht8VwvgY8xoU7IeEGxUzKyaKggtQRu
   QXrwKr4inzAEd893ot42PcsP/nOqBEJhpdjNYEJbPVZs8k0ApNNiETEer
   a9HP3L+y24oVYVUmMhwKJxojRce9VnRiIXk2yK5jBJT5DZcKoHjaH6c6y
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="286229716"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="286229716"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 04:35:32 -0700
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="546233797"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 04:35:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oBx7u-001DCM-2S;
        Thu, 14 Jul 2022 14:35:26 +0300
Date:   Thu, 14 Jul 2022 14:35:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Luca Ellero <luca.ellero@brickedbrain.com>
Cc:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, u.kleine-koenig@pengutronix.de,
        mkl@pengutronix.de, miquel.raynal@bootlin.com, imre.deak@nokia.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ellero <l.ellero@asem.it>
Subject: Re: [PATCH 3/3] ads7846: don't check penirq immediately for 7845
Message-ID: <Ys//fqwvh9hjP0RZ@smile.fi.intel.com>
References: <20220714084319.107334-1-luca.ellero@brickedbrain.com>
 <20220714084319.107334-4-luca.ellero@brickedbrain.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714084319.107334-4-luca.ellero@brickedbrain.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 10:43:19AM +0200, Luca Ellero wrote:
> From: Luca Ellero <l.ellero@asem.it>
> 
> To discard false readings, one should use "ti,penirq-recheck-delay-usecs".
> Checking get_pendown_state() at the beginning, most of the time fails
> causing malfunctioning.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Luca Ellero <l.ellero@asem.it>
> ---
>  drivers/input/touchscreen/ads7846.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index 9e15cdf6faa0..122d3a13b7c5 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -843,14 +843,8 @@ static void ads7846_report_state(struct ads7846 *ts)
>  	if (x == MAX_12BIT)
>  		x = 0;
>  
> -	if (ts->model == 7843) {
> +	if (ts->model == 7843 || ts->model == 7845) {
>  		Rt = ts->pressure_max / 2;
> -	} else if (ts->model == 7845) {
> -		if (get_pendown_state(ts))
> -			Rt = ts->pressure_max / 2;
> -		else
> -			Rt = 0;
> -		dev_vdbg(&ts->spi->dev, "x/y: %d/%d, PD %d\n", x, y, Rt);
>  	} else if (likely(x && z1)) {
>  		/* compute touch pressure resistance using equation #2 */
>  		Rt = z2;
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


