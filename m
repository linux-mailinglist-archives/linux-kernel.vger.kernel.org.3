Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1C45143A7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355403AbiD2ILa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351618AbiD2IL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:11:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D43BC85B;
        Fri, 29 Apr 2022 01:08:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3AE50B832FF;
        Fri, 29 Apr 2022 08:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4278C385A7;
        Fri, 29 Apr 2022 08:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651219685;
        bh=Xa7Xt0Ya8Kk0b5uXgIAOO0Suig2iMP7lAleVMCk640Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F4M14ARdKcVCKYgdzFxCyARWutPJUhUnCFe0XHJl4l/oVP+M4EVYWaPyz332i5xGY
         WStCTUVKf1h29UDS+1ke+fuqY6xiA0Bm+yLIR8r5eeEUHSK84UeZMbEoPTdNoJV1tT
         93apX9Ta77e4/IJDWVRezc5ufDI2A6w2d185FdgtXJCddoffIrrTpKH/NMsQelZaQj
         HQTZ9DjJAKTNTBsj+ziHVYKU7Z085NZcQQ3d85VgdI0aWTE/MxGuC0BF9XfWU5VGMG
         zG0y7nbsg1sdiY/kbX4JvQiR3e517RSQpVh2VeXzT/WGObcmjflkbam0IebMzbUWSi
         Gz1nbuY5i+Guw==
Date:   Fri, 29 Apr 2022 09:07:57 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>, mauro.chehab@intel.com,
        Kai Vehmanen <kai.vehmanen@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/2] module: add a function to add module references
Message-ID: <20220429090757.1acb943a@sal.lan>
In-Reply-To: <YmuZovuDaCYDDG4c@phenom.ffwll.local>
References: <cover.1651212016.git.mchehab@kernel.org>
        <a078eb2e46d00ec59c8a91ea0afa5190730c9e58.1651212016.git.mchehab@kernel.org>
        <YmuZovuDaCYDDG4c@phenom.ffwll.local>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Em Fri, 29 Apr 2022 09:54:10 +0200
Daniel Vetter <daniel@ffwll.ch> escreveu:

> On Fri, Apr 29, 2022 at 07:31:15AM +0100, Mauro Carvalho Chehab wrote:
> > Sometimes, device drivers are bound using indirect references,
> > which is not visible when looking at /proc/modules or lsmod.
> > 
> > Add a function to allow setting up module references for such
> > cases.
> > 
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>  
> 
> This sounds like duct tape at the wrong level. We should have a
> device_link connecting these devices, and maybe device_link internally
> needs to make sure the respective driver modules stay around for long
> enough too. But open-coding this all over the place into every driver that
> has some kind of cross-driver dependency sounds terrible.
> 
> Or maybe the bug is that the snd driver keeps accessing the hw/component
> side when that is just plain gone. Iirc there's still fundamental issues
> there on the sound side of things, which have been attempted to paper over
> by timeouts and stuff like that in the past instead of enforcing a hard
> link between the snd and i915 side.

I agree with you that the device link between snd-hda and the DRM driver
should properly handle unbinding on both directions. This is something
that require further discussions with ALSA and DRM people, and we should
keep working on it.

Yet, the binding between those drivers do exist, but, despite other
similar inter-driver bindings being properly reported by lsmod, this one
is invisible for userspace.

What this series does is to make such binding visible. As simple as that.


> 
> Adding Greg for device model questions like this.
> -Daniel
> 
> > ---
> > 
> > See [PATCH 0/2] at: https://lore.kernel.org/all/cover.1651212016.git.mchehab@kernel.org/
> > 
> >  include/linux/module.h |  7 +++++++
> >  kernel/module/main.c   | 31 +++++++++++++++++++++++++++++++
> >  2 files changed, 38 insertions(+)
> > 
> > diff --git a/include/linux/module.h b/include/linux/module.h
> > index 46d4d5f2516e..be74f807e41d 100644
> > --- a/include/linux/module.h
> > +++ b/include/linux/module.h
> > @@ -596,6 +596,8 @@ static inline bool within_module(unsigned long addr, const struct module *mod)
> >  /* Search for module by name: must be in a RCU-sched critical section. */
> >  struct module *find_module(const char *name);
> >  
> > +int module_add_named_dependency(const char *name, struct module *this);
> > +
> >  /* Returns 0 and fills in value, defined and namebuf, or -ERANGE if
> >     symnum out of range. */
> >  int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
> > @@ -772,6 +774,11 @@ static inline int lookup_module_symbol_attrs(unsigned long addr, unsigned long *
> >  	return -ERANGE;
> >  }
> >  
> > +static inline int module_add_named_dependency(const char *name, struct module *this)
> > +{
> > +	return 0;
> > +}
> > +
> >  static inline int module_get_kallsym(unsigned int symnum, unsigned long *value,
> >  					char *type, char *name,
> >  					char *module_name, int *exported)
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index 05a42d8fcd7a..dbd577ccc38c 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -631,6 +631,37 @@ static int ref_module(struct module *a, struct module *b)
> >  	return 0;
> >  }
> >  
> > +int module_add_named_dependency(const char *name, struct module *this)
> > +{
> > +	struct module *mod;
> > +	int ret;
> > +
> > +	if (!name || !this || !this->name) {
> > +		return -EINVAL;
> > +	}
> > +
> > +	mutex_lock(&module_mutex);
> > +	mod = find_module(name);
> > +	if (!mod) {
> > +		ret = -EINVAL;
> > +		goto ret;
> > +	}
> > +
> > +	ret = ref_module(this, mod);
> > +	if (ret)
> > +		goto ret;
> > +
> > +#ifdef CONFIG_MODULE_UNLOAD
> > +	ret = sysfs_create_link(mod->holders_dir,
> > +				&this->mkobj.kobj, this->name);
> > +#endif
> > +
> > +ret:
> > +	mutex_unlock(&module_mutex);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(module_add_named_dependency);
> > +
> >  /* Clear the unload stuff of the module. */
> >  static void module_unload_free(struct module *mod)
> >  {
> > -- 
> > 2.35.1
> >   
> 
