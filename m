Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A596D4B2E10
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 20:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353006AbiBKT4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 14:56:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240210AbiBKT4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 14:56:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 369FF317
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644609365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2N7m7wFJBzF+1rFV+wgawzoud82P4PHi3ZJduYH5GBk=;
        b=cnDXliQ46zPGjRvUvlLjvggay9xa3F9xfjrv5JqliGMPuWG51uEDgGqo+ZpwIR2hZ2xXx2
        Uw9DX9NvHpcfDQp/7n+JqRlPtSQ53z4FWeWB9U3ZJzQonXQ4RP4GfvhZBcgm3A2vMxrr5n
        Vzw2FmuBzuiBqWsAglOWoGm+Ns2Ns18=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-gUTJ6RFvPXGy-nzaPBGvGQ-1; Fri, 11 Feb 2022 14:56:04 -0500
X-MC-Unique: gUTJ6RFvPXGy-nzaPBGvGQ-1
Received: by mail-lj1-f200.google.com with SMTP id b14-20020a2eb90e000000b00243a877827eso4399595ljb.23
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:56:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2N7m7wFJBzF+1rFV+wgawzoud82P4PHi3ZJduYH5GBk=;
        b=uQ6zzxxl1RrnasjRlR74Cj6lS4FhS32ZvzguyX3nuSzbG8oWWF1V5Pf0fVvg0iNO22
         NziSqRquuVybBbiJN/DIcxEatyPtVYGnlSzNZmoyF0zRvqId2w2MXa5Hdzekh8G3r3Rw
         s+tCLgbnH8613ocNs1mr+DNOrCG4WGiU3/saNrY+O7WYSj5nHxXO8Qth1xB2xJyYrDPB
         6f7jy+3iodwwXLptoMvP7YAHv3YRg9QUSxyxqp53UcM/ztZaWueeQ8TlT02SIhtU8hUA
         Iki3aMO44Y2LRo24O7RGf8WwRnQVSb8cA8bpZSXzIoMyCtfqtuBhO+bB3XEAfnVCVtTx
         VFbA==
X-Gm-Message-State: AOAM533A67MCOawQdb0SSZgHOJsf2Vw6gMswDi6txASXVodxyIEW4CLP
        TGEy/WqugYlcvontlO7DpdjEt1c2a7OI9zitgBMvVOOojEvIOpHupwZ5tvUARkibVHTHxsmZanb
        641VM53qvv/AbJqjjTtZKqVZZxwG41OjNegHIrlQ=
X-Received: by 2002:a05:6512:2506:: with SMTP id be6mr2257562lfb.48.1644609361904;
        Fri, 11 Feb 2022 11:56:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx81qlKPaeiBgwknTMWXeTP1En6LFF4YBNshefuwcMR5Y+XoJ6DDIRWYHSCPg+HmK9tYT0DPy6EUbZoDfYm8Os=
X-Received: by 2002:a05:6512:2506:: with SMTP id be6mr2257547lfb.48.1644609361659;
 Fri, 11 Feb 2022 11:56:01 -0800 (PST)
MIME-Version: 1.0
References: <20220209170814.3268487-1-atomlin@redhat.com> <20220209170814.3268487-3-atomlin@redhat.com>
 <1d6dde1d-e819-b659-0239-5d42ab9bd087@csgroup.eu>
In-Reply-To: <1d6dde1d-e819-b659-0239-5d42ab9bd087@csgroup.eu>
From:   Aaron Tomlin <atomlin@redhat.com>
Date:   Fri, 11 Feb 2022 19:55:49 +0000
Message-ID: <CANfR36go+eyhkX5rHDps4Re6Z2gt7MS3iGMM0vu6wEsYF1B07w@mail.gmail.com>
Subject: Re: [PATCH v5 09/13] module: Move kallsyms support into a separate file
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "cl@linux.com" <cl@linux.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "ghalat@redhat.com" <ghalat@redhat.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "void@manifault.com" <void@manifault.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-02-10 13:43 +0000, Christophe Leroy wrote:
> Checkpatch reports:
>
> total: 3 errors, 1 warnings, 26 checks, 1103 lines checked

Christophe,

> Sparse reports the following:
>
>    CHECK   kernel/module/kallsyms.c
> kernel/module/kallsyms.c:174:23: warning: incorrect type in assignment
> (different address spaces)
> kernel/module/kallsyms.c:174:23:    expected struct mod_kallsyms
> [noderef] __rcu *kallsyms
> kernel/module/kallsyms.c:174:23:    got void *


Thanks once again for your review and feedback!

Indeed I can see the same via 'make C=2 kernel/module/'. Looking at struct
'module' declaration we see that field namely "kallsyms" has the __rcu
marker. So, If I understand correctly, perhaps this can be resolved as
follows, to be more explicit:

@@ -171,7 +171,7 @@ void add_kallsyms(struct module *mod, const struct
load_info *info)
        Elf_Shdr *symsec = &info->sechdrs[info->index.sym];

        /* Set up to point into init section. */
-       mod->kallsyms = mod->init_layout.base + info->mod_kallsyms_init_off;
+       mod->kallsyms = (struct mod_kallsyms __rcu
*)mod->init_layout.base + info->mod_kallsyms_init_off;


> kernel/module/kallsyms.c:176:12: warning: dereference of noderef expression
> kernel/module/kallsyms.c:177:12: warning: dereference of noderef expression
> kernel/module/kallsyms.c:179:12: warning: dereference of noderef expression
> kernel/module/kallsyms.c:180:12: warning: dereference of noderef expression
> kernel/module/kallsyms.c:189:18: warning: dereference of noderef expression
> kernel/module/kallsyms.c:190:35: warning: dereference of noderef expression
> kernel/module/kallsyms.c:191:20: warning: dereference of noderef expression
> kernel/module/kallsyms.c:196:32: warning: dereference of noderef expression
> kernel/module/kallsyms.c:199:45: warning: dereference of noderef expression

I will use rcu_dereference*() for the above since the pointer should not be
accessed directly.

> >
> > diff --git a/kernel/module/Makefile b/kernel/module/Makefile
> > index 62c9fc91d411..868b13c06920 100644
> > --- a/kernel/module/Makefile
> > +++ b/kernel/module/Makefile
> > @@ -12,4 +12,5 @@ obj-$(CONFIG_LIVEPATCH) += livepatch.o
> >   obj-$(CONFIG_MODULES_TREE_LOOKUP) += tree_lookup.o
> >   obj-$(CONFIG_STRICT_MODULE_RWX) += strict_rwx.o
> >   obj-$(CONFIG_DEBUG_KMEMLEAK) += debug_kmemleak.o
> > +obj-$(CONFIG_KALLSYMS) += kallsyms.o
> >   endif
> > diff --git a/kernel/module/internal.h b/kernel/module/internal.h
> > index 33d7befd0602..7973666452c3 100644
> > --- a/kernel/module/internal.h
> > +++ b/kernel/module/internal.h
> > @@ -69,6 +69,11 @@ struct load_info {
> >   };
> >
> >   int mod_verify_sig(const void *mod, struct load_info *info);
> > +struct module *find_module_all(const char *name, size_t len, bool even_unformed);
> > +unsigned long kernel_symbol_value(const struct kernel_symbol *sym);
>
> This function is small enought to be a 'static inline' in internal.h

Fair enough.

> > +int cmp_name(const void *name, const void *sym);
> > +long get_offset(struct module *mod, unsigned int *size, Elf_Shdr *sechdr,
> > +               unsigned int section);
>
> Having a non static function called get_offset() seems dangerous.
>
> There are already several get_offset() functions in the kernel allthough
> they are all static.
>
> It takes a struct module as an argument so it could be called
> module_get_offset()

The rename is a good idea.

> > +bool sect_empty(const Elf_Shdr *sect);
>
> sect_empty() is small enough to remain a static inline.

Yes and moved to kernel/module/internal.h.

>
> > +const char *find_kallsyms_symbol(struct module *mod, unsigned long addr,
> > +                    unsigned long *size, unsigned long *offset);
>
> This is not used outside kallsyms.c, no need to have it in internal.h

Agreed.

>
> > +#else /* !CONFIG_KALLSYMS */
> > +static inline void layout_symtab(struct module *mod, struct load_info *info) { }
> > +static inline void add_kallsyms(struct module *mod, const struct load_info *info) { }
> > +static inline char *find_kallsyms_symbol(struct module *mod, unsigned long addr,
> > +                     unsigned long *size, unsigned long *offset)
>
> This is not used outside kallsyms.c, no need to have it when
> !CONFIG_KALLSYMS

Agreed.

>
> > +{
> > +    return NULL;
> > +}
> > +#endif /* CONFIG_KALLSYMS */
> > diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
> > new file mode 100644
> > index 000000000000..ed28f6310701
> > --- /dev/null
> > +++ b/kernel/module/kallsyms.c
> > @@ -0,0 +1,502 @@
> ...
> > +
> > +/* Given a module and name of symbol, find and return the symbol's value */
> > +static unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name)
>
> This function is called from main.c, it can't be static and must be
> defined in internal.h

Agreed. This was an unfortunate oversight.

> > -static unsigned long kernel_symbol_value(const struct kernel_symbol *sym)
> > +unsigned long kernel_symbol_value(const struct kernel_symbol *sym)
>
> This function is small enought to become a 'static inline' in internal.h

Agreed.

> > +int cmp_name(const void *name, const void *sym)
>
> This function is small enought to become a 'static inline' in internal.h

Agreed.


Kind regards,

-- 
Aaron Tomlin

