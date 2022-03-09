Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6F54D366D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbiCIRLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237035AbiCIRKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:10:44 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D5ABBE1A;
        Wed,  9 Mar 2022 09:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646845367; x=1678381367;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OkzOLsVy4bRJDx790ntahgYsXuWH4OdPbeR3N+MAs4w=;
  b=fNzBSjolukK7hTgIQpar7fJde2+1hgaW+Eq9cgM+URzYcTzzO20qL332
   cjnLjJwbnbSRHMWxIo4ltXApZPFTuba1tqe/xagVGYcPmiK7CZLJIhmKm
   uFfViolQ09MQME5mRPdp9NYLNffNS7bcvqFq0gVqo7LdaHTnrL1rV6NQF
   jsMZjV2OIJNkVXrS7a8YOlwkdKRTPXyiGQ8Pfw77V8IeJrbwFGg3v8+tp
   5zGJjTaFBZZzIHM51UpNEpVmQa9GNvGMPBI33oQR4gyYjtH6GII8ZvZk9
   A6SsTIr5j1fKzokTd59ewMyHDm5CozeVTE1+0YplR3SSZsn1I0h8XZE+v
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="254761940"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="254761940"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 08:50:42 -0800
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="644096964"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 08:50:39 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 711152051A;
        Wed,  9 Mar 2022 18:50:37 +0200 (EET)
Date:   Wed, 9 Mar 2022 18:50:37 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Kate Hsuan <hpa@redhat.com>
Cc:     Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, hdegoede@redhat.com
Subject: Re: [PATCH v2] staging: media: ipu3: Fix AF x_start position when
 rightmost stripe is used
Message-ID: <Yija3YQ55gvCtKdR@paasikivi.fi.intel.com>
References: <20220309063456.102895-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309063456.102895-1-hpa@redhat.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kate,

Thanks for the update.

On Wed, Mar 09, 2022 at 02:34:56PM +0800, Kate Hsuan wrote:
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

Could you calculate these the same way as in the case both stripes are
enabled? Some bits in x_start is masked and then x_end is calculated from
width.

>  	} else if (acc->af.config.grid_cfg.x_end <=
>  		   acc->stripe.bds_out_stripes[0].width - min_overlap) {
>  		/* Enable only for leftmost stripe, disable right */

-- 
Regards,

Sakari Ailus
