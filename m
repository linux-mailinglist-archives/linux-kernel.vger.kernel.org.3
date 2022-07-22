Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7E557E1B7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 14:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbiGVM4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 08:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiGVM4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 08:56:12 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCF18C751
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 05:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658494569; x=1690030569;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9+dXXFg3dVNO+F5OFKMuAstg6hlbJQ2O+VxxMLytHfc=;
  b=bWWW/gT8u9SLGWjN0ocYoDuYkIrNXVwf7u0SFR2gSaQbS8woc5zf6sxN
   NKxoBG2ImtlPG6NG5SMLK6JaZ1YkCJQCDHEZe5f+pX4VTRiu3o4zaCjC9
   Ng23Sv/kwj2if5C4zcZ+ARyOoDCBdnwsdIURsj63eDtI3GvdzljwX9M+s
   0SBoOs6ob9MftD8S9yxRUZyUcCR4Yvy0R6yDqy0d3MuIA7BFnVT+JqwWD
   TX5UnFh5T0LYUdV5i1zGssK3mxNj2hVUH0ZFuPr/9TILEa1zh30HrNnD6
   XjVDlIu6kTQKASCWlMITFYuB5OIzcYW8c4CL3JwmuVAwsn7EISyzIYRB6
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="286068551"
X-IronPort-AV: E=Sophos;i="5.93,185,1654585200"; 
   d="scan'208";a="286068551"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 05:56:08 -0700
X-IronPort-AV: E=Sophos;i="5.93,185,1654585200"; 
   d="scan'208";a="574160416"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.22.123]) ([10.213.22.123])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 05:56:05 -0700
Message-ID: <6bb802aa-20d1-eb19-6946-66b8978c3699@intel.com>
Date:   Fri, 22 Jul 2022 14:56:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Use dev_err_probe() to avoid
 polluting the log
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Erico Nunes <ernunes@redhat.com>,
        Enric Balletbo i Serra <eballetbo@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Douglas Anderson <dianders@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel@lists.freedesktop.org
References: <20220722074755.660258-1-javierm@redhat.com>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20220722074755.660258-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.07.2022 09:47, Javier Martinez Canillas wrote:
> If devm_drm_of_get_bridge() can't find the connected bridge, it returns an
> ERR_PTR(-EPROBE_DEFER) to indicate that the probe should be deferred.
>
> But this path also prints an error message, which pollutes the kernel log
> since is printed on every probe deferral, i.e:
>
>    $ dmesg | grep "failed to create panel bridge" | wc -l
>    38
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>

Regards
Andrzej

> ---
>
>   drivers/gpu/drm/bridge/ti-sn65dsi86.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index 369bf72717f6..90bbabde1595 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -1206,10 +1206,9 @@ static int ti_sn_bridge_probe(struct auxiliary_device *adev,
>   	int ret;
>   
>   	pdata->next_bridge = devm_drm_of_get_bridge(pdata->dev, np, 1, 0);
> -	if (IS_ERR(pdata->next_bridge)) {
> -		DRM_ERROR("failed to create panel bridge\n");
> -		return PTR_ERR(pdata->next_bridge);
> -	}
> +	if (IS_ERR(pdata->next_bridge))
> +		return dev_err_probe(pdata->dev, PTR_ERR(pdata->next_bridge),
> +				     "failed to create panel bridge\n");
>   
>   	ti_sn_bridge_parse_lanes(pdata, np);
>   

