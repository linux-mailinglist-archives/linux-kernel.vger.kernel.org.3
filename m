Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1BA576FF5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 17:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbiGPPl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 11:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPPl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 11:41:58 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792E41EAC3;
        Sat, 16 Jul 2022 08:41:57 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 26GFfUl4024720;
        Sun, 17 Jul 2022 00:41:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 26GFfUl4024720
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1657986091;
        bh=9l6AqfAq1fUXeNREScyW3EFRwBhnW1ZJsI1ajN6AmNc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s8e1j334nemy0KPJqqC318cG7Oxxo/QQ9jkbsFB0Y4QIk9zd7FE1+U1Wj36+0dJT4
         bpaFl5g5KeWyxFLriF4HZNlDuGdJR4AtETNCnfiRl/xO0G+VvfNzmbcQl2ndJ4IcCV
         rQq8nmGKFWyduNV0nbTjMFa+lGHZrjraw80Fnt9i+6anXmt50KlK7pMyCYnio8vcoy
         BFzPcuSbRn0phYPYt7a1xBq8DhcTpoNNLuy3u2+eV8hyCBXQ1l/9W+9OOE52SOguGc
         1cZoSbB0FBo6PhK1b9Ees4MbOd88fDve/FBNJYcusok7aXndNJxch7q9Ky45Jq/BDV
         6Dp1lXd3ZEADQ==
X-Nifty-SrcIP: [209.85.221.43]
Received: by mail-wr1-f43.google.com with SMTP id e15so5385469wro.5;
        Sat, 16 Jul 2022 08:41:31 -0700 (PDT)
X-Gm-Message-State: AJIora8rm2GaoWVbz/Np9WeWmcFyXHgBqOqOnFkO9RK90BBvAKhPCLDi
        9phiLC4ppndcbC8Uh4POOXq3TFtxziMzmfiKxf0=
X-Google-Smtp-Source: AGRyM1t/dRQnd1fMOKpDQNUmKgzbpoxiL6/bhf+qufAWI8vS4tLK4bRl60YwqvphGURlbQHT0V1t+NmA0H97qvjtOpU=
X-Received: by 2002:adf:d1e2:0:b0:21d:d40b:d816 with SMTP id
 g2-20020adfd1e2000000b0021dd40bd816mr6497954wrd.682.1657986089724; Sat, 16
 Jul 2022 08:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220714050243.16411-1-masahiroy@kernel.org> <20220714050243.16411-4-masahiroy@kernel.org>
In-Reply-To: <20220714050243.16411-4-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 17 Jul 2022 00:40:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQqSWaLJV7cGDtq3hscqwh2eWUaRs-XgB8v4-mS2bVAQA@mail.gmail.com>
Message-ID: <CAK7LNAQqSWaLJV7cGDtq3hscqwh2eWUaRs-XgB8v4-mS2bVAQA@mail.gmail.com>
Subject: Re: [PATCH 4/4] kbuild: error out if $(INSTALL_MOD_PATH) contains %
 or :
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 2:03 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> If the directory pass given to INSTALL_MOD_PATH contains % or :,

A typo.

directory pass  ->  directory path





> the module_install fails.
>
> % is used in pattern rules, and : as the separator of dependencies.
>
> Bail out with a clearer error message.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/Makefile.modinst | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
> index 16a02e9237d3..a4c987c23750 100644
> --- a/scripts/Makefile.modinst
> +++ b/scripts/Makefile.modinst
> @@ -18,6 +18,9 @@ INSTALL_MOD_DIR ?= extra
>  dst := $(MODLIB)/$(INSTALL_MOD_DIR)
>  endif
>
> +$(foreach x, % :, $(if $(findstring $x, $(dst)), \
> +       $(error module installation path cannot contain '$x')))
> +
>  suffix-y                               :=
>  suffix-$(CONFIG_MODULE_COMPRESS_GZIP)  := .gz
>  suffix-$(CONFIG_MODULE_COMPRESS_XZ)    := .xz
> --
> 2.34.1
>


-- 
Best Regards
Masahiro Yamada
