Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5AA564576
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 08:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbiGCGud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 02:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiGCGu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 02:50:29 -0400
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr [80.12.242.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CD46578
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 23:50:24 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 7tQyovloGEMbD7tQyoi3Jm; Sun, 03 Jul 2022 08:50:22 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 03 Jul 2022 08:50:22 +0200
X-ME-IP: 90.11.190.129
Message-ID: <4dc5d50a-2291-1d3a-efac-3f6378a15d69@wanadoo.fr>
Date:   Sun, 3 Jul 2022 08:50:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/4] bitmap: Introduce bitmap_size()
Content-Language: en-US
To:     Yury Norov <yury.norov@gmail.com>
Cc:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        vneethv@linux.ibm.com, oberpar@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        almaz.alexandrovich@paragon-software.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        linux-s390@vger.kernel.org, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Newsgroups: gmane.linux.kernel.janitors,gmane.linux.kernel.device-mapper.devel,gmane.linux.kernel
References: <cover.1656785856.git.christophe.jaillet@wanadoo.fr>
 <98f5d3d855a9c687ccc035edf62016b02a6876b7.1656785856.git.christophe.jaillet@wanadoo.fr>
 <YsC0GpltMVaCPhkJ@yury-laptop>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <YsC0GpltMVaCPhkJ@yury-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 02/07/2022 à 23:09, Yury Norov a écrit :
> On Sat, Jul 02, 2022 at 08:29:36PM +0200, Christophe JAILLET wrote:
>> The new bitmap_size() function returns the size, in bytes, of a bitmap.
>>
>> Remove the already existing bitmap_size() functions and macro in some
>> files.
>> These files already use the bitmap API and will use the new function
>> in bitmap.h automatically.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/md/dm-clone-metadata.c | 5 -----
>>   include/linux/bitmap.h         | 6 ++++++
>>   lib/math/prime_numbers.c       | 2 --
>>   3 files changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/md/dm-clone-metadata.c b/drivers/md/dm-clone-metadata.c
>> index c43d55672bce..47c1fa7aad8b 100644
>> --- a/drivers/md/dm-clone-metadata.c
>> +++ b/drivers/md/dm-clone-metadata.c
>> @@ -465,11 +465,6 @@ static void __destroy_persistent_data_structures(struct dm_clone_metadata *cmd)
>>   
>>   /*---------------------------------------------------------------------------*/
>>   
>> -static size_t bitmap_size(unsigned long nr_bits)
>> -{
>> -	return BITS_TO_LONGS(nr_bits) * sizeof(long);
>> -}
>> -
>>   static int __dirty_map_init(struct dirty_map *dmap, unsigned long nr_words,
>>   			    unsigned long nr_regions)
>>   {
>> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
>> index f091a1664bf1..f66fb98a4126 100644
>> --- a/include/linux/bitmap.h
>> +++ b/include/linux/bitmap.h
>> @@ -48,6 +48,7 @@ struct device;
>>    *  bitmap_equal(src1, src2, nbits)             Are *src1 and *src2 equal?
>>    *  bitmap_intersects(src1, src2, nbits)        Do *src1 and *src2 overlap?
>>    *  bitmap_subset(src1, src2, nbits)            Is *src1 a subset of *src2?
>> + *  bitmap_size(nbits)                          Size, in bytes, of a bitmap
>>    *  bitmap_empty(src, nbits)                    Are all bits zero in *src?
>>    *  bitmap_full(src, nbits)                     Are all bits set in *src?
>>    *  bitmap_weight(src, nbits)                   Hamming Weight: number set bits
>> @@ -124,6 +125,11 @@ unsigned long *bitmap_alloc_node(unsigned int nbits, gfp_t flags, int node);
>>   unsigned long *bitmap_zalloc_node(unsigned int nbits, gfp_t flags, int node);
>>   void bitmap_free(const unsigned long *bitmap);
>>   
>> +static __always_inline size_t bitmap_size(unsigned long nbits)
>> +{
>> +	return BITS_TO_LONGS(nbits) * sizeof(unsigned long);
>> +}
>> +
>>   /* Managed variants of the above. */
>>   unsigned long *devm_bitmap_alloc(struct device *dev,
>>   				 unsigned int nbits, gfp_t flags);
>> diff --git a/lib/math/prime_numbers.c b/lib/math/prime_numbers.c
>> index d42cebf7407f..d3b64b10da1c 100644
>> --- a/lib/math/prime_numbers.c
>> +++ b/lib/math/prime_numbers.c
>> @@ -6,8 +6,6 @@
>>   #include <linux/prime_numbers.h>
>>   #include <linux/slab.h>
>>   
>> -#define bitmap_size(nbits) (BITS_TO_LONGS(nbits) * sizeof(unsigned long))
>> -
> 
> This should be dropped, for sure, and kmalloc() at line 128 should be
> replaced with bitmap_alloc().

This kmalloc() is for a structure and a flexible array.

You mean re-arranging the code to allocate the structure alone at first, 
then the bitmap?

CJ

> 
> For the driver, we need to introduce bitmap_kvmalloc/bitmap_kvfree etc.
> 
>>   struct primes {
>>   	struct rcu_head rcu;
>>   	unsigned long last, sz;
>> -- 
>> 2.34.1
> 

