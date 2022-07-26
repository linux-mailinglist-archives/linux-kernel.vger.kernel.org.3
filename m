Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F84B58093A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 04:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiGZCB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 22:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiGZCB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 22:01:57 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1E320F65
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 19:01:55 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LsKpg03KwzkXF6;
        Tue, 26 Jul 2022 09:59:23 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 10:01:53 +0800
Subject: Re: [PATCH 5/5] hugetlbfs: fix confusing hugetlbfs stat
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     <akpm@linux-foundation.org>, <songmuchun@bytedance.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220721131637.6306-1-linmiaohe@huawei.com>
 <20220721131637.6306-6-linmiaohe@huawei.com> <YtnvFBn8tSm7y/mV@monkey>
 <f277d8ac-8091-78b4-e168-5dfd87314889@huawei.com> <Ytsq6TEsXzyedpH+@monkey>
 <e6e2de0d-ee72-4572-75c5-02cb27e7ae95@huawei.com> <Yt8p+5FrU3XpFlxv@monkey>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b2fea016-7e42-f4a6-43db-d995316485e1@huawei.com>
Date:   Tue, 26 Jul 2022 10:01:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Yt8p+5FrU3XpFlxv@monkey>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/26 7:40, Mike Kravetz wrote:
> On 07/23/22 10:56, Miaohe Lin wrote:
>> On 2022/7/23 6:55, Mike Kravetz wrote:
>>> On 07/22/22 14:38, Miaohe Lin wrote:
>>>> On 2022/7/22 8:28, Mike Kravetz wrote:
>>>>> On 07/21/22 21:16, Miaohe Lin wrote:
>>>>>> When size option is not specified, f_blocks, f_bavail and f_bfree will be
>>>>>> set to -1 instead of 0. Likewise, when nr_inodes is not specified, f_files
>>>>>> and f_ffree will be set to -1 too. Check max_hpages and max_inodes against
>>>>>> -1 first to make sure 0 is reported for max/free/used when no limit is set
>>>>>> as the comment states.
>>>>>
>>>>> Just curious, where are you seeing values reported as -1?  The check
>>>>
>>>> From the standard statvfs() function.
>>>>
>>>>> for sbinfo->spool was supposed to handle these cases.  Seems like it
>>>>
>>>> sbinfo->spool could be created when ctx->max_hpages == -1 while
>>>> ctx->min_hpages != -1 in hugetlbfs_fill_super.
>>>>
>>>>> should handle the max_hpages == -1 case.  But, it doesn't look like it
>>>>> considers the max_inodes == -1 case.
>>>>>
>>>>> If I create/mount a hugetlb filesystem without specifying size or nr_inodes,
>>>>> df seems to report zero instead of -1.
>>>>>
>>>>> Just want to understand the reasoning behind the change.
>>>
>>> Thanks for the additional information (and test program)!
>>>
>>> >From the hugetlbfs documentation:
>>> "If the ``size``, ``min_size`` or ``nr_inodes`` option is not provided on
>>>  command line then no limits are set."
>>>
>>> So, having those values set to -1 indicates there is no limit set.
>>>
>>> With this change, 0 is reported for the case where there is no limit set as
>>> well as the case where the max value is 0.
>>
>> IMHO, 0 should not be a valid max value otherwise there will be no hugetlb pages
>> to use. It should mean there's no limit. But maybe I'm wrong.
> 
> I agree that 0 as a max value makes little sense.  However, it is allowed
> today and from what I can tell it is file system specific.  So, there is no
> defined behavior.

So it might be better to keep the code as is.

> 
>>
>>>
>>> There may be some value in reporting -1 as is done today.
>>
>> There still be a inconsistency:
>>
>> If the ``size`` and ``min_size`` isn't specified, then reported max value is 0.
>> But if ``min_size`` is specified while ``size`` isn't specified, the reported
>> max value is -1.
>>
> 
> Agree that this is inconsistent and confusing.
> 
> In the case where min_size and size is not specified, -1 for size still may
> make sense.  min_size specifies how many pages are reserved for use by the
> filesystem.  The only required relation between min_size and size is that if
> size is specified, then min_size must be smaller.  Otherwise, it makes no
> sense to reserve pages (min_size) that can not be used.
> 
>>> To be honest, I am not sure what is the correct behavior here.  Unless
>>> there is a user visible issue/problem, I am hesitant to change.  Other
>>> opinions are welcome.
>>
>> Yes, it might be better to keep it as is. Maybe we could change the comment to
>> reflect what the current behavior is like below?
>>
>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
>> index 44da9828e171..f03b1a019cc0 100644
>> --- a/fs/hugetlbfs/inode.c
>> +++ b/fs/hugetlbfs/inode.c
>> @@ -1080,7 +1080,7 @@ static int hugetlbfs_statfs(struct dentry *dentry, struct kstatfs *buf)
>>         buf->f_bsize = huge_page_size(h);
>>         if (sbinfo) {
>>                 spin_lock(&sbinfo->stat_lock);
>> -               /* If no limits set, just report 0 for max/free/used
>> +               /* If no limits set, just report 0 or -1 for max/free/used
>>                  * blocks, like simple_statfs() */
>>                 if (sbinfo->spool) {
>>                         spin_lock_irq(&sbinfo->spool->lock);
>>
>>>
>>
>> No strong opinion to keep this patch or above change. Many thanks for your comment and reply. :)
>>
> 
> I am fine with the comment change.  Thanks for reading through the code and
> trying to make sense of it!

I will do it in next version. Many thanks for your time.

> 

