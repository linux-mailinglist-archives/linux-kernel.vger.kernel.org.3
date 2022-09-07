Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8BD5B10A5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 01:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiIGXwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 19:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIGXwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 19:52:18 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825B5CEB0B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 16:52:17 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id a15so11729011qko.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 16:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=V2cNT8Amrqk0TNpJ6s/2BxbrzUDUXH8dhBFWFjJ5nFU=;
        b=l5EqQWUjadJduaSBR6zyGgdcbFAYdxXFbRWqpUaAUTC4bbfuvj1cj7gnDOj/XrIg8K
         NmyWKxRAbRJ+0B3TSp9MXWHDLclgcKKRNDdT8KA8z/nKaLh4bxK8WZX641sNh1SgTBQL
         snSteQ8Tc+H0E3BdAtFMaavMru7Y9gEEDJjv2ZiLUzFNPyoyPLjars0NgE5l9twOXBi+
         eYLHgR4i+EKVq8zM3CaNkKiA8Qqmg/RWYu+NIrbJ2qGPHiGf+uB8OBqMroJBJcOnli2w
         tru6B0lJtz/VS9h4GlB4ElB0a9FZzpvADBlCHEkqPA0Ef5L/ZnyrI1WDsn4pFj3bPJYz
         kOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=V2cNT8Amrqk0TNpJ6s/2BxbrzUDUXH8dhBFWFjJ5nFU=;
        b=q/iKnv1eyg9WGhurLcvKxY/YBdMJhhzecJdnuRxc9J0nDMOPR0QW1JCPoQ6Iipw98X
         ujBD2LS+qqKmwDZQvSnncsFJ83ANnE8x75UHmF4a7sYWY9nQQhuYvucjYHkCD3j2A6je
         /Rx7FozRHnxpL8+WmXF2lHH0q4I1m0j/dGC/CFxUJjs/kfBHair2odHl8/ri2bF5RS6Z
         tMn7yDuA/d9MmqRUF3f1lJTK1Cz2JNjs1sBTbdZ0q6H0v08MYkWnHLc3huJx3fKIfH0f
         8KPxJE2U2HvAgg1OF66JLUOZ0IRL2MVC2FsWF9GoFRmRGvwz38uK2IkEr8dNwTxHL0eX
         3lCQ==
X-Gm-Message-State: ACgBeo3RB2/t3R4xU0cvPjiRUOr2e0G6isDpae4tBzRGdQrZLRwyxFBX
        ykHXIKPBAqPJ9SO9H58ypEBEZhQw1P3zGQ==
X-Google-Smtp-Source: AA6agR5cXe7sqID90O6fwbJZhRoALaOOLda6OX1R8JKHdKr3v7xij9dw5sSaUtGvBogehdwrVzVIXQ==
X-Received: by 2002:a05:620a:12ad:b0:6bb:e6e8:9a96 with SMTP id x13-20020a05620a12ad00b006bbe6e89a96mr4349859qki.209.1662594736360;
        Wed, 07 Sep 2022 16:52:16 -0700 (PDT)
Received: from sophie ([45.134.140.172])
        by smtp.gmail.com with ESMTPSA id l5-20020a05620a28c500b006b5f06186aesm16205258qkp.65.2022.09.07.16.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 16:52:15 -0700 (PDT)
Date:   Wed, 7 Sep 2022 18:52:14 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] memblock tests: add simulation of physical memory
 with multiple NUMA nodes
Message-ID: <20220907235214.GA7222@sophie>
References: <cover.1662264560.git.remckee0@gmail.com>
 <49b96ce88dece5b394d5dd4332c1572da917b30a.1662264560.git.remckee0@gmail.com>
 <d57009d3-fd40-5061-31ae-203dff1e0ef7@redhat.com>
 <20220906234306.GA4053@sophie>
 <26f5ff14-077f-4bb6-90d8-ea83509ff682@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26f5ff14-077f-4bb6-90d8-ea83509ff682@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 10:44:44AM +0200, David Hildenbrand wrote:
> On 07.09.22 01:43, Rebecca Mckeever wrote:
> > On Tue, Sep 06, 2022 at 03:17:46PM +0200, David Hildenbrand wrote:
> > > On 04.09.22 06:21, Rebecca Mckeever wrote:
> > > > Add function setup_numa_memblock() for setting up a memory layout with
> > > > multiple NUMA nodes in a previously allocated dummy physical memory.
> > > > This function can be used in place of setup_memblock() in tests that need
> > > > to simulate a NUMA system.
> > > > 
> > > > setup_numa_memblock():
> > > > - allows for setting up a memory layout by specifying the fraction of
> > > >     MEM_SIZE in each node
> > > > 
> > > > Set CONFIG_NODES_SHIFT to 4 when building with NUMA=1 to allow for up to
> > > > 16 NUMA nodes.
> > > > 
> > > > Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> > > > ---
> > > >    .../testing/memblock/scripts/Makefile.include |  2 +-
> > > >    tools/testing/memblock/tests/common.c         | 29 +++++++++++++++++++
> > > >    tools/testing/memblock/tests/common.h         |  4 ++-
> > > >    3 files changed, 33 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/tools/testing/memblock/scripts/Makefile.include b/tools/testing/memblock/scripts/Makefile.include
> > > > index aa6d82d56a23..998281723590 100644
> > > > --- a/tools/testing/memblock/scripts/Makefile.include
> > > > +++ b/tools/testing/memblock/scripts/Makefile.include
> > > > @@ -3,7 +3,7 @@
> > > >    # Simulate CONFIG_NUMA=y
> > > >    ifeq ($(NUMA), 1)
> > > > -	CFLAGS += -D CONFIG_NUMA
> > > > +	CFLAGS += -D CONFIG_NUMA -D CONFIG_NODES_SHIFT=4
> > > >    endif
> > > >    # Use 32 bit physical addresses.
> > > > diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
> > > > index eec6901081af..b6110df21b2a 100644
> > > > --- a/tools/testing/memblock/tests/common.c
> > > > +++ b/tools/testing/memblock/tests/common.c
> > > > @@ -72,6 +72,35 @@ void setup_memblock(void)
> > > >    	fill_memblock();
> > > >    }
> > > > +/**
> > > > + * setup_numa_memblock:
> > > > + * Set up a memory layout with multiple NUMA nodes in a previously allocated
> > > > + * dummy physical memory.
> > > > + * @nodes: an array containing the denominators of the fractions of MEM_SIZE
> > > > + *         contained in each node (e.g., if nodes[0] = SZ_8, node 0 will
> > > > + *         contain 1/8th of MEM_SIZE)
> > > > + *
> > > > + * The nids will be set to 0 through NUMA_NODES - 1.
> > > > + */
> > > > +void setup_numa_memblock(const phys_addr_t nodes[])
> > > > +{
> > > > +	phys_addr_t base;
> > > > +	int flags;
> > > > +
> > > > +	reset_memblock_regions();
> > > > +	base = (phys_addr_t)memory_block.base;
> > > > +	flags = (movable_node_is_enabled()) ? MEMBLOCK_NONE : MEMBLOCK_HOTPLUG;
> > > > +
> > > > +	for (int i = 0; i < NUMA_NODES; i++) {
> > > > +		assert(nodes[i] <= MEM_SIZE && nodes[i] > 0);
> > > 
> > > I think it would be even easier to get if this would just be a fraction.
> > > E.g., instead of "1/8 * MEM_SIZE" just "1/8". All values have to add up to
> > > 1.
> > > 
> > > ... but then we'd have to mess with floats eventually, so I guess this makes
> > > it easier to handle these fractions.
> > > 
> > > 
> > > We could use "int" and simply specify the fraction in percent, like
> > > 
> > > nodes[0] = 50;
> > > nodes[1] = 25;
> > > nodes[2] = 25;
> > > 
> > > and everything has to add up to 100.
> > > 
> > This would still be a float for 1/8th (12.5) and 1/16th (6.25). What if
> > it was the "percent" of 256 (i.e., 0x100)?
> 
> Right, or in something "smaller" like 1/32 th. I don't think we go below
> that?
> 
> If we don't need more digits, why not in "basis points" (per ten thousand)
> -> https://en.wikipedia.org/wiki/Basis_point
> 
Basis points should work.

> nodes[0] = 5000; /* 1/2  */
> nodes[1] = 2500; /* 1/4 */
> nodes[2] = 1250; /* 1/8 */
> nodes[4] = 0625; /* 1/32 */
> nodes[5] = 0625;
> 
> 
> > > 
> > > > +		phys_addr_t size = MEM_SIZE / nodes[i];
> > > 
> > > 
> > > Hmmm, assuming a single node with "MEM_SIZE", we would get size=1.
> > > 
> > For a single node of MEM_SIZE, nodes[0] would be 1.
> > 
> > > Shouldn't this be "size = nodes[i]"
> > > 
> > > ?
> > No, not with the current implementation. The nodes array stores the
> > denominator of the fraction that will be multiplied by MEM_SIZE to
> > determine the size of that node (the numerator is always 1). So if the
> > size of the node should be 1/8 * MEM_SIZE, the nodes array just stores
> > the 8. I think the name of the array is misleading. Do you have any
> > suggestions for a better name?
> 
> Then I am confused about the
> 	assert(nodes[i] <= MEM_SIZE && nodes[i] > 0);
> 
> assertion :)
> 
The first part of the assert ensures that size doesn't become less than
1, and the second part prevents a divide by 0. I see how this is
confusing now.

> I think it would really be best to just store the actual fraction somehow.
> But maybe just I am confused :)
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 
Thanks,
Rebecca
