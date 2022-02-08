Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E004ACE52
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344214AbiBHBtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243058AbiBHBlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 20:41:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39A6C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 17:41:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 942D2B8162F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 01:41:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB48C004E1;
        Tue,  8 Feb 2022 01:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644284481;
        bh=PG9nKdSqWU1EyxwFEOiE2jtWbEBP0UISJyN0lr1Jgm0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mukdVPz8iz27i3XxSqkquq48InSHqIdLsdRhR5iezeRL045AFH6w96WDUFzJP+IPr
         4LvHUYmFkVrpJHVMO1tV+0BMNX5nOzHyGlS7LlAPbkCmUGE6GfMrrfvN+Gyt0MW2gz
         uAeTL3qumz68uA6fGQ/ysQcUZppseIEPibqUfTupUyxEH+EcPIcPBdbKe2/1Wfn/oJ
         kkd86XF4bAcoGMZ95g9nzDPLV0mIRWRk9KtoWT2QVD8fK4ECtaNkTc5slGRLRugjQT
         nJH07CZIcHdLRDViva9SYxnQcdm4Tts52j2xAoo9ywF4stJEDA8TO3AUfxpQCr62j2
         p+ILdmY+rJFAA==
Message-ID: <917b4044-80ce-cd46-520b-8325a011631f@kernel.org>
Date:   Tue, 8 Feb 2022 09:41:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2] f2fs: skip f2fs_preallocate_blocks() for overwrite
 case
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20220204091005.49407-1-chao@kernel.org>
 <YgFv85dH0dWFTZBx@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <YgFv85dH0dWFTZBx@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/2/8 3:16, Jaegeuk Kim wrote:
> On 02/04, Chao Yu wrote:
>> There is potential hangtask happened during swapfile's writeback:
>>
>> - loop_kthread_worker_fn		- do_checkpoint
>>    - kthread_worker_fn
>>     - loop_queue_work
>>      - lo_rw_aio
>>       - f2fs_file_write_iter
>>        - f2fs_preallocate_blocks
>>         - f2fs_map_blocks
>> 					 - down_write
>>          - down_read
>>           - rwsem_down_read_slowpath
>>            - schedule
>>
>> One cause is f2fs_preallocate_blocks() will always be called no matter
>> the physical block addresses are allocated or not.
>>
>> This patch tries to check whether block addresses are all allocated with
>> i_size and i_blocks of inode, it's rough because blocks can be allocated
>> beyond i_size, however, we can afford skipping block preallocation in this
>> condition since it's not necessary to do preallocation all the time.
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> v2:
>> - check overwrite case with i_size and i_blocks roughly.
>>   fs/f2fs/file.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index cfdc41f87f5d..09565d10611d 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -4390,6 +4390,16 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
>>   	int flag;
>>   	int ret;
>>   
>> +	/*
>> +	 * It tries to check whether block addresses are all allocated,
>> +	 * it's rough because blocks can be allocated beyond i_size,
>> +	 * however, we can afford skipping block preallocation since
>> +	 * it's not necessary all the time.
>> +	 */
>> +	if (F2FS_BLK_ALIGN(i_size_read(inode)) ==
>> +			SECTOR_TO_BLOCK(inode->i_blocks))
> 
> Do we count i_blocks only for data?

Oops, it seems it's not...

Needs to introduce another function to calculate node block count based on i_size?

Thanks,

> 
>> +		return 0;
>> +
>>   	/* If it will be an out-of-place direct write, don't bother. */
>>   	if (dio && f2fs_lfs_mode(sbi))
>>   		return 0;
>> -- 
>> 2.32.0
