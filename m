Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C904AE4C9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388315AbiBHWcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386622AbiBHU7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 15:59:38 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7988C0612B8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 12:59:37 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h6so515535wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 12:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=LR/HqP2Q1P8BmgSmBhLwoCgWv4OeRLxaaKVnBHVz380=;
        b=OClWzaHwfnKbU2ivv9C7fQtoAaSQhJdGklXpEzcFffm1SkumsQsTkr8ZOu//Qj3wMX
         gEbDIlvZmGBGIRp32EXuJUt4pdkA+9hSevTsMS5kH+0eK7Qp5AnE8d5EBZDnA9LbvTcn
         umgHa0cvz5UESKxYpoHkM5AGiSPrp+EXDnSms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=LR/HqP2Q1P8BmgSmBhLwoCgWv4OeRLxaaKVnBHVz380=;
        b=LV8lqsbqIMA9l+2avLwjMTU4Y3irTmvFOLFeT4qscEnFCJfhnIHJcd7Xna7/GwI32s
         wdbV6Lh7+hiihNQiJ4j6uy8mqAqR8RKuFRvtyjrzbo/8qbPsKwdVFNBPZoLP4QFtXFPr
         O9R1gUPhRFrpsjn3tW3tqupqwhLiKv5L68jvNSoPNeV5Wg65OrdWbltsLWi+VkTkzc26
         /Toe0g2IOsMpudEhMFxUoepuCRqWFtwwufdjY/lEgUvxQzXgBQilCpAcRz4USSWb9Mvj
         2QRHl5+S5emtsBdXNvQfKROPG50vBJvzmI/VF6ml8N8CIpDE42t48vvk/XMkMdsTRhti
         49/Q==
X-Gm-Message-State: AOAM531hF/FSXQD/ZQkPg8fPpsBlPE/OPoHg+dwrUHUJ8/4rzmcHVlBG
        C8lUFjp0/oIwxlc5XSIA+0BaLQ==
X-Google-Smtp-Source: ABdhPJyoKyE7ZSiQIZzA82zoDzmj1UBV8TCrGt8kooKo8r1vgxpn3G6jb5XrdBUZcozMC7B14dmZJA==
X-Received: by 2002:a5d:64c8:: with SMTP id f8mr5121045wri.337.1644353976273;
        Tue, 08 Feb 2022 12:59:36 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id e3sm7852138wrr.94.2022.02.08.12.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 12:59:35 -0800 (PST)
Date:   Tue, 8 Feb 2022 21:59:33 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jens Frederich <jfrederich@gmail.com>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev,
        Daniel Vetter <daniel.vetter@intel.com>,
        Helge Deller <deller@gmx.de>,
        Matthew Wilcox <willy@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 21/21] fbdev: Make registered_fb[] private to fbmem.c
Message-ID: <YgLZtbhMGlr/upqA@phenom.ffwll.local>
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
 <YgJ4g2BEaeUELmvF@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgJ4g2BEaeUELmvF@phenom.ffwll.local>
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

On Tue, Feb 08, 2022 at 03:04:51PM +0100, Daniel Vetter wrote:
> On Fri, Feb 04, 2022 at 09:30:56AM +0100, Geert Uytterhoeven wrote:
> > Hi Daniel,
> > 
> > Thanks for your patch!
> > 
> > On Tue, Feb 1, 2022 at 9:50 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> > > Well except when the olpc dcon fbdev driver is enabled, that thing
> > > digs around in there in rather unfixable ways.
> > 
> > Can't the actual frame buffer driver (which one?) used on olpc export
> > a pointer to its fb_info?
> 
> Yeah that might be the right thing to do, I'll add that as a stagin TODO
> in the next iteration.

Well I tried to do that and noticed I've done that already in 2019:

commit af1440368837f19ac7d5dec05d929d91308f5a90
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue May 28 11:03:03 2019 +0200

    staging/olpc_dcon: Add drm conversion to TODO

TODO already explains how this should be done correctly in drm. Well maybe
we should add that stitching the drivers together should be done with
component.c or something like that.
-Daniel

> 
> > 
> > > --- a/drivers/video/fbdev/core/fbmem.c
> > > +++ b/drivers/video/fbdev/core/fbmem.c
> > > @@ -48,10 +48,14 @@
> > >  static DEFINE_MUTEX(registration_lock);
> > >
> > >  struct fb_info *registered_fb[FB_MAX] __read_mostly;
> > > -EXPORT_SYMBOL(registered_fb);
> > > -
> > >  int num_registered_fb __read_mostly;
> > > +#if IS_ENABLED(CONFIG_OLPC_DCON)
> > 
> > CONFIG_FB_OLPC_DCON (everywhere), cfr. the build failure reported
> > by the robot.
> 
> Yeah realized that too and fixed it locally.
> 
> Cheers, Daniel
> 
> > 
> > Gr{oetje,eeting}s,
> > 
> >                         Geert
> > 
> > --
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> > 
> > In personal conversations with technical people, I call myself a hacker. But
> > when I'm talking to journalists I just say "programmer" or something like that.
> >                                 -- Linus Torvalds
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
