Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1AA4FB22B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 05:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241227AbiDKDM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 23:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238402AbiDKDMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 23:12:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CA32F394
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 20:10:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 48038CE1268
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:10:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D571FC385A1;
        Mon, 11 Apr 2022 03:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649646599;
        bh=4LmMfrR1QPPGbqdrcE2YtRn/sHGcdWwD5i6OKaZjEiE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tsPzZgJJ03fB0EumFGmnf7UJoBExhLPh1wWuvvCfR7OXTgxJU6X/ebA85ODaWUfyv
         vjPFk18aq4jiGN1pijBqs9YiBMObDL1jf5wIvUr6sgR5zFPTB8lhd0nQJHEssvXFTr
         erNUI7FS+YnP+J/NcM9hemXslNyAj9rc9vcWzg/HfjaeQtHlrbmcaL76bGPI/jWe7H
         vw7WiA+hFeW8wYcy8sqmA7l+vS4tM5zSI2bCJTJPY86soUHt3hVu37mZlOg6FsdqzR
         kNsxBVc+XM+pxaexoYCOjoGYdBVYmmlXuqSy0foal+IXbXsgYHkii2Mh87JUQH/hfj
         im3zudH+2KMGw==
Message-ID: <2f5b7291-da06-0895-8e75-c7a37251b47e@kernel.org>
Date:   Mon, 11 Apr 2022 11:09:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [f2fs-dev] [PATCH] fs: f2fs: remove WARN_ON in
 f2fs_is_valid_blkaddr
Content-Language: en-US
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Dongliang Mu <dzm91@hust.edu.cn>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot+763ae12a2ede1d99d4dc@syzkaller.appspotmail.com,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220408052207.209856-1-dzm91@hust.edu.cn>
 <f125ece9-872e-39d9-48a5-15b85508f6b6@kernel.org>
 <CAD-N9QV7RUfBreaVOmC0JUwVfieM3kOYigOav8=vpAoak6Uc6A@mail.gmail.com>
 <7e896205-027d-32e2-32b5-8951231132ac@kernel.org>
 <CAD-N9QXM_xds692Lh-QZc5aL01uRivLGrNnxJys41hiTUfKE5w@mail.gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <CAD-N9QXM_xds692Lh-QZc5aL01uRivLGrNnxJys41hiTUfKE5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/9 14:42, Dongliang Mu wrote:
> On Sat, Apr 9, 2022 at 11:46 AM Chao Yu <chao@kernel.org> wrote:
>>
>> On 2022/4/9 9:34, Dongliang Mu wrote:
>>> On Sat, Apr 9, 2022 at 8:27 AM Chao Yu <chao@kernel.org> wrote:
>>>>
>>>> On 2022/4/8 13:22, Dongliang Mu wrote:
>>>>> From: Dongliang Mu <mudongliangabcd@gmail.com>
>>>>>
>>>>> In f2fs_is_valid_blkaddr, if type is DATA_GENERIC_ENHANCE or
>>>>> DATA_GENERIC_ENHANCE_READ, it invokes WARN_ON(1) not matter
>>>>> blkaddr is in the range or not.
>>>>
>>>> If we run into the path where we invoke WARN_ON(1) in f2fs_is_valid_blkaddr(),
>>>> It means f2fs image may be broken, or there is a bug in f2fs.
>>>>
>>>> So, do you suffer any related issue in your environment?
>>>
>>> related issue? Can you explain a little?
>>>
>>> If you mean if this warning occurs, any other issues or crash
>>
>> I mean have you seen any warning info printed in the path of
>> f2fs_is_valid_blkaddr() before applying this patch, and if so, w/ what
>> reproducer? or you just figure out this patch from perspective of code
>> review?
> 
> Yes, I have seen both warning information from Syzbot [1] and my local
> syzkaller instance.
> 
> In f2fs_is_valid_blkaddr, if the following condition is satisfied,
> i.e., blkaddr is not in the right range [2], it will directly invoke
> one WARN_ON.
> 
> if (unlikely(blkaddr >= MAX_BLKADDR(sbi) ||
>                   blkaddr < MAIN_BLKADDR(sbi))) {
> 
> This is the case on Syzbot.
> 
> Otherwise, it will jump into __is_bitmap_valid. And if the following
> condition is satisfied [3], it will trigger another WARN_ON.
> 
> exist = f2fs_test_bit(offset, se->cur_valid_map);
> if (!exist && type == DATA_GENERIC_ENHANCE) {
> 
> This appears in my local syzbot instance, but unfortunately it does
> not get any reproducer.

Oh, it occurs in syzbot test, I guess it is possible that f2fs prints such
warning info after blkaddr of node/data block was fuzzed to invalid one.

I prefer to keep WARN_ON() to catch more info of bugs found by non-fuzzed
type test.

Thoughts?

Thanks,

> 
> [1] https://apc01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsyzkaller.appspot.com%2Fbug%3Fextid%3D763ae12a2ede1d99d4dc&amp;data=04%7C01%7Cchao.yu%40oppo.com%7Cff92e63621b24fc75a4908da19f45860%7Cf1905eb1c35341c5951662b4a54b5ee6%7C0%7C0%7C637850834521060840%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=UVSSS9IknYLJHzqqJAN5HmPgJ8GNczvi6%2FuQf2n3vlY%3D&amp;reserved=0
> [2] https://apc01.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Flatest%2Fsource%2Ffs%2Ff2fs%2Fcheckpoint.c%23L187&amp;data=04%7C01%7Cchao.yu%40oppo.com%7Cff92e63621b24fc75a4908da19f45860%7Cf1905eb1c35341c5951662b4a54b5ee6%7C0%7C0%7C637850834521060840%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=Sf%2Bx8WCAXf5c4%2Bins46saTsTN5uNTrnIceAP3oCWnQw%3D&amp;reserved=0
> [3] https://apc01.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Flatest%2Fsource%2Ffs%2Ff2fs%2Fcheckpoint.c%23L135&amp;data=04%7C01%7Cchao.yu%40oppo.com%7Cff92e63621b24fc75a4908da19f45860%7Cf1905eb1c35341c5951662b4a54b5ee6%7C0%7C0%7C637850834521060840%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=Ly%2FBL5oFAWZmXwbN6TaYCExroDE8%2Fsli1alaJwR4wvU%3D&amp;reserved=0
> 
> 
>>
>> Thanks,
>>
>>> behaviors are generated? I tested on the syzbot. After removing the
>>> WARN_ON, there is no abnormal issue or crash behaviors followed with
>>> the corresponding reproducer.
>>>
>>>
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>> Fix this by removing WARN_ON.
>>>>>
>>>>> Note that, syzbot patch testing does not incur any further issues
>>>>>
>>>>> Reported-by: syzbot+763ae12a2ede1d99d4dc@syzkaller.appspotmail.com
>>>>> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
>>>>> ---
>>>>>     fs/f2fs/checkpoint.c | 2 --
>>>>>     1 file changed, 2 deletions(-)
>>>>>
>>>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>>>> index f5366feea82d..521498b2dd8c 100644
>>>>> --- a/fs/f2fs/checkpoint.c
>>>>> +++ b/fs/f2fs/checkpoint.c
>>>>> @@ -158,7 +158,6 @@ static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
>>>>>                 f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:%d",
>>>>>                          blkaddr, exist);
>>>>>                 set_sbi_flag(sbi, SBI_NEED_FSCK);
>>>>> -             WARN_ON(1);
>>>>>         }
>>>>>         return exist;
>>>>>     }
>>>>> @@ -196,7 +195,6 @@ bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>>>>>                         f2fs_warn(sbi, "access invalid blkaddr:%u",
>>>>>                                   blkaddr);
>>>>>                         set_sbi_flag(sbi, SBI_NEED_FSCK);
>>>>> -                     WARN_ON(1);
>>>>>                         return false;
>>>>>                 } else {
>>>>>                         return __is_bitmap_valid(sbi, blkaddr, type);
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
