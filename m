Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B83F57E2C6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 16:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbiGVOBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 10:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235538AbiGVOAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 10:00:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4C5F2408F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 07:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658498426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EYLb6RY2ueWnVYybTZA3yk/81e2BTNzZgl+I9HRbCgI=;
        b=F10RZK34KlPjrsJ6UBFjLZwREGf5IqLw6Bg2M/h8Rh6zh7MuqeHXnWQvd4nloqKnvCXrHt
        k3tZr7M87OmZufy/MalIm/v9AeGY6wKg1p8qtJN1FoXlgyW7YegF9sMVbQp9GjVa9+vEag
        H8w80EUzY5/1FVjZbEfUCEbvugMBJXo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-D7ZJo2YZPYO7Au7qttF0DQ-1; Fri, 22 Jul 2022 10:00:25 -0400
X-MC-Unique: D7ZJo2YZPYO7Au7qttF0DQ-1
Received: by mail-wm1-f69.google.com with SMTP id c126-20020a1c3584000000b003a02fa133ceso2584892wma.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 07:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=EYLb6RY2ueWnVYybTZA3yk/81e2BTNzZgl+I9HRbCgI=;
        b=qusKk4DWfrrCZdGrEiWKE2VIaf/Wrs3qB88X0PQGrvr/iIhREfIOag5sj5SpqcPHr/
         HUBqvPNTvShLnWX323b2fuZalEZdBDk6nZ7Q8GlyajRQHhxJSKWMM0kcLGJoPn2gN3Ly
         sXcwzdHIZDIAc+BN15AuqbXJOGYmkpb7FWDWnL6tha70p7imX9alaIF1HGEJreOS6L81
         qbmrXf+fw4R7MAYifkwDoHGAojXsBr7LKnKFYJKBv67NC4cw+n5055CkP8hKmVE43u0X
         T+yiEPbdIHFHkOrV1cvH78ZQgpUkWtgttb+30xwQ8ZZVMBIAjazmkX94V9NccACuE08s
         OKXA==
X-Gm-Message-State: AJIora93Cu85NW3v8OemkBFDCAJ/jUK+MTzi7oz0QzqNtNwlvAIz5TPb
        cNQUY7jszKPctJ+eqLsol0334QTWaFZ/LiWWaIYPk8aezcEumJasdSQL+ftbEutAGqmswcf/53h
        GxFFqaswma58ScWuGN+/JLY/Y
X-Received: by 2002:a05:600c:1f0a:b0:3a3:15a8:a8e1 with SMTP id bd10-20020a05600c1f0a00b003a315a8a8e1mr595210wmb.167.1658498424198;
        Fri, 22 Jul 2022 07:00:24 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s8ZOURDBaUw+YZ7e4WCDD2+8cifIOmHl8p0TJdZ6Na8HH6aIEI8WrytCsO1vPoqo/9EqL/og==
X-Received: by 2002:a05:600c:1f0a:b0:3a3:15a8:a8e1 with SMTP id bd10-20020a05600c1f0a00b003a315a8a8e1mr595180wmb.167.1658498423796;
        Fri, 22 Jul 2022 07:00:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:cb00:cd6b:7964:cc7d:b0e6? (p200300cbc707cb00cd6b7964cc7db0e6.dip0.t-ipconnect.de. [2003:cb:c707:cb00:cd6b:7964:cc7d:b0e6])
        by smtp.gmail.com with ESMTPSA id l10-20020a7bc34a000000b003a30f84a9aasm5040435wmj.26.2022.07.22.07.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 07:00:23 -0700 (PDT)
Message-ID: <8fd4d9fa-7370-3d97-20d0-a4dfed914600@redhat.com>
Date:   Fri, 22 Jul 2022 16:00:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/3] selftests: soft-dirty: Add test for mprotect
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20220721183338.27871-1-peterx@redhat.com>
 <20220721183338.27871-3-peterx@redhat.com>
 <8fbbd68f-267c-1e0d-a578-7da4551c4c19@redhat.com>
 <Ytqpz03yRq+DlAdq@xz-m1.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Ytqpz03yRq+DlAdq@xz-m1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.07.22 15:44, Peter Xu wrote:
> On Fri, Jul 22, 2022 at 09:17:34AM +0200, David Hildenbrand wrote:
>> On 21.07.22 20:33, Peter Xu wrote:
>>> Add two soft-diryt test cases for mprotect() on both anon or file.
>>
>> s/soft-diryt/soft-dirty/
> 
> Fixed.
> 
>>
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>  tools/testing/selftests/vm/soft-dirty.c | 69 ++++++++++++++++++++++++-
>>>  1 file changed, 68 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/vm/soft-dirty.c b/tools/testing/selftests/vm/soft-dirty.c
>>> index 08ab62a4a9d0..7d93906aa43f 100644
>>> --- a/tools/testing/selftests/vm/soft-dirty.c
>>> +++ b/tools/testing/selftests/vm/soft-dirty.c
>>> @@ -121,13 +121,78 @@ static void test_hugepage(int pagemap_fd, int pagesize)
>>>  	free(map);
>>>  }
>>>  
>>> +static void test_mprotect(int pagemap_fd, int pagesize, bool anon)
>>> +{
>>> +	const char *type[] = {"file", "anon"};
>>> +	const char *fname = "./soft-dirty-test-file";
>>> +	int test_fd;
>>> +	char *map;
>>
>> Instead of fname, unlink, open, close, unlink  you can use a tmpfile
>>
>> FILE *file;
>>
>> file = tmpfile();
>> if (!file) {
>> 	ksft_test_result_fail("tmpfile() failed\n");
>> 	return;
>> }
>> test_fd = fileno(file);
> 
> Note that tmpfile() should by default fetch from /tmp which is very
> possibly a tmpfs afaict.  It's tricky in this special test case since I
> don't think tmpfs can trigger this bug (shmem doesn't define page_mkwrite).
> 

I don't think we need that? SOFTDIRTY tracking enabled should be
sufficient, or what am I missing?

-- 
Thanks,

David / dhildenb

