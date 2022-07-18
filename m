Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24728577EC9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbiGRJh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbiGRJhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:37:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 031321ADAC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658137034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h3W9LFUtphIHBmLct6LbkfBYwwCjHm4BOKd/7U7nvQ4=;
        b=Bcq9bTTK64yqTfUPBWXAcSiOBjgq8BxkifmAXKH12TkwomOJyA8QD36bhU+p9TlUEZ5em0
        gv2aBsFOlHYbNH7uL+1uP+jtlXHnjAD4BZXbqPCBJ1KrDWqvtSSXz3KqpGdl9rPMSG4Rub
        CSUv3AXS5Q1RZ5Yfpe8/8vBl36W73q4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-L9cTy2dPPC2d-pJ1r_OBLQ-1; Mon, 18 Jul 2022 05:37:13 -0400
X-MC-Unique: L9cTy2dPPC2d-pJ1r_OBLQ-1
Received: by mail-qk1-f199.google.com with SMTP id ay35-20020a05620a17a300b006b5d9646d31so5082011qkb.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=h3W9LFUtphIHBmLct6LbkfBYwwCjHm4BOKd/7U7nvQ4=;
        b=zo+91+RkfQAoVmaY/zgicsB4SxU8Kc8bjENSp2Tapc+cw16FIQ9swxP00l29P8Ueaj
         Ygaj8bL6OPf2nwHNfVLxndtFrqzoMmBmkcEuASrKp06iQvlWkSshzSXkOPuJNeMeZkKZ
         dmU/xAoosABoatzMOeq1BnySl2n0zQbur0mfkfZvxa3qlOhYtNa45wqV4+AVkjuevPsV
         ToMQtqQM97wKJvv42Cc/NwOI14QsOa4t1xZaRhHF8NvT+APM1Z2TPn7FYKnN4IAqPAj/
         Bo5lar2Op0ZrJmsfgLmEl5gPDR2ZHBDCXdw1QZrGavg7RU5WmWzjurEuCKws/AkvDq/X
         mJ6A==
X-Gm-Message-State: AJIora+pK7FOr8z3EX4Vsn8A/PnmQjfZy/siIzx1oY+NMJN+uHkuBSox
        Grzujf7bXJnkCnauzw4Ox3WI171ztWelt2qUcZDL/2IlhVDKKWTTS1IUxcwkB310LjewLn0kb7j
        giIH1ENdNUr0k+Pcd0PuAzqFc
X-Received: by 2002:ac8:5910:0:b0:315:534d:b74e with SMTP id 16-20020ac85910000000b00315534db74emr21190221qty.475.1658137032524;
        Mon, 18 Jul 2022 02:37:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tHkKddwAUBvrNP6S422BvgT3NFa1fann+Q0IVtCXe5r52OCXqo/1IS+R+MBZmtQKONfdZ5Cg==
X-Received: by 2002:ac8:5910:0:b0:315:534d:b74e with SMTP id 16-20020ac85910000000b00315534db74emr21190213qty.475.1658137032275;
        Mon, 18 Jul 2022 02:37:12 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id v3-20020a05620a440300b006a6a4b43c01sm4666677qkp.38.2022.07.18.02.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 02:37:11 -0700 (PDT)
Message-ID: <028a575079cee20cbbf41bca8a734e16535d179e.camel@redhat.com>
Subject: Re: [PATCH] KVM: x86: Do not block APIC write for non ICR registers
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, jon.grimm@amd.com,
        Zeng Guang <guang.zeng@intel.com>
Date:   Mon, 18 Jul 2022 12:37:07 +0300
In-Reply-To: <20220718083913.222140-1-suravee.suthikulpanit@amd.com>
References: <20220718083913.222140-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-07-18 at 03:39 -0500, Suravee Suthikulpanit wrote:
> The commit 5413bcba7ed5 ("KVM: x86: Add support for vICR APIC-write
> VM-Exits in x2APIC mode") introduces logic to prevent APIC write
> for offset other than ICR. This breaks x2AVIC support, which requires
> KVM to trap and emulate x2APIC MSR writes.
> 
> Therefore, removes the warning and modify to logic to allow MSR write.
> 
> Fixes: 5413bcba7ed5 ("KVM: x86: Add support for vICR APIC-write VM-Exits in x2APIC mode")
> Cc: Zeng Guang <guang.zeng@intel.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  arch/x86/kvm/lapic.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 9d4f73c4dc02..f688090d98b0 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -69,6 +69,7 @@ static bool lapic_timer_advance_dynamic __read_mostly;
>  /* step-by-step approximation to mitigate fluctuation */
>  #define LAPIC_TIMER_ADVANCE_ADJUST_STEP 8
>  static int kvm_lapic_msr_read(struct kvm_lapic *apic, u32 reg, u64 *data);
> +static int kvm_lapic_msr_write(struct kvm_lapic *apic, u32 reg, u64 data);
>  
>  static inline void __kvm_lapic_set_reg(char *regs, int reg_off, u32 val)
>  {
> @@ -2284,17 +2285,23 @@ void kvm_apic_write_nodecode(struct kvm_vcpu *vcpu, u32 offset)
>         u64 val;
>  
>         if (apic_x2apic_mode(apic)) {
> +               kvm_lapic_msr_read(apic, offset, &val);
> +
>                 /*
>                  * When guest APIC is in x2APIC mode and IPI virtualization
>                  * is enabled, accessing APIC_ICR may cause trap-like VM-exit
>                  * on Intel hardware. Other offsets are not possible.
> +                *
> +                * For AMD AVIC, write to some APIC registers can cause
> +                * trap-like VM-exit (see arch/x86/kvm/svm/avic.c:
> +                * avic_unaccel_trap_write()).
>                  */
> -               if (WARN_ON_ONCE(offset != APIC_ICR))
> +               if (offset == APIC_ICR) {
> +                       kvm_apic_send_ipi(apic, (u32)val, (u32)(val >> 32));
> +                       trace_kvm_apic_write(APIC_ICR, val);
>                         return;
> -
> -               kvm_lapic_msr_read(apic, offset, &val);
> -               kvm_apic_send_ipi(apic, (u32)val, (u32)(val >> 32));
> -               trace_kvm_apic_write(APIC_ICR, val);
> +               }
> +               kvm_lapic_msr_write(apic, offset, val);
>         } else {
>                 val = kvm_lapic_get_reg(apic, offset);
>  


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

