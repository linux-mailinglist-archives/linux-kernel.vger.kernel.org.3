Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869FE46704E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 03:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378298AbhLCCzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 21:55:42 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:43600 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243536AbhLCCzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 21:55:36 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3CCD0A59;
        Fri,  3 Dec 2021 03:52:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1638499931;
        bh=SnLYL+0P6D8oVgyVFOJ1csGxGyPoyV1B0+a7dbROoU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aovp1RYOso//aS2JCm4doWvuV7yCnSgfRfPj0XMp0VCcWoQUnGvunRC9foIIti6WZ
         MFNg8E8DMelbhR/ll1UR3gEpfS3L0+Akyri3sy++veWG9wN0j3gqVYBC8xekLv91G+
         rIh8EXOF6vUuSB26/ALJ5Ix+NrVHfxlHb8nv6yU8=
Date:   Fri, 3 Dec 2021 04:51:45 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     sakari.ailus@linux.intel.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] media: mc: mc-entity.c: Use bitmap_zalloc() when
 applicable
Message-ID: <YamGQbD+abET4rmx@pendragon.ideasonboard.com>
References: <b11f646dda189f490c06bf671f64a2cc0af4d45c.1638397089.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b11f646dda189f490c06bf671f64a2cc0af4d45c.1638397089.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Thank you for the patch.

On Wed, Dec 01, 2021 at 11:19:40PM +0100, Christophe JAILLET wrote:
> 'ent_enum->bmap' is a bitmap. So use 'bitmap_zalloc()' to simplify
> code, improve the semantic and avoid some open-coded arithmetic in
> allocator arguments.
> 
> Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
> consistency.
> 
> While at it, remove a useless 'bitmap_zero()'.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/mc/mc-entity.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/mc/mc-entity.c b/drivers/media/mc/mc-entity.c
> index c02340698ad6..b411f9796191 100644
> --- a/drivers/media/mc/mc-entity.c
> +++ b/drivers/media/mc/mc-entity.c
> @@ -48,12 +48,10 @@ __must_check int __media_entity_enum_init(struct media_entity_enum *ent_enum,
>  					  int idx_max)
>  {
>  	idx_max = ALIGN(idx_max, BITS_PER_LONG);
> -	ent_enum->bmap = kcalloc(idx_max / BITS_PER_LONG, sizeof(long),
> -				 GFP_KERNEL);
> +	ent_enum->bmap = bitmap_zalloc(idx_max, GFP_KERNEL);
>  	if (!ent_enum->bmap)
>  		return -ENOMEM;
>  
> -	bitmap_zero(ent_enum->bmap, idx_max);
>  	ent_enum->idx_max = idx_max;
>  
>  	return 0;
> @@ -62,7 +60,7 @@ EXPORT_SYMBOL_GPL(__media_entity_enum_init);
>  
>  void media_entity_enum_cleanup(struct media_entity_enum *ent_enum)
>  {
> -	kfree(ent_enum->bmap);
> +	bitmap_free(ent_enum->bmap);
>  }
>  EXPORT_SYMBOL_GPL(media_entity_enum_cleanup);
>  

-- 
Regards,

Laurent Pinchart
