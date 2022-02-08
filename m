Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1F74ADA7E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376907AbiBHN4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376885AbiBHN4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 08:56:39 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D86DC03FED3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 05:56:38 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id f17so30944449wrx.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 05:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=O/7417wNQCN4SuMaNTwcVKN+ZflwWgOUCIPC+jiRE/o=;
        b=Ew0LBKyyZZg7bw9TJmpVuYAYXcHmtjfUHDVj7FrAp9ZH8ajDNFW8U6BnR/JiOt4nzW
         PaCd3vXMwp7M/Dm9bNm/zpuvmivc2iaAFZUv6ZwzFyKlXURnG3XGpJliMBFsWShgVw5j
         ENO1C8RYNForJhZG+YhFWvcq4hbfLgfhHAbRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=O/7417wNQCN4SuMaNTwcVKN+ZflwWgOUCIPC+jiRE/o=;
        b=VNY5n0fWxAFcUZAYUZPZrGDEYfYJQM7KZ/Aqw5nkGLdIqwuWagS6nt6732rS98GPRr
         sD8x6K1QcYS7q1XzAGkvNyxZPq+yddGjr9mzLJ91Wbu0rjkzhQzV3jR5Efg7G926PDoY
         WNRPA3e0z1kgI1T74woKBolUb2h+oaXPuw1F9qWXoC0Z3eQHLWonsRRZ9/8K/eyjjiJ4
         08Cp6hzEheLalLrJmtO9ATH0DKUmJeO63jr1ibgn+TdDjqDbB9Y2rUw7xz3zIHCtOEjk
         Q+QePTRYuDVQiUWXomS666KlLaQ1w4iYJo2VwDjRXl+VfJD00V3tD9I0fb7+6UNctCXN
         bLkA==
X-Gm-Message-State: AOAM530aSUNvDMvtPM8K9KnEAUwwdcWyEcY9ACfuHE/D7m9uAAtsxk3s
        ct3uEgNDv0EJ8n8uSYZaGCgn7A==
X-Google-Smtp-Source: ABdhPJywjPxKkAwnXbVLdTzSYAhDUTqfE7kVbx67xjjQpyqk07POVfshuilESB0J8Up36dslkKnnyA==
X-Received: by 2002:a5d:4a06:: with SMTP id m6mr3751562wrq.37.1644328596738;
        Tue, 08 Feb 2022 05:56:36 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b11sm776039wmq.26.2022.02.08.05.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 05:56:35 -0800 (PST)
Date:   Tue, 8 Feb 2022 14:56:33 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Du Cheng <ducheng2@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Zheyu Ma <zheyuma97@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Claudio Suarez <cssk@net-c.es>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 16/21] fbcon: Move console_lock for
 register/unlink/unregister
Message-ID: <YgJ2kTA8E/DuHevH@phenom.ffwll.local>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>, Du Cheng <ducheng2@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Zheyu Ma <zheyuma97@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Claudio Suarez <cssk@net-c.es>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Guenter Roeck <linux@roeck-us.net>
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
 <20220131210552.482606-17-daniel.vetter@ffwll.ch>
 <Yf2EcGxoXz5HWD6O@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yf2EcGxoXz5HWD6O@ravnborg.org>
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

On Fri, Feb 04, 2022 at 08:54:24PM +0100, Sam Ravnborg wrote:
> Hi Daniel.
> 
> On Mon, Jan 31, 2022 at 10:05:47PM +0100, Daniel Vetter wrote:
> > Ideally console_lock becomes an implementation detail of fbcon.c and
> > doesn't show up anywhere in fbmem.c. We're still pretty far from that,
> > but at least the register/unregister code is there now.
> > 
> > With this the do_fb_ioctl() handler is the only code in fbmem.c still
> > calling console_lock().
> > 
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: Du Cheng <ducheng2@gmail.com>
> > Cc: Claudio Suarez <cssk@net-c.es>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Zheyu Ma <zheyuma97@gmail.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Zhen Lei <thunder.leizhen@huawei.com>
> > Cc: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> 
> Like how lock_console is now almost local to fbcon.
> Except the usage outside fbmem + fbcon taht is.

Yeah that's the goal. The problem is that moving console_lock for the
remaining fb_pan and fb_set_var calls will mean we need to put
lock_fbinfo() calls into fbcon.c, and right now that's just not
impossible. The FIXME update at the end of the series tries to explain
this a bit more.
-Daniel

> 
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> 
> > ---
> >  drivers/video/fbdev/core/fbcon.c | 33 ++++++++++++++++++++++++++------
> >  drivers/video/fbdev/core/fbmem.c | 23 ++--------------------
> >  2 files changed, 29 insertions(+), 27 deletions(-)
> > 
> > diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> > index 11b9f962af6f..e5e8aaf6f60d 100644
> > --- a/drivers/video/fbdev/core/fbcon.c
> > +++ b/drivers/video/fbdev/core/fbcon.c
> > @@ -2776,10 +2776,12 @@ void fbcon_fb_unbind(struct fb_info *info)
> >  	int i, new_idx = -1;
> >  	int idx = info->node;
> >  
> > -	WARN_CONSOLE_UNLOCKED();
> > +	console_lock();
> >  
> > -	if (!fbcon_has_console_bind)
> > +	if (!fbcon_has_console_bind) {
> > +		console_unlock();
> >  		return;
> > +	}
> >  
> >  	for (i = first_fb_vc; i <= last_fb_vc; i++) {
> >  		if (con2fb_map[i] != idx &&
> > @@ -2814,6 +2816,8 @@ void fbcon_fb_unbind(struct fb_info *info)
> >  		}
> >  		fbcon_unbind();
> >  	}
> > +
> > +	console_unlock();
> >  }
> >  
> >  /* called with console_lock held */
> > @@ -2821,10 +2825,12 @@ void fbcon_fb_unregistered(struct fb_info *info)
> >  {
> >  	int i, idx;
> >  
> > -	WARN_CONSOLE_UNLOCKED();
> > +	console_lock();
> >  
> > -	if (deferred_takeover)
> > +	if (deferred_takeover) {
> > +		console_unlock();
> >  		return;
> > +	}
> >  
> >  	idx = info->node;
> >  	for (i = first_fb_vc; i <= last_fb_vc; i++) {
> > @@ -2853,6 +2859,7 @@ void fbcon_fb_unregistered(struct fb_info *info)
> >  
> >  	if (!num_registered_fb)
> >  		do_unregister_con_driver(&fb_con);
> > +	console_unlock();
> >  }
> >  
> >  void fbcon_remap_all(struct fb_info *info)
> > @@ -2910,19 +2917,27 @@ static inline void fbcon_select_primary(struct fb_info *info)
> >  }
> >  #endif /* CONFIG_FRAMEBUFFER_DETECT_PRIMARY */
> >  
> > +static bool lockless_register_fb;
> > +module_param_named_unsafe(lockless_register_fb, lockless_register_fb, bool, 0400);
> > +MODULE_PARM_DESC(lockless_register_fb,
> > +	"Lockless framebuffer registration for debugging [default=off]");
> > +
> >  /* called with console_lock held */
> >  int fbcon_fb_registered(struct fb_info *info)
> >  {
> >  	int ret = 0, i, idx;
> >  
> > -	WARN_CONSOLE_UNLOCKED();
> > +	if (!lockless_register_fb)
> > +		console_lock();
> > +	else
> > +		atomic_inc(&ignore_console_lock_warning);
> >  
> >  	idx = info->node;
> >  	fbcon_select_primary(info);
> >  
> >  	if (deferred_takeover) {
> >  		pr_info("fbcon: Deferring console take-over\n");
> > -		return 0;
> > +		goto out;
> >  	}
> >  
> >  	if (info_idx == -1) {
> > @@ -2942,6 +2957,12 @@ int fbcon_fb_registered(struct fb_info *info)
> >  		}
> >  	}
> >  
> > +out:
> > +	if (!lockless_register_fb)
> > +		console_unlock();
> > +	else
> > +		atomic_dec(&ignore_console_lock_warning);
> > +
> >  	return ret;
> >  }
> >  
> > diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> > index fd51d12f2702..904ef1250677 100644
> > --- a/drivers/video/fbdev/core/fbmem.c
> > +++ b/drivers/video/fbdev/core/fbmem.c
> > @@ -1573,14 +1573,9 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
> >  	}
> >  }
> >  
> > -static bool lockless_register_fb;
> > -module_param_named_unsafe(lockless_register_fb, lockless_register_fb, bool, 0400);
> > -MODULE_PARM_DESC(lockless_register_fb,
> > -	"Lockless framebuffer registration for debugging [default=off]");
> > -
> >  static int do_register_framebuffer(struct fb_info *fb_info)
> >  {
> > -	int i, ret;
> > +	int i;
> >  	struct fb_videomode mode;
> >  
> >  	if (fb_check_foreignness(fb_info))
> > @@ -1649,17 +1644,7 @@ static int do_register_framebuffer(struct fb_info *fb_info)
> >  	}
> >  #endif
> >  
> > -	if (!lockless_register_fb)
> > -		console_lock();
> > -	else
> > -		atomic_inc(&ignore_console_lock_warning);
> > -	ret = fbcon_fb_registered(fb_info);
> > -
> > -	if (!lockless_register_fb)
> > -		console_unlock();
> > -	else
> > -		atomic_dec(&ignore_console_lock_warning);
> > -	return ret;
> > +	return fbcon_fb_registered(fb_info);
> >  }
> >  
> >  static void unbind_console(struct fb_info *fb_info)
> > @@ -1669,9 +1654,7 @@ static void unbind_console(struct fb_info *fb_info)
> >  	if (WARN_ON(i < 0 || i >= FB_MAX || registered_fb[i] != fb_info))
> >  		return;
> >  
> > -	console_lock();
> >  	fbcon_fb_unbind(fb_info);
> > -	console_unlock();
> >  }
> >  
> >  static void unlink_framebuffer(struct fb_info *fb_info)
> > @@ -1714,9 +1697,7 @@ static void do_unregister_framebuffer(struct fb_info *fb_info)
> >  		fb_notifier_call_chain(FB_EVENT_FB_UNREGISTERED, &event);
> >  	}
> >  #endif
> > -	console_lock();
> >  	fbcon_fb_unregistered(fb_info);
> > -	console_unlock();
> >  
> >  	/* this may free fb info */
> >  	put_fb_info(fb_info);
> > -- 
> > 2.33.0

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
