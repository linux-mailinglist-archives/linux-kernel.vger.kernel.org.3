Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58E44A95CA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 10:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354321AbiBDJK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 04:10:59 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35338 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241375AbiBDJK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:10:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C57A6120E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 09:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B216DC004E1;
        Fri,  4 Feb 2022 09:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643965857;
        bh=V0yE5hxMUdg9LANtbDXwIXfKd8UVrTrz86FSocO9m0M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bLr+sVeefq5BQhsVPxD6WVefhoHMwdbI/F4eK9gca8XWfZAxiw2t0V3B6AzTN8vRd
         cNUbxJXOUtwDoq1hloEFIR9YnO8lcEzgcxDJlcT8KJw11Cs3GvhECM9afPYpQKXPWg
         zYNMhIVtjsbj8FjbKVffH9bTE7J2BAe+56+/dOptNx8XuoUtKzgEBJevY5NvwMqeUP
         vSFW2oZzIIaTrwt0u8uALWKV6fqpkhxfdHYb7c3ttao2vN3qUzxKcb0f3zLnllpupd
         6D3LVG6BRLDyFOCKXm/D/7EvveUQ7qk42pPj8/Q/bkyS+enVEIjQorbEAobLPrn0St
         3+Y944U9TTYbA==
Message-ID: <22c3fe49-81aa-e453-8b9c-643f7f590905@kernel.org>
Date:   Fri, 4 Feb 2022 17:10:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: skip f2fs_preallocate_blocks() for
 overwrite case
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20210928151911.11189-1-chao@kernel.org>
 <YVNoHudG5c65X85G@google.com>
 <65f6c366-9e5b-fe7f-7c38-061996d1882b@kernel.org>
 <dec765de-407b-07c3-75f6-ec7f71c618b7@kernel.org>
 <YXwyvllUOm6jLiF5@google.com>
 <3e653a3d-ddb9-e115-d871-3659a1ba5530@kernel.org>
 <96959788-73b2-6e9b-3aa7-b1e23e9da417@kernel.org>
 <Ybjo6Zqpc7Wnev/r@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Ybjo6Zqpc7Wnev/r@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/15 2:56, Jaegeuk Kim wrote:
> On 12/12, Chao Yu wrote:
>> Ping,
>>
>> On 2021/10/30 11:02, Chao Yu wrote:
>>> On 2021/10/30 1:43, Jaegeuk Kim wrote:
>>>> On 10/29, Chao Yu wrote:
>>>>> Ping,
>>>>>
>>>>> On 2021/9/29 8:05, Chao Yu wrote:
>>>>>> On 2021/9/29 3:08, Jaegeuk Kim wrote:
>>>>>>> On 09/28, Chao Yu wrote:
>>>>>>>> In f2fs_file_write_iter(), let's use f2fs_overwrite_io() to
>>>>>>>> check whethere it is overwrite case, for such case, we can skip
>>>>>>>> f2fs_preallocate_blocks() in order to avoid f2fs_do_map_lock(),
>>>>>>>> which may be blocked by checkpoint() potentially.
>>>>>>>>
>>>>>>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>>>>>>> ---
>>>>>>>>     fs/f2fs/file.c | 4 ++++
>>>>>>>>     1 file changed, 4 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>>>>>> index 13deae03df06..51fecb2f4db5 100644
>>>>>>>> --- a/fs/f2fs/file.c
>>>>>>>> +++ b/fs/f2fs/file.c
>>>>>>>> @@ -4321,6 +4321,10 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>>>>>>>             preallocated = true;
>>>>>>>>             target_size = iocb->ki_pos + iov_iter_count(from);
>>>>>>>> +        if (f2fs_overwrite_io(inode, iocb->ki_pos,
>>>>>>>> +                        iov_iter_count(from)))
>>>>>>>> +            goto write;
>>>>>>>
>>>>>>> This calls f2fs_map_blocks() which can be duplicate, if it's not the overwirte
>>>>>>> case. Do we have other benefit?
>>>>>>
>>>>>> f2fs_overwrite_io() will break for append write case w/ below check:
>>>>>>
>>>>>>        if (pos + len > i_size_read(inode))
>>>>>>            return false;
>>>>>>
>>>>>> I guess we may only suffer double f2fs_map_blocks() for write hole
>>>>>> case, e.g. truncate to large size & write inside the filesize. For
>>>>>> this case, how about adding a condition to allow double f2fs_map_blocks()
>>>>>> only if write size is smaller than a threshold?
>>>>
>>>> I still don't see the benefit much to do double f2fs_map_blocks. What is the
>>>> problem here?
>>>
>>> There is potential hangtask happened during swapfile's writeback:
>>>
>>> - loop_kthread_worker_fn
>>>    - kthread_worker_fn
>>>     - loop_queue_work
>>>      - lo_rw_aio
>>>       - f2fs_file_write_iter
>>>        - f2fs_preallocate_blocks
>>>         - f2fs_map_blocks
>>>          - down_read
>>>           - rwsem_down_read_slowpath
>>>            - schedule
>>>
>>> I try to mitigate such issue by preallocating swapfile's block address and
>>> avoid f2fs_do_map_lock() as much as possible in swapfile's writeback path...
> 
> How about checking i_blocks and i_size instead of checking the entire map?

How about v2?

Thanks,

> 
>>>
>>> Thanks,
>>>
>>>>
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>>>
>>>>>>>> +
>>>>>>>>             err = f2fs_preallocate_blocks(iocb, from);
>>>>>>>>             if (err) {
>>>>>>>>     out_err:
>>>>>>>> -- 
>>>>>>>> 2.32.0
>>>>>>
>>>>>>
>>>>>> _______________________________________________
>>>>>> Linux-f2fs-devel mailing list
>>>>>> Linux-f2fs-devel@lists.sourceforge.net
>>>>>> https://apc01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.sourceforge.net%2Flists%2Flistinfo%2Flinux-f2fs-devel&amp;data=04%7C01%7Cchao.yu%40oppo.com%7Cbb41006c3f6d4e4d600a08d99b51cbcd%7Cf1905eb1c35341c5951662b4a54b5ee6%7C0%7C0%7C637711597895400286%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=%2BlEAXWLpV5wGX2hL0Wj5p2qX0AqfUFI05Qiqdp8PK8g%3D&amp;reserved=0
>>>
>>>
>>> _______________________________________________
>>> Linux-f2fs-devel mailing list
>>> Linux-f2fs-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
