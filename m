Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDC35305C0
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 22:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349706AbiEVUKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 16:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiEVUJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 16:09:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE8F3632F
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 13:09:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 395CCB80D7A
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 20:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A73C385AA;
        Sun, 22 May 2022 20:09:45 +0000 (UTC)
Date:   Sun, 22 May 2022 16:09:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v4] tracing: add 'accounted' entry into output of
 allocation tracepoints
Message-ID: <20220522160943.5e5950e0@gandalf.local.home>
In-Reply-To: <1621d82a-439d-0657-2b7e-5e90c42c2087@openvz.org>
References: <0c73ce5c-3625-6187-820e-1277e168b3bc@openvz.org>
        <a1e54672-d824-3ee1-cb68-9ceaa46fc70f@openvz.org>
        <YomzXwN9rvCGAZJ0@n2.us-central1-a.c.spheric-algebra-350919.internal>
        <1621d82a-439d-0657-2b7e-5e90c42c2087@openvz.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 May 2022 07:33:08 +0300
Vasily Averin <vvs@openvz.org> wrote:

> > slab_flags=SLAB_RECLAIM_ACCOUNT|SLAB_ACCOUNT|SLAB_STORE_USER
> > instead of just printing 'accounted=true/false'. This patch is too
> > specific to SLAB_ACCOUNT.  
> 
> Any extra output degrades performance.
> For my task it's not important to know SLAB flags, I just need to understand,
> is current allocation accounted or not.

If you do save the flags in the event, you can report that on output with
the __print_flags() macro:

 TP_fast_assign(
	[..]
	__entry->sflags = s ? s->flags;
	[..]
 )
 TP_printk("... slab_flags=%s ..",
	[..]
	__print_flags(sflags, "|",
		{ SLAB_CONSISTENCY_CHECKS, "CONSISTENCY_CHECKS" },
		{ SLAB_RED_ZONE, "RED_ZONE" },
		{ SLAB_POISON, "POISON" },
		{ SLAB_HWCACHE_ALIGN, "HWCACHE_ALIGN" },
		{ SLAB_CACHE_DMA, "CACHE_DMA" },
		{ SLAB_CACHE_DMA32, "CACHE_DMA32" },
		{ SLAB_STORE_USER, "STORE_USER" },
		{ SLAB_PANIC, "PANIC" }), ... )


And you get the flag output looking nicely, and all the processing is done
on the reader path.

That's if you find it useful at all.

-- Steve
