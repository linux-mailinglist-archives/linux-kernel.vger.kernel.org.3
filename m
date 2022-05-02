Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB0D5173B9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241122AbiEBQKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240898AbiEBQKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:10:09 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A656DEAF
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 09:06:39 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AD64E474;
        Mon,  2 May 2022 18:06:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1651507597;
        bh=aabGl3GzSk94KKGc7OXE2SaovEGKFkQ64Px+ktw/wOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=czFQIBTu+DGi0WBWJyKysjh14KAYvcNHHtRoLgVMTh3FtfmMrb5Q4qseexYQxcL75
         +2rWUtoLDmoHKWm0mRf/79t4OiRp80rMiKA1VSpBCzjrzWjbVnQ2b0o+AnVsURc2lj
         oX7m4tYokxNipuE1HEvXWxyiQudkQdcaEVf1gvMs=
Date:   Mon, 2 May 2022 19:06:37 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 1/3] drm: Remove superfluous arg when calling to
 drm_fbdev_generic_setup()
Message-ID: <YnABjdpGC166yIY7@pendragon.ideasonboard.com>
References: <20220502153900.408522-1-javierm@redhat.com>
 <20220502153900.408522-2-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220502153900.408522-2-javierm@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

Thank you for the patch.

On Mon, May 02, 2022 at 05:38:58PM +0200, Javier Martinez Canillas wrote:
> The drm_fbdev_generic_setup() function already sets the preferred bits per
> pixel for the device to dev->mode_config.preferred_depth, if preferred_bpp
> value is zero.
> 
> Passing the same value to the function is unnecessary. Let's cleanup that
> in the two drivers that do it.

This looks fine, so

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

but why do we have two different mechanisms to set the preferred depth ?
Could we get all drivers to set dev->mode_config.preferred_depth and
drop the depth option to drm_fbdev_generic_setup() ? There's a FIXME
comment in drm_fbdev_generic_setup() that could be related.

> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
> 
> (no changes since v1)
> 
>  drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 2 +-
>  drivers/gpu/drm/tiny/cirrus.c                   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index fe4269c5aa0a..ace92459e462 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -349,7 +349,7 @@ static int hibmc_pci_probe(struct pci_dev *pdev,
>  		goto err_unload;
>  	}
>  
> -	drm_fbdev_generic_setup(dev, dev->mode_config.preferred_depth);
> +	drm_fbdev_generic_setup(dev, 0);
>  
>  	return 0;
>  
> diff --git a/drivers/gpu/drm/tiny/cirrus.c b/drivers/gpu/drm/tiny/cirrus.c
> index c8e791840862..ed5a2e14894a 100644
> --- a/drivers/gpu/drm/tiny/cirrus.c
> +++ b/drivers/gpu/drm/tiny/cirrus.c
> @@ -601,7 +601,7 @@ static int cirrus_pci_probe(struct pci_dev *pdev,
>  	if (ret)
>  		return ret;
>  
> -	drm_fbdev_generic_setup(dev, dev->mode_config.preferred_depth);
> +	drm_fbdev_generic_setup(dev, 0);
>  	return 0;
>  }
>  

-- 
Regards,

Laurent Pinchart
