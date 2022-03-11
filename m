Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0A44D6AA6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiCKWvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 17:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiCKWur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 17:50:47 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AC023D036
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 14:32:07 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id qa43so21821630ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 14:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oImblYsWVMGS5zQ1ePppQmmiYR91J0cAmcAcM48NpcI=;
        b=BaIqFmBKr8M3m70S+XXZ+EK/lp61e4SxKkFzvYgGOAMCqZ62uQhxJc0a0eJRAcsRDZ
         6XgQyQti/ldlLBGCz5rTVteS7sXgX8UEe7vq0E+ofzVKR85UMClwc+Kd6rwHVGWxzJkQ
         UPyR/daTal0IWwV/faCbCO/cI9R+ef3bLTOOwYmU57JORRTmFNIb97c/9ewKfmDrcrjS
         wBR9Ia5Op6N4lfye4lLq4ziPdfZWHDVoJHK+0zm2Tl3Jy6FqW+ifaxp52Zo7BMJuXlZM
         5TrqFdjBivg9HPYoH6WzzwonQl7aroWvbKBIY3v08ODzxt4RqqDDmNsXjdTQ4WYvrZUA
         TLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oImblYsWVMGS5zQ1ePppQmmiYR91J0cAmcAcM48NpcI=;
        b=gQ3okgqPpB7KU8U9Sk50a130i/NOF3V1V65WcrIVKKUkr69zmllOxcoYEuKpR06YJx
         VS601n8SkCayPykzrz1obyZnKlmpZUVr9BfT9s886998zA7zb4u+yWuhmTkhTeGHNFE7
         aU7icp6Wmk0tIrqrYaMRX4R5aCLduC3FYVITsO9R+Vr2/NHjRjugVmz6kBDhGLMpW8Hn
         jAa/JfRbnCwVkXPRvXEYc8P5JtE73b2xy9Jh9crWj8rA/FRDeDbR5j0a1vlQG/GPDD+C
         0jZmHV0Isu2qBytbMeoYN0btjz9P09rxLOT/gTx74NO5C2B22gb//JabvayZUK5K6LMp
         Prug==
X-Gm-Message-State: AOAM532nCImcNxXtPGYv/tjXD/X6yJ9hUb6ejL/eXf/bKripK7AgVTX4
        CqPeGMc07XNEyl1r7Tnd0yl1dBf7mIxrIxCkUPLjQpWlHw==
X-Google-Smtp-Source: ABdhPJyWZ5aNzu/C+Tv46rBVFwOppvij1Tsq5Wb6owJWam9upz7UNT/kuEZFR5xQPSh3XaZxX4DQpJCXtDxrawj2CPQ=
X-Received: by 2002:a17:907:1b09:b0:6d8:faa8:4a06 with SMTP id
 mp9-20020a1709071b0900b006d8faa84a06mr10170156ejc.701.1647036043563; Fri, 11
 Mar 2022 14:00:43 -0800 (PST)
MIME-Version: 1.0
References: <20220311174741.250424-1-mic@digikod.net> <20220311174741.250424-2-mic@digikod.net>
In-Reply-To: <20220311174741.250424-2-mic@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 11 Mar 2022 17:00:32 -0500
Message-ID: <CAHC9VhThwFbO83D8u09XmRRvQxft7fHZ+KPciGfmrBJNZA1wGQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] certs: Remove panic() calls from blacklist_init()
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 12:47 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>=
 wrote:
> From: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
>
> Replace panic() calls from device_initcall(blacklist_init) with proper
> error handling using -ENODEV.
>
> Suggested-by: Jarkko Sakkinen <jarkko@kernel.org> [1]
> Link: https://lore.kernel.org/r/Yik0C2t7G272YZ73@iki.fi [1]
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> Link: https://lore.kernel.org/r/20220311174741.250424-2-mic@digikod.net
> ---
>  certs/blacklist.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)

I'm not sure we can safely rely on a non-zero error code saving us in
the care of failure, can we?

The blacklist_init() function is registered as an initcall via
device_initcall() which I believe is either executed via
do_init_module() in the case of a dynamic module load, or via
do_initcalls() if built into the kernel.  In either case the result is
that the module/functionality doesn't load and the kernel continues on
executing.  While this could be acceptable for some non-critical
modules, if this particular module fails to load it defeats the
certificate/key based deny list for signed modules, yes?

I completely understand the strong desire to purge the kernel of
panic()s, BUG()s, and the like, but if a critical piece of security
functionality that users expect to be present fails to initialize,
panic()ing is likely the right thing to do.

> diff --git a/certs/blacklist.c b/certs/blacklist.c
> index 486ce0dd8e9c..ea7a77f156da 100644
> --- a/certs/blacklist.c
> +++ b/certs/blacklist.c
> @@ -313,12 +313,16 @@ static int __init blacklist_init(void)
>         const char *const *bl;
>         struct key_restriction *restriction;
>
> -       if (register_key_type(&key_type_blacklist) < 0)
> -               panic("Can't allocate system blacklist key type\n");
> +       if (register_key_type(&key_type_blacklist) < 0) {
> +               pr_err("Can't allocate system blacklist key type\n");
> +               return -ENODEV;
> +       }
>
>         restriction =3D kzalloc(sizeof(*restriction), GFP_KERNEL);
> -       if (!restriction)
> -               panic("Can't allocate blacklist keyring restriction\n");
> +       if (!restriction) {
> +               pr_err("Can't allocate blacklist keyring restriction\n");
> +               goto err_restriction;
> +       }
>         restriction->check =3D restrict_link_for_blacklist;
>
>         blacklist_keyring =3D
> @@ -333,13 +337,24 @@ static int __init blacklist_init(void)
>                               , KEY_ALLOC_NOT_IN_QUOTA |
>                               KEY_ALLOC_SET_KEEP,
>                               restriction, NULL);
> -       if (IS_ERR(blacklist_keyring))
> -               panic("Can't allocate system blacklist keyring\n");
> +       if (IS_ERR(blacklist_keyring)) {
> +               pr_err("Can't allocate system blacklist keyring\n");
> +               goto err_keyring;
> +       }
>
>         for (bl =3D blacklist_hashes; *bl; bl++)
>                 if (mark_raw_hash_blacklisted(*bl) < 0)
>                         pr_err("- blacklisting failed\n");
>         return 0;
> +
> +
> +err_keyring:
> +       kfree(restriction);
> +
> +err_restriction:
> +       unregister_key_type(&key_type_blacklist);
> +
> +       return -ENODEV;
>  }

--=20
paul-moore.com
