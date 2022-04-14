Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7585C5003E2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 03:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239555AbiDNB5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 21:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239548AbiDNB5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 21:57:34 -0400
Received: from support.corp-email.com (support.corp-email.com [222.73.234.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C052CC8F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 18:55:06 -0700 (PDT)
Received: from ([114.119.32.142])
        by support.corp-email.com ((D)) with ASMTP (SSL) id IVQ00159;
        Thu, 14 Apr 2022 09:54:59 +0800
Received: from [172.16.35.4] (172.16.35.4) by GCY-MBS-28.TCL.com (10.136.3.28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 14 Apr
 2022 09:54:59 +0800
Message-ID: <39c4ded0-09c0-3e38-85cb-5535099b177d@tcl.com>
Date:   Thu, 14 Apr 2022 09:54:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] f2fs: avoid deadlock in gc thread under low memory
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <tang.ding@tcl.com>
References: <660530eb62e71fb6520d3596704162e5@sslemail.net>
 <YlcBxSA5qYN4z1ia@google.com>
From:   Wu Yan <wu-yan@tcl.com>
In-Reply-To: <YlcBxSA5qYN4z1ia@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.35.4]
X-ClientProxiedBy: GCY-EXS-21.TCL.com (10.74.128.61) To GCY-MBS-28.TCL.com
 (10.136.3.28)
tUid:   2022414095459fee587205794eb62e0e39d5e16303e5f
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 01:00, Jaegeuk Kim wrote:
> On 04/13, Rokudo Yan wrote:
>> There is a potential deadlock in gc thread may happen
>> under low memory as below:
>>
>> gc_thread_func
>>   -f2fs_gc
>>    -do_garbage_collect
>>     -gc_data_segment
>>      -move_data_block
>>       -set_page_writeback(fio.encrypted_page);
>>       -f2fs_submit_page_write
>> as f2fs_submit_page_write try to do io merge when possible, so the
>> encrypted_page is marked PG_writeback but may not submit to block
>> layer immediately, if system enter low memory when gc thread try
>> to move next data block, it may do direct reclaim and enter fs layer
>> as below:
>>     -move_data_block
>>      -f2fs_grab_cache_page(index=?, for_write=false)
>>       -grab_cache_page
>>        -find_or_create_page
>>         -pagecache_get_page
>>          -__page_cache_alloc --  __GFP_FS is set
>>           -alloc_pages_node
>>            -__alloc_pages
>>             -__alloc_pages_slowpath
>>              -__alloc_pages_direct_reclaim
>>               -__perform_reclaim
>>                -try_to_free_pages
>>                 -do_try_to_free_pages
>>                  -shrink_zones
>>                   -mem_cgroup_soft_limit_reclaim
>>                    -mem_cgroup_soft_reclaim
>>                     -mem_cgroup_shrink_node
>>                      -shrink_node_memcg
>>                       -shrink_list
>>                        -shrink_inactive_list
>>                         -shrink_page_list
>>                          -wait_on_page_writeback -- the page is marked
>>                         writeback during previous move_data_block call
>>
>> the gc thread wait for the encrypted_page writeback complete,
>> but as gc thread held sbi->gc_lock, the writeback & sync thread
>> may blocked waiting for sbi->gc_lock, so the bio contain the
>> encrypted_page may nerver submit to block layer and complete the
>> writeback, which cause deadlock. To avoid this deadlock condition,
>> we mark the gc thread with PF_MEMALLOC_NOFS flag, then it will nerver
>> enter fs layer when try to alloc cache page during move_data_block.
>>
>> Signed-off-by: Rokudo Yan <wu-yan@tcl.com>
>> ---
>>   fs/f2fs/gc.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index e020804f7b07..cc71f77b98c8 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -38,6 +38,12 @@ static int gc_thread_func(void *data)
>>   
>>   	wait_ms = gc_th->min_sleep_time;
>>   
>> +	/*
>> +	 * Make sure that no allocations from gc thread will ever
>> +	 * recurse to the fs layer to avoid deadlock as it will
>> +	 * hold sbi->gc_lock during garbage collection
>> +	 */
>> +	memalloc_nofs_save();
> 
> I think this cannot cover all the f2fs_gc() call cases. Can we just avoid by:
> 
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1233,7 +1233,7 @@ static int move_data_block(struct inode *inode, block_t bidx,
>                                  CURSEG_ALL_DATA_ATGC : CURSEG_COLD_DATA;
> 
>          /* do not read out */
> -       page = f2fs_grab_cache_page(inode->i_mapping, bidx, false);
> +       page = f2fs_grab_cache_page(inode->i_mapping, bidx, true);
>          if (!page)
>                  return -ENOMEM;
> 
> Thanks,
> 
>>   	set_freezable();
>>   	do {
>>   		bool sync_mode, foreground = false;
>> -- 
>> 2.25.1

Hi, Jaegeuk

I'm not sure if any other case may trigger the issue, but the stack 
traces I have caught so far are all the same as below:

f2fs_gc-253:12  D 226966.808196 572 302561 150976 0x1200840 0x0 572 
237207473347056
<ffffff889d88668c> __switch_to+0x134/0x150
<ffffff889e764b6c> __schedule+0xd5c/0x1100
<ffffff889e76554c> io_schedule+0x90/0xc0
<ffffff889d9fb880> wait_on_page_bit+0x194/0x208
<ffffff889da167b4> shrink_page_list+0x62c/0xe74
<ffffff889da1d354> shrink_inactive_list+0x2c0/0x698
<ffffff889da181f4> shrink_node_memcg+0x3dc/0x97c
<ffffff889da17d44> mem_cgroup_shrink_node+0x144/0x218
<ffffff889da6610c> mem_cgroup_soft_limit_reclaim+0x188/0x47c
<ffffff889da17a40> do_try_to_free_pages+0x204/0x3a0
<ffffff889da176c8> try_to_free_pages+0x35c/0x4d0
<ffffff889da05d60> __alloc_pages_nodemask+0x7a4/0x10d0
<ffffff889d9fc82c> pagecache_get_page+0x184/0x2ec
<ffffff889dbf8860> do_garbage_collect+0xfe0/0x2828
<ffffff889dbf7434> f2fs_gc+0x4a0/0x8ec
<ffffff889dbf6bf4> gc_thread_func+0x240/0x4d4
<ffffff889d8de9b0> kthread+0x17c/0x18c
<ffffff889d88567c> ret_from_fork+0x10/0x18

Thanks
yanwu
