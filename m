Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07865B0AEA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 19:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiIGRB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 13:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiIGRBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 13:01:54 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828ABA1A71
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 10:01:46 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id fy31so31816080ejc.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 10:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date;
        bh=peZgSl5dPI+u2OqW4n8C/pIWpEREEdjuQZWvwx0IKNk=;
        b=MzRYqUdoG6QXvWPPUrAiHiUARD6S98r7h6bufrT6HWmFBk385b5xdyYTdp5HAY7+r6
         PdEiTc68BfF2vPecg6NoPNhLcfCiJl7LmiKeXg0mxxnFgEKKAuW5a6lv29kJ+d+Z4DDN
         /jv+/EJXAqM0NU7hUmH+h0iVqN2oP2FI7aHWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=peZgSl5dPI+u2OqW4n8C/pIWpEREEdjuQZWvwx0IKNk=;
        b=xBrHAn3A5DOJVprxG2dhrsdaQ1iNdd4nMgwJMbFsVh3khXT3D8996X3PNj1T7H1btY
         8GGji9cqt6VngJiDQvmK+eKjONOgaIRJDJJH+S8TkvoTPZ5dmt2dEMEhqLsfdyhahjYU
         cSje76mtgaIRVYS9J4x1UJrxBKlHrn+jzMT3gHGZBHF1vQlv4ocADIVYGtElOpOUbsPi
         wgs1YOMawktxyYcoMjHeUHSY/4W0V/Vk4Phr6X9E6wM1G3WxrPJzfAdrRFO8Ayf/yI2b
         nMXfbgvonW+NyQ/UU5bBaR70D4VKG+ClCpYIqSPCOmMLOLkf7N6EF8nqAB1bLIWsBQ2K
         gr2Q==
X-Gm-Message-State: ACgBeo2RDRNe31BzX0MEehURVozU74yE8BDJqU3Vov9EsnXAUIQpf7Yo
        aKgkyp0wCQz0KzSwFHtu1jNTAg==
X-Google-Smtp-Source: AA6agR5jnrJ9MziGfpakhXBzK2SFkenGyD3KrEvbx717NnPk/0eqzDmgFJLNvuEQWGaCmtKJYkux4A==
X-Received: by 2002:a17:907:9816:b0:741:89cc:af19 with SMTP id ji22-20020a170907981600b0074189ccaf19mr2934614ejc.492.1662570105042;
        Wed, 07 Sep 2022 10:01:45 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id t1-20020a1709066bc100b007303fe58eb2sm8600083ejs.154.2022.09.07.10.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 10:01:44 -0700 (PDT)
Date:   Wed, 7 Sep 2022 19:01:42 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 01/12] drm/udl: Restore display mode on resume
Message-ID: <YxjOdtQmC/z73ImI@phenom.ffwll.local>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20220816153655.27526-1-tiwai@suse.de>
 <20220816153655.27526-2-tiwai@suse.de>
 <YxeoX5dikxsUjzJS@phenom.ffwll.local>
 <87sfl3enqu.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sfl3enqu.wl-tiwai@suse.de>
X-Operating-System: Linux phenom 5.18.0-4-amd64 
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 07:51:05AM +0200, Takashi Iwai wrote:
> On Tue, 06 Sep 2022 22:06:55 +0200,
> Daniel Vetter wrote:
> > 
> > On Tue, Aug 16, 2022 at 05:36:44PM +0200, Takashi Iwai wrote:
> > > From: Thomas Zimmermann <tzimmermann@suse.de>
> > > 
> > > Restore the display mode whne resuming from suspend. Currently, the
> > > display remains dark.
> > > 
> > > On resume, the CRTC's mode does not change, but the 'active' flag
> > > changes to 'true'. Taking this into account when considering a mode
> > > switch restores the display mode.
> > > 
> > > The bug is reproducable by using Gnome with udl and observing the
> > > adapter's suspend/resume behavior.
> > > 
> > > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > 
> > This patch isn't great and incomplete, see
> > 
> > https://lore.kernel.org/dri-devel/YxegiQFAv+OWjjqE@phenom.ffwll.local/
> > 
> > You need cc: stable and fixes: 997d33c35618 and actually just remove the
> > entire check :-)
> 
> OK, then is something like below?
> 
> I already submitted v2 yesterday (as I overlooked your reply), so I'll
> respin v3 with this (and your ack) if that's OK.
> 
> 
> thanks,
> 
> Takashi
> 
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] drm/udl: Restore display mode on resume
> 
> Restore the display mode whne resuming from suspend. Currently, the
> display remains dark.
> 
> On resume, the CRTC's mode does not change, but the 'active' flag
> changes to 'true'. Taking this into account when considering a mode
> switch restores the display mode.
> 
> The bug is reproducable by using Gnome with udl and observing the
> adapter's suspend/resume behavior.
> 
> Actually, the whole check added in udl_simple_display_pipe_enable()
> about the crtc_state->mode_changed was bogus.  We should drop the
> whole check and always apply the mode change in this function.
> 
> [ tiwai -- Drop the mode_changed check entirely instead, per Daniel's
>   suggestion ]
> 
> Fixes: 997d33c35618 ("drm/udl: Inline DPMS code into CRTC enable and disable functions")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Yeah I think that's the right one. But please check that it still fixes
the bug you're seeing :-)

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/udl/udl_modeset.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
> index 169110d8fc2e..34ce5b43c5db 100644
> --- a/drivers/gpu/drm/udl/udl_modeset.c
> +++ b/drivers/gpu/drm/udl/udl_modeset.c
> @@ -382,9 +382,6 @@ udl_simple_display_pipe_enable(struct drm_simple_display_pipe *pipe,
>  
>  	udl_handle_damage(fb, &shadow_plane_state->data[0], 0, 0, fb->width, fb->height);
>  
> -	if (!crtc_state->mode_changed)
> -		return;
> -
>  	/* enable display */
>  	udl_crtc_write_mode_to_hw(crtc);
>  }
> -- 
> 2.35.3
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
