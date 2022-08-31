Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989215A7CCF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiHaMEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiHaMEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:04:31 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139BDD2933
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:04:28 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id x80so9746964pgx.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=IwMyg41R2EGl0FJUp0yhBhoY3g3at35aUB0QWp4v9no=;
        b=YzrUeelY9m6wgQ+9R1Ae4z4LCenVRY9+ws0frazyKrml0IjzOMc+HWK0yYzCI5kf8n
         lxV7CM2uhCU0+JgZlX7PIe9fqXJacYuXkmnlurVciy2FvWigxEeDi24Uft9j9l6a5gU+
         VN9gMTC9b1Np4MspiJtZsGeWnwfBNUZV4b0n3B4HJSV15G40+sOai5oAT1to5si5Vtji
         ZASfAyikKTlrWVdVsKKKh3R52zrbq22kfpLMfrMk+KRIFI9uWZ6e6Pbo+ALFSYaQfo3X
         GOKhNGpCB1pMRcXNj+td/9B8yIdedk9EQrhJR9pvfQ0iLJMkUPJGxxugOAZPl5Mhu5rB
         cNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=IwMyg41R2EGl0FJUp0yhBhoY3g3at35aUB0QWp4v9no=;
        b=VzVKWBqBel/sos4HRDcYoWYh/StbCQuwvv02dYs0WWPkihLuJt4REdsTAFPvimZA0+
         m7UBssu2Kid5YWMEtelPzd1nQ99z+CFFQ1OsEE4RybB+xQ9TKmXf3EiMI8zv873qfc6B
         HmVikMbgRdPVn3FbHadd2KYLP9yindQrRPwzZPfReB9MCEgcJR6C0MO6uvGOVH1kWyMy
         07RdeSUXAsrjqMzIzstzn0SXVIOtoi5/CKwoYgZHRJl1LQjN6yreG+sI1dZTt6ThfPDZ
         YkGH+p2W754XdfT9cwRFevsUS8/Plqv22aZX8EpnZeLWuxYsEe1nYJIAaCJYDZ2XtvPj
         yQVg==
X-Gm-Message-State: ACgBeo0U2tdHnQSPsJGjEPNSAxZRKpjAJhzSoeG20HNzY7jfBBrfGDHl
        CBwWvagrlJXS6h4a7QbBI+8=
X-Google-Smtp-Source: AA6agR4yvnY/18/QLTX8DrPb/7i/o4dpapqsqx+vhSwYD7nWekpcA5gmSERBmeRXmFqpIsZgA1uvNA==
X-Received: by 2002:a63:5912:0:b0:42a:dcc6:210d with SMTP id n18-20020a635912000000b0042adcc6210dmr22590418pgb.50.1661947467547;
        Wed, 31 Aug 2022 05:04:27 -0700 (PDT)
Received: from localhost ([36.112.86.8])
        by smtp.gmail.com with ESMTPSA id g8-20020a62f948000000b0053ab9c189e2sm1337356pfm.2.2022.08.31.05.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 05:04:27 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     dan.carpenter@oracle.com
Cc:     18801353760@163.com, akpm@linux-foundation.org, anton@tuxera.com,
        chenxiaosong2@huawei.com, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
        syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, yin31149@gmail.com
Subject: Re: [PATCH 2/3] ntfs: fix out-of-bounds read in ntfs_attr_find()
Date:   Wed, 31 Aug 2022 20:03:25 +0800
Message-Id: <20220831120324.4477-1-yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220831110727.GK2071@kadam>
References: <20220831110727.GK2071@kadam>
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

On Wed, 31 Aug 2022 at 19:08, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Wed, Aug 31, 2022 at 10:43:36AM +0800, Hawkins Jiawei wrote:
> > Kernel will iterates over ATTR_RECORDs in mft record in ntfs_attr_find().
> > To ensure access on these ATTR_RECORDs are within bounds, kernel will
> > do some checking during iteration.
> >
> > The problem is that during checking whether ATTR_RECORD's name is within
> > bounds, kernel will dereferences the ATTR_RECORD name_offset field,
> > before checking this ATTR_RECORD strcture is within bounds. This problem
> > may result out-of-bounds read in ntfs_attr_find(), reported by
> > Syzkaller:
> >
> > ==================================================================
> > BUG: KASAN: use-after-free in ntfs_attr_find+0xc02/0xce0 fs/ntfs/attrib.c:597
> > Read of size 2 at addr ffff88807e352009 by task syz-executor153/3607
> >
> > [...]
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> >  print_address_description mm/kasan/report.c:317 [inline]
> >  print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
> >  kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
> >  ntfs_attr_find+0xc02/0xce0 fs/ntfs/attrib.c:597
> >  ntfs_attr_lookup+0x1056/0x2070 fs/ntfs/attrib.c:1193
> >  ntfs_read_inode_mount+0x89a/0x2580 fs/ntfs/inode.c:1845
> >  ntfs_fill_super+0x1799/0x9320 fs/ntfs/super.c:2854
> >  mount_bdev+0x34d/0x410 fs/super.c:1400
> >  legacy_get_tree+0x105/0x220 fs/fs_context.c:610
> >  vfs_get_tree+0x89/0x2f0 fs/super.c:1530
> >  do_new_mount fs/namespace.c:3040 [inline]
> >  path_mount+0x1326/0x1e20 fs/namespace.c:3370
> >  do_mount fs/namespace.c:3383 [inline]
> >  __do_sys_mount fs/namespace.c:3591 [inline]
> >  __se_sys_mount fs/namespace.c:3568 [inline]
> >  __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >  [...]
> >  </TASK>
> >
> > The buggy address belongs to the physical page:
> > page:ffffea0001f8d400 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7e350
> > head:ffffea0001f8d400 order:3 compound_mapcount:0 compound_pincount:0
> > flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
> > raw: 00fff00000010200 0000000000000000 dead000000000122 ffff888011842140
> > raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
> > page dumped because: kasan: bad access detected
> > Memory state around the buggy address:
> >  ffff88807e351f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >  ffff88807e351f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > >ffff88807e352000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >                       ^
> >  ffff88807e352080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >  ffff88807e352100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > ==================================================================
> >
> > This patch solves it by moving the ATTR_RECORD strcture's bounds
> > checking earlier, then checking whether ATTR_RECORD's name
> > is within bounds. What's more, this patch also add some comments
> > to improve its maintainability.
> >
> > Reported-and-tested-by: syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com
> > Signed-off-by: chenxiaosong (A) <chenxiaosong2@huawei.com>
> > Link: https://lore.kernel.org/all/1636796c-c85e-7f47-e96f-e074fee3c7d3@huawei.com/
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Link: https://groups.google.com/g/syzkaller-bugs/c/t_XdeKPGTR4/m/LECAuIGcBgAJ
> > Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> > ---
> >  fs/ntfs/attrib.c | 20 ++++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> > index 52615e6090e1..904734e34507 100644
> > --- a/fs/ntfs/attrib.c
> > +++ b/fs/ntfs/attrib.c
> > @@ -594,11 +594,23 @@ static int ntfs_attr_find(const ATTR_TYPE type, const ntfschar *name,
> >       for (;; a = (ATTR_RECORD*)((u8*)a + le32_to_cpu(a->length))) {
> >               u8 *mrec_end = (u8 *)ctx->mrec +
> >                              le32_to_cpu(ctx->mrec->bytes_allocated);
> > -             u8 *name_end = (u8 *)a + le16_to_cpu(a->name_offset) +
> > -                            a->name_length * sizeof(ntfschar);
> > -             if ((u8*)a < (u8*)ctx->mrec || (u8*)a > mrec_end ||
> > -                 name_end > mrec_end)
> > +             u8 *name_end, *arec_head_end;
> > +
> > +             /* check for wrap around */
> > +             if ((u8 *)a < (u8 *)ctx->mrec)
> > +                     break;
> > +
> > +             /* check whether Attribute Record Header is within bounds */
> > +             arec_head_end = (u8 *)a + sizeof(ATTR_RECORD);
> > +             if (arec_head_end < (u8 *)a || arec_head_end > mrec_end)
>
> This works but I feel like it would be more natural to just check if
> a was valid and if a +  sizeof(ATTR_RECORD) was also valid.
>
>         if (a > mrec_end || (u8 *)a + sizeof(ATTR_RECORD) > mrec_end)
Hi Dan,
Thanks for your suggestion.
This looks more natural than original patch, yet I wonder if there may
be an overflow?

To be more specific, if "a" and "mrec_end" is large enough, it seems that
some fields of "a" may be out-of-bounds and also bypass this check because
of the overflow.(Please correct me if I am wrong)
> But what you have also works so if you want to go with that then that's
> fine.
>
> regards,
> dan carpenter
>
> >                       break;
> > +
> > +             /* check whether ATTR_RECORD's name is within bounds */
> > +             name_end = (u8 *)a + le16_to_cpu(a->name_offset) +
> > +                        a->name_length * sizeof(ntfschar);
> > +             if (name_end > mrec_end)
> > +                     break;
> > +
> >               ctx->attr = a;
> >               if (unlikely(le32_to_cpu(a->type) > le32_to_cpu(type) ||
> >                               a->type == AT_END))
>
