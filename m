Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77BB4BBD1F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbiBRQOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:14:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiBRQN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:13:57 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFAC13AA1D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:13:40 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id p14so16092075ejf.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/gwC4bHRIUcSmFZT9uFBPhpMuizFhmgAEkJI/24KZZA=;
        b=SpNNtNFHQA2/1GYEtVOybDgFDXU1mx66Kr19Or0dQymEGAZ0wnqq5mjyUFd8w7EUPl
         /gYWk/B6lqXCJqEG80bZYsW82GEccd3Ktr91AmA2V3eJhfqVerMf2Hmx/vLOlNg9sQxh
         sR8yqNV9fp++DcQlT8pIebpwYENUpToWZUjrLM2H2meQqLFdwt7cF6aW43n+n9flXoWn
         NBHNSIpaY/cHB+kjs5ExznkuFDcXuwbQtOuPd3WuxCCeHcg6cs38Jp3FPLeycSHNI8xI
         gUNOGibfvVSA7xvyTLG0388qHZcrGVTg9sZJ1/9MTyChKE4Tyz6swWaa3/GKiti41cIV
         uiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/gwC4bHRIUcSmFZT9uFBPhpMuizFhmgAEkJI/24KZZA=;
        b=mff124y02HYB3/qW0mCLHb43zISCwMLmKs6dBC5LhkANO0GWnZO/v+CgWEVs4XGvll
         Fy2KlI+szl/WhVAPa/bqwdORO7Gl34pdxwpezEuMY75xAcS0OCYmkND585p+Mr2ApRv9
         HsIOP+KQgjfZdCp1mRy+G33iwYg7kOAwGxwCTH5DcaqzKS+5ENwM03qe0o9ysaaygQqK
         EgGBT6N8RuJ4uGCKmUhYJCCxrNUv9cm8fbdv/D7QHLmEe1H/f8f7oniI4dMVMO0stS7K
         42o4PqQrilRLyy/vYe2qZKjLUtIQMCKmKxIa+s9OgMPVVZ7w+ZDZXYqhpEXTxXSZu4hm
         LxRw==
X-Gm-Message-State: AOAM530zmUR+/KnH5GqAH3CZJZB0Wke6suMm2UBtpHNIk7YEfxzrztaX
        UCMqhDPKirnDHv7S3KHdXcXoBqq5Xi6xBLyrL0wP
X-Google-Smtp-Source: ABdhPJwfLu2AVHkXTP/KsJf25nvpYv+OIT3wySs7qBTBv+dcFHrlzw5xHDR+oh7tnMLK4SVmS000xwXCiaxJ/g/3G5g=
X-Received: by 2002:a17:906:3901:b0:6b2:9fc6:9b2 with SMTP id
 f1-20020a170906390100b006b29fc609b2mr6836636eje.327.1645200818564; Fri, 18
 Feb 2022 08:13:38 -0800 (PST)
MIME-Version: 1.0
References: <20220217142133.72205-1-cgzones@googlemail.com> <20220217142133.72205-3-cgzones@googlemail.com>
In-Reply-To: <20220217142133.72205-3-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 18 Feb 2022 11:13:26 -0500
Message-ID: <CAHC9VhT77Ft4+5LmNP0dwtaeNzF+r0b=9M5vh7qA1poY9jesJA@mail.gmail.com>
Subject: Re: [PATCH 4/5] selinux: declare data arrays const
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        "David S. Miller" <davem@davemloft.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Austin Kim <austin.kim@lge.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 9:21 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The arrays for the policy capability names, the initial sid identifiers
> and the class and permission names are not changed at runtime.  Declare
> them const to avoid accidental modification.
>
> The build time script genheaders needs to be exempted, since it converts
> the entries to uppercase.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  scripts/selinux/genheaders/genheaders.c          | 2 ++
>  scripts/selinux/mdp/mdp.c                        | 4 ++--
>  security/selinux/avc.c                           | 2 +-
>  security/selinux/include/avc_ss.h                | 2 +-
>  security/selinux/include/classmap.h              | 8 +++++++-
>  security/selinux/include/initial_sid_to_string.h | 9 ++++++++-
>  security/selinux/include/policycap.h             | 2 +-
>  security/selinux/include/policycap_names.h       | 2 +-
>  security/selinux/ss/services.c                   | 4 ++--
>  9 files changed, 25 insertions(+), 10 deletions(-)

...

> diff --git a/scripts/selinux/genheaders/genheaders.c b/scripts/selinux/ge=
nheaders/genheaders.c
> index f355b3e0e968..5f7c0b7d9260 100644
> --- a/scripts/selinux/genheaders/genheaders.c
> +++ b/scripts/selinux/genheaders/genheaders.c
> @@ -15,6 +15,8 @@ struct security_class_mapping {
>         const char *perms[sizeof(unsigned) * 8 + 1];
>  };
>
> +/* Allow to convert entries in mappings to uppercase */
> +#define __SELINUX_GENHEADERS__
>  #include "classmap.h"
>  #include "initial_sid_to_string.h"

...

> diff --git a/security/selinux/include/classmap.h b/security/selinux/inclu=
de/classmap.h
> index 35aac62a662e..07ade4af85ff 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -2,6 +2,12 @@
>  #include <linux/capability.h>
>  #include <linux/socket.h>
>
> +#ifdef __SELINUX_GENHEADERS__
> +# define const_qual
> +#else
> +# define const_qual const
> +#endif
> +
>  #define COMMON_FILE_SOCK_PERMS "ioctl", "read", "write", "create", \
>      "getattr", "setattr", "lock", "relabelfrom", "relabelto", "append", =
"map"
>
> @@ -38,7 +44,7 @@
>   * Note: The name for any socket class should be suffixed by "socket",
>   *      and doesn't contain more than one substr of "socket".
>   */
> -struct security_class_mapping secclass_map[] =3D {
> +const_qual struct security_class_mapping secclass_map[] =3D {
>         { "security",
>           { "compute_av", "compute_create", "compute_member",
>             "check_context", "load_policy", "compute_relabel",

...

> diff --git a/security/selinux/include/initial_sid_to_string.h b/security/=
selinux/include/initial_sid_to_string.h
> index 5d332aeb8b6c..915283cd89bd 100644
> --- a/security/selinux/include/initial_sid_to_string.h
> +++ b/security/selinux/include/initial_sid_to_string.h
> @@ -1,5 +1,12 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -static const char *initial_sid_to_string[] =3D
> +
> +#ifdef __SELINUX_GENHEADERS__
> +# define const_qual
> +#else
> +# define const_qual const
> +#endif
> +
> +static const char *const_qual initial_sid_to_string[] =3D
>  {
>         NULL,
>         "kernel",

Thanks for this Christian.  I generally like when we can const'ify
things like this, but I'm not excited about the const_qual hack on
core SELinux kernel code to satisfy genheaders.c.  I understand why it
is needed, but I would rather clutter the genheaders.c code than the
core SELinux kernel code.  If we can't cast away the const'ification
in genheaders.c could we simply allocate duplicate arrays in
genheaders.c and store the transformed strings into the new arrays?

--=20
paul-moore.com
