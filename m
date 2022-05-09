Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857A1520309
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 18:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239341AbiEIRAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 13:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239330AbiEIRA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 13:00:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2876654000;
        Mon,  9 May 2022 09:56:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B888E614F5;
        Mon,  9 May 2022 16:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFCA4C385B1;
        Mon,  9 May 2022 16:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652115387;
        bh=NT/NSm+ixv4NTnm+bzYUbh8NWftsy0GkupiwFftUrCw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EtvoF8IpfrUKSdvwW8V1qeHxhWfkW598IrjNsAqteSHaADCcEdw4x8KXDr3TbpGco
         +yggH/xodb4xZyPEnEeIc8mWLqDjS4iXNJXSCuBQpOQ/fSanq8ns6RptBh90cQlffa
         ZydWP2ygHERY2FiBF7EYP2PUX0oJed77PI+PtGtAug8JPiOmVIAJvSdJSVF0l2WgT3
         wW5f+Mu+92KTr/DOaR7Nqi5mZ7fd/NZ7bLFFprVwVSRAaFOoxIjPeDgJTM5EOXSyV1
         crJcVua2rcdRuwnbPejGtAvrTv7VAS/uq+3pJDH8Q5DUtKss9HWmbgKe7fxadeJAws
         EJ34J+Ehy52jg==
Date:   Mon, 9 May 2022 18:56:20 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Andi Shyti <andi.shyti@linux.intel.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, alsa-devel@alsa-project.org,
        mauro.chehab@linux.intel.com, David Airlie <airlied@linux.ie>,
        Greg KH <gregkh@linuxfoundation.org>,
        intel-gfx@lists.freedesktop.org,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Takashi Iwai <tiwai@suse.com>, dri-devel@lists.freedesktop.org,
        Jaroslav Kysela <perex@perex.cz>,
        Kai Vehmanen <kai.vehmanen@intel.com>,
        linux-modules@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
Subject: Re: [Intel-gfx] [PATCH v5 1/2] module: update dependencies at
 try_module_get()
Message-ID: <20220509185620.05567716@coco.lan>
In-Reply-To: <YnRDIfthGJXdY23h@intel.intel>
References: <cover.1651348913.git.mchehab@kernel.org>
        <ad2a9fe66cf502e2e2e2325f1f04d0fae36aa82b.1651348913.git.mchehab@kernel.org>
        <YnRDIfthGJXdY23h@intel.intel>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 5 May 2022 23:35:29 +0200
Andi Shyti <andi.shyti@linux.intel.com> escreveu:

> Hi Mauro,
> 
> [...]
> 
> > +static int ref_module_dependency(struct module *mod, struct module *this)
> > +{
> > +	int ret;
> > +
> > +	if (!this || !this->name)
> > +		return -EINVAL;
> > +
> > +	if (mod == this)
> > +		return 0;
> > +
> > +	mutex_lock(&module_mutex);
> > +
> > +	ret = ref_module(this, mod);
> > +
> > +#ifdef CONFIG_MODULE_UNLOAD
> > +	if (ret)
> > +		goto ret;
> > +
> > +	ret = sysfs_create_link(mod->holders_dir,
> > +				&this->mkobj.kobj, this->name);
> > +#endif
> > +
> > +ret:
> > +	mutex_unlock(&module_mutex);
> > +	return ret;
> > +}
> > +
> >  /* Clear the unload stuff of the module. */
> >  static void module_unload_free(struct module *mod)
> >  {
> > @@ -841,24 +886,16 @@ void __module_get(struct module *module)
> >  }
> >  EXPORT_SYMBOL(__module_get);
> >  
> > -bool try_module_get(struct module *module)
> > +bool try_module_get_owner(struct module *module, struct module *this)
> >  {
> > -	bool ret = true;
> > +	int ret = __try_module_get(module);
> >  
> > -	if (module) {
> > -		preempt_disable();
> > -		/* Note: here, we can fail to get a reference */
> > -		if (likely(module_is_live(module) &&
> > -			   atomic_inc_not_zero(&module->refcnt) != 0))
> > -			trace_module_get(module, _RET_IP_);
> > -		else
> > -			ret = false;
> > +	if (ret)
> > +		ref_module_dependency(module, this);  
> 
> do we care about the return value here?

I don't think it should care about the return value, as a failure to
create a sysfs node for the holder or to add it to the holders list
is not fatal: modules can still continue working without that.

Also, I opted to be conservative here: currently, not creating these
doesn't cause try_module_get() to fail. I'm not sure what would be the
impact if this starts to fail.

So, right now, I'm opting to just ignore the return value. Perhaps
in the future this could a warning (similarly to what sysfs create
link does).

Regards,
Mauro

> 
> Andi
> 
> >  
> > -		preempt_enable();
> > -	}
> >  	return ret;
> >  }
> > -EXPORT_SYMBOL(try_module_get);
> > +EXPORT_SYMBOL(try_module_get_owner);
> >  
> >  void module_put(struct module *module)
> >  {
> > -- 
> > 2.35.1  



Thanks,
Mauro
