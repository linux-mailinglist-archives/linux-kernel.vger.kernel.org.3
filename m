Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDE054DA75
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359066AbiFPGWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358508AbiFPGWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:22:02 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FB353C5F;
        Wed, 15 Jun 2022 23:22:00 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LNsWb38z3zDrGr;
        Thu, 16 Jun 2022 14:21:31 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 16 Jun 2022 14:21:57 +0800
Subject: Re: [PATCH -next] ext4: fix bug_on in ext4_iomap_begin as race
 between bmap and write
To:     Jan Kara <jack@suse.cz>, Ritesh Harjani <ritesh.list@gmail.com>
References: <20220615135850.1961759-1-yebin10@huawei.com>
 <20220615152139.vp64tnv46enwnfcs@riteshh-domain>
 <20220615153123.ab32zt75q7yn7jc5@riteshh-domain>
 <20220615172609.oydxhjw7exas23hd@quack3.lan>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   yebin <yebin10@huawei.com>
Message-ID: <62AACC05.3030207@huawei.com>
Date:   Thu, 16 Jun 2022 14:21:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20220615172609.oydxhjw7exas23hd@quack3.lan>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/16 1:26, Jan Kara wrote:
> On Wed 15-06-22 21:01:23, Ritesh Harjani wrote:
>> On 22/06/15 08:51PM, Ritesh Harjani wrote:
>>> On 22/06/15 09:58PM, Ye Bin wrote:
>>>> We got issue as follows:
>>>> ------------[ cut here ]------------
>>>> WARNING: CPU: 3 PID: 9310 at fs/ext4/inode.c:3441 ext4_iomap_begin+0x182/0x5d0
>>>> RIP: 0010:ext4_iomap_begin+0x182/0x5d0
>>>> RSP: 0018:ffff88812460fa08 EFLAGS: 00010293
>>>> RAX: ffff88811f168000 RBX: 0000000000000000 RCX: ffffffff97793c12
>>>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
>>>> RBP: ffff88812c669160 R08: ffff88811f168000 R09: ffffed10258cd20f
>>>> R10: ffff88812c669077 R11: ffffed10258cd20e R12: 0000000000000001
>>>> R13: 00000000000000a4 R14: 000000000000000c R15: ffff88812c6691ee
>>>> FS:  00007fd0d6ff3740(0000) GS:ffff8883af180000(0000) knlGS:0000000000000000
>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> CR2: 00007fd0d6dda290 CR3: 0000000104a62000 CR4: 00000000000006e0
>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>> Call Trace:
>>>>   iomap_apply+0x119/0x570
>>>>   iomap_bmap+0x124/0x150
>>>>   ext4_bmap+0x14f/0x250
>>>>   bmap+0x55/0x80
>>>>   do_vfs_ioctl+0x952/0xbd0
>>>>   __x64_sys_ioctl+0xc6/0x170
>>>>   do_syscall_64+0x33/0x40
>>>>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>>
>>>> Above issue may happen as follows:
>>>>            bmap                    write
>>>> bmap
>>>>    ext4_bmap
>>>>      iomap_bmap
>>>>        ext4_iomap_begin
>>>>                              ext4_file_write_iter
>>>> 			      ext4_buffered_write_iter
>>>> 			        generic_perform_write
>>>> 				  ext4_da_write_begin
>>>> 				    ext4_da_write_inline_data_begin
>>>> 				      ext4_prepare_inline_data
>>>> 				        ext4_create_inline_data
>>>> 					  ext4_set_inode_flag(inode,
>>>> 						EXT4_INODE_INLINE_DATA);
>>>>        if (WARN_ON_ONCE(ext4_has_inline_data(inode))) ->trigger bug_on
>>>>
>>>> To solved above issue hold inode lock in ext4_bamp.
>>> 											^^^ ext4_bmap()
>>>
>>> I checked the paths where bmap() kernel api can be called i.e. from jbd2/fc and
>>> generic_swapfile_activate() (apart from ioctl())
>>> For jbd2, it will be called with j_inode within bmap(), hence taking a inode lock
>>> of the inode passed within ext4_bmap() (j_inode in this case) should be safe here.
>>> Same goes with swapfile path as well.
>>>
>>> However I feel maybe we should hold inode_lock_shared() since there is no
>>> block/extent map layout changes that can happen via ext4_bmap().
>>> Hence read lock is what IMO should be used here.
>> On second thoughts, shoudn't we use ext4_iomap_report_ops here?  Can't
>> recollect why we didn't use ext4_iomap_report_ops for iomap_bmap() in the
>> first place. Should be good to verify it once.
> Hum, but I guess there's a deeper problem than ext4_bmap(). Generally we
> have places doing block mapping (such as ext4_writepages(), readahead, or
> page fault) where we don't hold i_rwsem and racing
> ext4_create_inline_data() could confuse them? I guess we need to come up
> with a sound scheme how inline data creation is serialized with these
> operations (or just decide to remove the inline data feature altogether as
> we already discussed once because the complexity likely is not worth the
> gain).
>
> 								Honza
Indeed, this feature has various concurrency problems. At present, there 
is no scenario
using this feature in the actual production environment. However, 
various problems in
the code are easy to be exploited by attackers if they are not solved.
Do I fix this single point problem or remove inline data feature?

