Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3DD57195E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbiGLMCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbiGLMCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:02:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 818AD1FCD8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 05:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657627341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B9/R1R/MEXtOrJ4aX8LfRJUNTXUW3YnoKA1MMGNShn4=;
        b=XkZ2oJUeVILZQqdJc5+Q6X93OuaOdus5TOhkcmwfFoG7X45aB+rzgTxHNHrXc04hPwbg25
        TTjvP194Q07bnRIYUCc1+IM6GVZlVFBicXxiaj8nQVGuNxSwdm9lIlvc77I9zKJzRxwEb5
        a7OO5exZHS1/7mqPDGJq18pzXvKGWFw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-375-l4FDRTxzMCO9E1LRy8XTjw-1; Tue, 12 Jul 2022 08:02:20 -0400
X-MC-Unique: l4FDRTxzMCO9E1LRy8XTjw-1
Received: by mail-qv1-f69.google.com with SMTP id p11-20020a0cfd8b000000b0047318870bdfso1680152qvr.14
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 05:02:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=B9/R1R/MEXtOrJ4aX8LfRJUNTXUW3YnoKA1MMGNShn4=;
        b=y2Mtk/0vIcMg7gMR+j/+0orNByNuhoL1hGSVEdJEeSul2M0MXZcitPUVvJFsPfwrQD
         gsFrUU7+vOPa55FwFY3oBlABmDGciC9fMQcUkChi861RVEl06Gyxt+c7GSFq1aeOgA69
         mxi7OQ3rDCAiRBQV0glR04ecJS2MBpIG0hTDroJCBQ+pOgxae9zOX7jo57ucSO7q0Q+q
         wol6STmbDBZ4OVLkakDUBwAnFyH/UV+WOEWQSyrKC3psIXwu5EWkmf50hXXUAqTaGLVr
         ZyV4jcZ6pNuxyS1+JHAaLxT6bT/H8kOgFARybnSBzwQHCSCI3gCRA/B5q0w8VNmKKm4u
         yr7w==
X-Gm-Message-State: AJIora9GCyvH2tR643jenVVc0GT9XBAXG/VQZ2fa/iWUN+WNYoeTJLkw
        qKG/xD8xCcnyg7oNETjY1h/qAEuLUN5uagiGj3b6VaocflWAqih7ePHHEQAHj67CtbFugWdXhGX
        OCHkkhiQmEOw3aTUn0C34zfis
X-Received: by 2002:a05:622a:487:b0:31e:b5b5:f1a7 with SMTP id p7-20020a05622a048700b0031eb5b5f1a7mr7047516qtx.280.1657627339773;
        Tue, 12 Jul 2022 05:02:19 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uyd/kOr5EOf/HaVF0YpWmwrE288XVK6Rs+TkWOWdhMqEZzv04XI88lowvDlAav1UNw8igKew==
X-Received: by 2002:a05:622a:487:b0:31e:b5b5:f1a7 with SMTP id p7-20020a05622a048700b0031eb5b5f1a7mr7047496qtx.280.1657627339545;
        Tue, 12 Jul 2022 05:02:19 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id bj17-20020a05620a191100b006a6ad90a117sm9040806qkb.105.2022.07.12.05.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 05:02:18 -0700 (PDT)
Message-ID: <374a848082f1823481566d268d0c4a16d57ec0b9.camel@redhat.com>
Subject: Re: [PATCH v3 22/25] KVM: nVMX: Always set required-1 bits of
 pinbased_ctls to PIN_BASED_ALWAYSON_WITHOUT_TRUE_MSR
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Jul 2022 15:02:15 +0300
In-Reply-To: <20220708144223.610080-23-vkuznets@redhat.com>
References: <20220708144223.610080-1-vkuznets@redhat.com>
         <20220708144223.610080-23-vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-07-08 at 16:42 +0200, Vitaly Kuznetsov wrote:
> Similar to exit_ctls_low, entry_ctls_low, procbased_ctls_low,
> pinbased_ctls_low should be set to PIN_BASED_ALWAYSON_WITHOUT_TRUE_MSR
> and not host's MSR_IA32_VMX_PINBASED_CTLS value |=
> PIN_BASED_ALWAYSON_WITHOUT_TRUE_MSR.
> 
> The commit eabeaaccfca0 ("KVM: nVMX: Clean up and fix pin-based
> execution controls") which introduced '|=' doesn't mention anything
> about why this is needed, the change seems rather accidental.
> 
> Note: normally, required-1 portion of MSR_IA32_VMX_PINBASED_CTLS should
> be equal to PIN_BASED_ALWAYSON_WITHOUT_TRUE_MSR so no behavioral change
> is expected, however, it is (in theory) possible to observe something
> different there when e.g. KVM is running as a nested hypervisor. Hope
> this doesn't happen in practice.
> 
> Reported-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index dcf3ee645212..09654d5c2144 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -6586,7 +6586,7 @@ void nested_vmx_setup_ctls_msrs(struct nested_vmx_msrs *msrs, u32 ept_caps)
>         rdmsr(MSR_IA32_VMX_PINBASED_CTLS,
>                 msrs->pinbased_ctls_low,
>                 msrs->pinbased_ctls_high);
> -       msrs->pinbased_ctls_low |=
> +       msrs->pinbased_ctls_low =
>                 PIN_BASED_ALWAYSON_WITHOUT_TRUE_MSR;
>         msrs->pinbased_ctls_high &=
>                 PIN_BASED_EXT_INTR_MASK |

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

