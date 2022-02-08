Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195E74AE1CE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 20:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385754AbiBHTBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 14:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385780AbiBHTAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:00:47 -0500
Received: from mx2.smtp.larsendata.com (mx2.smtp.larsendata.com [91.221.196.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41EFC0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:00:45 -0800 (PST)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
        by mx2.smtp.larsendata.com (Halon) with ESMTPS
        id 90d0ca10-8911-11ec-ac19-0050568cd888;
        Tue, 08 Feb 2022 19:01:47 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sam@ravnborg.org)
        by mail01.mxhotel.dk (Postfix) with ESMTPSA id 3DFC3194B5C;
        Tue,  8 Feb 2022 20:00:41 +0100 (CET)
Date:   Tue, 8 Feb 2022 20:00:38 +0100
X-Report-Abuse-To: abuse@mxhotel.dk
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Jens Frederich <jfrederich@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-staging@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 21/21] fbdev: Make registered_fb[] private to fbmem.c
Message-ID: <YgK91i6zHWPBwYOq@ravnborg.org>
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
 <20220131210552.482606-22-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131210552.482606-22-daniel.vetter@ffwll.ch>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Mon, Jan 31, 2022 at 10:05:52PM +0100, Daniel Vetter wrote:
> Well except when the olpc dcon fbdev driver is enabled, that thing
> digs around in there in rather unfixable ways.
> 
> Cc oldc_dcon maintainers as fyi.
> 
> Cc: Jens Frederich <jfrederich@gmail.com>
> Cc: Jon Nettleton <jon.nettleton@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-staging@lists.linux.dev
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Cc: Zhen Lei <thunder.leizhen@huawei.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Cc: linux-fbdev@vger.kernel.org
> Cc: Zheyu Ma <zheyuma97@gmail.com>
> Cc: Guenter Roeck <linux@roeck-us.net>

with the build thingy fixed:
Acked-by: Sam Ravnborg <sam@ravnborg.org>

I do wonder if there is a more clean way to trigger a blank
in the main fbdev driver from the olpc driver.

The current hack is not nice and it would be good to see it gone.

	Sam

> ---
>  drivers/video/fbdev/core/fbmem.c | 8 ++++++--
>  include/linux/fb.h               | 7 +++----
>  2 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 904ef1250677..dad6572942fa 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -48,10 +48,14 @@
>  static DEFINE_MUTEX(registration_lock);
>  
>  struct fb_info *registered_fb[FB_MAX] __read_mostly;
> -EXPORT_SYMBOL(registered_fb);
> -
>  int num_registered_fb __read_mostly;
> +#if IS_ENABLED(CONFIG_OLPC_DCON)
> +EXPORT_SYMBOL(registered_fb);
>  EXPORT_SYMBOL(num_registered_fb);
> +#endif
> +#define for_each_registered_fb(i)		\
> +	for (i = 0; i < FB_MAX; i++)		\
> +		if (!registered_fb[i]) {} else
>  
>  bool fb_center_logo __read_mostly;
>  
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index a8a00d2ba1f3..e236817502c2 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -622,16 +622,15 @@ extern int fb_get_color_depth(struct fb_var_screeninfo *var,
>  extern int fb_get_options(const char *name, char **option);
>  extern int fb_new_modelist(struct fb_info *info);
>  
> +#if IS_ENABLED(CONFIG_OLPC_DCON)
>  extern struct fb_info *registered_fb[FB_MAX];
> +
>  extern int num_registered_fb;
> +#endif
>  extern bool fb_center_logo;
>  extern int fb_logo_count;
>  extern struct class *fb_class;
>  
> -#define for_each_registered_fb(i)		\
> -	for (i = 0; i < FB_MAX; i++)		\
> -		if (!registered_fb[i]) {} else
> -
>  static inline void lock_fb_info(struct fb_info *info)
>  {
>  	mutex_lock(&info->lock);
> -- 
> 2.33.0
