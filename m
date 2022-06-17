Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9922D54EF02
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 03:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379352AbiFQB64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 21:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbiFQB6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 21:58:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDD85DE63
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 18:58:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76F9AB82690
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:58:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C11C34114;
        Fri, 17 Jun 2022 01:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655431131;
        bh=4ORWnSpPdZuo8VrELNzZCEyTwfy250F3Ymy9hC/UahI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=G6Cu20e5iVIFpcWbnk/TK1ovW3Z+HVhF2jc9uNaAIPaGXK39jnst+NSNnT4Kw3TIz
         o2Hx8PZUF7I4Z7064li25SsSwO2g1CEsRYvWOoxuxKibhXKvrBb7MVF/xDy4fYxjZJ
         gUq0aZDV2MWmz6gPGYatbYLbtnDKUPQU1WQpRWiPzYugJU/0n2VDN7N8exjcyyX34f
         sC8Wm+J8OCnOVotrV1BNPXbjy7hAP3nRU2YQj86aGDmD5w/0Df8w7bKGRmYn4QtHvG
         MqbRleU9XIedbI7n8Xeq1RD3z2t5McZsos3V2y2FmEhQImsSPWAKeRjVnNANNJ9zqR
         HIyY5ODzvqfWg==
Message-ID: <3e244ae3-67af-a347-3eb4-1d006984a080@kernel.org>
Date:   Fri, 17 Jun 2022 09:58:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix iostat related lock protection
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
References: <20220610183240.2269085-1-daeho43@gmail.com>
 <1815f3c2-0802-5b3f-7e98-9f89c5b9e07d@kernel.org>
 <YqoOzdxeG78RniEK@google.com>
 <fbd81c67-42b6-1e96-32d6-391dcafe181c@kernel.org>
 <YqtY4VVs9DrU3H5p@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <YqtY4VVs9DrU3H5p@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/17 0:22, Jaegeuk Kim wrote:
> On 06/16, Chao Yu wrote:
>> On 2022/6/16 0:54, Jaegeuk Kim wrote:
>>> On 06/15, Chao Yu wrote:
>>>> On 2022/6/11 2:32, Daeho Jeong wrote:
>>>>> From: Daeho Jeong <daehojeong@google.com>
>>>>>
>>>>> Made iostat related locks safe to be called from irq context again.
>>>>>
>>>>
>>>> Will be better to add a 'Fixes' line?
>>>
>>> Added some tags. Thanks,
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=f8ed39ad779fbc5d37d08e83643384fc06e4bae4
>>
>> It looks there are several patches not in mailing list?
>>
> 
> Which one doe you mean?

f2fs: do not skip updating inode when retrying to flush node page

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=27ef61f3bf3d15caa3f4ceef60163da3f143787d

f2fs: run GCs synchronously given user requests

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=503bbcc92f0baba2a59b0a6cb4f12cf5d7141978

f2fs: attach inline_data after setting compression

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=0c837862d93c8e2e0bbb6d33efa0ff10e603c0c5

And also current patch w/ Fixes line.

Thanks,

> 
>> Thanks,
>>
>>>
>>>
>>>>
>>>> Thanks,
>>>>
>>>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
>>>>> ---
>>>>>     fs/f2fs/iostat.c | 31 ++++++++++++++++++-------------
>>>>>     1 file changed, 18 insertions(+), 13 deletions(-)
>>>>>
>>>>> diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
>>>>> index be599f31d3c4..d84c5f6cc09d 100644
>>>>> --- a/fs/f2fs/iostat.c
>>>>> +++ b/fs/f2fs/iostat.c
>>>>> @@ -91,8 +91,9 @@ static inline void __record_iostat_latency(struct f2fs_sb_info *sbi)
>>>>>     	unsigned int cnt;
>>>>>     	struct f2fs_iostat_latency iostat_lat[MAX_IO_TYPE][NR_PAGE_TYPE];
>>>>>     	struct iostat_lat_info *io_lat = sbi->iostat_io_lat;
>>>>> +	unsigned long flags;
>>>>> -	spin_lock_bh(&sbi->iostat_lat_lock);
>>>>> +	spin_lock_irqsave(&sbi->iostat_lat_lock, flags);
>>>>>     	for (idx = 0; idx < MAX_IO_TYPE; idx++) {
>>>>>     		for (io = 0; io < NR_PAGE_TYPE; io++) {
>>>>>     			cnt = io_lat->bio_cnt[idx][io];
>>>>> @@ -106,7 +107,7 @@ static inline void __record_iostat_latency(struct f2fs_sb_info *sbi)
>>>>>     			io_lat->bio_cnt[idx][io] = 0;
>>>>>     		}
>>>>>     	}
>>>>> -	spin_unlock_bh(&sbi->iostat_lat_lock);
>>>>> +	spin_unlock_irqrestore(&sbi->iostat_lat_lock, flags);
>>>>>     	trace_f2fs_iostat_latency(sbi, iostat_lat);
>>>>>     }
>>>>> @@ -115,14 +116,15 @@ static inline void f2fs_record_iostat(struct f2fs_sb_info *sbi)
>>>>>     {
>>>>>     	unsigned long long iostat_diff[NR_IO_TYPE];
>>>>>     	int i;
>>>>> +	unsigned long flags;
>>>>>     	if (time_is_after_jiffies(sbi->iostat_next_period))
>>>>>     		return;
>>>>>     	/* Need double check under the lock */
>>>>> -	spin_lock_bh(&sbi->iostat_lock);
>>>>> +	spin_lock_irqsave(&sbi->iostat_lock, flags);
>>>>>     	if (time_is_after_jiffies(sbi->iostat_next_period)) {
>>>>> -		spin_unlock_bh(&sbi->iostat_lock);
>>>>> +		spin_unlock_irqrestore(&sbi->iostat_lock, flags);
>>>>>     		return;
>>>>>     	}
>>>>>     	sbi->iostat_next_period = jiffies +
>>>>> @@ -133,7 +135,7 @@ static inline void f2fs_record_iostat(struct f2fs_sb_info *sbi)
>>>>>     				sbi->prev_rw_iostat[i];
>>>>>     		sbi->prev_rw_iostat[i] = sbi->rw_iostat[i];
>>>>>     	}
>>>>> -	spin_unlock_bh(&sbi->iostat_lock);
>>>>> +	spin_unlock_irqrestore(&sbi->iostat_lock, flags);
>>>>>     	trace_f2fs_iostat(sbi, iostat_diff);
>>>>> @@ -145,25 +147,27 @@ void f2fs_reset_iostat(struct f2fs_sb_info *sbi)
>>>>>     	struct iostat_lat_info *io_lat = sbi->iostat_io_lat;
>>>>>     	int i;
>>>>> -	spin_lock_bh(&sbi->iostat_lock);
>>>>> +	spin_lock_irq(&sbi->iostat_lock);
>>>>>     	for (i = 0; i < NR_IO_TYPE; i++) {
>>>>>     		sbi->rw_iostat[i] = 0;
>>>>>     		sbi->prev_rw_iostat[i] = 0;
>>>>>     	}
>>>>> -	spin_unlock_bh(&sbi->iostat_lock);
>>>>> +	spin_unlock_irq(&sbi->iostat_lock);
>>>>> -	spin_lock_bh(&sbi->iostat_lat_lock);
>>>>> +	spin_lock_irq(&sbi->iostat_lat_lock);
>>>>>     	memset(io_lat, 0, sizeof(struct iostat_lat_info));
>>>>> -	spin_unlock_bh(&sbi->iostat_lat_lock);
>>>>> +	spin_unlock_irq(&sbi->iostat_lat_lock);
>>>>>     }
>>>>>     void f2fs_update_iostat(struct f2fs_sb_info *sbi,
>>>>>     			enum iostat_type type, unsigned long long io_bytes)
>>>>>     {
>>>>> +	unsigned long flags;
>>>>> +
>>>>>     	if (!sbi->iostat_enable)
>>>>>     		return;
>>>>> -	spin_lock_bh(&sbi->iostat_lock);
>>>>> +	spin_lock_irqsave(&sbi->iostat_lock, flags);
>>>>>     	sbi->rw_iostat[type] += io_bytes;
>>>>>     	if (type == APP_BUFFERED_IO || type == APP_DIRECT_IO)
>>>>> @@ -172,7 +176,7 @@ void f2fs_update_iostat(struct f2fs_sb_info *sbi,
>>>>>     	if (type == APP_BUFFERED_READ_IO || type == APP_DIRECT_READ_IO)
>>>>>     		sbi->rw_iostat[APP_READ_IO] += io_bytes;
>>>>> -	spin_unlock_bh(&sbi->iostat_lock);
>>>>> +	spin_unlock_irqrestore(&sbi->iostat_lock, flags);
>>>>>     	f2fs_record_iostat(sbi);
>>>>>     }
>>>>> @@ -185,6 +189,7 @@ static inline void __update_iostat_latency(struct bio_iostat_ctx *iostat_ctx,
>>>>>     	struct f2fs_sb_info *sbi = iostat_ctx->sbi;
>>>>>     	struct iostat_lat_info *io_lat = sbi->iostat_io_lat;
>>>>>     	int idx;
>>>>> +	unsigned long flags;
>>>>>     	if (!sbi->iostat_enable)
>>>>>     		return;
>>>>> @@ -202,12 +207,12 @@ static inline void __update_iostat_latency(struct bio_iostat_ctx *iostat_ctx,
>>>>>     			idx = WRITE_ASYNC_IO;
>>>>>     	}
>>>>> -	spin_lock_bh(&sbi->iostat_lat_lock);
>>>>> +	spin_lock_irqsave(&sbi->iostat_lat_lock, flags);
>>>>>     	io_lat->sum_lat[idx][iotype] += ts_diff;
>>>>>     	io_lat->bio_cnt[idx][iotype]++;
>>>>>     	if (ts_diff > io_lat->peak_lat[idx][iotype])
>>>>>     		io_lat->peak_lat[idx][iotype] = ts_diff;
>>>>> -	spin_unlock_bh(&sbi->iostat_lat_lock);
>>>>> +	spin_unlock_irqrestore(&sbi->iostat_lat_lock, flags);
>>>>>     }
>>>>>     void iostat_update_and_unbind_ctx(struct bio *bio, int rw)
>>>>
>>>>
>>>> _______________________________________________
>>>> Linux-f2fs-devel mailing list
>>>> Linux-f2fs-devel@lists.sourceforge.net
>>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
