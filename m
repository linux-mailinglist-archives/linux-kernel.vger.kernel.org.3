Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B0F4713EF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 14:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhLKNLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 08:11:25 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:24915 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhLKNLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 08:11:24 -0500
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 1BBDAvSL022843;
        Sat, 11 Dec 2021 22:10:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 1BBDAvSL022843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1639228258;
        bh=qYDFccdAWcc4y87hz8YL2hqcW/2tJJYb/x8dUaXucUQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bqa+5YJABxL3PK4750Tpuijxc4GkiTFemUHucJs0rhr13ibJehpID+gNvtx5mCWfn
         OFyfLanYHE8PB8orWSiTm3xZtMI8vz8ZdEWGKgLGpzJCbtgthMZWnFPWzpSqfInX9z
         GHL5UP7GU7PGPY7fbNfzIRLhDPI8vyzqYxKrcQcsSotSSkbKCz2LTsMXRB7UuvQwyZ
         /gNRmGl1GPgZ3AEbEoeOYDh3hazNl+2LTtS/i5qywR26x/DPCFVseK4BdtP451gOMa
         jTwaBE+bmrrWPqmPkIzsUu79UO3AqwZoPcaPggD3od2VgpIF7/sCaovUvlCb8BhJWh
         5OoBsJOpt8BzQ==
X-Nifty-SrcIP: [209.85.215.180]
Received: by mail-pg1-f180.google.com with SMTP id j11so10398530pgs.2;
        Sat, 11 Dec 2021 05:10:58 -0800 (PST)
X-Gm-Message-State: AOAM531iZ2smHb4aicZ/IwPYFpyYGxAFwBJ2UacmtIUDYIFJslRByrC8
        sIYAnR/jb5AHSEspLTHYeTqd2CjqE39PeAo7m80=
X-Google-Smtp-Source: ABdhPJxrWUTVzJUtO2/XZiB7yRc0vSmQkxoWMxhXmEeWjYFrPCY3LGEf/+0CrD0NC0wUUafhcdAPCP0S3ySJZpW0YXI=
X-Received: by 2002:a65:50c6:: with SMTP id s6mr44883388pgp.352.1639228257267;
 Sat, 11 Dec 2021 05:10:57 -0800 (PST)
MIME-Version: 1.0
References: <20211001040126.1200230-1-masahiroy@kernel.org>
In-Reply-To: <20211001040126.1200230-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 11 Dec 2021 22:10:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNATvAFvnTte_P4PiTq-Gui5CeK_NJvtv8Q2snsfqcEAUcQ@mail.gmail.com>
Message-ID: <CAK7LNATvAFvnTte_P4PiTq-Gui5CeK_NJvtv8Q2snsfqcEAUcQ@mail.gmail.com>
Subject: Re: [PATCH] certs: move the 'depends on' to the choice of module
 signing keys
To:     keyrings@vger.kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 1, 2021 at 1:02 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> When the condition "MODULE_SIG || (IMA_APPRAISE_MODSIG && MODULES)"
> is unmet, you cannot choose anything in the choice, but the choice
> menu is still displayed in the menuconfig etc.
>
> Move the 'depends on' to the choice to hide the meaningless menu.
>
> Also delete the redundant 'default'. In a choice, the first entry is
> the default.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Applied to linux-kbuild.




>
>  certs/Kconfig | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/certs/Kconfig b/certs/Kconfig
> index ae7f2e876a31..73d1350c223a 100644
> --- a/certs/Kconfig
> +++ b/certs/Kconfig
> @@ -17,21 +17,19 @@ config MODULE_SIG_KEY
>
>  choice
>         prompt "Type of module signing key to be generated"
> -       default MODULE_SIG_KEY_TYPE_RSA
> +       depends on MODULE_SIG || (IMA_APPRAISE_MODSIG && MODULES)
>         help
>          The type of module signing key type to generate. This option
>          does not apply if a #PKCS11 URI is used.
>
>  config MODULE_SIG_KEY_TYPE_RSA
>         bool "RSA"
> -       depends on MODULE_SIG || (IMA_APPRAISE_MODSIG && MODULES)
>         help
>          Use an RSA key for module signing.
>
>  config MODULE_SIG_KEY_TYPE_ECDSA
>         bool "ECDSA"
>         select CRYPTO_ECDSA
> -       depends on MODULE_SIG || (IMA_APPRAISE_MODSIG && MODULES)
>         help
>          Use an elliptic curve key (NIST P384) for module signing. Consider
>          using a strong hash like sha256 or sha384 for hashing modules.
> --
> 2.30.2
>


-- 
Best Regards
Masahiro Yamada
