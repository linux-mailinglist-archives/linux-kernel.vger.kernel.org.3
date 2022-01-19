Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CB4493C94
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 16:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240248AbiASPFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 10:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355627AbiASPFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 10:05:23 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AA3C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:05:22 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id az27-20020a05600c601b00b0034d2956eb04so5980293wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=0odyDD4qZWEyKf4dgk5bsg3tKYSY9CGvoUStfcevylA=;
        b=KY4YCZwWueLtUID+/YuRziwAprnxroizrhhiLqgR+VJv0dvAqf6p/e/Z8+2hbD5td3
         M1RXz2Ulz5/UO405poQs0LC2mWECerbCYmm6/PclkyYapoYCKVCVsrH7+qHMc7mD7DNG
         yVv6KCpVaJQuyRwX173l73U/aTdl9LopqeRzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=0odyDD4qZWEyKf4dgk5bsg3tKYSY9CGvoUStfcevylA=;
        b=RkuDCglsVjcEBLNjHA7aXH53ijQqWm+awEYUL644VtemHj+Q+oLHPlrJ06gRs6oGp+
         tq4fuvnXRXKrBwjUahug8jzholY6cn4BW1pQYWqL/n+YXzE4tOsq/UiOXKO9oeMogzod
         epVXhiPUpRy8WDd1fpKZFlEUmijEC2ZMcKy45crg80o2R0cDqGCx2igIs+hYHZ6fQkxB
         N6EXJ2hqZMGJ0TBCoQ1I5MSlCSku0yVhvHfeg/2TKECQr65wkfI3K1crKjom/OPa/BG1
         zszhHx1YUv6+hmr1wDXKYiUsxNPGOOd2iRDivtO3tblJKXWJ+5sAcBujbdaqfUJrpuPV
         rhzQ==
X-Gm-Message-State: AOAM530GarK7JJg3p68l+yazTxpa8oAuMIR5dFxroS4E+P9yT0H20qYn
        lN1XmKdxdx/CZILO1e5JvWiM/A==
X-Google-Smtp-Source: ABdhPJxqxOTFLl5T1cf1q2Ex/gbOeL3/4WLRyt3JAUtwMEe4sBmurRyS45VDAxAFnc6SDjv5q4TcRQ==
X-Received: by 2002:adf:fec2:: with SMTP id q2mr29547534wrs.546.1642604721320;
        Wed, 19 Jan 2022 07:05:21 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id g17sm7645503wmq.9.2022.01.19.07.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 07:05:20 -0800 (PST)
Date:   Wed, 19 Jan 2022 16:05:18 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Weizhao Ouyang <o451686892@gmail.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@kernel.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>, christian.koenig@amd.com,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org
Subject: Re: [PATCH] dma-buf: cma_heap: Fix mutex locking section
Message-ID: <YegormDmEewox0MF@phenom.ffwll.local>
Mail-Followup-To: Weizhao Ouyang <o451686892@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>, Laura Abbott <labbott@kernel.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>, christian.koenig@amd.com,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org
References: <20220104073545.124244-1-o451686892@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104073545.124244-1-o451686892@gmail.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 03:35:45PM +0800, Weizhao Ouyang wrote:
> Fix cma_heap_buffer mutex locking critical section to protect vmap_cnt
> and vaddr.
> 
> Fixes: a5d2d29e24be ("dma-buf: heaps: Move heap-helper logic into the cma_heap implementation")
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> ---
>  drivers/dma-buf/heaps/cma_heap.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
> index 0c05b79870f9..83f02bd51dda 100644
> --- a/drivers/dma-buf/heaps/cma_heap.c
> +++ b/drivers/dma-buf/heaps/cma_heap.c
> @@ -124,10 +124,11 @@ static int cma_heap_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
>  	struct cma_heap_buffer *buffer = dmabuf->priv;
>  	struct dma_heap_attachment *a;
>  
> +	mutex_lock(&buffer->lock);
> +
>  	if (buffer->vmap_cnt)
>  		invalidate_kernel_vmap_range(buffer->vaddr, buffer->len);

Since this creates nesting with mm/, but optionally I think it'd be good
to prime lockdep so it knows about this. See e.g. dma_resv_lockdep() in
dma-resv.c, except I don't know offhand what the right lock for
invalidate_kernel_vmap_range is.
-Daniel


>  
> -	mutex_lock(&buffer->lock);
>  	list_for_each_entry(a, &buffer->attachments, list) {
>  		if (!a->mapped)
>  			continue;
> @@ -144,10 +145,11 @@ static int cma_heap_dma_buf_end_cpu_access(struct dma_buf *dmabuf,
>  	struct cma_heap_buffer *buffer = dmabuf->priv;
>  	struct dma_heap_attachment *a;
>  
> +	mutex_lock(&buffer->lock);
> +
>  	if (buffer->vmap_cnt)
>  		flush_kernel_vmap_range(buffer->vaddr, buffer->len);
>  
> -	mutex_lock(&buffer->lock);
>  	list_for_each_entry(a, &buffer->attachments, list) {
>  		if (!a->mapped)
>  			continue;
> -- 
> 2.32.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
