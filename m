Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E47452DAFD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242447AbiESRPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiESRPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:15:13 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61DC42A25
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:15:11 -0700 (PDT)
Date:   Thu, 19 May 2022 10:15:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652980510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XfoNuzmTm649aI5ONkoIpBGqUyVi4ImAhh5x2MDNA7A=;
        b=tbkH+5zeXm2NWvS6AkLQyXTqBthWWsx1EaknpKWCyUBbV43CW1+8lycyML1yFJ91XZW8f1
        H6EANgEli+mveLHPxCTqhukZZhV6oU6y8L2H+DMtLc3KIf3dFEy7LwOrQmdMUp1+6OEpM9
        vQDYh4WsO4H5V5BbrY26xZqYvcZ9vPs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Dave Chinner <dchinner@redhat.com>, linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v3 0/6] mm: introduce shrinker debugfs interface
Message-ID: <YoZ7GA9cjQiylEP7@carbon>
References: <20220509183820.573666-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509183820.573666-1-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 11:38:14AM -0700, Roman Gushchin wrote:
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
> block's shrinker it is having only "super_cache_scan").
> 
> To provide a better visibility and debug options for memory shrinkers
> this patchset introduces a /sys/kernel/debug/shrinker interface, to some extent
> similar to /sys/kernel/slab.
> 
> For each shrinker registered in the system a directory is created.
> As now, the directory will contain only a "scan" file, which allows to get
> the number of managed objects for each memory cgroup (for memcg-aware shrinkers)
> and each numa node (for numa-aware shrinkers on a numa machine). Other
> interfaces might be added in the future.
> 
> To make debugging more pleasant, the patchset also names all shrinkers,
> so that debugfs entries can have meaningful names.
> 
> 
> v3:
>   1) separated the "scan" part into a separate patch, by Dave
>   2) merged *_memcg, *_node and *_memcg_node interfaces, by Dave
>   3) shrinkers naming enhancements, by Christophe and Dave
>   4) added signal_pending() check, by Hillf
>   5) enabled by default, by Dave

Any comments? Thoughts? Objections?

Thanks!
