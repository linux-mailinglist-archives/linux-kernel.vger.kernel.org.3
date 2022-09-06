Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231EA5AE93F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 15:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240394AbiIFNR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 09:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240210AbiIFNRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 09:17:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2220C6DACB
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 06:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662470270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GjwOR0IwFj7/RGmX3t8tdGBhDDX1U7Y1rtGQK453L9s=;
        b=CGKn6PODg0oQQ2L16NP2IM+glRznswsVPVUq7J/c5OE98k0AUeW0JdMtzzmsCFIbsTYSB6
        zPoaoSJYCpVy/D5Adtihx1550YxfgYwPW5Brox2eVpJYIMd61ZzVS9saxxP2zsiU9q8pRy
        CYO4llNxrcXnIoCXw4Y+QtwTZMKWl48=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-488-bcm_OnQSPXq2zmTLsf01BQ-1; Tue, 06 Sep 2022 09:17:49 -0400
X-MC-Unique: bcm_OnQSPXq2zmTLsf01BQ-1
Received: by mail-wr1-f69.google.com with SMTP id d11-20020adfc08b000000b002207555c1f6so2337115wrf.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 06:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=GjwOR0IwFj7/RGmX3t8tdGBhDDX1U7Y1rtGQK453L9s=;
        b=KgNNSzoBs7Z3PSuhpJPHf3xzZXJwdMc21jQW3V2ychyLY4vz5J+ie4w+/RzFjQBUy6
         CpJkvyOPLS1qdqMlninPeVtZrp/kAvHqdhbsa16X3szuCv3kaNGTQZ1uG8RUGkK+576Z
         IIHlLXPc6C+lt3HKnGEapUYqqGSuNEkw4NyMrE652SKojKujcdM0uNAsBFiE70mQYU1P
         eILL//kfpOoHCAC4kUyErcciA5t5CckiSEjTwqO/byusOime+R/4zospGwg8/G13twKk
         9MTAlb5bf7852DL8YL9ODOU0hddCxE4N3h72ZO8flCYb9ttJQ+BHSEsnSzfuNlYoOglK
         G2cw==
X-Gm-Message-State: ACgBeo0ptjEyfPRuHJeRKk5dWdsUXfqadfuZXvhtkGDp4itEcW0lI96D
        2I5uvg7vOv1FoPm+G34fuMfjDh85t3NL2sOF/3bskbNyP3v9OSd/ndmaFF55qk2cgZ58eMPpb5E
        I1t6jo8JNEEQErlShHeo94hDE
X-Received: by 2002:a5d:62d0:0:b0:228:d6ee:9bf4 with SMTP id o16-20020a5d62d0000000b00228d6ee9bf4mr2376976wrv.34.1662470267893;
        Tue, 06 Sep 2022 06:17:47 -0700 (PDT)
X-Google-Smtp-Source: AA6agR60faROv7NXDWQZSAZ3esquhwyEQlDW0rmfE16kWqyRI1dSjiveaH/zBuliIdeF9eC3CgbQVw==
X-Received: by 2002:a5d:62d0:0:b0:228:d6ee:9bf4 with SMTP id o16-20020a5d62d0000000b00228d6ee9bf4mr2376951wrv.34.1662470267511;
        Tue, 06 Sep 2022 06:17:47 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0? (p200300d82f0dba00c95131d7b2b08ba0.dip0.t-ipconnect.de. [2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0])
        by smtp.gmail.com with ESMTPSA id j17-20020a05600c411100b003a6896feef7sm14104782wmi.39.2022.09.06.06.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 06:17:46 -0700 (PDT)
Message-ID: <d57009d3-fd40-5061-31ae-203dff1e0ef7@redhat.com>
Date:   Tue, 6 Sep 2022 15:17:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1662264560.git.remckee0@gmail.com>
 <49b96ce88dece5b394d5dd4332c1572da917b30a.1662264560.git.remckee0@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4 1/4] memblock tests: add simulation of physical memory
 with multiple NUMA nodes
In-Reply-To: <49b96ce88dece5b394d5dd4332c1572da917b30a.1662264560.git.remckee0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.09.22 06:21, Rebecca Mckeever wrote:
> Add function setup_numa_memblock() for setting up a memory layout with
> multiple NUMA nodes in a previously allocated dummy physical memory.
> This function can be used in place of setup_memblock() in tests that need
> to simulate a NUMA system.
> 
> setup_numa_memblock():
> - allows for setting up a memory layout by specifying the fraction of
>    MEM_SIZE in each node
> 
> Set CONFIG_NODES_SHIFT to 4 when building with NUMA=1 to allow for up to
> 16 NUMA nodes.
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---
>   .../testing/memblock/scripts/Makefile.include |  2 +-
>   tools/testing/memblock/tests/common.c         | 29 +++++++++++++++++++
>   tools/testing/memblock/tests/common.h         |  4 ++-
>   3 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/memblock/scripts/Makefile.include b/tools/testing/memblock/scripts/Makefile.include
> index aa6d82d56a23..998281723590 100644
> --- a/tools/testing/memblock/scripts/Makefile.include
> +++ b/tools/testing/memblock/scripts/Makefile.include
> @@ -3,7 +3,7 @@
>   
>   # Simulate CONFIG_NUMA=y
>   ifeq ($(NUMA), 1)
> -	CFLAGS += -D CONFIG_NUMA
> +	CFLAGS += -D CONFIG_NUMA -D CONFIG_NODES_SHIFT=4
>   endif
>   
>   # Use 32 bit physical addresses.
> diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
> index eec6901081af..b6110df21b2a 100644
> --- a/tools/testing/memblock/tests/common.c
> +++ b/tools/testing/memblock/tests/common.c
> @@ -72,6 +72,35 @@ void setup_memblock(void)
>   	fill_memblock();
>   }
>   
> +/**
> + * setup_numa_memblock:
> + * Set up a memory layout with multiple NUMA nodes in a previously allocated
> + * dummy physical memory.
> + * @nodes: an array containing the denominators of the fractions of MEM_SIZE
> + *         contained in each node (e.g., if nodes[0] = SZ_8, node 0 will
> + *         contain 1/8th of MEM_SIZE)
> + *
> + * The nids will be set to 0 through NUMA_NODES - 1.
> + */
> +void setup_numa_memblock(const phys_addr_t nodes[])
> +{
> +	phys_addr_t base;
> +	int flags;
> +
> +	reset_memblock_regions();
> +	base = (phys_addr_t)memory_block.base;
> +	flags = (movable_node_is_enabled()) ? MEMBLOCK_NONE : MEMBLOCK_HOTPLUG;
> +
> +	for (int i = 0; i < NUMA_NODES; i++) {
> +		assert(nodes[i] <= MEM_SIZE && nodes[i] > 0);

I think it would be even easier to get if this would just be a fraction.
E.g., instead of "1/8 * MEM_SIZE" just "1/8". All values have to add up 
to 1.

... but then we'd have to mess with floats eventually, so I guess this 
makes it easier to handle these fractions.


We could use "int" and simply specify the fraction in percent, like

nodes[0] = 50;
nodes[1] = 25;
nodes[2] = 25;

and everything has to add up to 100.


> +		phys_addr_t size = MEM_SIZE / nodes[i];


Hmmm, assuming a single node with "MEM_SIZE", we would get size=1.

Shouldn't this be "size = nodes[i]"

?

-- 
Thanks,

David / dhildenb

