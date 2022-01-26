Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C76749CED0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243061AbiAZPos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:44:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48960 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236060AbiAZPor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:44:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643211886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OE2o1EX3RpFpjJ9IFNscD0lnVIpsfwDRSieBpWxhAkg=;
        b=QM9wyOnYpp+O4nm4XvOGm5QyEgEMVc2gHCJZbmsYvKd/TsqnamqXu86Ezh/ceT62qDqmo3
        rTJYzG/oum1FuLlyn/rbz2UFJR6uIHJE3WLSMr7xnzSHhwpj+VnutvHJYhR5a3nsz+/UQC
        aMxtUnT79R+UV3k+KXW5oTVXxvXEvQs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-7y-QrJCqMdKZ2EqXapT0lw-1; Wed, 26 Jan 2022 10:44:45 -0500
X-MC-Unique: 7y-QrJCqMdKZ2EqXapT0lw-1
Received: by mail-ed1-f70.google.com with SMTP id h21-20020aa7c955000000b0040390b2bfc5so16850109edt.15
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 07:44:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OE2o1EX3RpFpjJ9IFNscD0lnVIpsfwDRSieBpWxhAkg=;
        b=zY2F4K4KSnWy9vZf1hZk+P0+eLqiExjuytvmISuPXwRx+qXnn/Sl7yHfnxwMrOW77J
         CTH/GKqagnXvZJjNJnHt029OlflFkTNEYkiMijl+FDliiKsbjXd0L5QBi8L5LCZK3ffD
         d8piF9ObZmEAVdZON2/FC7iuGfmmH1xfyUsi+hr5mBcGRt212P50in5vziyOfUZ7qcVZ
         bxxwrwn+ZoXfUVHvKADze0VrP37GfSzkDX59xLq0ymPQUzML9PRQ/2HjG8pq4K2DB9at
         gLMgWTm1XXRLzfuSRpE7sBdI9L1Gtpycqrfq/IMRp2hUO7sMEYBpfPn51xWmoQBLWf6G
         YSyg==
X-Gm-Message-State: AOAM5334kNcAjGvPygp2j8JpG3osHWKhUH9QyDMBdUoW06iz9Pl4j31z
        79LYZsXP0Gb2sowi4ToraSxTEjeWV5oyF/T9wCtlPSrKoofYmnCuFOiu90lg7azQmgX6ygiW6O3
        IXZUvmnYE1WTkvIb706SHkODO
X-Received: by 2002:a05:6402:1e94:: with SMTP id f20mr14266193edf.58.1643211883904;
        Wed, 26 Jan 2022 07:44:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy7uQ0EN1LS78KOt+2SzSj8bnbPTHkmly9oJVJGISCGWR7A4V/TczlXQmSzFDjFNSc5l/4G9w==
X-Received: by 2002:a05:6402:1e94:: with SMTP id f20mr14266172edf.58.1643211883676;
        Wed, 26 Jan 2022 07:44:43 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id bx18sm6707218edb.93.2022.01.26.07.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 07:44:43 -0800 (PST)
Message-ID: <718ac952-e9ec-a211-9a43-d4b4a1ea001a@redhat.com>
Date:   Wed, 26 Jan 2022 16:44:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] KVM: x86: Check .flags in kvm_cpuid_check_equal() too
Content-Language: en-US
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
References: <20220126131804.2839410-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220126131804.2839410-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/22 14:18, Vitaly Kuznetsov wrote:
> kvm_cpuid_check_equal() checks for the (full) equality of the supplied
> CPUID data so .flags need to be checked too.
> 
> Reported-by: Sean Christopherson <seanjc@google.com>
> Fixes: c6617c61e8fe ("KVM: x86: Partially allow KVM_SET_CPUID{,2} after KVM_RUN")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>   arch/x86/kvm/cpuid.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 89d7822a8f5b..ddfd97f62ba8 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -133,6 +133,7 @@ static int kvm_cpuid_check_equal(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2
>   		orig = &vcpu->arch.cpuid_entries[i];
>   		if (e2[i].function != orig->function ||
>   		    e2[i].index != orig->index ||
> +		    e2[i].flags != orig->flags ||
>   		    e2[i].eax != orig->eax || e2[i].ebx != orig->ebx ||
>   		    e2[i].ecx != orig->ecx || e2[i].edx != orig->edx)
>   			return -EINVAL;

Queued, with Cc to stable.

Paolo

