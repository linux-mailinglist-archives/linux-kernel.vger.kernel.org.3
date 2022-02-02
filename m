Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F884A7195
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236439AbiBBN3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiBBN3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:29:32 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CFBC061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 05:29:32 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id z7so28931655ljj.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 05:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ut1heMlmneP+6IiHVYaCsRV+iQnMtY/plsON5gFnw/s=;
        b=pSxMvG+egIt4WW80jF9dDVL3Z8lG/xgxzcN3gE1P+6SGJWoI6nsWsoHQEl+4+ug4UX
         gOar1xx+mu87pvf4RiobK4x+KVC1BJ0rMGMqGoKBLxkSpfVs45nt0jEUavC6xXXffZGS
         3a77UePfRjq+OPgpZjJkUwohMc5aUQDULSqqZwagYfF0RicMliSE9QWN0Hrn0IuXxiAt
         c9ViyFifNmmf1QaV6qNZXiz2p1HT/DmQ2aV8i4BCX+OIXIhGarMZzkeX/thOFYt3BPi1
         X8hme+1Sv7Cr9o2AxrucOVRe6/pynI7ogzarWIANwAiNk6dOQAL3W7orgc2jNEDuDVzJ
         upnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ut1heMlmneP+6IiHVYaCsRV+iQnMtY/plsON5gFnw/s=;
        b=bi+SL0x1b9CjWMqtx+5BD9xUAuOMPFwZbwptnujrGOicxO7EZGKgYVASNSkkvpqxv9
         NG9kP4BSMohLF1K807ZJ99+iNYYFJePeMeSCbskFzlOTtbziZ6buJoRO2iUJpSqGleB0
         MnkFx2rSgVYBiEZ/cinmCRIh+vfe2LrZqmYU6xpBqubw85otpPWXRXTaP95EJTnvsjIR
         RpV1q0MMglnc3bowzUGnNCxJu1yvpMyLMY/bKWInz7CjUubOJRIZmhH/Xb3ADC5PSSLF
         YNmVf/r3778b9hLehytTboLXBjEH6oJW2evzBlj0pjaK5aIhzCgdK6xfeJiOOz4xh8MD
         VR+A==
X-Gm-Message-State: AOAM533CnOT+ZUn5ihr0RyLpULwKT3NJfwGWopS1MlLYyn+NNUhScA8w
        scAet5scJJq9HFHw3vsRr7raegKy5fmkM3PYy9llxviaNSL5kQ==
X-Google-Smtp-Source: ABdhPJx5vsaf3f2A8imbwwx+BlfgfCJf+ICQ65e5a/dtBqayDqwZfU1QHrHiSP/evaTJiDLlffNcX5TPkt9HUMaKhUw=
X-Received: by 2002:a05:651c:a0b:: with SMTP id k11mr15027229ljq.266.1643808570290;
 Wed, 02 Feb 2022 05:29:30 -0800 (PST)
MIME-Version: 1.0
References: <20220131110307.1684739-1-mchitale@ventanamicro.com>
 <CAAhSdy2wX7Re4yepV7ReNQazF9jb-eqSUDE7rLCarr3iUchzkQ@mail.gmail.com> <B04F937F-6FC8-42F5-9D6B-7EF1148F9646@jrtc27.com>
In-Reply-To: <B04F937F-6FC8-42F5-9D6B-7EF1148F9646@jrtc27.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 2 Feb 2022 18:59:18 +0530
Message-ID: <CAK9=C2WPmH4snAH1Ft4jNoaNuLRQ9dEuYm_K4ePVHdS9wkBYPA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: make CY, TM, and IR counters accessible in
 VU mode
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Anup Patel <anup@brainfault.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        kvm-riscv@lists.infradead.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 6:49 PM Jessica Clarke <jrtc27@jrtc27.com> wrote:
>
> On 2 Feb 2022, at 11:14, Anup Patel <anup@brainfault.org> wrote:
> >
> > On Mon, Jan 31, 2022 at 4:33 PM Mayuresh Chitale
> > <mchitale@ventanamicro.com> wrote:
> >>
> >> Those applications that run in VU mode and access the time CSR cause
> >> a virtual instruction trap as Guest kernel currently does not
> >> initialize the scounteren CSR.
> >>
> >> To fix this, we should make CY, TM, and IR counters accessibile
> >> by default in VU mode (similar to OpenSBI).
> >>
> >> Fixes: a33c72faf2d73 ("RISC-V: KVM: Implement VCPU create, init and
> >> destroy functions")
> >> Cc:stable@vger.kernel.org
> >> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> >
> > Thanks, I have queued this for fixes.
>
> The formatting is clearly wrong...

I have updated this in my fixes queue.

>
> > Regards,
> > Anup
> >
> >> ---
> >> arch/riscv/kvm/vcpu.c | 4 ++++
> >> 1 file changed, 4 insertions(+)
> >>
> >> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> >> index 0c5239e05721..caaf824347b9 100644
> >> --- a/arch/riscv/kvm/vcpu.c
> >> +++ b/arch/riscv/kvm/vcpu.c
> >> @@ -90,6 +90,7 @@ int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
> >> int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
> >> {
> >>        struct kvm_cpu_context *cntx;
> >> +       struct kvm_vcpu_csr *reset_csr = &vcpu->arch.guest_reset_csr;
> >>
> >>        /* Mark this VCPU never ran */
> >>        vcpu->arch.ran_atleast_once = false;
> >> @@ -106,6 +107,9 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
> >>        cntx->hstatus |= HSTATUS_SPVP;
> >>        cntx->hstatus |= HSTATUS_SPV;
> >>
> >> +       /* By default, make CY, TM, and IR counters accessible in VU mode */
> >> +       reset_csr->scounteren=0x7;
>
> ... here

Same as above, I have updated this my queue as well.

Thanks,
Anup

>
> Jess
>
> >> +
> >>        /* Setup VCPU timer */
> >>        kvm_riscv_vcpu_timer_init(vcpu);
> >>
> >> --
> >> 2.25.1
> >>
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
