Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5285574C34
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238938AbiGNLfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238952AbiGNLez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:34:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEFF599FE;
        Thu, 14 Jul 2022 04:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657798494; x=1689334494;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UYKVusdjN3uJPbVd5bXgJk3qFGpE1Ln3ZbTd6vEktCY=;
  b=Bee0U2HyoRZ1PV0jpvSRseIab7mGt1Qg2JJKas6RuoXPiWUqyItZz4/9
   drs44hpAfmH7pyfWR8tRuyEiHbw/xcX1XHgt6xkT1WDq++N1n9W8Dvcei
   /VkecMoHnEjFQHMffPgYzthO4ZwIkRnio6+xKFBBHHQmuCd/rIRFVMrvV
   6xoPONRFPv2DISt+zJWK2+59oYtp3lB/HON0v3Hshv+BKQ1OD2yPWCYw9
   9xLXBTztUGdgAjiiZ5RhX8ZqY0rxt/EfNQlHTTxGAeB20D5i6NzAmn3yE
   nctx/+MKijEUwXPjOelbA7hGQIdk5IXAsgRtBnWJVUCxdrqAWzmzeK/Ct
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="347168181"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="347168181"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 04:34:42 -0700
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="722694140"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 04:34:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oBx76-001DCE-2h;
        Thu, 14 Jul 2022 14:34:36 +0300
Date:   Thu, 14 Jul 2022 14:34:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Luca Ellero <luca.ellero@brickedbrain.com>
Cc:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, u.kleine-koenig@pengutronix.de,
        mkl@pengutronix.de, miquel.raynal@bootlin.com, imre.deak@nokia.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ellero <l.ellero@asem.it>
Subject: Re: [PATCH 2/3] ads7846: always set last command to PWRDOWN
Message-ID: <Ys//TM5/JuvoEZMo@smile.fi.intel.com>
References: <20220714084319.107334-1-luca.ellero@brickedbrain.com>
 <20220714084319.107334-3-luca.ellero@brickedbrain.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714084319.107334-3-luca.ellero@brickedbrain.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 10:43:18AM +0200, Luca Ellero wrote:
> From: Luca Ellero <l.ellero@asem.it>
> 
> This was broken on controllers with 3 commands as ads7845.
> READ_Z1 was sent instead.

What is "This"? Please, make commit message more understandable by its own.
With that fixed,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Luca Ellero <l.ellero@asem.it>
> ---
>  drivers/input/touchscreen/ads7846.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index 24605c40d039..9e15cdf6faa0 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -1066,6 +1066,9 @@ static int ads7846_setup_spi_msg(struct ads7846 *ts,
>  		struct ads7846_buf_layout *l = &packet->l[cmd_idx];
>  		unsigned int max_count;
>  
> +		if (cmd_idx == packet->cmds - 1)
> +			cmd_idx = ADS7846_PWDOWN;
> +
>  		if (ads7846_cmd_need_settle(cmd_idx))
>  			max_count = packet->count + packet->count_skip;
>  		else
> @@ -1102,7 +1105,12 @@ static int ads7846_setup_spi_msg(struct ads7846 *ts,
>  
>  	for (cmd_idx = 0; cmd_idx < packet->cmds; cmd_idx++) {
>  		struct ads7846_buf_layout *l = &packet->l[cmd_idx];
> -		u8 cmd = ads7846_get_cmd(cmd_idx, vref);
> +		u8 cmd;
> +
> +		if (cmd_idx == packet->cmds - 1)
> +			cmd_idx = ADS7846_PWDOWN;
> +
> +		cmd = ads7846_get_cmd(cmd_idx, vref);
>  
>  		for (b = 0; b < l->count; b++)
>  			packet->tx[l->offset + b].cmd = cmd;
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


