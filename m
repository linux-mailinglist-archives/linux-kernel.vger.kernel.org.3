Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD6259A32F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350840AbiHSRNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350833AbiHSRM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:12:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9711435A9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 09:33:00 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1oP4vV-0007Ko-EU; Fri, 19 Aug 2022 18:32:53 +0200
Message-ID: <fbc25d0455faf3f3a870388508747eb9271a4f4e.camel@pengutronix.de>
Subject: Re: [PATCH] drm/etnaviv: Remove duplicate call to
 drm_gem_free_mmap_offset
From:   Lucas Stach <l.stach@pengutronix.de>
To:     "T.J. Mercier" <tjmercier@google.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 19 Aug 2022 18:32:51 +0200
In-Reply-To: <20220706182924.2563058-1-tjmercier@google.com>
References: <20220706182924.2563058-1-tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, dem 06.07.2022 um 18:29 +0000 schrieb T.J. Mercier:
> The docs explicitly say the drm_gem_object_release function already calls this,
> and this does not appear to be a prerequisite for the call to
> etnaviv_gem_ops.release.
> 
This looks correct to me. Patch applied to etnaviv/next.

Regards,
Lucas

> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gem.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> index cc386f8a7116..ecb828e4e156 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> @@ -504,7 +504,6 @@ void etnaviv_gem_free_object(struct drm_gem_object *obj)
>  		kfree(mapping);
>  	}
>  
> -	drm_gem_free_mmap_offset(obj);
>  	etnaviv_obj->ops->release(etnaviv_obj);
>  	drm_gem_object_release(obj);
>  


