Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0BC5649B9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 22:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiGCUlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 16:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbiGCUle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 16:41:34 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA452BED
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 13:41:32 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 86PIo6R3j5ohR86PIo6kvF; Sun, 03 Jul 2022 22:41:30 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 03 Jul 2022 22:41:30 +0200
X-ME-IP: 90.11.190.129
Message-ID: <effcd39c-7f86-5f69-0663-4b81015cfc7c@wanadoo.fr>
Date:   Sun, 3 Jul 2022 22:41:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/4] bitmap: Introduce bitmap_size()
Content-Language: en-US
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        vneethv@linux.ibm.com, oberpar@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        almaz.alexandrovich@paragon-software.com, linux@rasmusvillemoes.dk,
        linux-s390@vger.kernel.org, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <cover.1656785856.git.christophe.jaillet@wanadoo.fr>
 <98f5d3d855a9c687ccc035edf62016b02a6876b7.1656785856.git.christophe.jaillet@wanadoo.fr>
 <YsC0GpltMVaCPhkJ@yury-laptop>
 <4dc5d50a-2291-1d3a-efac-3f6378a15d69@wanadoo.fr>
 <YsGz1Xp0RDM5ZhVY@smile.fi.intel.com> <YsHqRDfCQVwyA2m1@yury-laptop>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <YsHqRDfCQVwyA2m1@yury-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 03/07/2022 à 21:13, Yury Norov a écrit :
> On Sun, Jul 03, 2022 at 06:20:53PM +0300, Andy Shevchenko wrote:
>> On Sun, Jul 03, 2022 at 08:50:19AM +0200, Christophe JAILLET wrote:
>>> Le 02/07/2022 à 23:09, Yury Norov a écrit :
>>>> On Sat, Jul 02, 2022 at 08:29:36PM +0200, Christophe JAILLET wrote:
>>
>> ...
>>
>>>> This should be dropped, for sure, and kmalloc() at line 128 should be
>>>> replaced with bitmap_alloc().
>>>
>>> This kmalloc() is for a structure and a flexible array.
>>>
>>> You mean re-arranging the code to allocate the structure alone at first,
>>> then the bitmap?
> 
> We can change struct primes to:
>          struct primes {
>                  struct rcu_head rcu;
>                  unsigned long last, sz;
>                  unsigned long *primes;
>          };
> 
> And then either allocate twice:
>          new = kmalloc(sizeof(struct primes);
>          new->primes = bitmap_alloc(sz);
> 
> Or keep the same struct primes for all expansions, and just allocate
> new bitmap for ->primes when needed. This is what I meant.
> 
> This a bit deeper rework, but it addresses Andy's concern about excessive
> fragmentation. (Did anyone before complain? Is it measurable?)
> 
>> It's one way, but it will increase fragmentation of memory. The other one
>> as it seems to me is to name a new API properly, i.e. bitmap_size_to_bytes().
>>
>> In such case you won't need renames to begin with. And then would be able
>> to convert driver-by-driver in cases of duplicated code.
>>
>> I think that's what confused Yuri and I kinda agree that bitmap_size() should
>> return bits, and not bytes. Also argument for pure bitmap_size() would be
>> bitmap itself, but we have no way to detect the length of bitmap because we
>> are using POD and not a specific data structure for it.
> 
> bitmap_size_to_bytes() sounds better. How many places in the kernel
> do we have where we can't simply use bitmap_alloc(), and need this
> machinery? If this is the only one, I'd prefer to switch it to
> bitmap_alloc() instead.

I'll spot some places that would require a bitmap_size_to_bytes().

This way, we'll have some more information to decide if:
    - bitmap_size_to_bytes() makes sense or not
    - other helper functions are better suited
    - these places need some rework to use the existing API

CJ

> 
> Thanks,
> Yury
> 

