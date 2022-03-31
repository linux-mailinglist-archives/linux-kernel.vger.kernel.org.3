Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008FB4EE066
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 20:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbiCaS3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 14:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbiCaS3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 14:29:19 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2B113E85;
        Thu, 31 Mar 2022 11:27:30 -0700 (PDT)
Received: from [IPV6:2a00:5f00:102:0:10b3:10ff:fe5d:4ec1] (unknown [IPv6:2a00:5f00:102:0:10b3:10ff:fe5d:4ec1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id DB2721F470F3;
        Thu, 31 Mar 2022 19:27:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648751249;
        bh=uP7q/xYsT32zx3bzbweG0t9nZq+UAL3kQqtb4RqJLm8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Pvdo9fWIRW4W+gzpHQiwinvhXLCRyAC1ZPTm5yM2woYZMseQ7vo4JNJmwR796bUjh
         HSAJcrJ5+PpFcwE83BAgE5NctvFxx6okVEh6E4tiA8jlbE4O/nUCc3sgMw61Iu/lHE
         q0L+/W2EOOCjdle1t11TZzFYqp0mx8QRfe2npCwt6C7pymmtTF/CHPxZVWqBF/7cP1
         5BSPqivxVGrip5/vffd9looqQiB4Bfllg/+HMmXLfv7ERgJYtxArrZmgY/D7ynIw+e
         cpNEXdAcygH+288NqW5YJFa3i3fKyVvWGz657DWYO7IrAUFA8iK0y3SLdkkkhttXz2
         0ahKTKkrU/YOQ==
Message-ID: <83979c7b-8a8a-5006-6af3-f3ca8b0d8ced@collabora.com>
Date:   Thu, 31 Mar 2022 21:27:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 07/10] drm/msm/gem: Rework vma lookup and pin
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
References: <20220330204804.660819-1-robdclark@gmail.com>
 <20220330204804.660819-8-robdclark@gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220330204804.660819-8-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/22 23:47, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Combines duplicate vma lookup in the get_and_pin path.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/msm_gem.c | 50 ++++++++++++++++++-----------------
>  1 file changed, 26 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index deafae6feaa8..218744a490a4 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -376,39 +376,40 @@ put_iova_vmas(struct drm_gem_object *obj)
>  	}
>  }
>  
> -static int get_iova_locked(struct drm_gem_object *obj,
> -		struct msm_gem_address_space *aspace, uint64_t *iova,
> +static struct msm_gem_vma *get_vma_locked(struct drm_gem_object *obj,
> +		struct msm_gem_address_space *aspace,
>  		u64 range_start, u64 range_end)
>  {
>  	struct msm_gem_vma *vma;
> -	int ret = 0;
>  
>  	GEM_WARN_ON(!msm_gem_is_locked(obj));
>  
>  	vma = lookup_vma(obj, aspace);
>  
>  	if (!vma) {
> +		int ret;
> +
>  		vma = add_vma(obj, aspace);
>  		if (IS_ERR(vma))
> -			return PTR_ERR(vma);
> +			return vma;
>  
>  		ret = msm_gem_init_vma(aspace, vma, obj->size,
>  			range_start, range_end);
>  		if (ret) {
You're allocation range_start -> range_end


>  			del_vma(vma);
> -			return ret;
> +			return ERR_PTR(ret);
>  		}
> +	} else {
> +		GEM_WARN_ON(vma->iova < range_start);
> +		GEM_WARN_ON((vma->iova + obj->size) > range_end);

and then comparing range_start -> range_start + obj->size, hence you're
assuming that range_end always equals to obj->size during the allocation.

I'm not sure what is the idea here.. this looks inconsistent. I think
you wanted to write:

		GEM_WARN_ON(vma->iova < range_start);
		GEM_WARN_ON(vma->iova + (vma->node.size << PAGE_SHIFT) > range_end);

But is it really useful to check whether the new range is inside of the
old range? Shouldn't it be always a error to change the IOVA range
without reallocating vma?

I'd expect to see:

		GEM_WARN_ON(vma->iova != range_start);
		GEM_WARN_ON(vma->iova + (vma->node.size << PAGE_SHIFT) != range_end);

and then error out if range mismatches.
