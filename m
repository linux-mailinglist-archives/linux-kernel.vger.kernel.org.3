Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD52A5A244C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343685AbiHZJ2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237428AbiHZJ2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:28:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FF7D7D2F
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661506093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tZm8+FPJNVay8zI5ZDreamxl1om7Nr78rlpU7kmodO4=;
        b=A8Z6DApgLYFkQiBTtK1YaGAXgKyBF4HfBKGEFTeUZEvMci14veaMvhRfzbI0W1QsoQphB8
        InZl9c3pTTKUJWmT0cQ6InAOT7LjO+enIW4QmrO0vpN7kxbbyY+CNRaIQ9LNufkwE5Vt03
        HzuCrMNfI/CJ0DUMCPWKAfmVCu3vcxc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-662-DGhZ-JknPXWob9dkKP9__g-1; Fri, 26 Aug 2022 05:28:12 -0400
X-MC-Unique: DGhZ-JknPXWob9dkKP9__g-1
Received: by mail-wr1-f70.google.com with SMTP id s20-20020adf9794000000b002258607240eso106594wrb.23
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 02:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=tZm8+FPJNVay8zI5ZDreamxl1om7Nr78rlpU7kmodO4=;
        b=wbbi1etzbfhblyF0na/WBIfJIuL3Cvw8RJ+5PvpVOKZ98RwXWc32UD3nvv1bqd79Gy
         /RrMafh6+ES6C96FhvZCeg52GnksKoqTu548OzEDD+nq8Tn7WtpruqUc1MP+LG+QRZ9V
         4OJriaIvp6TRV3dQ4zTGc4W0sw3rc6NqSfynlY1WowNsQUWGfPqukGVFkkLIuvn0kNAd
         /K3MRYNGoJTyjETS3WK0Aw26VLqrx+h1BoM43yPHInM8YX4tkB1xAMDN58RgzOiEv5os
         5d35pRMOgpMsmSd1fi6nmJxUyY4OckQlPrqoa9xL6irp5tbx3upxJPk4IoUdp0LUyG/j
         6ljw==
X-Gm-Message-State: ACgBeo0uwb+4+Pc5gu01zgzrZqktq6fPWsIVdlqJUmve1JLjwaqlwbYR
        4l4yeSqUrHY2k0GJ569P46OubOxRac1sfvfHu5zK0kgOJ3sQfh/zja3/4oiDg1oeeEj1bQtDbyO
        oP7n3jAZedf9Q0hWhblWEpYIk
X-Received: by 2002:adf:9ccf:0:b0:225:4934:53e3 with SMTP id h15-20020adf9ccf000000b00225493453e3mr4509917wre.210.1661506091102;
        Fri, 26 Aug 2022 02:28:11 -0700 (PDT)
X-Google-Smtp-Source: AA6agR710MOt95gvLSyB2DYQA8RD1oC554oWsCWqEuY3W3PaubYO9NAho/V4h0PHCqjnn7amuZl2oA==
X-Received: by 2002:adf:9ccf:0:b0:225:4934:53e3 with SMTP id h15-20020adf9ccf000000b00225493453e3mr4509905wre.210.1661506090767;
        Fri, 26 Aug 2022 02:28:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:f600:abad:360:c840:33fa? (p200300cbc708f600abad0360c84033fa.dip0.t-ipconnect.de. [2003:cb:c708:f600:abad:360:c840:33fa])
        by smtp.gmail.com with ESMTPSA id v16-20020a5d6110000000b0021e13efa17esm1403883wrt.70.2022.08.26.02.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 02:28:09 -0700 (PDT)
Message-ID: <8092cd73-f165-9026-ea6e-076e6a96f206@redhat.com>
Date:   Fri, 26 Aug 2022 11:28:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 5/8] memblock tests: update alloc_api to test
 memblock_alloc_raw
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1660897732.git.remckee0@gmail.com>
 <48cfb01ba417895f28ce7ef9b99d1ce0854bfd5e.1660897732.git.remckee0@gmail.com>
 <d65cf9fe-e22c-7698-0313-879685f1319b@redhat.com>
 <20220825213546.GA13624@sophie>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220825213546.GA13624@sophie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.08.22 23:35, Rebecca Mckeever wrote:
> On Tue, Aug 23, 2022 at 11:49:46AM +0200, David Hildenbrand wrote:
>> On 19.08.22 10:34, Rebecca Mckeever wrote:
>>> Update memblock_alloc() tests so that they test either memblock_alloc()
>>> or memblock_alloc_raw() depending on the value of alloc_test_flags. Run
>>> through all the existing tests in memblock_alloc_api twice: once for
>>> memblock_alloc() and once for memblock_alloc_raw().
>>>
>>> When the tests run memblock_alloc(), they test that the entire memory
>>> region is zero. When the tests run memblock_alloc_raw(), they test that
>>> the entire memory region is nonzero.
>>
>> Could add a comment stating that we initialize the content to nonzero in
>> that case, and expect it to remain unchanged (== not zeroed).
>>
>>>
>>> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
>>> ---
>>>  tools/testing/memblock/tests/alloc_api.c | 98 ++++++++++++++++--------
>>>  tools/testing/memblock/tests/common.h    | 25 ++++++
>>>  2 files changed, 90 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/tools/testing/memblock/tests/alloc_api.c b/tools/testing/memblock/tests/alloc_api.c
>>> index 65bff77dd55b..cf67687ae044 100644
>>> --- a/tools/testing/memblock/tests/alloc_api.c
>>> +++ b/tools/testing/memblock/tests/alloc_api.c
>>> @@ -1,6 +1,29 @@
>>>  // SPDX-License-Identifier: GPL-2.0-or-later
>>>  #include "alloc_api.h"
>>>  
>>> +static const char * const func_testing[] = {
>>> +	"memblock_alloc",
>>> +	"memblock_alloc_raw"
>>> +};
>>> +
>>> +static int alloc_test_flags = TEST_ZEROED;
>>> +
>>> +static inline const char * const get_func_testing(int flags)
>>> +{
>>> +	if (flags & TEST_RAW)
>>> +		return func_testing[1];
>>> +	else
>>> +		return func_testing[0];
>>
>> No need for the else, you can return directly.
>>
>> Can we avoid the func_testing array?
>>
>>
>> Persoally, I consider the "get_func_testing()" name a bit confusing.
>>
>> get_memblock_alloc_name() ?
>>
>>
>>> diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
>>> index 58f84bf2c9ae..4fd3534ff955 100644
>>> --- a/tools/testing/memblock/tests/common.h
>>> +++ b/tools/testing/memblock/tests/common.h
>>> @@ -12,6 +12,11 @@
>>>  
>>>  #define MEM_SIZE SZ_16K
>>>  
>>> +enum test_flags {
>>> +	TEST_ZEROED = 0x0,
>>> +	TEST_RAW = 0x1
>>> +};
>>
>> I'd have called this
>>
>> enum test_flags {
>> 	/* No special request. */
>> 	TEST_F_NONE = 0x0,
>> 	/* Perform raw allocations (no zeroing of memory).
>> 	TEST_F_RAW = 0x1,
>> };
>>
>> Further, I'd just have use #define for the flags.
>>
> Do you mean use two #defines instead of the enum? I thought enums were
> preferred when defining related constants.

I guess we have a wild mixture of raw define, enums and __bitwise +
defines nowdays.

E.g., take a look at include/linux/rmap.h "typedef int __bitwise rmap_t"
and how it's used --  that seems to be the new "best" solution for use
in the kernel.

Having that said, feel free to just let it be an enum :)

-- 
Thanks,

David / dhildenb

