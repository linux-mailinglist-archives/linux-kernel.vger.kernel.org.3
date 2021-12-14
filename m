Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6879447455C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 15:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbhLNOkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 09:40:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50974 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbhLNOkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 09:40:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DDF6B819E7;
        Tue, 14 Dec 2021 14:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB65DC34605;
        Tue, 14 Dec 2021 14:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639492817;
        bh=ZsV7vgxPngHOT7KypBEabGUnzoS988RDkMy+GfbQz5k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DEk9lHeW4hwiaZLjPTt7Uc1cptM17Ov0+NsM6bhU4LiI//GPvobyXJoBCiW9S4dF/
         OReBLXH4E90RJYGzpp/+tJ9ERkzS7RFhDYW2ME6QjJuoUNis7M+4XpD7r0pg5z8Nmx
         cKcnofKDQhYytgZBnUQ49vx4/PCZh+xekN9naH1FqLdx9G0sh26AFfh8LwEZzGltbl
         ETFEJfnkFVhWU5+bdgUz3314Eahw+5wMST9UXEdQSPqMU0kcDMsUidpADbC4y1i9ht
         2UA6ByU0F+OuHVYfpGQmKk63vajy5tyctQoCyq7ckY6+kySqHgV/1ZehWyRdaj/zS0
         HWmEi/IJCNzaA==
Received: by mail-ed1-f42.google.com with SMTP id v1so64156056edx.2;
        Tue, 14 Dec 2021 06:40:16 -0800 (PST)
X-Gm-Message-State: AOAM531vLnxzkKlZh2jcMkxKKIM2wcznwKgQmX059FMPoGDI+E8z2o8f
        F90jL1azuvrScpUpIEyf0upyPqNAuL2C31p42w==
X-Google-Smtp-Source: ABdhPJzb2kFsttfkp1wodLWs1+u9g7X0Osm0q69CwVTGT2N2fa1Xsg4NpUSIZpuN1tuA7JavfOna2VbIWMjOqcHj4o8=
X-Received: by 2002:a17:907:9256:: with SMTP id kb22mr5778005ejb.423.1639492814393;
 Tue, 14 Dec 2021 06:40:14 -0800 (PST)
MIME-Version: 1.0
References: <20211208155839.4084795-1-robh@kernel.org> <87fsqwn03o.fsf@mpe.ellerman.id.au>
 <CAL_JsqLpq7fx0pyQiJFa0P5C3JXijiVe_fr84x9RML1aDJ7vDQ@mail.gmail.com> <877dc7mo3o.fsf@mpe.ellerman.id.au>
In-Reply-To: <877dc7mo3o.fsf@mpe.ellerman.id.au>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 14 Dec 2021 08:40:02 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKbaRgivZMxEj6Mjdny2LNeSA1GQyDW-nQe7E2irPc-Fw@mail.gmail.com>
Message-ID: <CAL_JsqKbaRgivZMxEj6Mjdny2LNeSA1GQyDW-nQe7E2irPc-Fw@mail.gmail.com>
Subject: Re: [PATCH v2] of/fdt: Rework early_init_dt_scan_memory() to call directly
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     John Crispin <john@phrozen.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 5:18 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Rob Herring <robh@kernel.org> writes:
> > On Mon, Dec 13, 2021 at 6:47 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> >> Rob Herring <robh@kernel.org> writes:
> >> > Use of the of_scan_flat_dt() function predates libfdt and is discouraged
> >> > as libfdt provides a nicer set of APIs. Rework
> >> > early_init_dt_scan_memory() to be called directly and use libfdt.
> >> ...
> >> > diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> >> > index 6e1a106f02eb..63762a3b75e8 100644
> >> > --- a/arch/powerpc/kernel/prom.c
> >> > +++ b/arch/powerpc/kernel/prom.c
> >> > @@ -532,19 +532,19 @@ static int  __init early_init_drmem_lmb(struct drmem_lmb *lmb,
> >> >  }
> >> >  #endif /* CONFIG_PPC_PSERIES */
> >> >
> >> > -static int __init early_init_dt_scan_memory_ppc(unsigned long node,
> >> > -                                             const char *uname,
> >> > -                                             int depth, void *data)
> >> > +static int __init early_init_dt_scan_memory_ppc(void)
> >> >  {
> >> >  #ifdef CONFIG_PPC_PSERIES
> >> > -     if (depth == 1 &&
> >> > -         strcmp(uname, "ibm,dynamic-reconfiguration-memory") == 0) {
> >> > +     const void *fdt = initial_boot_params;
> >> > +     int node = fdt_path_offset(fdt, "/ibm,dynamic-reconfiguration-memory");
> >> > +
> >> > +     if (node > 0) {
> >> >               walk_drmem_lmbs_early(node, NULL, early_init_drmem_lmb);
> >> >               return 0;
> >> >       }
>
> It's that return that is the problem.
>
> Now that early_init_dt_scan_memory_ppc() is only called once, that
> return causes us to skip scanning regular memory nodes if there is an
> "ibm,dynamic-reconfiguration-memory" property present.
>
> So the fix is just:
>
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 1098de3b172f..125661e5fcf3 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -538,10 +538,8 @@ static int __init early_init_dt_scan_memory_ppc(void)
>         const void *fdt = initial_boot_params;
>         int node = fdt_path_offset(fdt, "/ibm,dynamic-reconfiguration-memory");
>
> -       if (node > 0) {
> +       if (node > 0)
>                 walk_drmem_lmbs_early(node, NULL, early_init_drmem_lmb);
> -               return 0;
> -       }
>  #endif
>
>         return early_init_dt_scan_memory();

Thanks! I've rolled that in.

> > The only thing I see is now there is an assumption that 'memory' nodes
> > are off the root node only. Before they could be anywhere.
>
> I don't know of any machines where that would be a problem. But given
> all the wild and wonderful device trees out there, who really knows :)
>
> Maybe we should continue to allow memory nodes to be anywhere, and print
> a warning for any that aren't at the root. Then if no one reports any
> hits for the warning we could switch to only allowing them at the root?

I really doubt there's any case. I just have the least visibility into
what IBM DTs look like. I checked some old DT files I have and also
u-boot only supports off the root node.


Rob
