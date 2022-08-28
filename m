Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478F75A3E84
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 18:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiH1QQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 12:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiH1QQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 12:16:06 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CF332A83
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 09:16:01 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id w88-20020a17090a6be100b001fbb0f0b013so6413138pjj.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 09:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=zJ58IbUxUfHQZ1l1Y+m3svyB3b0AMVU5Fh++cHS+4ec=;
        b=WuBVTtVP2LABsmV48efXcFwxaXdc55lU8gWcRpaDpqcOkhekYrnTJsZdvHkK22Ci8V
         6vzElzsJ2PR9A89mOTQaaud0Lu9Vd+7njPZw2kvOWtRRwHzG3i/X+e+uV3UIT8D1NUFq
         lgn073uJZvuI773OJiDTRuh279wJ4BUCFMImlDONWqAGmKhBoEe+1prFZA8A9GFRx4wZ
         hGAHNozIHkpIj/jnPjLEG1l5HdcBJPoa5hCFScqEhxxUyhPE1r9JUvBbYm+6uSuanw03
         7PQRAh2EG3nNVKvCoYsQKuEiyG59TxHezkbPXYn5XGhD+9pb3IAtA48N0oaAtq4sTE/w
         2HnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=zJ58IbUxUfHQZ1l1Y+m3svyB3b0AMVU5Fh++cHS+4ec=;
        b=N+oiUh6Kec/QCytO+Eck3V8D8SfZknT1X3nKnHK3Q0U9AsYNW3S2jkcFhQzpdbX6oo
         nQlpgdXD9aucIHkO9FPAlecZHr3ElFIrq4AKxgglUN/ZoczVSGF15Tpi2hd5iqu96cgV
         xQR0AtXICYcPcRjG3mjxN5STp2zeS3wELNiFJZqmhkfKeKYeBao6w++KrprWJjEms529
         v/jHWA+7nIac8TeAPoitXQHKo/L3NoAV4Z9jVTfYoBbp39sy8IVFJG5Uqa+lh3gzp7X5
         30QqQoCg1+YIBrpooncpsX7vo4iic6li4oKIHNrQM8WFLFB0xRzcTUuJRko0CB1uW02Z
         MgbA==
X-Gm-Message-State: ACgBeo0cwkcIS4uRhtUXavHMsOuFayB/IZvBG0NWSLUBMa4c+iJfmY63
        2bH5N1xGffBkAh9Cb6T4VtQ=
X-Google-Smtp-Source: AA6agR7YxRhxLB0cWsbupFoE/I9EfryO9AnHusPSztq9FIJchsOYA5b2YMBcDndwngcAKxO2Hje+EA==
X-Received: by 2002:a17:902:e851:b0:172:dda3:77d3 with SMTP id t17-20020a170902e85100b00172dda377d3mr12574751plg.19.1661703360860;
        Sun, 28 Aug 2022 09:16:00 -0700 (PDT)
Received: from localhost ([36.112.195.70])
        by smtp.gmail.com with ESMTPSA id u17-20020a627911000000b00536b975b013sm5422879pfc.24.2022.08.28.09.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 09:16:00 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     dan.carpenter@oracle.com
Cc:     akpm@linux-foundation.org, anton@tuxera.com,
        chenxiaosong2@huawei.com, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
        syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, yin31149@gmail.com
Subject: Re: [PATCH] ntfs: change check order in ntfs_attr_find
Date:   Mon, 29 Aug 2022 00:15:52 +0800
Message-Id: <20220828161552.3651-1-yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220827105842.GM2030@kadam>
References: <20220827105842.GM2030@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Sat, 27 Aug 2022 at 18:59, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Sat, Aug 27, 2022 at 05:02:31PM +0800, Hawkins Jiawei wrote:
> > On Sat, 27 Aug 2022 at 14:42, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > >
> > > On Fri, Aug 26, 2022 at 11:42:32PM +0800, Hawkins Jiawei wrote:
> > > > On Fri, 26 Aug 2022 at 23:15, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > > > >
> > > > > On Fri, Aug 26, 2022 at 08:32:57PM +0800, Hawkins Jiawei wrote:
> > > > > > > syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git     master
> > > > > > >
> > > > > > > Looks like it is improper check order that causes this bug.
> > > > > >
> > > > > > Sorry for wrong command.
> > > > > > #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git     master
> > > > > >
> > > > > > diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> > > > > > index 52615e6090e1..6480cd2d371d 100644
> > > > > > --- a/fs/ntfs/attrib.c
> > > > > > +++ b/fs/ntfs/attrib.c
> > > > > > @@ -594,10 +594,11 @@ static int ntfs_attr_find(const ATTR_TYPE type, const ntfschar *name,
> > > > > >       for (;; a = (ATTR_RECORD*)((u8*)a + le32_to_cpu(a->length))) {
> > > > > >               u8 *mrec_end = (u8 *)ctx->mrec +
> > > > > >                              le32_to_cpu(ctx->mrec->bytes_allocated);
> > > > > > +             if ((u8*)a < (u8*)ctx->mrec || (u8*)a > mrec_end)
> > > > > > +                     break;
> > > > >
> > > > > This definitely seems like a bug.  But your code won't build.  Syzbot
> > > > > must have -Werror turned off?
> > > > Hi Dan,
> > > > Did you mean we should put the variable declares at the beginning of the function?
> > > > (Correct me if I understand anything wrong)
> > >
> > > You can declare it at the beginning of the block.
> > OK, I will do like that.
> >
> > >
> > > >
> > > > >
> > > > > Btw, this was in the original code, but those casts are ugly.  Ideally
> > > > > there would be some way to get rid of them.  But otherwise at least
> > > > > put a space after the u8.  "(u8 *)a < (u8 *)ctx->mrec".
> > > > >
> > > > > >               u8 *name_end = (u8 *)a + le16_to_cpu(a->name_offset) +
> > > > > >                              a->name_length * sizeof(ntfschar);
> > > > > > -             if ((u8*)a < (u8*)ctx->mrec || (u8*)a > mrec_end ||
> > > > > > -                 name_end > mrec_end)
> > > > > > +             if (name_end > mrec_end)
> > > > > >                       break;
> > > > >
> > > > > regards,
> > > > > dan carpenter
> > > > So maybe I can try to refactor these codes. But I wonder if this can be
> > > > done in a seperate bug
> > >
> > > The kernel has a strict "one thing per patch rule".  Those rules are
> > > for reviewers and easier backporting.  So the trick is to write the
> > > commit message to persuade the reviewer that the way you've written the
> > > patch is the easiest way to review it.  So here is how I would write the
> > > commit message:
> > >
> > > [PATCH] ntfs: fix out of bounds read in ntfs_attr_find()
> > >
> > > This code deferences "a" to calculate "name_end" and then it checks to
> > > ensure that "a" is within bounds.  Move the bounds checks earlier and
> > > add some comments to make it more clear what they're doing.  Then
> > > calculate "name_end" and check that.
> > >
> > > (Btw, are the wrap around checks really sufficient?  It seems like it
> > > could wrap to something still within the ->mrec buffer but before the
> > > current entry so it would end up in a forever loop or something?)
> > I am not for sure, but it seems that it is OK before.
> > As for the forever loop, there is a break when a->length is 0 in the loop,
> > So I think it probably would not end up in a forever loop?(Correct me if
> > I am wrong)
> >
>
> Checking for zero is not sufficient because it can wrap on 32 bit
> systems.  It needs something like:
>
>                         return -ENOENT;
>                 len = le32_to_cpu(a->length);
>                 if (!len ||
>                     (void *)a + len < (void *)a ||
>                     (void *)a + len > mrec_end)
>                         break;
>                 if (a->type != type)
>                         continue;
>
> Sort of ugly, but hopefully it gives the idea of what I'm saying.
>
> regards,
> dan carpenter
Hi, Dan
Do you mean there may be an overflow on 32bit systems?
It seems that it is, so it may end up in a forever loop
as you point out before.

I will try to add an overflow checking helper to fix it.
