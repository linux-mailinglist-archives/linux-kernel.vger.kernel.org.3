Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F224B580340
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 19:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236397AbiGYRDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 13:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235198AbiGYRC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 13:02:58 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B898B1DA7B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 10:02:56 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bf9so18934147lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 10:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PwYfqMD6rfq6rjOqioZJHz+L2/HGXhIIjsdnhWmm9BU=;
        b=Vc7G4MxWVHT6/S2qsrBsiMQtsPNnSiXsjQacSVzDOZiZmwesaOSnB6/TJecUn7Jk/W
         V/JxPz/nyoQKV99wJRumG26kvizzdXt/fINIgzH63GJzztMyUSybeUAKB4+0H8oPHLud
         W3C8xJYxXctzgrcFeQqVAWCpXTHoRfyLzlth4mV/pHa3dwxLpiXVD1jEPfZF6CTE80PV
         ZP9mmW3E4xnaThGcE7XK6NX7fmV09BETnodMOAAK0Xds7Ceyg0oTC/v28fKtF1kwV7ac
         E2IOmwz5MzERTtULcoC/kSPYWKm84yGNqNrYG0MOsr/Ko4zVf0QlOZdCyPVZ5cPb9iSq
         c2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PwYfqMD6rfq6rjOqioZJHz+L2/HGXhIIjsdnhWmm9BU=;
        b=GEHzwzv8lei9tUvpdueZJsI14BhzCQoaLLZvLY0TzSpUOXvLgeKCnhGrZZLvNZEhXw
         MRnjEtF/G6Y8LVjjbhAjS7a2VRwOY8B9rm3erEFn8ewT21NQIP77Avesp6JoxKjRj+Uf
         K3QeP7dUOsX3k+g+nHRB++/OvW1aJXOmKSqxHROMD6zm4okQ6aZ2yHvSe0wOY1kQHe9m
         BsFhs2xn8cN5CPsPROlk+XDFhLBM3++tMupJfF2nRFjAzFw+9e+1G3m99hJrmu6PIcFs
         VYm76iEWln8soEysuWXtB0VbIOCzFxDEyvPTAURGz+ImBJQEQXsPVGcSvIMctDtMFPP9
         fz4Q==
X-Gm-Message-State: AJIora8GQTzQsEbo2xP9M+Ah+1qHReayZ/6+uuklgrU99Vuh0Qan29XN
        6FGnwXLlkQRgPxGiXbL5JQP6ee6znj31YYKZ34RkqQ==
X-Google-Smtp-Source: AGRyM1vM13rgd/slOqq6rzR/GF+9bV6nsXD00WID/92zXrhUrPFIIXQ6CrmHMaV8g8gXYlEO+2tkIhtqVfu6YaKkwHc=
X-Received: by 2002:ac2:4c46:0:b0:489:e93c:69b with SMTP id
 o6-20020ac24c46000000b00489e93c069bmr4711100lfk.403.1658768574640; Mon, 25
 Jul 2022 10:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220725020812.622255-1-masahiroy@kernel.org>
In-Reply-To: <20220725020812.622255-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 25 Jul 2022 10:02:42 -0700
Message-ID: <CAKwvOd=yeqE-sMRDwB6Nq5RCwHo9wbx2ZagTiqXnkpidpjUAYw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] x86/purgatory: hard-code obj-y in Makefile
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 7:10 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> arch/x86/Kbuild guards the entire purgatory/ directory, and
> CONFIG_KEXEC_FILE is bool type.
>
> $(CONFIG_KEXEC_FILE) is always 'y' when this directory is being built.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> (no changes since v1)
>
>  arch/x86/purgatory/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> index ae53d54d7959..248b009c4061 100644
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -81,4 +81,4 @@ quiet_cmd_bin2c = BIN2C   $@
>  $(obj)/kexec-purgatory.c: $(obj)/purgatory.ro $(obj)/purgatory.chk FORCE
>         $(call if_changed,bin2c)
>
> -obj-$(CONFIG_KEXEC_FILE)       += kexec-purgatory.o
> +obj-y += kexec-purgatory.o
> --
> 2.34.1
>


-- 
Thanks,
~Nick Desaulniers
