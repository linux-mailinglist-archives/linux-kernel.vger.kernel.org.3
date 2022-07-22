Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC0557E2CB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 16:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbiGVOHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 10:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiGVOHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 10:07:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 396B79EC76
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 07:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658498871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l8a/WRegPOdZwKugMYKaaY0XGl8Dn+IbhTpt/OWCmYM=;
        b=csrz1xSrykPZIysqSbKnNoCsWRCYfRbf8jdKTESCNbQD6mG+5bSmMq783Ej90xWxloXLDb
        gi3DZdv5nCDx6qCQD8Wzy+rYmFVIB96jw5pisJwya2d+4h9jbpFa9HZqitO7aEIwbuEF/K
        qvhEmQB122DmJ/nYxJ2tmBIKSbcy8jU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-tGF558X-P0qDYDZtWdaE6Q-1; Fri, 22 Jul 2022 10:07:50 -0400
X-MC-Unique: tGF558X-P0qDYDZtWdaE6Q-1
Received: by mail-wm1-f70.google.com with SMTP id h65-20020a1c2144000000b003a30cae106cso4488112wmh.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 07:07:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:organization:in-reply-to
         :content-transfer-encoding;
        bh=l8a/WRegPOdZwKugMYKaaY0XGl8Dn+IbhTpt/OWCmYM=;
        b=3ngqM4yb8xrJTGzZy7+ltMDYKCQiATHh9+LqrkXN47FlkWkJJcRDejNW4nsFL2OVu3
         JrjlERZKw6uzpVI6HmlY5hZS7CyBEHHnKy7hsR4HSzudUCSAQ+xTds8g9ASz1d2Ez8hH
         6jki/xRWBpJoIPq5LKmp1tUFSN1DKcKmUm7z8uFT5nFrYygJGjsCveQdXQp3E3bum39b
         SXlfpwVHnCRjTZv50GhJeBshuKbHjWk2bqEGkk8xGYZBXuITDJMPX3EDRgHxofwD+KdL
         DLU5pH+lGTAszvq5mpaZuH5vXJvYMFUib97AdGRL6tZdkoWSKRPIxa8oh2BptN+/FVAg
         z0Ug==
X-Gm-Message-State: AJIora8PFNtA5y2VuH2tXYwu5yPDIg+dkn/nLCCRnjSkLL4n8bUZTy+3
        yLWrxhLXvs+J2+8dRlgJML6VbRK0PJ3qcfXHCKDP4n49qO0PpJml7Ib3KgEnegpmsUFgpfe/zZP
        2ANwygXfZVZajGeTSJV63mLF6
X-Received: by 2002:a5d:53c9:0:b0:21d:62f8:f99f with SMTP id a9-20020a5d53c9000000b0021d62f8f99fmr87941wrw.214.1658498868939;
        Fri, 22 Jul 2022 07:07:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vSshwyGQ0KMdrtp15M6q3/lUK221PemuB2tK0wPeqzQSMsQkjQT4Af4VIpFnru8cRx2EZfXQ==
X-Received: by 2002:a5d:53c9:0:b0:21d:62f8:f99f with SMTP id a9-20020a5d53c9000000b0021d62f8f99fmr87909wrw.214.1658498868518;
        Fri, 22 Jul 2022 07:07:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:cb00:cd6b:7964:cc7d:b0e6? (p200300cbc707cb00cd6b7964cc7db0e6.dip0.t-ipconnect.de. [2003:cb:c707:cb00:cd6b:7964:cc7d:b0e6])
        by smtp.gmail.com with ESMTPSA id q5-20020a1ce905000000b003a0323463absm5206666wmc.45.2022.07.22.07.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 07:07:48 -0700 (PDT)
Message-ID: <5d6c745e-219c-3abf-a30d-b3fb8e8e752c@redhat.com>
Date:   Fri, 22 Jul 2022 16:07:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/3] selftests: soft-dirty: Add test for mprotect
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20220721183338.27871-1-peterx@redhat.com>
 <20220721183338.27871-3-peterx@redhat.com>
 <8fbbd68f-267c-1e0d-a578-7da4551c4c19@redhat.com>
 <Ytqpz03yRq+DlAdq@xz-m1.local>
 <8fd4d9fa-7370-3d97-20d0-a4dfed914600@redhat.com>
Organization: Red Hat
In-Reply-To: <8fd4d9fa-7370-3d97-20d0-a4dfed914600@redhat.com>
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

On 22.07.22 16:00, David Hildenbrand wrote:
> On 22.07.22 15:44, Peter Xu wrote:
>> On Fri, Jul 22, 2022 at 09:17:34AM +0200, David Hildenbrand wrote:
>>> On 21.07.22 20:33, Peter Xu wrote:
>>>> Add two soft-diryt test cases for mprotect() on both anon or file.
>>>
>>> s/soft-diryt/soft-dirty/
>>
>> Fixed.
>>
>>>
>>>>
>>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>>> ---
>>>>  tools/testing/selftests/vm/soft-dirty.c | 69 ++++++++++++++++++++++++-
>>>>  1 file changed, 68 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/testing/selftests/vm/soft-dirty.c b/tools/testing/selftests/vm/soft-dirty.c
>>>> index 08ab62a4a9d0..7d93906aa43f 100644
>>>> --- a/tools/testing/selftests/vm/soft-dirty.c
>>>> +++ b/tools/testing/selftests/vm/soft-dirty.c
>>>> @@ -121,13 +121,78 @@ static void test_hugepage(int pagemap_fd, int pagesize)
>>>>  	free(map);
>>>>  }
>>>>  
>>>> +static void test_mprotect(int pagemap_fd, int pagesize, bool anon)
>>>> +{
>>>> +	const char *type[] = {"file", "anon"};
>>>> +	const char *fname = "./soft-dirty-test-file";
>>>> +	int test_fd;
>>>> +	char *map;
>>>
>>> Instead of fname, unlink, open, close, unlink  you can use a tmpfile
>>>
>>> FILE *file;
>>>
>>> file = tmpfile();
>>> if (!file) {
>>> 	ksft_test_result_fail("tmpfile() failed\n");
>>> 	return;
>>> }
>>> test_fd = fileno(file);
>>
>> Note that tmpfile() should by default fetch from /tmp which is very
>> possibly a tmpfs afaict.  It's tricky in this special test case since I
>> don't think tmpfs can trigger this bug (shmem doesn't define page_mkwrite).
>>
> 
> I don't think we need that? SOFTDIRTY tracking enabled should be
> sufficient, or what am I missing?
> 

I think you're right that it doesn't work with tmpfile. I do wonder why,
because I'd have thought that it's sufficient for
vma_wants_writenotify() to return "1" due to the
vma_soft_dirty_enabled() check.

Hm ....

-- 
Thanks,

David / dhildenb

