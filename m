Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3195A921F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbiIAIcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbiIAIcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:32:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85AFC7FB4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:32:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A6CED1FA04;
        Thu,  1 Sep 2022 08:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662021161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5hZJdKvZSq/cAGjCksiQPWfxol38eNcxRTKoapUoi84=;
        b=UQPhO/Bte5iI5JqU+YSl94RuZjt+GPlGBGjfi1LqL9gtD0+3SkAqd15042zZMgpMYdE7r/
        9ceszmg2z0N9KxOxJL4xEh/jiewiwzpL/dPCgpkRVVFQvFSs1a/5y5Z9SQ/2QMoFoatDhw
        yBBlLq4nTB7ghTDHuHcmpOgj2WGudVY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 87A2C13A79;
        Thu,  1 Sep 2022 08:32:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id h0rBHiluEGORNQAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 01 Sep 2022 08:32:41 +0000
Date:   Thu, 1 Sep 2022 10:32:40 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 0/3] page_owner: print stacks and their counter
Message-ID: <YxBuKHHJyk1AABbM@dhcp22.suse.cz>
References: <20220901044249.4624-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901044249.4624-1-osalvador@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01-09-22 06:42:46, Oscar Salvador wrote:
> Hi,
> 
> page_owner is a great debug functionality tool that gets us to know
> about all pages that have been allocated/freed and their stacktrace.
> This comes very handy when e.g: debugging leaks, as with some scripting
> we might be able to see those stacktraces that are allocating pages
> but not freeing theme.
> 
> In my experience, that is one of the most useful cases, but it can get
> really tedious to screen through all pages aand try to reconstruct the
> stack <-> allocated/freed relationship. There is a lot of noise
> to cancel off.
> 
> This patch aims to fix that by adding a new functionality into page_owner.
> What this does is to create a new read-only file "page_owner_stacks",
> which prints only the allocating stacktraces and their counting, being that
> the times the stacktrace has allocated - the times it has freed.
> 
> So we have a clear overview of stacks <-> allocated/freed relationship
> without the need to fiddle with pages and trying to match free stacktraces
> with allocated stacktraces.
> 
> This is achieved by adding a new refcount_t field in the stack_record struct,
> incrementing that refcount_t everytime the same stacktrace allocates,
> and decrementing it when it frees a page. Details can be seen in the
> respective patches.
> 
> We also create another file called "page_owner_threshold", which let us
> specify a threshold, so when when reading from "page_owner_stacks",
> we will only see those stacktraces which counting goes beyond the
> threshold we specified.
> 
> A PoC can be found below:
> 
> # cat /sys/kernel/debug/page_owner_threshold
>  0
> # cat /sys/kernel/debug/page_owner_stacks > stacks_full.txt
> # head -32 stacks_full.txt
>  prep_new_page+0x10d/0x180
>  get_page_from_freelist+0x1bd6/0x1e10
>  __alloc_pages+0x194/0x360
>  alloc_page_interleave+0x13/0x90
>  new_slab+0x31d/0x530
>  ___slab_alloc+0x5d7/0x720
>  __slab_alloc.isra.85+0x4a/0x90
>  kmem_cache_alloc+0x455/0x4a0
>  acpi_ps_alloc_op+0x57/0x8f
>  acpi_ps_create_scope_op+0x12/0x23
>  acpi_ps_execute_method+0x102/0x2c1
>  acpi_ns_evaluate+0x343/0x4da
>  acpi_evaluate_object+0x1cb/0x392
>  acpi_run_osc+0x135/0x260
>  acpi_init+0x165/0x4ed
>  do_one_initcall+0x3e/0x200
> stack count: 2

This is very nice and useful! I guess some people would prefer to have
Memory usage: XYZ kB
dumped instead but looking at the code this would require to track
number of pages rather than calls with stacks and that would be more code
and somehow alien to the concept as well. Practically speaking, when
looking into leakers high stack count should be indicative enough IMHO.

[...]
> Oscar Salvador (3):
>   lib/stackdepot: Add a refcount field in stack_record
>   mm, page_owner: Add page_owner_stacks file to print out only stacks
>     and their counter
>   mm,page_owner: Filter out stacks by a threshold counter
> 
>  include/linux/stackdepot.h |  16 ++++-
>  lib/stackdepot.c           | 121 ++++++++++++++++++++++++++++++++-----
>  mm/kasan/common.c          |   3 +-
>  mm/page_owner.c            | 102 +++++++++++++++++++++++++++++--
>  4 files changed, 222 insertions(+), 20 deletions(-)

The code footprint is also rather low. I am no expert in neither
stackdepot nor page owner but from a very quick glance nothing really
jumped at me.

Thanks!
-- 
Michal Hocko
SUSE Labs
