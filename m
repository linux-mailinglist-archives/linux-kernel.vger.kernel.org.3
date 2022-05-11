Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F9B52325B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240563AbiEKMBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236601AbiEKMBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:01:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0121153E02
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652270497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wi7tUBG+u292GRef9SBFymEZGOLQSxAzizn9GnHgqZI=;
        b=SyqjYylgnsRq4/uHRiz7yaf2cwprGD1Hdhs+E5RwUJBKRuNn4F/Vl7d4zMrEdPrKkNxjgP
        jHwm17y1eZk/jGnul6DRnPpQQT72pD94Q2VMosgqXGswYtmQk4e6Vq7sRpKT2ToWvz+Cqy
        hSBQaJ1aVRXauyk383kgdOFMcgIpUSg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-577-zxBfwwiKPwmjlg2eYPRBvw-1; Wed, 11 May 2022 08:01:32 -0400
X-MC-Unique: zxBfwwiKPwmjlg2eYPRBvw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BC2E8015BA;
        Wed, 11 May 2022 12:01:25 +0000 (UTC)
Received: from [10.22.16.235] (unknown [10.22.16.235])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01F86400E122;
        Wed, 11 May 2022 12:01:24 +0000 (UTC)
Message-ID: <8f047351-c53e-ae9a-2d5e-f7c37f6bbdff@redhat.com>
Date:   Wed, 11 May 2022 08:01:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] locking/qrwlock: Reduce cacheline contention for
 rwlocks used in interrupt context
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220510192134.434753-1-longman@redhat.com>
 <20220510192134.434753-2-longman@redhat.com>
 <CAK8P3a3APecwzfS24Cc2f7rPdZXKU0Y9FB3RZNFTnRYnVXVQzg@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CAK8P3a3APecwzfS24Cc2f7rPdZXKU0Y9FB3RZNFTnRYnVXVQzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/22 03:20, Arnd Bergmann wrote:
> On Tue, May 10, 2022 at 9:21 PM Waiman Long <longman@redhat.com> wrote:
>> Even though qrwlock is supposed to be a fair lock, it does allow readers
>> from interrupt context to spin on the lock until it can acquire it making
>> it not as fair. This exception was added due to the requirement to allow
>> recursive read lock in interrupt context. This can also be achieved by
>> just ignoring the writer waiting bit without spinning on the lock.
>>
>> By making this change, we make qrwlock a bit more fair and eliminating
>> the problem of cacheline bouncing for rwlocks that are used heavily in
>> interrupt context, like the networking stack. This should also reduce
>> the chance of lock starvation for those interrupt context rwlocks.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   include/asm-generic/qrwlock.h |  6 +++---
>>   kernel/locking/qrwlock.c      | 17 ++++++-----------
>>   2 files changed, 9 insertions(+), 14 deletions(-)
> I have no opinion on the change itself, but I made sure this does
> not conflict with the generic ticket spinlock changes that I merged
> in the asm-generic tree, since those also touch the comments in
> qrwlock.h [1]
>
> I assume you are merging both patches through the tip tree, so

Yes, it is based on the latest tip tree.

Cheers,
Longman

