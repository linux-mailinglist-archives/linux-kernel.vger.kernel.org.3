Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B57C5A382E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 16:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbiH0OuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 10:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbiH0OuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 10:50:22 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1547E0A7
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 07:50:20 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id r22so3919769pgm.5
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 07:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=dZ4zlrr+go/KaBB0jREILJ4K7QdtlExm7aQVnIZgPn8=;
        b=loHmnPaZgxZiI8nLJHM0/6F+WR9dv629rzz9HnMyYWhc5x+MavOwZaPcU/BwJVygl5
         ArKBUI7UNJzAqSVoLrwChUEHaLq1tpoYCfxjWjkX/RGaseYmIZLbuOliNOpf3fiIey2T
         IyRg5H0//A7Sl13WeiPhGX86Sm9TVxfM8jMVLCaXCswP0mSWBUQTj7VtDXlgxCjWUHu7
         aDvYjYaM/4USdI5kGPpmjAMZNaIN1Z3kicc8mw1t5EAi/mBzmso1z5x5vmWndv1KnhqD
         8ZH+8vuXog1VdwRfWpnqt5muJktTCbxYe77BYMq3rskO84l7TzVWy5iBmlOo1VivrSAz
         ROKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=dZ4zlrr+go/KaBB0jREILJ4K7QdtlExm7aQVnIZgPn8=;
        b=Ga4VLFuNXr9iCRGtXKryM69d48WJIBHgLLqAq/5VsQifPm5FL9E9xHNvg+XJqXgfKa
         UDRKsB8u9KyFBdznt19dOavnV2U+s5vpUqsMBBNzTZatROjLI3D07x53ARInacjEdWz4
         KQc9TpEspq7ZUoTRq82j5HH82hSuaEccY6dwVxgLrfcymKbOK/i7OgjryzVqm50EqY71
         aXtkZqcht+kFG/uwQ1yaFRx4Wy+Atd1u3/k4OwgKiW+Ph0KHYLuvtquZ2fHB5sX3L/z9
         XDiYp4s5J9QmxQ8QYr6FtKi2ocfsU7skD0faBHup+LVLKheCa8Or3rMWMg0XkRayF6Pj
         qfeQ==
X-Gm-Message-State: ACgBeo3FfptsiFfTkJM/zDSIk48YyZNMRRaSLSNS8ePEu9SUkIlQDhGd
        0LoSIXoXRxgEh63fpT/mb8w=
X-Google-Smtp-Source: AA6agR78Svaxuabnx52QbLppHuW6RmmkeGfzVNIRu3kFq6ssXA/9Eh3r3054yiZeluQ3TjLIlkYxmA==
X-Received: by 2002:a65:468a:0:b0:42b:3b13:f7ee with SMTP id h10-20020a65468a000000b0042b3b13f7eemr7486715pgr.112.1661611820383;
        Sat, 27 Aug 2022 07:50:20 -0700 (PDT)
Received: from localhost ([223.104.39.136])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090a16c800b001faafa42a9esm3481850pje.26.2022.08.27.07.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 07:50:19 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     yin31149@gmail.com
Cc:     akpm@linux-foundation.org, anton@tuxera.com,
        chenxiaosong2@huawei.com, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
        syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] ntfs: change check order in ntfs_attr_find
Date:   Sat, 27 Aug 2022 22:49:44 +0800
Message-Id: <20220827144943.5290-1-yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220827075143.61311-1-yin31149@gmail.com>
References: <20220827075143.61311-1-yin31149@gmail.com>
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

On Sat, 27 Aug 2022 at 15:59, Hawkins Jiawei <yin31149@gmail.com> wrote:
>
> On Sat, 27 Aug 2022 at 09:29, chenxiaosong (A) <chenxiaosong2@huawei.com> wrote:
> >
> > 在 2022/8/26 20:27, Hawkins Jiawei 写道:
> > > syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > >
> > > Looks like it is improper check order that causes this bug.
> > >
> > > Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> > > ---
> > >   fs/ntfs/attrib.c | 5 +++--
> > >   1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> > > index 52615e6090e1..6480cd2d371d 100644
> > > --- a/fs/ntfs/attrib.c
> > > +++ b/fs/ntfs/attrib.c
> > > @@ -594,10 +594,11 @@ static int ntfs_attr_find(const ATTR_TYPE type, const ntfschar *name,
> > >       for (;; a = (ATTR_RECORD*)((u8*)a + le32_to_cpu(a->length))) {
> > >               u8 *mrec_end = (u8 *)ctx->mrec +
> > >                              le32_to_cpu(ctx->mrec->bytes_allocated);
> > > +             if ((u8*)a < (u8*)ctx->mrec || (u8*)a > mrec_end)
> > > +                     break;
> > >               u8 *name_end = (u8 *)a + le16_to_cpu(a->name_offset) +
> > >                              a->name_length * sizeof(ntfschar);
> > > -             if ((u8*)a < (u8*)ctx->mrec || (u8*)a > mrec_end ||
> > > -                 name_end > mrec_end)
> > > +             if (name_end > mrec_end)
> > >                       break;
> > >               ctx->attr = a;
> > >               if (unlikely(le32_to_cpu(a->type) > le32_to_cpu(type) ||
> > >
> >
> > The reason is that a->length is 0, it will occur uaf when deref any
> > field of ATTR_RECORD.
> >
> > It seems that changing check order will not fix root cause, if the
> > condition "if ((u8*)a < (u8*)ctx->mrec || (u8*)a > mrec_end)" is false,
> > uaf will still occur.
> >
> > Do you have any thoughts on this ?
> Hi, chenxiaosong
>
> I think changing the check order is able to fix this bug. But we may need
> to check whether mft record header is out of bounds, maybe
> "if ((u8*)a < (u8*)ctx->mrec || (u8*)a + sizeof(MFT_RECORD) > mrec_end)"
>
> Because we just need to check if this ATTR_RECORD is in valid addresss. As for
> situation that a->length is 0, there seems already a check in the loop
> (Correct me if I am wrong):
> > static int ntfs_attr_find(const ATTR_TYPE type, const ntfschar *name,
> >               const u32 name_len, const IGNORE_CASE_BOOL ic,
> >               const u8 *val, const u32 val_len, ntfs_attr_search_ctx *ctx)
> > {
> >       ...
> >
> >       for (;; a = (ATTR_RECORD*)((u8*)a + le32_to_cpu(a->length))) {
> >               u8 *mrec_end = (u8 *)ctx->mrec +
> >                              le32_to_cpu(ctx->mrec->bytes_allocated);
> >               u8 *name_end = (u8 *)a + le16_to_cpu(a->name_offset) +
> >                              a->name_length * sizeof(ntfschar);
> >               if ((u8*)a < (u8*)ctx->mrec || (u8*)a > mrec_end ||
> >                   name_end > mrec_end)
> >                       break;
> >               ctx->attr = a;
> >               if (unlikely(le32_to_cpu(a->type) > le32_to_cpu(type) ||
> >                               a->type == AT_END))
> >                       return -ENOENT;
> >               if (unlikely(!a->length))
> >                       break;
> >       ...
> > }
>
> And as for the root cause for use-after-free read, I think it is the
> ctx->attr->length to be blamed.
Apologize for my typing error, it is the ctx->attr should be blamed:

static int ntfs_attr_find(const ATTR_TYPE type, const ntfschar *name,
		const u32 name_len, const IGNORE_CASE_BOOL ic,
		const u8 *val, const u32 val_len, ntfs_attr_search_ctx *ctx)
{
	ATTR_RECORD *a;
	ntfs_volume *vol = ctx->ntfs_ino->vol;
	ntfschar *upcase = vol->upcase;
	u32 upcase_len = vol->upcase_len;

	/*
	 * Iterate over attributes in mft record starting at @ctx->attr, or the
	 * attribute following that, if @ctx->is_first is 'true'.
	 */
	if (ctx->is_first) {
		a = ctx->attr;
		ctx->is_first = false;
	} else
		a = (ATTR_RECORD*)((u8*)ctx->attr +
				le32_to_cpu(ctx->attr->length));
	...
}

The "ctx->attr" is not invalid, then the pointer "a" will probably also
points to an invalid memory, which triggers a use-after-free read.
This also probably explains why the memory state around the buggy address are
all invalid in KASAN, instead of at the bounder between valid memory
and invalid memory

Yet the analysis below is still correct. ctx->attr is assigned with
"((u8*)mrec + le16_to_cpu(mrec->attrs_offset))" in
ntfs_attr_init_search_ctx()
>
> To be more specific, when kernel loads the struct MFT_RECORD from disk
> in ntfs_read_inode_mount(),  m's attrs_offset field should less than
> m's bytes_allocated field, or it may out of the bounds:
>
> int ntfs_read_inode_mount(struct inode *vi)
> {
>         ...
>         MFT_RECORD *m = NULL;
>         i = vol->mft_record_size;
>
>         ...
>         m = (MFT_RECORD*)ntfs_malloc_nofs(i);
>
>         /* Determine the first block of the $MFT/$DATA attribute. */
>         block = vol->mft_lcn << vol->cluster_size_bits >>
>                         sb->s_blocksize_bits;
>         nr_blocks = vol->mft_record_size >> sb->s_blocksize_bits;
>
>         ...
>
>         /* Load $MFT/$DATA's first mft record. */
>         for (i = 0; i < nr_blocks; i++) {
>                 bh = sb_bread(sb, block++);
>                 if (!bh) {
>                         ntfs_error(sb, "Device read failed.");
>                         goto err_out;
>                 }
>                 memcpy((char*)m + (i << sb->s_blocksize_bits), bh->b_data,
>                                 sb->s_blocksize);
>                 brelse(bh);
>         }
>
>         if (le32_to_cpu(m->bytes_allocated) != vol->mft_record_size) {
>                 ntfs_error(sb, "Incorrect mft record size %u in superblock, should be %u.",
>                                 le32_to_cpu(m->bytes_allocated), vol->mft_record_size);
>                 goto err_out;
>         }
>
>         ...
>
>         ctx = ntfs_attr_get_search_ctx(ni, m);
>         if (!ctx) {
>                 err = -ENOMEM;
>                 goto err_out;
>         }
>
>         /* Find the attribute list attribute if present. */
>         err = ntfs_attr_lookup(AT_ATTRIBUTE_LIST, NULL, 0, 0, 0, NULL, 0, ctx);
>
>         ...
> }
>
> > ==================================================================
> > BUG: KASAN: use-after-free in ntfs_attr_find+0xc02/0xce0 fs/ntfs/attrib.c:597
> > Read of size 2 at addr ffff88807e352009 by task syz-executor153/3607
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
> > Memory state around the buggy address:
> >  ffff88807e351f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >  ffff88807e351f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > >ffff88807e352000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >                       ^
> >  ffff88807e352080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >  ffff88807e352100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > ==================================================================
> So check these fields as follow should fix the root cause for this
> use-after-free bug(Correct me if I am wrong). I test this patch locally,
> it doesn't trigger any issue.
>
> diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
> index db0f1995aedd..6ba99e109ca9 100644
> --- a/fs/ntfs/inode.c
> +++ b/fs/ntfs/inode.c
> @@ -1822,6 +1822,11 @@ int ntfs_read_inode_mount(struct inode *vi)
>                 goto err_out;
>         }
>
> +       if (m->attrs_offset >= le32_to_cpu(m->bytes_allocated)) {
> +               ntfs_error(sb, "Incorrect mft record attrs_offset %u", m->attrs_offset);
> +               goto err_out;
> +       }
> +
>         /* Apply the mst fixups. */
>         if (post_read_mst_fixup((NTFS_RECORD*)m, vol->mft_record_size)) {
>                 /* FIXME: Try to use the $MFTMirr now. */
>
>
> What's your opinion?
