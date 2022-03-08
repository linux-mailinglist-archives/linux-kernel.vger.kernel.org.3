Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0274A4D152E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346001AbiCHKwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345997AbiCHKwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:52:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DD2143490
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 02:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646736699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fGHP5u/Zbzx5j7Gfciio1oHVz6AOtI5jro8ptGHtKdI=;
        b=Zg3DndeUqWJNKnhowS59Li0F/IKyKtngexcuoTu1YjAjpLJbXnKNicXj2A2qVFa7Hk8SfE
        uFOIUKshFpeW4E0CNCEvKcr73l0649Kta97B5KSrG2Pi9X9H8abJq2zgBZMy2UVWRbL4vU
        y5qUnWz877Zaakb08ETR+mCEcynyC+Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-Ax-GgOVdPzWRJzDK4E_IYg-1; Tue, 08 Mar 2022 05:51:38 -0500
X-MC-Unique: Ax-GgOVdPzWRJzDK4E_IYg-1
Received: by mail-wm1-f72.google.com with SMTP id 10-20020a1c020a000000b0037fae68fcc2so992204wmc.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 02:51:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fGHP5u/Zbzx5j7Gfciio1oHVz6AOtI5jro8ptGHtKdI=;
        b=2B7FPCx62lnp1epl4a6Y8UF4q1sUZ47qkbP2T8F3M+d4qLR6AVVa4vIgfEXDR4LZ8+
         HpzG8FZZNugKbPVLXMaI7RS6LCQD6bL5r3i16l7+v34nmvCplHfFxn7FX7eHDY4UrOow
         vpIqB0Mg1WZc+ur+5FOmYrFnKbT9PVUGIN2VtEewKgl76jn8Ha8Eq9hUqGsBD/O38hfl
         FjiWip0CDBAX82OqetfAGl6moxore+AYyGrWixTrScZhPDQIE3wKzXiSGqlvBfnZq564
         qP8JYhwf4De0aPuBojd7a6axY0euY/buKfDOFNmYkD1Bw64fBkWUcNo7Qg8uhqU3ghPv
         HSTQ==
X-Gm-Message-State: AOAM533MUC1sXumJgccZsJ6QL5mHVDTS90mKorcoFL2JHvCsW5M1POTz
        w217BjXv/nPCsRPN7egzWS/ZN5Z1iSWGcfyIqJYb1j7CD4zf4yWvugKX6qzZROTW5LwQoZ+RISG
        VZwbwT6/aEmkSpFbOJ6XN7c4=
X-Received: by 2002:a5d:64c4:0:b0:202:29d7:2a4d with SMTP id f4-20020a5d64c4000000b0020229d72a4dmr3768574wri.624.1646736697571;
        Tue, 08 Mar 2022 02:51:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzwRhOUg7FHvhHegjJXE7PwqmhXPJn4/LEToYlVXfLbXUBneGnbrYsN4lbqVGGq08DoadiCuw==
X-Received: by 2002:a5d:64c4:0:b0:202:29d7:2a4d with SMTP id f4-20020a5d64c4000000b0020229d72a4dmr3768548wri.624.1646736697263;
        Tue, 08 Mar 2022 02:51:37 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id v14-20020a7bcb4e000000b0034492fa24c6sm1801207wmj.34.2022.03.08.02.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 02:51:36 -0800 (PST)
Date:   Tue, 8 Mar 2022 10:51:35 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "cl@linux.com" <cl@linux.com>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "pmladek@suse.com" <pmladek@suse.com>
Subject: Re: [PATCH v10 13/14] module: Move kdb module related code out of
 main kdb code
Message-ID: <20220308105135.hvs6qqfvrxkpzykx@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220307174509.2887714-1-atomlin@redhat.com>
 <20220307174741.2889588-1-atomlin@redhat.com>
 <82088b20-6129-aecc-c43c-1c78171717c4@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82088b20-6129-aecc-c43c-1c78171717c4@csgroup.eu>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-03-08 08:36 +0000, Christophe Leroy wrote:
> 
> 
> Le 07/03/2022 à 18:47, Aaron Tomlin a écrit :
> > diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> > index 0852a537dad4..f3a30cd5037f 100644
> > --- a/kernel/debug/kdb/kdb_main.c
> > +++ b/kernel/debug/kdb/kdb_main.c
> > @@ -26,7 +26,6 @@
> >   #include <linux/utsname.h>
> >   #include <linux/vmalloc.h>
> >   #include <linux/atomic.h>
> > -#include <linux/module.h>
> >   #include <linux/moduleparam.h>
> >   #include <linux/mm.h>
> >   #include <linux/init.h>
> No need of linux/module.h here anymore ?

Hi Christophe,

Correct.

> In that case, I see several other files in kernel/debug/kdb/ that 
> include linux/module.h
> 
> Should it be removed in those files as well ?

I did not review the other kernel/debug/kdb/.*c files.
Anyhow, yes it can be removed from each, since it is entirely redundant.

> > diff --git a/kernel/module/kdb.c b/kernel/module/kdb.c
> > new file mode 100644
> > index 000000000000..60baeebea3e0
> > --- /dev/null
> > +++ b/kernel/module/kdb.c
> > @@ -0,0 +1,55 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Module kdb support
> > + *
> > + * Copyright (C) 2010 Jason Wessel
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/kdb.h>
> > +#include "internal.h"
> > +
> > +/*
> > + * kdb_lsmod - This function implements the 'lsmod' command.  Lists
> > + *	currently loaded kernel modules.
> > + *	Mostly taken from userland lsmod.
> > + */
> > +int kdb_lsmod(int argc, const char **argv)
> > +{
> > +	struct module *mod;
> > +
> > +	if (argc != 0)
> > +		return KDB_ARGCOUNT;
> > +
> > +	kdb_printf("Module                  Size  modstruct     Used by\n");
> > +	list_for_each_entry(mod, &modules, list) {
> > +		if (mod->state == MODULE_STATE_UNFORMED)
> > +			continue;
> > +
> > +		kdb_printf("%-20s%8u  0x%px ", mod->name,
> > +			   mod->core_layout.size, (void *)mod);
> > +#ifdef CONFIG_MODULE_UNLOAD
> > +		kdb_printf("%4d ", module_refcount(mod));
> > +#endif
> > +		if (mod->state == MODULE_STATE_GOING)
> > +			kdb_printf(" (Unloading)");
> > +		else if (mod->state == MODULE_STATE_COMING)
> > +			kdb_printf(" (Loading)");
> > +		else
> > +			kdb_printf(" (Live)");
> > +		kdb_printf(" 0x%px", mod->core_layout.base);
> > +
> > +#ifdef CONFIG_MODULE_UNLOAD
> > +		{
> > +			struct module_use *use;
> > +			kdb_printf(" [ ");
> > +			list_for_each_entry(use, &mod->source_list,
> > +					    source_list)
> > +				kdb_printf("%s ", use->target->name);
> > +			kdb_printf("]\n");
> > +		}
> > +#endif
> 
> That's a ugly construct. Could it be a function instead that you call 
> from this loop,

Fair enough and I agree; albeit, as you know, this was simply a migration
to kernel/module/kdb.c. We could indeed address this format/or style
concern later.


> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index b8a59b5c3e3a..bcc4f7a82649 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -108,10 +108,6 @@ static void mod_update_bounds(struct module *mod)
> >   		__mod_update_bounds(mod->init_layout.base, mod->init_layout.size);
> >   }
> >   
> > -#ifdef CONFIG_KGDB_KDB
> > -struct list_head *kdb_modules = &modules; /* kdb needs the list of modules */
> 
> It should be removed from kernel/debug/kdb/kdb_private.h as well.

Agreed - this was missed.


Thanks,

-- 
Aaron Tomlin

