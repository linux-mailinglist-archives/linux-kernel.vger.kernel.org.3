Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBEA504CF8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 09:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236909AbiDRHK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 03:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiDRHKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 03:10:21 -0400
Received: from mx2.smtp.larsendata.com (mx2.smtp.larsendata.com [91.221.196.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E04167DF
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 00:07:42 -0700 (PDT)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
        by mx2.smtp.larsendata.com (Halon) with ESMTPS
        id 3e71f98d-bee6-11ec-9ac0-0050568cd888;
        Mon, 18 Apr 2022 07:07:44 +0000 (UTC)
Received: from mailproxy3.cst.dirpod4-cph3.one.com (mailproxy3.pub.dirpod4-cph3.one.com [104.37.34.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sam@ravnborg.org)
        by mail01.mxhotel.dk (Postfix) with ESMTPSA id 5F784194B38;
        Mon, 18 Apr 2022 09:07:39 +0200 (CEST)
Date:   Mon, 18 Apr 2022 09:07:35 +0200
X-Report-Abuse-To: abuse@mxhotel.dk
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Christophe Branchereau <cbranchereau@gmail.com>,
        kbuild-all <kbuild-all@lists.01.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] drm/panel: newvision-nv3052c: Fix build
Message-ID: <Yl0ON+E7bYluGIYG@ravnborg.org>
References: <20220409100016.9337-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409100016.9337-1-paul@crapouillou.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2022 at 11:00:16AM +0100, Paul Cercueil wrote:
> The driver was compile-tested then rebased on drm-misc-next, and not
> compile-tested after the rebase; unfortunately the driver didn't compile
> anymore when it hit drm-misc-next.
> 
> Fixes: 49956b505c53 ("drm/panel: Add panel driver for NewVision NV3052C based LCDs")
> Cc: Christophe Branchereau <cbranchereau@gmail.com>
> Cc: kbuild-all <kbuild-all@lists.01.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  drivers/gpu/drm/panel/panel-newvision-nv3052c.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-newvision-nv3052c.c b/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
> index 127bcfdb59df..cf078f0d3cd3 100644
> --- a/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
> +++ b/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
> @@ -416,15 +416,13 @@ static int nv3052c_probe(struct spi_device *spi)
>  	return 0;
>  }
>  
> -static int nv3052c_remove(struct spi_device *spi)
> +static void nv3052c_remove(struct spi_device *spi)
>  {
>  	struct nv3052c *priv = spi_get_drvdata(spi);
>  
>  	drm_panel_remove(&priv->panel);
>  	drm_panel_disable(&priv->panel);
>  	drm_panel_unprepare(&priv->panel);
> -
> -	return 0;
>  }
>  
>  static const struct drm_display_mode ltk035c5444t_modes[] = {
> -- 
> 2.35.1
