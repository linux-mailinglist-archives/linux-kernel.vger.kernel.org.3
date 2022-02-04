Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD294A9FF6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 20:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbiBDTWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 14:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiBDTWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:22:44 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637E5C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 11:22:43 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id b22so5546451qkk.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 11:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5odN6rMwltUoUEaPnfnI/Lwo2lMwPdE9aw/xm4uKQro=;
        b=OQW1BNsJP3CX3IWKdckwO+Who2ZvMboyjVmT0ml0RenWk1xvYjkf0bhQMxcAfMVxES
         63cTYk1FlcVVeS30hxkAx0J+cAToUYOHJ6y2wroPP95irRjAbEHmOswbJBkVfTVpWNHp
         BPaTVoWNys9F115cJfEM2Z14ChvlNhcMDf1QIbkj7HBhsdqJhO7pfEezBSZZvJ57y4fd
         3TGNQGk9sI1j2hFZJF9m15H0GdtXkblQNdQ+k60O40pGbEW9ve4LXfTGO56qDhqrqFYs
         XGZJevT/nrvIjrjs0lOgAVexKzjJdvNDR3T2rg53j3Y+N4qYWdlShRmPWqjQchm6Oddh
         Flqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5odN6rMwltUoUEaPnfnI/Lwo2lMwPdE9aw/xm4uKQro=;
        b=o00JZ4TlTqRcWVJYqMLd4Meze831roFzfc1Km9Apb3w9O3JzX5X+evq2mIwNlyiW9F
         go683bIAWGFXHmLSvpXFpiGeQRaFsOkx+wuI0kOUHDXjKTTxWWQ4vJRf64Unfvo4DV5H
         hxiyvwRmFBuS5IS7H847dp3ZX0FIqEb21sezAPBDWAHcbcnDyGpx65R3yjQXPWjlqjJu
         Zz3njSmORWiRYYaVXC05aM08qmLS7Ob6VDaluzofP9XhUf2021yfQNxh+IJAxRRzzEz4
         QLOXliQI3f6gyEvwlM/wt7LWhvEHIPeumsA7eRsd6yI2uOGZbPKDUfchSm8iqPzler8K
         P0Cg==
X-Gm-Message-State: AOAM530R/DW7Zg9/iZqjpM+MKzgksD/l2T4plUI4yt2B1T3DOsv9TfAK
        z8niVr8igbSGyKkAcq2p+y39qA==
X-Google-Smtp-Source: ABdhPJxMbUuv4qndRwWDoPG9ugcKRGL0z1iH6EYEWqmFX7Qc4bhvV0UY4cEzZh5+fjnOD2+IirMukg==
X-Received: by 2002:a05:620a:4093:: with SMTP id f19mr378593qko.306.1644002562420;
        Fri, 04 Feb 2022 11:22:42 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id u17sm1551317qkp.90.2022.02.04.11.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 11:22:41 -0800 (PST)
Date:   Fri, 4 Feb 2022 14:22:40 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] memcg: add per-memcg total kernel memory stat
Message-ID: <Yf19ABluqVyNd5pI@cmpxchg.org>
References: <20220203193856.972500-1-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203193856.972500-1-yosryahmed@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 07:38:56PM +0000, Yosry Ahmed wrote:
> Currently memcg stats show several types of kernel memory:
> kernel stack, page tables, sock, vmalloc, and slab.
> However, there are other allocations with __GFP_ACCOUNT
> (or supersets such as GFP_KERNEL_ACCOUNT) that are not accounted
> in any of those stats, a few examples are:
> - various kvm allocations (e.g. allocated pages to create vcpus)
> - io_uring
> - tmp_page in pipes during pipe_write()
> - bpf ringbuffers
> - unix sockets
> 
> Keeping track of the total kernel memory is essential for the ease of
> migration from cgroup v1 to v2 as there are large discrepancies between
> v1's kmem.usage_in_bytes and the sum of the available kernel memory stats
> in v2. Adding separate memcg stats for all __GFP_ACCOUNT kernel
> allocations is an impractical maintenance burden as there a lot of those
> all over the kernel code, with more use cases likely to show up in the
> future.
> 
> Therefore, add a "kernel" memcg stat that is analogous to kmem
> page counter, with added benefits such as using rstat infrastructure
> which aggregates stats more efficiently. Additionally, this provides a
> lighter alternative in case the legacy kmem is deprecated in the future
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Reported-by: kernel test robot <lkp@intel.com>

Looks good, thanks Yosry!
