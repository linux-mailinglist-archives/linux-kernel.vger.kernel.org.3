Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7FE52E99B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 12:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348033AbiETKJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 06:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348025AbiETKJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 06:09:07 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B2CDE30B
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 03:09:05 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n6-20020a05600c3b8600b0039492b44ce7so4070537wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 03:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2CPVeVY4qdJoTLOZfRTk2rSUnY1KMS5MbsQ8/Hgrd+w=;
        b=oIoFyFouf7ftBKUDUWiBpXNbka+ahkLFi5oXe4Tz0H+aZazK6/Oq+MARZE63IZ2Lqg
         HrlC09a1/lojg6HSseBHtp7++bWAUMADyGICFWcXPB70Ba/qMxVCHNuEDYyREPXK09Eb
         iMZC/GO6Ee5DtrLvI49nepP9sUTedG+qho73UpEZXhG4YuPlLEKim9vMAOS+orELVLI1
         fEInsTTLqGzUsY8xkQIwew5ahsE4hOHjaCIv0PgyGzTCh8jb4ZDYWUzLhmiEw4IcVjP/
         jqVrDJCh4T5AZ6ZivhhgxOu0NaCQAqTwonIzJOKK1wlK/gCf5DMPaEFBDa1k0NWBPZv7
         qn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2CPVeVY4qdJoTLOZfRTk2rSUnY1KMS5MbsQ8/Hgrd+w=;
        b=LdH1aMARoYP08IdCBrBmTQadd7xl9uwMNedrprO7nntPbpr9RUZXTUe8iQULgw7VMR
         7SEyKlsfgVcIbJlsxYSae5Qg+9/O8GPSDOmMtn86Ed5twijWtA1Q7ZvHgk1FHL7HCtDe
         s0waSK2RGXlqdLGADoA9pMa5L82bdQxg+gJRuQnStWApff7iVwdATyiUS6qY8ntID+Ux
         sGIp8Mg0ZQRGlsduUQ2remlszr7nnMhQCxq6LGdCBssyulwf15vNJpRZZRGM3h1mFSdv
         ju19ZmqJnF+ss38rr3l+dmNNB6UaljM7uJjbV2oFdCoRzk34ot7res0xuA9oKy9A007E
         zQ+g==
X-Gm-Message-State: AOAM530rQZ/VZ/fqjnjpZ3Z6DiHP8VEkaAAhgpcYzH7BReC75d3r/MTF
        BZq72tGxIO3N0p7yraemtmjAaA==
X-Google-Smtp-Source: ABdhPJzLd/eA2CYC2y5nNLjrjT9MIpioYwS82PuvIPnbCSI3FgMUvoPjkpAUs58F1BBsMJbFYOPIhA==
X-Received: by 2002:a05:600c:3b06:b0:397:3d4f:9846 with SMTP id m6-20020a05600c3b0600b003973d4f9846mr404320wms.40.1653041344046;
        Fri, 20 May 2022 03:09:04 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:bae2:f132:a26:fae2])
        by smtp.gmail.com with ESMTPSA id o8-20020a1c7508000000b003942a244f2fsm1673578wmc.8.2022.05.20.03.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 03:09:03 -0700 (PDT)
Date:   Fri, 20 May 2022 12:08:57 +0200
From:   Marco Elver <elver@google.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, paulmck@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 1/2] Documentation/barriers: Add memory barrier
 dma_mb()
Message-ID: <YodouVpl26890QfU@elver.google.com>
References: <20220520031548.175582-1-wangkefeng.wang@huawei.com>
 <20220520031548.175582-2-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520031548.175582-2-wangkefeng.wang@huawei.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 11:15AM +0800, Kefeng Wang wrote:
> The memory barrier dma_mb() is introduced by commit a76a37777f2c
> ("iommu/arm-smmu-v3: Ensure queue is read after updating prod pointer"),
> which is used to ensure that prior (both reads and writes) accesses to
> memory by a CPU are ordered w.r.t. a subsequent MMIO write.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  Documentation/memory-barriers.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index b12df9137e1c..1eabcc0e4eca 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -1894,10 +1894,13 @@ There are some more advanced barrier functions:
>  
>   (*) dma_wmb();
>   (*) dma_rmb();
> + (*) dma_mb();
>  
>       These are for use with consistent memory to guarantee the ordering
>       of writes or reads of shared memory accessible to both the CPU and a
> -     DMA capable device.
> +     DMA capable device, in the case of ensure the prior (both reads and
> +     writes) accesses to memory by a CPU are ordered w.r.t. a subsequent
> +     MMIO write, dma_mb().
>  

I think this is out of place; this explanation here is not yet
elaborating on either. Elaboration on dma_mb() should go where
dma_rmb() and dma_wmb() are explained. 

Something like this:

------ >8 ------

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index b12df9137e1c..fb322b6cce70 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1894,6 +1894,7 @@ There are some more advanced barrier functions:
 
  (*) dma_wmb();
  (*) dma_rmb();
+ (*) dma_mb();
 
      These are for use with consistent memory to guarantee the ordering
      of writes or reads of shared memory accessible to both the CPU and a
@@ -1925,11 +1926,11 @@ There are some more advanced barrier functions:
      The dma_rmb() allows us guarantee the device has released ownership
      before we read the data from the descriptor, and the dma_wmb() allows
      us to guarantee the data is written to the descriptor before the device
-     can see it now has ownership.  Note that, when using writel(), a prior
-     wmb() is not needed to guarantee that the cache coherent memory writes
-     have completed before writing to the MMIO region.  The cheaper
-     writel_relaxed() does not provide this guarantee and must not be used
-     here.
+     can see it now has ownership.  The dma_mb() implies both a dma_rmb() and a
+     dma_wmb().  Note that, when using writel(), a prior wmb() is not needed to
+     guarantee that the cache coherent memory writes have completed before
+     writing to the MMIO region.  The cheaper writel_relaxed() does not provide
+     this guarantee and must not be used here.
 
      See the subsection "Kernel I/O barrier effects" for more information on
      relaxed I/O accessors and the Documentation/core-api/dma-api.rst file for

------ >8 ------

Also, now that you're making dma_mb() part of the official API, it might
need a generic definition in include/asm-generic/barrier.h, because
as-is it's only available in arm64 builds.

Thoughts?

Thanks,
-- Marco
