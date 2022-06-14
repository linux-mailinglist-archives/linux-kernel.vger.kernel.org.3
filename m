Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260BD54B7A7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 19:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351851AbiFNR2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 13:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350483AbiFNR2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:28:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5F4936696
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655227697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iSH+DYmRkKMqWyNjrkzYbk9as1pR1wnvGMJve2jezd4=;
        b=WsBKiJzwXRQjYB62PKzHxF5IiK+ej53AUGXZ9kXL509nZIdqJW8IimTDRjqt3uhdTIOKss
        Z8ks2CRy62eB7F22gTV2bXmZydeE4EehpqjkI7a5sN79UZDYhjDlmwV3o1aFGFP/vXkoRR
        wqY/zBQ2twOMw+HeXZFBzObfF8FsfY0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-269-Af51m9E0OtWlGsapN1480Q-1; Tue, 14 Jun 2022 13:28:16 -0400
X-MC-Unique: Af51m9E0OtWlGsapN1480Q-1
Received: by mail-wm1-f71.google.com with SMTP id l4-20020a05600c1d0400b0039c60535405so4067634wms.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=iSH+DYmRkKMqWyNjrkzYbk9as1pR1wnvGMJve2jezd4=;
        b=y9AwYEK9ysn0jLm9rs9crtGxhFzGjZwxzJ+lD/IWi2N/lnCCGpMVjgnyqZRU3d4s5Z
         CVBKjsSyQenctWy0jNI93ldjwk6uTDMl0dH+ZgxPUQ1FhkzVI+MLCBffy7ioChDOsu2B
         bvQP07LUzjZtDAGXaO2pCUItWHIz9H/xoRsqEsOqfapCaR1p5Idy32dySZdHblFpvxF4
         7FgCraOgY71YRu4aRGFTa8ZKxHvOw063X7LXcxjA+oU9MsiTX8OOWWc+4uWYRZxxtqtz
         ZsHgEZZaa7dR4xFyGPldX2bnz1BK78kYl4Ut438AI56Q8brOnT51RurGOfs9jlAZO9gg
         dlsw==
X-Gm-Message-State: AJIora+FjuuB1DIZUQkc5YSQjPNJ1qeE/xRKyH2o3OxvPd7Boj5MVBy4
        q1Xqo42wX+eG6p7PtEllA24o4TDVcuVmKMlRMP59MD5STJ9Bpyo4OfTjUF3HDvlOkyP9BcYwDok
        2el5U0qg49zEfKRtb1VNX769c
X-Received: by 2002:adf:f592:0:b0:213:711d:55ad with SMTP id f18-20020adff592000000b00213711d55admr5953665wro.540.1655227694677;
        Tue, 14 Jun 2022 10:28:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uQsWCeMjHo+6+u2IAR6pHNgMgtPft3WHP6rzOx3d8cYaac9V2retUEhAye0AAUBrEJgsnZXg==
X-Received: by 2002:adf:f592:0:b0:213:711d:55ad with SMTP id f18-20020adff592000000b00213711d55admr5953651wro.540.1655227694453;
        Tue, 14 Jun 2022 10:28:14 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id v22-20020a7bcb56000000b0039482d95ab7sm13632257wmj.24.2022.06.14.10.28.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 10:28:13 -0700 (PDT)
Message-ID: <ec63cf3c-d312-01b7-671b-02729bddfa32@redhat.com>
Date:   Tue, 14 Jun 2022 19:28:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Ilias Stamatis <ilstam@amazon.com>,
        Maxim Levitsky <mlevitsk@redhat.com>, mail@anirudhrb.com,
        kumarpraveen@linux.microsoft.com, wei.liu@kernel.org,
        robert.bradford@intel.com, liuwe@microsoft.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220613161611.3567556-1-anrayabh@linux.microsoft.com>
 <592ab920-51f3-4794-331f-8737e1f5b20a@redhat.com>
 <YqgU2KfFCqawbTkW@anrayabh-desk>
 <75bdc7ee-bac5-ae05-dffb-cb749c9005e1@redhat.com>
 <YqilhAnxLMoQu1Ou@anrayabh-desk>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: nVMX: Don't expose TSC scaling to L1 when on Hyper-V
In-Reply-To: <YqilhAnxLMoQu1Ou@anrayabh-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/22 17:13, Anirudh Rayabharam wrote:
>>> Sanitize at the end might not work because I see some cases in
>>> nested_vmx_setup_ctls_msrs() where we want to expose some things to L1
>>> even though the hardware doesn't support it.
>>
>> Yes, but these will never include eVMCS-unsupported features.
>
> How are you so sure?
> 
> For example, SECONDARY_EXEC_SHADOW_VMCS is unsupported in eVMCS but in
> nested_vmx_setup_ctls_msrs() we do:
> 
> 6675         /*
> 6676          * We can emulate "VMCS shadowing," even if the hardware
> 6677          * doesn't support it.
> 6678          */
> 6679         msrs->secondary_ctls_high |=
> 6680                 SECONDARY_EXEC_SHADOW_VMCS;
> 
> If we sanitize this out it might cause some regression right?

Yes, you're right, shadow VMCS is special: it is not supported by 
enlightened VMCS, but it is emulated rather than virtualized. 
Therefore, if L1 does not use the enlightened VMCS, it can indeed use 
shadow VMCS.

Paolo

