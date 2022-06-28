Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B4255D80F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242238AbiF1H3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242178AbiF1H3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:29:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B53A101E6;
        Tue, 28 Jun 2022 00:29:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5027CB81D18;
        Tue, 28 Jun 2022 07:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F487C341CD;
        Tue, 28 Jun 2022 07:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656401345;
        bh=9e7xqvkeOXPne6fkHK55WdOz4A7pOvMWc/9SVYribOs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QhC+rpby4BOw7U4H4rdqD0vKHlqgbn08vIl5qLgG66YFCXAEMuypYYNqBifOt8WQz
         UR0csvk93WkR1DUiNtj+Jm4P1yG3BeNXIawp2LgI4hjNA2vYlIyJdh2uckHwYAc1dC
         KGfmbS5JwWIW+BZd1qiXhAZJOsg2VPj/eJWAdpfU0sZNiW9bKzGsnjOGK2DljwyLGq
         unqEmQcjMQ9biGjHRZzz7R55W7SBXC+wUD1dWbdqfoxAH5X/p9uawtq0LYmyVHcTmH
         DPHN2XWuOxqItbvg9dvbOZwNeAN8KRHRYZYj9KevLAA5FR5diiaDpJYVLkMz4bo51u
         NGCxLFVVRcvSA==
Received: by mail-vs1-f51.google.com with SMTP id w187so11217251vsb.1;
        Tue, 28 Jun 2022 00:29:05 -0700 (PDT)
X-Gm-Message-State: AJIora+Y0mFxRZKMbA4yIC++rmOJVFHu5N11t/iVnNnGUML/DPKz2pCh
        Jdbr8oP3g1HHjLfZrGf9dmgL5y2miFzSpCvKo5o=
X-Google-Smtp-Source: AGRyM1uCNNlVvtFMXSOJl2rXJ+BXq/24l0yBQjfRqfBWkr48/MqTF3+P2ImyLvaXf/glefJIvsMl2/bC9KbFPDHYEoM=
X-Received: by 2002:a05:6102:6c4:b0:354:3f88:4d3f with SMTP id
 m4-20020a05610206c400b003543f884d3fmr1401486vsg.78.1656401344053; Tue, 28 Jun
 2022 00:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <1656313633-1713-1-git-send-email-yangtiezhu@loongson.cn> <a93e5cbe-deb8-c760-685a-6d3171d651f3@loongson.cn>
In-Reply-To: <a93e5cbe-deb8-c760-685a-6d3171d651f3@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 28 Jun 2022 15:28:52 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7BiFru1AZRe8pM0NxRb2FEj7n6eYtEkZ8jEWKQWYv4WA@mail.gmail.com>
Message-ID: <CAAhV-H7BiFru1AZRe8pM0NxRb2FEj7n6eYtEkZ8jEWKQWYv4WA@mail.gmail.com>
Subject: Re: [PATCH v2] MIPS: Loongson64: Fix section mismatch warning
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Huacai Chen <chenhuacai@kernel.org>

On Tue, Jun 28, 2022 at 8:16 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> Cc Masahiro Yamada <masahiroy@kernel.org>
>
> On 06/27/2022 03:07 PM, Tiezhu Yang wrote:
> > prom_init_numa_memory() is annotated __init and not used by any module,
> > thus don't export it.
> >
> > Remove not needed EXPORT_SYMBOL for prom_init_numa_memory() to fix the
> > following section mismatch warning:
> >
> >   LD      vmlinux.o
> >   MODPOST vmlinux.symvers
> > WARNING: modpost: vmlinux.o(___ksymtab+prom_init_numa_memory+0x0): Section mismatch in reference
> > from the variable __ksymtab_prom_init_numa_memory to the function .init.text:prom_init_numa_memory()
> > The symbol prom_init_numa_memory is exported and annotated __init
> > Fix this by removing the __init annotation of prom_init_numa_memory or drop the export.
> >
> > This is build on Linux 5.19-rc4.
> >
> > Fixes: 6fbde6b492df ("MIPS: Loongson64: Move files to the top-level directory")
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > ---
> >
> > v2: update the commit message and add Fixes tag
> >
> >  arch/mips/loongson64/numa.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/mips/loongson64/numa.c b/arch/mips/loongson64/numa.c
> > index 69a5331..8f61e93 100644
> > --- a/arch/mips/loongson64/numa.c
> > +++ b/arch/mips/loongson64/numa.c
> > @@ -196,7 +196,6 @@ void __init prom_init_numa_memory(void)
> >       pr_info("CP0_PageGrain: CP0 5.1 (0x%x)\n", read_c0_pagegrain());
> >       prom_meminit();
> >  }
> > -EXPORT_SYMBOL(prom_init_numa_memory);
> >
> >  pg_data_t * __init arch_alloc_nodedata(int nid)
> >  {
> >
>
> Hi Masahiro,
>
> Please review this patch, I think it is related with the following
> issue, thank you.
>
> https://lore.kernel.org/lkml/CAHk-=wgcsUU-TNoLS7Q6YF3RCSVAKwNM7gFOwqnPQTiU_oGEWA@mail.gmail.com/
>
> Thanks,
> Tiezhu
>
