Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCE34B3CB8
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 19:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237667AbiBMSD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 13:03:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237654AbiBMSD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 13:03:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F3FA5C34D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 10:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644775430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MzMGv99OCi8+2Db1ZNZFSg9ybIYsKPglxX6rxpaRY6Y=;
        b=XIncsxXzvZ2aQfZK9acvXzIcOfcnC7bSdazE/8dsYtoy3PuI07QrO2WURRMGmmBv5BjrN3
        Txm5z05RCxqWYtouyDizwN8mpU8BcJ9P6QM0ilTbvleNOiKnKFl958w3eXgqql9j7SsDVN
        ZE4uR5+Ipf/3EHGSPBKQMIn+eYGUIz8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-362-ilgTA_fTPIGeYbW6kFz4_g-1; Sun, 13 Feb 2022 13:03:49 -0500
X-MC-Unique: ilgTA_fTPIGeYbW6kFz4_g-1
Received: by mail-lj1-f197.google.com with SMTP id m13-20020a2e97cd000000b0023e09d49ce4so4910896ljj.6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 10:03:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MzMGv99OCi8+2Db1ZNZFSg9ybIYsKPglxX6rxpaRY6Y=;
        b=J83vtPjZMGVJOBVTEjbrBv21Q9Fxb+Yq9mycpzrkLE8xHdmnRl6pyamEfifN9cPXk0
         ZOk+pRUtQPskOhyznKpUUk+0qm+16N9KiUqRJfDGBvT/bixsCLOvMyl1U0VNdWNrAL/0
         YXN5Hbc0F1Sh6JZF5glNYcl49jbXOtSiem1ZpmOWwMlCxw2M/QkERE/8pZZo7Dk9dcrl
         Gubtnr59aJO9qaRLje2UVzI3hzCgskBj7NdPXtgSLN49+OiUZZhV2t6BSzRaKeCcSlmY
         GcuHDtt0QFomQeHG1izt80Z0vC+BNcRcgK058Rh1GF2Dn6B+80uXzpMT2dsEEDmDd9p5
         RKWQ==
X-Gm-Message-State: AOAM533MXJrtJ/po9mv7TqCuJONHMkDIwyfv6ABlNSykBEurtqV7BOXm
        0aD9bd3oCvF7WgVelntvNni4jw5GhGMDaJQxjTYn1aCOMvgmt1fC5+5qzUjDrkd/akGhYMOXOrM
        6yVo+1AaUp2Uv++CYi9383xr8mr2cbUk2mSzfoY4=
X-Received: by 2002:a05:6512:1032:: with SMTP id r18mr8185989lfr.678.1644775427511;
        Sun, 13 Feb 2022 10:03:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwes2q5xf22MJdPcoboBes53363gO606y9zz8jO7gp+BzN+lD6OSPykVWJAaQM7JqN5TGO7fgvFg8JwEeveI28=
X-Received: by 2002:a05:6512:1032:: with SMTP id r18mr8185979lfr.678.1644775427325;
 Sun, 13 Feb 2022 10:03:47 -0800 (PST)
MIME-Version: 1.0
References: <20220209171118.3269581-1-atomlin@redhat.com> <20220209171118.3269581-3-atomlin@redhat.com>
 <14a1678f-0c56-1237-c5c7-4ca1bac4b42a@csgroup.eu>
In-Reply-To: <14a1678f-0c56-1237-c5c7-4ca1bac4b42a@csgroup.eu>
From:   Aaron Tomlin <atomlin@redhat.com>
Date:   Sun, 13 Feb 2022 18:03:36 +0000
Message-ID: <CANfR36gVY+1k7YJy0fn1z+mGv-LqEmZJSvSHXn_BFR4WC+oJrQ@mail.gmail.com>
Subject: Re: [PATCH v5 13/13] module: Move version support into a separate file
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-02-10 14:28 +0000, Christophe Leroy wrote:
>
>
> Le 09/02/2022 =C3=A0 18:11, Aaron Tomlin a =C3=A9crit :
> > No functional change.
> >
> > This patch migrates module version support out of core code into
> > kernel/module/version.c. In addition simple code refactoring to
> > make this possible.
> >
> > Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> > ---
> >   kernel/module/Makefile   |   1 +
> >   kernel/module/internal.h |  50 +++++++++++++
> >   kernel/module/main.c     | 150 +-------------------------------------=
-
> >   kernel/module/version.c  | 110 ++++++++++++++++++++++++++++
> >   4 files changed, 163 insertions(+), 148 deletions(-)
> >   create mode 100644 kernel/module/version.c
>
> Sparse reports:
>
>    CHECK   kernel/module/version.c
> kernel/module/version.c:103:6: warning: symbol 'module_layout' was not
> declared. Should it be static?

The function module_layout() does not appear to be used. So, I've decided
to remove it.

> Checkpatch:
>
>     total: 0 errors, 2 warnings, 3 checks, 337 lines checked

Ok.

> > +struct symsearch {
> > +    const struct kernel_symbol *start, *stop;
> > +    const s32 *crcs;
> > +    enum mod_license {
> > +        NOT_GPL_ONLY,
> > +        GPL_ONLY,
> > +    } license;
> > +};
>
> Why don't leave this in main.c ?

Yes, struct 'symsearch' is not used outside of kernel/module/main.c.

> > +inline int check_modstruct_version(const struct load_info *info,
> > +                      struct module *mod)
>
> inline is pointless for a non static function

This was an unfortunate oversight.

> > +inline int same_magic(const char *amagic, const char *bmagic,
> > +                 bool has_crcs)
>
> Same, not point for inline keyword here.

Agreed.


Kind regards,

--=20
Aaron Tomlin

