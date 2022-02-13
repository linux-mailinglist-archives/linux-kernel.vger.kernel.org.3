Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5DB4B3B95
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 14:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbiBMNcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 08:32:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiBMNc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 08:32:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A3665EDF2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 05:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644759141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uOYbuLgoQrIJu9nKfMdzzauQRx2lRskPgBFfceJrL3s=;
        b=fu7YqESrPM3fhjsu3ou6FdqQeReou+eT1IVouA+eFBUxuar6lJpWZSWpLKNTOPAdn0zFPv
        l1BcSID+cQ0FSWaay8PbwDmyvhQ+fTsNfwjt/PZZGsuxSuiRQPrxjR0YgTdA/e2uvupx1u
        GOTwj9Kg3n72qyFMnah4EewgzwzXBrU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-SkjtbCdXNTmkvcyqZekI_Q-1; Sun, 13 Feb 2022 08:32:20 -0500
X-MC-Unique: SkjtbCdXNTmkvcyqZekI_Q-1
Received: by mail-lf1-f69.google.com with SMTP id 27-20020ac25f1b000000b0043edb7bf7e7so4334446lfq.20
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 05:32:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uOYbuLgoQrIJu9nKfMdzzauQRx2lRskPgBFfceJrL3s=;
        b=ZH8Fjop2gjbWWXprKoyejG843BJfJ/+QhSPRVYJutanIUz4nGdbXwmBDO17O+ZXrRg
         4BLDzV9nXAeDJ6w8R32883U38V/vGYDZLDhS+OBISgdXT+RjCxcU49kZ5mhkKmXQQlHx
         gT183HWWHeFA+v4/dvtw3JEwPv6zfaANpl3yGMVnUZaASVae+nAqnNHFcwmzt2YDwQg5
         0ZNLqDoS+hyBmy2glQSNkzcHuy9EQvZDmWPX8KlnguJWUbxj3cW5+srgZj9iQa+Mm17N
         NnT1E7DHj3VdrLsOF/rrgSpnJXJPg+nY8qrtG5cWGRE6q3czwPs+HFfcEHsCYgy1RQ5H
         tofA==
X-Gm-Message-State: AOAM531Jm7dSSX41ocAEmKRUgGuwISv3kT3drSE0NMfYBmUmQGbArRj3
        RlBBF9zS2ZddpC5RGpWmgOU7GoLDIOypmhYAzHalNtK5p7t3Km1SDHxwBusl44pPnd2fPI1E/zE
        7EbUVEGc5SCKqNUJq3pVR9KMgas/vulHRWhlBmzk=
X-Received: by 2002:a05:6512:3b91:: with SMTP id g17mr7860199lfv.79.1644759139006;
        Sun, 13 Feb 2022 05:32:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw6QOJ9OCsgrJpykyWrVf7n930ImpTeONtk7WaCfpRLimBjJcl5tAk9Gz17gF2GFtFKp8pZMQwJ6onRNh1AcA4=
X-Received: by 2002:a05:6512:3b91:: with SMTP id g17mr7860177lfv.79.1644759138845;
 Sun, 13 Feb 2022 05:32:18 -0800 (PST)
MIME-Version: 1.0
References: <20220209171118.3269581-1-atomlin@redhat.com> <6d6cbfe4-ee1a-ec5f-4249-c25ab6142668@csgroup.eu>
In-Reply-To: <6d6cbfe4-ee1a-ec5f-4249-c25ab6142668@csgroup.eu>
From:   Aaron Tomlin <atomlin@redhat.com>
Date:   Sun, 13 Feb 2022 13:32:07 +0000
Message-ID: <CANfR36hWpznfhryHtjOR8Juv_rHqF4HOg-163r_OdwY8Sfri+A@mail.gmail.com>
Subject: Re: [PATCH v5 11/13] module: Move sysfs support into a separate file
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
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-02-10 14:00 +0000, Christophe Leroy wrote:
> Checkpatch:
>
>     total: 0 errors, 2 warnings, 10 checks, 946 lines checked

Ok.

> > diff --git a/kernel/module/internal.h b/kernel/module/internal.h
> > index b67ce836746a..52d30bf6d6b0 100644
> > --- a/kernel/module/internal.h
> > +++ b/kernel/module/internal.h
> > @@ -35,6 +35,9 @@
> >   extern struct mutex module_mutex;
> >   extern struct list_head modules;
> >
> > +extern struct module_attribute *modinfo_attrs[];
> > +extern size_t modinfo_attrs_count;
>
> Can't this come in sysfs.c as well ?

No.

> > +#ifdef CONFIG_SYSFS
> > +int mod_sysfs_setup(struct module *mod, const struct load_info *info,
> > +               struct kernel_param *kparam, unsigned int num_params);
> > +void mod_sysfs_fini(struct module *mod);
> > +void module_remove_modinfo_attrs(struct module *mod, int end);
> > +void del_usage_links(struct module *mod);
> > +void init_param_lock(struct module *mod);
>
> Why don't we move mod_sysfs_teardown() here as well ?

Agreed.


Kind regards,

-- 
Aaron Tomlin

