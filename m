Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2044D7192
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 00:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbiCLX3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 18:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbiCLX1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 18:27:48 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979D393991
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 15:26:24 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id g1so24026781ybe.4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 15:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vNx6s5KnOqjV7Tmfqf+dCQj5955OsQk4Bwz0LXPX7LA=;
        b=X+xmHlE/1nenrdIB0uJ20KSXJHeWvXUvb1BpZ9ptuVQi9xqy7+oPZ1c2bf4VTZTKkU
         qaWDXjdiFt94igAFkJ0X6u+UCtjZWhugqb5Xocox2E4xSKDhBnPsoXnzrWeas6Uqf8F5
         J9WnD5oCn0Z3njgyeWWbg4R5caMpl4YZ/5NjTPP/Y8yM6J26ibFA5Kje9u7bEsRwvG7T
         /dNh2fJN47sVp490RzgLd/D9jjXA72ihDoW/Ashok+4sjLm0dndW43IkSghIgeQX2fDX
         SL8N/DIBu9sC7mVXmgSZ024yIh2VzYM8B7b7FL2glw51PY9M8Pn6BF52CRzkTwu2y2H5
         bFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vNx6s5KnOqjV7Tmfqf+dCQj5955OsQk4Bwz0LXPX7LA=;
        b=GZH8ge9RobMLaB/XxTFoT8jkCaxq2cQbiLnGsDuXI8T6iOUtFaXUgzJ54LZh0KAHpL
         N2pYYP1r36yQrlA4Ep9dmDAnaIuyB9PLCzPqX4Z6wyx4WeIqLQ1siWzNyrijVchdJO8A
         7nJfZUtwiO5aiQwvC6I01F7Y0KljQ7g28k2tRAg4s3YSIOU+glb1mqdzspz9xVmxhykU
         hgUqWxSh7JjDE+pSRFbM/W/kSUbCG7QDnw08E7z/JhlugLtK5rwzv2r1G7NOZ2QR9Zn5
         IwigM7FWkCk5No8v+AytMQ1VVoOrPRI4H4z6EWnlxkmt7nBydLvah29Z+aA8/497OYVP
         p2UQ==
X-Gm-Message-State: AOAM533VQJHLaRH6CBT7FNgkvxn6Ar7LceEOLQ8qPAQAdkpAddrT0QS8
        eCp9s2WY8iTUSrTMe/gJvLbHCqjteZ9Xdk5KlH8E0g==
X-Google-Smtp-Source: ABdhPJzeMXGyyZv4j+lG96D740YNvnKxeU/9Wh8dXoGzwHH0Cd99LEMJVacYfGqtsAOoTBDb8Tk5G71QcqCmZygRGSc=
X-Received: by 2002:a25:d9c7:0:b0:628:be42:b671 with SMTP id
 q190-20020a25d9c7000000b00628be42b671mr12905465ybg.387.1647127583323; Sat, 12
 Mar 2022 15:26:23 -0800 (PST)
MIME-Version: 1.0
References: <20220312154321.GC1189@xsang-OptiPlex-9020> <15307f8a-c202-75d8-1361-dae0146df734@suse.cz>
In-Reply-To: <15307f8a-c202-75d8-1361-dae0146df734@suse.cz>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sat, 12 Mar 2022 15:26:12 -0800
Message-ID: <CANn89i+fM0k+=Qw0M0fso1f-Ya8--5+==gtcWqCpo=Gu-ca1Ow@mail.gmail.com>
Subject: Re: [mm/page_alloc] 8212a964ee: vm-scalability.throughput 30.5% improvement
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        0day robot <lkp@intel.com>, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        "Huang, Ying" <ying.huang@intel.com>,
        "Tang, Feng" <feng.tang@intel.com>, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com, Eric Dumazet <eric.dumazet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
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

On Sat, Mar 12, 2022 at 10:59 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 3/12/22 16:43, kernel test robot wrote:
> >
> >
> > Greeting,
> >
> > FYI, we noticed a 30.5% improvement of vm-scalability.throughput due to commit:
> >
> >
> > commit: 8212a964ee020471104e34dce7029dec33c218a9 ("Re: [PATCH v2] mm/page_alloc: call check_new_pages() while zone spinlock is not held")
> > url: https://github.com/0day-ci/linux/commits/Mel-Gorman/Re-PATCH-v2-mm-page_alloc-call-check_new_pages-while-zone-spinlock-is-not-held/20220309-203504
> > patch link: https://lore.kernel.org/lkml/20220309123245.GI15701@techsingularity.net
>
> Heh, that's weird. I would expect some improvement from Eric's patch,
> but this seems to be actually about Mel's "mm/page_alloc: check
> high-order pages for corruption during PCP operations" applied directly
> on 5.17-rc7 per the github url above. This was rather expected to make
> performance worse if anything, so maybe the improvement is due to some
> unexpected side-effect of different inlining decisions or cache alignment...
>

I doubt this has anything to do with inlining or cache alignment.

I am not familiar with the benchmark, but its name
(anon-w-rand-hugetlb) hints at hugetlb ?

After Mel fix, we go over 512 'struct page' to perform sanity checks,
thus loading into cpu caches the 512 cache lines.

This caching is done while no lock is held.

If after this huge page allocation some mm operation needs to access
these 512 struct pages,
while holding a lock, then sure, there is a huge gain.
