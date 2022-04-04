Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC7B4F17C5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378362AbiDDPBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378348AbiDDPBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:01:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EBBCDEFB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649084347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UTGtn1rG1oHnPf4jWqsoBHgFGHb3FmEXtAlPLct00TQ=;
        b=R4aFSWoTn5iF1iXytUEKQtyHi0xcf4p7I3W1zLatQa4NWktC7Kh0rLN0lOID3tubZenvQa
        aSNFc9mQbEmZVZ3P6vfAXubXwmbIgc1wdSaOKteDuRffxwvKtI6zPRl4zOaf/Fd9LmqX3/
        3TCzCT6nbtXT8MByGpT0VGNGNXSNAmM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-154-TSa6o067PxWz42LA3ERiOg-1; Mon, 04 Apr 2022 10:59:06 -0400
X-MC-Unique: TSa6o067PxWz42LA3ERiOg-1
Received: by mail-wm1-f70.google.com with SMTP id r206-20020a1c44d7000000b0038e6a1b25f1so3232876wma.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 07:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UTGtn1rG1oHnPf4jWqsoBHgFGHb3FmEXtAlPLct00TQ=;
        b=F+qtBf4Fyf1qDnWCrfXhL1kEcHo40YQlwkHWBVFc+5+YhEGqbSB95krLZD2xRYP7IU
         +xDNK7sWZcdngJ51fcJu7ab/0ezySoBGPS28NKfn1gIK5Ng0v4j/APhJNhIBcsMZ6wdw
         lnqaBy6prF59KMU23oufyCIHbhF6E5tpAnde8tfFI+t7quSwVfSlFJHsARg0ldvnOVh3
         dzSMDBSzxnfIn5tZdw/MdNFPkWBNeMxnCWlRIUUx0nBvtekZ0jkjB21c3GfZGsRd2Ylf
         3KbEtU9FhQVsgJSv9gm0em6keQwYzj7ST1jDHmBdoIQ20LZsC2Kl5lPeACUuJPGt8AH7
         OY2Q==
X-Gm-Message-State: AOAM532GFBD11RlT0WmIZqMgVUhnAJx0rBgKhjdRcDIVrzV1qQcBRvK3
        iRZZ8KdHce8f3yaZ9SFsuFuiZPH8NhHuczsnSr9ggPR542h06ExLg4mb7wLtY8HbblsrknMqxGB
        R2AwtrOhq+GjcLgUKVjRkpzaBHoReJQY1GJ8tc6qu
X-Received: by 2002:a7b:cbc1:0:b0:38e:7c42:fe38 with SMTP id n1-20020a7bcbc1000000b0038e7c42fe38mr972392wmi.51.1649084345328;
        Mon, 04 Apr 2022 07:59:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuYUVoq7tbnpe6v2K8Vg+lD8MBTb279vFZsP129/zboUn+PR7U05cmYuZ6pqPwC3hRYGrFm8x2cCpEeiOz8+E=
X-Received: by 2002:a7b:cbc1:0:b0:38e:7c42:fe38 with SMTP id
 n1-20020a7bcbc1000000b0038e7c42fe38mr972374wmi.51.1649084345107; Mon, 04 Apr
 2022 07:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220331223857.902911-1-jakobkoschel@gmail.com>
In-Reply-To: <20220331223857.902911-1-jakobkoschel@gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 4 Apr 2022 16:58:53 +0200
Message-ID: <CAHc6FU4s952rPPsceefvZER8dPM9RVWyQrmneMyqaW_0oViFSA@mail.gmail.com>
Subject: Re: [PATCH 1/2] gfs2: remove usage of list iterator variable for list_for_each_entry_continue()
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakob,

On Fri, Apr 1, 2022 at 12:40 AM Jakob Koschel <jakobkoschel@gmail.com> wrote:
> In preparation to limiting the scope of a list iterator to the list
> traversal loop, use a dedicated pointer to iterate through the list [1].
>
> Since that variable should not be used past the loop iteration, a
> separate variable is used to 'remember the current location within the
> loop'.
>
> To either continue iterating from that position or start a new
> iteration (if the previous iteration was complete) list_prepare_entry()
> is used.

I can see how accessing an iterator variable past a for_each_entry
loop will cause problems when it ends up pointing at the list head.
Here, the iterator variables are not accessed outside the loops at
all, though. So this patch is ugly, and it doesn't even help.

> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>  fs/gfs2/lops.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> index 6ba51cbb94cf..74e6d05cee2c 100644
> --- a/fs/gfs2/lops.c
> +++ b/fs/gfs2/lops.c
> @@ -653,7 +653,7 @@ static void gfs2_before_commit(struct gfs2_sbd *sdp, unsigned int limit,
>                                 bool is_databuf)
>  {
>         struct gfs2_log_descriptor *ld;
> -       struct gfs2_bufdata *bd1 = NULL, *bd2;
> +       struct gfs2_bufdata *bd1 = NULL, *bd2, *tmp1, *tmp2;
>         struct page *page;
>         unsigned int num;
>         unsigned n;
> @@ -661,7 +661,7 @@ static void gfs2_before_commit(struct gfs2_sbd *sdp, unsigned int limit,
>
>         gfs2_log_lock(sdp);
>         list_sort(NULL, blist, blocknr_cmp);
> -       bd1 = bd2 = list_prepare_entry(bd1, blist, bd_list);
> +       tmp1 = tmp2 = list_prepare_entry(bd1, blist, bd_list);

We should actually be using list_entry() here, not list_prepare_entry().

>         while(total) {
>                 num = total;
>                 if (total > limit)
> @@ -675,14 +675,18 @@ static void gfs2_before_commit(struct gfs2_sbd *sdp, unsigned int limit,
>                 ptr = (__be64 *)(ld + 1);
>
>                 n = 0;
> +               bd1 = list_prepare_entry(tmp1, blist, bd_list);
> +               tmp1 = NULL;
>                 list_for_each_entry_continue(bd1, blist, bd_list) {
>                         *ptr++ = cpu_to_be64(bd1->bd_bh->b_blocknr);
>                         if (is_databuf) {
>                                 gfs2_check_magic(bd1->bd_bh);
>                                 *ptr++ = cpu_to_be64(buffer_escaped(bd1->bd_bh) ? 1 : 0);
>                         }
> -                       if (++n >= num)
> +                       if (++n >= num) {
> +                               tmp1 = bd1;
>                                 break;
> +                       }
>                 }
>
>                 gfs2_log_unlock(sdp);
> @@ -690,6 +694,8 @@ static void gfs2_before_commit(struct gfs2_sbd *sdp, unsigned int limit,
>                 gfs2_log_lock(sdp);
>
>                 n = 0;
> +               bd2 = list_prepare_entry(tmp2, blist, bd_list);
> +               tmp2 = NULL;
>                 list_for_each_entry_continue(bd2, blist, bd_list) {
>                         get_bh(bd2->bd_bh);
>                         gfs2_log_unlock(sdp);
> @@ -712,8 +718,10 @@ static void gfs2_before_commit(struct gfs2_sbd *sdp, unsigned int limit,
>                                 gfs2_log_write_bh(sdp, bd2->bd_bh);
>                         }
>                         gfs2_log_lock(sdp);
> -                       if (++n >= num)
> +                       if (++n >= num) {
> +                               tmp2 = bd2;
>                                 break;
> +                       }
>                 }
>
>                 BUG_ON(total < num);
>
> base-commit: f82da161ea75dc4db21b2499e4b1facd36dab275
> --
> 2.25.1
>

Thanks,
Andreas

