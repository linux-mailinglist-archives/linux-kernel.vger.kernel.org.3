Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFAE525A12
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 05:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376716AbiEMD2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 23:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiEMD2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 23:28:39 -0400
X-Greylist: delayed 84415 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 May 2022 20:28:37 PDT
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DEC20D4FF;
        Thu, 12 May 2022 20:28:37 -0700 (PDT)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 24D3SIfW022474;
        Fri, 13 May 2022 12:28:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 24D3SIfW022474
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652412499;
        bh=65QpWywYEXx5+t0AoIjLCVLNZism0JO9jsEsk1X5rL0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SyKTwlmTxfu1Y1ir0NCfsHzyPDGcbZhqIfZefxZ6HKFMYCTFfOyVnoj60fRFHIQBe
         /jhidJEWUXZz5XvuAZphhKIINyXDPp3tBuAAw4iZXTXbOpd7j3DX/jcmJyAOh9vdVt
         /6aK1L8HryxRblq+4zxcANMP/9KHxOx2x+80QQ7GyfwgEdS1pZ09o9kwNoQUt/pUoU
         3e5FLuHSmopNe62oB3dOvzffLEFA22IOmbNu3sSzQC3sZhIWLkOrvEmnIcbJP38DnA
         9pKlktiY+q74fz8zTvB/+F+48OqXDzI5HgxaTnHxsb6h4aI4VXg92ONAubEfdjkB/I
         Mogwpb3/pUmww==
X-Nifty-SrcIP: [209.85.216.53]
Received: by mail-pj1-f53.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so6623584pjq.2;
        Thu, 12 May 2022 20:28:19 -0700 (PDT)
X-Gm-Message-State: AOAM532RbVNPcLXsIvhzbhhM7wfJhwFriq1C62PlfHWgqtYHa7Z2RPIT
        ocl9gaLFlBSPlmgjur/ZykUm8WR5NocmSiasLTo=
X-Google-Smtp-Source: ABdhPJwJjTqMt2DGeBaDODDkT2N4FmDiIUvsLpRMmpQBl0z2UKRm78ObMJY2W9UT93lqKp+DXe1aSPgWadVHu5ZiMN0=
X-Received: by 2002:a17:902:7891:b0:15e:cae9:7620 with SMTP id
 q17-20020a170902789100b0015ecae97620mr2921294pll.136.1652412498411; Thu, 12
 May 2022 20:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220512035903.2779287-1-masahiroy@kernel.org> <20220512035903.2779287-4-masahiroy@kernel.org>
In-Reply-To: <20220512035903.2779287-4-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 13 May 2022 12:27:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNASsrr_birFp=1MO6fVauogU1uiqSytQNgzFxBiOuLVw1w@mail.gmail.com>
Message-ID: <CAK7LNASsrr_birFp=1MO6fVauogU1uiqSytQNgzFxBiOuLVw1w@mail.gmail.com>
Subject: Re: [PATCH 4/4] cskly: move $(core-y) into arch/csky/Kbuild
To:     Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 1:01 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Use the standard obj-y form to specify the sub-directories under
> arch/csky/. No functional change intended.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

I am not sending v2 just for typo "cskly:"

I hope the maintainer can fix it.




>  arch/csky/Kbuild   | 4 ++++
>  arch/csky/Makefile | 4 ----
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/csky/Kbuild b/arch/csky/Kbuild
> index 4e39f7abdeb6..3015be1afd59 100644
> --- a/arch/csky/Kbuild
> +++ b/arch/csky/Kbuild
> @@ -1,4 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>
> +obj-y += kernel/ mm/
> +obj-$(CONFIG_CPU_ABI_V1) += abiv1/
> +obj-$(CONFIG_CPU_ABI_V2) += abiv2/
> +
>  # for cleaning
>  subdir- += boot
> diff --git a/arch/csky/Makefile b/arch/csky/Makefile
> index 2b30525f39e1..51150abd2831 100644
> --- a/arch/csky/Makefile
> +++ b/arch/csky/Makefile
> @@ -63,10 +63,6 @@ KBUILD_AFLAGS += $(KBUILD_CFLAGS)
>
>  head-y := arch/csky/kernel/head.o
>
> -core-y += arch/csky/kernel/
> -core-y += arch/csky/mm/
> -core-y += arch/csky/$(CSKYABI)/
> -
>  libs-y += arch/csky/lib/ \
>         $(shell $(CC) $(KBUILD_CFLAGS) $(KCFLAGS) -print-libgcc-file-name)
>
> --
> 2.32.0
>


-- 
Best Regards
Masahiro Yamada
