Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3A6515CA2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 14:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241593AbiD3MIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 08:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238806AbiD3MI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 08:08:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6925C663;
        Sat, 30 Apr 2022 05:05:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BB9D60AF8;
        Sat, 30 Apr 2022 12:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9E4C385AA;
        Sat, 30 Apr 2022 12:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651320303;
        bh=tWlItz5i5kXdXuKnvQvNpU5f7HV/eMhhZ4OfG79KfB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EWPWQ/+A8KiWNeEnnCkAKXMPSezGdtzp5Pu/mRwQ/MU866OQbmFsojF7i409gTuJu
         COUJKad1RdoM48RcXRCz1/y234ep+r8F5hVv3U8qnSyXd89g/SqzfONVpSS2CCu9eN
         CMKtf9Kko8TmVqrBl0bJ24rI3PoZ2XY2ikw7YirU=
Date:   Sat, 30 Apr 2022 14:04:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jaroslav Kysela <perex@perex.cz>,
        Kai Vehmanen <kai.vehmanen@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@intel.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        mauro.chehab@linux.intel.com,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 1/2] module: update dependencies at try_module_get()
Message-ID: <Ym0l6yeTWCCAeww8@kroah.com>
References: <cover.1651314499.git.mchehab@kernel.org>
 <3c7547d551558c9da02038dda45992f91b1f5141.1651314499.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c7547d551558c9da02038dda45992f91b1f5141.1651314499.git.mchehab@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 11:30:58AM +0100, Mauro Carvalho Chehab wrote:
> Sometimes, device drivers are bound into each other via try_module_get(),
> making such references invisible when looking at /proc/modules or lsmod.
> 
> Add a function to allow setting up module references for such
> cases, and call it when try_module_get() is used.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
> 
> See [PATCH v2 0/2] at: https://lore.kernel.org/all/cover.1651314499.git.mchehab@kernel.org/
> 
>  include/linux/module.h |  4 +++-
>  kernel/module/main.c   | 35 +++++++++++++++++++++++++++++++++--
>  2 files changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 46d4d5f2516e..836851baaad4 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -620,7 +620,9 @@ extern void __module_get(struct module *module);
>  
>  /* This is the Right Way to get a module: if it fails, it's being removed,
>   * so pretend it's not there. */
> -extern bool try_module_get(struct module *module);
> +extern bool __try_module_get(struct module *module, struct module *this);
> +
> +#define try_module_get(mod) __try_module_get(mod, THIS_MODULE)
>  
>  extern void module_put(struct module *module);
>  
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 05a42d8fcd7a..9f4416381e65 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -631,6 +631,35 @@ static int ref_module(struct module *a, struct module *b)
>  	return 0;
>  }
>  
> +static int ref_module_dependency(struct module *mod,
> +				       struct module *this)

This can be on one line, right?

> +{
> +	int ret;
> +
> +	if (!this || !this->name) {
> +		return -EINVAL;
> +	}

Did you run checkpatch on this?  Please do :)

> +
> +	if (mod == this)
> +		return 0;

How can this happen?

When people mistakenly call try_module_get(THIS_MODULE)?  We should
throw up a big warning when that happens anyway as that's always wrong.

But that's a different issue from this change, sorry for the noise.

> +
> +	mutex_lock(&module_mutex);
> +
> +	ret = ref_module(this, mod);
> +
> +#ifdef CONFIG_MODULE_UNLOAD
> +	if (ret)
> +		goto ret;
> +
> +	ret = sysfs_create_link(mod->holders_dir,
> +				&this->mkobj.kobj, this->name);

Meta comment, why do we only create links if we can unload things?

thanks,

greg k-h
