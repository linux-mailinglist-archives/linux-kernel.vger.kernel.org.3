Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4D0567654
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbiGESWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbiGESWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:22:23 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A42193DF;
        Tue,  5 Jul 2022 11:22:21 -0700 (PDT)
Received: from [192.168.1.186] (S010674d02b5e9d39.lb.shawcable.net [68.144.200.120])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id D6ED5424DB;
        Tue,  5 Jul 2022 18:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1657045339;
        bh=uUoaIPkkkNHECoED5te93hLiKvEQRvPs48n63ZXrwdY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=u09+jmIxvK4FGuINTXpH5ZYLChqkAL6Bss+I5+nUK8pHLs9TL1VKNN3FaQlmBsVTX
         wicRjALJmR6DEtIfrTTQWWlYmtjEHhDsf6C9EF8XQYIV0gdg47vexUFDEXEEjGiU/s
         5Q5U8iArXvE3QmUlTJX9KJsLc2wVEHtQFohtaDejNp3FUK74FZplwNlczdg75VQUqe
         are593Z2QsMQIzbfdhbSR92Ua44UFZVDcUgIpooJOV6n48P7V1hbq71mnJNDZ25W1p
         OqR6v3NrYC68vYgQbdbjF2JhCayU3AeMPJ+mAXjkiXsvsMR1Em6zAtDJjcnLl/4sh3
         Yv1xu/5WEkoPw==
Message-ID: <67061a0e-5559-b79d-316e-228c7987dd7f@canonical.com>
Date:   Tue, 5 Jul 2022 11:22:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: linux-next: manual merge of the kunit-next tree with the apparmor
 tree
Content-Language: en-US
To:     David Gow <davidgow@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ricardo Ribalda <ribalda@chromium.org>
References: <20220405125540.2135d81d@canb.auug.org.au>
 <20220705091352.15150c7f@canb.auug.org.au>
 <CABVgOSkhSb1oVo90h8vOALZzJFCE-1GaiADFEEpXEYqrvHTS=g@mail.gmail.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <CABVgOSkhSb1oVo90h8vOALZzJFCE-1GaiADFEEpXEYqrvHTS=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/22 01:57, David Gow wrote:
> On Tue, Jul 5, 2022 at 7:14 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Hi all,
>>
>> On Tue, 5 Apr 2022 12:55:40 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>>
>>> Today's linux-next merge of the kunit-next tree got a conflict in:
>>>
>>>    security/apparmor/policy_unpack_test.c
>>>
>>> between commit:
>>>
>>>    d86d1652ab13 ("apparmor: test: Remove some casts which are no-longer required")
>>>
>>> from the apparmor tree and commit:
>>>
>>>    5f91bd9f1e7a ("apparmor: test: Use NULL macros")
>>>
>>> from the kunit-next tree.
>>>
>>> I fixed it up (see below) and can carry the fix as necessary. This
>>> is now fixed as far as linux-next is concerned, but any non trivial
>>> conflicts should be mentioned to your upstream maintainer when your tree
>>> is submitted for merging.  You may also want to consider cooperating
>>> with the maintainer of the conflicting tree to minimise any particularly
>>> complex conflicts.
>>>
>>>
>>> diff --cc security/apparmor/policy_unpack_test.c
>>> index 399dce3781aa,5c18d2f19862..000000000000
>>> --- a/security/apparmor/policy_unpack_test.c
>>> +++ b/security/apparmor/policy_unpack_test.c
>>> @@@ -408,8 -408,8 +408,8 @@@ static void policy_unpack_test_unpack_u
>>>
>>>        size = unpack_u16_chunk(puf->e, &chunk);
>>>
>>>   -    KUNIT_EXPECT_EQ(test, size, (size_t)0);
>>>   +    KUNIT_EXPECT_EQ(test, size, 0);
>>> -     KUNIT_EXPECT_PTR_EQ(test, chunk, NULL);
>>> +     KUNIT_EXPECT_NULL(test, chunk);
>>>        KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, puf->e->end - 1);
>>>    }
>>>
>>> @@@ -430,8 -430,8 +430,8 @@@ static void policy_unpack_test_unpack_u
>>>
>>>        size = unpack_u16_chunk(puf->e, &chunk);
>>>
>>>   -    KUNIT_EXPECT_EQ(test, size, (size_t)0);
>>>   +    KUNIT_EXPECT_EQ(test, size, 0);
>>> -     KUNIT_EXPECT_PTR_EQ(test, chunk, NULL);
>>> +     KUNIT_EXPECT_NULL(test, chunk);
>>>        KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, puf->e->start + TEST_U16_OFFSET);
>>>    }
>>>
>>
>> This is now a conflict between the apparmor tree and Linus' tree.
>>
> 
> Hmm... this patch -- d86d1652ab13 ("apparmor: test: Remove some casts
> which are no-longer required") -- has been sitting in the
> apparmor-next branch since December, but there haven't been any
> AppArmor pull requests since then.
> 
yeah sorry we had some testing infrastructure issues against the upstream kernel that
needed to be reworked, and I have been refusing to pull new stuff push a pull request
until we could get that fixed and have passing tests to ensure we weren't breaking
something, and this got caught up in that mess. That has finally happened this whole
lot that has been sitting can finally go up, and I can start merging in some of the
queued up new stuff.

> If it's easier, I'm happy to redo this and send it in via the KUnit
> tree (assuming it gets removed from apparmor-next). Otherwise, I guess
> this'll just have to wait for the next AppArmor PR.
> 
I have dropped it from apparmor-next for the moment. It can go up via KUnit or the
apparmor PR for 5.20.
