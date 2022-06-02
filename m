Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2CB53C084
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 23:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239519AbiFBVz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 17:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236743AbiFBVzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 17:55:54 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B37B7F2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 14:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1654206947; bh=Ki/Rl/4q0399EjnSBqmzWU3sLpJik8WX4vFYR3fDXjg=;
        h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
        b=FLcoU608SZaHaFJVRmHeaoFikgDsv6OxWVxeRAWPKeAQKSmUPNsaF9elJXb9Z6ST9
         axoaxO/BP16uhEv0Im0qYE0VTGmt7sBdQe16Q8AWXWtcNdNVrolG1Z7fgg2u/tV3bL
         5e34zlYVa/hV/i9VZaDx0KppIU7ukftnHRY6QCLo=
Date:   Thu, 2 Jun 2022 23:55:47 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Roman Stratiienko <r.stratiienko@gmail.com>
Cc:     mripard@kernel.org, wens@csie.org, jernej.skrabec@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch, samuel@sholland.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: sun8i: Add the ability to keep scaler enabled
 for VI layer
Message-ID: <20220602215547.scsabzbeztgduaj3@core>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Roman Stratiienko <r.stratiienko@gmail.com>, mripard@kernel.org,
        wens@csie.org, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, samuel@sholland.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20220602180118.66170-1-r.stratiienko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602180118.66170-1-r.stratiienko@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

On Thu, Jun 02, 2022 at 06:01:18PM +0000, Roman Stratiienko wrote:
> According to DE2.0/DE3.0 manual VI scaler enable register is double
> buffered, but de facto it doesn't, or the hardware has the shadow
> register latching issues which causes single-frame picture corruption
> after changing the state of scaler enable register.
> 
> Allow the user to keep the scaler always enabled, preventing the UI
> glitches on the transition from scaled to unscaled state.
> 
> NOTE:
> UI layer scaler has more registers with double-buffering issue and can't
> be workarounded in the same manner.
> 
> You may find a python test and a demo video for this issue at [1]

Isn't this an issue with kernel driver not waiting for DE2 FINISH IRQ, but
for VBLANK IRQ from TCON instead, before allowing to write new set of register
values?

https://megous.com/dl/tmp/4fe35b3fc72ee7de.png

I haven't checked if FINISH flag is set at time of VBLANK interrupt, so maybe
this is not the issue.

regards,
	o.

> [1]: https://github.com/GloDroid/glodroid_tests/issues/4
> Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> ---
>  drivers/gpu/drm/sun4i/sun8i_mixer.c    | 12 ++++++++++++
>  drivers/gpu/drm/sun4i/sun8i_vi_layer.c |  4 +++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> index 71ab0a00b4de..15cad0330f66 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> @@ -27,6 +27,18 @@
>  #include "sun8i_vi_layer.h"
>  #include "sunxi_engine.h"
>  
> +/* According to DE2.0/DE3.0 manual VI scaler enable register is double
> + * buffered, but de facto it doesn't, or the hardware has the shadow
> + * register latching issues which causes single-frame picture corruption
> + * after changing the state of scaler enable register.
> + * Allow the user to keep the scaler always enabled, preventing the UI
> + * glitches on the transition from scaled to unscaled state.
> + */
> +int sun8i_vi_keep_scaler_enabled;
> +MODULE_PARM_DESC(keep_vi_scaler_enabled,
> +		 "Keep VI scaler enabled (1 = enabled, 0 = disabled (default))");
> +module_param_named(keep_vi_scaler_enabled, sun8i_vi_keep_scaler_enabled, int, 0644);
> +
>  struct de2_fmt_info {
>  	u32	drm_fmt;
>  	u32	de2_fmt;
> diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> index 662ba1018cc4..f005ab883503 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> @@ -17,6 +17,8 @@
>  #include "sun8i_vi_layer.h"
>  #include "sun8i_vi_scaler.h"
>  
> +extern int sun8i_vi_keep_scaler_enabled;
> +
>  static void sun8i_vi_layer_enable(struct sun8i_mixer *mixer, int channel,
>  				  int overlay, bool enable, unsigned int zpos)
>  {
> @@ -149,7 +151,7 @@ static int sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int channel,
>  	 */
>  	subsampled = format->hsub > 1 || format->vsub > 1;
>  
> -	if (insize != outsize || subsampled || hphase || vphase) {
> +	if (insize != outsize || subsampled || hphase || vphase || sun8i_vi_keep_scaler_enabled) {
>  		unsigned int scanline, required;
>  		struct drm_display_mode *mode;
>  		u32 hscale, vscale, fps;
> -- 
> 2.30.2
> 
