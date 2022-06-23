Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3C055806E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 18:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbiFWQr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 12:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbiFWQrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 12:47:01 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A8D49CAE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 09:46:58 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id cs6so188771qvb.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 09:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B1jvVdluJ66W41UOcamwBo/85mg4sSq7LE7oRZc9/Ws=;
        b=CQgpPxqnnpqAloyO7Cx3oS7JP5gZQB3Qg0Mw2O4cWqw3cPSl/gs3pEoUgwTf3F2ERo
         dqIndkVy6qNbaczXA18ui/W1Uf2EYbUGkmckXM1NOGViyBpaCUtGPOXa2WE1WTX9e1SY
         WML0WjDpL/clGTLZdmKiq6o2tGLLrdlI9gHCS10Mi/kIkpec+p5IdmoZ1XFY7puK4uUH
         BOawN171/X8635YxQHiPx4XzloEvkwByWBIBZEK6EdI0XLNGOUpp6hZiKZvi2jJngvF0
         B9azYvIFMbctnuc1A9kMbnzp+BAbHnl6yOUVoDpD9sY5t2AHKxM4D6ijomMyR/wV0j+M
         MQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B1jvVdluJ66W41UOcamwBo/85mg4sSq7LE7oRZc9/Ws=;
        b=oEdJzSxPcA7T8Kwl40lcfSh97BdTOe+//kevggijG3XBZYHIrTWJYD+eIqDMyKZABK
         LqOiOu6ML5qWrxJjDN8/c7SXrpRJwlaryR6J6BNa/fQR0A3vz0sb9nVutcooXKY2GWMq
         Pi454Xcw77lUfBCV+qzGcRPiKNLBxOncj2rYJCT5CzhTzxv67taoa/Kl10v6+UZEwkuJ
         W6i5Lj8XPdMyLTjg7MWC1vCjNkEWmJ4S6qKZ4eynQGR6jNAImKTHv7dq7MJUR+K+2UJC
         s+c62agKSngSVYXUfdXaTkOBajXSB0gL1IqJ5rofPanbQ0zx6go1OKggx2/y9EntOEpg
         QkSA==
X-Gm-Message-State: AJIora+de/wzEertCpWIZnRUiCwoj3zCjH7g6LAB3z+FC7xiezPjFJMz
        S2Zo3JzhyjGFyiAxyx5Lm5t8JA==
X-Google-Smtp-Source: AGRyM1vxTXHu+RcB3wUEKbXav6TTh4Vf0ZudnPRdRYthYM9mf8uEoaiSOtHZwJ2Xro3RBhPUjeOqUA==
X-Received: by 2002:ac8:5a04:0:b0:304:f19e:5fe4 with SMTP id n4-20020ac85a04000000b00304f19e5fe4mr8951799qta.374.1656002817837;
        Thu, 23 Jun 2022 09:46:57 -0700 (PDT)
Received: from localhost (115.25.199.35.bc.googleusercontent.com. [35.199.25.115])
        by smtp.gmail.com with ESMTPSA id x28-20020ac8701c000000b00316022dcc08sm3157121qtm.11.2022.06.23.09.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 09:46:57 -0700 (PDT)
Date:   Thu, 23 Jun 2022 16:46:56 +0000
From:   Sean Paul <sean@poorly.run>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Doug Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Sandy Huang <hjc@rock-chips.com>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH] drm/rockchip: vop: Don't crash for invalid
 duplicate_state()
Message-ID: <YrSZAMYzEkXUExNG@art_vandelay>
References: <20220617172623.1.I62db228170b1559ada60b8d3e1637e1688424926@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617172623.1.I62db228170b1559ada60b8d3e1637e1688424926@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 05:26:52PM -0700, Brian Norris wrote:
> It's possible for users to try to duplicate the CRTC state even when the
> state doesn't exist. drm_atomic_helper_crtc_duplicate_state() (and other
> users of __drm_atomic_helper_crtc_duplicate_state()) already guard this
> with a WARN_ON() instead of crashing, so let's do that here too.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Thanks for this patch!

Reviewed-by: Sean Paul <seanpaul@chromium.org>

> ---
> 
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index 74562d40f639..daf192881353 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -1570,6 +1570,9 @@ static struct drm_crtc_state *vop_crtc_duplicate_state(struct drm_crtc *crtc)
>  {
>  	struct rockchip_crtc_state *rockchip_state;
>  
> +	if (WARN_ON(!crtc->state))
> +		return NULL;
> +
>  	rockchip_state = kzalloc(sizeof(*rockchip_state), GFP_KERNEL);
>  	if (!rockchip_state)
>  		return NULL;
> -- 
> 2.36.1.476.g0c4daa206d-goog
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
