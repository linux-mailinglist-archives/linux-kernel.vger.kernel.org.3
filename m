Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4085424BB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444043AbiFHBBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382604AbiFGWeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 18:34:02 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76EF27ED8C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:29:47 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id w27so24235797edl.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 12:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yKE5Bq8iXMNxt2427O+F+1WcMe8sa2DT1LXBnKJwWF8=;
        b=lxKuu50mDkU/0oF/yO+ecrSfjwsRG4gfExEALGlP5/qUx3+Yfpz4hHpOGnHteee7SD
         5+AUB224zpBCDlUaUm0OaGN/Uv6sunKvrue5zm3pIU2YE3IS39aBxUPAwFefOc5PzRKu
         FISZgStjNwkKhqF+gaeesMcMEd6t1hMqUatrU1qVw79NmKqCg/Ezq5z6zIWu4b7hgt4Y
         Fb9XJ88Lu1Y/8ff3PaDecuJhwM8Qhqc8KnkMUBsvkEDRgnzeLtjnVCNCiyiGxd7oz2eH
         gvbZbsZfALlHAiMtmJv8vlVPOs+mwMKrTB23F9yOpJGWviIy4hDhT9QIyg86FZIYsiRg
         nVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yKE5Bq8iXMNxt2427O+F+1WcMe8sa2DT1LXBnKJwWF8=;
        b=lqac9jcTIIE4/c3eduSrx6pnR7v9MoN3wxk85/hYDP7nq+ylPvitHZ/lBfKAfA7EpK
         E9tWX+HW3dmxwwaukt0s55Qx+IhcLl3EkSctqgCa2CTbhjNHbkJYSiukfqqAu9HrFkey
         TN1ezCz82BV/XM1nZ9EhWQC8y9/hcPzel+JpovwUc0w9JmWvXNIAvksQ7u0iql697yU5
         ER8p0Wg1ecPv3k3O0C6xQk7Tfs56Nke/c7ZA2Tvv+5FK8PYxT/8sL3K36mU2Q6L1OCro
         vUKkNlR/hkd48LzGwMXvxrt92hDk6zEA1Aoao06jzdlWlsgYGSjMWzM+2eMaJkGI+ElF
         WbYA==
X-Gm-Message-State: AOAM533OLN128jKG153a9XNxJmkWUXTLUTN966khVIFmzugHpFko+Ass
        2ZAoQc2lt69WnyKITs2yOCdnW/qBUAM=
X-Google-Smtp-Source: ABdhPJws3j93I3BviFDDiRdE3M0Pj5104FpDCCnzyTtvF/l+eB4pyagrYY8iMFFfN0yH9M3W8RQvBA==
X-Received: by 2002:a05:6402:518b:b0:42d:fe74:98f9 with SMTP id q11-20020a056402518b00b0042dfe7498f9mr35332222edd.371.1654630184913;
        Tue, 07 Jun 2022 12:29:44 -0700 (PDT)
Received: from opensuse.localnet (host-79-13-108-3.retail.telecomitalia.it. [79.13.108.3])
        by smtp.gmail.com with ESMTPSA id fg16-20020a1709069c5000b006fe8d8c54a7sm8051501ejc.87.2022.06.07.12.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 12:29:43 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongwei Song <Xiongwei.Song@windriver.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Zheng Liang <zhengliang6@huawei.com>,
        Zhang Yi <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        "squashfs-devel @ lists . sourceforge . net" 
        <squashfs-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, ira.weiny@intel.com
Subject: Re: [PATCH v5 3/3] squashfs: implement readahead
Date:   Tue, 07 Jun 2022 21:29:42 +0200
Message-ID: <1794711.atdPhlSkOF@opensuse>
In-Reply-To: <20220606150305.1883410-4-hsinyi@chromium.org>
References: <20220606150305.1883410-1-hsinyi@chromium.org> <20220606150305.1883410-4-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On luned=C3=AC 6 giugno 2022 17:03:05 CEST Hsin-Yi Wang wrote:
> Implement readahead callback for squashfs. It will read datablocks
> which cover pages in readahead request. For a few cases it will
> not mark page as uptodate, including:
> - file end is 0.
> - zero filled blocks.
> - current batch of pages isn't in the same datablock.
> - decompressor error.
> Otherwise pages will be marked as uptodate. The unhandled pages will be
> updated by readpage later.
>=20
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Reported-by: Phillip Lougher <phillip@squashfs.org.uk>
> Reported-by: Xiongwei Song <Xiongwei.Song@windriver.com>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reported-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> v4->v5:
> - Handle short file cases reported by Marek and Matthew.
> - Fix checkpatch error reported by Andrew.
>=20
> v4: https://lore.kernel.org/lkml/20220601103922.1338320-4-hsinyi@chromium=
=2Eorg/
> v3: https://lore.kernel.org/lkml/20220523065909.883444-4-hsinyi@chromium.=
org/
> v2: https://lore.kernel.org/lkml/20220517082650.2005840-4-hsinyi@chromium=
=2Eorg/
> v1: https://lore.kernel.org/lkml/20220516105100.1412740-3-hsinyi@chromium=
=2Eorg/
> ---
>  fs/squashfs/file.c | 124 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 123 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> index a8e495d8eb86..fbd096cd15f4 100644
> --- a/fs/squashfs/file.c
> +++ b/fs/squashfs/file.c
> @@ -39,6 +39,7 @@
>  #include "squashfs_fs_sb.h"
>  #include "squashfs_fs_i.h"
>  #include "squashfs.h"
> +#include "page_actor.h"
> =20
>  /*
>   * Locate cache slot in range [offset, index] for specified inode.  If
> @@ -495,7 +496,128 @@ static int squashfs_read_folio(struct file *file,=20
struct folio *folio)
>  	return 0;
>  }
> =20
> +static void squashfs_readahead(struct readahead_control *ractl)
> +{
> +	struct inode *inode =3D ractl->mapping->host;
> +	struct squashfs_sb_info *msblk =3D inode->i_sb->s_fs_info;
> +	size_t mask =3D (1UL << msblk->block_log) - 1;
> +	unsigned short shift =3D msblk->block_log - PAGE_SHIFT;
> +	loff_t start =3D readahead_pos(ractl) & ~mask;
> +	size_t len =3D readahead_length(ractl) + readahead_pos(ractl) -=20
start;
> +	struct squashfs_page_actor *actor;
> +	unsigned int nr_pages =3D 0;
> +	struct page **pages;
> +	int i, file_end =3D i_size_read(inode) >> msblk->block_log;
> +	unsigned int max_pages =3D 1UL << shift;
> +
> +	readahead_expand(ractl, start, (len | mask) + 1);
> +
> +	if (file_end =3D=3D 0)
> +		return;
> +
> +	pages =3D kmalloc_array(max_pages, sizeof(void *), GFP_KERNEL);
> +	if (!pages)
> +		return;
> +
> +	actor =3D squashfs_page_actor_init_special(pages, max_pages, 0);
> +	if (!actor)
> +		goto out;
> +
> +	for (;;) {
> +		pgoff_t index;
> +		int res, bsize;
> +		u64 block =3D 0;
> +		unsigned int expected;
> +
> +		nr_pages =3D __readahead_batch(ractl, pages, max_pages);
> +		if (!nr_pages)
> +			break;
> +
> +		if (readahead_pos(ractl) >=3D i_size_read(inode))
> +			goto skip_pages;
> +
> +		index =3D pages[0]->index >> shift;
> +		if ((pages[nr_pages - 1]->index >> shift) !=3D index)
> +			goto skip_pages;
> +
> +		expected =3D index =3D=3D file_end ?
> +			   (i_size_read(inode) & (msblk->block_size -=20
1)) :
> +			    msblk->block_size;
> +
> +		bsize =3D read_blocklist(inode, index, &block);
> +		if (bsize =3D=3D 0)
> +			goto skip_pages;
> +
> +		if (nr_pages < max_pages) {
> +			struct squashfs_cache_entry *buffer;
> +			unsigned int block_mask =3D max_pages - 1;
> +			int offset =3D pages[0]->index - (pages[0]-
>index & ~block_mask);
> +
> +			buffer =3D squashfs_get_datablock(inode->i_sb,=20
block,
> +						=09
bsize);
> +			if (buffer->error) {
> +				squashfs_cache_put(buffer);
> +				goto skip_pages;
> +			}
> +
> +			expected -=3D offset * PAGE_SIZE;
> +			for (i =3D 0; i < nr_pages && expected > 0; i+
+,
> +						expected -=3D=20
PAGE_SIZE, offset++) {
> +				int avail =3D min_t(int, expected,=20
PAGE_SIZE);
> +
> +				squashfs_fill_page(pages[i],=20
buffer,
> +						offset *=20
PAGE_SIZE, avail);
> +				unlock_page(pages[i]);
> +			}
> +
> +			squashfs_cache_put(buffer);
> +			continue;
> +		}
> +
> +		res =3D squashfs_read_data(inode->i_sb, block, bsize,=20
NULL,
> +					 actor);
> +
> +		if (res =3D=3D expected) {
> +			int bytes;
> +
> +			/* Last page may have trailing bytes not=20
filled */
> +			bytes =3D res % PAGE_SIZE;
> +			if (bytes) {
> +				void *pageaddr;
> +
> +				pageaddr =3D=20
kmap_atomic(pages[nr_pages - 1]);
> +				memset(pageaddr + bytes, 0,=20
PAGE_SIZE - bytes);
> +				kunmap_atomic(pageaddr);
> +			}

Hi Hsin-Yi,

kmap_atomic() shouldn't be used in new code, unless there are special=20
reasons that I am not able to spot here.

Why not use kmap_local_page(), preferably via memzero_page?

Thanks,

=46abio

> +
> +			for (i =3D 0; i < nr_pages; i++) {
> +				flush_dcache_page(pages[i]);
> +				SetPageUptodate(pages[i]);
> +			}
> +		}
> +
> +		for (i =3D 0; i < nr_pages; i++) {
> +			unlock_page(pages[i]);
> +			put_page(pages[i]);
> +		}
> +	}
> +
> +	kfree(actor);
> +	kfree(pages);
> +	return;
> +
> +skip_pages:
> +	for (i =3D 0; i < nr_pages; i++) {
> +		unlock_page(pages[i]);
> +		put_page(pages[i]);
> +	}
> +
> +	kfree(actor);
> +out:
> +	kfree(pages);
> +}
> =20
>  const struct address_space_operations squashfs_aops =3D {
> -	.read_folio =3D squashfs_read_folio
> +	.read_folio =3D squashfs_read_folio,
> +	.readahead =3D squashfs_readahead
>  };
> --=20
> 2.36.1.255.ge46751e96f-goog
>=20
>=20
>=20




