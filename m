Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E9A515DB5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 15:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241961AbiD3Nlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 09:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241973AbiD3Nlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 09:41:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EA22983C;
        Sat, 30 Apr 2022 06:38:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4187DB82B82;
        Sat, 30 Apr 2022 13:38:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA220C385AA;
        Sat, 30 Apr 2022 13:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651325904;
        bh=FzJFz5nQnOEB7AB6Bbc1j8nS92uMjFglrLsFGFrMKzw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jlSMgCulySK0sR8W6lTjvw+WKsHy9h2dvPSn/5YMc2Ov1/C/vSQeLPrh3/hxq3C2S
         3IgkIw0WSNTct9hBvrXmgMyELaYee9X3mtIvkZ2yTAPC2v3ej3vzF8gFH8UU44MXbw
         KAqWgwhvW5Kb+28/T9aQZOdeMKDQxhCoyaDM5Rc4HmIJ7hWl19h6P1Gfv/gEy6VuWa
         AFwi7dJptexzaE2VQYSiaVEgvKpTyAV4wyKOTlFHh6sphvpGPBihxxB6k6TaJew2RL
         kkHhZDiMzx49PBfmL29bVUZATY3SHGlyUfdYempi/ByrrXPMeyQ9uc+WWBkNDMAlQp
         uxkJBLqr/FN2w==
Date:   Sat, 30 Apr 2022 14:38:14 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
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
Message-ID: <20220430143814.7184bd93@sal.lan>
In-Reply-To: <Ym0l6yeTWCCAeww8@kroah.com>
References: <cover.1651314499.git.mchehab@kernel.org>
        <3c7547d551558c9da02038dda45992f91b1f5141.1651314499.git.mchehab@kernel.org>
        <Ym0l6yeTWCCAeww8@kroah.com>
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

Em Sat, 30 Apr 2022 14:04:59 +0200
Greg KH <gregkh@linuxfoundation.org> escreveu:

> On Sat, Apr 30, 2022 at 11:30:58AM +0100, Mauro Carvalho Chehab wrote:

> Did you run checkpatch on this?  Please do :)
> 
> > +
> > +	if (mod == this)
> > +		return 0;  
> 
> How can this happen?
> When people mistakenly call try_module_get(THIS_MODULE)?  

Yes. There are lots of place where this is happening:

	$ git grep try_module_get\(THIS_MODULE|wc -l
	82

> We should
> throw up a big warning when that happens anyway as that's always wrong.
> 
> But that's a different issue from this change, sorry for the noise.

It sounds very weird to use try_module_get(THIS_MODULE).

We could add a WARN_ON() there - or something similar - but I would do it 
on a separate patch.

> 
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
> 
> Meta comment, why do we only create links if we can unload things?

Good question. I don't know for certain. This is the already existing 
pattern at add_usage_links() - see kernel/module/sysfs.c.

Also, lsmod uses sysfs links when showing dependencies.

Regards,
Mauro

