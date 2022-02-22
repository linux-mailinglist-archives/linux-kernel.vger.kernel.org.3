Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C0D4BFEDA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbiBVQft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbiBVQfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:35:33 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3928816E7F2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:34:21 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id ba20so452541qvb.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2pjjU5zHuaxPJTKda8Jl5cHbMT8Mpw2hlMIdhnjkMTk=;
        b=xGdwdrTr+PVvzHmGxLrfQ8lZ1kFry5pJlG+CnWsag0DswuSZIeyEJpz9s5RTAavQQd
         d6d4Qe4t9ZeAC7AFQU2sIR6mt2d7E7657obKwwHSJP6BuMjaO1FuHA6jQBD2lEIMP/gv
         KWZqSycsAvowxw65Xn0Dn0V5DCyKALHG/EZd5xEQQoryFGjVorGfD/ABH/tXbwpkfswg
         VV7v03mSPCry5prSzvSCax4BA9XE6685uHcyRNqhwZR1DouitIV6urZ1WCK0Xn56Nc1T
         C99SqVsj/ySVfrZrFFqyiU+cRnnsSfglQm9IiTElvkGSUPEWJT4EqD6/hXY3K381DYqI
         u3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2pjjU5zHuaxPJTKda8Jl5cHbMT8Mpw2hlMIdhnjkMTk=;
        b=rthBsAY1Y8dOmtUwbbt2K20nzpb774IZHBEG/jDGiBXyPVBhG+h1dauH9JpXOzgKFY
         vdtUkIRdh8pjJ99yB3foFS2BfLZQPJvopdU/PpyRpg9hbS316vDjCCroC925EM+p17OI
         cYlwzoxVAnf/dhPHSJqtp336+zlWQJaHdg3mAZRcyjo0PaRR3Mpoc1STRNgbV/xO5BAu
         pIlpM/Sf4e8XFgGvWqk3n0/R2JkdVX+eP+0mHAFK65wixfBDvNq//TBc6DZP+UR3eH98
         q45RSRRGEeaMOQRwtAJttQqwC92j66Pbd934rCTzu/pNDOX3bxX/K/cK0n4UAPBwcn4I
         TfxQ==
X-Gm-Message-State: AOAM530x7pTaWGFQ3IWx4f6FE81vPewy43TjArJgZC2d6232lNvFKisZ
        93FjqhZ1zHTePRvxqUx68Ky0tQ==
X-Google-Smtp-Source: ABdhPJyYjQ0swClJ5D1OlmgUW4KG7J4LAiCCD+RMaflR2hpgwXvv9ZP/fApy7yxOrmcfJJYlWwgziw==
X-Received: by 2002:a05:622a:2c4:b0:2dd:2d86:3fe9 with SMTP id a4-20020a05622a02c400b002dd2d863fe9mr22824519qtx.624.1645547656242;
        Tue, 22 Feb 2022 08:34:16 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id x17sm35291qtr.69.2022.02.22.08.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 08:34:15 -0800 (PST)
Date:   Tue, 22 Feb 2022 11:34:15 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Feng Tang <feng.tang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH -V13 2/3] NUMA balancing: optimize page placement for
 memory tiering system
Message-ID: <YhUQh3DKpKeFqiXL@cmpxchg.org>
References: <20220221084529.1052339-1-ying.huang@intel.com>
 <20220221084529.1052339-3-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221084529.1052339-3-ying.huang@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 04:45:28PM +0800, Huang Ying wrote:
> With the advent of various new memory types, some machines will have
> multiple types of memory, e.g. DRAM and PMEM (persistent memory).  The
> memory subsystem of these machines can be called memory tiering
> system, because the performance of the different types of memory are
> usually different.
> 
> In such system, because of the memory accessing pattern changing etc,
> some pages in the slow memory may become hot globally.  So in this
> patch, the NUMA balancing mechanism is enhanced to optimize the page
> placement among the different memory types according to hot/cold
> dynamically.
> 
> In a typical memory tiering system, there are CPUs, fast memory and
> slow memory in each physical NUMA node.  The CPUs and the fast memory
> will be put in one logical node (called fast memory node), while the
> slow memory will be put in another (faked) logical node (called slow
> memory node).  That is, the fast memory is regarded as local while the
> slow memory is regarded as remote.  So it's possible for the recently
> accessed pages in the slow memory node to be promoted to the fast
> memory node via the existing NUMA balancing mechanism.
> 
> The original NUMA balancing mechanism will stop to migrate pages if
> the free memory of the target node becomes below the high watermark.
> This is a reasonable policy if there's only one memory type.  But this
> makes the original NUMA balancing mechanism almost do not work to
> optimize page placement among different memory types.  Details are as
> follows.
> 
> It's the common cases that the working-set size of the workload is
> larger than the size of the fast memory nodes.  Otherwise, it's
> unnecessary to use the slow memory at all.  So, there are almost
> always no enough free pages in the fast memory nodes, so that the
> globally hot pages in the slow memory node cannot be promoted to the
> fast memory node.  To solve the issue, we have 2 choices as follows,
> 
> a. Ignore the free pages watermark checking when promoting hot pages
>    from the slow memory node to the fast memory node.  This will
>    create some memory pressure in the fast memory node, thus trigger
>    the memory reclaiming.  So that, the cold pages in the fast memory
>    node will be demoted to the slow memory node.
> 
> b. Make kswapd of the fast memory node to reclaim pages until the free
>    pages are a little more than the high watermark (named as promo
>    watermark).  Then, if the free pages of the fast memory node reaches
>    high watermark, and some hot pages need to be promoted, kswapd of the
>    fast memory node will be waken up to demote more cold pages in the
>    fast memory node to the slow memory node.  This will free some extra
>    space in the fast memory node, so the hot pages in the slow memory
>    node can be promoted to the fast memory node.
> 
> The choice "a" may create high memory pressure in the fast memory
> node.  If the memory pressure of the workload is high, the memory
> pressure may become so high that the memory allocation latency of the
> workload is influenced, e.g. the direct reclaiming may be triggered.
> 
> The choice "b" works much better at this aspect.  If the memory
> pressure of the workload is high, the hot pages promotion will stop
> earlier because its allocation watermark is higher than that of the
> normal memory allocation.  So in this patch, choice "b" is
> implemented.  A new zone watermark (WMARK_PROMO) is added.  Which is
> larger than the high watermark and can be controlled via
> watermark_scale_factor.
> 
> In addition to the original page placement optimization among sockets,
> the NUMA balancing mechanism is extended to be used to optimize page
> placement according to hot/cold among different memory types.  So the
> sysctl user space interface (numa_balancing) is extended in a backward
> compatible way as follow, so that the users can enable/disable these
> functionality individually.
> 
> The sysctl is converted from a Boolean value to a bits field.  The
> definition of the flags is,
> 
> - 0: NUMA_BALANCING_DISABLED
> - 1: NUMA_BALANCING_NORMAL
> - 2: NUMA_BALANCING_MEMORY_TIERING
> 
> We have tested the patch with the pmbench memory accessing benchmark
> with the 80:20 read/write ratio and the Gauss access address
> distribution on a 2 socket Intel server with Optane DC Persistent
> Memory Model.  The test results shows that the pmbench score can
> improve up to 95.9%.
> 
> Thanks Andrew Morton to help fix the document format error.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org

Looks good to me,

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
