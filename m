Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4026558AA85
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240667AbiHEMJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiHEMJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:09:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F86928E21
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 05:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659701377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tfAY0OctIFwhY2dxc6t3vPJmdx9dX9vR5e4NaQbcGUc=;
        b=JqUcOuVWtcwSzN4FuN3uvar/U1xblJ9AX6hBYWfH78ay/Hvvi+zzcex8LA0S6zHckjacHW
        eSCVwXMeWhWMm0Yd6O7DIpkZOJ6lh8bGyngVgOw4vL5Qhiqe5kfAl2JMl02bi3kGJani0q
        uBW4bQKXRiQXmbjb3EsvzY6gFkiMwXQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-LvIkT9vaPSaxeOw171_YjA-1; Fri, 05 Aug 2022 08:09:35 -0400
X-MC-Unique: LvIkT9vaPSaxeOw171_YjA-1
Received: by mail-wm1-f70.google.com with SMTP id i9-20020a1c3b09000000b003a511239973so1514207wma.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 05:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=tfAY0OctIFwhY2dxc6t3vPJmdx9dX9vR5e4NaQbcGUc=;
        b=Hg85CSTVoXGRr+rAdIZPfrK7Ink5jLMs+r98n51FBbWhN0Ua4SbygDmoje8Asz0kBa
         0BKjZnJHJRPjPy8BOwtUeTv6tRrVkdPF+whij801Ib70mlVCSB1+bFQQDM/zl043+8yt
         JKFgzr7vJixVvD7Ij28PIiFYl3Ih6q9aWiR2106KTohiZyGl2bxRaOy4Ek/0kIooQxQT
         SQgdYODJkethJDD4GyBX9ExBb/fYUYY8mI1xFZ5c/LMSHcNlBcsfFxWjPfNikbnj2dYY
         YgMNtYOd8fykX3GsRsQoKCVWoeXrvnjTisAnjA4xjkC+HwCMR+ZnqZJ1fUdOUoS63VTT
         vw7A==
X-Gm-Message-State: ACgBeo2VuHWkz7xP7uY/kJxQ8YVuMqoKDxSxiPpmJNUWTlqbDEUG6X6L
        CwAYZKOUxXPHvNZw6n0aSKeo+r9LZvG6jMbAwuzBFqnK5RAQv3Ul5frSX0BLtEbw77MMHQsBOaY
        +JeiHHEeYP1dk9ZReHfDxLfJq
X-Received: by 2002:a05:6000:1379:b0:21f:c4d:957a with SMTP id q25-20020a056000137900b0021f0c4d957amr4235780wrz.210.1659701373611;
        Fri, 05 Aug 2022 05:09:33 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4KIyeyf2kV1/U5HQgcYIKESpAYnB5Rpy18WHdGgXasfneZBXhzdedc2vFgJWSbeAMW30V03w==
X-Received: by 2002:a05:6000:1379:b0:21f:c4d:957a with SMTP id q25-20020a056000137900b0021f0c4d957amr4235739wrz.210.1659701373283;
        Fri, 05 Aug 2022 05:09:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:fb00:f5c3:24b2:3d03:9d52? (p200300cbc706fb00f5c324b23d039d52.dip0.t-ipconnect.de. [2003:cb:c706:fb00:f5c3:24b2:3d03:9d52])
        by smtp.gmail.com with ESMTPSA id bh19-20020a05600c3d1300b003a2f6367049sm4449097wmb.48.2022.08.05.05.09.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 05:09:32 -0700 (PDT)
Message-ID: <cb9d3310-3bc0-8ecf-5e71-becce980235f@redhat.com>
Date:   Fri, 5 Aug 2022 14:09:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv7 02/14] mm: Add support for unaccepted memory
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>, marcelo.cerri@canonical.com,
        tim.gardner@canonical.com, khalid.elmously@canonical.com,
        philip.cox@canonical.com, x86@kernel.org, linux-mm@kvack.org,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-3-kirill.shutemov@linux.intel.com>
 <8cf143e7-2b62-1a1e-de84-e3dcc6c027a4@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <8cf143e7-2b62-1a1e-de84-e3dcc6c027a4@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.08.22 13:49, Vlastimil Babka wrote:
> On 6/14/22 14:02, Kirill A. Shutemov wrote:
>> UEFI Specification version 2.9 introduces the concept of memory
>> acceptance. Some Virtual Machine platforms, such as Intel TDX or AMD
>> SEV-SNP, require memory to be accepted before it can be used by the
>> guest. Accepting happens via a protocol specific to the Virtual Machine
>> platform.
>>
>> There are several ways kernel can deal with unaccepted memory:
>>
>>  1. Accept all the memory during the boot. It is easy to implement and
>>     it doesn't have runtime cost once the system is booted. The downside
>>     is very long boot time.
>>
>>     Accept can be parallelized to multiple CPUs to keep it manageable
>>     (i.e. via DEFERRED_STRUCT_PAGE_INIT), but it tends to saturate
>>     memory bandwidth and does not scale beyond the point.
>>
>>  2. Accept a block of memory on the first use. It requires more
>>     infrastructure and changes in page allocator to make it work, but
>>     it provides good boot time.
>>
>>     On-demand memory accept means latency spikes every time kernel steps
>>     onto a new memory block. The spikes will go away once workload data
>>     set size gets stabilized or all memory gets accepted.
>>
>>  3. Accept all memory in background. Introduce a thread (or multiple)
>>     that gets memory accepted proactively. It will minimize time the
>>     system experience latency spikes on memory allocation while keeping
>>     low boot time.
>>
>>     This approach cannot function on its own. It is an extension of #2:
>>     background memory acceptance requires functional scheduler, but the
>>     page allocator may need to tap into unaccepted memory before that.
>>
>>     The downside of the approach is that these threads also steal CPU
>>     cycles and memory bandwidth from the user's workload and may hurt
>>     user experience.
>>
>> Implement #2 for now. It is a reasonable default. Some workloads may
>> want to use #1 or #3 and they can be implemented later based on user's
>> demands.
>>
>> Support of unaccepted memory requires a few changes in core-mm code:
>>
>>   - memblock has to accept memory on allocation;
>>
>>   - page allocator has to accept memory on the first allocation of the
>>     page;
>>
>> Memblock change is trivial.
>>
>> The page allocator is modified to accept pages on the first allocation.
>> The new page type (encoded in the _mapcount) -- PageUnaccepted() -- is
>> used to indicate that the page requires acceptance.
>>
>> Architecture has to provide two helpers if it wants to support
>> unaccepted memory:
>>
>>  - accept_memory() makes a range of physical addresses accepted.
>>
>>  - range_contains_unaccepted_memory() checks anything within the range
>>    of physical addresses requires acceptance.
>>
>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Acked-by: Mike Rapoport <rppt@linux.ibm.com>	# memblock
>> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> Hmm I realize it's not ideal to raise this at v7, and maybe it was discussed
> before, but it's really not great how this affects the core page allocator
> paths. Wouldn't it be possible to only release pages to page allocator when
> accepted, and otherwise use some new per-zone variables together with the
> bitmap to track how much exactly is where to accept? Then it could be hooked
> in get_page_from_freelist() similarly to CONFIG_DEFERRED_STRUCT_PAGE_INIT -
> if we fail zone_watermark_fast() and there are unaccepted pages in the zone,
> accept them and continue. With a static key to flip in case we eventually
> accept everything. Because this is really similar scenario to the deferred
> init and that one was solved in a way that adds minimal overhead.

I kind of like just having the memory stats being correct (e.g., free
memory) and acceptance being an internal detail to be triggered when
allocating pages -- just like the arch_alloc_page() callback.

I'm sure we could optimize for the !unaccepted memory via static keys
also in this version with some checks at the right places if we find
this to hurt performance?

-- 
Thanks,

David / dhildenb

