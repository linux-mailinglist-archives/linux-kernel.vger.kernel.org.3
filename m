Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CED497A1F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242109AbiAXIUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236174AbiAXIUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:20:00 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34790C06173D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 00:20:00 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id i187-20020a1c3bc4000000b0034d2ed1be2aso32154185wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 00:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c28QaxpAfuOEDq8LtprBB/owZVWinCLNDU++tnPYx8Y=;
        b=TOc2vC6Sez7B1OJIVhWGrBW+xzr1cTbg1+AY2tKmzzXEd1JTBeTnU5ks/NAzREDOPK
         m2OidHWrFQtHf/Lac6tDSZaqjyZUGQIwUuFaZ2RQpmJEcFPmUa/n+781xW0RWPX3ajqq
         nrrHUGXRWWcHmZgBMgQZrLAwPB0yyrZq2YWqKm779yZVIF9bvQoy7zXx5FwZAu7odzlP
         XM3Y2GfW53kSDAPompeMzMuUUYPZp+i29x+pwYqqvaLnbI6VaD1YGG1HaS/uwpso/aB3
         EJX0+25VLxPnV8AOsR+ad7Ay7vRFKi+LrfFcMPtr+l7zswHWyc/U+1m2ayUrU7SrracZ
         B1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c28QaxpAfuOEDq8LtprBB/owZVWinCLNDU++tnPYx8Y=;
        b=Te/bBVACTTR6VAjEutMSH9kmEjSb15p0voJqa/BCk4GcFvkN8KkC7vFwJSCC6xXHdr
         6dHHZlO/X41B44dXUVR21AK1YIr2WcmudVRYa4/AtXLqwTb/kvqjQSIcZBqRDwpvpmXN
         +cNXBD5GBsBqEefxnkhFrvebVMLOUWM8la/vIZYZ6+DWF0VhNCUALFYD1cV8pfO3RBCJ
         WaAuzkTKSjBjKdTsrkhrrKlgGw4r7Ku8eiXdghhim7jLVPVwGuVfgZBW8uPi+3nHUlqB
         cRGHYmQF+is9rlIEi51Pt3bHqdAIn6gQlju1b6g+Mu7BtjPVzP3MCgXle+lqtV+Lqvo8
         EZmQ==
X-Gm-Message-State: AOAM531XPG1twy/epJu+iCpGyhcsUDCMysd1g7/Hse6I+Ov3JfbSM5Ny
        YF54PFrCC39Uq8YbCaodrZcQnQ==
X-Google-Smtp-Source: ABdhPJx4Pm2pD/O9ccohPZOobd6EDqFPWxBIGeLe+BNc/cqIvHMM7/KeZIO+u+4h+Wqp6jGjKjUAWg==
X-Received: by 2002:a1c:3b08:: with SMTP id i8mr768071wma.52.1643012398399;
        Mon, 24 Jan 2022 00:19:58 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:810c:fb1:faa0:df2])
        by smtp.gmail.com with ESMTPSA id m5sm2460444wrs.22.2022.01.24.00.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 00:19:57 -0800 (PST)
Date:   Mon, 24 Jan 2022 09:19:52 +0100
From:   Marco Elver <elver@google.com>
To:     Peng Liu <liupeng256@huawei.com>
Cc:     glider@google.com, dvyukov@google.com, corbet@lwn.net,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        akpm@linux-foundation.org, kasan-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org
Subject: Re: [PATCH RFC 1/3] kfence: Add a module parameter to adjust kfence
 objects
Message-ID: <Ye5hKItk3j7arjaI@elver.google.com>
References: <20220124025205.329752-1-liupeng256@huawei.com>
 <20220124025205.329752-2-liupeng256@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124025205.329752-2-liupeng256@huawei.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 02:52AM +0000, Peng Liu wrote:
> KFENCE is designed to be enabled in production kernels, but it can
> be also useful in some debug situations. For machines with limited
> memory and CPU resources, KASAN is really hard to run. Fortunately,

If these are arm64 based machines, see if CONFIG_KASAN_SW_TAGS works for
you. In future, we believe that CONFIG_KASAN_HW_TAGS will be suitable
for a variety of scenarios, including debugging scenarios of resource
constrained environments.

> KFENCE can be a suitable candidate. For KFENCE running on a single
> machine, the possibility of discovering existed bugs will increase
> as the increasing of KFENCE objects, but this will cost more memory.
> In order to balance the possibility of discovering existed bugs and
> memory cost, KFENCE objects need to be adjusted according to memory
> resources for a compiled kernel Image. Add a module parameter to
> adjust KFENCE objects will make kfence to use in different machines
> with the same kernel Image.
> 
> In short, the following reasons motivate us to add this parameter.
> 1) In some debug situations, this will make kfence flexible.
> 2) For some production machines with different memory and CPU size,
> this will reduce the kernel-Image-version burden.
[...]
> This patch (of 3):

[ Note for future: No need to add "This patch (of X)" usually -- this is
  added by maintainers if deemed appropriate, and usually includes the
  cover letter. ]

> The most important motivation of this patch series is to make
> KFENCE easy-to-use in business situations.
> 
> Signed-off-by: Peng Liu <liupeng256@huawei.com>
> ---
>  Documentation/dev-tools/kfence.rst |  14 ++--
>  include/linux/kfence.h             |   3 +-
>  mm/kfence/core.c                   | 108 ++++++++++++++++++++++++-----
>  mm/kfence/kfence.h                 |   2 +-
>  mm/kfence/kfence_test.c            |   2 +-
>  5 files changed, 103 insertions(+), 26 deletions(-)
[...]  
> diff --git a/include/linux/kfence.h b/include/linux/kfence.h
> index 4b5e3679a72c..aec4f6b247b5 100644
> --- a/include/linux/kfence.h
> +++ b/include/linux/kfence.h
> @@ -17,12 +17,13 @@
>  #include <linux/atomic.h>
>  #include <linux/static_key.h>
>  
> +extern unsigned long kfence_num_objects;
>  /*
>   * We allocate an even number of pages, as it simplifies calculations to map
>   * address to metadata indices; effectively, the very first page serves as an
>   * extended guard page, but otherwise has no special purpose.
>   */
> -#define KFENCE_POOL_SIZE ((CONFIG_KFENCE_NUM_OBJECTS + 1) * 2 * PAGE_SIZE)
> +#define KFENCE_POOL_SIZE ((kfence_num_objects + 1) * 2 * PAGE_SIZE)
>  extern char *__kfence_pool;

I appreciate the effort, but you could have gotten a quicker answer if
you had first sent us an email to ask why adjustable number of objects
hasn't been done before. Because if it was trivial, we would have
already done it.

What you've done is turned KFENCE_POOL_SIZE into a function instead of a
constant (it still being ALL_CAPS is now also misleading).

This is important here:

	/**
	 * is_kfence_address() - check if an address belongs to KFENCE pool
	 * @addr: address to check
	 *
	 * Return: true or false depending on whether the address is within the KFENCE
	 * object range.
	 *
	 * KFENCE objects live in a separate page range and are not to be intermixed
	 * with regular heap objects (e.g. KFENCE objects must never be added to the
	 * allocator freelists). Failing to do so may and will result in heap
	 * corruptions, therefore is_kfence_address() must be used to check whether
	 * an object requires specific handling.
	 *
	 * Note: This function may be used in fast-paths, and is performance critical.
	 * Future changes should take this into account; for instance, we want to avoid
	 * introducing another load and therefore need to keep KFENCE_POOL_SIZE a
	 * constant (until immediate patching support is added to the kernel).
	 */
	static __always_inline bool is_kfence_address(const void *addr)
	{
		/*
		 * The __kfence_pool != NULL check is required to deal with the case
		 * where __kfence_pool == NULL && addr < KFENCE_POOL_SIZE. Keep it in
		 * the slow-path after the range-check!
		 */
		return unlikely((unsigned long)((char *)addr - __kfence_pool) < KFENCE_POOL_SIZE && __kfence_pool);
	}

Unfortunately I think you missed the "Note".

Which means that ultimately your patch adds another LOAD to the fast
path, which is not an acceptable trade-off.

This would mean your change would require benchmarking, but it'd also
mean we and everyone else would have to re-benchmark _all_ systems where
we've deployed KFENCE.

I think the only reasonable way forward is if you add immediate patching
support to the kernel as the "Note" suggests.

In the meantime, while not a single kernel imagine, we've found that
debug scenarios usually are best served with a custom debug kernel, as
there are other debug features that are only Kconfig configurable. Thus,
having a special debug kernel just configure KFENCE differently
shouldn't be an issue in the majority of cases.

Should this answer not be satisfying for you, the recently added feature
skipping already covered allocations (configurable via
kfence.skip_covered_thresh) alleviates some of the issue of a smaller
pool with a very low sample interval (viz. high sample rate).

The main thing to watch out for is KFENCE's actual sample rate vs
intended sample rate (per kfence.sample_interval). If you monitor
/sys/kernel/debug/kfence/stats, you can compute the actual sample rate.
If the actual sample rate becomes significantly lower than the intended
rate, only then does it make sense to increase the pool size. My
suggestion for you is therefore to run some experiments, while adjusting
kfence.sample_interval and kfence.skip_covered_thresh until you reach a
sample rate that is close to intended.

Thanks,
-- Marco
