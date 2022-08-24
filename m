Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647E159FA6B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 14:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237165AbiHXMuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 08:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236994AbiHXMuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:50:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D3374CDD
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:50:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7CA9EB822BB
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 12:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CCFC433B5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 12:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661345409;
        bh=1k60HpX7cXrshFFmT/6JTyPBxaN3k/G7TgJpXm0jnnI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q8954Qz+AYsJs/EFwKcnbzp+3uraYlGZjdmodvi6SKXgvcpRaldwPFJeNAd5/JxU4
         Z3gV8uCFK9EiiEDLUatuMU83jmL/wgUCp1cxt9Jek+k9N0ynSpHoleqdNqqC4T33nJ
         1ainM1ohnbdDkztA7kyaHDaKsT/P3fdhpXp0R914PNMaYNSJH2I29RSCF3qE0l86Ho
         s/DHCEsZMaEPmf7uZ6O+0hsNflVOWQqvAjEltUyD5jIK08XAU8LWw2qsrFmN2n9uUB
         HRwegcRORMwFDcq0hwgSt6HfP7Z/S8naFoTGnbmwkmkOc7LWgFvMGbBgqqJOLEtMR5
         v2jVLoYU7fL9A==
Received: by mail-vk1-f182.google.com with SMTP id d6so6418424vko.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:50:09 -0700 (PDT)
X-Gm-Message-State: ACgBeo2tIe7XkFAYJBCEf8AJblNqOLB7GwFUDSC9yPNM0MreJN/ZCieu
        nmegdlghxWUrkNeXsp63uVdOF96TKGtIFuLh6UE=
X-Google-Smtp-Source: AA6agR4uatgwhnEP5R2JmNAqISyNLPbDFpcVJUPr35PGmJIIpRrZq9oQVxpTmF81UWPGtF8IMScNTq9PBxp/88vBFxg=
X-Received: by 2002:a1f:acd2:0:b0:37b:531:9988 with SMTP id
 v201-20020a1facd2000000b0037b05319988mr11191879vke.19.1661345408156; Wed, 24
 Aug 2022 05:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220820153506.607928-1-chenhuacai@loongson.cn> <CAK8P3a1Z2xR_Poiv4dTntpghWKES6Jk75jNiDy8q7_L8XfRyuQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1Z2xR_Poiv4dTntpghWKES6Jk75jNiDy8q7_L8XfRyuQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 24 Aug 2022 20:49:55 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7wLp2EiEL0zyLL0_+tZAqTwy+tfFcyE9WwJeDYTfQY-g@mail.gmail.com>
Message-ID: <CAAhV-H7wLp2EiEL0zyLL0_+tZAqTwy+tfFcyE9WwJeDYTfQY-g@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Fix build warnings in VDSO
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Arnd,

On Wed, Aug 24, 2022 at 6:10 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Sat, Aug 20, 2022 at 5:35 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > diff --git a/arch/loongarch/vdso/vgetcpu.c b/arch/loongarch/vdso/vgetcpu.c
> > index 43a0078e4418..e02e775f5360 100644
> > --- a/arch/loongarch/vdso/vgetcpu.c
> > +++ b/arch/loongarch/vdso/vgetcpu.c
> > @@ -24,6 +24,8 @@ static __always_inline const struct vdso_pcpu_data *get_pcpu_data(void)
> >         return (struct vdso_pcpu_data *)(get_vdso_base() - VDSO_DATA_SIZE);
> >  }
> >
> > +extern
> > +int __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused);
> >  int __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused)
> >  {
>
> I don't think that adding the declaration before the function is a
> good workaround here,
> that is likely to just trigger another warning about declarations in .c files.
Yes, this is not a good solution, I just use the same method as RISC-V. :)
But "another warning" is a checkpatch warning, not a build warning, so
lkp@intel.com will not send bug reports again and again. :)

>
> I would add the declarations into a header file instead. If the
> prototypes are the same
> across architectures, this can be a global header that also avoids the
> warnings elsewhere,
> otherwise just keep it local to this directory.
gettimeofday, clock_gettime and clock_getres can be declared across
architectures, but getcpu seems not suitable because not all
architectures have it.

Huacai

>
>       Arnd
