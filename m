Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F145AA41E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 02:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbiIBAOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 20:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiIBAOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 20:14:51 -0400
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com [IPv6:2001:4860:4864:20::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977F2E2C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 17:14:50 -0700 (PDT)
Received: by mail-oa1-x42.google.com with SMTP id 586e51a60fabf-11ba6e79dd1so1132060fac.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 17:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=gKp98spEweFUGFmaHflLEq6ZQ2lg9SKE97iSlwXZRWk=;
        b=b3fx0Lq5OQIejVvIPchFJmhhaRpuR7yq6Mz+SI9N1fGg+lSTtC6oFKYaKWQLRoDBfY
         DHgPJ+9tRxH5fv7akPGi6AaQwFNLluX4V7WBUcsRK0a5GdYv5749hSMj9fV3ZNdl+yit
         mX+0YZ4o2wQ4L54SfDgQxU7YemcqWENW8F40qSVXaQyZc3TLPnxA3u8d0Q2nMyhtTlJv
         jcC1Q81d55Pgcl9KGQaGc0wct2uzOQebukS2E0pgSGVJWD5Cle05ykv7yV+TtlNf4eGL
         3dYrJzbmUzuQ05MdBkPYzopmZnwtTMvZufcWtfM/L5AK1CDt65mpLrsU8OpRfJdOB8kf
         kKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=gKp98spEweFUGFmaHflLEq6ZQ2lg9SKE97iSlwXZRWk=;
        b=nOUeeaxAxQ1hMu1F+k3qJxX+Hq7rbrOJHHwW/J1chI/fWK60wpjuRlj9cTDrI5DtXv
         xh6RjgfPUzZLVAbRiuNcuoXrWT2aucSJbK6/JTIPNBBHR2vEUrcXeqR8Z6Yv9gSsXZ+K
         klEN8EUz8/VaNH05yfLQVv/30jQSH+KuP2JiQi3Cq0BekUchNuzgK0X5k5Yoisroz4Lv
         b3iq06G0SytNBbvLmd0lC1aGRzl1jdF3FBW/DJ0DCbXXDpn36ruWa0m78ahd3HgpZJnP
         Tvc8mzsYhsTvhqnXh1kMO4lLkXcOujAzaNn0cxneKnS4xEJYpq6/iWWOCZELd9kzSQ8e
         s4Yg==
X-Gm-Message-State: ACgBeo0VVZWIVKG819OYxF1okeW0BsRQAyFUr8d2ngRHetVIiFH7xQ/P
        vdkxOJ+q3uHHx/35HpLa4tQ=
X-Google-Smtp-Source: AA6agR6qNPSkUFTWari9DLPob4stRjrElutvNL9JQO3j+rRkmaCUD31HuOEVA2sXN79I29N56Y5JIg==
X-Received: by 2002:a05:6870:3282:b0:122:58aa:3fbd with SMTP id q2-20020a056870328200b0012258aa3fbdmr977288oac.12.1662077689859;
        Thu, 01 Sep 2022 17:14:49 -0700 (PDT)
Received: from sophie (static-198-54-128-70.cust.tzulo.com. [198.54.128.70])
        by smtp.gmail.com with ESMTPSA id u42-20020a056870d5aa00b00120f7de7f6esm352544oao.58.2022.09.01.17.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 17:14:48 -0700 (PDT)
Date:   Thu, 1 Sep 2022 19:14:47 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 1/4] memblock tests: add simulation of physical memory
 with multiple NUMA nodes
Message-ID: <20220902001447.GA18733@sophie>
References: <cover.1660897864.git.remckee0@gmail.com>
 <0cfb3c69ba6ca9ff55e1fc2528d18d108416ba57.1660897864.git.remckee0@gmail.com>
 <Yw97HVSRW4+pkemb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw97HVSRW4+pkemb@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 06:15:41PM +0300, Mike Rapoport wrote:
> On Fri, Aug 19, 2022 at 02:05:31AM -0700, Rebecca Mckeever wrote:
> > Add functions setup_numa_memblock_generic() and setup_numa_memblock()
> > for setting up a memory layout with multiple NUMA nodes in a previously
> > allocated dummy physical memory. These functions can be used in place of
> > setup_memblock() in tests that need to simulate a NUMA system.
> > 
> > setup_numa_memblock_generic():
> > - allows for setting up a custom memory layout by specifying the amount
> >   of memory in each node, the number of nodes, and a factor that will be
> >   used to scale the memory in each node
> > 
> > setup_numa_memblock():
> > - allows for setting up a default memory layout
> > 
> > Introduce constant MEM_FACTOR, which is used to scale the default memory
> > layout based on MEM_SIZE.
> > 
> > Set CONFIG_NODES_SHIFT to 4 when building with NUMA=1 to allow for up to
> > 16 NUMA nodes.
> > 
> > Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> > ---
> >  .../testing/memblock/scripts/Makefile.include |  2 +-
> >  tools/testing/memblock/tests/common.c         | 38 +++++++++++++++++++
> >  tools/testing/memblock/tests/common.h         |  9 ++++-
> >  3 files changed, 47 insertions(+), 2 deletions(-)
> 
> ...
>   
> > +/**
> > + * setup_numa_memblock_generic:
> > + * Set up a memory layout with multiple NUMA nodes in a previously allocated
> > + * dummy physical memory.
> > + * @nodes: an array containing the amount of memory in each node
> > + * @node_cnt: the size of @nodes
> > + * @factor: a factor that will be used to scale the memory in each node
> > + *
> > + * The nids will be set to 0 through node_cnt - 1.
> > + */
> > +void setup_numa_memblock_generic(const phys_addr_t nodes[],
> > +				 int node_cnt, int factor)
> 
> I only had time for a quick look and it seems this function is never used
> on its own.
> Let's fold it into setup_numa_memblock() for now.
> 
Okay, will do.

> > +{
> > +	phys_addr_t base;
> > +	int flags;
> > +
> > +	reset_memblock_regions();
> > +	base = (phys_addr_t)memory_block.base;
> > +	flags = (movable_node_is_enabled()) ? MEMBLOCK_NONE : MEMBLOCK_HOTPLUG;
> > +
> > +	for (int i = 0; i < node_cnt; i++) {
> > +		phys_addr_t size = factor * nodes[i];
> > +
> > +		memblock_add_node(base, size, i, flags);
> > +		base += size;
> > +	}
> > +	fill_memblock();
> > +}
> > +
> > +void setup_numa_memblock(void)
> > +{
> > +	setup_numa_memblock_generic(node_sizes, NUMA_NODES, MEM_FACTOR);
> > +}
> > +
> 
> -- 
> Sincerely yours,
> Mike.

Thanks,
Rebecca
