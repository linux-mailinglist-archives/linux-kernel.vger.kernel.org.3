Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9050C4FB8A1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245452AbiDKJ4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344928AbiDKJ4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:56:07 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8904160F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:53:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D7066CE170D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:53:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22668C385AA;
        Mon, 11 Apr 2022 09:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670819;
        bh=lKIoE+fCrKnnFm+3QbNw32clo6tQo6WExWhfT9DKIPc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=E9glXHmdjnSJGsaaNhsUd3ai286WN/l7Go/zk/ufh7o+jTun3W13zlsjZq4AM+hnX
         lx/ZTMLWGrJ73xGXmNeESe7KWHEhdrMC6zwcMUsfxCmFtKzLxbcUqnvg6ecBkFUfLi
         flQq39/uaEIIarJcJXMlzu9Xz29GHz52OMdl+s4FQd9e96zcAAH2dG4FKMMIInLrBn
         tyL8Jhs8QC6OT9YE3QCrwshvSDj//MociQ5v8LEd459du73AVopB55ulCFTfUzDuRX
         6e62qpz/O6oudwwIHDYtl4pVzn6PMNntcaI0DvB6tzYLx2NzFFqdns86DujXWbjuu0
         SktrikGrdeD/g==
Message-ID: <a25bac9c-188b-4ab4-21e2-d34e20c92524@kernel.org>
Date:   Mon, 11 Apr 2022 17:53:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [f2fs-dev] [PATCH] fs: f2fs: remove WARN_ON in
 f2fs_is_valid_blkaddr
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot+763ae12a2ede1d99d4dc@syzkaller.appspotmail.com,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220408052207.209856-1-dzm91@hust.edu.cn>
 <f125ece9-872e-39d9-48a5-15b85508f6b6@kernel.org>
 <CAD-N9QV7RUfBreaVOmC0JUwVfieM3kOYigOav8=vpAoak6Uc6A@mail.gmail.com>
 <7e896205-027d-32e2-32b5-8951231132ac@kernel.org>
 <CAD-N9QXM_xds692Lh-QZc5aL01uRivLGrNnxJys41hiTUfKE5w@mail.gmail.com>
 <2f5b7291-da06-0895-8e75-c7a37251b47e@kernel.org>
 <CAD-N9QX7wKN_x88w7p6t1KWeTGodeF-o0i-1d0Sq4Ja1OzPFoA@mail.gmail.com>
 <YlPHWaSlk21cc32p@sol.localdomain>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <YlPHWaSlk21cc32p@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/11 14:14, Eric Biggers wrote:
> On Mon, Apr 11, 2022 at 01:06:09PM +0800, Dongliang Mu wrote:
>> On Mon, Apr 11, 2022 at 11:10 AM Chao Yu <chao@kernel.org> wrote:
>>>
>>> On 2022/4/9 14:42, Dongliang Mu wrote:
>>>> On Sat, Apr 9, 2022 at 11:46 AM Chao Yu <chao@kernel.org> wrote:
>>>>>
>>>>> On 2022/4/9 9:34, Dongliang Mu wrote:
>>>>>> On Sat, Apr 9, 2022 at 8:27 AM Chao Yu <chao@kernel.org> wrote:
>>>>>>>
>>>>>>> On 2022/4/8 13:22, Dongliang Mu wrote:
>>>>>>>> From: Dongliang Mu <mudongliangabcd@gmail.com>
>>>>>>>>
>>>>>>>> In f2fs_is_valid_blkaddr, if type is DATA_GENERIC_ENHANCE or
>>>>>>>> DATA_GENERIC_ENHANCE_READ, it invokes WARN_ON(1) not matter
>>>>>>>> blkaddr is in the range or not.
>>>>>>>
>>>>>>> If we run into the path where we invoke WARN_ON(1) in f2fs_is_valid_blkaddr(),
>>>>>>> It means f2fs image may be broken, or there is a bug in f2fs.
>>>>>>>
>>>>>>> So, do you suffer any related issue in your environment?
>>>>>>
>>>>>> related issue? Can you explain a little?
>>>>>>
>>>>>> If you mean if this warning occurs, any other issues or crash
>>>>>
>>>>> I mean have you seen any warning info printed in the path of
>>>>> f2fs_is_valid_blkaddr() before applying this patch, and if so, w/ what
>>>>> reproducer? or you just figure out this patch from perspective of code
>>>>> review?
>>>>
>>>> Yes, I have seen both warning information from Syzbot [1] and my local
>>>> syzkaller instance.
>>>>
>>>> In f2fs_is_valid_blkaddr, if the following condition is satisfied,
>>>> i.e., blkaddr is not in the right range [2], it will directly invoke
>>>> one WARN_ON.
>>>>
>>>> if (unlikely(blkaddr >= MAX_BLKADDR(sbi) ||
>>>>                    blkaddr < MAIN_BLKADDR(sbi))) {
>>>>
>>>> This is the case on Syzbot.
>>>>
>>>> Otherwise, it will jump into __is_bitmap_valid. And if the following
>>>> condition is satisfied [3], it will trigger another WARN_ON.
>>>>
>>>> exist = f2fs_test_bit(offset, se->cur_valid_map);
>>>> if (!exist && type == DATA_GENERIC_ENHANCE) {
>>>>
>>>> This appears in my local syzbot instance, but unfortunately it does
>>>> not get any reproducer.
>>>
>>> Oh, it occurs in syzbot test, I guess it is possible that f2fs prints such
>>> warning info after blkaddr of node/data block was fuzzed to invalid one.
>>>
>>> I prefer to keep WARN_ON() to catch more info of bugs found by non-fuzzed
>>> type test.
>>>
>>> Thoughts?
>>
>> I am fine with both options. I can remove the WARN_ON in my local
>> syzkaller instance and continue fuzzing Linux kernel.
>>
>> +Dmitry Vyukov how do you think? If WARN_ON is kept, this crash will
>> occur on Syzbot from time to time.
> 
> WARN_ON is for kernel bugs; please refer to the documentation in
> include/asm-generic/bug.h.  If this is a kernel bug, then the kernel bug needs
> to be fixed.  Otherwise, the WARN_ON needs to be removed.

Alright, so how about using dump_stack() instead as suggested in doc?

Thanks,

> 
> - Eric
