Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C634FA219
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 05:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238878AbiDIDsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 23:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiDIDsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 23:48:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8A138BF4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 20:46:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CCE7B82BFA
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 03:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF7DC385A4;
        Sat,  9 Apr 2022 03:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649475989;
        bh=Ayb5hOX+i0FYgvnXG3e1nz3NSgrfl8nSbqPlfEV1NhA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TXNmTKxdaftbGYQMVbAiJH2mRxMbkP5glhSOccafVmsDCxPowFIweppa8qoKJOdez
         Ep4e3+dW4L5f+Xi9QhRTfg0zRymursmVLlBlPeQgfIzt23UyVO7hPzAoR1p/FK0+XD
         CnLAamE4Dxnr/Vz2kaQvKTKQAdeTejWzDBB36V9AhpbuJCPm870etSUggDWbJ+E8MG
         U7mB8HqhWrdCoK5uExhJL/Nk0REPEw0zPDWPSMmm9jC6QGnAq30QZIpHr5Nml6lYjr
         LcYFkOIEXoC1UtjFOhUto0fkP0M/bG+WgG/YJHRNrVflme49SrISGpOZ44nNn0C7m1
         /ti9U6AhhefuQ==
Message-ID: <7e896205-027d-32e2-32b5-8951231132ac@kernel.org>
Date:   Sat, 9 Apr 2022 11:46:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] fs: f2fs: remove WARN_ON in f2fs_is_valid_blkaddr
Content-Language: en-US
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, Jaegeuk Kim <jaegeuk@kernel.org>,
        syzbot+763ae12a2ede1d99d4dc@syzkaller.appspotmail.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20220408052207.209856-1-dzm91@hust.edu.cn>
 <f125ece9-872e-39d9-48a5-15b85508f6b6@kernel.org>
 <CAD-N9QV7RUfBreaVOmC0JUwVfieM3kOYigOav8=vpAoak6Uc6A@mail.gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <CAD-N9QV7RUfBreaVOmC0JUwVfieM3kOYigOav8=vpAoak6Uc6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/9 9:34, Dongliang Mu wrote:
> On Sat, Apr 9, 2022 at 8:27 AM Chao Yu <chao@kernel.org> wrote:
>>
>> On 2022/4/8 13:22, Dongliang Mu wrote:
>>> From: Dongliang Mu <mudongliangabcd@gmail.com>
>>>
>>> In f2fs_is_valid_blkaddr, if type is DATA_GENERIC_ENHANCE or
>>> DATA_GENERIC_ENHANCE_READ, it invokes WARN_ON(1) not matter
>>> blkaddr is in the range or not.
>>
>> If we run into the path where we invoke WARN_ON(1) in f2fs_is_valid_blkaddr(),
>> It means f2fs image may be broken, or there is a bug in f2fs.
>>
>> So, do you suffer any related issue in your environment?
> 
> related issue? Can you explain a little?
> 
> If you mean if this warning occurs, any other issues or crash

I mean have you seen any warning info printed in the path of
f2fs_is_valid_blkaddr() before applying this patch, and if so, w/ what
reproducer? or you just figure out this patch from perspective of code
review?

Thanks,

> behaviors are generated? I tested on the syzbot. After removing the
> WARN_ON, there is no abnormal issue or crash behaviors followed with
> the corresponding reproducer.
> 
> 
>>
>> Thanks,
>>
>>>
>>> Fix this by removing WARN_ON.
>>>
>>> Note that, syzbot patch testing does not incur any further issues
>>>
>>> Reported-by: syzbot+763ae12a2ede1d99d4dc@syzkaller.appspotmail.com
>>> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
>>> ---
>>>    fs/f2fs/checkpoint.c | 2 --
>>>    1 file changed, 2 deletions(-)
>>>
>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>> index f5366feea82d..521498b2dd8c 100644
>>> --- a/fs/f2fs/checkpoint.c
>>> +++ b/fs/f2fs/checkpoint.c
>>> @@ -158,7 +158,6 @@ static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
>>>                f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:%d",
>>>                         blkaddr, exist);
>>>                set_sbi_flag(sbi, SBI_NEED_FSCK);
>>> -             WARN_ON(1);
>>>        }
>>>        return exist;
>>>    }
>>> @@ -196,7 +195,6 @@ bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>>>                        f2fs_warn(sbi, "access invalid blkaddr:%u",
>>>                                  blkaddr);
>>>                        set_sbi_flag(sbi, SBI_NEED_FSCK);
>>> -                     WARN_ON(1);
>>>                        return false;
>>>                } else {
>>>                        return __is_bitmap_valid(sbi, blkaddr, type);
