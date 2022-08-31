Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74EB5A7A2F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiHaJ0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbiHaJ0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:26:13 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB93F4B0C1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 02:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661937964; x=1693473964;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=QVVOxa5CAKqbH+RerLVWhklDkj5aNGiQ5eBmUvlln6Q=;
  b=SSWqFoaLL45dBPi0uHzTUnjUiBdwYN/Z8/+x+va0NsVoHyjCvp2ohteX
   6WScd6b8QZMabOSHk0DrG3idUkLQ7FcNT8pOVdFB61iz5Ru6TTgzpBN3H
   lGrOSzIZty/cfyLY670U+3IGKb0PyrEkM0Ld1dZYH5VaYr/xRj7vVvLww
   x9eyZ8rPF8L+WG7tgf9mpgV24Jx6uDFuTEGgpSbtXQQOfu2NysD/N+QLi
   aWOtKT3GQb/MirPgm4kzrgQ13QpPKUTdfQsYZXSCx1MH3JOffuppqOJ3I
   0tNA8aCn5hvqd2ul9n6YoBOqai3XsZ0g3MQjhqswSzl3mjWNFbMjKupFh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="296195220"
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="296195220"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 02:26:04 -0700
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="673278171"
Received: from nprotaso-mobl1.ccr.corp.intel.com (HELO localhost) ([10.252.43.15])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 02:26:00 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     cgel.zte@gmail.com, airlied@linux.ie
Cc:     tzimmermann@suse.de, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Maxime Ripard <maxime@cerno.tech>,
        Thierry Reding <treding@nvidia.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH linux-next] drm/gem: Remove the unneeded result variable
In-Reply-To: <20220831033301.302121-1-ye.xingchen@zte.com.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220831033301.302121-1-ye.xingchen@zte.com.cn>
Date:   Wed, 31 Aug 2022 12:25:52 +0300
Message-ID: <8735dcepcv.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Aug 2022, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Return the value drm_gem_handle_delete() directly instead of storing it
> in another redundant variable.

Personally, I generally prefer keeping these types of variables, because
they make future changes on the code easier. For example, adding a new
call where you need to check the return value, or having to deal with
the error value right there. Or just adding ad hoc debug logging of the
return value.

Related, but not exactly the same, see commit b784c7707502
("coccinnelle: Remove ptr_ret script"). Adding Cc's from that commit for
input.

BR,
Jani.

> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/gpu/drm/drm_gem.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index ad068865ba20..3fa0deff3014 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -782,14 +782,11 @@ drm_gem_close_ioctl(struct drm_device *dev, void *data,
>  		    struct drm_file *file_priv)
>  {
>  	struct drm_gem_close *args = data;
> -	int ret;
>  
>  	if (!drm_core_check_feature(dev, DRIVER_GEM))
>  		return -EOPNOTSUPP;
>  
> -	ret = drm_gem_handle_delete(file_priv, args->handle);
> -
> -	return ret;
> +	return drm_gem_handle_delete(file_priv, args->handle);
>  }
>  
>  /**

-- 
Jani Nikula, Intel Open Source Graphics Center
