Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E33474300
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 13:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbhLNMyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 07:54:16 -0500
Received: from foss.arm.com ([217.140.110.172]:54306 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229916AbhLNMyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 07:54:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02AA26D;
        Tue, 14 Dec 2021 04:54:15 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D69B23F793;
        Tue, 14 Dec 2021 04:54:14 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 9329368527A; Tue, 14 Dec 2021 12:54:13 +0000 (GMT)
Date:   Tue, 14 Dec 2021 12:54:13 +0000
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     brian.starkey@arm.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm: mali-dp: potential dereference of null pointer
Message-ID: <YbiT9SZ2sqrl3sJT@e110455-lin.cambridge.arm.com>
References: <20211214125110.46979-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211214125110.46979-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiasheng,

On Tue, Dec 14, 2021 at 08:51:10PM +0800, Jiasheng Jiang wrote:
> The return value of kzalloc() needs to be checked.
> To avoid use of null pointer '&state->base' in case of the
> failure of alloc.
> 
> Fixes: 99665d072183 ("drm: mali-dp: add malidp_crtc_state struct")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> Reported-by: Brian Starkey <brian.starkey@arm.com>

By R-b Brian meant "Reviewed-by" but I now can see how it can be confused with "Reported-by".

You don't have to send another version of the patch, I will add the correct tag to
your v1 when pushing it into drm-misc-next.

Best regards,
Liviu


> ---
> Changelog:
> 
> v1 -> v2
> 
> *Change 1. Add r-p.
> ---
>  drivers/gpu/drm/arm/malidp_crtc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_crtc.c b/drivers/gpu/drm/arm/malidp_crtc.c
> index 494075ddbef6..b5928b52e279 100644
> --- a/drivers/gpu/drm/arm/malidp_crtc.c
> +++ b/drivers/gpu/drm/arm/malidp_crtc.c
> @@ -487,7 +487,10 @@ static void malidp_crtc_reset(struct drm_crtc *crtc)
>  	if (crtc->state)
>  		malidp_crtc_destroy_state(crtc, crtc->state);
>  
> -	__drm_atomic_helper_crtc_reset(crtc, &state->base);
> +	if (state)
> +		__drm_atomic_helper_crtc_reset(crtc, &state->base);
> +	else
> +		__drm_atomic_helper_crtc_reset(crtc, NULL);
>  }
>  
>  static int malidp_crtc_enable_vblank(struct drm_crtc *crtc)
> -- 
> 2.25.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
