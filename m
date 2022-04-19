Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC5B506238
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 04:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345074AbiDSCp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 22:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiDSCpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 22:45:25 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2041DA65
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 19:42:43 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b19so20548886wrh.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 19:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NaZKghXfb3DoOx4eVJC6+gBDrMqsAj++iAp6qrZ51XE=;
        b=IOIawwuxeBpnPEW4muE+XmTP8tzJk+lOOZEPTVzGnnqkLERhpykUDERNuCeJW3dVWg
         F2fDXw4eW11ZRZ5O9TthYSN0mD67aAmgu8DVvp2E9JLQVJqa1jgm9s4vfF5w9amWFiWr
         s6v5e19V488KeCa61wXdMxsctCCtoRmaenKJKaPPlloMlSrxMXlwzDzmYDtQY5C2YsxM
         4lW/gEU1+nWPyqqg0ks5HwcAeQj/MpcAdfDy4UUFPpvKuahhdYdPjab3mvGFWVEMK0ne
         kAKhEeDMA20ZxRhIwrufTTknIPRk3Qf+MDIXPC46uwTSUxq7HP/4e023CZey2PT8PFSp
         iLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NaZKghXfb3DoOx4eVJC6+gBDrMqsAj++iAp6qrZ51XE=;
        b=E/TtAU9AwuMNeUxGuzvX0bujHqS4aC5AY5O3g0mykurQrhU5v3cYnuIRqgYOBi7x9J
         JXsfm21yXV8AEd7HdsUnlSwfMScocBKLy2NU2hO9WcKMHFLYsS57NDLNt+qKFuk/1HTp
         2dpMU5uGSGfxX4/zPpKiBS0QyIvLQWxHv/y6gWJdbbgHh76nYgpksaDm55shUbLASegI
         n750ZDc/PS67fn2DsEV1j3PjJ3rrgfOoAbjkpUcI1ZmuSyj75uUxH5ftAFEYaybo7KOt
         VYVYyZZ7ie1UpstWQNPcczLgAo5L/btw9YivVYLyLH6r2pYJBWZIFrMNsv643h4w8n/4
         287g==
X-Gm-Message-State: AOAM531TBUi72IiFlFqZBEt63HDlsmIFhHEdsAdep8CTimJzmMZm5AKi
        hW6GpT4JpasW3VXqLbxJQ8lrj8n8WaAN01QkyJkuXg==
X-Google-Smtp-Source: ABdhPJwlJs4gJ4Ap7DqcjRwmKIBky5cw2JqOihJw3PpLKISM9MLa1vtSULvwejGmcmEXeoX04fS0XL9k/bB0wj9zdrM=
X-Received: by 2002:a5d:5487:0:b0:20a:8f45:8f34 with SMTP id
 h7-20020a5d5487000000b0020a8f458f34mr7573081wrv.699.1650336162246; Mon, 18
 Apr 2022 19:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220408200349.1529080-1-kaleshsingh@google.com>
 <20220408200349.1529080-7-kaleshsingh@google.com> <87tuaqae7h.wl-maz@kernel.org>
In-Reply-To: <87tuaqae7h.wl-maz@kernel.org>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Mon, 18 Apr 2022 19:42:31 -0700
Message-ID: <CAC_TJvfZD0KAM9z3+GEpNDJxanePuq+xFgauaMyYabGhPPuvQA@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] KVM: arm64: Symbolize the nVHE HYP addresses
To:     Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Quentin Perret <qperret@google.com>,
        Fuad Tabba <tabba@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Walbran <qwandor@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Changbin Du <changbin.du@intel.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 3:16 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Fri, 08 Apr 2022 21:03:29 +0100,
> Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > Reintroduce the __kvm_nvhe_ symbols in kallsyms, ignoring the local
> > symbols in this namespace. The local symbols are not informative and
> > can cause aliasing issues when symbolizing the addresses.
> >
> > With the necessary symbols now in kallsyms we can symbolize nVHE
> > addresses using the %p print format specifier:
> >
> > [   98.916444][  T426] kvm [426]: nVHE hyp panic at: [<ffffffc0096156fc=
>] __kvm_nvhe_overflow_stack+0x8/0x34!
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > Tested-by: Fuad Tabba <tabba@google.com>
> > Reviewed-by: Fuad Tabba <tabba@google.com>
> > ---
> >
> > Changes in v6:
> >   - Add Fuad's Reviewed-by and Tested-by tags.
> >
> > Changes in v2:
> >   - Fix printk warnings - %p expects (void *)
> >
> >
> >  arch/arm64/kvm/handle_exit.c | 13 +++++--------
> >  scripts/kallsyms.c           |  2 +-
> >  2 files changed, 6 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.=
c
> > index 97fe14aab1a3..a377b871bf58 100644
> > --- a/arch/arm64/kvm/handle_exit.c
> > +++ b/arch/arm64/kvm/handle_exit.c
> > @@ -295,13 +295,8 @@ void __noreturn __cold nvhe_hyp_panic_handler(u64 =
esr, u64 spsr,
> >       u64 elr_in_kimg =3D __phys_to_kimg(elr_phys);
> >       u64 hyp_offset =3D elr_in_kimg - kaslr_offset() - elr_virt;
> >       u64 mode =3D spsr & PSR_MODE_MASK;
> > +     u64 panic_addr =3D elr_virt + hyp_offset;
> >
> > -     /*
> > -      * The nVHE hyp symbols are not included by kallsyms to avoid iss=
ues
> > -      * with aliasing. That means that the symbols cannot be printed w=
ith the
> > -      * "%pS" format specifier, so fall back to the vmlinux address if
> > -      * there's no better option.
> > -      */
> >       if (mode !=3D PSR_MODE_EL2t && mode !=3D PSR_MODE_EL2h) {
> >               kvm_err("Invalid host exception to nVHE hyp!\n");
> >       } else if (ESR_ELx_EC(esr) =3D=3D ESR_ELx_EC_BRK64 &&
> > @@ -321,9 +316,11 @@ void __noreturn __cold nvhe_hyp_panic_handler(u64 =
esr, u64 spsr,
> >               if (file)
> >                       kvm_err("nVHE hyp BUG at: %s:%u!\n", file, line);
> >               else
> > -                     kvm_err("nVHE hyp BUG at: %016llx!\n", elr_virt +=
 hyp_offset);
> > +                     kvm_err("nVHE hyp BUG at: [<%016llx>] %pB!\n", pa=
nic_addr,
> > +                                     (void *)panic_addr);
> >       } else {
> > -             kvm_err("nVHE hyp panic at: %016llx!\n", elr_virt + hyp_o=
ffset);
> > +             kvm_err("nVHE hyp panic at: [<%016llx>] %pB!\n", panic_ad=
dr,
> > +                             (void *)panic_addr);
> >       }
> >
> >       /*
> > diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> > index 8caabddf817c..ad2c93640a92 100644
> > --- a/scripts/kallsyms.c
> > +++ b/scripts/kallsyms.c
> > @@ -111,7 +111,7 @@ static bool is_ignored_symbol(const char *name, cha=
r type)
> >               ".L",                   /* local labels, .LBB,.Ltmpxxx,.L=
__unnamed_xx,.LASANPC, etc. */
> >               "__crc_",               /* modversions */
> >               "__efistub_",           /* arm64 EFI stub namespace */
> > -             "__kvm_nvhe_",          /* arm64 non-VHE KVM namespace */
> > +             "__kvm_nvhe_$",         /* arm64 local symbols in non-VHE=
 KVM namespace */
> >               "__AArch64ADRPThunk_",  /* arm64 lld */
> >               "__ARMV5PILongThunk_",  /* arm lld */
> >               "__ARMV7PILongThunk_",
>
> If you are sanitising this, shouldn'tt you also apply the same rules
> as the rest of the kernel for non-'__-kvm_nvhe_' symbols? For example,
> I see a long list of .L* symbols:
>
> 0000000000000000 r __kvm_nvhe_.L144721
> 0000000000000090 r __kvm_nvhe_.L144721
> 00000000000000b4 r __kvm_nvhe_.L144721
> 00000000000004b0 r __kvm_nvhe_.L144721
> 000000000000051c r __kvm_nvhe_.L144721
> 0000000000000650 r __kvm_nvhe_.L144721
> 0000000000000694 r __kvm_nvhe_.L144721
> 0000000000000761 r __kvm_nvhe_.L144721
> 00000000000007a7 r __kvm_nvhe_.L144721
> 00000000000007c7 r __kvm_nvhe_.L144721
> 0000000000000814 r __kvm_nvhe_.L144721
> 0000000000000b08 r __kvm_nvhe_.L144721
> 0000000000003200 r __kvm_nvhe_.L144721
>
> (83 of them in total on a local build) that I think should also be
> trimmed.

Good catch. I=E2=80=99ll fix it in the next version along with your other
comments. Thanks for the reviews Mark.

-Kalesh

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
