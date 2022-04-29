Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EF651404D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 03:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353988AbiD2Bmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 21:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235461AbiD2Bmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 21:42:38 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E19CBF330
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 18:39:21 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id t13so5384989pgn.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 18:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=rhA4aZUdRaNgOqnDVV3QzhoT8n++/dGWzUM62LHJQpE=;
        b=YpVVxkFOvaBfZTwyNXGDo+Gr0q/zc/izFhnZ0kSp0xp8DXzHB1Vhz7HEg5yEGk9Lup
         YqVJ4Jji5VQN5ToQuduIiSWpyfgRp6q35jcBRVqCZY3MH2VDrToKXurUtMP4CYo+4RYp
         tClatmIUqEuTphALX0jOQfN2TYYniHEJgKhchMNvxSVy/i8/gaRrMRVsXsm2pKmFYLWm
         fEUru6dQJKSiDwjpDi2qICmSJQVmhUptUFoTMpv7QIYHzgiIGIiOJESnm0N2ZmWP3Q7U
         x9ZXWGbJYbb/xEYE+LAaSN88EKwKXGtQ94UV5TszGa4g/ZGZzb1+wInB5Ik/W5FmGjqS
         rluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rhA4aZUdRaNgOqnDVV3QzhoT8n++/dGWzUM62LHJQpE=;
        b=bGTExf0sIgFU1oi5PJmtIW68TbIItrTlE1k8CGrxq7ynSVOi1JrLxoKkz3kaj9kQoo
         1IvG+ND4fQmOYEG2FMsuVCVG3X8UmX66cLYIdghe16iQPRHXHDRZjEKIFOsLxTo3CVqE
         lJCyViC7K/ea35H4nQGIBycYiKC6h1iTtURGYXa8wjHlYSV4fxNUPt3Kvzw19LwoNcGx
         KgK+Y62rtoGJD6t0NmdWPHngMQmc1IyLt0hJROn6F70/FcY1J5Lq4hJOrJUdU7YP1Yat
         C4tognJz6dDDVmsvDxYoQlbhnmNx0icFiLCje18nlxAYpIvaHIv0JQIA3QcX0I//j+8A
         rpJA==
X-Gm-Message-State: AOAM531jQfmHkGQMRsp38Jktma+0yOLLeIH5B9crpQoMFnW7NehBK/Hy
        5Fx02rX/9FMow1iL0pRKEzNPdQ==
X-Google-Smtp-Source: ABdhPJyfoFDrOX4ugPpi20iiVdqc3EOn/QLxfQF3709bk7teLh0JelkDjqJXiA+CEkYSux7mQuRHXw==
X-Received: by 2002:a63:d145:0:b0:3c1:4ba0:d890 with SMTP id c5-20020a63d145000000b003c14ba0d890mr8385077pgj.607.1651196361096;
        Thu, 28 Apr 2022 18:39:21 -0700 (PDT)
Received: from [10.52.0.6] ([94.177.118.121])
        by smtp.gmail.com with ESMTPSA id k17-20020a628e11000000b0050d8d373331sm1021922pfe.214.2022.04.28.18.39.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 18:39:20 -0700 (PDT)
Subject: Re: [PATCH v2] iommu/sva: Fix PASID use-after-free issue
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org
References: <20220428180041.806809-1-fenghua.yu@intel.com>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <8f50c673-fe92-3c42-993d-43e65fc7235c@linaro.org>
Date:   Fri, 29 Apr 2022 09:39:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220428180041.806809-1-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/29 上午2:00, Fenghua Yu wrote:
> The PASID is being freed too early.  It needs to stay around until after
> device drivers that might be using it have had a chance to clear it out
> of the hardware.
>
> As a reminder:
>
> mmget() /mmput()  refcount the mm's address space
> mmgrab()/mmdrop() refcount the mm itself
>
> The PASID is currently tied to the life of the mm's address space and
> freed in __mmput().  This makes logical sense because the PASID can't be
> used once the address space is gone.
>
> But, this misses an important point: even after the address space is
> gone, the PASID will still be programmed into a device.  Device drivers
> might, for instance, still need to flush operations that are outstanding
> and need to use that PASID.  They do this at file->release() time.
>
> Device drivers call the IOMMU driver to hold a reference on the mm itself
> and drop it at file->release() time.  But, the IOMMU driver holds a
> reference on the mm itself, not the address space.  The address space
> (and the PASID) is long gone by the time the driver tries to clean up.
> This is effectively a use-after-free bug on the PASID.
>
> To fix this, move the PASID free operation from __mmput() to __mmdrop().
> This ensures that the IOMMU driver's existing mmgrab() keeps the PASID
> allocated until it drops its mm reference.
>
> Fixes: 701fac40384f ("iommu/sva: Assign a PASID to mm on PASID allocation and free it on mm exit")
>
> Reported-by: Zhangfei Gao <zhangfei.gao@foxmail.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@foxmail.com>

Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>

Use the formal email, thanks

> Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Suggested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>
> v2:
> - Dave Hansen rewrites the change log.
> - Add Tested-by: Zhangfei Gao <zhangfei.gao@foxmail.com>
> - Add Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>
> The original patch was posted and discussed in:
> https://lore.kernel.org/lkml/YmdzFFx7fN586jcf@fyu1.sc.intel.com/
>
>   kernel/fork.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 9796897560ab..35a3beff140b 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -792,6 +792,7 @@ void __mmdrop(struct mm_struct *mm)
>   	mmu_notifier_subscriptions_destroy(mm);
>   	check_mm(mm);
>   	put_user_ns(mm->user_ns);
> +	mm_pasid_drop(mm);
>   	free_mm(mm);
>   }
>   EXPORT_SYMBOL_GPL(__mmdrop);
> @@ -1190,7 +1191,6 @@ static inline void __mmput(struct mm_struct *mm)
>   	}
>   	if (mm->binfmt)
>   		module_put(mm->binfmt->module);
> -	mm_pasid_drop(mm);
>   	mmdrop(mm);
>   }
>   

