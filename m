Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A5D4E3EAD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 13:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbiCVMng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 08:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbiCVMnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:43:35 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A6B85961
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 05:42:08 -0700 (PDT)
Received: from [192.168.12.80] (unknown [182.2.69.158])
        by gnuweeb.org (Postfix) with ESMTPSA id 5614E7E2BC;
        Tue, 22 Mar 2022 12:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647952927;
        bh=wEvnoUYj5ItswMTYHtWE6EYw1sIxWYk5k1yPNx8RgUo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bKvuMOfW27+DJg7Cb3IpAkuLP43KoZHx8Z4IArrq2g8zvnixi0UFKCkRnZqe4ZvKo
         5UqtiZsNZgxIqlegbzo84BeNcSTxnrjejdDkzIg8lSCYzz7JCXRPaQukDE81e0Drkq
         gn9W1bYkv6FszyNdyAKcdtqq8vtdm2OVH/K0WaU7WjVYkvVO7rhT2dKeaEiZdHIAav
         M4Me5jw/ku/x6dVDGk03VbLK6hwZSMcUtXSmWHEyjqVliQLMqbcwbvNSA76Q/sQPha
         DemYIPB8jbR90pan0w9VBdWr7icJaMvj0Th8KVYcjEedA42MIwEfcT0SyfUbhGZTJE
         S4Tr9XT3nzpcA==
Message-ID: <8e3470c9-8bfd-3397-03c7-9bd77ed1ae06@gnuweeb.org>
Date:   Tue, 22 Mar 2022 19:42:02 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v2 6/8] tools/nolibc/stdlib: Implement `malloc()`,
 `calloc()`, `realloc()` and `free()`
Content-Language: en-US
To:     Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Cc:     David Laight <David.Laight@aculab.com>, Willy Tarreau <w@1wt.eu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
References: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
 <20220322102115.186179-7-ammarfaizi2@gnuweeb.org>
 <56935393241242adab6f32c50dd74c23@AcuMS.aculab.com>
 <28dd5f67-0c59-8ea0-8798-55757a6b05f6@gnuweeb.org>
 <CAOG64qP2qiyOQaTJ56Cg2w=Q=euDbSjqkOVOLKJHMq-xAS2U7Q@mail.gmail.com>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <CAOG64qP2qiyOQaTJ56Cg2w=Q=euDbSjqkOVOLKJHMq-xAS2U7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/22 7:36 PM, Alviro Iskandar Setiawan wrote:
> On Tue, Mar 22, 2022 at 7:18 PM Ammar Faizi wrote:
>> Rounding up is not useful here, because we don't have any free list to keep
>> track the unused block of memory. I mean, even if it's rounded up, the extra
>> space after rounded up cannot be utilized with this design. There is no
>> book-keeping that tracks it.
>>
>> Though, the kernel still allocates the size in multiple page size.
> 
> BTW, what David meant probably, don't call mmap() again if heap->len
> is greater than new_len. Isn't that simple enough to give it a go?

Ah yes, I get the idea now, it shouldn't be a burden for this series. I
think that small improvement is not too overkill. So I will take that
suggestion for the next series.

Thanks!

-- 
Ammar Faizi
