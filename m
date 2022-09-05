Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9735AD48A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbiIEOKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237415AbiIEOKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:10:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A43F27DDF
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 07:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662387015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/aM9Hz/CxTU/5IZIiOb0wSytjLDU1CYz4f/uZlzEYfY=;
        b=WXhE9tE+lWskXL7dnxRIFOx82M1hrtyWC1zMSjoHGv+JpsLFoAduU4XWYEOByeCoMYIC7/
        7XBDNz8gfqUeOXwJPLKEcM3HTA63IHoRDKgCWlxianshklmZW4oqlVRJIhc2w4xvaOWG/v
        scfBuFAyCrPa1mN5TgQrb6ClPeB9J3U=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-3-spKonLifNr6Ql3-DIQhixw-1; Mon, 05 Sep 2022 10:10:14 -0400
X-MC-Unique: spKonLifNr6Ql3-DIQhixw-1
Received: by mail-pl1-f200.google.com with SMTP id q8-20020a170902dac800b001753aa66955so6092412plx.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 07:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/aM9Hz/CxTU/5IZIiOb0wSytjLDU1CYz4f/uZlzEYfY=;
        b=LN0P6jNVC3zER4/Jbyz94GaBDyM8mgOFuqWb4pqmEdEps2rDARzmgtS8WnTx4za5br
         HVUWjTHfplxmz90s+GCT9Zg+uKyS3L4PTvAWrlteOTrIXfBM3CVzabFN3QgdPCufNuo1
         USDx9uwgLjFRKDN/0z9FAglAmehBKNCSHSRcdT5DDLmljI0fMGxRZL6opLxYjiMS08wC
         c98UmIrbyHhK62KS3FpY3nqMKT6cITrsgS5BlRVaaeefdiyFKbK82BQdkSWMofwNWlJ0
         ugZCSO0GAhv1DC90i/f+ZQ0hhV//bzFJNAQU5uwXWZ6baI4jsualUMrjC/qUAD7JwDCF
         FMpg==
X-Gm-Message-State: ACgBeo3vdF+IctP5oLWPj3cIHh9sKatUQnhxQtgIYJC0twMho+PAoZAo
        hZQtKa+kcVt5YTRBXyPIhSbno07SRnzBTkLqXyjOlTQzj9a0GqYk/EfX4krPT0K9Hvw4OsJCrp+
        eTE6MKDvP4uyN394ukgf3uIJ3gnGOaUIzOvVSWLRz
X-Received: by 2002:a65:6e49:0:b0:429:cae6:aac6 with SMTP id be9-20020a656e49000000b00429cae6aac6mr41418489pgb.268.1662387013101;
        Mon, 05 Sep 2022 07:10:13 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6Mbj0cnXfyvltZuZyI75OnAiCy5kv581MclsxMj6AKJtQBQIL0bE5MAfuVXEL2TcdEimwBiyT3tt6LHh8ASBA=
X-Received: by 2002:a65:6e49:0:b0:429:cae6:aac6 with SMTP id
 be9-20020a656e49000000b00429cae6aac6mr41418453pgb.268.1662387012811; Mon, 05
 Sep 2022 07:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220901133505.2510834-1-yi.zhang@huawei.com> <20220901133505.2510834-5-yi.zhang@huawei.com>
In-Reply-To: <20220901133505.2510834-5-yi.zhang@huawei.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 5 Sep 2022 16:10:01 +0200
Message-ID: <CAHc6FU4XqSxUr3CS8zxu=Fh_kHytJbzezim0ie_cxdioW5R=FA@mail.gmail.com>
Subject: Re: [PATCH v2 04/14] gfs2: replace ll_rw_block()
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, cluster-devel@redhat.com,
        ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com,
        reiserfs-devel@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        akpm@linux-foundation.org, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, rpeterso@redhat.com,
        almaz.alexandrovich@paragon-software.com, mark@fasheh.com,
        dushistov@mail.ru, hch@infradead.org, chengzhihao1@huawei.com,
        yukuai3@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 1, 2022 at 3:24 PM Zhang Yi <yi.zhang@huawei.com> wrote:
> ll_rw_block() is not safe for the sync read path because it cannot
> guarantee that always submitting read IO if the buffer has been locked,
> so stop using it. We also switch to new bh_readahead() helper for the
> readahead path.
>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/gfs2/meta_io.c | 7 ++-----
>  fs/gfs2/quota.c   | 8 ++------
>  2 files changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
> index 7e70e0ba5a6c..6ed728aae9a5 100644
> --- a/fs/gfs2/meta_io.c
> +++ b/fs/gfs2/meta_io.c
> @@ -525,8 +525,7 @@ struct buffer_head *gfs2_meta_ra(struct gfs2_glock *gl, u64 dblock, u32 extlen)
>
>         if (buffer_uptodate(first_bh))
>                 goto out;
> -       if (!buffer_locked(first_bh))
> -               ll_rw_block(REQ_OP_READ | REQ_META | REQ_PRIO, 1, &first_bh);
> +       bh_read_nowait(first_bh, REQ_META | REQ_PRIO);
>
>         dblock++;
>         extlen--;
> @@ -534,9 +533,7 @@ struct buffer_head *gfs2_meta_ra(struct gfs2_glock *gl, u64 dblock, u32 extlen)
>         while (extlen) {
>                 bh = gfs2_getbuf(gl, dblock, CREATE);
>
> -               if (!buffer_uptodate(bh) && !buffer_locked(bh))
> -                       ll_rw_block(REQ_OP_READ | REQ_RAHEAD | REQ_META |
> -                                   REQ_PRIO, 1, &bh);
> +               bh_readahead(bh, REQ_RAHEAD | REQ_META | REQ_PRIO);
>                 brelse(bh);
>                 dblock++;
>                 extlen--;
> diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> index f201eaf59d0d..1ed17226d9ed 100644
> --- a/fs/gfs2/quota.c
> +++ b/fs/gfs2/quota.c
> @@ -745,12 +745,8 @@ static int gfs2_write_buf_to_page(struct gfs2_inode *ip, unsigned long index,
>                 }
>                 if (PageUptodate(page))
>                         set_buffer_uptodate(bh);
> -               if (!buffer_uptodate(bh)) {
> -                       ll_rw_block(REQ_OP_READ | REQ_META | REQ_PRIO, 1, &bh);
> -                       wait_on_buffer(bh);
> -                       if (!buffer_uptodate(bh))
> -                               goto unlock_out;
> -               }
> +               if (bh_read(bh, REQ_META | REQ_PRIO) < 0)
> +                       goto unlock_out;
>                 if (gfs2_is_jdata(ip))
>                         gfs2_trans_add_data(ip->i_gl, bh);
>                 else
> --
> 2.31.1
>

Thanks for this fix; looking good.

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

Andreas

