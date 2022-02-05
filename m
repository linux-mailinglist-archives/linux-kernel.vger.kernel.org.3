Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B0C4AA985
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 15:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380197AbiBEOuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 09:50:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32895 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380180AbiBEOux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 09:50:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644072653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Rc8ijCVExWwCJv+VMGAynjPNWd83v7JPEXJNV8RCeA=;
        b=FNQj24v9K5HEZPhag6iDP0eNrAIXLaRunFA/VNexWvZNrTD6KW/xwR4abCzfk3R0x2TGD1
        PVKU9asiqEtcvAxLIYX3zvT2Wcp4gO+6Gz7haOvKncfyBZ2wbYboGXVBTWRXSpi28yO1jY
        JuxMuutAXjOlqdDDGxNTy5YgNEQ5gNs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-52dY_LICODylR7M7ZrlkzA-1; Sat, 05 Feb 2022 09:50:51 -0500
X-MC-Unique: 52dY_LICODylR7M7ZrlkzA-1
Received: by mail-ed1-f72.google.com with SMTP id n7-20020a05640205c700b0040b7be76147so4765957edx.10
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 06:50:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5Rc8ijCVExWwCJv+VMGAynjPNWd83v7JPEXJNV8RCeA=;
        b=H+nyxpLuXG2R5zk3cl9hFKFWbvRhwH1TC7Er+RisaEgQvndWH+SPy3W61Qnjw+z2iy
         /RywC83q8RvOwOOwMkH9W2MoVWIko7Fxj/pr5uCLNISo1/fgDfIzc5YP2Dg2JfgMV5Mx
         rzdDudnp1QcxLi5fyNAZ6y0X8nQkrSY6VH+O5gx4CDYFtAOW2YfPU3leSh/X5jKyfw47
         6sWiorXYDidv/NjVKauar79s7xRXrjyacAxMamyh+8VIUD7bMXAwhb8SO8bIVAEsLgCg
         BLItb8ZkSIDOmPYAUBQvrHs6nNMGAHIh5qEBx1J5yINF12eZzWXVWB8jjtA9IVRinhuc
         mrCg==
X-Gm-Message-State: AOAM533t9vlFKmP1lu2+3bSsG3JSp8JLt75wyzNNBf+JxK3ujRh0QTr2
        beiuEOYM5EaM9k1KdMGF7xaJmC5MNKpHF2edId7fKjtBs2/V+NCRdV+pZaY81X2kJ6rcyRu6bux
        FLbdw4h0Dsm8n0QuqNvgPbQT5
X-Received: by 2002:a05:6402:2683:: with SMTP id w3mr4776346edd.405.1644072650702;
        Sat, 05 Feb 2022 06:50:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzauDtqAvaJ/GElUfrMmdQtavm9QTuQ0dPoLeNID8Ql3GDWEKtV4Y/TrUFnpLdaxfgqo9WIPQ==
X-Received: by 2002:a05:6402:2683:: with SMTP id w3mr4776326edd.405.1644072650511;
        Sat, 05 Feb 2022 06:50:50 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id t8sm1673362ejx.217.2022.02.05.06.50.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Feb 2022 06:50:49 -0800 (PST)
Message-ID: <a7cc6ead-c30b-4d21-c92c-faf37d9023b7@redhat.com>
Date:   Sat, 5 Feb 2022 15:50:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 03/23] KVM: MMU: remove valid from extended role
Content-Language: en-US
To:     David Matlack <dmatlack@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        seanjc@google.com, vkuznets@redhat.com
References: <20220204115718.14934-1-pbonzini@redhat.com>
 <20220204115718.14934-4-pbonzini@redhat.com> <Yf1xU+EVukcX4Exb@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Yf1xU+EVukcX4Exb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/22 19:32, David Matlack wrote:
>> -	vcpu->arch.root_mmu.mmu_role.ext.valid = 0;
>> -	vcpu->arch.guest_mmu.mmu_role.ext.valid = 0;
>> -	vcpu->arch.nested_mmu.mmu_role.ext.valid = 0;
>> +	vcpu->arch.root_mmu.mmu_role.base.level = 0;
>> +	vcpu->arch.guest_mmu.mmu_role.base.level = 0;
>> +	vcpu->arch.nested_mmu.mmu_role.base.level = 0;
> I agree this will work but I think it makes the code more difficult to
> follow (and I start worrying that some code that relies on level being
> accurate will creep in in the future). At minimum we should extend the
> comment here to describe why level is being changed.
> 
> I did a half-assed attempt to pass something like "bool force_role_reset"
> down to the MMU initialization functions as an alternative but it very
> quickly got out of hand.
> 
> What about just changing `valid` to `cpuid_stale` and flip the meaning?
> kvm_mmu_after_set_cpuid() would set the cpuid_stale bit and then reset
> the MMUs.
> 

For now I'll swap this patch with one that clears the whole word, but 
keep the ext bit as described in my other reply.

Paolo

