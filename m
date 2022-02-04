Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DBE4AACE9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 23:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381063AbiBEWvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 17:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbiBEWvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 17:51:53 -0500
Received: from mx1.smtp.larsendata.com (mx1.smtp.larsendata.com [91.221.196.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A7FC061353
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 14:51:50 -0800 (PST)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
        by mx1.smtp.larsendata.com (Halon) with ESMTPS
        id c5bc346a-85f1-11ec-b20b-0050568c148b;
        Fri, 04 Feb 2022 19:36:39 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sam@ravnborg.org)
        by mail01.mxhotel.dk (Postfix) with ESMTPSA id DD5A1194B91;
        Fri,  4 Feb 2022 20:35:34 +0100 (CET)
Date:   Fri, 4 Feb 2022 20:35:31 +0100
X-Report-Abuse-To: abuse@mxhotel.dk
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Du Cheng <ducheng2@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Claudio Suarez <cssk@net-c.es>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 13/21] fbcon: move more common code into fb_open()
Message-ID: <Yf2AAx9rlIsh/h8I@ravnborg.org>
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
 <20220131210552.482606-14-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131210552.482606-14-daniel.vetter@ffwll.ch>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 10:05:44PM +0100, Daniel Vetter wrote:
> No idea why con2fb_acquire_newinfo() initializes much less than
> fbcon_startup(), but so be it. From a quick look most of the
> un-initialized stuff should be fairly harmless, but who knows.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Claudio Suarez <cssk@net-c.es>
> Cc: Du Cheng <ducheng2@gmail.com>
> ---
>  drivers/video/fbdev/core/fbcon.c | 74 +++++++++++++-------------------
>  1 file changed, 31 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index b83a5a77d8a8..5a3391ff038d 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -680,8 +680,18 @@ static int fbcon_invalid_charcount(struct fb_info *info, unsigned charcount)
>  
>  #endif /* CONFIG_MISC_TILEBLITTING */
>  
> +static void fbcon_release(struct fb_info *info)
> +{
> +	if (info->fbops->fb_release)
> +		info->fbops->fb_release(info, 0);
> +
> +	module_put(info->fbops->owner);
> +}
> +
>  static int fbcon_open(struct fb_info *info)
>  {
> +	struct fbcon_ops *ops;
> +
>  	if (!try_module_get(info->fbops->owner))
>  		return -ENODEV;
>  
> @@ -691,19 +701,22 @@ static int fbcon_open(struct fb_info *info)
>  		return -ENODEV;
>  	}
>  
> -	return 0;
> -}
> +	ops = kzalloc(sizeof(struct fbcon_ops), GFP_KERNEL);
> +	if (!ops) {
> +		fbcon_release(info);
> +		return -ENOMEM;
> +	}
>  
> -static void fbcon_release(struct fb_info *info)
> -{
> -	if (info->fbops->fb_release)
> -		info->fbops->fb_release(info, 0);
> +	INIT_DELAYED_WORK(&ops->cursor_work, fb_flashcursor);
> +	ops->info = info;
> +	info->fbcon_par = ops;
> +	ops->cur_blink_jiffies = HZ / 5;
>  
> -	module_put(info->fbops->owner);
> +	return 0;
>  }
>  
>  static int con2fb_acquire_newinfo(struct vc_data *vc, struct fb_info *info,
> -				  int unit, int oldidx)
> +				  int unit)
>  {
>  	struct fbcon_ops *ops = NULL;
>  	int err;
> @@ -712,27 +725,10 @@ static int con2fb_acquire_newinfo(struct vc_data *vc, struct fb_info *info,
>  	if (err)
>  		return err;
>  
> -	if (!err) {
> -		ops = kzalloc(sizeof(struct fbcon_ops), GFP_KERNEL);
> -		if (!ops)
> -			err = -ENOMEM;
> -
> -		INIT_DELAYED_WORK(&ops->cursor_work, fb_flashcursor);
> -	}
> -
> -	if (!err) {
> -		ops->cur_blink_jiffies = HZ / 5;
> -		ops->info = info;
> -		info->fbcon_par = ops;
> -
> -		if (vc)
> -			set_blitting_type(vc, info);
> -	}
> +	ops = info->fbcon_par;
>  
> -	if (err) {
> -		con2fb_map[unit] = oldidx;
> -		fbcon_release(info);
> -	}
> +	if (vc)
> +		set_blitting_type(vc, info);
>  
>  	return err;
>  }
> @@ -840,9 +836,11 @@ static int set_con2fb_map(int unit, int newidx, int user)
>  
>  	found = search_fb_in_map(newidx);
>  
> -	con2fb_map[unit] = newidx;
> -	if (!err && !found)
> -		err = con2fb_acquire_newinfo(vc, info, unit, oldidx);
> +	if (!err && !found) {
> +		err = con2fb_acquire_newinfo(vc, info, unit);
> +		if (!err)
> +			con2fb_map[unit] = newidx;
> +	}
This looks like an unintentional change of functionality as con2fb_map[unit] is
only assigned when we do a con2fb_acquire_newinfo().

Staring at the code I could not say it is wrong, but not nice to hide
the change in this patch.

	Sam


>  
>  	/*
>  	 * If old fb is not mapped to any of the consoles,
> @@ -939,20 +937,10 @@ static const char *fbcon_startup(void)
>  	if (fbcon_open(info))
>  		return NULL;
>  
> -	ops = kzalloc(sizeof(struct fbcon_ops), GFP_KERNEL);
> -	if (!ops) {
> -		fbcon_release(info);
> -		return NULL;
> -	}
> -
> -	INIT_DELAYED_WORK(&ops->cursor_work, fb_flashcursor);
> -
> +	ops = info->fbcon_par;
>  	ops->currcon = -1;
>  	ops->graphics = 1;
>  	ops->cur_rotate = -1;
> -	ops->cur_blink_jiffies = HZ / 5;
> -	ops->info = info;
> -	info->fbcon_par = ops;
>  
>  	p->con_rotate = initial_rotation;
>  	if (p->con_rotate == -1)
> @@ -1022,7 +1010,7 @@ static void fbcon_init(struct vc_data *vc, int init)
>  		return;
>  
>  	if (!info->fbcon_par)
> -		con2fb_acquire_newinfo(vc, info, vc->vc_num, -1);
> +		con2fb_acquire_newinfo(vc, info, vc->vc_num);
>  
>  	/* If we are not the first console on this
>  	   fb, copy the font from that console */
> -- 
> 2.33.0
