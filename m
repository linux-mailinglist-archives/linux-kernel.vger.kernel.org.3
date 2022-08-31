Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3955A7DD3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiHaMsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiHaMsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:48:15 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB6089CFF
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:48:14 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y127so14314652pfy.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=6NKnzrETkbi6SAy1MFS1UHBKyYJZhDmPoJGYfc26l3U=;
        b=kZN6sEwtcAwkyKo/tpc3V8sA3AtrAS3avh7p8yQKEaEEupE2tkRiinrFRLQUcDmZfK
         mPQLOA2lAuWgQ1v/1fmpUh4/wiwQd2sPQbtAWv7tQxTTF//hOUSx5nWuW/bQD93o+liJ
         zqZ7zIRgcveLQ7q15T8+WqEmfaKu7fJ1cvATN9NtJRW8rNruBea8lFCSzHrT8DfLTqTT
         tBcfsyJosiNlKqZnB+aKTX2Yw540gE/cOwdfSvvehYB0epds2RgX9gDY5jwY3bS8C0Ni
         zT+SyFx2ykHF8PEIaxyvXw7L1zsLR7Zbu7kYPWaffX5zfkFImUjYkfq3FJvked1cUQQz
         IACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=6NKnzrETkbi6SAy1MFS1UHBKyYJZhDmPoJGYfc26l3U=;
        b=NWLkJoA6ZcaaVxd60N4ucYARprZLg2/xjZRJqzzt6HMyG7/99GILT3FDuvKxsyeijJ
         mXg8KqSlFwvfXaRQ8amgJPhDdaLrC3WAuWoIHFHPMYN1I74eWL+eBWa+UMHtGsunNZZK
         dWg04kjfXEUyLs1uldpB/kuXTJ7nr1uZ7+tX3XUfgeztsSfyIxxwbhp1H18MK9F+7sBo
         PeWlrwAfm42SIIGvRptEXlbqz33q90casmhXH0RKS3JVCs50INi+VO+oWdclaSdw1G8+
         Vb0KKih4cy+biySGi22e60HhNoAuPouKjLJKVkfe86WXXKKyiP2Hk3/V1IDsZs6umCkr
         zjng==
X-Gm-Message-State: ACgBeo3PdbA2XcIRR00nW/xSgdZfJbROhqHB5H0FLIxrQmQemKHVTseE
        Wtl165NnFq59yIRGNNUUNDY=
X-Google-Smtp-Source: AA6agR6ZUrxbULA3wUe/ALNomHW68v7PrN6LPTlsCp1bg6NxmjlU3wN6ff8iCeP1H+AmZrmMC9Upng==
X-Received: by 2002:a63:87:0:b0:42e:16f2:7a40 with SMTP id 129-20020a630087000000b0042e16f27a40mr6481941pga.302.1661950094276;
        Wed, 31 Aug 2022 05:48:14 -0700 (PDT)
Received: from localhost ([36.112.86.8])
        by smtp.gmail.com with ESMTPSA id o186-20020a62cdc3000000b005289a50e4c2sm11147225pfg.23.2022.08.31.05.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 05:48:13 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     dan.carpenter@oracle.com
Cc:     18801353760@163.com, akpm@linux-foundation.org, anton@tuxera.com,
        chenxiaosong2@huawei.com, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
        syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, yin31149@gmail.com
Subject: Re: [PATCH 2/3] ntfs: fix out-of-bounds read in ntfs_attr_find()
Date:   Wed, 31 Aug 2022 20:47:36 +0800
Message-Id: <20220831124735.7044-1-yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220831122046.GA2030@kadam>
References: <20220831122046.GA2030@kadam>
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

On Wed, 31 Aug 2022 at 20:22, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Wed, Aug 31, 2022 at 08:03:25PM +0800, Hawkins Jiawei wrote:
> > On Wed, 31 Aug 2022 at 19:08, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > >
> > > On Wed, Aug 31, 2022 at 10:43:36AM +0800, Hawkins Jiawei wrote:
> > > > Kernel will iterates over ATTR_RECORDs in mft record in ntfs_attr_find().
> > > > To ensure access on these ATTR_RECORDs are within bounds, kernel will
> > > > do some checking during iteration.
> > > >
> > > > The problem is that during checking whether ATTR_RECORD's name is within
> > > > bounds, kernel will dereferences the ATTR_RECORD name_offset field,
> > > > before checking this ATTR_RECORD strcture is within bounds. This problem
> > > > may result out-of-bounds read in ntfs_attr_find(), reported by
> > > > Syzkaller:
> > > >
> > > > ==================================================================
> > > > BUG: KASAN: use-after-free in ntfs_attr_find+0xc02/0xce0 fs/ntfs/attrib.c:597
> > > > Read of size 2 at addr ffff88807e352009 by task syz-executor153/3607
> > > >
> > > > [...]
> > > > Call Trace:
> > > >  <TASK>
> > > >  __dump_stack lib/dump_stack.c:88 [inline]
> > > >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> > > >  print_address_description mm/kasan/report.c:317 [inline]
> > > >  print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
> > > >  kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
> > > >  ntfs_attr_find+0xc02/0xce0 fs/ntfs/attrib.c:597
> > > >  ntfs_attr_lookup+0x1056/0x2070 fs/ntfs/attrib.c:1193
> > > >  ntfs_read_inode_mount+0x89a/0x2580 fs/ntfs/inode.c:1845
> > > >  ntfs_fill_super+0x1799/0x9320 fs/ntfs/super.c:2854
> > > >  mount_bdev+0x34d/0x410 fs/super.c:1400
> > > >  legacy_get_tree+0x105/0x220 fs/fs_context.c:610
> > > >  vfs_get_tree+0x89/0x2f0 fs/super.c:1530
> > > >  do_new_mount fs/namespace.c:3040 [inline]
> > > >  path_mount+0x1326/0x1e20 fs/namespace.c:3370
> > > >  do_mount fs/namespace.c:3383 [inline]
> > > >  __do_sys_mount fs/namespace.c:3591 [inline]
> > > >  __se_sys_mount fs/namespace.c:3568 [inline]
> > > >  __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
> > > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > > >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > > >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > >  [...]
> > > >  </TASK>
> > > >
> > > > The buggy address belongs to the physical page:
> > > > page:ffffea0001f8d400 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7e350
> > > > head:ffffea0001f8d400 order:3 compound_mapcount:0 compound_pincount:0
> > > > flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
> > > > raw: 00fff00000010200 0000000000000000 dead000000000122 ffff888011842140
> > > > raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
> > > > page dumped because: kasan: bad access detected
> > > > Memory state around the buggy address:
> > > >  ffff88807e351f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > > >  ffff88807e351f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > > > >ffff88807e352000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > >                       ^
> > > >  ffff88807e352080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > >  ffff88807e352100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > > ==================================================================
> > > >
> > > > This patch solves it by moving the ATTR_RECORD strcture's bounds
> > > > checking earlier, then checking whether ATTR_RECORD's name
> > > > is within bounds. What's more, this patch also add some comments
> > > > to improve its maintainability.
> > > >
> > > > Reported-and-tested-by: syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com
> > > > Signed-off-by: chenxiaosong (A) <chenxiaosong2@huawei.com>
> > > > Link: https://lore.kernel.org/all/1636796c-c85e-7f47-e96f-e074fee3c7d3@huawei.com/
> > > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > Link: https://groups.google.com/g/syzkaller-bugs/c/t_XdeKPGTR4/m/LECAuIGcBgAJ
> > > > Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> > > > ---
> > > >  fs/ntfs/attrib.c | 20 ++++++++++++++++----
> > > >  1 file changed, 16 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> > > > index 52615e6090e1..904734e34507 100644
> > > > --- a/fs/ntfs/attrib.c
> > > > +++ b/fs/ntfs/attrib.c
> > > > @@ -594,11 +594,23 @@ static int ntfs_attr_find(const ATTR_TYPE type, const ntfschar *name,
> > > >       for (;; a = (ATTR_RECORD*)((u8*)a + le32_to_cpu(a->length))) {
> > > >               u8 *mrec_end = (u8 *)ctx->mrec +
> > > >                              le32_to_cpu(ctx->mrec->bytes_allocated);
> > > > -             u8 *name_end = (u8 *)a + le16_to_cpu(a->name_offset) +
> > > > -                            a->name_length * sizeof(ntfschar);
> > > > -             if ((u8*)a < (u8*)ctx->mrec || (u8*)a > mrec_end ||
> > > > -                 name_end > mrec_end)
> > > > +             u8 *name_end, *arec_head_end;
> > > > +
> > > > +             /* check for wrap around */
> > > > +             if ((u8 *)a < (u8 *)ctx->mrec)
> > > > +                     break;
> > > > +
> > > > +             /* check whether Attribute Record Header is within bounds */
> > > > +             arec_head_end = (u8 *)a + sizeof(ATTR_RECORD);
> > > > +             if (arec_head_end < (u8 *)a || arec_head_end > mrec_end)
> > >
> > > This works but I feel like it would be more natural to just check if
> > > a was valid and if a +  sizeof(ATTR_RECORD) was also valid.
> > >
> > >         if (a > mrec_end || (u8 *)a + sizeof(ATTR_RECORD) > mrec_end)
> > Hi Dan,
> > Thanks for your suggestion.
> > This looks more natural than original patch, yet I wonder if there may
> > be an overflow?
> >
> > To be more specific, if "a" and "mrec_end" is large enough, it seems that
> > some fields of "a" may be out-of-bounds and also bypass this check because
> > of the overflow.(Please correct me if I am wrong)
>
> Are we talking buffer overflows or integer overflows?  There is no
> buffer overflow until we dereference "a".  The checks are just pointer
> math and not dereferences.
>
> For integer overflows if "a" is valid then "a + sizeof(ATTR_RECORD)"
> will not have an integer.  I do not know exactly how memory is laid out
Sorry for the lack of clarity.
What you analyse is what I want to ask. For there are code below this
check, dereferencing "a"(such as a->name_offset). So if there is an
integer overflows in this check, then it may leads to the buffer overflows.

> in the kernel and it also depends on the arch. But the last page is
> always error pointer values so you can always add a page to any valid
> pointer without an integer overflow.
OK, it makes sense now.
I will refactor this patch as you suggested before.
Thanks for your explaination.
