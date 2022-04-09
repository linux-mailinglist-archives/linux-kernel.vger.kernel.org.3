Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF0C4FA144
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 03:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238413AbiDIBgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 21:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbiDIBgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:36:37 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E950632C223
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 18:34:30 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x24so6881274edl.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 18:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zpo56anepGh1996ZVn2ynpiLSftI9+RsEzRBaVj4yg4=;
        b=INLGEH+vbKT+ECgiAZQ8C9Fwbb4Ob99aqXQUVcVZlQBciKqXZJiwwAQUePzVEghVm/
         tWvN94mruy6ucYM0CMQwryR8hvCHbFupHJjot82QO8BkCiK5Ka9PRxkE7HS2KBycVdEs
         OZKCiUK97EdIfnxWTjQ6gN9wLXadLkrpAm/SIa5t5D/OQ7TkPvlA0NbjV2gldv5qeIcu
         /ahC2E2aUxUs4fojmEvvksy78BvNiAZbXRq8N6MCMU/BnhuziZN9iUMa11Ec5NZL2qTT
         48mk7hbS5ANaPL0fajF1tSjPYeezVsNQXmgqq4vgJk9GABhlGpp8HkdmONg3hz7cFsh4
         jjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zpo56anepGh1996ZVn2ynpiLSftI9+RsEzRBaVj4yg4=;
        b=i5u58vy2QDRlMFMhDVjbYrspuviNNFDIwBQ5LheeLcixGhZVDJpMTFKHtXtLHdgIZA
         zhGiGBlmgTxStyjeo1Ocv2qy5sM/ZmhyA6nvwyDNlIMyejHzazWHM3kP7pVvDUywodxc
         OeZWS65TGiYN6JoybMlKrusnBAperrTb6FIbTj94cO/XHd38mXJtayiI1u/tmR6aqRKC
         CRGBKo7Czhf+xYyYOV/vefqmrDKhR4fgHH/Ztb3WDQn84izR0sXiM5USACHQya6vb2Ad
         CWBW2emrbY0YLBxFxBUK0McANIyH6V3UF+GKcMlhd+SGxCHPKWql7tatxWqwxom6QEHu
         oFmQ==
X-Gm-Message-State: AOAM5309yMIKvPDcSQ4G19TeI7z8pQJFdOUoDc166lWpbHG2pp52WSnG
        hUOLZRjYHz+T0Xzfe0PFlHfng9xgU8pQ6roLr2U=
X-Google-Smtp-Source: ABdhPJwsQzL7e5sUmjWOrWUQj/zvgUrqSodIKWDDRl2LEEuDh6ugBZhU7XQ7ASrJ3S9LsSJ8eI/TPh4VcvBbTJ2uIvw=
X-Received: by 2002:a05:6402:2945:b0:41d:aad:c824 with SMTP id
 ed5-20020a056402294500b0041d0aadc824mr10293856edb.364.1649468069444; Fri, 08
 Apr 2022 18:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220408052207.209856-1-dzm91@hust.edu.cn> <f125ece9-872e-39d9-48a5-15b85508f6b6@kernel.org>
In-Reply-To: <f125ece9-872e-39d9-48a5-15b85508f6b6@kernel.org>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Sat, 9 Apr 2022 09:34:02 +0800
Message-ID: <CAD-N9QV7RUfBreaVOmC0JUwVfieM3kOYigOav8=vpAoak6Uc6A@mail.gmail.com>
Subject: Re: [PATCH] fs: f2fs: remove WARN_ON in f2fs_is_valid_blkaddr
To:     Chao Yu <chao@kernel.org>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, Jaegeuk Kim <jaegeuk@kernel.org>,
        syzbot+763ae12a2ede1d99d4dc@syzkaller.appspotmail.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Sat, Apr 9, 2022 at 8:27 AM Chao Yu <chao@kernel.org> wrote:
>
> On 2022/4/8 13:22, Dongliang Mu wrote:
> > From: Dongliang Mu <mudongliangabcd@gmail.com>
> >
> > In f2fs_is_valid_blkaddr, if type is DATA_GENERIC_ENHANCE or
> > DATA_GENERIC_ENHANCE_READ, it invokes WARN_ON(1) not matter
> > blkaddr is in the range or not.
>
> If we run into the path where we invoke WARN_ON(1) in f2fs_is_valid_blkaddr(),
> It means f2fs image may be broken, or there is a bug in f2fs.
>
> So, do you suffer any related issue in your environment?

related issue? Can you explain a little?

If you mean if this warning occurs, any other issues or crash
behaviors are generated? I tested on the syzbot. After removing the
WARN_ON, there is no abnormal issue or crash behaviors followed with
the corresponding reproducer.


>
> Thanks,
>
> >
> > Fix this by removing WARN_ON.
> >
> > Note that, syzbot patch testing does not incur any further issues
> >
> > Reported-by: syzbot+763ae12a2ede1d99d4dc@syzkaller.appspotmail.com
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> >   fs/f2fs/checkpoint.c | 2 --
> >   1 file changed, 2 deletions(-)
> >
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index f5366feea82d..521498b2dd8c 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -158,7 +158,6 @@ static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
> >               f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:%d",
> >                        blkaddr, exist);
> >               set_sbi_flag(sbi, SBI_NEED_FSCK);
> > -             WARN_ON(1);
> >       }
> >       return exist;
> >   }
> > @@ -196,7 +195,6 @@ bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
> >                       f2fs_warn(sbi, "access invalid blkaddr:%u",
> >                                 blkaddr);
> >                       set_sbi_flag(sbi, SBI_NEED_FSCK);
> > -                     WARN_ON(1);
> >                       return false;
> >               } else {
> >                       return __is_bitmap_valid(sbi, blkaddr, type);
