Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAE64F3E1D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 22:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382500AbiDEMPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 08:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244903AbiDEIwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:52:46 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA8F2458C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 01:45:56 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id k23so21738070ejd.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 01:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kLwOSJh4JkUAu8bAVMQPem4swoCfWHajhhsSaSbd3wA=;
        b=bMbT3uGp3dFxXv5749rP/YEH0fwf2ipBnL4qQcoZffJmqP63odGiG48c6lrEQDoOuE
         2Io2E+FIcefJqaP5UzCFcWumnT1yERlYhCUDpyrunp/zi7DwDGmp9jA4EjrBmXZPUbxe
         m4RBFNb29e21bIjfvB3+04nX0j65o9B8vbaPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=kLwOSJh4JkUAu8bAVMQPem4swoCfWHajhhsSaSbd3wA=;
        b=jrJ4CRoGI/THTp1O8nP+KhfA/x0Rq4eGzJ8+2w93iKRLFo1RdGt80MRBKGCKN+XCuB
         QuAdTKtFLT6GcFEK2/1nS8W71I30QuDj8dLcSLMPC0NzzWV1nM95iJHyXI7dr8NYNnVf
         OsHPq55PugaGHbiCGWsFGcgd6jo9cUbKYjw4R01i/uWMpMdIZ4xBXRyBDXStSPF8OfqW
         IBw2dS3yzybVZhAb+Gbd2HJqSy67DdtColzZ4puVnBbvGYvM7hYe1Xj9pqGImTbYMC7U
         j7mSsnmXoziwWYQtxM4ISB+PhQsdHbNvh223gfIQPiVkAruNgrYGGD6H/EG8vTheYjJF
         Fm0g==
X-Gm-Message-State: AOAM5318AcDWbFwD0FjZd8goDH66jKg2MTOTG7HoQMZXE9qkDxr60ApL
        TUe5Kxn8+oXAGD9FqSjkJrbrqQ==
X-Google-Smtp-Source: ABdhPJylM+dFHXlrCCet5bi78ssTO3yLx8DQZUwNTohynsB3hLO/O0NXGESroauDwjtoDMbXczTEkA==
X-Received: by 2002:a17:906:300f:b0:6e0:b38d:777d with SMTP id 15-20020a170906300f00b006e0b38d777dmr2418845ejz.189.1649148355361;
        Tue, 05 Apr 2022 01:45:55 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a22-20020a50ff16000000b00410d029ea5csm6312065edu.96.2022.04.05.01.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 01:45:54 -0700 (PDT)
Date:   Tue, 5 Apr 2022 10:45:53 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, Du Cheng <ducheng2@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Claudio Suarez <cssk@net-c.es>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2 09/19] fbcon: Extract fbcon_open/release helpers
Message-ID: <YkwBwW6E9gbL2Sut@phenom.ffwll.local>
Mail-Followup-To: Thomas Zimmermann <tzimmermann@suse.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, Du Cheng <ducheng2@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, Claudio Suarez <cssk@net-c.es>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>
References: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
 <20220208210824.2238981-10-daniel.vetter@ffwll.ch>
 <0879a2ff-37df-a9ae-0ce1-2bfcb2d1b322@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0879a2ff-37df-a9ae-0ce1-2bfcb2d1b322@suse.de>
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

On Thu, Feb 10, 2022 at 12:46:32PM +0100, Thomas Zimmermann wrote:
> Hi
> 
> Am 08.02.22 um 22:08 schrieb Daniel Vetter:
> > There's two minor behaviour changes in here:
> > - in error paths we now consistently call fb_ops->fb_release
> > - fb_release really can't fail (fbmem.c ignores it too) and there's no
> >    reasonable cleanup we can do anyway.
> > 
> > Note that everything in fbcon.c is protected by the big console_lock()
> > lock (especially all the global variables), so the minor changes in
> > ordering of setup/cleanup do not matter.
> > 
> > v2: Explain a bit better why this is all correct (Sam)
> > 
> > Acked-by: Sam Ravnborg <sam@ravnborg.org>
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Claudio Suarez <cssk@net-c.es>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Cc: Du Cheng <ducheng2@gmail.com>
> > ---
> >   drivers/video/fbdev/core/fbcon.c | 107 +++++++++++++++----------------
> >   1 file changed, 53 insertions(+), 54 deletions(-)
> > 
> > diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> > index 058e885d24f6..3e1a3e7bf527 100644
> > --- a/drivers/video/fbdev/core/fbcon.c
> > +++ b/drivers/video/fbdev/core/fbcon.c
> > @@ -682,19 +682,37 @@ static int fbcon_invalid_charcount(struct fb_info *info, unsigned charcount)
> >   #endif /* CONFIG_MISC_TILEBLITTING */
> > +static int fbcon_open(struct fb_info *info)
> > +{
> > +	if (!try_module_get(info->fbops->owner))
> > +		return -ENODEV;
> > +
> > +	if (info->fbops->fb_open &&
> > +	    info->fbops->fb_open(info, 0)) {
> > +		module_put(info->fbops->owner);
> > +		return -ENODEV;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void fbcon_release(struct fb_info *info)
> > +{
> > +	if (info->fbops->fb_release)
> > +		info->fbops->fb_release(info, 0);
> > +
> > +	module_put(info->fbops->owner);
> > +}
> >   static int con2fb_acquire_newinfo(struct vc_data *vc, struct fb_info *info,
> >   				  int unit, int oldidx)
> >   {
> >   	struct fbcon_ops *ops = NULL;
> > -	int err = 0;
> > -
> > -	if (!try_module_get(info->fbops->owner))
> > -		err = -ENODEV;
> > +	int err;
> > -	if (!err && info->fbops->fb_open &&
> > -	    info->fbops->fb_open(info, 0))
> > -		err = -ENODEV;
> > +	err = fbcon_open(info);
> > +	if (err)
> > +		return err;
> >   	if (!err) {
> >   		ops = kzalloc(sizeof(struct fbcon_ops), GFP_KERNEL);
> > @@ -715,7 +733,7 @@ static int con2fb_acquire_newinfo(struct vc_data *vc, struct fb_info *info,
> >   	if (err) {
> >   		con2fb_map[unit] = oldidx;
> > -		module_put(info->fbops->owner);
> > +		fbcon_release(info);
> >   	}
> >   	return err;
> > @@ -726,45 +744,34 @@ static int con2fb_release_oldinfo(struct vc_data *vc, struct fb_info *oldinfo,
> >   				  int oldidx, int found)
> >   {
> >   	struct fbcon_ops *ops = oldinfo->fbcon_par;
> > -	int err = 0, ret;
> > +	int ret;
> > -	if (oldinfo->fbops->fb_release &&
> > -	    oldinfo->fbops->fb_release(oldinfo, 0)) {
> > -		con2fb_map[unit] = oldidx;
> 
> We don't need oldidx any longer?
> 
> There's some logic wrt to the parameter 'found' here and in set_con2fb_map()
> that appears to be relevant.

Yeah further patches clean this up more. Or did you see a potential bug
here? I did ditch the fb_release error handling, simply because there's
not really much we can do anyway, it shouldn't ever fail (that's a driver
bug) and it was convoluting the code for no gain. But I might have missed
something in this cargo-cult.
-Daniel

> 
> Best regards
> Thomas
> 
> 
> > -		if (!found && newinfo->fbops->fb_release)
> > -			newinfo->fbops->fb_release(newinfo, 0);
> > -		if (!found)
> > -			module_put(newinfo->fbops->owner);
> > -		err = -ENODEV;
> > -	}
> > +	fbcon_release(oldinfo);
> > -	if (!err) {
> > -		fbcon_del_cursor_work(oldinfo);
> > -		kfree(ops->cursor_state.mask);
> > -		kfree(ops->cursor_data);
> > -		kfree(ops->cursor_src);
> > -		kfree(ops->fontbuffer);
> > -		kfree(oldinfo->fbcon_par);
> > -		oldinfo->fbcon_par = NULL;
> > -		module_put(oldinfo->fbops->owner);
> > -		/*
> > -		  If oldinfo and newinfo are driving the same hardware,
> > -		  the fb_release() method of oldinfo may attempt to
> > -		  restore the hardware state.  This will leave the
> > -		  newinfo in an undefined state. Thus, a call to
> > -		  fb_set_par() may be needed for the newinfo.
> > -		*/
> > -		if (newinfo && newinfo->fbops->fb_set_par) {
> > -			ret = newinfo->fbops->fb_set_par(newinfo);
> > +	fbcon_del_cursor_work(oldinfo);
> > +	kfree(ops->cursor_state.mask);
> > +	kfree(ops->cursor_data);
> > +	kfree(ops->cursor_src);
> > +	kfree(ops->fontbuffer);
> > +	kfree(oldinfo->fbcon_par);
> > +	oldinfo->fbcon_par = NULL;
> > +	/*
> > +	  If oldinfo and newinfo are driving the same hardware,
> > +	  the fb_release() method of oldinfo may attempt to
> > +	  restore the hardware state.  This will leave the
> > +	  newinfo in an undefined state. Thus, a call to
> > +	  fb_set_par() may be needed for the newinfo.
> > +	*/
> > +	if (newinfo && newinfo->fbops->fb_set_par) {
> > +		ret = newinfo->fbops->fb_set_par(newinfo);
> > -			if (ret)
> > -				printk(KERN_ERR "con2fb_release_oldinfo: "
> > -					"detected unhandled fb_set_par error, "
> > -					"error code %d\n", ret);
> > -		}
> > +		if (ret)
> > +			printk(KERN_ERR "con2fb_release_oldinfo: "
> > +				"detected unhandled fb_set_par error, "
> > +				"error code %d\n", ret);
> >   	}
> > -	return err;
> > +	return 0;
> >   }
> >   static void con2fb_init_display(struct vc_data *vc, struct fb_info *info,
> > @@ -919,7 +926,6 @@ static const char *fbcon_startup(void)
> >   	struct fbcon_display *p = &fb_display[fg_console];
> >   	struct vc_data *vc = vc_cons[fg_console].d;
> >   	const struct font_desc *font = NULL;
> > -	struct module *owner;
> >   	struct fb_info *info = NULL;
> >   	struct fbcon_ops *ops;
> >   	int rows, cols;
> > @@ -938,17 +944,12 @@ static const char *fbcon_startup(void)
> >   	if (!info)
> >   		return NULL;
> >   	
> > -	owner = info->fbops->owner;
> > -	if (!try_module_get(owner))
> > +	if (fbcon_open(info))
> >   		return NULL;
> > -	if (info->fbops->fb_open && info->fbops->fb_open(info, 0)) {
> > -		module_put(owner);
> > -		return NULL;
> > -	}
> >   	ops = kzalloc(sizeof(struct fbcon_ops), GFP_KERNEL);
> >   	if (!ops) {
> > -		module_put(owner);
> > +		fbcon_release(info);
> >   		return NULL;
> >   	}
> > @@ -3314,10 +3315,6 @@ static void fbcon_exit(void)
> >   		}
> >   		if (mapped) {
> > -			if (info->fbops->fb_release)
> > -				info->fbops->fb_release(info, 0);
> > -			module_put(info->fbops->owner);
> > -
> >   			if (info->fbcon_par) {
> >   				struct fbcon_ops *ops = info->fbcon_par;
> > @@ -3327,6 +3324,8 @@ static void fbcon_exit(void)
> >   				kfree(info->fbcon_par);
> >   				info->fbcon_par = NULL;
> >   			}
> > +
> > +			fbcon_release(info);
> >   		}
> >   	}
> >   }
> 
> -- 
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 Nürnberg, Germany
> (HRB 36809, AG Nürnberg)
> Geschäftsführer: Ivo Totev




-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
