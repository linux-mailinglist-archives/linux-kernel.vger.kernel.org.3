Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E32D51CB4D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 23:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386030AbiEEVjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 17:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385999AbiEEVjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 17:39:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2792813E15;
        Thu,  5 May 2022 14:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651786538; x=1683322538;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bGKPoFs3oKrceGUWOKyLUpHxG8GVrtEbDeiLw6i4OsE=;
  b=m6MhUgL6fX5ZMeg27UV7l4WMkpICqIU4xfE7syo2mpW9sEVddVg4GIyr
   IcZ144Ud+mhHYZJ2PagG29hR5EWKRv3/5DTtI1N4qkmkfk6Z29bGH8rEX
   7EVlWhrIyoCLZ7d3jSB6cYA/xAmf+wVQEKAgfacQv5CoNISKHKkFyUmiA
   fxVASzSALgeQz0pnHEsA2HEW+xDqpxJKM7QgYQ8GQ/dXpAZdCa8YTynWb
   dKxtXLZk3H9qKccPdVLlxTU7iOzzOeNzx0ztqRI8GdvAZpVEtKxAZUX6K
   XQyMegif2vC32XN0k2s8UmrfT/dckVZVmSgq3kzhujxiOkUNsOluNYHww
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="268152596"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="268152596"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 14:35:36 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="735163599"
Received: from blaesing-mobl.ger.corp.intel.com (HELO intel.com) ([10.251.218.207])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 14:35:32 -0700
Date:   Thu, 5 May 2022 23:35:29 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
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
Message-ID: <YnRDIfthGJXdY23h@intel.intel>
References: <cover.1651348913.git.mchehab@kernel.org>
 <ad2a9fe66cf502e2e2e2325f1f04d0fae36aa82b.1651348913.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad2a9fe66cf502e2e2e2325f1f04d0fae36aa82b.1651348913.git.mchehab@kernel.org>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

[...]

> +static int ref_module_dependency(struct module *mod, struct module *this)
> +{
> +	int ret;
> +
> +	if (!this || !this->name)
> +		return -EINVAL;
> +
> +	if (mod == this)
> +		return 0;
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
> +#endif
> +
> +ret:
> +	mutex_unlock(&module_mutex);
> +	return ret;
> +}
> +
>  /* Clear the unload stuff of the module. */
>  static void module_unload_free(struct module *mod)
>  {
> @@ -841,24 +886,16 @@ void __module_get(struct module *module)
>  }
>  EXPORT_SYMBOL(__module_get);
>  
> -bool try_module_get(struct module *module)
> +bool try_module_get_owner(struct module *module, struct module *this)
>  {
> -	bool ret = true;
> +	int ret = __try_module_get(module);
>  
> -	if (module) {
> -		preempt_disable();
> -		/* Note: here, we can fail to get a reference */
> -		if (likely(module_is_live(module) &&
> -			   atomic_inc_not_zero(&module->refcnt) != 0))
> -			trace_module_get(module, _RET_IP_);
> -		else
> -			ret = false;
> +	if (ret)
> +		ref_module_dependency(module, this);

do we care about the return value here?

Andi

>  
> -		preempt_enable();
> -	}
>  	return ret;
>  }
> -EXPORT_SYMBOL(try_module_get);
> +EXPORT_SYMBOL(try_module_get_owner);
>  
>  void module_put(struct module *module)
>  {
> -- 
> 2.35.1
