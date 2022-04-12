Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CA84FDC65
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352983AbiDLKXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380630AbiDLKUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 06:20:52 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1550D4C43E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 02:25:40 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bh17so36067632ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 02:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X3YNHPaCJ0j6J7AgyeqSNpvtgtUHrIrd+cUv59gmDdw=;
        b=VDmPWsFhmRDehPDyMetWshMjV0aZT1SEh3ZvGVJlflnm8d84DzneF+d9o2XKkbbkOJ
         /lvK8KKFLduChzyolt0Ln3fsQHpjlFOlwNPW0h945g1CRhI7iiDEtkLU/nsZKJUC9KiR
         8DQncwuLk6UdZA/HGp0Ve/2q+uovgoLrD4RB9EbHiVswxU1MN7un0J7cbvnfcFAzTaxS
         MpKfhWbdjYjS1ufX/R4/k7ZB1xwawDdO21viIotcT4DWbpzR6zukClEn+PkmYCZwynKw
         DTArIWvs1+fSxPGUpZki8xbuQrNRtW3vhoUti9/7UqU88slSL1ifx3ThSeBAD05ZcEzW
         MBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X3YNHPaCJ0j6J7AgyeqSNpvtgtUHrIrd+cUv59gmDdw=;
        b=2bC2UUjXdohMcrPfKLGDRooTbtDzw8I8qFzz41CivSe1vcpmVvQ4r+2EJ3GOtzmsp+
         W0+tyll2u+vL7EYSS68trple9pX0dDwQgwE3uR5eN7eD/RwPRXq1YYJ5emHsR6sT+yI0
         U4XI+n0ECDrkjy6QcE5BZ1mxjrF+/vqPDzzqeaHvjQ73YZK1qEw11sDnZlKnMtYzBZl4
         XQ52/NvvpAPE4qLLzSE84a20xoWj0rk6+8qvLgytYywdczcGj5X5BIVh5JwYoaKpeDlM
         iJ0V6W0aFKIfcINbmNuYIFUMUqjtSEJmX/89u6kbwtF5AgXrWMJmAuNOQzYYPSzkZMOT
         lzPA==
X-Gm-Message-State: AOAM532Y5E7/03h2vfpvAeSduyhNPUqb2uYOGD/i7QNGN4eE4oyWUQPe
        lbr4LnwpkqU6pT88O3xpLMKJQmEX/YhBqTsXP9Q=
X-Google-Smtp-Source: ABdhPJyOaUXGrfelcS+wdxAvMUvh4iGL4B43HTVL/dE8NDiNrkZdvrJKneNEM5Q6Hsisd4g2s0OHs2NgcPmFTA8u37Q=
X-Received: by 2002:a17:906:1be1:b0:6ce:b0a8:17d with SMTP id
 t1-20020a1709061be100b006ceb0a8017dmr33419444ejg.413.1649755538517; Tue, 12
 Apr 2022 02:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220408052207.209856-1-dzm91@hust.edu.cn> <f125ece9-872e-39d9-48a5-15b85508f6b6@kernel.org>
 <CAD-N9QV7RUfBreaVOmC0JUwVfieM3kOYigOav8=vpAoak6Uc6A@mail.gmail.com>
 <7e896205-027d-32e2-32b5-8951231132ac@kernel.org> <CAD-N9QXM_xds692Lh-QZc5aL01uRivLGrNnxJys41hiTUfKE5w@mail.gmail.com>
 <2f5b7291-da06-0895-8e75-c7a37251b47e@kernel.org> <CAD-N9QX7wKN_x88w7p6t1KWeTGodeF-o0i-1d0Sq4Ja1OzPFoA@mail.gmail.com>
 <YlPHWaSlk21cc32p@sol.localdomain> <a25bac9c-188b-4ab4-21e2-d34e20c92524@kernel.org>
In-Reply-To: <a25bac9c-188b-4ab4-21e2-d34e20c92524@kernel.org>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Tue, 12 Apr 2022 17:25:12 +0800
Message-ID: <CAD-N9QWCHZ46wL5zOzWSeesGRk0xzKC4oGy2f8E08FTJhE5UCA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] fs: f2fs: remove WARN_ON in f2fs_is_valid_blkaddr
To:     Chao Yu <chao@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot+763ae12a2ede1d99d4dc@syzkaller.appspotmail.com,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 5:53 PM Chao Yu <chao@kernel.org> wrote:
>
> On 2022/4/11 14:14, Eric Biggers wrote:
> > On Mon, Apr 11, 2022 at 01:06:09PM +0800, Dongliang Mu wrote:
> >> On Mon, Apr 11, 2022 at 11:10 AM Chao Yu <chao@kernel.org> wrote:
> >>>
> >>> On 2022/4/9 14:42, Dongliang Mu wrote:
> >>>> On Sat, Apr 9, 2022 at 11:46 AM Chao Yu <chao@kernel.org> wrote:
> >>>>>
> >>>>> On 2022/4/9 9:34, Dongliang Mu wrote:
> >>>>>> On Sat, Apr 9, 2022 at 8:27 AM Chao Yu <chao@kernel.org> wrote:
> >>>>>>>
> >>>>>>> On 2022/4/8 13:22, Dongliang Mu wrote:
> >>>>>>>> From: Dongliang Mu <mudongliangabcd@gmail.com>
> >>>>>>>>
> >>>>>>>> In f2fs_is_valid_blkaddr, if type is DATA_GENERIC_ENHANCE or
> >>>>>>>> DATA_GENERIC_ENHANCE_READ, it invokes WARN_ON(1) not matter
> >>>>>>>> blkaddr is in the range or not.
> >>>>>>>
> >>>>>>> If we run into the path where we invoke WARN_ON(1) in f2fs_is_valid_blkaddr(),
> >>>>>>> It means f2fs image may be broken, or there is a bug in f2fs.
> >>>>>>>
> >>>>>>> So, do you suffer any related issue in your environment?
> >>>>>>
> >>>>>> related issue? Can you explain a little?
> >>>>>>
> >>>>>> If you mean if this warning occurs, any other issues or crash
> >>>>>
> >>>>> I mean have you seen any warning info printed in the path of
> >>>>> f2fs_is_valid_blkaddr() before applying this patch, and if so, w/ what
> >>>>> reproducer? or you just figure out this patch from perspective of code
> >>>>> review?
> >>>>
> >>>> Yes, I have seen both warning information from Syzbot [1] and my local
> >>>> syzkaller instance.
> >>>>
> >>>> In f2fs_is_valid_blkaddr, if the following condition is satisfied,
> >>>> i.e., blkaddr is not in the right range [2], it will directly invoke
> >>>> one WARN_ON.
> >>>>
> >>>> if (unlikely(blkaddr >= MAX_BLKADDR(sbi) ||
> >>>>                    blkaddr < MAIN_BLKADDR(sbi))) {
> >>>>
> >>>> This is the case on Syzbot.
> >>>>
> >>>> Otherwise, it will jump into __is_bitmap_valid. And if the following
> >>>> condition is satisfied [3], it will trigger another WARN_ON.
> >>>>
> >>>> exist = f2fs_test_bit(offset, se->cur_valid_map);
> >>>> if (!exist && type == DATA_GENERIC_ENHANCE) {
> >>>>
> >>>> This appears in my local syzbot instance, but unfortunately it does
> >>>> not get any reproducer.
> >>>
> >>> Oh, it occurs in syzbot test, I guess it is possible that f2fs prints such
> >>> warning info after blkaddr of node/data block was fuzzed to invalid one.
> >>>
> >>> I prefer to keep WARN_ON() to catch more info of bugs found by non-fuzzed
> >>> type test.
> >>>
> >>> Thoughts?
> >>
> >> I am fine with both options. I can remove the WARN_ON in my local
> >> syzkaller instance and continue fuzzing Linux kernel.
> >>
> >> +Dmitry Vyukov how do you think? If WARN_ON is kept, this crash will
> >> occur on Syzbot from time to time.
> >
> > WARN_ON is for kernel bugs; please refer to the documentation in
> > include/asm-generic/bug.h.  If this is a kernel bug, then the kernel bug needs
> > to be fixed.  Otherwise, the WARN_ON needs to be removed.
>
> Alright, so how about using dump_stack() instead as suggested in doc?

I agree. Let's change WARN_ON to dump_stack().

>
> Thanks,
>
> >
> > - Eric
