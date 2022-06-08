Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141AF542DDE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237364AbiFHKaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237903AbiFHK3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:29:30 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D93FC0469
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 03:20:38 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id o7so7212107eja.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 03:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MOErlrKzcQ0fQGKzKCELcp2CMfm4h2E469Ifi2WUjpY=;
        b=WJvip2ibSrEZvbDiUNa7JekF+K4j2m3EL1NncxpLz5TkY7DE479sifvRs+9BiZ+G2t
         oWeUoIkAdWfyjSKtpwzZ3ndWz8TL0RLVKwZPh1A9BPnkdXUbNNdE86E2xIiFBGypXTbz
         0WLlFaQu42r991k4noZxW4cSiSYm3kd+vsaEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MOErlrKzcQ0fQGKzKCELcp2CMfm4h2E469Ifi2WUjpY=;
        b=CVSFnKxjR8E71kjceH5tJLOTpiC5C4XkCXPJUapD/qMh5xiK5lwBgXTNC+LM/TOCP2
         3bdYcnHyuPa3I6JvsFpqIDMduh3x/DAeGrfvSALZjFw5wenx5TuNYrGTJu1CNGWSQdyT
         DHdgFQxdLP3tMRawE+G31pezvyeJ38cynGI74CyA9f/xQ1Vr25T1gU09WKDt1e6QNCu5
         kpEPPDA7CTIEpBYr1uMyKBHt9prJjj4BeLsPouSpNmpylv+zScFPZSXU2UmH9uYDJKme
         aiRrkp/KbpiOlL7/E9OC/sa1qkPLdoasmDXzz55CEVzsxkfg5x3XCrz5M2sAxMc2I27i
         r5/w==
X-Gm-Message-State: AOAM531eQteQ1XfYRzjvUiKqrBPNXfBs/WE0XgD6eoqsgO6MPaERCxZW
        LMN2opi3EwY5BerNXuISE1CkW8BP4Ntwg9LfpS4p3w==
X-Google-Smtp-Source: ABdhPJxRuD7qoNFPxC5yA3clz7LmXcRRFdUy1KgowVtGWClNjAStxI/Cd9NKgyaKhPsrkpEE1CkW+7A0RESM2g3V3PQ=
X-Received: by 2002:a17:907:2ce2:b0:6ff:30e2:25c3 with SMTP id
 hz2-20020a1709072ce200b006ff30e225c3mr30423037ejc.494.1654683636410; Wed, 08
 Jun 2022 03:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220606150305.1883410-1-hsinyi@chromium.org> <20220606150305.1883410-4-hsinyi@chromium.org>
 <1794711.atdPhlSkOF@opensuse>
In-Reply-To: <1794711.atdPhlSkOF@opensuse>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 8 Jun 2022 18:20:10 +0800
Message-ID: <CAJMQK-h_XYir+fpji3MYx=RzFJFHkkS4-GvtfVie5Hkjo9kK2w@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] squashfs: implement readahead
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Phillip Lougher <phillip@squashfs.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongwei Song <Xiongwei.Song@windriver.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zheng Liang <zhengliang6@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        "squashfs-devel @ lists . sourceforge . net" 
        <squashfs-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, ira.weiny@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 8, 2022 at 3:29 AM Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
>
> On luned=C3=AC 6 giugno 2022 17:03:05 CEST Hsin-Yi Wang wrote:
> > Implement readahead callback for squashfs. It will read datablocks
> > which cover pages in readahead request. For a few cases it will
> > not mark page as uptodate, including:
> > - file end is 0.
> > - zero filled blocks.
> > - current batch of pages isn't in the same datablock.
> > - decompressor error.
> > Otherwise pages will be marked as uptodate. The unhandled pages will be
> > updated by readpage later.
> >
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > Reported-by: Matthew Wilcox <willy@infradead.org>
> > Reported-by: Phillip Lougher <phillip@squashfs.org.uk>
> > Reported-by: Xiongwei Song <Xiongwei.Song@windriver.com>
> > Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Reported-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> > v4->v5:
> > - Handle short file cases reported by Marek and Matthew.
> > - Fix checkpatch error reported by Andrew.
> >
> > v4: https://lore.kernel.org/lkml/20220601103922.1338320-4-hsinyi@chromi=
um.org/
> > v3: https://lore.kernel.org/lkml/20220523065909.883444-4-hsinyi@chromiu=
m.org/
> > v2: https://lore.kernel.org/lkml/20220517082650.2005840-4-hsinyi@chromi=
um.org/
> > v1: https://lore.kernel.org/lkml/20220516105100.1412740-3-hsinyi@chromi=
um.org/
> > ---
> >  fs/squashfs/file.c | 124 ++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 123 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> > index a8e495d8eb86..fbd096cd15f4 100644
> > --- a/fs/squashfs/file.c
> > +++ b/fs/squashfs/file.c
> > @@ -39,6 +39,7 @@
> >  #include "squashfs_fs_sb.h"
> >  #include "squashfs_fs_i.h"
> >  #include "squashfs.h"
> > +#include "page_actor.h"
> >
> >  /*
> >   * Locate cache slot in range [offset, index] for specified inode.  If
> > @@ -495,7 +496,128 @@ static int squashfs_read_folio(struct file *file,
> struct folio *folio)
> >       return 0;
> >  }
> >
> > +static void squashfs_readahead(struct readahead_control *ractl)
> > +{
> > +     struct inode *inode =3D ractl->mapping->host;
> > +     struct squashfs_sb_info *msblk =3D inode->i_sb->s_fs_info;
> > +     size_t mask =3D (1UL << msblk->block_log) - 1;
> > +     unsigned short shift =3D msblk->block_log - PAGE_SHIFT;
> > +     loff_t start =3D readahead_pos(ractl) & ~mask;
> > +     size_t len =3D readahead_length(ractl) + readahead_pos(ractl) -
> start;
> > +     struct squashfs_page_actor *actor;
> > +     unsigned int nr_pages =3D 0;
> > +     struct page **pages;
> > +     int i, file_end =3D i_size_read(inode) >> msblk->block_log;
> > +     unsigned int max_pages =3D 1UL << shift;
> > +
> > +     readahead_expand(ractl, start, (len | mask) + 1);
> > +
> > +     if (file_end =3D=3D 0)
> > +             return;
> > +
> > +     pages =3D kmalloc_array(max_pages, sizeof(void *), GFP_KERNEL);
> > +     if (!pages)
> > +             return;
> > +
> > +     actor =3D squashfs_page_actor_init_special(pages, max_pages, 0);
> > +     if (!actor)
> > +             goto out;
> > +
> > +     for (;;) {
> > +             pgoff_t index;
> > +             int res, bsize;
> > +             u64 block =3D 0;
> > +             unsigned int expected;
> > +
> > +             nr_pages =3D __readahead_batch(ractl, pages, max_pages);
> > +             if (!nr_pages)
> > +                     break;
> > +
> > +             if (readahead_pos(ractl) >=3D i_size_read(inode))
> > +                     goto skip_pages;
> > +
> > +             index =3D pages[0]->index >> shift;
> > +             if ((pages[nr_pages - 1]->index >> shift) !=3D index)
> > +                     goto skip_pages;
> > +
> > +             expected =3D index =3D=3D file_end ?
> > +                        (i_size_read(inode) & (msblk->block_size -
> 1)) :
> > +                         msblk->block_size;
> > +
> > +             bsize =3D read_blocklist(inode, index, &block);
> > +             if (bsize =3D=3D 0)
> > +                     goto skip_pages;
> > +
> > +             if (nr_pages < max_pages) {
> > +                     struct squashfs_cache_entry *buffer;
> > +                     unsigned int block_mask =3D max_pages - 1;
> > +                     int offset =3D pages[0]->index - (pages[0]-
> >index & ~block_mask);
> > +
> > +                     buffer =3D squashfs_get_datablock(inode->i_sb,
> block,
> > +
> bsize);
> > +                     if (buffer->error) {
> > +                             squashfs_cache_put(buffer);
> > +                             goto skip_pages;
> > +                     }
> > +
> > +                     expected -=3D offset * PAGE_SIZE;
> > +                     for (i =3D 0; i < nr_pages && expected > 0; i+
> +,
> > +                                             expected -=3D
> PAGE_SIZE, offset++) {
> > +                             int avail =3D min_t(int, expected,
> PAGE_SIZE);
> > +
> > +                             squashfs_fill_page(pages[i],
> buffer,
> > +                                             offset *
> PAGE_SIZE, avail);
> > +                             unlock_page(pages[i]);
> > +                     }
> > +
> > +                     squashfs_cache_put(buffer);
> > +                     continue;
> > +             }
> > +
> > +             res =3D squashfs_read_data(inode->i_sb, block, bsize,
> NULL,
> > +                                      actor);
> > +
> > +             if (res =3D=3D expected) {
> > +                     int bytes;
> > +
> > +                     /* Last page may have trailing bytes not
> filled */
> > +                     bytes =3D res % PAGE_SIZE;
> > +                     if (bytes) {
> > +                             void *pageaddr;
> > +
> > +                             pageaddr =3D
> kmap_atomic(pages[nr_pages - 1]);
> > +                             memset(pageaddr + bytes, 0,
> PAGE_SIZE - bytes);
> > +                             kunmap_atomic(pageaddr);
> > +                     }
>
> Hi Hsin-Yi,
>
> kmap_atomic() shouldn't be used in new code, unless there are special
> reasons that I am not able to spot here.
>
> Why not use kmap_local_page(), preferably via memzero_page?

Right, these can be replaced with kmap_local_page(pages[nr_pages - 1],
bytes, PAGE_SIZE - bytes);

Thanks for the suggestion.
>
> Thanks,
>
> Fabio
>
> > +
> > +                     for (i =3D 0; i < nr_pages; i++) {
> > +                             flush_dcache_page(pages[i]);
> > +                             SetPageUptodate(pages[i]);
> > +                     }
> > +             }
> > +
> > +             for (i =3D 0; i < nr_pages; i++) {
> > +                     unlock_page(pages[i]);
> > +                     put_page(pages[i]);
> > +             }
> > +     }
> > +
> > +     kfree(actor);
> > +     kfree(pages);
> > +     return;
> > +
> > +skip_pages:
> > +     for (i =3D 0; i < nr_pages; i++) {
> > +             unlock_page(pages[i]);
> > +             put_page(pages[i]);
> > +     }
> > +
> > +     kfree(actor);
> > +out:
> > +     kfree(pages);
> > +}
> >
> >  const struct address_space_operations squashfs_aops =3D {
> > -     .read_folio =3D squashfs_read_folio
> > +     .read_folio =3D squashfs_read_folio,
> > +     .readahead =3D squashfs_readahead
> >  };
> > --
> > 2.36.1.255.ge46751e96f-goog
> >
> >
> >
>
>
>
>
