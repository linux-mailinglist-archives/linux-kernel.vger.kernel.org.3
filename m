Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537A34ADABC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 15:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377514AbiBHOE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 09:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359354AbiBHOE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:04:56 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF9AC03FECE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 06:04:56 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k6-20020a05600c1c8600b003524656034cso1729106wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 06:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=B6FmlZTmcDzUzTnzs/ZnYmE51lyCgX2/CWAYd99P97c=;
        b=NRaKMb4NCaHsBJXQvwGqtTS8m1aISo9EPi17EJah39Y03g7CaTHKQott64gc4dVFLo
         Uhdo9cAUaQPQ0mKLYZByUdJh3JLOVDpX7kQzE7v3+1tAY07cyMvHU22MVI4QEiRD51AZ
         tVcbf8e3BnqOM6P7zL5YaFtDr+YDwBLbWzPds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=B6FmlZTmcDzUzTnzs/ZnYmE51lyCgX2/CWAYd99P97c=;
        b=KfYVplISo+rr7C2eCAYmk6BlvQJ1wpkR1z2d63crYWaC5Q5r4vp7qy29NGJqNlMLQ7
         Gv7qYS83ooOrR9qsOTKNZcDzwyK2vYEUwD3WYOGQlk6qjDmOaYRsjTuHLSdeqT5ukBrz
         wm7aZnaCPh2NcMRk2eIhHJMLlqbTDfp1m88oBWL7o+5JMZe9q9WhiiezgrnVFXNfqvqp
         VYscvpOEAc5TGf4nNMlNUn6lI0IKmMydwYTOFYHYjsEodeLgeiAM0Ol6H1sce7dBsQZ6
         uecg+wgC2tmQXmAz5JUvIkkyak8zyWi0fHA6zOb1uiEvBlUiB0lYJPcc4hE1k/T3hcfi
         DCKA==
X-Gm-Message-State: AOAM531pTxmphdXotGmiQXzW0V2kAs+CY4VkPveY8nfdDZbB1CBPAuxB
        Zu79uGsDDriAj7ctcCZOrbDXkg==
X-Google-Smtp-Source: ABdhPJy7VKPSMId+XZSUl+UPzsq7hk9qGy4vC8m7UEqCLa/LPu+gRsdppXdPV+QZ5sHxKub1DOQDkQ==
X-Received: by 2002:a05:600c:1506:: with SMTP id b6mr1299950wmg.30.1644329094673;
        Tue, 08 Feb 2022 06:04:54 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id z17sm2262017wml.38.2022.02.08.06.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 06:04:54 -0800 (PST)
Date:   Tue, 8 Feb 2022 15:04:51 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jens Frederich <jfrederich@gmail.com>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Matthew Wilcox <willy@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 21/21] fbdev: Make registered_fb[] private to fbmem.c
Message-ID: <YgJ4g2BEaeUELmvF@phenom.ffwll.local>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jens Frederich <jfrederich@gmail.com>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev,
        Daniel Vetter <daniel.vetter@intel.com>,
        Helge Deller <deller@gmx.de>, Matthew Wilcox <willy@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>, Zheyu Ma <zheyuma97@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
 <20220131210552.482606-22-daniel.vetter@ffwll.ch>
 <CAMuHMdUm76tT6u+i=A50ffh=k8hX5kgoMqH=t_wfHqH95nVOPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUm76tT6u+i=A50ffh=k8hX5kgoMqH=t_wfHqH95nVOPA@mail.gmail.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 09:30:56AM +0100, Geert Uytterhoeven wrote:
> Hi Daniel,
> 
> Thanks for your patch!
> 
> On Tue, Feb 1, 2022 at 9:50 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> > Well except when the olpc dcon fbdev driver is enabled, that thing
> > digs around in there in rather unfixable ways.
> 
> Can't the actual frame buffer driver (which one?) used on olpc export
> a pointer to its fb_info?

Yeah that might be the right thing to do, I'll add that as a stagin TODO
in the next iteration.

> 
> > --- a/drivers/video/fbdev/core/fbmem.c
> > +++ b/drivers/video/fbdev/core/fbmem.c
> > @@ -48,10 +48,14 @@
> >  static DEFINE_MUTEX(registration_lock);
> >
> >  struct fb_info *registered_fb[FB_MAX] __read_mostly;
> > -EXPORT_SYMBOL(registered_fb);
> > -
> >  int num_registered_fb __read_mostly;
> > +#if IS_ENABLED(CONFIG_OLPC_DCON)
> 
> CONFIG_FB_OLPC_DCON (everywhere), cfr. the build failure reported
> by the robot.

Yeah realized that too and fixed it locally.

Cheers, Daniel

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
