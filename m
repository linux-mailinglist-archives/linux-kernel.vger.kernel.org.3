Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDA657F815
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 03:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbiGYB7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 21:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiGYB7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 21:59:33 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AAAE0C3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 18:59:32 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 26P1x9DI025970
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 10:59:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 26P1x9DI025970
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1658714351;
        bh=HVu+KaNVwvREcYnTWHIbGMhdQS80Phpv0XKr84P25VM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Pc/sWxVjSjQ8XOdnwSZ7INJ72O7E7Kv/aLMlu90fMJSH1BWhuDlIK91j2vIBUj17Q
         kaIrk1cusBO23FAWq8eQ2TkqVXQSLrSdj3dTe9Jc3SLhHuOoMgvXnIeDCfqqJ2tmCZ
         4FF4CRlMuFClYGQMOiWq/FeVovJGofX4GSF4I2xAvBWvDsMXTyZgB3OO/EbRInmz3h
         FhPnwEFsC9MR6pAKYaFuN/QTfMlP37lVo4noj7wedf89uSMLKu2ZVn998qk+flZmCU
         0sdg+QDFzaghOzURKe8tXYex4zqiPwWjHg5tnv0CbZr+KupLwUFPM7yVB8fwO0JDQj
         EwI4C5Yo8yrXw==
X-Nifty-SrcIP: [209.85.128.44]
Received: by mail-wm1-f44.google.com with SMTP id j29-20020a05600c1c1d00b003a2fdafdefbso5511696wms.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 18:59:10 -0700 (PDT)
X-Gm-Message-State: AJIora/J/aI1exdKm+CLB/RL/ok9EnWWmRbTF6PNuwI4IkTkFpZk7V6O
        lXLZq63YiJ98mQPU1FpIOBFD/gBQca4URBWjPyc=
X-Google-Smtp-Source: AGRyM1vivR05y2jgl4+ym0sl+fjMjQbBEUj0AOZjOmvOpxjP/5cSIlaorKkje5gZwtyeN7RnyVJuYRVi0J7bgCmZcPs=
X-Received: by 2002:a05:600c:a42:b0:39c:9086:8a34 with SMTP id
 c2-20020a05600c0a4200b0039c90868a34mr19832895wmq.169.1658714349182; Sun, 24
 Jul 2022 18:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220625224037.836581-1-masahiroy@kernel.org> <20220725014100.GQ25951@gate.crashing.org>
In-Reply-To: <20220725014100.GQ25951@gate.crashing.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 25 Jul 2022 10:58:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNATFT3YFz-VUu1PQWNNfCL6k4EFokxcMGq3guJo9MhmydQ@mail.gmail.com>
Message-ID: <CAK7LNATFT3YFz-VUu1PQWNNfCL6k4EFokxcMGq3guJo9MhmydQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/purgatory: Omit use of bin2c
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
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

On Mon, Jul 25, 2022 at 10:42 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Sun, Jun 26, 2022 at 07:40:37AM +0900, Masahiro Yamada wrote:
> > The .incbin assembler directive is much faster than bin2c + $(CC).
>
> And perhaps more importantly it is simpler and less clumsy.
>
> > --- /dev/null
> > +++ b/arch/powerpc/purgatory/kexec-purgatory.S
> > @@ -0,0 +1,14 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +     .section .rodata, "a"
> > +
> > +     .align  8
> > +kexec_purgatory:
> > +     .globl  kexec_purgatory
> > +     .incbin "arch/powerpc/purgatory/purgatory.ro"
> > +.Lkexec_purgatroy_end:
>
> Typo here (s/ro/or/)


Nice catch. Thanks.

I've sent v2.



>
> > +
> > +     .align  8
> > +kexec_purgatory_size:
> > +     .globl  kexec_purgatory_size
> > +     .quad   .Lkexec_purgatroy_end - kexec_purgatory
>
> And here again ofc.
>
> Looks good to me otherwise, nice cleanup :-)
>
> Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>
>
>
> Segher



-- 
Best Regards
Masahiro Yamada
