Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C384A4799EF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 10:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbhLRJQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 04:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhLRJQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 04:16:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1501C061574;
        Sat, 18 Dec 2021 01:16:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8893F60E73;
        Sat, 18 Dec 2021 09:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A129C36AE1;
        Sat, 18 Dec 2021 09:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639819006;
        bh=hOMGL3IpkFJQfo5rO2SN15qADKosK49E/K3YyTIMkBA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Wvp7dAZaWIGNnA1fIfeIkbncQZu5sDHqg7PZ3efcsTfMsYBOLCyUUocVKRxX1OfTv
         dddQqg8jW6KcHVkSz3PR8KUD5lL2d+dnKfYeWpsODh5tLys3XY1n8Vf0p3sHXrHKmv
         iRFbwCSAPi4oDK7rBxcuo9+x374b++z6RU67V20KqNZvEJA+ZpqZ/Aw1sxgWIg1m2r
         /XXJq+PZ4cEWjJtqsaCrteEcRS2T7FMRy9JoDFh9pAxusXxjT0AdygmMjhCTRogh2a
         y3LGIQbc5HH8kjqEeXW6wfTI08lB4tWw5CODFeX/vMZ07ptyKmuL7F7EBRxYma0mE3
         7m5rIiE6xpwnw==
Date:   Sat, 18 Dec 2021 10:16:42 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     davidcomponentone@gmail.com
Cc:     arnd@arndb.de, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] media: saa7134: use swap() to make code cleaner
Message-ID: <20211218101642.1e1c22ca@coco.lan>
In-Reply-To: <021c7dbfec45346672d1773bd322c00b62906e54.1639791971.git.yang.guang5@zte.com.cn>
References: <021c7dbfec45346672d1773bd322c00b62906e54.1639791971.git.yang.guang5@zte.com.cn>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, 18 Dec 2021 09:58:02 +0800
davidcomponentone@gmail.com escreveu:

> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
> opencoding it.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: David Yang <davidcomponentone@gmail.com>
> Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
> ---
>  drivers/media/pci/saa7134/saa7134-video.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/pci/saa7134/saa7134-video.c b/drivers/media/pci/saa7134/saa7134-video.c
> index 374c8e1087de..6f4132058c35 100644
> --- a/drivers/media/pci/saa7134/saa7134-video.c
> +++ b/drivers/media/pci/saa7134/saa7134-video.c
> @@ -823,7 +823,7 @@ static int buffer_activate(struct saa7134_dev *dev,
>  {
>  	struct saa7134_dmaqueue *dmaq = buf->vb2.vb2_buf.vb2_queue->drv_priv;
>  	unsigned long base,control,bpl;
> -	unsigned long bpl_uv,lines_uv,base2,base3,tmp; /* planar */
> +	unsigned long bpl_uv, lines_uv, base2, base3; /* planar */
>  
>  	video_dbg("buffer_activate buf=%p\n", buf);
>  	buf->top_seen = 0;
> @@ -869,9 +869,7 @@ static int buffer_activate(struct saa7134_dev *dev,
>  		base2    = base + bpl * dev->height;
>  		base3    = base2 + bpl_uv * lines_uv;
>  		if (dev->fmt->uvswap) {
> -			tmp = base2;
> -			base2 = base3;
> -			base3 = tmp;
> +			swap(base2, base3);
>  		}

No need for {}

>  		video_dbg("uv: bpl=%ld lines=%ld base2/3=%ld/%ld\n",
>  			bpl_uv,lines_uv,base2,base3);



Thanks,
Mauro
