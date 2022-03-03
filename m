Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3E74CB9DE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 10:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbiCCJKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 04:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiCCJK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:10:28 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5144838F;
        Thu,  3 Mar 2022 01:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646298583; x=1677834583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OnJVXfIxBJCa2zbcrSYYMyJc+X5r5JG+8hWCDRkOLX0=;
  b=DyB2HCw1TdJiosFY3th3V8aO4DyRqwkBHVcMpmRzJSKBYBQI/WqL42nc
   V3ON20WBDpGn0rDsTD9WT5lDpWcclnPAW1xtizsZXv4GjuSe8C+ofH6m6
   N88dyXUKOxQR6DGOllU1vcfXGsfWtjhJwNFt3J7y/OIrEm1QqVfmBjieA
   I/7paPIM0PbzGGaWc14fMMomyhhEcJGGcKNgL1ycfGe+Hwxev3IsfLWTR
   I3/+FsO5smdO4CXTy4CfGvFBmMp8Qg85sUqWZjjhjMs0b8/nPVYJFMEBp
   +v0I1bm4uM219WEeGQAcy3hxTB9j7tHAzGViFpdkYmUjpJjOOMiJBDPtv
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="233586762"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="233586762"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 01:09:42 -0800
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="535747413"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 01:09:39 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 3B1C320090;
        Thu,  3 Mar 2022 11:09:37 +0200 (EET)
Date:   Thu, 3 Mar 2022 11:09:37 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Kate Hsuan <hpa@redhat.com>
Cc:     Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, hdegoede@redhat.com
Subject: Re: [PATCH 1/1] staging: media: ipu3: Fix AF x_start position when
 rightmost stripe is used
Message-ID: <YiCF0Ze+mPxYQ2NP@paasikivi.fi.intel.com>
References: <20220223090648.41989-1-hpa@redhat.com>
 <20220223090648.41989-2-hpa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223090648.41989-2-hpa@redhat.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kate,

Thank you for the patch.

On Wed, Feb 23, 2022 at 05:06:48PM +0800, Kate Hsuan wrote:
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
> Signed-off-by: Kate Hsuan <hpa@redhat.com>
> ---
>  drivers/staging/media/ipu3/ipu3-css-params.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/ipu3/ipu3-css-params.c b/drivers/staging/media/ipu3/ipu3-css-params.c
> index d9e3c3785075..efe4de8ef205 100644
> --- a/drivers/staging/media/ipu3/ipu3-css-params.c
> +++ b/drivers/staging/media/ipu3/ipu3-css-params.c
> @@ -2556,6 +2556,14 @@ int imgu_css_cfg_acc(struct imgu_css *css, unsigned int pipe,
>  		/* Enable only for rightmost stripe, disable left */
>  		acc->af.stripes[0].grid_cfg.y_start &=
>  			~IPU3_UAPI_GRID_Y_START_EN;
> +		acc->af.stripes[0].grid_cfg.x_start -=
> +			acc->stripe.down_scaled_stripes[1].offset;
> +		acc->af.stripes[0].grid_cfg.x_end -=
> +			acc->stripe.down_scaled_stripes[1].offset;
> +		acc->af.stripes[1].grid_cfg.x_start -=
> +			acc->stripe.down_scaled_stripes[1].offset;
> +		acc->af.stripes[1].grid_cfg.x_end -=
> +			acc->stripe.down_scaled_stripes[1].offset;

The grid x/y ends are calculated from the width when both grids are enabled
and I think it should work the same way here. There's also masking of the
bits that aren't in use.

The first stripe isn't enabled so changing values there has no effect as
far as I can tell.

Looking at the code a little, it seems all awb_fr, ae and af seem to suffer
from the same issue. Let's still iron out the fix for af first before
considering those.

>  	} else if (acc->af.config.grid_cfg.x_end <=
>  		   acc->stripe.bds_out_stripes[0].width - min_overlap) {
>  		/* Enable only for leftmost stripe, disable right */
> @@ -2563,7 +2571,6 @@ int imgu_css_cfg_acc(struct imgu_css *css, unsigned int pipe,
>  			~IPU3_UAPI_GRID_Y_START_EN;
>  	} else {
>  		/* Enable for both stripes */
> -
>  		acc->af.stripes[0].grid_cfg.width =
>  			(acc->stripe.bds_out_stripes[0].width - min_overlap -
>  			 acc->af.config.grid_cfg.x_start + 1) >>

-- 
Kind regards,

Sakari Ailus
