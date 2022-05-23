Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28E7530759
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 03:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbiEWB56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 21:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbiEWB54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 21:57:56 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE1635877
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 18:57:55 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id p8so12385565pfh.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 18:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/FTTj1NCDuWlD3xBvsaMWUk8OJZgm6jQNAj/ji3CrYw=;
        b=ULbMxk+D5gUlKqXBT8EAAfV14LeGwJZXVgVIto+ijwXo5r3J2DmTZPzhqXWTK8ZWoC
         oa5nvyEwXwEVOWnPI6WVrfqKaZwlBOihsqID8ZMvp2KOr6SyHwKJXICwN30fELpQxYvy
         zPOFlcLLYt1+Lcp73F2W8lHvu5Dd6v8VrC7Vsxw/vQ/yjMXOuRIjYuml3yd2vPny3xQY
         suigjPKyQUIQmKJODzR4pOkmvuah15OcfsIe5gtj7kHO6atTbMVNXYgb4esHV0wsrFdf
         /0h8W6seoY8ZDVdlzLXLxrVGhImhi5IMfy+J1I9Lcy4lw4nbyuQCBb00lr3mByRnKEv0
         COVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/FTTj1NCDuWlD3xBvsaMWUk8OJZgm6jQNAj/ji3CrYw=;
        b=Qq01U3NaU2CC6qOhIytiBAVkqwVxFw3wnnD+C7YrmYP4QWj75vVku5ZPctam0uShb/
         zs3jOjUCwkYnc1vPRqwQmyVrdHkjEPn2bvUxVd/PY16o5mzuNvoacVZ6tFZ8PPoOa/6W
         trXDYtuo/EHwr1sH9LXFFwfDooQ16J2YVd8sNCZwQUiW5W0a01zY275FzAJBYbbdmpS/
         +NFclAJv2uCErP0Ko0WaafaAGtUW4VIgqLsUwW+wRq+/XEOaf4j8VUVqYIBG9f0/Ru1m
         HTgXeL3mRyVyRoGe1j2zhCy2tTJrRqQjdtdeuk2hZLJlFHwNcckE/Tiw9mr8H8HRA7A5
         bUzQ==
X-Gm-Message-State: AOAM530sDZb8efNr+oKxnvmJi6SgVIux0EDCAMFPPA2k2OdN4y0UZjTv
        trubRceiF+oLTzBmTd81NRBANdH9pn8=
X-Google-Smtp-Source: ABdhPJwPdopwEMr1sDFEcvl434H1/gGWo6/3BGHR4lVExvgZxKtdj4S7KnUGIvSL6f+EzLDCHmqhHw==
X-Received: by 2002:a05:6a00:1488:b0:510:4e64:fb80 with SMTP id v8-20020a056a00148800b005104e64fb80mr21461166pfu.58.1653271075440;
        Sun, 22 May 2022 18:57:55 -0700 (PDT)
Received: from [192.168.50.247] ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id u14-20020a62d44e000000b0050dc7628153sm5824491pfl.45.2022.05.22.18.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 18:57:55 -0700 (PDT)
Message-ID: <ea67fa6b-0fcd-4b59-861f-360e74a4d70a@gmail.com>
Date:   Mon, 23 May 2022 09:57:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] gpu: drm: fix possible memory leak in drm_addmap_core()
Content-Language: en-US
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220509054441.17282-1-hbh25y@gmail.com>
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <20220509054441.17282-1-hbh25y@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/9 13:44, Hangyu Hua wrote:
> map->handle need to be handled correctly when map->type is _DRM_SHM or
> _DRM_CONSISTENT just like map->type is _DRM_REGISTERS.
> 
> Fixes: 8d153f7107ff ("drm: update user token hashing and map handles")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>   drivers/gpu/drm/drm_bufs.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_bufs.c b/drivers/gpu/drm/drm_bufs.c
> index fcca21e8efac..2b3f504c5f9c 100644
> --- a/drivers/gpu/drm/drm_bufs.c
> +++ b/drivers/gpu/drm/drm_bufs.c
> @@ -344,6 +344,15 @@ static int drm_addmap_core(struct drm_device *dev, resource_size_t offset,
>   	if (!list) {
>   		if (map->type == _DRM_REGISTERS)
>   			iounmap(map->handle);
> +		else if (map->type == _DRM_SHM) {
> +			dev->sigdata.lock = dev->master->lock.hw_lock = NULL;
> +			vfree(map->handle);
> +		} else if (map->type == _DRM_CONSISTENT) {
> +			dma_free_coherent(dev->dev,
> +					  map->size,
> +					  map->handle,
> +					  map->offset);
> +		}
>   		kfree(map);
>   		return -EINVAL;
>   	}
> @@ -361,6 +370,15 @@ static int drm_addmap_core(struct drm_device *dev, resource_size_t offset,
>   	if (ret) {
>   		if (map->type == _DRM_REGISTERS)
>   			iounmap(map->handle);
> +		else if (map->type == _DRM_SHM) {
> +			dev->sigdata.lock = dev->master->lock.hw_lock = NULL;
> +			vfree(map->handle);
> +		} else if (map->type == _DRM_CONSISTENT) {
> +			dma_free_coherent(dev->dev,
> +					  map->size,
> +					  map->handle,
> +					  map->offset);
> +		}
>   		kfree(map);
>   		kfree(list);
>   		mutex_unlock(&dev->struct_mutex);

Gentel ping.
