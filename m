Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211634ACE57
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245418AbiBHBt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344209AbiBHBfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 20:35:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42E4C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 17:35:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95800B8170D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 01:35:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B730C004E1;
        Tue,  8 Feb 2022 01:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644284136;
        bh=o+NEaHYg1oMwFFbJTVtbm24NxkjLxuhPYXj4L9pEGzo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZJpocSefDus7E3fo3k8k2+rstHENI67GChkDgaAffdBlqoIpcz1c3oGu5gDUsKnVC
         xUQHcsoEXzv1Heh4q//VHqx9XQLrGcRKMcC7uB6+xveGlZdlrwaKR61GYLHPhBCklK
         IHmLL5S6mw25t4f/cgqQXt2xi4/DVcjUXBuKta/Z/kZz1cPgW09y5zKxRqrpsA6gxL
         hWiyMlm21Ht63uRb1VA3OyhLsg5lvQ8Cyr28tkezF4mCxXojH56VSUHsMaMHJB2SPw
         Yl2ak0Kv7pMq2FLrzjyu4GoiLTlH0yqGX2qwrTRRsSfWNegTjaKAjiZAEGQ+WwrTzm
         QLaijvOHNFDLQ==
Message-ID: <59da7f3e-92bd-1165-00e3-3dc18ae19aea@kernel.org>
Date:   Tue, 8 Feb 2022 09:35:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] f2fs: avoid unneeded preflush during checkpoint()
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20220207113516.9489-1-chao@kernel.org>
 <YgFvqnoa61BspqmW@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <YgFvqnoa61BspqmW@google.com>
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

On 2022/2/8 3:14, Jaegeuk Kim wrote:
> On 02/07, Chao Yu wrote:
>> During checkpoint, we have committed preflush command via f2fs_flush_device_cache()
> 
>   787 int f2fs_flush_device_cache(struct f2fs_sb_info *sbi)
>   788 {
>   789         int ret = 0, i;
>   790
>   791         if (!f2fs_is_multi_device(sbi))
>   792                 return 0;
> 
> Seems a wrong assumption.

Oh, I missed that f2fs_flush_device_cache was introduced to flush devices except
first device when multi-device feature is on.

	for (i = 1; i < sbi->s_ndevs; i++) {
		int count = DEFAULT_RETRY_IO_COUNT;

So, this patch seems wrong...

Instead, below case looks wrong since it needs to trigger flush during checkpoint()
no matter nobarrier is on or off.

	if (test_opt(sbi, NOBARRIER))
		return 0;

Thanks,

> 
>> to persist all metadata pages except last #2 CP pack page, so we don't need to
>> commit another preflush command in commit_checkpoint(), remove it to avoid unneeded
>> write cache overhead.
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/data.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 8c417864c66a..15ac18bbbc8e 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -598,7 +598,7 @@ static void __f2fs_submit_merged_write(struct f2fs_sb_info *sbi,
>>   		io->fio.op = REQ_OP_WRITE;
>>   		io->fio.op_flags = REQ_META | REQ_PRIO | REQ_SYNC;
>>   		if (!test_opt(sbi, NOBARRIER))
>> -			io->fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
>> +			io->fio.op_flags |= REQ_FUA;
>>   	}
>>   	__submit_merged_bio(io);
>>   	up_write(&io->io_rwsem);
>> -- 
>> 2.32.0
