Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D0457198A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbiGLMMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbiGLMMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:12:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AB7AB31CA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 05:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657627916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A9nXHDLA+aj6px0VjCk5pTVFb/x1kM7mKf9a3TUvwwQ=;
        b=ORoqmY6jIxT8n5odG1bq2gN/ees1tJdFxHhqaiC6si4x6F3SZqPb7YLFve2NAQECJv1Kvx
        sAFkQuKgotybuTQFQTAQNlYj0TCz2my7qYnGXg6Xth+mogSkvbakLxFT7MX1s2nMq2Yk2s
        PPX3/si5UY8ekPrygiJvvH26q/hsRU4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317-Hy3Nv0SGMsqTFtNa4kPyaw-1; Tue, 12 Jul 2022 08:11:55 -0400
X-MC-Unique: Hy3Nv0SGMsqTFtNa4kPyaw-1
Received: by mail-qt1-f199.google.com with SMTP id bs7-20020ac86f07000000b0031d3efbb91aso6826574qtb.21
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 05:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=A9nXHDLA+aj6px0VjCk5pTVFb/x1kM7mKf9a3TUvwwQ=;
        b=X0y0/oRXz/ih9/WYTLyTOjzlaOs9hP9gcdn5rXT3apkBUGL/m1tS28yWHnlRvrejCg
         TIK4iUXdqlZygxMmo+pDZEkbBtjnNU1Z6nwuw1777o6nrBIwVFLuoeRinrDqT+AuuGI2
         ivKANobdytsuEgBTXYz0ZDwLJgSOWEI2hWIxeePldo4O/cJV1FhzCRv2jEhf4ZSHnXJR
         YA8RaBN2/dZUDk9GLVHzt+QivrGsHawl9zDUkImGPGF7Y7zf+urL0b1h5Fq7a7Chr2rU
         OUE0s4ZToLTHoNxfB3WLDDEKs9VRSUjBI7BNuuH7kqzK6TJU8bK9OCptHaJRPm8E4BCA
         rSXg==
X-Gm-Message-State: AJIora/esresSUUQf3Gv84sijnGK7CQ/8FQ0+Z6kAcws9kHxXKGniiWX
        16o9fu9LySQH/RlTwWcO4z7ZlxMNWxT8lL6OFgmWvNJnIq67wt0BUFv7DaMELxLJxMdWi27pXqS
        UA4xgrPiID24IQx6M4ZeVKCxT
X-Received: by 2002:a05:620a:3199:b0:6af:52bc:d448 with SMTP id bi25-20020a05620a319900b006af52bcd448mr14822380qkb.637.1657627914476;
        Tue, 12 Jul 2022 05:11:54 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v4Zewel6mbdoe+fB5QSMfVct/iEpAbmuRjiGhgbHpjBp+abvTPS8Tw2XH4IjDuiG6rdqisgg==
X-Received: by 2002:a05:620a:3199:b0:6af:52bc:d448 with SMTP id bi25-20020a05620a319900b006af52bcd448mr14822363qkb.637.1657627914286;
        Tue, 12 Jul 2022 05:11:54 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id x21-20020a05620a0b5500b006af147d4876sm5207334qkg.30.2022.07.12.05.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 05:11:53 -0700 (PDT)
Message-ID: <018653fac9bd964f65e6fd28fd07da8cb24a61c2.camel@redhat.com>
Subject: Re: [PATCH v3 25/25] KVM: nVMX: Use cached host MSR_IA32_VMX_MISC
 value for setting up nested MSR
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Jul 2022 15:11:50 +0300
In-Reply-To: <20220708144223.610080-26-vkuznets@redhat.com>
References: <20220708144223.610080-1-vkuznets@redhat.com>
         <20220708144223.610080-26-vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-07-08 at 16:42 +0200, Vitaly Kuznetsov wrote:
> vmcs_config has cased host MSR_IA32_VMX_MISC value, use it for setting
 ^^ typo
> up nested MSR_IA32_VMX_MISC in nested_vmx_setup_ctls_msrs() and avoid the
> redundant rdmsr().
> 
> No (real) functional change intended.
> 
> Reviewed-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 3d386c663fac..8026dab71086 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -6754,10 +6754,7 @@ void nested_vmx_setup_ctls_msrs(struct vmcs_config *vmcs_conf, u32 ept_caps)
>                 msrs->secondary_ctls_high |= SECONDARY_EXEC_ENCLS_EXITING;
>  
>         /* miscellaneous data */
> -       rdmsr(MSR_IA32_VMX_MISC,
> -               msrs->misc_low,
> -               msrs->misc_high);
> -       msrs->misc_low &= VMX_MISC_SAVE_EFER_LMA;
> +       msrs->misc_low = (u32)vmcs_conf->misc & VMX_MISC_SAVE_EFER_LMA;
>         msrs->misc_low |=
>                 MSR_IA32_VMX_MISC_VMWRITE_SHADOW_RO_FIELDS |
>                 VMX_MISC_EMULATED_PREEMPTION_TIMER_RATE |

Besides the typo,
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
 Maxim Levitsky


