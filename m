Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECE9466ECE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237968AbhLCAzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbhLCAzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:55:53 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64084C06174A;
        Thu,  2 Dec 2021 16:52:30 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id k4so1394090pgb.8;
        Thu, 02 Dec 2021 16:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KcgckVJBk609C9n8WlYPxKWxBCCyIgqINt/uZGi6A0Y=;
        b=Ctf7ofl9Xke/PvNfOa+Vrw+j8ZBmzqUrFn63JewI2pdb1XRMsZgcYJ6ssqVhQpeDjA
         ya/eT9D/t9b86F/AArvhA/u4vb7Q466qgo9KzGmBFPZijZkkoSob/z+47kRcGLqgoLcX
         bsKy2XDc+XW2Z3hJyPDbt5ekMsag8vEQ2CepLHEGWHzbT4FUP8ejDg9HntELO6U/kHXv
         0lfZVQR7cTvYiPYD9S0BPTPNA7HKN4I5EniGd53Riw/4BkWX0Rzro4VxzMSJ2yNh1zWV
         Ss04cFrELxmFNzr+xgR2eQO2siyrMfdD3g7WfN8Jk6hkDnUt2W+67yQTSa55mAdVQ+Wq
         eSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KcgckVJBk609C9n8WlYPxKWxBCCyIgqINt/uZGi6A0Y=;
        b=EVLha84H23tWr5XtmEvHBREgXMfFIiowzXozBrc2j64U60xK/dFEYOdeQJ5u5c8htH
         Bk+3UeN8vyQgMmKkKDV7togqu60D/uBXzgD6cswPZ4prr7j9ErjJRkJQNs0X7Ve9mZk1
         LMOxGMnRUvgp49fthwhGslaXQ5UC5ASd/pClocUfMhvclOvBfDwyZfZZs5aeRWKfUO+w
         bc4EzgU/od2yurE2dQzsZJmyasOr1T52Dx7nhKYi7LihFaVnXCvjrpW4Mo6Jdvvkp3hd
         r6eYvvkVjsHE2weaqyeku/u5/Au1yXUQy62zwgJGtKoZIcoLfFnxXWjVtLYN7NrhnDYl
         ljiQ==
X-Gm-Message-State: AOAM532exG8ThJcBTM7je0AFQL5NmZ8MBV7wqRYzNVpwdMk+Ann+APYT
        F/+ZkDRGzz5V4soKNYJYMVM=
X-Google-Smtp-Source: ABdhPJy0wAKaq2tyZW6eEKVEZ01mPalVC9neiDt4H5evhXCCzzA5axCTHMxBIQfQZL4+VtxXQMlS3g==
X-Received: by 2002:a05:6a00:15ca:b0:49f:d22b:afff with SMTP id o10-20020a056a0015ca00b0049fd22bafffmr15996509pfu.35.1638492749937;
        Thu, 02 Dec 2021 16:52:29 -0800 (PST)
Received: from localhost ([103.99.179.247])
        by smtp.gmail.com with ESMTPSA id h26sm652480pgm.68.2021.12.02.16.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 16:52:29 -0800 (PST)
Date:   Fri, 3 Dec 2021 08:52:24 +0800
From:   Calvin Zhang <calvinzhang.cool@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH] mm: kmemleak: Ignore kmemleak scanning on CMA regions
Message-ID: <YalqSC0FdhEMpCQH@debian>
References: <20211126024711.54937-1-calvinzhang.cool@gmail.com>
 <20211127160718.54e82aa93c977a367404a9e3@linux-foundation.org>
 <YaLgfYzxFRVamvdI@debian>
 <YakMQA1A75ZADeHi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YakMQA1A75ZADeHi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 06:11:12PM +0000, Catalin Marinas wrote:
>On Sun, Nov 28, 2021 at 09:50:53AM +0800, Calvin Zhang wrote:
>> On Sat, Nov 27, 2021 at 04:07:18PM -0800, Andrew Morton wrote:
>> >On Fri, 26 Nov 2021 10:47:11 +0800 Calvin Zhang <calvinzhang.cool@gmail.com> wrote:
>> >> Just like this:
>> >> commit 620951e27457 ("mm/cma: make kmemleak ignore CMA regions").
>> >> 
>> >> Add kmemleak_ignore_phys() for CMA created from of reserved node.
>[...]
>> >The 620951e27457 changelog says "Without this, the kernel crashes...". 
>> >Does your patch also fix a crash?  If so under what circumstances and
>> >should we backport this fix into -stable kernels?
>> 
>> No crash occurred. 620951e27457 avoids crashes caused by accessing
>> highmem and it was fixed later. Now kmemleak_alloc_phys() and
>> kmemleak_ignore_phys() skip highmem. This patch is based on the
>> point that CMA regions don't contain pointers to other kmemleak
>> objects, and ignores CMA regions from reserved memory as what
>> 620951e27457 did.
>
>Note that kmemleak_ignore() only works if there was a prior
>kmemleak_alloc() on that address range. With the previous commit we get
>this via the memblock_alloc_range() but I fail to see one on the
>rmem_cma_setup() path.

rmem is from memblock_reserve() or early_init_dt_alloc_reserved_memory_arch()
kmemleak_alloc() is not called in the first case. And It's bad to add one.

I think all the reserved regions should be allocated from memblock without
kmemleak_alloc() and let rmem handler choose to add it as kmemleak object
by kmemleak_alloc(). Because MEMBLOCK_ALLOC_NOLEAKTRACE conflicts with range
parameter in memlbock_alloc_* series, all reserved regions and default CMA
region are allocated with kmemleak_alloc().

I think it's better to add memblock_alloc_* series a spearate flag paramter
(like "NOLEAKTRACE") instead of encoding MEMBLOCK_ALLOC_NOLEAKTRACE in `end`
parameter.

--
Calvin

