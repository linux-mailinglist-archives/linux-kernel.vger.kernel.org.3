Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F39A571C81
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiGLO2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbiGLO2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:28:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2BC3B9DA3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657636080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZYHjDyHRUCfENuUw1YAFJ33SC7QGQxArlza+HDxiHoc=;
        b=ZBz3vibZaLRxAT0i8LU/JVq9NFIhGuyteuV3kMj2h/rwmVKuWmvO7l0S3BGxa2gSEz4q9M
        qKqSQ26em4I7IvmYcL6pFZ+vrFZRma+LofBQ1PvkO8cBTqIdSlJ/rM30XBVANcl6eZcKaN
        ArSB/NJSjchegrcEOx+efpT0GUwRxcU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-102-sBRjWoKQNEmz7LRg9xl5Ig-1; Tue, 12 Jul 2022 10:27:58 -0400
X-MC-Unique: sBRjWoKQNEmz7LRg9xl5Ig-1
Received: by mail-qt1-f197.google.com with SMTP id m6-20020ac866c6000000b002f52f9fb4edso7006881qtp.19
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ZYHjDyHRUCfENuUw1YAFJ33SC7QGQxArlza+HDxiHoc=;
        b=2aCdA6UkjGQfRYeVXq8CedFpN1eeMm70ZY7w6FGWZAVV+5ipkqso3SfO32bVRQ11du
         E/ywc5ETcjZFxppqHEMiMQIDGUbfgdwZQrKRYLEBIb5EcdxU4LQrB0f4j/R8RZVqcXh5
         1rM8fxv2JxyUjAFx8JgetBu/OSpI/cWTdwDgIPqNZrXTW1pspIzwNhqZYifEtL7k2aNw
         W8/hZf+4qTctj0A2PpURaha5+yQTBCn9eZsI6Ar/OaJLhp7ouGSqGxWSpQp5aL4gHwSp
         VMDlGGuuJH0Xyxp5HRMdW/SyC/IndyGdDupF7XQEX60AuMeKu/3J5EQlF65/CTGRHWRS
         7ODA==
X-Gm-Message-State: AJIora+XAVuNmZDB5f2IGg/cbi2H7W6Gw/oRU6benxgqzEhdimIiLdWZ
        ep4L+rRuJmGFrbloyvWhJa74wtemSO2G3RXlAe3eS5Rt2y6DzlbluHqzEL8hjcFHhHX7tE9iqaH
        KKINKYaPftSB0aEJ4Wb9kGvcx
X-Received: by 2002:ad4:5ecb:0:b0:473:6181:4a23 with SMTP id jm11-20020ad45ecb000000b0047361814a23mr10713352qvb.17.1657636078020;
        Tue, 12 Jul 2022 07:27:58 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tUMyMFGKWXzHGloySmQayJm5YD9ab0hOL9dwX7wDj4Knm+oQErb26Ep1Oc8MEI68R7YUTjdw==
X-Received: by 2002:ad4:5ecb:0:b0:473:6181:4a23 with SMTP id jm11-20020ad45ecb000000b0047361814a23mr10713333qvb.17.1657636077796;
        Tue, 12 Jul 2022 07:27:57 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id s7-20020a05620a254700b006a6b374d8bbsm9828944qko.69.2022.07.12.07.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 07:27:56 -0700 (PDT)
Message-ID: <ee479e42605d3ed3276b66da69179dbfbcb05dbc.camel@redhat.com>
Subject: Re: [PATCH] KVM: nVMX: Always enable TSC scaling for L2 when it was
 enabled for L1
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Date:   Tue, 12 Jul 2022 17:27:53 +0300
In-Reply-To: <20220712135009.952805-1-vkuznets@redhat.com>
References: <20220712135009.952805-1-vkuznets@redhat.com>
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

On Tue, 2022-07-12 at 15:50 +0200, Vitaly Kuznetsov wrote:
> Windows 10/11 guests with Hyper-V role (WSL2) enabled are observed to
> hang upon boot or shortly after when a non-default TSC frequency was
> set for L1. The issue is observed on a host where TSC scaling is
> supported. The problem appears to be that Windows doesn't use TSC
> frequency for its guests even when the feature is advertised and KVM
> filters SECONDARY_EXEC_TSC_SCALING out when creating L2 controls from
> L1's. This leads to L2 running with the default frequency (matching
> host's) while L1 is running with an altered one.

Ouch.

I guess that needs a Fixes tag?

Fixes: d041b5ea93352b ("KVM: nVMX: Enable nested TSC scaling")

Also this is thankfully Intel specific, because in AMD you can't enable
TSC scaling - there is just an MSR with default value of 1.0,
which one can change if TSC scaling is supported in CPUID.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Best regards,
	Maxim Levitsky


> 
> Keep SECONDARY_EXEC_TSC_SCALING in secondary exec controls for L2 when
> it was set for L1. TSC_MULTIPLIER is already correctly computed and
> written by prepare_vmcs02().
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 778f82015f03..bfa366938c49 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -2284,7 +2284,6 @@ static void prepare_vmcs02_early(struct vcpu_vmx *vmx, struct loaded_vmcs *vmcs0
>                                   SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
>                                   SECONDARY_EXEC_APIC_REGISTER_VIRT |
>                                   SECONDARY_EXEC_ENABLE_VMFUNC |
> -                                 SECONDARY_EXEC_TSC_SCALING |
>                                   SECONDARY_EXEC_DESC);
>  
>                 if (nested_cpu_has(vmcs12,


