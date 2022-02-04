Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1201C4AACF9
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 00:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381098AbiBEXKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 18:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbiBEXKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 18:10:39 -0500
Received: from mx1.smtp.larsendata.com (mx1.smtp.larsendata.com [91.221.196.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BCFC061353
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 15:10:38 -0800 (PST)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
        by mx1.smtp.larsendata.com (Halon) with ESMTPS
        id 675d5505-85f4-11ec-b20b-0050568c148b;
        Fri, 04 Feb 2022 19:55:29 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sam@ravnborg.org)
        by mail01.mxhotel.dk (Postfix) with ESMTPSA id 7D61C194BA2;
        Fri,  4 Feb 2022 20:54:27 +0100 (CET)
Date:   Fri, 4 Feb 2022 20:54:24 +0100
X-Report-Abuse-To: abuse@mxhotel.dk
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
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
Message-ID: <Yf2EcGxoXz5HWD6O@ravnborg.org>
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
 <20220131210552.482606-17-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131210552.482606-17-daniel.vetter@ffwll.ch>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel.

On Mon, Jan 31, 2022 at 10:05:47PM +0100, Daniel Vetter wrote:
> Ideally console_lock becomes an implementation detail of fbcon.c and
> doesn't show up anywhere in fbmem.c. We're still pretty far from that,
> but at least the register/unregister code is there now.
> 
> With this the do_fb_ioctl() handler is the only code in fbmem.c still
> calling console_lock().
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Du Cheng <ducheng2@gmail.com>
> Cc: Claudio Suarez <cssk@net-c.es>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Zheyu Ma <zheyuma97@gmail.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Zhen Lei <thunder.leizhen@huawei.com>
> Cc: Xiyu Yang <xiyuyang19@fudan.edu.cn>

Like how lock_console is now almost local to fbcon.
Except the usage outside fbmem + fbcon taht is.

Acked-by: Sam Ravnborg <sam@ravnborg.org>

> ---
>  drivers/video/fbdev/core/fbcon.c | 33 ++++++++++++++++++++++++++------
>  drivers/video/fbdev/core/fbmem.c | 23 ++--------------------
>  2 files changed, 29 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 11b9f962af6f..e5e8aaf6f60d 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2776,10 +2776,12 @@ void fbcon_fb_unbind(struct fb_info *info)
>  	int i, new_idx = -1;
>  	int idx = info->node;
>  
> -	WARN_CONSOLE_UNLOCKED();
> +	console_lock();
>  
> -	if (!fbcon_has_console_bind)
> +	if (!fbcon_has_console_bind) {
> +		console_unlock();
>  		return;
> +	}
>  
>  	for (i = first_fb_vc; i <= last_fb_vc; i++) {
>  		if (con2fb_map[i] != idx &&
> @@ -2814,6 +2816,8 @@ void fbcon_fb_unbind(struct fb_info *info)
>  		}
>  		fbcon_unbind();
>  	}
> +
> +	console_unlock();
>  }
>  
>  /* called with console_lock held */
> @@ -2821,10 +2825,12 @@ void fbcon_fb_unregistered(struct fb_info *info)
>  {
>  	int i, idx;
>  
> -	WARN_CONSOLE_UNLOCKED();
> +	console_lock();
>  
> -	if (deferred_takeover)
> +	if (deferred_takeover) {
> +		console_unlock();
>  		return;
> +	}
>  
>  	idx = info->node;
>  	for (i = first_fb_vc; i <= last_fb_vc; i++) {
> @@ -2853,6 +2859,7 @@ void fbcon_fb_unregistered(struct fb_info *info)
>  
>  	if (!num_registered_fb)
>  		do_unregister_con_driver(&fb_con);
> +	console_unlock();
>  }
>  
>  void fbcon_remap_all(struct fb_info *info)
> @@ -2910,19 +2917,27 @@ static inline void fbcon_select_primary(struct fb_info *info)
>  }
>  #endif /* CONFIG_FRAMEBUFFER_DETECT_PRIMARY */
>  
> +static bool lockless_register_fb;
> +module_param_named_unsafe(lockless_register_fb, lockless_register_fb, bool, 0400);
> +MODULE_PARM_DESC(lockless_register_fb,
> +	"Lockless framebuffer registration for debugging [default=off]");
> +
>  /* called with console_lock held */
>  int fbcon_fb_registered(struct fb_info *info)
>  {
>  	int ret = 0, i, idx;
>  
> -	WARN_CONSOLE_UNLOCKED();
> +	if (!lockless_register_fb)
> +		console_lock();
> +	else
> +		atomic_inc(&ignore_console_lock_warning);
>  
>  	idx = info->node;
>  	fbcon_select_primary(info);
>  
>  	if (deferred_takeover) {
>  		pr_info("fbcon: Deferring console take-over\n");
> -		return 0;
> +		goto out;
>  	}
>  
>  	if (info_idx == -1) {
> @@ -2942,6 +2957,12 @@ int fbcon_fb_registered(struct fb_info *info)
>  		}
>  	}
>  
> +out:
> +	if (!lockless_register_fb)
> +		console_unlock();
> +	else
> +		atomic_dec(&ignore_console_lock_warning);
> +
>  	return ret;
>  }
>  
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index fd51d12f2702..904ef1250677 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1573,14 +1573,9 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
>  	}
>  }
>  
> -static bool lockless_register_fb;
> -module_param_named_unsafe(lockless_register_fb, lockless_register_fb, bool, 0400);
> -MODULE_PARM_DESC(lockless_register_fb,
> -	"Lockless framebuffer registration for debugging [default=off]");
> -
>  static int do_register_framebuffer(struct fb_info *fb_info)
>  {
> -	int i, ret;
> +	int i;
>  	struct fb_videomode mode;
>  
>  	if (fb_check_foreignness(fb_info))
> @@ -1649,17 +1644,7 @@ static int do_register_framebuffer(struct fb_info *fb_info)
>  	}
>  #endif
>  
> -	if (!lockless_register_fb)
> -		console_lock();
> -	else
> -		atomic_inc(&ignore_console_lock_warning);
> -	ret = fbcon_fb_registered(fb_info);
> -
> -	if (!lockless_register_fb)
> -		console_unlock();
> -	else
> -		atomic_dec(&ignore_console_lock_warning);
> -	return ret;
> +	return fbcon_fb_registered(fb_info);
>  }
>  
>  static void unbind_console(struct fb_info *fb_info)
> @@ -1669,9 +1654,7 @@ static void unbind_console(struct fb_info *fb_info)
>  	if (WARN_ON(i < 0 || i >= FB_MAX || registered_fb[i] != fb_info))
>  		return;
>  
> -	console_lock();
>  	fbcon_fb_unbind(fb_info);
> -	console_unlock();
>  }
>  
>  static void unlink_framebuffer(struct fb_info *fb_info)
> @@ -1714,9 +1697,7 @@ static void do_unregister_framebuffer(struct fb_info *fb_info)
>  		fb_notifier_call_chain(FB_EVENT_FB_UNREGISTERED, &event);
>  	}
>  #endif
> -	console_lock();
>  	fbcon_fb_unregistered(fb_info);
> -	console_unlock();
>  
>  	/* this may free fb info */
>  	put_fb_info(fb_info);
> -- 
> 2.33.0
