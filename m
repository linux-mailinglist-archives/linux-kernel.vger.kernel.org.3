Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDE55AFF78
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiIGIpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiIGIox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:44:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C40B5F226
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662540288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gRwNMNugMbeJ/J9QmYL3cKMM73+txKjGs7EQMZzIdQQ=;
        b=AjQlxZROM0Uq/zFKjDrxzEWZ0xZaY8fa3MbhMx7VNhdZ00lIAagmlNmmsG7jqf/oC9k5Xg
        HyOoDsdSSMIowIZ74HNkGAkH6JNGnZSLD9P7Y2KHK9ZLw9u2UmkK93bPO/N01UnhU03Ryo
        Agr88ByPOu9w4zLixVITKWkFIAVnozI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-621-6MEH-EE8O2KKqB1JGvOF_w-1; Wed, 07 Sep 2022 04:44:47 -0400
X-MC-Unique: 6MEH-EE8O2KKqB1JGvOF_w-1
Received: by mail-wm1-f69.google.com with SMTP id ay21-20020a05600c1e1500b003a6271a9718so7140640wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 01:44:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=gRwNMNugMbeJ/J9QmYL3cKMM73+txKjGs7EQMZzIdQQ=;
        b=ShNcgIipHF8CZDOQVez0+YpWv4xttZMlB4No4dNtGBekPKsusT+VUQcyUv+K426ozV
         zG6EVNUU7DPYMxJ5IsVpSuRe8Wa6fib73fE3lhlCh3DzM7L4AObLf3p1qEaWaMQHhvmC
         9W0bE+K8mD5zJYp6arJbO42o5MVfD00KmwaZwnKWPfhSoF1oBqTP/UulQXbYCE/6R1C7
         9kiiV7wmoNe11x5nvkc/jTTAuItvLGgpYQfJmAn6xXSxBay+mb/Ifkva0WIEquYfIDex
         vvZr9WJcZyXINRUuF1+xq0Nmc8CxGzF5h28prlVBbaws2U1dix7hYlfUYL1Ud972uqeF
         SnbQ==
X-Gm-Message-State: ACgBeo090zYrMa9Iea83raaLiC4TA0yE/pZoFBssHPrlUL6P9GAw8BwU
        8OJfnCJxrxj55ZQfXiV32DgancpirUwUvAVVx/u+WKhBTSjjkiLPRVxOswIyUvgycHYLoBA4ubG
        T0GoUITzM9NHJQUd0Fg+u3Y25
X-Received: by 2002:a5d:448d:0:b0:228:6084:1f36 with SMTP id j13-20020a5d448d000000b0022860841f36mr1416681wrq.157.1662540286039;
        Wed, 07 Sep 2022 01:44:46 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5PAhtZiU4Ib9kLPSRKT9y9QpO5R0BeKsXCl6caTOpdA1oVdgybiz7O3EG7EBIC3upAV0tR5Q==
X-Received: by 2002:a5d:448d:0:b0:228:6084:1f36 with SMTP id j13-20020a5d448d000000b0022860841f36mr1416669wrq.157.1662540285705;
        Wed, 07 Sep 2022 01:44:45 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0? (p200300d82f0dba00c95131d7b2b08ba0.dip0.t-ipconnect.de. [2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0])
        by smtp.gmail.com with ESMTPSA id o16-20020a05600c4fd000b003a5c999cd1asm23485819wmq.14.2022.09.07.01.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 01:44:45 -0700 (PDT)
Message-ID: <26f5ff14-077f-4bb6-90d8-ea83509ff682@redhat.com>
Date:   Wed, 7 Sep 2022 10:44:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1662264560.git.remckee0@gmail.com>
 <49b96ce88dece5b394d5dd4332c1572da917b30a.1662264560.git.remckee0@gmail.com>
 <d57009d3-fd40-5061-31ae-203dff1e0ef7@redhat.com>
 <20220906234306.GA4053@sophie>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4 1/4] memblock tests: add simulation of physical memory
 with multiple NUMA nodes
In-Reply-To: <20220906234306.GA4053@sophie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.09.22 01:43, Rebecca Mckeever wrote:
> On Tue, Sep 06, 2022 at 03:17:46PM +0200, David Hildenbrand wrote:
>> On 04.09.22 06:21, Rebecca Mckeever wrote:
>>> Add function setup_numa_memblock() for setting up a memory layout with
>>> multiple NUMA nodes in a previously allocated dummy physical memory.
>>> This function can be used in place of setup_memblock() in tests that need
>>> to simulate a NUMA system.
>>>
>>> setup_numa_memblock():
>>> - allows for setting up a memory layout by specifying the fraction of
>>>     MEM_SIZE in each node
>>>
>>> Set CONFIG_NODES_SHIFT to 4 when building with NUMA=1 to allow for up to
>>> 16 NUMA nodes.
>>>
>>> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
>>> ---
>>>    .../testing/memblock/scripts/Makefile.include |  2 +-
>>>    tools/testing/memblock/tests/common.c         | 29 +++++++++++++++++++
>>>    tools/testing/memblock/tests/common.h         |  4 ++-
>>>    3 files changed, 33 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/testing/memblock/scripts/Makefile.include b/tools/testing/memblock/scripts/Makefile.include
>>> index aa6d82d56a23..998281723590 100644
>>> --- a/tools/testing/memblock/scripts/Makefile.include
>>> +++ b/tools/testing/memblock/scripts/Makefile.include
>>> @@ -3,7 +3,7 @@
>>>    # Simulate CONFIG_NUMA=y
>>>    ifeq ($(NUMA), 1)
>>> -	CFLAGS += -D CONFIG_NUMA
>>> +	CFLAGS += -D CONFIG_NUMA -D CONFIG_NODES_SHIFT=4
>>>    endif
>>>    # Use 32 bit physical addresses.
>>> diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
>>> index eec6901081af..b6110df21b2a 100644
>>> --- a/tools/testing/memblock/tests/common.c
>>> +++ b/tools/testing/memblock/tests/common.c
>>> @@ -72,6 +72,35 @@ void setup_memblock(void)
>>>    	fill_memblock();
>>>    }
>>> +/**
>>> + * setup_numa_memblock:
>>> + * Set up a memory layout with multiple NUMA nodes in a previously allocated
>>> + * dummy physical memory.
>>> + * @nodes: an array containing the denominators of the fractions of MEM_SIZE
>>> + *         contained in each node (e.g., if nodes[0] = SZ_8, node 0 will
>>> + *         contain 1/8th of MEM_SIZE)
>>> + *
>>> + * The nids will be set to 0 through NUMA_NODES - 1.
>>> + */
>>> +void setup_numa_memblock(const phys_addr_t nodes[])
>>> +{
>>> +	phys_addr_t base;
>>> +	int flags;
>>> +
>>> +	reset_memblock_regions();
>>> +	base = (phys_addr_t)memory_block.base;
>>> +	flags = (movable_node_is_enabled()) ? MEMBLOCK_NONE : MEMBLOCK_HOTPLUG;
>>> +
>>> +	for (int i = 0; i < NUMA_NODES; i++) {
>>> +		assert(nodes[i] <= MEM_SIZE && nodes[i] > 0);
>>
>> I think it would be even easier to get if this would just be a fraction.
>> E.g., instead of "1/8 * MEM_SIZE" just "1/8". All values have to add up to
>> 1.
>>
>> ... but then we'd have to mess with floats eventually, so I guess this makes
>> it easier to handle these fractions.
>>
>>
>> We could use "int" and simply specify the fraction in percent, like
>>
>> nodes[0] = 50;
>> nodes[1] = 25;
>> nodes[2] = 25;
>>
>> and everything has to add up to 100.
>>
> This would still be a float for 1/8th (12.5) and 1/16th (6.25). What if
> it was the "percent" of 256 (i.e., 0x100)?

Right, or in something "smaller" like 1/32 th. I don't think we go below 
that?

If we don't need more digits, why not in "basis points" (per ten thousand)
-> https://en.wikipedia.org/wiki/Basis_point

nodes[0] = 5000; /* 1/2  */
nodes[1] = 2500; /* 1/4 */
nodes[2] = 1250; /* 1/8 */
nodes[4] = 0625; /* 1/32 */
nodes[5] = 0625;


>>
>>> +		phys_addr_t size = MEM_SIZE / nodes[i];
>>
>>
>> Hmmm, assuming a single node with "MEM_SIZE", we would get size=1.
>>
> For a single node of MEM_SIZE, nodes[0] would be 1.
> 
>> Shouldn't this be "size = nodes[i]"
>>
>> ?
> No, not with the current implementation. The nodes array stores the
> denominator of the fraction that will be multiplied by MEM_SIZE to
> determine the size of that node (the numerator is always 1). So if the
> size of the node should be 1/8 * MEM_SIZE, the nodes array just stores
> the 8. I think the name of the array is misleading. Do you have any
> suggestions for a better name?

Then I am confused about the
	assert(nodes[i] <= MEM_SIZE && nodes[i] > 0);

assertion :)

I think it would really be best to just store the actual fraction 
somehow. But maybe just I am confused :)

-- 
Thanks,

David / dhildenb

