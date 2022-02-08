Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76964ADA57
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376385AbiBHNql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357586AbiBHNqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 08:46:40 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E1FC03FED0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 05:46:36 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id y3so31604567ejf.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 05:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=n+LaJyZileNVYfrYaX66cB1MBmYgBiVsCyxJAwLVUMM=;
        b=lI+BZuVcaX39tM3Hzn6AV7cMAOYQiuorb7ECkjKy19ZLPsqgt5HccWa6JVE5WSOUzf
         zkF5zK1pNUirlIF9c0I6rmjLcjRY61AIgt0gVX3PzKHHihcmAvkzPuyk6Vsiwh52MJlx
         nJbFdhibExMF4h5Vct0UMFUcQtBrt70JaaTJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=n+LaJyZileNVYfrYaX66cB1MBmYgBiVsCyxJAwLVUMM=;
        b=SheVDckCffvyiuHD8DSyHPDsULKgpk66LRB9ZXj1GkTru9yWChJP7ySNQm2X/KUn/g
         NSdfccm+SHtmAJqJgJVwQNosIWOY9xmRiPpsEUkbS+jiZeorlpW7kl5/Ks9RgFj/KsBe
         w1mWfYn0oEyqMHylQRmhqXIO+nkbh8jvbNOhYUY8K1Lg69v+ij/uWEb5f4S0LlK+xSga
         cLJxEPk+g/9yQw8CNXkfinJIF4l/dzuIfSYNy1cPRp6iL+mxhoG4hFEw/uwQ+/KQkqFl
         lceGw9pxz4t6El4LYxaUf/dXlMwiWYVkwbtp7YlyEqaGeKRzVB3sJBS0mFK+gonslCw1
         3SvQ==
X-Gm-Message-State: AOAM532zXXvwpKhm8euTegLJLu2Lng3KklnptAHlyOsW31AY8yE/XyJI
        EjhM3g01F1XxWUl90WQOgbFFYQ==
X-Google-Smtp-Source: ABdhPJxVk+yKuksCrmEzucsFv8fLMfNwj3TQ4MGzWAZDuSk8mMV/chycYqMAJ3qCJ8UZgxkmkgB4aw==
X-Received: by 2002:a17:907:da3:: with SMTP id go35mr3771651ejc.456.1644327995333;
        Tue, 08 Feb 2022 05:46:35 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id e7sm331032ejm.133.2022.02.08.05.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 05:46:34 -0800 (PST)
Date:   Tue, 8 Feb 2022 14:46:33 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 10/21] fb: Delete fb_info->queue
Message-ID: <YgJ0OQxt4KIPD9uz@phenom.ffwll.local>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Helge Deller <deller@gmx.de>
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
 <20220131210552.482606-11-daniel.vetter@ffwll.ch>
 <YfxJlH2NDnLk/GUw@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfxJlH2NDnLk/GUw@ravnborg.org>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 10:31:00PM +0100, Sam Ravnborg wrote:
> On Mon, Jan 31, 2022 at 10:05:41PM +0100, Daniel Vetter wrote:
> > It was only used by fbcon, and that now switched to its own,
> > private work.
> > 
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Helge Deller <deller@gmx.de>
> > Cc: linux-fbdev@vger.kernel.org
> I would merge this with the patch that drops the usage

Yeah, but I like to split these out so that if this does break something,
it's much easier to revert. In case I overlooked something somewhere.

It's imo different if the cleanup is directly related to the preceeding
prep work, but this is a generic workqueue, and the cursor logic is rather
unrelated. And if I remember my history digging right, there were actually
other uses of this.
-Daniel

> 
> > ---
> >  include/linux/fb.h | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/include/linux/fb.h b/include/linux/fb.h
> > index 02f362c661c8..a8a00d2ba1f3 100644
> > --- a/include/linux/fb.h
> > +++ b/include/linux/fb.h
> > @@ -449,7 +449,6 @@ struct fb_info {
> >  	struct fb_var_screeninfo var;	/* Current var */
> >  	struct fb_fix_screeninfo fix;	/* Current fix */
> >  	struct fb_monspecs monspecs;	/* Current Monitor specs */
> > -	struct work_struct queue;	/* Framebuffer event queue */
> >  	struct fb_pixmap pixmap;	/* Image hardware mapper */
> >  	struct fb_pixmap sprite;	/* Cursor hardware mapper */
> >  	struct fb_cmap cmap;		/* Current cmap */
> > -- 
> > 2.33.0

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
