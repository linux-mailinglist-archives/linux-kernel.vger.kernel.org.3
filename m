Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E786557A66C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 20:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240102AbiGSSXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 14:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiGSSX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 14:23:29 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DD65C962
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 11:23:28 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id a11so3334772wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 11:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NQRCSR2WG8er1FhdGOfttemdCe3XEsMa8dXWlWjyNw8=;
        b=Dev7X87CB5SrU1paX0aLZ1+Gcz3wYUyDgf/zZsSA+oLuRySUD7tRDvnFp9di/5e4vX
         sKqRbC371IPytuLFhWEqjWgmzGFGwA4yw6VGH1Nod0pyDgOLFE7F/P7FECTNwT5oiTV7
         Sd5cwBi0uhQ0KbLzBm1rbHDI3KKPw9HXCKIIu06+MxM0cE7KVMDeolPT4ZPjPHjE/DYD
         qB8WBoteOxI+Eg8BbfsSaxyg1aPAZjnHl88qURuXDtzwgXIyzzS3KQLWmtWIf5QaYa5W
         ZGlyfciWywxwsYPW1iA7dvcLLFDZZe2Q4CV9MTwIC73lzWaoxtGbou4nMfOV2cMUH6W/
         4S3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NQRCSR2WG8er1FhdGOfttemdCe3XEsMa8dXWlWjyNw8=;
        b=5Dm83XjWdRgdybYfbsB29+xZbNzkAYcxPFGZskxZ1hAEiheTx9dDGLhczHbIpUFitr
         Yp+1ImNV/gwD45oUbViPOdGAwyGOStXLCUHSEnXO8gdeU+ba6DyRfkQT/yQ0ICqYKOh4
         /cQJ+paGV9/VKS6nHlbYbN2ieNRwpsw54lbkeciJLDzzGPq7F4WW4dK1acEqY7jXJlVr
         cs6ttSxWPNY2MSfd35kQpydaT2g3I8ECGRBfxUHc/9QmJl3BK0Fgj+nNJewZRoColh8i
         yqPhbDEEBapVRltQ2cuVJrWXywEQq0E8bwHIEz0uC6f4uUAcSuKlZcjvtc8r0HzAEnbD
         DpmA==
X-Gm-Message-State: AJIora/NJReqcBh9vsKU6QXCOA98wVgflGxZT6nUA25Lp5grOkOgX6Ll
        WqElxvm9udImvedYy2JCoC2EFd/0OfclgxIya+ifAw==
X-Google-Smtp-Source: AGRyM1vSoSJtrZoPCR2Oh4eOeW/iTiccKQ3ClVq/gcCjafcraFgfslE49RLCAuKSpVUs2OkXwkAEMR3ln5pMXC3ZnlE=
X-Received: by 2002:a05:600c:3554:b0:3a3:1d70:9101 with SMTP id
 i20-20020a05600c355400b003a31d709101mr501679wmq.61.1658255006954; Tue, 19 Jul
 2022 11:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com>
 <20220715061027.1612149-9-kaleshsingh@google.com> <87cze252q7.wl-maz@kernel.org>
 <CAC_TJvcyb6xQhvuoSHpC6+LmeSAqbDk9Fnb=x-bB7UxxMek3EA@mail.gmail.com> <87ilntz8yh.wl-maz@kernel.org>
In-Reply-To: <87ilntz8yh.wl-maz@kernel.org>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Tue, 19 Jul 2022 11:23:16 -0700
Message-ID: <CAC_TJvc7_dKUhkHUHx8-bBC+-RPPasw1vTdjZwvVAGcUTQUnTg@mail.gmail.com>
Subject: Re: [PATCH v4 08/18] KVM: arm64: Add PROTECTED_NVHE_STACKTRACE Kconfig
To:     Marc Zyngier <maz@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Fuad Tabba <tabba@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Marco Elver <elver@google.com>, Keir Fraser <keirf@google.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Oliver Upton <oupton@google.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 3:35 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 18 Jul 2022 18:03:30 +0100,
> Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > On Sun, Jul 17, 2022 at 11:56 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > [- Drew and android-mm, as both addresses bounce]
> > >
> > > On Fri, 15 Jul 2022 07:10:17 +0100,
> > > Kalesh Singh <kaleshsingh@google.com> wrote:
> > > >
> > > > This can be used to disable stacktrace for the protected KVM
> > > > nVHE hypervisor, in order to save on the associated memory usage.
> > > >
> > > > This option is disabled by default, since protected KVM is not widely
> > > > used on platforms other than Android currently.
> > > >
> > > > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > > > ---
> > > >  arch/arm64/kvm/Kconfig | 15 +++++++++++++++
> > > >  1 file changed, 15 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> > > > index 8a5fbbf084df..1edab6f8a3b8 100644
> > > > --- a/arch/arm64/kvm/Kconfig
> > > > +++ b/arch/arm64/kvm/Kconfig
> > > > @@ -46,6 +46,21 @@ menuconfig KVM
> > > >
> > > >         If unsure, say N.
> > > >
> > > > +config PROTECTED_NVHE_STACKTRACE
> > > > +     bool "Protected KVM hypervisor stacktraces"
> > > > +     depends on KVM
> > > > +     default n
> > > > +     help
> > > > +       Say Y here to enable pKVM hypervisor stacktraces on hyp_panic()
> > > > +
> > > > +       If you are not using protected nVHE (pKVM), say N.
> > > > +
> > > > +       If using protected nVHE mode, but cannot afford the associated
> > > > +       memory cost (less than 0.75 page per CPU) of pKVM stacktraces,
> > > > +       say N.
> > > > +
> > > > +       If unsure, say N.
> > > > +
> > >
> > > Can we make this depend on NVHE_EL2_DEBUG instead? I'd like to keep
> > > the disclosing of EL2 information in protected mode a strict debug
> > > feature.
> >
> > Hi Marc,
> >
> > An earlier version was similar to what you propose. The unwinding
> > depended on NVHE_EL2_DEBUG and all unwinding was done from EL1 with
> > host stage 2 being disabled. The reason the design was changed is
> > because Android expressed the need for pKVM hyp stacktraces in
> > production environments. [1]
>
> I think that's an Android-specific requirement that doesn't apply to
> upstream. If Android wants to enable this in production (and
> potentially leak details of the hypervisor address space), that's
> Android's business, and they can carry a patch for that.  Upstream
> shouldn't have to cater for such a thing.

Hi Marc,

For android it's important to be able to debug issues from the field.
But I agree no need to subject upstream to the same requirements. I'll
guard this with the NVHE_EL2_DEBUG config in the next version.

Thanks,
Kalesh

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
