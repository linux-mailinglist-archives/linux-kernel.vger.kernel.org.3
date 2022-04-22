Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AF950BAF2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449063AbiDVPBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449038AbiDVPAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:00:55 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7BB5C850
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:58:01 -0700 (PDT)
Date:   Fri, 22 Apr 2022 07:57:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650639479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yEZOup7wIqy02BcMRZRLp0SLmo1/PuUKmg3Pv5TLqWU=;
        b=WHkWfFnH+LeK7AefEWpgMiNUthZIEAVwi34pOhXpZgLAsfbAUshBOSjW44ktWjfgmr9qlb
        m77QNLA+d3VxusEPkU6lzywI0GM71VIkGFiya+S7NV5AO6qD5qRQHOAUukHg7ZTjLXo80G
        SCRsdEQctQ2UbwtbKCi5CCF/15liqhE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Dave Chinner <dchinner@redhat.com>, linux-kernel@vger.kernel.org,
        Yang Shi <shy828301@gmail.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH v1 0/5] mm: introduce shrinker debugfs interface
Message-ID: <YmLCc/DiqJs0jFIX@carbon>
References: <20220422015853.748291-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422015853.748291-1-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 06:58:48PM -0700, Roman Gushchin wrote:
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
> this patchset introduces a /sys/kernel/debug/shrinker interface, to some extent
> similar to /sys/kernel/slab.
> 
> For each shrinker registered in the system a directory is created. The directory
> contains "count" and "scan" files, which allow to trigger count_objects()
> and scan_objects() callbacks. For memcg-aware and numa-aware shrinkers
> count_memcg, scan_memcg, count_node, scan_node, count_memcg_node
> and scan_memcg_node are additionally provided. They allow to get per-memcg
> and/or per-node object count and shrink only a specific memcg/node.
> 
> To make debugging more pleasant, the patchset also names all shrinkers,
> so that debugfs entries can have more meaningful names.
> 
> v1:
>   1) switched to debugfs, suggested by Mike, Andrew, Greg and others
>   2) switched to seq_file API for output, no PAGE_SIZE limit anymore, by Andrew
>   3) switched to down_read_killable(), suggested by Hillf
>   4) dropped stateful filtering and "freed" returning, by Kent

>   5) added docs, by Andrew

Not quite true, gonna add it and also a cgroup tree inspection tool
and send out v2.

Thanks!
