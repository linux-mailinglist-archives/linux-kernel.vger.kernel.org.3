Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FDC467228
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 07:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350792AbhLCGqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 01:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbhLCGqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 01:46:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AAAC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 22:43:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C0DBB82503
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 06:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D45C53FC7;
        Fri,  3 Dec 2021 06:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638513790;
        bh=kQWKSO8pVmVc/VLBP9zNwAX6yT8k5Pr0J8RSVBiVfaI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WwC8BxpfO2TuNdW4uXsFfDxb+u6oAr8/34p0TlPWAkhqPoonzlTKeB8wXWjWoGWOm
         t9q4avoQmUNpr8E3RixVNx/jgGAI9zqr3vF9InWRfRiCJxOYqZD0jB78eHG4oiN0hC
         tQTo2EEsIwROfLlVJt+8NCwgygmZrEiZ3/sI5x59pNrzQlVm6i6AQY3cr0dw49tyGz
         dGcJaiwWXKhLGMKe9bRNRVyjqvUF28f66YhByoDcWQwArQ3/s0739TRuMvbM7dSHFN
         lfGPhi/YdLHBjTDHHM7xbE4NbzWK6ZieUE9DfTJFkSKM2ILWqYgsU6YoEL93+n3tsJ
         bJduLTm+/Y5gg==
Message-ID: <9b637c29-f9c7-5928-cf2e-346253bb00c7@kernel.org>
Date:   Fri, 3 Dec 2021 14:43:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [f2fs-dev] [PATCH 2/6] f2fs: do not expose unwritten blocks to
 user by DIO
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20211116214510.2934905-1-jaegeuk@kernel.org>
 <20211116214510.2934905-2-jaegeuk@kernel.org>
 <6576ab84-7441-e594-a7c4-e5876a814df7@kernel.org>
 <YakMtRif1f0cXT6R@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <YakMtRif1f0cXT6R@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/3 2:13, Jaegeuk Kim wrote:
> On 12/02, Chao Yu wrote:
>> On 2021/11/17 5:45, Jaegeuk Kim wrote:
>>> DIO preallocates physical blocks before writing data, but if an error occurrs
>>> or power-cut happens, we can see block contents from the disk. This patch tries
>>> to fix it by 1) turning to buffered writes for DIO into holes, 2) truncating
>>> unwritten blocks from error or power-cut.
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>    fs/f2fs/data.c |  5 ++++-
>>>    fs/f2fs/f2fs.h |  5 +++++
>>>    fs/f2fs/file.c | 24 +++++++++++++++++++++++-
>>>    3 files changed, 32 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index 3b27fb7daa8b..7ac1a39fcad2 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -1543,8 +1543,11 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>>>    					flag != F2FS_GET_BLOCK_DIO);
>>>    				err = __allocate_data_block(&dn,
>>>    							map->m_seg_type);
>>> -				if (!err)
>>> +				if (!err) {
>>> +					if (flag == F2FS_GET_BLOCK_PRE_DIO)
>>> +						file_need_truncate(inode);
>>>    					set_inode_flag(inode, FI_APPEND_WRITE);
>>> +				}
>>>    			}
>>>    			if (err)
>>>    				goto sync_out;
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index be871a79c634..14bea669f87e 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -654,6 +654,7 @@ enum {
>>>    #define FADVISE_KEEP_SIZE_BIT	0x10
>>>    #define FADVISE_HOT_BIT		0x20
>>>    #define FADVISE_VERITY_BIT	0x40
>>> +#define FADVISE_TRUNC_BIT	0x80
>>>    #define FADVISE_MODIFIABLE_BITS	(FADVISE_COLD_BIT | FADVISE_HOT_BIT)
>>> @@ -681,6 +682,10 @@ enum {
>>>    #define file_is_verity(inode)	is_file(inode, FADVISE_VERITY_BIT)
>>>    #define file_set_verity(inode)	set_file(inode, FADVISE_VERITY_BIT)
>>> +#define file_should_truncate(inode)	is_file(inode, FADVISE_TRUNC_BIT)
>>> +#define file_need_truncate(inode)	set_file(inode, FADVISE_TRUNC_BIT)
>>> +#define file_dont_truncate(inode)	clear_file(inode, FADVISE_TRUNC_BIT)
>>> +
>>>    #define DEF_DIR_LEVEL		0
>>>    enum {
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>> index 4bf77a5bf998..ec8de0662437 100644
>>> --- a/fs/f2fs/file.c
>>> +++ b/fs/f2fs/file.c
>>> @@ -960,10 +960,21 @@ int f2fs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
>>>    		down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>>>    		filemap_invalidate_lock(inode->i_mapping);
>>> +		/*
>>> +		 * Truncate stale preallocated blocks used by the previous DIO.
>>> +		 */
>>> +		if (file_should_truncate(inode)) {
>>> +			err = f2fs_truncate(inode);
>>> +			if (err)
>>> +				goto out_unlock;
>>> +			file_dont_truncate(inode);
>>> +		}
>>> +
>>>    		truncate_setsize(inode, attr->ia_size);
>>>    		if (attr->ia_size <= old_size)
>>>    			err = f2fs_truncate(inode);
>>> +out_unlock:
>>>    		/*
>>>    		 * do not trim all blocks after i_size if target size is
>>>    		 * larger than i_size.
>>> @@ -4257,6 +4268,13 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter)
>>>    	/* If it will be an out-of-place direct write, don't bother. */
>>>    	if (dio && f2fs_lfs_mode(sbi))
>>>    		return 0;
>>> +	/*
>>> +	 * Don't preallocate holes aligned to DIO_SKIP_HOLES which turns into
>>> +	 * buffered IO, if DIO meets any holes.
>>> +	 */
>>> +	if (dio && i_size_read(inode) &&
>>> +		(F2FS_BYTES_TO_BLK(pos) < F2FS_BLK_ALIGN(i_size_read(inode))))
>>> +		return 0;
>>>    	/* No-wait I/O can't allocate blocks. */
>>>    	if (iocb->ki_flags & IOCB_NOWAIT)
>>> @@ -4366,10 +4384,14 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>>    		if (preallocated > 0 && i_size_read(inode) < target_size) {
>>>    			down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>>>    			filemap_invalidate_lock(inode->i_mapping);
>>> -			f2fs_truncate(inode);
>>> +			if (!f2fs_truncate(inode))
>>> +				file_dont_truncate(inode);
>>>    			filemap_invalidate_unlock(inode->i_mapping);
>>>    			up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>>> +		} else {
>>> +			file_dont_truncate(inode);
>>
>> How about this case:
>>
>> - touch file
>> - DIO write [0, 8kb] to file
>>   - preallocate 2 physical blocks
>>   - set FADVISE_TRUNC_BIT
>>   - SPO
>> - BUFIO write [0, 4kb] to file
>>   - file_dont_truncate -- it leaks unwritten [4kb, 8kb] to user after
>> truncating file to 8kb
> 
> i_size should be 4kb, no?

- BUFIO write [0, 4kb] to file
  - file_dont_truncate()
i_size should be 4kb, w/ FADVISE_TRUNC_BIT

- setattr 8kb
i_size should be 8kb, last [4kb, 8kb] is unwritten

Thanks,

> 
>>
>> Thanks,
>>
>>>    		}
>>> +
>>>    		clear_inode_flag(inode, FI_PREALLOCATED_ALL);
>>>    		if (ret > 0)
>>>
