Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6525C5A361F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 11:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiH0JCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 05:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiH0JCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 05:02:40 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D440427CFC
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 02:02:39 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q63so3433537pga.9
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 02:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=D7wwbAuLXWf5SB+NrnBAoFyECHS6XWLYdUvOon1TCXE=;
        b=EdrAPX3fWMDCt2nPBgcPLvrxq6br95yWD8pDZjJZHeiC8vfwNudi1/FPnHY2e7toVy
         i4FXOAAmjRSbloR/Ii3Ev6Q0Tn1j6+og1LqZB/vO4KQ0rK/qwL1Nj2qeBmbO783aXdSf
         FE+kbXlPcKRfBlYiutc0bTuT5Yce9DZJvoHfa6H3B2hUdIY89GDNXE/Kbnj9uAf4kDAm
         uxwDxWAhbBuQw3Q/VNiy7TrOiN1xQdmXwA8VSe02c4M+FFUXuL+ad2aUAj5dVcU3S+pm
         V4GiO4/vNDYlTEn42J+WwlskCoO4CqL+keVtpqMDGincSKnZDyKDM6fQBNTrZ+EGLKkP
         uOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=D7wwbAuLXWf5SB+NrnBAoFyECHS6XWLYdUvOon1TCXE=;
        b=fpCwJ/A2BCllm/gM0gV6vyytRmvqMFO9U2rT3YrGFitQloW+Jsfn3dHREReoVJVbmk
         K2dClFL7q+dyYV1KFUR74T4LT95iS2NSoiKsETx7IGG0jSv0qaA4Ut2P7upr8Itkl0tl
         0kNUoEmJh+8ROQ6M8fgPIoiGiQUWe6rJfO3cq7E7BFwgIESzcwPfTG1x+/QcqfZJWUH5
         h8bTjdAWv3bxLeqO7h8zMu3JdqpWEf49bINed5SaiE2H+XNjbYqUfG+WjgwVNBS59Grf
         UsdF0hAM/9Q7ZgYAc69IuFg9IZ/UsPsCx77EpTa7S7VWTKP9Xbrm3ci7X3nGjp+oMdxr
         r+nA==
X-Gm-Message-State: ACgBeo0Iqqu8QliAVo6FGjbKmwL20Bi3vszzXnCFBYe1IQzhAZGdhEIQ
        MPnu4mHanHkO+D5cztb1Zdw=
X-Google-Smtp-Source: AA6agR6SduTHI/dh7+uOOuXv2bOQOJLw1oK9Z9i3q8mttMJatnvVJZ+6PtRXtZKOmgbxIG+W2ljGSg==
X-Received: by 2002:a05:6a00:22cd:b0:52f:706a:5268 with SMTP id f13-20020a056a0022cd00b0052f706a5268mr7469640pfj.80.1661590959325;
        Sat, 27 Aug 2022 02:02:39 -0700 (PDT)
Received: from localhost ([223.104.39.136])
        by smtp.gmail.com with ESMTPSA id i17-20020a170902cf1100b0016d785ef6d2sm3031403plg.223.2022.08.27.02.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 02:02:38 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     dan.carpenter@oracle.com
Cc:     akpm@linux-foundation.org, anton@tuxera.com,
        chenxiaosong2@huawei.com, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
        syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, yin31149@gmail.com
Subject: Re: [PATCH] ntfs: change check order in ntfs_attr_find
Date:   Sat, 27 Aug 2022 17:02:31 +0800
Message-Id: <20220827090230.3287-1-yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220827064217.GK2030@kadam>
References: <20220827064217.GK2030@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Aug 2022 at 14:42, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Fri, Aug 26, 2022 at 11:42:32PM +0800, Hawkins Jiawei wrote:
> > On Fri, 26 Aug 2022 at 23:15, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > >
> > > On Fri, Aug 26, 2022 at 08:32:57PM +0800, Hawkins Jiawei wrote:
> > > > > syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git   master
> > > > >
> > > > > Looks like it is improper check order that causes this bug.
> > > >
> > > > Sorry for wrong command.
> > > > #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git   master
> > > >
> > > > diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> > > > index 52615e6090e1..6480cd2d371d 100644
> > > > --- a/fs/ntfs/attrib.c
> > > > +++ b/fs/ntfs/attrib.c
> > > > @@ -594,10 +594,11 @@ static int ntfs_attr_find(const ATTR_TYPE type, const ntfschar *name,
> > > >       for (;; a = (ATTR_RECORD*)((u8*)a + le32_to_cpu(a->length))) {
> > > >               u8 *mrec_end = (u8 *)ctx->mrec +
> > > >                              le32_to_cpu(ctx->mrec->bytes_allocated);
> > > > +             if ((u8*)a < (u8*)ctx->mrec || (u8*)a > mrec_end)
> > > > +                     break;
> > >
> > > This definitely seems like a bug.  But your code won't build.  Syzbot
> > > must have -Werror turned off?
> > Hi Dan,
> > Did you mean we should put the variable declares at the beginning of the function?
> > (Correct me if I understand anything wrong)
>
> You can declare it at the beginning of the block.
OK, I will do like that.

>
> >
> > >
> > > Btw, this was in the original code, but those casts are ugly.  Ideally
> > > there would be some way to get rid of them.  But otherwise at least
> > > put a space after the u8.  "(u8 *)a < (u8 *)ctx->mrec".
> > >
> > > >               u8 *name_end = (u8 *)a + le16_to_cpu(a->name_offset) +
> > > >                              a->name_length * sizeof(ntfschar);
> > > > -             if ((u8*)a < (u8*)ctx->mrec || (u8*)a > mrec_end ||
> > > > -                 name_end > mrec_end)
> > > > +             if (name_end > mrec_end)
> > > >                       break;
> > >
> > > regards,
> > > dan carpenter
> > So maybe I can try to refactor these codes. But I wonder if this can be
> > done in a seperate bug
>
> The kernel has a strict "one thing per patch rule".  Those rules are
> for reviewers and easier backporting.  So the trick is to write the
> commit message to persuade the reviewer that the way you've written the
> patch is the easiest way to review it.  So here is how I would write the
> commit message:
>
> [PATCH] ntfs: fix out of bounds read in ntfs_attr_find()
>
> This code deferences "a" to calculate "name_end" and then it checks to
> ensure that "a" is within bounds.  Move the bounds checks earlier and
> add some comments to make it more clear what they're doing.  Then
> calculate "name_end" and check that.
>
> (Btw, are the wrap around checks really sufficient?  It seems like it
> could wrap to something still within the ->mrec buffer but before the
> current entry so it would end up in a forever loop or something?)
I am not for sure, but it seems that it is OK before.
As for the forever loop, there is a break when a->length is 0 in the loop,
So I think it probably would not end up in a forever loop?(Correct me if
I am wrong)

>
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index 52615e6090e1..90d567acb2a3 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -594,11 +594,20 @@ static int ntfs_attr_find(const ATTR_TYPE type, const ntfschar *name,
>         for (;; a = (ATTR_RECORD*)((u8*)a + le32_to_cpu(a->length))) {
>                 u8 *mrec_end = (u8 *)ctx->mrec +
>                                le32_to_cpu(ctx->mrec->bytes_allocated);
> -               u8 *name_end = (u8 *)a + le16_to_cpu(a->name_offset) +
> -                              a->name_length * sizeof(ntfschar);
> -               if ((u8*)a < (u8*)ctx->mrec || (u8*)a > mrec_end ||
> -                   name_end > mrec_end)
> +               u8 *name_end;
> +
> +               /* check for wrap around */
> +               if ((u8 *)a < (u8 *)ctx->mrec)
> +                       break;
> +               /* check for overflow */
> +               if ((u8 *)a > mrec_end)
>                         break;
> +
> +               name_end = (u8 *)a + le16_to_cpu(a->name_offset) +
> +                          a->name_length * sizeof(ntfschar);
> +               if (name_end > mrec_end)
> +                       break;
> +
>                 ctx->attr = a;
>                 if (unlikely(le32_to_cpu(a->type) > le32_to_cpu(type) ||
>                                 a->type == AT_END))
Thanks for your suggestion, I will refactor these codes in this way.
