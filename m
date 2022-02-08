Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFC84AD496
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 10:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353677AbiBHJSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 04:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238582AbiBHJSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:18:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA5CC03FEC3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 01:18:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B02961465
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 09:18:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CD4C340EE;
        Tue,  8 Feb 2022 09:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644311886;
        bh=I7Xie7sMfICHs14aE9eDxrmpTe6fMPFsk6GoOxJmkV8=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=g2SIl1sv37Wg4HfiTuc4dZnLg2S/byf3jUtnH3uIc4WvhjoID1lqvjW6LXqKoZ09y
         KJaXGAbCLiMOl0wys7ZCmWmeT2Fx2xPwaTXoZ3ZZJZ6lVnKu3/rQkqPNJ1f5NEJeMk
         1Ovl49WTI0DoSyXnD9KNIDP39i5U+0J28WZuuFMKPe+UV2PbVEY93HpsSm6pkDcWOo
         zi9BuuErpypqH+TrJl38bj6QOjzLVmakbAjevbg858sHUeDausKlm4Tsu3MfoJDQXh
         Ei3Wb7fUIFDqoMCTQGPh/JHreg5ddJVjBg2shjWIIvmLVKeAMytFsfIEb4Ruc3xhCQ
         qUjloscENnUNg==
Message-ID: <2cd93012-16b8-6681-cabe-c1401987bf27@kernel.org>
Date:   Tue, 8 Feb 2022 17:18:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid unneeded preflush during
 checkpoint()
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220207113516.9489-1-chao@kernel.org>
 <YgFvqnoa61BspqmW@google.com>
 <59da7f3e-92bd-1165-00e3-3dc18ae19aea@kernel.org>
In-Reply-To: <59da7f3e-92bd-1165-00e3-3dc18ae19aea@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/2/8 9:35, Chao Yu wrote:
> On 2022/2/8 3:14, Jaegeuk Kim wrote:
>> On 02/07, Chao Yu wrote:
>>> During checkpoint, we have committed preflush command via f2fs_flush_device_cache()
>>
>>   787 int f2fs_flush_device_cache(struct f2fs_sb_info *sbi)
>>   788 {
>>   789         int ret = 0, i;
>>   790
>>   791         if (!f2fs_is_multi_device(sbi))
>>   792                 return 0;
>>
>> Seems a wrong assumption.
> 
> Oh, I missed that f2fs_flush_device_cache was introduced to flush devices except
> first device when multi-device feature is on.
> 
>      for (i = 1; i < sbi->s_ndevs; i++) {
>          int count = DEFAULT_RETRY_IO_COUNT;
> 
> So, this patch seems wrong...
> 
> Instead, below case looks wrong since it needs to trigger flush during checkpoint()
> no matter nobarrier is on or off.

Wrong comments, let's ignore this patch, sorry.

Thanks,

> 
>      if (test_opt(sbi, NOBARRIER))
>          return 0;
> 
> Thanks,
> 
>>
>>> to persist all metadata pages except last #2 CP pack page, so we don't need to
>>> commit another preflush command in commit_checkpoint(), remove it to avoid unneeded
>>> write cache overhead.
>>>
>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>> ---
>>>   fs/f2fs/data.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index 8c417864c66a..15ac18bbbc8e 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -598,7 +598,7 @@ static void __f2fs_submit_merged_write(struct f2fs_sb_info *sbi,
>>>           io->fio.op = REQ_OP_WRITE;
>>>           io->fio.op_flags = REQ_META | REQ_PRIO | REQ_SYNC;
>>>           if (!test_opt(sbi, NOBARRIER))
>>> -            io->fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
>>> +            io->fio.op_flags |= REQ_FUA;
>>>       }
>>>       __submit_merged_bio(io);
>>>       up_write(&io->io_rwsem);
>>> -- 
>>> 2.32.0
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
