Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B559D4B140A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 18:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245126AbiBJRUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 12:20:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245113AbiBJRUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:20:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D154DE72
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 09:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644513631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SVIUy3YEzbIOwDBGTHyt0++Vn4z6UjSjAvlypOu8m5g=;
        b=DkSvr80uFfoP+XkgSdngUQqbXZLpGeONyq1Nt/hTwuzV4TYbWbNel3XS0khFCdeu53GcZK
        ytzA706Tkq41RESL65cUR2mFFeBJs3fMjdFOhyYF51gACJ3d4lGuI8wVd0xP1eJMVd/VIT
        Yc+V17F6UG1jSPAT2nFgqABqrkycaSw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-f9qRpWCWMYeHvO5yxD65wA-1; Thu, 10 Feb 2022 12:20:29 -0500
X-MC-Unique: f9qRpWCWMYeHvO5yxD65wA-1
Received: by mail-lj1-f198.google.com with SMTP id a13-20020a2e88cd000000b002386c61ffe2so2865600ljk.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 09:20:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SVIUy3YEzbIOwDBGTHyt0++Vn4z6UjSjAvlypOu8m5g=;
        b=q9ZjFL/YF4XfKr91q5ikfhgeML0BUKi0ODhbGW0R+1pbV78bzD/TdT9gNxcEwnBwBn
         uQUZwyf1rs0XXHPcDXkcPWHMervkoIsFg2cnF9byiC3CNfT8VJPR/ohG94sIcRdRb+r0
         167SJV0MNPhNRakL3MBRzZ5w/kLBQ1WdDCTYhlAGmuT9kKJ44TUa2ZjAiyvPNdRYuLA/
         LIsRKlctzzBBVpecXRJLVagI26PUoHpLHo5Q7F2VAqBxu9mPTaMTZX+88lXafCCf8g/Z
         U/ZqjVr/m0vOcpEobHHv7cTTOgikAoJBuzec8bB3iTQxBY5mJK1Jo9jWGfeht1429uIs
         AwWg==
X-Gm-Message-State: AOAM53315n4UnwBUC+wY0B391iICMf91IM2RVskTXQZYGPTudIq2mo8P
        oDk/8W2FflDbBwsMEMtmd9wXFMTMWrDT3L/5VHqoDN5Zw/F1PT+6iAaQ8EuVu6pQVVn339ZCgdW
        dLRXebyuPS92KGlhCS1Dk+qVRyBEldbP64NvyyTk=
X-Received: by 2002:a05:6512:10c2:: with SMTP id k2mr2649509lfg.118.1644513627998;
        Thu, 10 Feb 2022 09:20:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdC2WYF1MjtM0D647lyE/jFUeL6Kz6D4x3PT6XN17z8ru+VP3vWE2qW4glTva4tAxOSkk0lKTWVTsG8aBNdBs=
X-Received: by 2002:a05:6512:10c2:: with SMTP id k2mr2649499lfg.118.1644513627797;
 Thu, 10 Feb 2022 09:20:27 -0800 (PST)
MIME-Version: 1.0
References: <20220209170358.3266629-1-atomlin@redhat.com> <20220209170358.3266629-5-atomlin@redhat.com>
 <c8f97323-fcaa-5316-df79-60fd91c837aa@csgroup.eu>
In-Reply-To: <c8f97323-fcaa-5316-df79-60fd91c837aa@csgroup.eu>
From:   Aaron Tomlin <atomlin@redhat.com>
Date:   Thu, 10 Feb 2022 17:20:16 +0000
Message-ID: <CANfR36gBDrBvCRtxy2Dg+hJaoQDxAfZH1x3_JPHO2UAB-bCi6w@mail.gmail.com>
Subject: Re: [PATCH v5 04/13] module: Move livepatch support to a separate file
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
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-02-10 11:44 +0000, Christophe Leroy wrote:
> This change is wrong, build fails with it because is_livepatch_module()
> is nowhere defined.

Yes, sorry about that. This was an omission/or oversight during the rebase
attempt.

> You could move is_livepatch_module() to include/linux/livepatch.h but as
> a separate patch.

Fair enough. Albeit, I'd prefer to revert and keep is_livepatch_module()
in include/linux/module.h - this is likely the best solution.
Note: set_livepatch_module() will remain for internal use only.

> >   #else /* !CONFIG_LIVEPATCH */
> >   static inline bool is_livepatch_module(struct module *mod)
> >   {
> > diff --git a/kernel/module/Makefile b/kernel/module/Makefile
> > index 2902fc7d0ef1..ee20d864ad19 100644
> > --- a/kernel/module/Makefile
> > +++ b/kernel/module/Makefile
> > @@ -7,3 +7,6 @@ obj-$(CONFIG_MODULES) += main.o
> >   obj-$(CONFIG_MODULE_DECOMPRESS) += decompress.o
> >   obj-$(CONFIG_MODULE_SIG) += signing.o
> >   obj-$(CONFIG_MODULE_SIG_FORMAT) += signature.o
> > +ifdef CONFIG_MODULES
>
> CONFIG_LIVEPATCH depends on CONFIG_MODULES so this ifdef is not needed

Agreed.

> Checkpatch reports the following:
>
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #80:
> new file mode 100644
>
> CHECK: Comparison to NULL could be written "!mod->klp_info"
> #109: FILE: kernel/module/livepatch.c:25:
> +    if (mod->klp_info == NULL)
>
> CHECK: Comparison to NULL could be written "!mod->klp_info->sechdrs"
> #119: FILE: kernel/module/livepatch.c:35:
> +    if (mod->klp_info->sechdrs == NULL) {
>
> CHECK: Comparison to NULL could be written "!mod->klp_info->secstrings"
> #127: FILE: kernel/module/livepatch.c:43:
> +    if (mod->klp_info->secstrings == NULL) {
>
> CHECK: No space is necessary after a cast
> #142: FILE: kernel/module/livepatch.c:58:
> +    mod->klp_info->sechdrs[symndx].sh_addr = (unsigned long)
> mod->core_kallsyms.symtab;

Ok.

> Given how simple this function is, it should be a 'static inline' in
> internal.c

Agreed.

> CHECK: Alignment should match open parenthesis
> #285: FILE: kernel/module/main.c:3033:
> +    pr_err("%s: module is marked as livepatch module, but livepatch
> support is disabled",
> +        mod->name);

Fair enough.


Kind regards,

-- 
Aaron Tomlin

