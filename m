Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F394BE6E0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379501AbiBUPtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:49:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379480AbiBUPtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:49:05 -0500
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE0A23BF4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:48:39 -0800 (PST)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 21LFmFtX007182
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 00:48:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 21LFmFtX007182
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1645458495;
        bh=Eq86KaLsmhn/jol5Cl8rzxgkWiNMVMb0uEfZ1QLZapo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ts3bbvIUNhE0Y6Bzss57FFqwRvn8Wc/PkOSyPLDeypC1k78+CvrOTRlgjsEXuxEYE
         5NTs5N/PTQLeNrWbp4d4e58Yd2W74J89cZRrBxhyhraLmAxDlKeRQi3mhi3D/LoKx1
         S5E92VIWwX4sB2oSs6RlucNfUIWqS27MOST4QzglE5L92ogAJhAXXFYI/UKNm9+Fq9
         D890iCMxRvvmOj+y91+gLM4MDwZeBA1clPKkJnDvV+kkY01C97mX1Eae/JMZBqL6V0
         2oOAwlzGRR/FukvlPYLTJ0Z6lRj8vqk1yXYnLSh4Wy9z2vnvjMaw1snJDIDBB0dXEB
         W7CLgcztMYI0A==
X-Nifty-SrcIP: [209.85.210.169]
Received: by mail-pf1-f169.google.com with SMTP id z15so3469323pfe.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:48:15 -0800 (PST)
X-Gm-Message-State: AOAM533N6JRf6jJR0N6Fk9A9MSkNEfDtBd9OtU3jE0ovNGnCeuIY10Zc
        gwIOvdedy4i/qCkVxWVq2N3gIwU4ImAukTXi7Ac=
X-Google-Smtp-Source: ABdhPJyIDoa3KpkYnOJOjGfpO89oU3Wb/HC5/pM/hhJVkCzjD2oDLvQEdThWSSXmLxjexnlDDXnTVXnsngQ2AX1NiQI=
X-Received: by 2002:a65:5341:0:b0:363:da77:99df with SMTP id
 w1-20020a655341000000b00363da7799dfmr16423493pgr.126.1645458494757; Mon, 21
 Feb 2022 07:48:14 -0800 (PST)
MIME-Version: 1.0
References: <20220201013257.17926-1-changbin.du@gmail.com> <20220221143758.7wln3mklyaj7mzod@mail.google.com>
In-Reply-To: <20220221143758.7wln3mklyaj7mzod@mail.google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 22 Feb 2022 00:47:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQtuMujS32JTmjj3kPwiHALmV+izV4_mjRtFq6szC-e2Q@mail.gmail.com>
Message-ID: <CAK7LNAQtuMujS32JTmjj3kPwiHALmV+izV4_mjRtFq6szC-e2Q@mail.gmail.com>
Subject: Re: [PATCH] kallsyms: ignore all local labels prefixed by '.L'
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SIFIVE DRIVERS" <linux-riscv@lists.infradead.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 11:38 PM Changbin Du <changbin.du@gmail.com> wrote:
>
> Hi, Masahiro,
> Could you consider picking up this change if you have no objection?
>
> On Tue, Feb 01, 2022 at 09:32:57AM +0800, Changbin Du wrote:
> > The llvm compiler can generate lots of local labels ('.LBB', '.Ltmpxxx',
> > '.L__unnamed_xx', etc.). These symbols usually are useless for debugging.
> > And they might overlap with handwritten symbols.
> >
> > Before this change, a dumpstack shows a local symbol for epc:
> > [    0.040341][    T0] Hardware name: riscv-virtio,qemu (DT)
> > [    0.040376][    T0] epc : .LBB6_14+0x22/0x6a
> > [    0.040452][    T0]  ra : restore_all+0x12/0x6e
> >
> > The simple solution is that we can ignore all local labels prefixed by '.L'.
> > For handwritten symbols which need to be preserved should drop the '.L'
> > prefix.
> >
> > After this change, the C defined symbol is shown so we can locate the
> > problematical code immediately:
> > [    0.035795][    T0] Hardware name: riscv-virtio,qemu (DT)
> > [    0.036332][    T0] epc : trace_hardirqs_on+0x54/0x13c
> > [    0.036567][    T0]  ra : restore_all+0x12/0x6e
> >
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>

Now applied to linux-kbuild. Thanks.



> > ---
> >  scripts/kallsyms.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> > index 54ad86d13784..8caabddf817c 100644
> > --- a/scripts/kallsyms.c
> > +++ b/scripts/kallsyms.c
> > @@ -108,7 +108,7 @@ static bool is_ignored_symbol(const char *name, char type)
> >       /* Symbol names that begin with the following are ignored.*/
> >       static const char * const ignored_prefixes[] = {
> >               "$",                    /* local symbols for ARM, MIPS, etc. */
> > -             ".LASANPC",             /* s390 kasan local symbols */
> > +             ".L",                   /* local labels, .LBB,.Ltmpxxx,.L__unnamed_xx,.LASANPC, etc. */
> >               "__crc_",               /* modversions */
> >               "__efistub_",           /* arm64 EFI stub namespace */
> >               "__kvm_nvhe_",          /* arm64 non-VHE KVM namespace */
> > --
> > 2.32.0
> >
>
> --
> Cheers,
> Changbin Du



-- 
Best Regards
Masahiro Yamada
