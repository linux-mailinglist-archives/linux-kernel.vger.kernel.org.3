Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CA74E7987
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 17:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377064AbiCYQ6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 12:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377376AbiCYQ6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:58:05 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17343ED2E;
        Fri, 25 Mar 2022 09:56:25 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id m84so4542584vke.1;
        Fri, 25 Mar 2022 09:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7fjXSK3Yvyz7mSD5V7xuckH+eT1koYaMuBSGDuDa7Jg=;
        b=j9Vj4vJzsRg1iLTzat+VUMVIwbpF2OjBrUJLXaU2urPVF2IpHN9mumemI7oSEUSpSS
         7b27OFfmiVkavRZQ7+T4Q1zse7cIQKk/dYGGNTo9SrMz8fOCyq/JmKX4GTMerWB35KFf
         DZtxQyYrMlfsaNO9YV0o6tPtGigmFt539hcKgmhOx7qZfRX8G0Uu6FjXT5YOTvuxqP5o
         DewQyiRA1EqU2ewDRLp8mSVZVSb4aNU1u+nYCJf+LVzB66KI/LZ7SsPokBlKnSCQ6CNq
         6e0RMzOE+5KTnscXPIv+79D+tlmCuujJIzGWg6Vg6wkXVrnApZgHQ76uQkOexFE+Z6Fl
         0tsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7fjXSK3Yvyz7mSD5V7xuckH+eT1koYaMuBSGDuDa7Jg=;
        b=Ih3gVSI4oQXNJrCSBkhFD6/O7zlvJrBSh8q3DerRuDBAG2BRJMF0gRTlW0Fg50jLVp
         4Tz6TgeXrSuMmXPcrInF+DcyhOH9oBc5IS5ngdq6xOyKIoAqEcSIwL2cRrepFL0sqP/Q
         g/Q7yNIpDUDJZwQmbClAVa1wo2rCtb1VSJVDAf8+aXPElSJM8TXoLRmi1U82Mw3LeG7Z
         jtwrz9EVP1fSGSOi02k5/W+SHMfktdyEdD8mO26MOBdphNZKIxPX9/ebLw3MfvgxAgV9
         fOZieGsRUBuEq0bE3q+NBFJkLihekUcYRu4ZzJ7ZXhuEJD+hiTR9k3gvzZIhcne77jUz
         L6ug==
X-Gm-Message-State: AOAM531f8TepZ9hCYT+oMeMJKqo6ESht3JM5brtewmTPWo6fzklEjPxv
        fkEPyAxnWFFl96RtEjq2BrZxOHsGXC8uO8z1d30=
X-Google-Smtp-Source: ABdhPJz/8XFnjnwx1Noi+N4DU0S2Tn47QZWN0T95fxmHkeNqxDKorClg2d7HT1mn/rlebzglvDLzHWV0j0okgNNJiW4=
X-Received: by 2002:a05:6122:8c8:b0:32a:7010:c581 with SMTP id
 8-20020a05612208c800b0032a7010c581mr5548291vkg.32.1648227384124; Fri, 25 Mar
 2022 09:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220324072050.62242-1-jakobkoschel@gmail.com>
In-Reply-To: <20220324072050.62242-1-jakobkoschel@gmail.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Fri, 25 Mar 2022 17:56:58 +0100
Message-ID: <CAOi1vP-kHch7eF--yuH=y+V2DyY0v09qTA826=Tqr_YnQDfMBQ@mail.gmail.com>
Subject: Re: [PATCH] rbd: replace usage of found with dedicated list iterator variable
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Jens Axboe <axboe@kernel.dk>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 8:21 AM Jakob Koschel <jakobkoschel@gmail.com> wrote:
>
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
>
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable instead of a
> found boolean [1].
>
> This removes the need to use a found variable and simply checking if
> the variable was set, can determine if the break/goto was hit.
>
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>  drivers/block/rbd.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index b844432bad20..e5f891d058e8 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -756,24 +756,23 @@ static struct rbd_client *__rbd_get_client(struct rbd_client *rbdc)
>   */
>  static struct rbd_client *rbd_client_find(struct ceph_options *ceph_opts)
>  {
> -       struct rbd_client *client_node;
> -       bool found = false;
> +       struct rbd_client *client_node = NULL, *iter;
>
>         if (ceph_opts->flags & CEPH_OPT_NOSHARE)
>                 return NULL;
>
>         spin_lock(&rbd_client_list_lock);
> -       list_for_each_entry(client_node, &rbd_client_list, node) {
> -               if (!ceph_compare_options(ceph_opts, client_node->client)) {
> -                       __rbd_get_client(client_node);
> +       list_for_each_entry(iter, &rbd_client_list, node) {
> +               if (!ceph_compare_options(ceph_opts, iter->client)) {
> +                       __rbd_get_client(iter);
>
> -                       found = true;
> +                       client_node = iter;
>                         break;
>                 }
>         }
>         spin_unlock(&rbd_client_list_lock);
>
> -       return found ? client_node : NULL;
> +       return client_node;
>  }
>
>  /*
>
> base-commit: f443e374ae131c168a065ea1748feac6b2e76613
> --
> 2.25.1
>

Applied.

Thanks,

                Ilya
