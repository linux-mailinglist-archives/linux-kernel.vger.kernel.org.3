Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38E9549CCE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347542AbiFMTEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348774AbiFMTDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:03:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF642106351
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 09:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655138964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vfGAHWMcThoU3wboNMsB+3o85C/to02NSWQZiLFEu4U=;
        b=T8h5puOgAvSMRgo//XCofRnlicmNgPaM7gAUMA9TdTy8gZGNW4SBRZ/pJnC4Ke+sDw6dH4
        Jf1LP6rWWjJ41FwiAWobusW1BcKGZdz1rthMumyB/TKAwCHMhhXWt5esAyLhdLON5/Nel4
        c6eFCNdwfa1jsrum5fq+Emm9nGqJgXQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-33m3p_YQNJqBOLDotmu7mQ-1; Mon, 13 Jun 2022 12:49:23 -0400
X-MC-Unique: 33m3p_YQNJqBOLDotmu7mQ-1
Received: by mail-ed1-f72.google.com with SMTP id o17-20020a50fd91000000b0042dbded81deso4341392edt.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 09:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=vfGAHWMcThoU3wboNMsB+3o85C/to02NSWQZiLFEu4U=;
        b=in5RrW+A6ffT2PkmoLpHYxPfJBpVZmQ7aZWRzRASwQkjuPTrSkbVBbS7AdVtZH2Me/
         yO3sDGe0Is9lMGzG6KPJ2Vrl5MjjddDrGw9/3R9/zIZWzfu8B+5N0nQuxwj2Ub6Pr05h
         HMvdIiOPt9WjA5etIZh3uulSw3O3KpqnJ5SyrBk4DLeiPVZfV5DohWIsyfKcyvcjwTI0
         DEzdCJxg2N4mHKr2/3i4RSeDqSwo2a3jwDAGv7EHZdJFOHyaOapgDsZA6gzg4+u6XLk6
         07Dq4GTEEsJQlssebd8v5PO3Cvua+jtrnkVq9TOdqN6Z8DfcffkknvYzuUu6BHeEEcIp
         B4lg==
X-Gm-Message-State: AOAM5332GAcJijMKnkjFrftoqHZyrdSnBnMHxaysbFxoWZgxD5Cp5Q0N
        8vVOkJR7sPllCyTK/xT3tEvHRLJ8C2aBD2LoA8UvkjZ9nzrSlBNnTvdFy+6zBvSk7iv8D23biyx
        S2B7i9AdtO/4c8007gxao7Jgl
X-Received: by 2002:a17:907:7781:b0:6fe:4398:47b3 with SMTP id ky1-20020a170907778100b006fe439847b3mr617828ejc.513.1655138962080;
        Mon, 13 Jun 2022 09:49:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaL+erNcK9c2wpVjZ2CfoESc46xlmRh3AMsc8EsCE4Ff2tToUvshmu2OHg3VCG1JrC9LQuaw==
X-Received: by 2002:a17:907:7781:b0:6fe:4398:47b3 with SMTP id ky1-20020a170907778100b006fe439847b3mr617810ejc.513.1655138961846;
        Mon, 13 Jun 2022 09:49:21 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id p13-20020aa7c88d000000b0043151e18630sm5276460eds.21.2022.06.13.09.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 09:49:21 -0700 (PDT)
Message-ID: <592ab920-51f3-4794-331f-8737e1f5b20a@redhat.com>
Date:   Mon, 13 Jun 2022 18:49:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Ilias Stamatis <ilstam@amazon.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Cc:     mail@anirudhrb.com, kumarpraveen@linux.microsoft.com,
        wei.liu@kernel.org, robert.bradford@intel.com, liuwe@microsoft.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220613161611.3567556-1-anrayabh@linux.microsoft.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: nVMX: Don't expose TSC scaling to L1 when on Hyper-V
In-Reply-To: <20220613161611.3567556-1-anrayabh@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/22 18:16, Anirudh Rayabharam wrote:
> +	if (!kvm_has_tsc_control)
> +		msrs->secondary_ctls_high &= ~SECONDARY_EXEC_TSC_SCALING;
> +
>   	msrs->secondary_ctls_low = 0;
>   	msrs->secondary_ctls_high &=
>   		SECONDARY_EXEC_DESC |
> @@ -6667,8 +6670,7 @@ void nested_vmx_setup_ctls_msrs(struct nested_vmx_msrs *msrs, u32 ept_caps)
>   		SECONDARY_EXEC_RDRAND_EXITING |
>   		SECONDARY_EXEC_ENABLE_INVPCID |
>   		SECONDARY_EXEC_RDSEED_EXITING |
> -		SECONDARY_EXEC_XSAVES |
> -		SECONDARY_EXEC_TSC_SCALING;
> +		SECONDARY_EXEC_XSAVES;
>   
>   	/*

This is wrong because it _always_ disables SECONDARY_EXEC_TSC_SCALING,
even if kvm_has_tsc_control == true.

That said, I think a better implementation of this patch is to just add
a version of evmcs_sanitize_exec_ctrls that takes a struct
nested_vmx_msrs *, and call it at the end of nested_vmx_setup_ctl_msrs like

	evmcs_sanitize_nested_vmx_vsrs(msrs);

Even better (but I cannot "mentally test it" offhand) would be just

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e802f71a9e8d..b3425ce835c5 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1862,7 +1862,7 @@ int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
  		 * sanity checking and refuse to boot. Filter all unsupported
  		 * features out.
  		 */
-		if (!msr_info->host_initiated &&
+		if (static_branch_unlikely(&enable_evmcs) ||
  		    vmx->nested.enlightened_vmcs_enabled)
  			nested_evmcs_filter_control_msr(msr_info->index,
  							&msr_info->data);

I cannot quite understand the host_initiated check, so I'll defer to
Vitaly on why it is needed.  Most likely, removing it would cause some
warnings in QEMU with e.g. "-cpu Haswell,+vmx"; but I think it's a
userspace bug and we should remove that part of the condition.  You
don't need to worry about that part, we'll cross that bridge if the
above patch works for your case.

Thanks,

Paolo

