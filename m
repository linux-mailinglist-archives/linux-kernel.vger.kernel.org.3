Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0849571F67
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbiGLPeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbiGLPds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:33:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A227FD20
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657640025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QvXvgma6mjwjAWHd6+YYVyH2hz1GPZg9VsvRaOcyslY=;
        b=aUg2HtlsGDEKV3tmXd8AnhOmeNNNbXF7bKaE8skISow+dVn6IXbtq0bNNEQAYiv1pscB3P
        /x1S7EU5C86JMiryfoiHQs4r/vqc5aTq5hZvAvqSs1u0sbJHMuHJLl8B6HlZElg8+AC59r
        97rhNSxKZboaIXF1LmsepE/s6+J+Z6A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-117-uVddNevxPbqGymJ3-2g8Qw-1; Tue, 12 Jul 2022 11:33:43 -0400
X-MC-Unique: uVddNevxPbqGymJ3-2g8Qw-1
Received: by mail-wm1-f70.google.com with SMTP id m10-20020a7bcb8a000000b003a2d979099cso3886104wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=QvXvgma6mjwjAWHd6+YYVyH2hz1GPZg9VsvRaOcyslY=;
        b=lrjo9zW87ky61wHa6F6qm2cSippA6VetXyi/MXRG3rV5Z0pUp2VyHzU0INrfhBEcnX
         KdP8TklcjQKHYdm3mZCyqhrewTgGjQoTaJzO+FUXRvHd09LcRsbT+auzVy3tNFZ/nBUU
         ZE4FkycMAbq0T8Tp+yb/U6U6vxQRL7+gqb+QmH8MuEAsmyO61qASVf2WFGNSaqtH8LWy
         wKi8q11OFpuxMRz0k2/GyBCfiJ78bp9JIwOWy5zV3Je3VtfXiz1wRuWi/kEJTiR6aXcf
         B6XO3C8R7gnV/BBxh2VERo/LZafsFqjulMsyT9ZsZYCWEZW4VS5vgVA/9Qr3tShuxeDy
         6Fww==
X-Gm-Message-State: AJIora9aVe7mo1CjAMgV/dzFjf51rhAU5nmK5eT3UZ62+BOdIooZXlVS
        +yPGw4GH87Mm869K6PNwBifUTqiSForSw5R9CrAOPgenTRlLu3U1kuE2Hxd8GOivmfioTqCpPoe
        q0w0qoN4bNFCNpsDGwo/bKsrlCHY6gRnctyiSoPYOl2zCtZwGR3Z8q8Cg2U9pjhRd3ZNZ4ZaXsF
        Tk
X-Received: by 2002:a5d:584d:0:b0:21d:b7f8:7d19 with SMTP id i13-20020a5d584d000000b0021db7f87d19mr732918wrf.260.1657640021606;
        Tue, 12 Jul 2022 08:33:41 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vsohtsRezHd+K1mxMoD6DDUTSf09YMJkQwLUwuJfnXvRlCJvmmUonwXDMUPJZckhIQXtJWnA==
X-Received: by 2002:a5d:584d:0:b0:21d:b7f8:7d19 with SMTP id i13-20020a5d584d000000b0021db7f87d19mr732881wrf.260.1657640021211;
        Tue, 12 Jul 2022 08:33:41 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b1-20020adfee81000000b0021bbdc3375fsm8651134wro.68.2022.07.12.08.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 08:33:40 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: nVMX: Always enable TSC scaling for L2 when it was
 enabled for L1
In-Reply-To: <ee479e42605d3ed3276b66da69179dbfbcb05dbc.camel@redhat.com>
References: <20220712135009.952805-1-vkuznets@redhat.com>
 <ee479e42605d3ed3276b66da69179dbfbcb05dbc.camel@redhat.com>
Date:   Tue, 12 Jul 2022 17:33:39 +0200
Message-ID: <871quqpcq4.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxim Levitsky <mlevitsk@redhat.com> writes:

> On Tue, 2022-07-12 at 15:50 +0200, Vitaly Kuznetsov wrote:
>> Windows 10/11 guests with Hyper-V role (WSL2) enabled are observed to
>> hang upon boot or shortly after when a non-default TSC frequency was
>> set for L1. The issue is observed on a host where TSC scaling is
>> supported. The problem appears to be that Windows doesn't use TSC
>> frequency

^^^ scaling ^^^

>> for its guests even when the feature is advertised and KVM
>> filters SECONDARY_EXEC_TSC_SCALING out when creating L2 controls from
>> L1's. This leads to L2 running with the default frequency (matching
>> host's) while L1 is running with an altered one.
>
> Ouch.
>
> I guess that needs a Fixes tag?
>
> Fixes: d041b5ea93352b ("KVM: nVMX: Enable nested TSC scaling")
>

I dismissed that because prior to d041b5ea93352b SECONDARY_EXEC_TSC_SCALING
was filtered out in nested_vmx_setup_ctls_msrs() but now I think I was
wrong, SECONDARY_EXEC_TSC_SCALING was likely kept in VMCS02 regardless
of that. Will add in v2.

> Also this is thankfully Intel specific, because in AMD you can't enable
> TSC scaling - there is just an MSR with default value of 1.0,
> which one can change if TSC scaling is supported in CPUID.
>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Thanks!

> Best regards,
> 	Maxim Levitsky
>
>
>>=20
>> Keep SECONDARY_EXEC_TSC_SCALING in secondary exec controls for L2 when
>> it was set for L1. TSC_MULTIPLIER is already correctly computed and
>> written by prepare_vmcs02().
>>=20
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>> =C2=A0arch/x86/kvm/vmx/nested.c | 1 -
>> =C2=A01 file changed, 1 deletion(-)
>>=20
>> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
>> index 778f82015f03..bfa366938c49 100644
>> --- a/arch/x86/kvm/vmx/nested.c
>> +++ b/arch/x86/kvm/vmx/nested.c
>> @@ -2284,7 +2284,6 @@ static void prepare_vmcs02_early(struct vcpu_vmx *=
vmx, struct loaded_vmcs *vmcs0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SECONDARY_EXEC_VIRTUAL_=
INTR_DELIVERY |
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SECONDARY_EXEC_APIC_REG=
ISTER_VIRT |
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SECONDARY_EXEC_ENABLE_V=
MFUNC |
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SECONDARY_EXEC_TSC_SCALING=
 |
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SECONDARY_EXEC_DESC);
>> =C2=A0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (nested_cpu_has(vmcs12,
>
>

--=20
Vitaly

