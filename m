Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B756580A8D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 06:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiGZEtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 00:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiGZEtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 00:49:13 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CAA248CD
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 21:49:12 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 26Q4mmVs011015
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 13:48:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 26Q4mmVs011015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1658810929;
        bh=TJAt1sPKJdZeEtouGB202AmkAZKPNWADM2oec71xILQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H+bAzdQoX1NlMoaWJVuA1qncXKv/uWJmIsm2+S5S1gbF5VtEW3a9Y6QLpOMnoJdPv
         BEuiVLlmY65JNmt3oBdAif4zPVavxqucMyfPem6pO48uWP4Kb60m2el6Z6Ac2u9Qie
         jidXg/g1F6OWB5fVtavRcOxYuELafLNxMxCACDt1bbiAlsXNN6ZKO8f3JlMto0wCS0
         7v4S0r7IMUaC2dM3uwnoC/K3SGK/3qhAjES2Z3+O2smdYJv8iykVyTEW1DAslRL/zs
         1VtyXoNwJwhjUoiKjVYc45AJDFEbZ0IfMm++K0NkIt0CQTr9NBB37CAxV8h3VOITbx
         2djtMGiL149Jw==
X-Nifty-SrcIP: [209.85.221.41]
Received: by mail-wr1-f41.google.com with SMTP id v13so10764745wru.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 21:48:48 -0700 (PDT)
X-Gm-Message-State: AJIora/uQBi9acK47ZKxESNPe3tpg7j/7v0wlRVmtAf+zzwehboodpad
        5O4VeaLZzBeXYpSz2i31DdxsjV63f23yNNMrs44=
X-Google-Smtp-Source: AGRyM1vqyF2N00F5xIlUZdPlGCSBPRAMhN1dql2XSqm2aGCeTkFnj866PnWyStoi52GSkOBa0GFxHDU1rqg4meNzUYA=
X-Received: by 2002:a5d:52c4:0:b0:21e:af40:7f0b with SMTP id
 r4-20020a5d52c4000000b0021eaf407f0bmr92775wrv.477.1658810926938; Mon, 25 Jul
 2022 21:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220713194112.15557-1-wafgo01@gmail.com> <fa77d640-a18d-ca77-ba57-6735094a224f@microchip.com>
In-Reply-To: <fa77d640-a18d-ca77-ba57-6735094a224f@microchip.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 26 Jul 2022 13:47:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNARu4OU_hGQHu8B7F=5jLzU1jp7L=RHVcyo3eLkEyWNcQw@mail.gmail.com>
Message-ID: <CAK7LNARu4OU_hGQHu8B7F=5jLzU1jp7L=RHVcyo3eLkEyWNcQw@mail.gmail.com>
Subject: Re: [PATCH] checkstack: add riscv support for scripts/checkstack.pl
To:     Conor.Dooley@microchip.com
Cc:     wafgo01@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SIFIVE DRIVERS" <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 2:40 AM <Conor.Dooley@microchip.com> wrote:
>
> On 13/07/2022 20:41, Wadim Mueller wrote:
> > [You don't often get email from wafgo01@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
>
> I feel like you might've been mislead by get_maintainer for this
> patch. It looks like the maintainer covering this is Masahiro
> Yamada <masahiroy@kernel.org> (at least he's taken the last few
> patches for it).


I can pick this up.

Applied to linux-kbuild. Thanks.


>
> I'll be honest, I don't know how to verify that the output is
> correct - but I did run it & it does output something that looks
> sane /shrug
>
> Thanks,
> Conor.
>
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > scripts/checkstack.pl lacks support for the riscv architecture. Add
> > support to detect "addi sp,sp,-FRAME_SIZE" stack frame generation instruction
> >
> > Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
> > ---
> >  scripts/checkstack.pl | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
> > index d2c38584ece6..d48dfed6d3db 100755
> > --- a/scripts/checkstack.pl
> > +++ b/scripts/checkstack.pl
> > @@ -16,6 +16,7 @@
> >  #      AArch64, PARISC ports by Kyle McMartin
> >  #      sparc port by Martin Habets <errandir_news@mph.eclipse.co.uk>
> >  #      ppc64le port by Breno Leitao <leitao@debian.org>
> > +#      riscv port by Wadim Mueller <wafgo01@gmail.com>
> >  #
> >  #      Usage:
> >  #      objdump -d vmlinux | scripts/checkstack.pl [arch]
> > @@ -108,6 +109,9 @@ my (@stack, $re, $dre, $sub, $x, $xs, $funcre, $min_stack);
> >         } elsif ($arch eq 'sparc' || $arch eq 'sparc64') {
> >                 # f0019d10:       9d e3 bf 90     save  %sp, -112, %sp
> >                 $re = qr/.*save.*%sp, -(([0-9]{2}|[3-9])[0-9]{2}), %sp/o;
> > +       } elsif ($arch =~ /^riscv(64)?$/) {
> > +               #ffffffff8036e868:      c2010113                addi    sp,sp,-992
> > +               $re = qr/.*addi.*sp,sp,-(([0-9]{2}|[3-9])[0-9]{2})/o;
> >         } else {
> >                 print("wrong or unknown architecture \"$arch\"\n");
> >                 exit
> > --
> > 2.25.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>


-- 
Best Regards
Masahiro Yamada
