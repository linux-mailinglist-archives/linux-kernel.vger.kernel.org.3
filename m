Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E174DAD1B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 10:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354773AbiCPJDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 05:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354743AbiCPJD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 05:03:26 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA39C6517F;
        Wed, 16 Mar 2022 02:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647421332; x=1678957332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LOX9uW5s+vqsnfBIseHFWmznTuk/lp2t/LhmcHS4Clg=;
  b=L3f9jcWAMi7EKvLCFeukcjvvnUlASAFwO3EkUpEytSqLAaleiKy75d9J
   VYAAl9vpHkWmDmro9Twx27cfvfymdnS4uHslUVJvAVLSciETx4D0yOGar
   aoBZbbrORkEYWsYAgFzAH8ScC4dR6y+XIL3LJWH/4mQrKq0mowuCL0USg
   6XG4ne8wk6Wcamfnk9Je2pMsoUc6jzr7qgH9Zki6Dh7w38rIcUzhMEEYa
   7Hc72t6ULhOACPVNW7oXTAOiB6X/4bC2s8L7HcjnUoCh7yUCqFsP2Hy7t
   kHj1JpoqNgmqhiqDZH49g/Gc1sk4Zz3MRL5BRL1+0KLcxLzfobATvxj4c
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="243982621"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="243982621"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 02:02:12 -0700
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="783392162"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 02:02:08 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id BBFB5201B6;
        Wed, 16 Mar 2022 11:01:36 +0200 (EET)
Date:   Wed, 16 Mar 2022 11:01:36 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Kate Hsuan <hpa@redhat.com>
Cc:     Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, hdegoede@redhat.com
Subject: Re: [PATCH v3 1/2] staging: media: ipu3: Fix AF x_start position
 when rightmost stripe is used
Message-ID: <YjGncJFYky69Fjmz@paasikivi.fi.intel.com>
References: <20220314101523.129672-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314101523.129672-1-hpa@redhat.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kate,

On Mon, Mar 14, 2022 at 06:15:22PM +0800, Kate Hsuan wrote:
> For the AF configuration, if the rightmost stripe is used, the AF scene
> will be at the incorrect location of the sensor.
> 
> The AF coordinate may be set to the right part of the sensor. This
> configuration would lead to x_start being greater than the
> down_scaled_stripes offset and the leftmost stripe would be disabled
> and only the rightmost stripe is used to control the AF coordinate. If
> the x_start doesn't perform any adjustments, the AF coordinate will be
> at the wrong place of the sensor since down_scaled_stripes offset
> would be the new zero of the coordinate system.
> 
> In this patch, if only the rightmost stripe is used, x_start should
> minus down_scaled_stripes offset to maintain its correctness of AF
> scene coordinate.
> 
> Changes in v2:
> 1. Remove the setting of the first stripe.
> 
> Signed-off-by: Kate Hsuan <hpa@redhat.com>
> ---
>  drivers/staging/media/ipu3/ipu3-css-params.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/staging/media/ipu3/ipu3-css-params.c b/drivers/staging/media/ipu3/ipu3-css-params.c
> index d9e3c3785075..5a8c07f34756 100644
> --- a/drivers/staging/media/ipu3/ipu3-css-params.c
> +++ b/drivers/staging/media/ipu3/ipu3-css-params.c
> @@ -2556,6 +2556,10 @@ int imgu_css_cfg_acc(struct imgu_css *css, unsigned int pipe,
>  		/* Enable only for rightmost stripe, disable left */
>  		acc->af.stripes[0].grid_cfg.y_start &=
>  			~IPU3_UAPI_GRID_Y_START_EN;
> +		acc->af.stripes[1].grid_cfg.x_start -=
> +			acc->stripe.down_scaled_stripes[1].offset;
> +		acc->af.stripes[1].grid_cfg.x_end -=
> +			acc->stripe.down_scaled_stripes[1].offset;

Could you calculate the values the same way as for the two stripes case, as
I've been asking since v1?

>  	} else if (acc->af.config.grid_cfg.x_end <=
>  		   acc->stripe.bds_out_stripes[0].width - min_overlap) {
>  		/* Enable only for leftmost stripe, disable right */

-- 
Regards,

Sakari Ailus
