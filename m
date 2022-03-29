Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4654EA4F2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 04:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiC2CON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 22:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiC2COM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 22:14:12 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DD423F3B5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 19:12:29 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KSCkM1X1MzZfh8;
        Tue, 29 Mar 2022 10:12:11 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 29 Mar 2022 10:12:26 +0800
Subject: Re: [PATCH] mm: shmem: make shmem_init return void
To:     Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Hugh Dickins <hughd@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220328112707.22217-1-linmiaohe@huawei.com>
 <CAMZfGtXccwgR6TxNJc6aYV+WGJvAWWAz=RXEHNWDwjKfV49JuA@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <67fb3ff7-f46a-985d-94ac-698885eb43c5@huawei.com>
Date:   Tue, 29 Mar 2022 10:12:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAMZfGtXccwgR6TxNJc6aYV+WGJvAWWAz=RXEHNWDwjKfV49JuA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/28 22:50, Muchun Song wrote:
> On Mon, Mar 28, 2022 at 7:44 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> The return value of shmem_init is never used. So we can make it
>> return void now.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  include/linux/shmem_fs.h | 2 +-
>>  mm/shmem.c               | 9 ++++-----
>>  2 files changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
>> index ab51d3cd39bd..3e915cc550bc 100644
>> --- a/include/linux/shmem_fs.h
>> +++ b/include/linux/shmem_fs.h
>> @@ -56,7 +56,7 @@ static inline struct shmem_inode_info *SHMEM_I(struct inode *inode)
>>   * Functions in mm/shmem.c called directly from elsewhere:
>>   */
>>  extern const struct fs_parameter_spec shmem_fs_parameters[];
>> -extern int shmem_init(void);
>> +extern void shmem_init(void);
>>  extern int shmem_init_fs_context(struct fs_context *fc);
>>  extern struct file *shmem_file_setup(const char *name,
>>                                         loff_t size, unsigned long flags);
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 529c9ad3e926..26e09a022087 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -3879,7 +3879,7 @@ static struct file_system_type shmem_fs_type = {
>>         .fs_flags       = FS_USERNS_MOUNT,
>>  };
>>
>> -int __init shmem_init(void)
>> +void __init shmem_init(void)
>>  {
>>         int error;
>>
>> @@ -3904,14 +3904,13 @@ int __init shmem_init(void)
>>         else
>>                 shmem_huge = SHMEM_HUGE_NEVER; /* just in case it was patched */
>>  #endif
>> -       return 0;
>> +       return;
>>
>>  out1:
>>         unregister_filesystem(&shmem_fs_type);
>>  out2:
>>         shmem_destroy_inodecache();
>>         shm_mnt = ERR_PTR(error);
>> -       return error;
>>  }
>>
>>  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && defined(CONFIG_SYSFS)
>> @@ -3989,14 +3988,14 @@ static struct file_system_type shmem_fs_type = {
>>         .fs_flags       = FS_USERNS_MOUNT,
>>  };
>>
>> -int __init shmem_init(void)
>> +void __init shmem_init(void)
>>  {
>>         BUG_ON(register_filesystem(&shmem_fs_type) != 0);
>>
>>         shm_mnt = kern_mount(&shmem_fs_type);
>>         BUG_ON(IS_ERR(shm_mnt));
>>
>> -       return 0;
>> +       return;
> 
> Weird. Using return at the end of a void function.

Thanks for review. And thanks Andrew for kindly fixing this. :)

> .
> 

