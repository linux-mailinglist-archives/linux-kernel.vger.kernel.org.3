Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600EA4FF597
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 13:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbiDMLWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 07:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiDMLWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 07:22:41 -0400
Received: from smtp233.corp-email.com (smtp233.corp-email.com [222.73.234.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF80255BC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:20:19 -0700 (PDT)
Received: from ([114.119.32.142])
        by smtp233.corp-email.com ((D)) with ASMTP (SSL) id IHI00009;
        Wed, 13 Apr 2022 19:20:09 +0800
Received: from [172.16.35.4] (172.16.35.4) by GCY-MBS-28.TCL.com (10.136.3.28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 13 Apr
 2022 19:20:00 +0800
Message-ID: <ff186d65-2103-b796-79b9-3eb4a3e04380@tcl.com>
Date:   Wed, 13 Apr 2022 19:20:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] f2fs: avoid deadlock in gc thread under low memory
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
CC:     <jaegeuk@kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <tang.ding@tcl.com>
References: <181ce21548da652d9a14eebc684fe75c@sslemail.net>
 <Ylab+Tz4d8kZYjef@dhcp22.suse.cz>
From:   Wu Yan <wu-yan@tcl.com>
In-Reply-To: <Ylab+Tz4d8kZYjef@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.35.4]
X-ClientProxiedBy: GCY-EXS-05.TCL.com (10.74.128.155) To GCY-MBS-28.TCL.com
 (10.136.3.28)
tUid:   2022413192009cdda9d904e4172743aab11da4840b35c
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/22 17:46, Michal Hocko wrote:
> On Wed 13-04-22 16:44:32, Rokudo Yan wrote:
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
> 
> This is a memcg reclaim path and you would have to have __GFP_ACCOUNT in
> the gfp mask to hit it from the page allocator. I am not really familiar
> with f2fs but I doubt it is using this flag.
> 
> On the other hand the memory is charged to a memcg when the newly
> allocated page is added to the page cache. That wouldn't trigger the
> soft reclaim path but that is not really necessary because even the
> regular memcg reclaim would trigger wait_on_page_writeback for cgroup
> v1.
> 
> Also are you sure that the mapping's gfp mask has __GFP_FS set for this
> allocation? f2fs_iget uses GFP_NOFS like mask for some inode types.
> 
> All that being said, you will need to change the above call chain but it
> would be worth double checking the dead lock is real.

Hi, Michal

1. The issue is occur when do monkey test in Android Device with 4GB RAM 
+ 3GB zram, and memory cgroup v1 enabled.

2. full memory dump has caught when the issue occur and the dead lock 
has confirmed from dump. We can see the mapping->gfp_mask is 0x14200ca,
so both __GFP_ACCOUNT(0x1000000) and __GFP_FS(0x80) set

crash-arm64> struct inode.i_mapping 0xFFFFFFDFD578EEA0
   i_mapping = 0xffffffdfd578f028,
crash-arm64> struct address_space.host,gfp_mask -x 0xffffffdfd578f028
   host = 0xffffffdfd578eea0,
   gfp_mask = 0x14200ca,

Thanks
yanwu
