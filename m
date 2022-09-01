Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578F75A9199
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbiIAIG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiIAIGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:06:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEDC399DC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662019612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dqPVrtOwWGCqcYDkakHKdTas6tpFK8zIdpjFxy7YvEE=;
        b=ROLrzLRMhqE2EUWS7+oIMNIQUhrdNajs1H4WC1Cm373az7O5XspEhsiojeLL2vzV3rgpMk
        tQtSVELrUSDievVaM7ayYrVdeG9DQwr/mXYLN6m8RXXZAK8nj95eFENRwPO0VXdrDv3hIv
        IErUtUDpKBPiAjz5yCUMe1Z4/5MUSBA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-649-PF-tO9LqMuqTZJUWyrtEkg-1; Thu, 01 Sep 2022 04:06:51 -0400
X-MC-Unique: PF-tO9LqMuqTZJUWyrtEkg-1
Received: by mail-wr1-f70.google.com with SMTP id t11-20020adfba4b000000b00226eb5f7564so885800wrg.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 01:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=dqPVrtOwWGCqcYDkakHKdTas6tpFK8zIdpjFxy7YvEE=;
        b=BiRU/tSmjbI8dUbSU1KsrxDzBbdzgdhWfGGQUzQihvVp/n3DLURvLmjjwgHtnnnsmf
         qymfn76ofLjIPcKYO3vkSwf0x50FIMkgeM2yxbf1O+8Q520mtOhtsI2yUK5OawnF7K6J
         9JBPljVUJYO7Kjn/mts7xfakl94Q3RAjbo+5cr4Cjb+vCseyeRc1kQ0qVEL0wfG6iIKr
         5Y8gYADTeuZEuqaeKNBXcJ/NDCc4dt193fyXV1CB719zTMA4M8MS8Y8P0PgHDJtkXyqt
         tgBbYoLbz5S3hjLbW3rVvYPjzFfgUe5QE2ydwFacnMZ1HNb9zORVqnWiNVBO90U5rW5U
         /TwA==
X-Gm-Message-State: ACgBeo3e0SI3GxAUFYjKJlQkooLZQumY7eJrhUAIpyEExz7SlcSboBBr
        L15mpXfwySVdl+tHzF0lhOMWmhRuqMgga3ls+dAqDwl8g1pZfHlGwiRjcrcr93V0CATc/VaPCF+
        BlGdIgMvO7jOQtEM9CB3JVPIM
X-Received: by 2002:a05:600c:358e:b0:3a5:f19d:28db with SMTP id p14-20020a05600c358e00b003a5f19d28dbmr4477729wmq.76.1662019610223;
        Thu, 01 Sep 2022 01:06:50 -0700 (PDT)
X-Google-Smtp-Source: AA6agR56CdGBcdfAUEu62KyI3cxizpsi0lfGeFDK2oviALHqdX9dLBLxRg/MEJEONW33aP8AvHXgiQ==
X-Received: by 2002:a05:600c:358e:b0:3a5:f19d:28db with SMTP id p14-20020a05600c358e00b003a5f19d28dbmr4477716wmq.76.1662019609965;
        Thu, 01 Sep 2022 01:06:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:9e00:fec0:7e96:15cb:742? (p200300cbc7079e00fec07e9615cb0742.dip0.t-ipconnect.de. [2003:cb:c707:9e00:fec0:7e96:15cb:742])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c510500b003a5f2cc2f1dsm5100452wms.42.2022.09.01.01.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 01:06:49 -0700 (PDT)
Message-ID: <7c83950c-6a83-e35b-0060-79b5df3bda56@redhat.com>
Date:   Thu, 1 Sep 2022 10:06:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/4] memblock tests: add simulation of physical memory
 with multiple NUMA nodes
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1660897864.git.remckee0@gmail.com>
 <0cfb3c69ba6ca9ff55e1fc2528d18d108416ba57.1660897864.git.remckee0@gmail.com>
 <329ab669-620c-ba9e-3c57-9cb90d55b942@redhat.com>
 <20220831034909.GA16092@sophie>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220831034909.GA16092@sophie>
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

On 31.08.22 05:49, Rebecca Mckeever wrote:
> On Tue, Aug 30, 2022 at 01:17:56PM +0200, David Hildenbrand wrote:
>> On 19.08.22 11:05, Rebecca Mckeever wrote:
>>> Add functions setup_numa_memblock_generic() and setup_numa_memblock()
>>> for setting up a memory layout with multiple NUMA nodes in a previously
>>> allocated dummy physical memory. These functions can be used in place of
>>> setup_memblock() in tests that need to simulate a NUMA system.
>>>
>>> setup_numa_memblock_generic():
>>> - allows for setting up a custom memory layout by specifying the amount
>>>   of memory in each node, the number of nodes, and a factor that will be
>>>   used to scale the memory in each node
>>>
>>> setup_numa_memblock():
>>> - allows for setting up a default memory layout
>>>
>>> Introduce constant MEM_FACTOR, which is used to scale the default memory
>>> layout based on MEM_SIZE.
>>>
>>> Set CONFIG_NODES_SHIFT to 4 when building with NUMA=1 to allow for up to
>>> 16 NUMA nodes.
>>>
>>> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
>>> ---
>>>  .../testing/memblock/scripts/Makefile.include |  2 +-
>>>  tools/testing/memblock/tests/common.c         | 38 +++++++++++++++++++
>>>  tools/testing/memblock/tests/common.h         |  9 ++++-
>>>  3 files changed, 47 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/testing/memblock/scripts/Makefile.include b/tools/testing/memblock/scripts/Makefile.include
>>> index aa6d82d56a23..998281723590 100644
>>> --- a/tools/testing/memblock/scripts/Makefile.include
>>> +++ b/tools/testing/memblock/scripts/Makefile.include
>>> @@ -3,7 +3,7 @@
>>>  
>>>  # Simulate CONFIG_NUMA=y
>>>  ifeq ($(NUMA), 1)
>>> -	CFLAGS += -D CONFIG_NUMA
>>> +	CFLAGS += -D CONFIG_NUMA -D CONFIG_NODES_SHIFT=4
>>>  endif
>>>  
>>>  # Use 32 bit physical addresses.
>>> diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
>>> index eec6901081af..15d8767dc70c 100644
>>> --- a/tools/testing/memblock/tests/common.c
>>> +++ b/tools/testing/memblock/tests/common.c
>>> @@ -34,6 +34,10 @@ static const char * const help_opts[] = {
>>>  
>>>  static int verbose;
>>>  
>>> +static const phys_addr_t node_sizes[] = {
>>> +	SZ_4K, SZ_1K, SZ_2K, SZ_2K, SZ_1K, SZ_1K, SZ_4K, SZ_1K
>>> +};
>>> +
>>>  /* sets global variable returned by movable_node_is_enabled() stub */
>>>  bool movable_node_enabled;
>>>  
>>> @@ -72,6 +76,40 @@ void setup_memblock(void)
>>>  	fill_memblock();
>>>  }
>>>  
>>> +/**
>>> + * setup_numa_memblock_generic:
>>> + * Set up a memory layout with multiple NUMA nodes in a previously allocated
>>> + * dummy physical memory.
>>> + * @nodes: an array containing the amount of memory in each node
>>> + * @node_cnt: the size of @nodes
>>> + * @factor: a factor that will be used to scale the memory in each node
>>> + *
>>> + * The nids will be set to 0 through node_cnt - 1.
>>> + */
>>> +void setup_numa_memblock_generic(const phys_addr_t nodes[],
>>> +				 int node_cnt, int factor)
>>> +{
>>> +	phys_addr_t base;
>>> +	int flags;
>>> +
>>> +	reset_memblock_regions();
>>> +	base = (phys_addr_t)memory_block.base;
>>> +	flags = (movable_node_is_enabled()) ? MEMBLOCK_NONE : MEMBLOCK_HOTPLUG;
>>> +
>>> +	for (int i = 0; i < node_cnt; i++) {
>>> +		phys_addr_t size = factor * nodes[i];
>>
>> I'm a bit lost why we need the factor if we already provide sizes in the
>> array.
>>
>> Can you enlighten me? :)
>>
>> Why can't we just stick to the sizes in the array?
>>
> Without the factor, some of the tests will break if we increase MEM_SIZE
> in the future (which we may need to do). I could rewrite them so that the
> factor is not needed, but I thought the code would be over-complicated if
> I did.

Independent of the suggestion from Mike, I wonder if we should really
care about (eventual) MEM_SIZE changes for now if not caring simplifies
the current code.

-- 
Thanks,

David / dhildenb

