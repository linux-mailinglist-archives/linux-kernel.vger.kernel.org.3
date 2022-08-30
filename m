Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E875A617D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiH3LSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiH3LSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:18:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9230CF327B
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 04:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661858280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZxmNIacuuwOoWBsLtTJD3DQdhsimDAChe/PhEh+YcZI=;
        b=IJLA3aDid3jwbCS3W6o76Z4/alrVKaTM1aNy7M63ugtmUnfL6yqVXRleXzYZZlVipZMauN
        kCsLX5A4o0Us8V0nTn2XpFa8k0SGo9qbv0ovbvfOl1xb993bqTem8JmagvsAO2WXkOw2KN
        JvLYSyScPE1LcyzOqM7W6ADIpeOjujk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-235-fVdFvgQZNK6FmwYizIabPA-1; Tue, 30 Aug 2022 07:17:58 -0400
X-MC-Unique: fVdFvgQZNK6FmwYizIabPA-1
Received: by mail-wm1-f71.google.com with SMTP id b16-20020a05600c4e1000b003a5a47762c3so6482201wmq.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 04:17:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ZxmNIacuuwOoWBsLtTJD3DQdhsimDAChe/PhEh+YcZI=;
        b=GN6MfGrTrXevdTojmVPyTdldfos29M3UTwWeVfo6hUlskpafCtFIdIFsEw5W9bM+MN
         ZZJaTT5SgZzQk4QHf5fqVNbR5Yyl8puOepVRL92A6MVmzexA3RiL9ldQw5CHs+KkC+nj
         O186kufKl1uw4GLFBLJ05fmsmJcLGEzw6uGqPyLlkQBffvfz5mbnjhpovhm6lFH3br0E
         P+lrxsZbBBjVS/oj8xRuKiQ4K9Jqnjk6nG1PveloctnBk5tDutPymoPO38FlujpOLCRZ
         KQrNY27loSVTQBo8NTMbR69Ew5VNSPxBMZ+4Az2WIUSliy6jalqTke77smWTeyPktsYP
         U6Ww==
X-Gm-Message-State: ACgBeo2fZUvXYsjoDqXrGegl6FOHkZm+AWy6j/fMFQH3zLPv4IBgtfmb
        uuQuP6qSgJhyqTfKCxNQziaO65Y2pbuv/uad5B2NHi1L8UkNWcQ4TyL/CU6tpFWmn92MkdSxKDH
        dvJX6UZz4+s/SvlCkNi8xuisX
X-Received: by 2002:a1c:7c0d:0:b0:3a6:673a:395e with SMTP id x13-20020a1c7c0d000000b003a6673a395emr9216553wmc.67.1661858277784;
        Tue, 30 Aug 2022 04:17:57 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6yoSx94SNgBaZ6EuUcO48Vir8ri2vtPcwaz1VF0AmY4tAJL7otWozoHlqmLMFJc2DoyCHGuQ==
X-Received: by 2002:a1c:7c0d:0:b0:3a6:673a:395e with SMTP id x13-20020a1c7c0d000000b003a6673a395emr9216542wmc.67.1661858277481;
        Tue, 30 Aug 2022 04:17:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:1000:ecb4:919b:e3d3:e20b? (p200300cbc70a1000ecb4919be3d3e20b.dip0.t-ipconnect.de. [2003:cb:c70a:1000:ecb4:919b:e3d3:e20b])
        by smtp.gmail.com with ESMTPSA id l7-20020a05600c1d0700b003a317ee3036sm13323610wms.2.2022.08.30.04.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 04:17:56 -0700 (PDT)
Message-ID: <329ab669-620c-ba9e-3c57-9cb90d55b942@redhat.com>
Date:   Tue, 30 Aug 2022 13:17:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/4] memblock tests: add simulation of physical memory
 with multiple NUMA nodes
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1660897864.git.remckee0@gmail.com>
 <0cfb3c69ba6ca9ff55e1fc2528d18d108416ba57.1660897864.git.remckee0@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <0cfb3c69ba6ca9ff55e1fc2528d18d108416ba57.1660897864.git.remckee0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.08.22 11:05, Rebecca Mckeever wrote:
> Add functions setup_numa_memblock_generic() and setup_numa_memblock()
> for setting up a memory layout with multiple NUMA nodes in a previously
> allocated dummy physical memory. These functions can be used in place of
> setup_memblock() in tests that need to simulate a NUMA system.
> 
> setup_numa_memblock_generic():
> - allows for setting up a custom memory layout by specifying the amount
>   of memory in each node, the number of nodes, and a factor that will be
>   used to scale the memory in each node
> 
> setup_numa_memblock():
> - allows for setting up a default memory layout
> 
> Introduce constant MEM_FACTOR, which is used to scale the default memory
> layout based on MEM_SIZE.
> 
> Set CONFIG_NODES_SHIFT to 4 when building with NUMA=1 to allow for up to
> 16 NUMA nodes.
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---
>  .../testing/memblock/scripts/Makefile.include |  2 +-
>  tools/testing/memblock/tests/common.c         | 38 +++++++++++++++++++
>  tools/testing/memblock/tests/common.h         |  9 ++++-
>  3 files changed, 47 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/memblock/scripts/Makefile.include b/tools/testing/memblock/scripts/Makefile.include
> index aa6d82d56a23..998281723590 100644
> --- a/tools/testing/memblock/scripts/Makefile.include
> +++ b/tools/testing/memblock/scripts/Makefile.include
> @@ -3,7 +3,7 @@
>  
>  # Simulate CONFIG_NUMA=y
>  ifeq ($(NUMA), 1)
> -	CFLAGS += -D CONFIG_NUMA
> +	CFLAGS += -D CONFIG_NUMA -D CONFIG_NODES_SHIFT=4
>  endif
>  
>  # Use 32 bit physical addresses.
> diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
> index eec6901081af..15d8767dc70c 100644
> --- a/tools/testing/memblock/tests/common.c
> +++ b/tools/testing/memblock/tests/common.c
> @@ -34,6 +34,10 @@ static const char * const help_opts[] = {
>  
>  static int verbose;
>  
> +static const phys_addr_t node_sizes[] = {
> +	SZ_4K, SZ_1K, SZ_2K, SZ_2K, SZ_1K, SZ_1K, SZ_4K, SZ_1K
> +};
> +
>  /* sets global variable returned by movable_node_is_enabled() stub */
>  bool movable_node_enabled;
>  
> @@ -72,6 +76,40 @@ void setup_memblock(void)
>  	fill_memblock();
>  }
>  
> +/**
> + * setup_numa_memblock_generic:
> + * Set up a memory layout with multiple NUMA nodes in a previously allocated
> + * dummy physical memory.
> + * @nodes: an array containing the amount of memory in each node
> + * @node_cnt: the size of @nodes
> + * @factor: a factor that will be used to scale the memory in each node
> + *
> + * The nids will be set to 0 through node_cnt - 1.
> + */
> +void setup_numa_memblock_generic(const phys_addr_t nodes[],
> +				 int node_cnt, int factor)
> +{
> +	phys_addr_t base;
> +	int flags;
> +
> +	reset_memblock_regions();
> +	base = (phys_addr_t)memory_block.base;
> +	flags = (movable_node_is_enabled()) ? MEMBLOCK_NONE : MEMBLOCK_HOTPLUG;
> +
> +	for (int i = 0; i < node_cnt; i++) {
> +		phys_addr_t size = factor * nodes[i];

I'm a bit lost why we need the factor if we already provide sizes in the
array.

Can you enlighten me? :)

Why can't we just stick to the sizes in the array?

-- 
Thanks,

David / dhildenb

