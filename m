Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11AB506330
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 06:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348215AbiDSE34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 00:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiDSE3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 00:29:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F89424F1A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 21:27:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2714B81125
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E07C385A7;
        Tue, 19 Apr 2022 04:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1650342430;
        bh=U87XC1YEsD2BTQUvV8SJzW0Xi6JkPFRYfotP8FuYOXs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dQrCWZVZ3Vj91DG/8XP28ubGi1QZkqEtifxM67rP1rMkDDavcGrXSeD13dXoMjkCK
         9LCptanc9Zpeo+Citnuucwe7rxFq133eT7rW/lrq3LfuIITwvVKLvtA9UaM1R/CLwR
         pWV7yBj+dkh+iKMYd7gAigkWbqNTd2z7bOqz3uB0=
Date:   Mon, 18 Apr 2022 21:27:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH rfc 0/5] mm: introduce shrinker sysfs interface
Message-Id: <20220418212709.42f2ba15e00999bb57086b27@linux-foundation.org>
In-Reply-To: <20220416002756.4087977-1-roman.gushchin@linux.dev>
References: <20220416002756.4087977-1-roman.gushchin@linux.dev>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2022 17:27:51 -0700 Roman Gushchin <roman.gushchin@linux.dev> wrote:

> There are 50+ different shrinkers in the kernel, many with their own bells and
> whistles. Under the memory pressure the kernel applies some pressure on each of
> them in the order of which they were created/registered in the system. Some
> of them can contain only few objects, some can be quite large. Some can be
> effective at reclaiming memory, some not.
> 
> The only existing debugging mechanism is a couple of tracepoints in
> do_shrink_slab(): mm_shrink_slab_start and mm_shrink_slab_end. They aren't
> covering everything though: shrinkers which report 0 objects will never show up,
> there is no support for memcg-aware shrinkers. Shrinkers are identified by their
> scan function, which is not always enough (e.g. hard to guess which super
> block's shrinker it is having only "super_cache_scan"). They are a passive
> mechanism: there is no way to call into counting and scanning of an individual
> shrinker and profile it.
> 
> To provide a better visibility and debug options for memory shrinkers
> this patchset introduces a /sys/kernel/shrinker interface, to some extent
> similar to /sys/kernel/slab.
> 
> For each shrinker registered in the system a folder is created.

Please, "directory".

> The folder
> contains "count" and "scan" files, which allow to trigger count_objects()
> and scan_objects() callbacks. For memcg-aware and numa-aware shrinkers
> count_memcg, scan_memcg, count_node, scan_node, count_memcg_node
> and scan_memcg_node are additionally provided. They allow to get per-memcg
> and/or per-node object count and shrink only a specific memcg/node.
> 
> To make debugging more pleasant, the patchset also names all shrinkers,
> so that sysfs entries can have more meaningful names.

I also was wondering "why not debugfs".

> Usage examples:
> 
> ...
>
> If the output doesn't fit into a single page, "...\n" is printed at the end of
> output.

Unclear.  At the end of what output?

> 
> Roman Gushchin (5):
>   mm: introduce sysfs interface for debugging kernel shrinker
>   mm: memcontrol: introduce mem_cgroup_ino() and
>     mem_cgroup_get_from_ino()
>   mm: introduce memcg interfaces for shrinker sysfs
>   mm: introduce numa interfaces for shrinker sysfs
>   mm: provide shrinkers with names
> 
>  arch/x86/kvm/mmu/mmu.c                        |   2 +-
>  ...
>

Nothing under Documentation/!
