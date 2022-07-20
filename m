Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7F357BC86
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239878AbiGTRXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239731AbiGTRXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:23:09 -0400
Received: from mailrelay4-1.pub.mailoutpod1-cph3.one.com (mailrelay4-1.pub.mailoutpod1-cph3.one.com [46.30.210.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DDB52DDF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=lmaI30XHSL4PNFFVG0Xa0lhNYlUk5+rFIvNWFGwnmcQ=;
        b=iHaJGi0FLxds7BNBQFppRlzBxxuGbf9h1B2kkPk/hcd8hIW++aGHpkQTVoA2sTv3k+8E/fNcbpyh4
         +NGDu/gE0rXzKLbQ99R6h5bZS9dFVlblNgd99sYYZNpdrC0C0u8QJU8qKmHAuUXDV6c/JDapOf7P15
         gjNl7TfO7mxYNuS5/kIFbFP0aq7K6txRNJu0x0CCjaFY+zB4mQeS63NHA9Z28TdefQWk6q1mTSQAwf
         Oe0VpgX3MwvTLbGltjCPRZD6FhY0Uef9yhyWivgbCaoktwYXaPZRBDvF5WSFN7gLrXcs7PjELsUV3A
         3fSDY2UjEFLOetOwAhEL7gEK/5E0VTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=lmaI30XHSL4PNFFVG0Xa0lhNYlUk5+rFIvNWFGwnmcQ=;
        b=PRS2y6QNbF1pksH+j2QM+QHs6lKmaQSVlAYN9b8oI2DOJMgmzQ9MNoAK8+xrrLxWkqLpfCUjswXPr
         Pk1IgkJCQ==
X-HalOne-Cookie: aec1246fa57e05843033a4568f02e71c9cb1aef8
X-HalOne-ID: 9d2313f5-0850-11ed-823f-d0431ea8bb10
Received: from mailproxy2.cst.dirpod4-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 9d2313f5-0850-11ed-823f-d0431ea8bb10;
        Wed, 20 Jul 2022 17:23:04 +0000 (UTC)
Date:   Wed, 20 Jul 2022 19:23:03 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     daniel@ffwll.ch, laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, tzimmermann@suse.de, mripard@kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH drm-misc-next v5 1/4] drm/fb: rename FB CMA helpers to FB
 DMA helpers
Message-ID: <Ytg596Lk4kumqeRD@ravnborg.org>
References: <20220720153128.526876-1-dakr@redhat.com>
 <20220720153128.526876-2-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720153128.526876-2-dakr@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danilo,

On Wed, Jul 20, 2022 at 05:31:25PM +0200, Danilo Krummrich wrote:
> Rename "FB CMA" helpers to "FB DMA" helpers - considering the hierarchy
> of APIs (mm/cma -> dma -> fb dma) calling them "FB DMA" seems to be
> more applicable.
> 
> Besides that, commit e57924d4ae80 ("drm/doc: Task to rename CMA helpers")
> requests to rename the CMA helpers and implies that people seem to be
> confused about the naming.
> 
> In order to do this renaming the following script was used:
> 
> ```
> 	#!/bin/bash
> 
> 	DIRS="drivers/gpu include/drm Documentation/gpu"
> 
> 	REGEX_SYM_UPPER="[0-9A-Z_\-]"
> 	REGEX_SYM_LOWER="[0-9a-z_\-]"
> 
> 	REGEX_GREP_UPPER="(${REGEX_SYM_UPPER}*)(FB)_CMA_(${REGEX_SYM_UPPER}*)"
> 	REGEX_GREP_LOWER="(${REGEX_SYM_LOWER}*)(fb)_cma_(${REGEX_SYM_LOWER}*)"
> 
> 	REGEX_SED_UPPER="s/${REGEX_GREP_UPPER}/\1\2_DMA_\3/g"
> 	REGEX_SED_LOWER="s/${REGEX_GREP_LOWER}/\1\2_dma_\3/g"
> 
> 	# Find all upper case 'CMA' symbols and replace them with 'DMA'.
> 	for ff in $(grep -REHl "${REGEX_GREP_UPPER}" $DIRS)
> 	do
> 	       sed -i -E "$REGEX_SED_UPPER" $ff
> 	done
> 
> 	# Find all lower case 'cma' symbols and replace them with 'dma'.
> 	for ff in $(grep -REHl "${REGEX_GREP_LOWER}" $DIRS)
> 	do
> 	       sed -i -E "$REGEX_SED_LOWER" $ff
> 	done
> 
> 	# Replace all occurrences of 'CMA' / 'cma' in comments and
> 	# documentation files with 'DMA' / 'dma'.
> 	for ff in $(grep -RiHl " cma " $DIRS)
> 	do
> 		sed -i -E "s/ cma / dma /g" $ff
> 		sed -i -E "s/ CMA / DMA /g" $ff
> 	done
> ```
> 
> Only a few more manual modifications were needed, e.g. reverting the
> following modifications in some DRM Kconfig files
> 
>     -       select CMA if HAVE_DMA_CONTIGUOUS
>     +       select DMA if HAVE_DMA_CONTIGUOUS
> 
> as well as manually picking the occurrences of 'CMA'/'cma' in comments and
> documentation which relate to "FB CMA", but not "GEM CMA".
> 
> This patch is compile-time tested building a x86_64 kernel with
> `make allyesconfig && make drivers/gpu/drm`.
> 
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>

For the most part I like the patch.
But there is a few cases I would like to see fixed.


> diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
> index e89ae0ec60eb..fab18135f12b 100644
> --- a/drivers/gpu/drm/arm/hdlcd_drv.c
> +++ b/drivers/gpu/drm/arm/hdlcd_drv.c
> @@ -25,7 +25,7 @@
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_debugfs.h>
>  #include <drm/drm_drv.h>
> -#include <drm/drm_fb_cma_helper.h>
> +#include <drm/drm_fb_dma_helper.h>
>  #include <drm/drm_fb_helper.h>
>  #include <drm/drm_gem_cma_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>


The only change in the file above is the rename of the include file.
This is a strong hint that the include is not needed and the correct fix
is to drop the include. There are more cases like the above.

This is a manual process on top of what you could automate, but then I
suggest to identify them and remove the includes before you change the
file name.

Or if anyone applies the patches then at least do it in a follow-up at
the places will never be easier to spot.

So with this cleanup done either before or after this patch.
Acked-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
