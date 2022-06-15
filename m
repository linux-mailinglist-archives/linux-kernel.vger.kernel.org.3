Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EAE54C785
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347925AbiFOLbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347864AbiFOLbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:31:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 359C552E63
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 04:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655292657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=deu1fZ+rJg4vtIyzufwUH9tCrx+7IF3P/lvcMVMcMto=;
        b=jOY+f9s5ny1+xF2LOeakdX57gA4kAOsuwKJlideOsv398UA6ruA9Va3a4K34d5B5XbanEo
        6WfmCAFx1vMNlBLI5f0F6SDM7bJV2E4z2uqfAXDqO86LMHPmAK8c+xqldJc7TqBctjeVPJ
        +5kOkWNAGb13DBbPLWPWyHYOSyx1rrI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-YOCOutogNE2o2X49mqNIbQ-1; Wed, 15 Jun 2022 07:30:56 -0400
X-MC-Unique: YOCOutogNE2o2X49mqNIbQ-1
Received: by mail-wr1-f71.google.com with SMTP id h2-20020adfe982000000b002102da95c71so1751610wrm.23
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 04:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=deu1fZ+rJg4vtIyzufwUH9tCrx+7IF3P/lvcMVMcMto=;
        b=gtAn9yJ33CK+qMDXkS44tfXm6LT1zegfeN3K5Hh9Br2GPYDd9iIQYujOILYXGJFGTG
         O3OPticeHcmKSkUrTo2xBCHrSWcaLgfNTtfch/9CsBYDp8GBIqFjo14ViZKhJ6gheV/O
         OeSaPcxiT2uPFhYdBB0uUcOpW0w96vVUv70rF1LCkAFG6O/ptkcwCJEJt+bh5FPz7bZi
         AKqMO1qIeVrOWlh0Gw6DRXN1cMnv40fcZZVYhaFXfXulvh7c3gjb1iWCJV4YihJLVfIx
         AiBoXt1ZnKx4+BrjvJ4o9Bt/76CtALDXhNiiWlYaI/XBk3srEGVtwP5yvaEy8gHQmRM2
         P5eQ==
X-Gm-Message-State: AJIora/SOklKUcDmCELjMZlRsk/SW6O/x4AxcEZN0Xv3Z8SH6JpliFYb
        3GPT1E50VUx01VKnRu2VIymXk9STl1dv14IC4Qm4nRSWpMQTdhS0KUsG6CJuQp3w73DqNlRHeuq
        yX18QU8suTSSe8VTxo/GqiXMI
X-Received: by 2002:a05:6000:1808:b0:21a:1322:cd9b with SMTP id m8-20020a056000180800b0021a1322cd9bmr9793136wrh.164.1655292655039;
        Wed, 15 Jun 2022 04:30:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v6ZjaAdpwX7tIwW3bDni1DiejlVqSRKsvOo3OuGN1wsYo5tjNHWI+jwvqWm6RPrB9yjf7DNQ==
X-Received: by 2002:a05:6000:1808:b0:21a:1322:cd9b with SMTP id m8-20020a056000180800b0021a1322cd9bmr9793119wrh.164.1655292654831;
        Wed, 15 Jun 2022 04:30:54 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id q17-20020adffed1000000b00219f9829b71sm12682321wrs.56.2022.06.15.04.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 04:30:54 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     mail@anirudhrb.com, kumarpraveen@linux.microsoft.com,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        wei.liu@kernel.org, robert.bradford@intel.com, liuwe@microsoft.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Ilias Stamatis <ilstam@amazon.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH] KVM: nVMX: Don't expose TSC scaling to L1 when on Hyper-V
In-Reply-To: <87pmjbi90m.fsf@redhat.com>
References: <20220613161611.3567556-1-anrayabh@linux.microsoft.com>
 <87sfo7igis.fsf@redhat.com> <87pmjbi90m.fsf@redhat.com>
Date:   Wed, 15 Jun 2022 13:30:53 +0200
Message-ID: <87ilp2i2oi.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Vitaly Kuznetsov <vkuznets@redhat.com> writes:
>
>> Anirudh Rayabharam <anrayabh@linux.microsoft.com> writes:
>>
>> ...
>>
>>>
>>> As per the comments in arch/x86/kvm/vmx/evmcs.h, TSC multiplier field is
>>> currently not supported in EVMCS.
>>
>> The latest version:
>> https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/datatypes/hv_vmx_enlightened_vmcs
>>
>> has it, actually. It was missing before (compare with e.g. 6.0b version
>> here:
>> https://github.com/MicrosoftDocs/Virtualization-Documentation/raw/live/tlfs/Hypervisor%20Top%20Level%20Functional%20Specification%20v6.0b.pdf)
>>
>> but AFAIR TSC scaling wasn't advertised by genuine Hyper-V either.
>> Interestingly enough, eVMCS version didn't change when these fields were
>> added, it is still '1'.
>>
>> I even have a patch in my stash (attached). I didn't send it out because
>> it wasn't properly tested with different Hyper-V versions.
>
> And of course I forgot a pre-requisite patch which updates 'struct
> hv_enlightened_vmcs' to the latest:
>

The good news is that TscMultiplies seems to work fine for me, at least
with an Azure Dv5 instance where I can see Tsc scaling exposed. The bad
news is that a few more patches are needed:

1) Fix 'struct hv_enlightened_vmcs' definition:
https://lore.kernel.org/kvm/20220613133922.2875594-20-vkuznets@redhat.com/

2) Define VMCS-to-EVMCS conversion for the new fields :

diff --git a/arch/x86/kvm/vmx/evmcs.c b/arch/x86/kvm/vmx/evmcs.c
index 6a61b1ae7942..707a8de11802 100644
--- a/arch/x86/kvm/vmx/evmcs.c
+++ b/arch/x86/kvm/vmx/evmcs.c
@@ -28,6 +28,8 @@ const struct evmcs_field vmcs_field_to_evmcs_1[] = {
                     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1),
        EVMCS1_FIELD(HOST_IA32_EFER, host_ia32_efer,
                     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1),
+       EVMCS1_FIELD(HOST_IA32_PERF_GLOBAL_CTRL, host_ia32_perf_global_ctrl,
+                    HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1),
        EVMCS1_FIELD(HOST_CR0, host_cr0,
                     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1),
        EVMCS1_FIELD(HOST_CR3, host_cr3,
@@ -78,6 +80,8 @@ const struct evmcs_field vmcs_field_to_evmcs_1[] = {
                     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1),
        EVMCS1_FIELD(GUEST_IA32_EFER, guest_ia32_efer,
                     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1),
+       EVMCS1_FIELD(GUEST_IA32_PERF_GLOBAL_CTRL, guest_ia32_perf_global_ctrl,
+                    HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1),
        EVMCS1_FIELD(GUEST_PDPTR0, guest_pdptr0,
                     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1),
        EVMCS1_FIELD(GUEST_PDPTR1, guest_pdptr1,
@@ -126,24 +130,47 @@ const struct evmcs_field vmcs_field_to_evmcs_1[] = {
                     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1),
        EVMCS1_FIELD(XSS_EXIT_BITMAP, xss_exit_bitmap,
                     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP2),
+       EVMCS1_FIELD(ENCLS_EXITING_BITMAP, encls_exiting_bitmap,
+                    HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP2),
+       EVMCS1_FIELD(TSC_MULTIPLIER, tsc_multiplier,
+                    HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP2),

...

so it is becoming more and more complicated to assemble for testing. Let
me finish my testing and I'll put a series together and send it out to
simplify the process. Stay tuned!

-- 
Vitaly

