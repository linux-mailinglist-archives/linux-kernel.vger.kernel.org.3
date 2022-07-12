Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C3657193B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbiGLL5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiGLL5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:57:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEEAE65DB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657627024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ne2+6mQ+Olc8xUTQbYHS1Uk/HE21HVTiNLAnJ6kuYc=;
        b=S447IunVeJwNaGpEaGjADwCNnwuy65i6R/1GVOV5ZjFK42qRzAwDD8/Q1cBSOHCs4OBRlA
        38RB24dTkuR9Q8kCNRCYzlCi7LxmNJhI/ZwR/YBscjOWAvI6s8oMVPf5NQgmqWtxMKcce2
        kUbO+r1jqgt9MuYVW4EcUkrU/z13U3o=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-VmNTZXKzNAmEYcKWgG8x1Q-1; Tue, 12 Jul 2022 07:57:03 -0400
X-MC-Unique: VmNTZXKzNAmEYcKWgG8x1Q-1
Received: by mail-qv1-f69.google.com with SMTP id q4-20020a0ce9c4000000b00473004919ddso1666203qvo.16
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=3ne2+6mQ+Olc8xUTQbYHS1Uk/HE21HVTiNLAnJ6kuYc=;
        b=3wMtVvH2IPPjnlUVnUSpEOEDvqfWtI1G031ZiHGgi8TucECHya3Ozh7IKJqTL7GknD
         vpgsBBhxXHiziH4irIWP7KY8r0aff6js9g/57yYGOAZuR3eF2VOgvhQ5/1Z7lAQ4SJI8
         Wqd2b+XpTJmMPEjswxRVgv6WyjiGqDJ2kZN7VCXJldaK6d5JO9h4hhFZUwPW+CJNJD8U
         KasekPB46tSrJyi53VHbJqrYoF6FPHgIxQBt1V9JOPZU4PYa/40WkRCIQ5uCMVVH9UAN
         bO32n1n5DJbwDefpEWI8wRrTJ6IQruesc/rJQ3CXkFb76ymPB55Xsznh57FMfMrEzGtm
         7Mqw==
X-Gm-Message-State: AJIora8zoDKeooXKkKw9z9Q/yTTuUsrIML3AnPOki5YsJxPwzfJ2hLMF
        fA0nq24hT+CtAwsT1yoHITDARINoh7TNop+gcvs0b/PQCE+41ReO/CS9j1CVMmwWJjG7AJ3rnfD
        YJ2fcD909epPWBD1ppuGxNo+G
X-Received: by 2002:a05:6214:f22:b0:472:f00d:7e14 with SMTP id iw2-20020a0562140f2200b00472f00d7e14mr16687973qvb.20.1657627023059;
        Tue, 12 Jul 2022 04:57:03 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tuqCewMUF6qq2QaY5sl7A6uBGYI/u8wZ95DM2kKbiwQVsePtNXNWXdEb9l++OUOfjeAuQZ8Q==
X-Received: by 2002:a05:6214:f22:b0:472:f00d:7e14 with SMTP id iw2-20020a0562140f2200b00472f00d7e14mr16687959qvb.20.1657627022899;
        Tue, 12 Jul 2022 04:57:02 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id bj17-20020a05620a191100b006a6ad90a117sm9030691qkb.105.2022.07.12.04.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 04:57:02 -0700 (PDT)
Message-ID: <b648160c9bbf81f820b0c0bc8512c4e28fb1fc33.camel@redhat.com>
Subject: Re: [PATCH v3 16/25] KVM: VMX: Move
 CPU_BASED_CR8_{LOAD,STORE}_EXITING filtering out of setup_vmcs_config()
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Jul 2022 14:56:58 +0300
In-Reply-To: <20220708144223.610080-17-vkuznets@redhat.com>
References: <20220708144223.610080-1-vkuznets@redhat.com>
         <20220708144223.610080-17-vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-07-08 at 16:42 +0200, Vitaly Kuznetsov wrote:
> As a preparation to reusing the result of setup_vmcs_config() in
> nested VMX MSR setup, move CPU_BASED_CR8_{LOAD,STORE}_EXITING filtering
> to vmx_exec_control().
> 
> No functional change intended.
> 
> Reviewed-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 93ca9ff8e641..d7170990f469 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2479,11 +2479,6 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>                                 MSR_IA32_VMX_PROCBASED_CTLS,
>                                 &_cpu_based_exec_control) < 0)
>                 return -EIO;
> -#ifdef CONFIG_X86_64
> -       if (_cpu_based_exec_control & CPU_BASED_TPR_SHADOW)
> -               _cpu_based_exec_control &= ~CPU_BASED_CR8_LOAD_EXITING &
> -                                          ~CPU_BASED_CR8_STORE_EXITING;
> -#endif
>         if (_cpu_based_exec_control & CPU_BASED_ACTIVATE_SECONDARY_CONTROLS) {
>                 if (adjust_vmx_controls(KVM_REQ_VMX_SECONDARY_VM_EXEC_CONTROL,
>                                         KVM_OPT_VMX_SECONDARY_VM_EXEC_CONTROL,
> @@ -4248,13 +4243,17 @@ static u32 vmx_exec_control(struct vcpu_vmx *vmx)
>         if (vmx->vcpu.arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT)
>                 exec_control &= ~CPU_BASED_MOV_DR_EXITING;
>  
> -       if (!cpu_need_tpr_shadow(&vmx->vcpu)) {
> +       if (!cpu_need_tpr_shadow(&vmx->vcpu))
>                 exec_control &= ~CPU_BASED_TPR_SHADOW;
> +
>  #ifdef CONFIG_X86_64
> +       if (exec_control & CPU_BASED_TPR_SHADOW)
> +               exec_control &= ~(CPU_BASED_CR8_LOAD_EXITING |
> +                                 CPU_BASED_CR8_STORE_EXITING);
> +       else
>                 exec_control |= CPU_BASED_CR8_STORE_EXITING |
>                                 CPU_BASED_CR8_LOAD_EXITING;
>  #endif
> -       }
>         if (!enable_ept)
>                 exec_control |= CPU_BASED_CR3_STORE_EXITING |
>                                 CPU_BASED_CR3_LOAD_EXITING  |

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


