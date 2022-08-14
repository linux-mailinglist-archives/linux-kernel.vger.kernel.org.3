Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D295925C1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 19:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiHNROi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 13:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHNROg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 13:14:36 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CDA1BEB0;
        Sun, 14 Aug 2022 10:14:35 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r4so7019761edi.8;
        Sun, 14 Aug 2022 10:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=lcXhUSdXTZBEx8SZoP2wndcVuxf5BwHzU6Gjyckptts=;
        b=csWx3BhYGeVOyeUipPUq7Umiysxpgwd1x1SSSCUVIBiXp7sRSBvlv1PQmaRUK/pp1Q
         uziYUvtY4HkYzwGDIiwY/Thmr1T9BZ8kkxZ5zDDsD3pRr7BhbzvDebxpkyhCv3aNdaxP
         dk271AYRtadbRBBh+T780jeCgO9gW7sBllq3ixbctSKmvoEgGD9xhN9k16MXepM38VZa
         aAPE8ysiNZD4g8KS/BkziR4hu58afy4seLzQcx2OEYuEsP/Nh9zbmZl06eH9qJO673xM
         gqdRh+1FVeg0J+05bowFsiEB7khTokFp9WWLTs+SrMG4/ZPaoOATXSiIID5zoMZOSJ/0
         ukug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=lcXhUSdXTZBEx8SZoP2wndcVuxf5BwHzU6Gjyckptts=;
        b=6JwFhflWfoTZl2eOPR9FTVV3IlmXIaM+46eydrh41xFw0NsOBt1lc0sHlkCpOH9D5I
         IpuDxd/H97glgDZn6buKp2KFs9/HhzO/t/+EqnZ1i+u1dtc3nFkOD0ys8QeIyoPA41Uw
         sOVz9pybnML6i79FcLxh7qVD2UNbe/qU9/kvck5UdHPqRmAfnxCGq26ovHwC3GfLSPM2
         f3ttH8ude9l33fCwgBHDfeVIz+VKD7YZpkeNe/7bQFsBhxlWDppSdbD+roJLnQ2q3Dut
         e/ZGojVjMt3K7C4NdVZGC970H4vgdvIQ9qxf4qfOaIK23kh5PjuPrFQ3wW9TOUeQ431a
         sRPg==
X-Gm-Message-State: ACgBeo2hxXKuLqc9s0juR0ypVhnqEuSzgwTKFllQ1/JGsZWtJ59iG248
        4DDz56Lk1DBmTv+PgjzVrV4=
X-Google-Smtp-Source: AA6agR49F60BoKAAj3bxWs5EH7O5Rxjmmbzndw264ksH1sHE2A+sDjwmDCt7uWuElhxtIcwzeeRWmQ==
X-Received: by 2002:a05:6402:4282:b0:43e:612c:fcf7 with SMTP id g2-20020a056402428200b0043e612cfcf7mr11105056edc.242.1660497274265;
        Sun, 14 Aug 2022 10:14:34 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:fb92:e16e:a0f2:319d? ([2a02:908:1256:79a0:fb92:e16e:a0f2:319d])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090604c100b00730aa5f15cfsm3125754eja.63.2022.08.14.10.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Aug 2022 10:14:33 -0700 (PDT)
Message-ID: <ebb573b8-237f-602e-8d7d-9c49f0bd73be@gmail.com>
Date:   Sun, 14 Aug 2022 19:14:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amd/amdgpu: Replace kmap() with kmap_local_page()
Content-Language: en-US
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Nirmoy Das <nirmoy.das@amd.com>,
        Jonathan Kim <jonathan.kim@amd.com>,
        Philip Yang <Philip.Yang@amd.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Zack Rusin <zackr@vmware.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Cc:     Ira Weiny <ira.weiny@intel.com>
References: <20220812175753.22926-1-fmdefrancesco@gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220812175753.22926-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 12.08.22 um 19:57 schrieb Fabio M. De Francesco:
> kmap() is being deprecated in favor of kmap_local_page().
>
> There are two main problems with kmap(): (1) It comes with an overhead as
> mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when the
> kmap’s pool wraps and it might block when the mapping space is fully
> utilized until a slot becomes available.
>
> With kmap_local_page() the mappings are per thread, CPU local, can take
> page faults, and can be called from any context (including interrupts).
> It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> the tasks can be preempted and, when they are scheduled to run again, the
> kernel virtual addresses are restored and are still valid.
>
> Since its use in amdgpu/amdgpu_ttm.c is safe, it should be preferred.
>
> Therefore, replace kmap() with kmap_local_page() in amdgpu/amdgpu_ttm.c.
>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

For those two use cases that looks good to me. Feel free to add an 
Acked-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 3b4c19412625..c11657b5915f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2301,9 +2301,9 @@ static ssize_t amdgpu_iomem_read(struct file *f, char __user *buf,
>   		if (p->mapping != adev->mman.bdev.dev_mapping)
>   			return -EPERM;
>   
> -		ptr = kmap(p);
> +		ptr = kmap_local_page(p);
>   		r = copy_to_user(buf, ptr + off, bytes);
> -		kunmap(p);
> +		kunmap_local(ptr);
>   		if (r)
>   			return -EFAULT;
>   
> @@ -2352,9 +2352,9 @@ static ssize_t amdgpu_iomem_write(struct file *f, const char __user *buf,
>   		if (p->mapping != adev->mman.bdev.dev_mapping)
>   			return -EPERM;
>   
> -		ptr = kmap(p);
> +		ptr = kmap_local_page(p);
>   		r = copy_from_user(ptr + off, buf, bytes);
> -		kunmap(p);
> +		kunmap_local(ptr);
>   		if (r)
>   			return -EFAULT;
>   

