Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074B4570357
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiGKMvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiGKMvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:51:42 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104B02A24B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:51:42 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l23so8634559ejr.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JkioUlyXsWtostATJ3u0HnRvtF12CIZO0nbupsZilPE=;
        b=UwTjZqh5FPE3v+aEWCKeALzktrkdLFKO/hnpxSxbeMzboGZWVkPEp9yvyvMe+yELqx
         hSi2YcYBF4+JLuVarZptcBaoFqRt1JjuUSHnFY2vN+KVCkRs2GLnC36hAgdYlAQwpJos
         RWQX0hzozSDrPd0gmgUCkkv74VkRMT7ZXl6637NmAIy0T4/WuVQ0KK14odBLhdvxyIAf
         MA0exyizlmjdmPvaAjhqOh+EycJ8eZqMf51z/haO4CnCUKlInu++hx/68aVt/IKJ/WN+
         bcNY1YDosCPZylceFLu/6aOOCKUxjdF8yCQdfe3Q/otfz5IaKTf+Ti3g2vA73nxxBNeQ
         779A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JkioUlyXsWtostATJ3u0HnRvtF12CIZO0nbupsZilPE=;
        b=aE96qW6Jul3sDnX4IqX7Rfed/LFJtqFxsIUOCA3C8rw48vhd6aN6nu9DLjmZEhlWQB
         ms8YpkJvdHhvfhxr2o8Z3eYycPl2kfslUmZmijJi+H9TlaPmzb6C43ZmnVBCaeo5eYjT
         REjZ/HVQ36Hyef0B3KWqSEp2mwoJInuD+z+OEDylVVo6orJBoBe5gVzz8umJUb5UzN4x
         SzMeEYjevc0pimrQAj736yspylChA0PXMRjKRSvPM2OpdxEQi4VXnbJ60RRovJ0OYoJm
         rfJltfVkmiSsla1ZB/UIq1rw/tq5AaVxvRlr4a6eY3tgfbcwD3mKkWCFwdymeRYrYODe
         xaZg==
X-Gm-Message-State: AJIora9lSj9XU48bnC+ChmZ7n7bl3AJnKTrqrkCSCVYM/vtubPh7FzEV
        OhS8ZPZPBDek14qbbeHz+gufzhu88Fof4n2d1wxALw==
X-Google-Smtp-Source: AGRyM1tOtK7xAhQOCFytdJvSDS2LIAxhU6MnGCessw8gltyNFqrPs7d3fenAXsf0Iecioj+FkPNGYMZRi7TI/gdYzY0=
X-Received: by 2002:a17:906:d54f:b0:726:2c7c:c0f9 with SMTP id
 cr15-20020a170906d54f00b007262c7cc0f9mr18599577ejc.441.1657543900546; Mon, 11
 Jul 2022 05:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <ca9c5c8301d76d60de34640568b3db0d4401d050.1657298747.git.christophe.jaillet@wanadoo.fr>
 <b71ccfaf4a47dee8e1ad373604c861479d499b6b.1657298747.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <b71ccfaf4a47dee8e1ad373604c861479d499b6b.1657298747.git.christophe.jaillet@wanadoo.fr>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 11 Jul 2022 14:51:30 +0200
Message-ID: <CAMGffEngaZFX+B22shwOFDQN_MM==Uy+8NuHGAKfeyGwFd6N6w@mail.gmail.com>
Subject: Re: [PATCH 2/2] RDMA/rtrs-clt: Use bitmap_empty()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 8, 2022 at 6:47 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Use bitmap_empty() instead of hand-writing them.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
Thx!
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index 06c27a3d83f5..8441f0965b56 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -1433,12 +1433,10 @@ static int alloc_permits(struct rtrs_clt_sess *clt)
>
>  static void free_permits(struct rtrs_clt_sess *clt)
>  {
> -       if (clt->permits_map) {
> -               size_t sz = clt->queue_depth;
> -
> +       if (clt->permits_map)
>                 wait_event(clt->permits_wait,
> -                          find_first_bit(clt->permits_map, sz) >= sz);
> -       }
> +                          bitmap_empty(clt->permits_map, clt->queue_depth));
> +
>         bitmap_free(clt->permits_map);
>         clt->permits_map = NULL;
>         kfree(clt->permits);
> --
> 2.34.1
>
