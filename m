Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C977254F2F4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380966AbiFQI3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380904AbiFQI3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:29:31 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A245689B0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:29:30 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id h23so7356413ejj.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YTuPF5XEzCGBKJ3Isq0bPgMxP/V4UajwZO7gE1YaLpc=;
        b=GoVqNBv9H1LhebEz9+6aVsx7lIOjd3cHR731EwA8XaVvr93MxC43SgEG94XHPsqYZu
         yrt5xKukgyY+f6q7bax0dMt47Xl7UNOg7LdT0xNbQgOHMkuWSRl2JD1ozEEHqhPw5x5+
         VJoYEm5E8LY5elO0ptF4jqhBW/OoltUrJFCMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YTuPF5XEzCGBKJ3Isq0bPgMxP/V4UajwZO7gE1YaLpc=;
        b=ZFD/CF5smTmI8vgHZVK1mXBFvuA5m9d/dqfu7zJFujHaqWXLU1whBv7R+8DKX4n0Xc
         ryM7K53DyH/DYppXu/jc6E2S5bxniMMwbAS6CY8xMzu2CgMMll7T+dOhd5sH453E/WjI
         lied68TZujgA+FtEFRyz7xVqY7BSbHivDAl1plY+2lN1qElj1SUaOHpfS8ANp7LN0qY5
         6kZUCF4wp2fXgoyQls5KDX0rW4WXbqsTZuL4LLzt6oScIbNKk++LV7kHWRyYTutdOl/A
         l3Azd2TZF9ntxOWvmEeZGDcp8clkcHzIhl93WqxsI4QgTK5p3+mYrxD5ePmEhVBQJOQJ
         jN9w==
X-Gm-Message-State: AJIora+oJC1tfX2rAK47x5iNAh2DoS2ylMwvb6Z03oLsAQpP/mZpC+JA
        NDmQrh3XxYwDh9zfMNTH7mWgqI3QhMBB6WRKnwpXTA==
X-Google-Smtp-Source: AGRyM1u73FI2QNVjoIx4iM/dQYqInoO0y/XWGhHUClbTPLVyZ8NsiD1XihY2D04rCpC+iyM7Ceg+BgHIdFfDbdiIixo=
X-Received: by 2002:a17:907:868f:b0:702:f865:55de with SMTP id
 qa15-20020a170907868f00b00702f86555demr8340167ejc.24.1655454569043; Fri, 17
 Jun 2022 01:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220613082802.1301238-4-hsinyi@chromium.org> <20220617030345.24712-1-phillip@squashfs.org.uk>
In-Reply-To: <20220617030345.24712-1-phillip@squashfs.org.uk>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 17 Jun 2022 16:29:03 +0800
Message-ID: <CAJMQK-hw-qURVaf-bSbtoS3OM_wV+gVr_zeVc-L+GV47yLg6Bw@mail.gmail.com>
Subject: Re: [PATCH 4/3] squashfs: support reading fragments in readahead call
To:     Phillip Lougher <phillip@squashfs.org.uk>
Cc:     Xiongwei.Song@windriver.com, akpm@linux-foundation.org,
        houtao1@huawei.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, m.szyprowski@samsung.com, miaoxie@huawei.com,
        squashfs-devel@lists.sourceforge.net, willy@infradead.org,
        yi.zhang@huawei.com, zhengliang6@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 11:04 AM Phillip Lougher
<phillip@squashfs.org.uk> wrote:
>
> This patch adds a function which can be used to read fragments in the
> readahead call.
>
> This function is necessary because filesystems built with the -tailends
> (or -always-use-fragments) option may have fragments present which
> cannot be currently handled.
>
> Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
> ---
>  fs/squashfs/file.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> index f0c64ee272d5..3a4cce16d7da 100644
> --- a/fs/squashfs/file.c
> +++ b/fs/squashfs/file.c
> @@ -497,6 +497,41 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
>         return res;
>  }
>
> +static unsigned int squashfs_readahead_fragment(struct page **page,
hi Phillip,

Since the buffer->error is int, and also the variable to receive the
value is res, I modified it when sending it with the series, though it
won't affect the result.

> +       unsigned int pages, unsigned int expected)
> +{
> +       struct inode *inode = page[0]->mapping->host;
> +       struct squashfs_cache_entry *buffer = squashfs_get_fragment(inode->i_sb,
> +               squashfs_i(inode)->fragment_block,
> +               squashfs_i(inode)->fragment_size);
> +       struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
> +       unsigned int n, mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
> +
> +       if (buffer->error)
> +               goto out;
> +
> +       expected += squashfs_i(inode)->fragment_offset;
> +
> +       for (n = 0; n < pages; n++) {
> +               unsigned int base = (page[n]->index & mask) << PAGE_SHIFT;
> +               unsigned int offset = base + squashfs_i(inode)->fragment_offset;
> +
> +               if (expected > offset) {
> +                       unsigned int avail = min_t(unsigned int, expected -
> +                               offset, PAGE_SIZE);
> +
> +                       squashfs_fill_page(page[n], buffer, offset, avail);
> +               }
> +
> +               unlock_page(page[n]);
> +               put_page(page[n]);
> +       }
> +
> +out:
> +       squashfs_cache_put(buffer);
> +       return buffer->error;
> +}
> +
>  static void squashfs_readahead(struct readahead_control *ractl)
>  {
>         struct inode *inode = ractl->mapping->host;
> --
> 2.34.1
>
