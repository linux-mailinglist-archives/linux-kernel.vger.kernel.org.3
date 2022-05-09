Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA0F51F413
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbiEIFoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 01:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbiEIFhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 01:37:45 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B921550EF
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 22:33:47 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t6so17815055wra.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 22:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PLUNZth0Gzu0RXkdCxlC7YsvIKkko3pZWci/8TjWfsg=;
        b=1fEjcPA9ZwqimNLicimZh7D54btJlReV6ttUi5sPPHZnlucnlayki28FnMUzJ/QL9Y
         M3c5KF+PPpNktxtj878OD+pC4SkuQy2P6dLZQYUe2Cujk0Gb7K/0i0a8L3+IV/hrdY4w
         clL8WGuArZLzgWuOlj6y5KUXWtm0lP97uo8OZdfkDmwLMoLvksx9f6ufrBVKNZkXmh5d
         nyuQNHzTw/00jpMFdO8AU/V3rp4KrVfb5sHGTxhTXdr+wSJhwyUxsMYI6zF73msEMXuS
         oNnwgVMaQmo1HLNVjh1tA9fH8g64Xjq73hzz8gXkMiEDk3tyUN8wHgrRYsJh1psS5+Rt
         GXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PLUNZth0Gzu0RXkdCxlC7YsvIKkko3pZWci/8TjWfsg=;
        b=rDScGcW3BC95VMIyaEZMGhUBSeW+0dAS6hRjuRF0NCGRHoBszMWz4L/wq4IoEu0hXQ
         31p6cXTlcLQwA21t41bJzU/nnzZG/weMfeJTV2q3zrK5lCICCu5bQJkV+BPCuv4u7Aro
         0QQTXsC9amyQSM8jldrOhChttNtB5O3ITSfNi4EfDmgKgAVe//BrFyA/UNhESLoGHhJt
         PPXFXW0x86Qh7k/UhZ1ynFjX93vJFT3+HXOeMhq5kUZU9NZsCPAAto8PFywMNBRKNk93
         28tzteRrn+AlqxYS1WGvfz6glW6k93uZfqQ3FgxUgi9tg34pOHnDbLTGapKO8DOP/U2f
         ulqQ==
X-Gm-Message-State: AOAM533XYtG3HZNAL0aJuPlidyfnVW7eh9xzY9iV6PPynP6ySornEmgr
        9VrRZ0+9hLhqgCGpjdt2SB+6YPcYnFPG11IlujU9KQ==
X-Google-Smtp-Source: ABdhPJwm5HiGVrJo6H6A2ZwkRwo0cXAPq+C8yDH3Ar/UxfL9RCxY1/yZPp8l+hlWdvpp1E/Vv7lPAPz1K2H2BhU6/ug=
X-Received: by 2002:a05:6000:12d1:b0:20a:d901:3828 with SMTP id
 l17-20020a05600012d100b0020ad9013828mr11892146wrx.313.1652074425312; Sun, 08
 May 2022 22:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220420112450.155624-1-apatel@ventanamicro.com>
 <20220420112450.155624-6-apatel@ventanamicro.com> <CAOnJCU+yd7hqauHRYwnPqNKEgfy5FK06ezR64aH0Hm2AcNNadw@mail.gmail.com>
In-Reply-To: <CAOnJCU+yd7hqauHRYwnPqNKEgfy5FK06ezR64aH0Hm2AcNNadw@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 9 May 2022 11:03:34 +0530
Message-ID: <CAAhSdy1vwQ6BmjzvSuJHc8V37U78PPjGS19+XEQHHqE1=nQRpg@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] RISC-V: KVM: Reduce KVM_MAX_VCPUS value
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        KVM General <kvm@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv)" 
        <kvm-riscv@lists.infradead.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 4, 2022 at 7:45 AM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Wed, Apr 20, 2022 at 4:25 AM Anup Patel <apatel@ventanamicro.com> wrote:
> >
> > Currently, the KVM_MAX_VCPUS value is 16384 for RV64 and 128
> > for RV32.
> >
> > The KVM_MAX_VCPUS value is too high for RV64 and too low for
> > RV32 compared to other architectures (e.g. x86 sets it to 1024
> > and ARM64 sets it to 512). The too high value of KVM_MAX_VCPUS
> > on RV64 also leads to VCPU mask on stack consuming 2KB.
> >
> > We set KVM_MAX_VCPUS to 1024 for both RV64 and RV32 to be
> > aligned other architectures.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  arch/riscv/include/asm/kvm_host.h | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
> > index 806f74dc0bfc..61d8b40e3d82 100644
> > --- a/arch/riscv/include/asm/kvm_host.h
> > +++ b/arch/riscv/include/asm/kvm_host.h
> > @@ -16,8 +16,7 @@
> >  #include <asm/kvm_vcpu_fp.h>
> >  #include <asm/kvm_vcpu_timer.h>
> >
> > -#define KVM_MAX_VCPUS                  \
> > -       ((HGATP_VMID_MASK >> HGATP_VMID_SHIFT) + 1)
> > +#define KVM_MAX_VCPUS                  1024
> >
> >  #define KVM_HALT_POLL_NS_DEFAULT       500000
> >
> > --
> > 2.25.1
> >
>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>

Queued this patch for 5.19

Thanks,
Anup

>
> --
> Regards,
> Atish
