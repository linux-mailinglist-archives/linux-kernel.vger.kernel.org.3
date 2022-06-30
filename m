Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EB5561783
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 12:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbiF3KR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 06:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbiF3KRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:17:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E852E44A3F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 03:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656584272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rOCaXt8+HI3g+OU53dq0jNzOP8yzJQrPf6iSdbWrmX0=;
        b=H+j8mQMAw5V8myNujkptqhOtTM82Pd131aSBoVZ9h2bKnu9AclhM/qmL1qrgDhB9paKluB
        lvINsmb2Ohznb3qrDIxksAeh41idz2Jkot07VsVHq3ZXeTswl/gWh6WsazuC5UNP1KXVjR
        b/oKfNr/8n5DSCsmeBnIjAWE9Nk2Ofg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-A4mvq5CKO1KrdFy3ZneTBw-1; Thu, 30 Jun 2022 06:17:51 -0400
X-MC-Unique: A4mvq5CKO1KrdFy3ZneTBw-1
Received: by mail-wr1-f72.google.com with SMTP id l9-20020adfa389000000b0021b8b489336so2982770wrb.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 03:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=rOCaXt8+HI3g+OU53dq0jNzOP8yzJQrPf6iSdbWrmX0=;
        b=x83/Tq9v4uXpLmJU/3fMnpc1/UNoqrYtnmpmx8clV9r+DAci3BH2DugtsvMW8Znjiq
         ezhVnF/jeBJMT9PoVwU9CuRO0DXcp4PoGtSpfOP4QBgknSzzVWsVfbGBL12sqjlMIAdv
         4+u/nHN7L6Qx3YEDtqI+N5qAFJVadmvYMj/w7mUgWOMJMkQw5kz2HCkTlBJ3M3EYu6WB
         jZfvBT9LviUSPwFLTNN2HPJPhzScFA6DgNll7UGQi5VkZyemUmmG15hJelH8Y1mfPsEY
         At56W5oSz8rOhiTso0hklGxP7MA4K2dcWj+UyrTJj0qV7PHc2t1VBTFnT4EP3AcZNcrH
         HWPw==
X-Gm-Message-State: AJIora+s/64BuzOgzu4xMXIvGvGf+YCjGJvpQDvw+jg1EElA0Ur0NJoh
        KsJg8aeUR+zmODbz42Ep4AAUFWEVrvu4l5euC4jNMC5OduVBlvyEu2eOuJ5DlPn8EMHaErJmr/q
        xYcx9qPINq/F3oA2BgBXlebe9
X-Received: by 2002:a5d:614e:0:b0:21b:9736:736f with SMTP id y14-20020a5d614e000000b0021b9736736fmr7440514wrt.200.1656584270290;
        Thu, 30 Jun 2022 03:17:50 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sgc41nSJcu5H7wXynnBC8/ogLJm7VRvadyqJgAdRtVWl7h++SF77QONlxdgvS7LCUtRpuoJw==
X-Received: by 2002:a5d:614e:0:b0:21b:9736:736f with SMTP id y14-20020a5d614e000000b0021b9736736fmr7440487wrt.200.1656584269979;
        Thu, 30 Jun 2022 03:17:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:7f00:214b:cffb:c693:2b71? (p200300cbc7087f00214bcffbc6932b71.dip0.t-ipconnect.de. [2003:cb:c708:7f00:214b:cffb:c693:2b71])
        by smtp.gmail.com with ESMTPSA id t8-20020adfdc08000000b0021350f7b22esm19187608wri.109.2022.06.30.03.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 03:17:49 -0700 (PDT)
Message-ID: <ef1620a2-dbc6-911e-5cd0-e860ad7772e0@redhat.com>
Date:   Thu, 30 Jun 2022 12:17:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4 2/4] memblock tests: add verbose output to memblock
 tests
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1656368930.git.remckee0@gmail.com>
 <883c28e34527fd4cdc55df97c791ed8b2e79538d.1656368930.git.remckee0@gmail.com>
 <5db2944e-9d64-8faa-83d3-fd02fce583bd@redhat.com> <YryG1nuJ+nL9maeS@bertie>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YryG1nuJ+nL9maeS@bertie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.06.22 19:07, Rebecca Mckeever wrote:
> On Wed, Jun 29, 2022 at 01:34:54PM +0200, David Hildenbrand wrote:
>> On 28.06.22 00:34, Rebecca Mckeever wrote:
>>> Add and use functions and macros for printing verbose testing output.
>>>
>>> If the Memblock simulator was compiled with VERBOSE=1:
>>> - prefix_push(): appends the given string to a prefix string that will be
>>>   printed in test_fail() and test_pass*().
>>>
>>> - prefix_pop(): removes the last prefix from the prefix string.
>>>
>>> - prefix_reset(): clears the prefix string.
>>>
>>> - test_fail(): prints a message after a test fails containing the test
>>>   number of the failing test and the prefix.
>>>
>>> - test_pass(): prints a message after a test passes containing its test
>>>   number and the prefix.
>>>
>>> - test_print(): prints the given formatted output string.
>>>
>>> - test_pass_pop(): runs test_pass() followed by prefix_pop().
>>>
>>> - PREFIX_PUSH(): runs prefix_push(__func__).
>>>
>>> If the Memblock simulator was not compiled with VERBOSE=1, these
>>> functions/macros do nothing.
>>>
>>> Add the assert wrapper macros ASSERT_EQ(), ASSERT_NE(), and ASSERT_LT().
>>> If the assert condition fails, these macros call test_fail() before
>>> executing assert().
>>>
>>> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
>>
>>
>> [...]
>>
>>>  
>>> diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
>>> index 62d3191f7c9a..e55b2a8bf0ff 100644
>>> --- a/tools/testing/memblock/tests/common.c
>>> +++ b/tools/testing/memblock/tests/common.c
>>> @@ -4,8 +4,12 @@
>>>  
>>>  #define INIT_MEMBLOCK_REGIONS			128
>>>  #define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
>>> +#define PREFIXES_LEN_MAX			256
>>> +#define DELIM					": "
>>> +#define DELIM_LEN				strlen(DELIM)
>>
>> Why not simply
>>
>> #define PREFIXES_MAX	15
>> static const char * __maybe_unused prefixes[PREFIXES_MAX];
>> static int nr_prefixes;
>>
>> And then simply insert/clear the corresponding prefixes[] pointer and
>> update nr_prefixes?
>>
>> When printing, you only have to walk prefixes from 0 ... nr_prefixes - 1
>> and print the values.
>>
>> Avoids any string modifications.
>>
> What is nr_prefixes? Number of prefixes? Currently, the longest prefix is
> 49 characters (alloc_try_nid_bottom_up_reserved_with_space_check), so I
> think PREFIXES_MAX would need to be at least 52 (including the delimiter),
> but let me know if I'm misunderstanding.

nr_prefixes would be the current number of prefixes (not the length).

You be storing pointers to strings in the constant pool, not copying the
strings over.

-- 
Thanks,

David / dhildenb

