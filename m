Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712AF4663CD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357873AbhLBMlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:41:39 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:54626 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346987AbhLBMld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:41:33 -0500
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 899A4E79;
        Thu,  2 Dec 2021 13:38:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1638448688;
        bh=8laB6ZrK7mL8S9it7gK0pnuQ1r9qGWjJGPYXw7Sj4rA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=cAhCaHoff0avaL228wDsPFu7O4+5ZfUhG+UrehEQnVUVC/AchTUQu8EilSaKCUeRz
         qWWz8EhsAJZpPCZa5tS2P/g0hq1sFyopHT4J5UvLXWpDDZED2DeuY5dm5dlHbGokIs
         +WKS52JJd5gjYvgKw6wDj438ZEhtjedCpPUgcTK8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b11f646dda189f490c06bf671f64a2cc0af4d45c.1638397089.git.christophe.jaillet@wanadoo.fr>
References: <b11f646dda189f490c06bf671f64a2cc0af4d45c.1638397089.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] media: mc: mc-entity.c: Use bitmap_zalloc() when applicable
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
        sakari.ailus@linux.intel.com
Date:   Thu, 02 Dec 2021 12:38:05 +0000
Message-ID: <163844868581.3059017.16653620248778368715@Monstersaurus>
User-Agent: alot/0.10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christophe JAILLET (2021-12-01 22:19:40)
> 'ent_enum->bmap' is a bitmap. So use 'bitmap_zalloc()' to simplify
> code, improve the semantic and avoid some open-coded arithmetic in
> allocator arguments.
>=20
> Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
> consistency.
>=20
> While at it, remove a useless 'bitmap_zero()'.

Ah, yes kcalloc zeros memory, so it is doing a redundant clear as well.
Changing to bitmap_zalloc looks a lot better though.

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/media/mc/mc-entity.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/media/mc/mc-entity.c b/drivers/media/mc/mc-entity.c
> index c02340698ad6..b411f9796191 100644
> --- a/drivers/media/mc/mc-entity.c
> +++ b/drivers/media/mc/mc-entity.c
> @@ -48,12 +48,10 @@ __must_check int __media_entity_enum_init(struct medi=
a_entity_enum *ent_enum,
>                                           int idx_max)
>  {
>         idx_max =3D ALIGN(idx_max, BITS_PER_LONG);
> -       ent_enum->bmap =3D kcalloc(idx_max / BITS_PER_LONG, sizeof(long),
> -                                GFP_KERNEL);
> +       ent_enum->bmap =3D bitmap_zalloc(idx_max, GFP_KERNEL);
>         if (!ent_enum->bmap)
>                 return -ENOMEM;
> =20
> -       bitmap_zero(ent_enum->bmap, idx_max);
>         ent_enum->idx_max =3D idx_max;
> =20
>         return 0;
> @@ -62,7 +60,7 @@ EXPORT_SYMBOL_GPL(__media_entity_enum_init);
> =20
>  void media_entity_enum_cleanup(struct media_entity_enum *ent_enum)
>  {
> -       kfree(ent_enum->bmap);
> +       bitmap_free(ent_enum->bmap);
>  }
>  EXPORT_SYMBOL_GPL(media_entity_enum_cleanup);
> =20
> --=20
> 2.30.2
>
