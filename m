Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1DD583695
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 03:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbiG1B6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 21:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbiG1B6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 21:58:05 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2EE58B49
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 18:58:04 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id v185so440966ioe.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 18:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7OcGNq5n7OL7NCeH32T6WffwDtTAaQWjccCnv1aDnY8=;
        b=d5wLp6zq9wwXGe/75isEFHSDc58FlS8/OHPOjVktA1LCPSaJb30DStjNod1lQM6A2w
         gHz97PZavsAG6MmdzQLpRyCzseyQrMZG/LhG7yo/2UBjZwVb1Y3e5JL81LPeGo/EiMbv
         ifpJkZLkd0d+HxkuM6LP0oA7dfZVc5riWdj8WM9A+LBcQW7uX1sNUnwZrhozuwGwWC4H
         hB6kDoeWk8c18Ql28NSjkpFAqcoBL8YXzQodckUWVA4pWkTlEemC4pwG+AAWSZbYhShv
         gxqq/ju8DJEzdufEFfKK6yOBMY4t+AW67rUMpG67W9Pm22pQEYss1lDOSw4olRT6z2Pk
         6i+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7OcGNq5n7OL7NCeH32T6WffwDtTAaQWjccCnv1aDnY8=;
        b=UpX7bmoFJhb/87Ecvs5CZoEHEvDJhkn8R9vFVo5gi/epIcQ9DwopnO+iTuXTk9FTno
         vVwZcB1LPjecOvv1dx5dantd74yMhT7NKWZpsmHZRmxcnwLoIaag5pgDDwFKQQjF/8wl
         KSz5kig21nIOK2UZlwFN6N5tyYywKjH0drXfs3LOkUujNvwJVCWJIU45v0+z+eGdsu2M
         QVLkIKLazr6J52RysJ4ajSPu7DGKlOo0EisTpTDxbKD1pRtJllxNOjGe4r+v3TWjBLe5
         RzC8Q/KeqrRD0tXF4hCBpQLT6LiaNWHf9jb6LOlIU86Yrb0dTK5EkXPfgvJ+8jg7ZDam
         7Vog==
X-Gm-Message-State: AJIora+5xvGse+dbdEPfUQwT2qkmIvJhb4uTP1RRAfC0YucVZVktKfVl
        KizfBMcLPZQ6gE/LuPAKZ8bbHVmpBn4/enptqKnmeg==
X-Google-Smtp-Source: AGRyM1vd2+VTOuirM6qNLzHH+tMAqMjBD/U8hapM6G4FiL1Gph9O7L4H/mnvEFv3FMrQ/hr4Aaou2XRjzil5EFw2Jg8=
X-Received: by 2002:a05:6638:138f:b0:341:4711:4c2c with SMTP id
 w15-20020a056638138f00b0034147114c2cmr10183257jad.178.1658973484043; Wed, 27
 Jul 2022 18:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220725083904.56552-1-huangjie.albert@bytedance.com>
 <20220725083904.56552-3-huangjie.albert@bytedance.com> <Yt6JRBToqY5ts6OU@zx2c4.com>
 <CABKxMyOcePkvAvMyrG2r08yRuxx=gK2SnMBFbKzKW6hBAdmRFw@mail.gmail.com>
In-Reply-To: <CABKxMyOcePkvAvMyrG2r08yRuxx=gK2SnMBFbKzKW6hBAdmRFw@mail.gmail.com>
From:   =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date:   Thu, 28 Jul 2022 09:57:53 +0800
Message-ID: <CABKxMyNjHVryZ4zuTkyPcsS=WVN-vVb4YFzzq3LKgVWgf01dyw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 2/4] kexec: add CONFING_KEXEC_PURGATORY_SKIP_SIG
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Michael Roth <michael.roth@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone know why this sha256 checksum is put here? I feel that it
is better to put it in the system call of kexec -e.
If the verification is not passed, the second kernel will not be
started, and some prompt information will be printed at the
same time, which seems to be better than when the second kernel is
started. Doing the verification operation will be more friendly,
 and it can also reduce downtime.

=E9=BB=84=E6=9D=B0 <huangjie.albert@bytedance.com> =E4=BA=8E2022=E5=B9=B47=
=E6=9C=8825=E6=97=A5=E5=91=A8=E4=B8=80 21:32=E5=86=99=E9=81=93=EF=BC=9A
>
> maybe a boot parameter ?
>
> Jason A. Donenfeld <Jason@zx2c4.com> =E4=BA=8E2022=E5=B9=B47=E6=9C=8825=
=E6=97=A5=E5=91=A8=E4=B8=80 20:15=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Hi Albert,
> >
> > On Mon, Jul 25, 2022 at 04:38:54PM +0800, Albert Huang wrote:
> > > +config KEXEC_PURGATORY_SKIP_SIG
> > > +     bool "skip kexec purgatory signature verification"
> > > +     depends on ARCH_HAS_KEXEC_PURGATORY
> > > +     help
> > > +       this options makes the kexec purgatory do  not signature veri=
fication
> > > +       which would get hundreds of milliseconds saved during kexec b=
oot. If we can
> > > +       confirm that the data of each segment loaded by kexec will no=
t change we may
> > > +       enable this option
> > > +
> >
> > Some grammar nits here, but actually, wouldn't it be better to make thi=
s
> > depend on some other signature things instead? Like if the parent kerne=
l
> > actually did a big signature computation, then maybe the purgatory step
> > is needed, but if it didn't bother, then maybe you can skip it. This
> > way, you don't need a compile-time option that might change some aspect
> > of signature verification people might otherwise be relying on.
> >
> > Jason
