Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5DE54B419
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355288AbiFNPCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344219AbiFNPB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:01:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 827E9403C9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655218915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J0TyJoYQ26JBnYmZYgj7lHRpHCJIU5GdHdyAKYNVq4s=;
        b=RWd82fQBHsaxkHSImGMtbPqSKXAMktSBdwjofvHbAXvkeVoFCuFKGt5TOzvuWdh6Na5Mm8
        fJ2IRElV6Woxyrk5JC23sh0eBU6xw01fxbm9HpP8jAxTFSgY85TFtnKE0KlTthAu6wVOAg
        HLKNG0tGqSNJXdoSyE9kKZAFG9lZAQk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317-smumNDXjMgynpZJ-VwbOQw-1; Tue, 14 Jun 2022 11:01:53 -0400
X-MC-Unique: smumNDXjMgynpZJ-VwbOQw-1
Received: by mail-wm1-f69.google.com with SMTP id v184-20020a1cacc1000000b0039c7efa3e95so3905977wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=J0TyJoYQ26JBnYmZYgj7lHRpHCJIU5GdHdyAKYNVq4s=;
        b=DD+Yu/7lKCv8zqNQSVV2qypl5iWlOMVIE2QfANPqkP/YOsK9xvR7VwJ7hwG0JMTnOA
         qQOk5tsn94ZG/Q5Y0gl6nDXOfzn11LsaK0M92jmckFr760xEUVKQU4StwwMwa9PIJ2nk
         tJesit/Fy2lm2HtWbVjStp/GVG6ndOq2IpRB1icQirYfCFcV60nhzxBkrwDxTfi4dwHY
         YFbOptmv/86gNBCiI8QUG1crTheS9wSYHfFToGKN3k4zIO6hKjFZoAQ30rH4Lb02OtVP
         H4UTVS3JjC2XhwLV1pT4V4/kvImgKlzAC4UKCf76n/Ghyms0K2+IcqNqR0Rqt74xDUD2
         Z7mg==
X-Gm-Message-State: AOAM530JFivgBUn5L5KrM5sc1i8ZE6TPddVcMHP98BaQEMFKa+pGFLQ+
        QlGBxO5GmV+FjTGaqZ9IGd+m0VDJw8WDC3JRJ4Ek/k199zA7Z6jH4dPDeb8QZKPVTv8nieWNYbd
        eFkgQYDGpMUBJfHx3npJe3gaY
X-Received: by 2002:a05:600c:4fd0:b0:39c:6565:31a5 with SMTP id o16-20020a05600c4fd000b0039c656531a5mr4672001wmq.60.1655218906947;
        Tue, 14 Jun 2022 08:01:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMIhlZbyecRjzqaqLq58DG7gWGNeWqK36G+IRce1uMWn4j2Niel2ejc1+7NC3ArykNox5mJg==
X-Received: by 2002:a05:600c:4fd0:b0:39c:6565:31a5 with SMTP id o16-20020a05600c4fd000b0039c656531a5mr4671978wmq.60.1655218906712;
        Tue, 14 Jun 2022 08:01:46 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600c129100b0039754d1d327sm13356207wmd.13.2022.06.14.08.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 08:01:46 -0700 (PDT)
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
In-Reply-To: <87sfo7igis.fsf@redhat.com>
References: <20220613161611.3567556-1-anrayabh@linux.microsoft.com>
 <87sfo7igis.fsf@redhat.com>
Date:   Tue, 14 Jun 2022 17:01:45 +0200
Message-ID: <87pmjbi90m.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Anirudh Rayabharam <anrayabh@linux.microsoft.com> writes:
>
> ...
>
>>
>> As per the comments in arch/x86/kvm/vmx/evmcs.h, TSC multiplier field is
>> currently not supported in EVMCS.
>
> The latest version:
> https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/datatypes/hv_vmx_enlightened_vmcs
>
> has it, actually. It was missing before (compare with e.g. 6.0b version
> here:
> https://github.com/MicrosoftDocs/Virtualization-Documentation/raw/live/tlfs/Hypervisor%20Top%20Level%20Functional%20Specification%20v6.0b.pdf)
>
> but AFAIR TSC scaling wasn't advertised by genuine Hyper-V either.
> Interestingly enough, eVMCS version didn't change when these fields were
> added, it is still '1'.
>
> I even have a patch in my stash (attached). I didn't send it out because
> it wasn't properly tested with different Hyper-V versions.

And of course I forgot a pre-requisite patch which updates 'struct
hv_enlightened_vmcs' to the latest:

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 0a9407dc0859..038e5ef9b4a6 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -559,9 +559,20 @@ struct hv_enlightened_vmcs {
        u64 partition_assist_page;
        u64 padding64_4[4];
        u64 guest_bndcfgs;
-       u64 padding64_5[7];
+       u64 guest_ia32_perf_global_ctrl;
+       u64 guest_ia32_s_cet;
+       u64 guest_ssp;
+       u64 guest_ia32_int_ssp_table_addr;
+       u64 guest_ia32_lbr_ctl;
+       u64 padding64_5[2];
        u64 xss_exit_bitmap;
-       u64 padding64_6[7];
+       u64 host_ia32_perf_global_ctrl;
+       u64 encls_exiting_bitmap;
+       u64 tsc_multiplier;
+       u64 host_ia32_s_cet;
+       u64 host_ssp;
+       u64 host_ia32_int_ssp_table_addr;
+       u64 padding64_6;
 } __packed;
 
 #define HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE                    0

-- 
Vitaly

