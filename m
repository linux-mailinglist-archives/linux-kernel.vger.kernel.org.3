Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76FD57192C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbiGLL4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbiGLLzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:55:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D082B5D2E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657626909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qjIYMYGc62E0BbWvxRB7WEHJptMLkEdJ4uHka19dQgQ=;
        b=bAHZ8xP7rfRhLmRu/iif0bid8lnROxDg0kbcHoc5AxU+mzCUVxmA2BlZOUejLNVP7db6O3
        zxAL/y3VniEXrkhburFDD58ErEgt6rb1fd+bHY+68Cvn/8qs0cu0Uyj1xU0zwGeNOJdp4g
        zb4JRU7d/lwP/mEMj3gMlHqfbfaHCd0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-RKkk78bnMJKBWAGiPnm7ag-1; Tue, 12 Jul 2022 07:55:08 -0400
X-MC-Unique: RKkk78bnMJKBWAGiPnm7ag-1
Received: by mail-qk1-f199.google.com with SMTP id l15-20020a05620a28cf00b006b46997c070so7687048qkp.20
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=qjIYMYGc62E0BbWvxRB7WEHJptMLkEdJ4uHka19dQgQ=;
        b=gRdSzPYjeST3JbiPEkwotMWQYfRgkY7u4weF8yByBnBNe9pgkq+DM3dYPajhK+16G3
         Ya6Hlk5lDfLS2sP9IzGqzQrPkGRgb4LPh0VCFhv0NCTRGeV8r/6CztKCx6YbVimp39lb
         W7W3jxK3Yh0y3YMzqjIz42qDn3wQVPCXdwNbbEOn8sol8DhiRgZbZ4OTdoGPI26Kqi06
         VL/wig2cSC2MrdyVDqM/0T0xyLRr89zCwfBNDQWDClYc4GUsy1xdDOjJ2EiXOxXckpBa
         f6mMuyiC+3cOE3NTfNtd+uuKDx3FUwrZHW+RRm0R464dt5s45MG2Y/ycCo7FZV5Q0bNt
         cEbA==
X-Gm-Message-State: AJIora+TcuUVw1GtQgAFJmHhd+OSkS2KLDPY08TuDWeqkzTwKC/40lkY
        rH02AHuxVPDjnDN7y/9POlBUvUlLxKtSkdEVNwO48/5OT8WXv3V/xO13lprT+g08pSR5LU856j2
        a1z+F7L+OPdzUkfUNYn/X0uhG
X-Received: by 2002:ac8:5b50:0:b0:31e:ac0f:8aa3 with SMTP id n16-20020ac85b50000000b0031eac0f8aa3mr12462564qtw.435.1657626907709;
        Tue, 12 Jul 2022 04:55:07 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1slSf1BriwdzlNAC9gslv5iv7v/Dul11Kb2D11OfX783hkIDavHA5m8MsNcXYI+d+ZlUswq1Q==
X-Received: by 2002:ac8:5b50:0:b0:31e:ac0f:8aa3 with SMTP id n16-20020ac85b50000000b0031eac0f8aa3mr12462554qtw.435.1657626907499;
        Tue, 12 Jul 2022 04:55:07 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id t10-20020a05620a450a00b006b54e630a98sm3035507qkp.96.2022.07.12.04.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 04:55:06 -0700 (PDT)
Message-ID: <67e0fb26400844f05c4ffba16bf80ea2496b79df.camel@redhat.com>
Subject: Re: [PATCH v3 12/25] KVM: VMX: Check VM_ENTRY_IA32E_MODE in
 setup_vmcs_config()
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Jul 2022 14:55:03 +0300
In-Reply-To: <20220708144223.610080-13-vkuznets@redhat.com>
References: <20220708144223.610080-1-vkuznets@redhat.com>
         <20220708144223.610080-13-vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-07-08 at 16:42 +0200, Vitaly Kuznetsov wrote:
> VM_ENTRY_IA32E_MODE control is toggled dynamically by vmx_set_efer()
> and setup_vmcs_config() doesn't check its existence. On the contrary,
> nested_vmx_setup_ctls_msrs() doesn set it on x86_64. Add the missing
> check and filter the bit out in vmx_vmentry_ctrl().
> 
> No (real) functional change intended as all existing CPUs supporting
> long mode and VMX are supposed to have it.
> 
> Reviewed-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index dd905ad72637..1aaec4d19e1b 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2610,6 +2610,9 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>                 _pin_based_exec_control &= ~PIN_BASED_POSTED_INTR;
>  
>         min = VM_ENTRY_LOAD_DEBUG_CONTROLS;
> +#ifdef CONFIG_X86_64
> +       min |= VM_ENTRY_IA32E_MODE;
> +#endif
>         opt = VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
>               VM_ENTRY_LOAD_IA32_PAT |
>               VM_ENTRY_LOAD_IA32_EFER |
> @@ -4242,9 +4245,14 @@ static u32 vmx_vmentry_ctrl(void)
>         if (vmx_pt_mode_is_system())
>                 vmentry_ctrl &= ~(VM_ENTRY_PT_CONCEAL_PIP |
>                                   VM_ENTRY_LOAD_IA32_RTIT_CTL);
> -       /* Loading of EFER and PERF_GLOBAL_CTRL are toggled dynamically */
> -       return vmentry_ctrl &
> -               ~(VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL | VM_ENTRY_LOAD_IA32_EFER);
> +       /*
> +        * IA32e mode, and loading of EFER and PERF_GLOBAL_CTRL are toggled dynamically.
> +        */
> +       vmentry_ctrl &= ~(VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
> +                         VM_ENTRY_LOAD_IA32_EFER |
> +                         VM_ENTRY_IA32E_MODE);
> +
> +       return vmentry_ctrl;
>  }
>  
>  static u32 vmx_vmexit_ctrl(void)

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

