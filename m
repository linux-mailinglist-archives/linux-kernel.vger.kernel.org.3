Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEAC56FF95
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 12:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiGKK5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 06:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiGKK45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 06:56:57 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96DEFFE01
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:02:04 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id mf4so6764355ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wGvgUoEpgRoFdw5xB3ByPDZ/Z4C3Oec3OA9m4e/7zr0=;
        b=RSgSJPGfw4G/qutpiBewn0jq3S+XphrS/nSQldk+zB5jc6SNG8BxH9gtyCt31mxMv2
         oFN/E92Iu6kUuYasX4qE1vwxnsrS6rsW9XS9HaKp2j5hSWLKACY+5Y0RnDzYL1vDfZUr
         Y4zo4jJ1CbgQdJCqjgjTo6/1lYCsgeB+9xLhRAL4bWzEBn5tENPcU8udqd3DNZxIJwYP
         MK3PTfEigpvND3GsN13ZGfI4lDjQxQEWHY72T7bXff0JD+5fP+ua4D2MEcPRKBP/HYmX
         m7RAaehwlsir7ffzRR4pswlInHpW6hvYC3ZKdGfzSrXN4ZRu9KmRl4fMxi6g1trSpdNT
         GqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wGvgUoEpgRoFdw5xB3ByPDZ/Z4C3Oec3OA9m4e/7zr0=;
        b=IYrBG6iWzBHlAVu29qIKbVAhshRTKsOclVMrBFQqnVBNNPYpSUoGHfN1Ti29xK4Mn7
         5gmmjwE81q/4XL/VMVpCteyqrvtO8N9NQzmSQJ3TjUaaCDX3xGBlqB1SYE4sDy8mfbc1
         DjKdf4HWjUHZowlGrgPB4iiGyGWKf+Ztt+TCt3VBvQXlkuio9pKl3GBKzQhPc5/qpn0f
         gB7fzu+H6qS9yoPN86Jrrezeuj+ou2L2g+kZ3bjxC2yXnDQD/dfpD9ZbAVKeCvCdbgJt
         cchAtO55Zp7Z8rU5m6FzKmftOTHdfRkwqnh34SWJkWP4M3CyP6yMen6udr6iOQ9+MnMk
         XOlw==
X-Gm-Message-State: AJIora8E079hB/Gr89MQ8/yAdJcCSXjkwMb8g6EYG1muKbkphwFEHWXp
        0yexZNGZTiUIw/7ubV/MUds2mJk592Srt5TZRt5kDg==
X-Google-Smtp-Source: AGRyM1vafSCHUmSjW+hMdfrXxS7hOwpJ9tY3psQHMQaljV4Evx72JF9q90YXl+Rpw/+ZgPbrzliXxhhDryKeNeHi9yQ=
X-Received: by 2002:a17:906:8462:b0:72b:4e05:a8c1 with SMTP id
 hx2-20020a170906846200b0072b4e05a8c1mr6181720ejc.443.1657533723516; Mon, 11
 Jul 2022 03:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <ca9c5c8301d76d60de34640568b3db0d4401d050.1657298747.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <ca9c5c8301d76d60de34640568b3db0d4401d050.1657298747.git.christophe.jaillet@wanadoo.fr>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 11 Jul 2022 12:01:53 +0200
Message-ID: <CAMGffEk46vD2d-GCR5VPYiAQi3268sz9PiH6Zvuru8zUW03eXQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] RDMA/rtrs-clt: Use the bitmap API to allocate bitmaps
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
> Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.
>
> It is less verbose and it improves the semantic.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
Thx!
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index 9809c3883979..06c27a3d83f5 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -1403,8 +1403,7 @@ static int alloc_permits(struct rtrs_clt_sess *clt)
>         unsigned int chunk_bits;
>         int err, i;
>
> -       clt->permits_map = kcalloc(BITS_TO_LONGS(clt->queue_depth),
> -                                  sizeof(long), GFP_KERNEL);
> +       clt->permits_map = bitmap_zalloc(clt->queue_depth, GFP_KERNEL);
>         if (!clt->permits_map) {
>                 err = -ENOMEM;
>                 goto out_err;
> @@ -1426,7 +1425,7 @@ static int alloc_permits(struct rtrs_clt_sess *clt)
>         return 0;
>
>  err_map:
> -       kfree(clt->permits_map);
> +       bitmap_free(clt->permits_map);
>         clt->permits_map = NULL;
>  out_err:
>         return err;
> @@ -1440,7 +1439,7 @@ static void free_permits(struct rtrs_clt_sess *clt)
>                 wait_event(clt->permits_wait,
>                            find_first_bit(clt->permits_map, sz) >= sz);
>         }
> -       kfree(clt->permits_map);
> +       bitmap_free(clt->permits_map);
>         clt->permits_map = NULL;
>         kfree(clt->permits);
>         clt->permits = NULL;
> --
> 2.34.1
>
