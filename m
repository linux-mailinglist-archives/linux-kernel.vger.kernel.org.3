Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D4448194C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 05:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbhL3EXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 23:23:10 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:44212 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235544AbhL3EXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 23:23:08 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 831972A5;
        Thu, 30 Dec 2021 05:23:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1640838186;
        bh=lk4NdUPSMrf0hfvUHOMJ/lZApA0VGtGmYWqfcHKrUus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VQqAtC5Ghz15FaGuB/BFSE/EUI5YukiOs18f8Pn8SgWWRdRDKfETw2nmZGDrtSGJM
         +unV71QJoFU2clBaQxpUnVNPVTm8WDK7lMy4PsYnvebjTqzhIDdvUAN3xpfOdlLSgo
         jpeCdAIM+fvFbw9OFd2KnqmKSTR2DNhkxAJAl21k=
Date:   Thu, 30 Dec 2021 06:23:04 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Benoit Parrot <bparrot@ti.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v5 02/14] media: cadence: csi2rx: Cleanup media entity
 properly
Message-ID: <Yc00KA6zwnfvdp6C@pendragon.ideasonboard.com>
References: <20211223191615.17803-1-p.yadav@ti.com>
 <20211223191615.17803-3-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211223191615.17803-3-p.yadav@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pratyush,

Thank you for the patch.

On Fri, Dec 24, 2021 at 12:46:03AM +0530, Pratyush Yadav wrote:
> Call media_entity_cleanup() in probe error path and remove to make sure
> the media entity is cleaned up properly.
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
> Changes in v5:
> - New in v5.
> 
>  drivers/media/platform/cadence/cdns-csi2rx.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
> index 2a23da6a0b8e..2547903f2e8e 100644
> --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> @@ -471,6 +471,7 @@ static int csi2rx_probe(struct platform_device *pdev)
>  err_cleanup:
>  	v4l2_async_nf_unregister(&csi2rx->notifier);
>  	v4l2_async_nf_cleanup(&csi2rx->notifier);
> +	media_entity_cleanup(&csi2rx->subdev.entity);
>  err_free_priv:
>  	kfree(csi2rx);
>  	return ret;
> @@ -483,6 +484,7 @@ static int csi2rx_remove(struct platform_device *pdev)
>  	v4l2_async_nf_unregister(&csi2rx->notifier);
>  	v4l2_async_nf_cleanup(&csi2rx->notifier);
>  	v4l2_async_unregister_subdev(&csi2rx->subdev);
> +	media_entity_cleanup(&csi2rx->subdev.entity);
>  	kfree(csi2rx);
>  
>  	return 0;

-- 
Regards,

Laurent Pinchart
