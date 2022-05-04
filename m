Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29271519ACA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346962AbiEDIzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346938AbiEDIxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:53:54 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8A62613B
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:49:46 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z19so911753edx.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 01:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=XXrjEm2wIrBddPNT8DRElEMfxh0MzkztaH2UgBD/RaY=;
        b=efE5YHtoUUJxgkMLw6aJY/tO1Sbsm/gyrBiwHtax5k21PegImsGITrNG8wnJx1I8Wx
         JEzYO6eWqZBNTPlO4jqHXUEvMinO76P3PsI58d1/hufLNbsyGLjvtAY+TUsFKAhb/MMo
         kpWR+sw+6y61D5IGtM9/mNtird2IBxuTVBTn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=XXrjEm2wIrBddPNT8DRElEMfxh0MzkztaH2UgBD/RaY=;
        b=U3pEZF/z91Da3Hoa2RUegvmYpG10dn0jdL/dh6c7chU/7rXpVWPmKek+rV6HcIY38U
         96V3e+0XSllgXErqmQruMiT4KNFSdlDZuxIaBhZXs9HIBmhgw5Wcv9d0UtWLlIU3eaHf
         emePY16G+h3Enu6sGkIvzrUL2519flMsXXTITjidJyoRj5vwlyBF1Vqmnq0vfG+z+4jt
         XTRFVobpLqJpgeaBkyGIAG5YnCTmlSLOvQrc/kwNbGFXThBkRe/YfUfNBohCxpcdEVq6
         01AwtFQ+syHQ7wWtworUMfGAGBZIFB9FnweYmFlYN/CIvuOwQGIBfyE/rNzYE0+7BYcY
         t78Q==
X-Gm-Message-State: AOAM530UNI6eqHX1ikFJdM+iD6/WSUvOeyuEiNoYQM8YZgcIWbE5yuDJ
        FnEbdv8MlVlujSDA/+35Dd2AoA==
X-Google-Smtp-Source: ABdhPJzDxtt75yICh75Xfe3J/PRTpYBjGupKxzPWB5UB481q/1zFzLaBZ6sskEhMuC4ZJGYQgKLdcw==
X-Received: by 2002:a05:6402:1e8d:b0:426:9:6ec with SMTP id f13-20020a0564021e8d00b00426000906ecmr22255316edf.55.1651654184780;
        Wed, 04 May 2022 01:49:44 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id el10-20020a170907284a00b006f3ef214e32sm5433599ejc.152.2022.05.04.01.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 01:49:44 -0700 (PDT)
Date:   Wed, 4 May 2022 10:49:42 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Luis Chamberlain <mcgrof@kernel.org>, mauro.chehab@intel.com,
        Kai Vehmanen <kai.vehmanen@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/2] module: add a function to add module references
Message-ID: <YnI+Ji+EwLLUhq9T@phenom.ffwll.local>
Mail-Followup-To: Greg KH <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>, mauro.chehab@intel.com,
        Kai Vehmanen <kai.vehmanen@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Dan Williams <dan.j.williams@intel.com>
References: <cover.1651212016.git.mchehab@kernel.org>
 <a078eb2e46d00ec59c8a91ea0afa5190730c9e58.1651212016.git.mchehab@kernel.org>
 <YmuZovuDaCYDDG4c@phenom.ffwll.local>
 <20220429090757.1acb943a@sal.lan>
 <YmuiKcHgl+nABvo/@kroah.com>
 <20220429101503.4048db5b@sal.lan>
 <Ymu5f8EjdC1Mawzt@kroah.com>
 <20220429112351.0e044950@sal.lan>
 <Ymu/keaggU6Uajom@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ymu/keaggU6Uajom@kroah.com>
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

On Fri, Apr 29, 2022 at 12:36:01PM +0200, Greg KH wrote:
> On Fri, Apr 29, 2022 at 11:23:51AM +0100, Mauro Carvalho Chehab wrote:
> > Em Fri, 29 Apr 2022 12:10:07 +0200
> > Greg KH <gregkh@linuxfoundation.org> escreveu:
> > 
> > > On Fri, Apr 29, 2022 at 10:15:03AM +0100, Mauro Carvalho Chehab wrote:
> > > > HI Greg,
> > > > 
> > > > Em Fri, 29 Apr 2022 10:30:33 +0200
> > > > Greg KH <gregkh@linuxfoundation.org> escreveu:
> > > >   
> > > > > On Fri, Apr 29, 2022 at 09:07:57AM +0100, Mauro Carvalho Chehab wrote:  
> > > > > > Hi Daniel,
> > > > > > 
> > > > > > Em Fri, 29 Apr 2022 09:54:10 +0200
> > > > > > Daniel Vetter <daniel@ffwll.ch> escreveu:
> > > > > >     
> > > > > > > On Fri, Apr 29, 2022 at 07:31:15AM +0100, Mauro Carvalho Chehab wrote:    
> > > > > > > > Sometimes, device drivers are bound using indirect references,
> > > > > > > > which is not visible when looking at /proc/modules or lsmod.
> > > > > > > > 
> > > > > > > > Add a function to allow setting up module references for such
> > > > > > > > cases.
> > > > > > > > 
> > > > > > > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > > > > > > Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>      
> > > > > > > 
> > > > > > > This sounds like duct tape at the wrong level. We should have a
> > > > > > > device_link connecting these devices, and maybe device_link internally
> > > > > > > needs to make sure the respective driver modules stay around for long
> > > > > > > enough too. But open-coding this all over the place into every driver that
> > > > > > > has some kind of cross-driver dependency sounds terrible.
> > > > > > > 
> > > > > > > Or maybe the bug is that the snd driver keeps accessing the hw/component
> > > > > > > side when that is just plain gone. Iirc there's still fundamental issues
> > > > > > > there on the sound side of things, which have been attempted to paper over
> > > > > > > by timeouts and stuff like that in the past instead of enforcing a hard
> > > > > > > link between the snd and i915 side.    
> > > > > > 
> > > > > > I agree with you that the device link between snd-hda and the DRM driver
> > > > > > should properly handle unbinding on both directions. This is something
> > > > > > that require further discussions with ALSA and DRM people, and we should
> > > > > > keep working on it.
> > > > > > 
> > > > > > Yet, the binding between those drivers do exist, but, despite other
> > > > > > similar inter-driver bindings being properly reported by lsmod, this one
> > > > > > is invisible for userspace.
> > > > > > 
> > > > > > What this series does is to make such binding visible. As simple as that.    
> > > > > 
> > > > > It also increases the reference count, and creates a user/kernel api
> > > > > with the symlinks, right?  Will the reference count increase prevent the
> > > > > modules from now being unloadable?
> > > > >
> > > > > This feels like a very "weak" link between modules that should not be
> > > > > needed if reference counting is implemented properly (so that things are
> > > > > cleaned up in the correct order.)  
> > > > 
> > > > The refcount increment exists even without this patch, as
> > > > hda_component_master_bind() at sound/hda/hdac_component.c uses 
> > > > try_module_get() when it creates the device link.  
> > > 
> > > Ok, then why shouldn't try_module_get() be creating this link instead of
> > > having to manually do it this way again?  You don't want to have to go
> > > around and add this call to all users of that function, right?
> > 
> > Works for me, but this is not a too trivial change, as the new 
> > try_module_get() function will require two parameters, instead of one:
> > 
> > 	- the module to be referenced;
> > 	- the module which will reference it.
> > 
> > On trivial cases, one will be THIS_MODULE, but, in the specific case
> > of snd_hda, the binding is done via an ancillary routine under 
> > snd_hda_core, but the actual binding happens at snd_hda_intel.
> 
> For calls that want to increment a module reference on behalf of a
> different code segment than is calling it, create a new function so we
> can audit-the-heck out of those code paths as odds are, they are unsafe.
> 
> For the normal code path, just turn try_module_get() into a macro that
> includes THIS_MODULE as part of it like we do for the driver register
> functions (see usb_register_driver() in include/linux/usb.h as an
> example of how to do that.)
> 
> > Ok, we could add a __try_module_get() (or whatever other name that
> > would properly express what it does) with two parameters, and then
> > define try_module_get() as:
> > 
> > 	#define try_module_get(mod) __try_module_get(mod, THIS_MODULE)
> 
> Yes, that's the way forward.

This might result in some complaints because it can create module refcount
loops. Well, seemingly module refcount loops, you can break them by first
unloading the driver, and then unloading the module. Currently a lot of
folks rely on just unload the module to tear down the drivers (and all in
right order through device links and component and all that). So maybe we
want to make this some kind of weak reference, i.e. it shows up in lsmod,
but the magic teardown still works and the module isn't actually pinnned.

Either way I agree that something like this sounds like the right
approach.
-Daniel
> 
> thanks,
> 
> greg k-h

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
