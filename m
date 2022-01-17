Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC26490F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 18:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238925AbiAQRak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 12:30:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23430 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237889AbiAQRaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 12:30:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642440616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/w6ywDujGqIOgc7nIxG43iGWbwsdbvdKl0S+bN7l8WM=;
        b=dF+POrFzbOE8gyiRIa84yjnHE5+zbNlaUMIqtREmT2kWMjqVUfU4MNBuABGSEuFYJfJ10H
        7mGeQ2h3k3+LYqLvKRPjd1FKqt4TG9nCgje/ifEZPNs1cYYkVPdD5QnNp+e62x/q20TSrq
        ZlX1UMAS6u5XyY4TPL8yujpfTnVybYI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-194-E1ZjEWEMO7uRPMJUxa9AXw-1; Mon, 17 Jan 2022 12:30:15 -0500
X-MC-Unique: E1ZjEWEMO7uRPMJUxa9AXw-1
Received: by mail-wm1-f72.google.com with SMTP id i81-20020a1c3b54000000b003467c58cbddso14370135wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 09:30:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/w6ywDujGqIOgc7nIxG43iGWbwsdbvdKl0S+bN7l8WM=;
        b=Rx2hHXS2Fx+keC7QyvC2Uebicr6Q7kDbg+sThGG/gTsVwWId7ufSJ3HU44zh5hyzwT
         5FG00fPaW8P4Pv65kd+q1VBNYhgi73bnsZPGdU4AYdeFZ4YnW1tnpqL1PlEB78Mo3pNP
         3Agc7d25IOAf/3XKvMok+ozGsS0nYEX6ISClWbiWjYdPAY9983RKgX0vBtKRccq0pIkb
         fuo1NijHgqRw1344koXUI1nHkL9/YGyBwdIHrxK9TpAVsNPk8yI/VaYkk63y9Cao3yku
         dZEdARoepDMZOc4BuO/5HY/NMJqCHdAm0MVuDK11ck2VvtmlpJEL7eYMgqTgA1F+d+YL
         hr2g==
X-Gm-Message-State: AOAM533j0vEgH12OfD7RCG5DSusDw5GTJxzhK/D//PIGg/OCbeYZLnUX
        onHjcXoerchowTaJe4I2gKY1+h52X0VKjRCfapl/vHQNV3pAc9jn+BH+u1QaAurY1++3qkwAy2l
        uXN/3e769CncmENb2aZSFVUDN
X-Received: by 2002:a1c:1b8d:: with SMTP id b135mr13740222wmb.106.1642440614565;
        Mon, 17 Jan 2022 09:30:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwVpMF2YQx9CrtZpY9sSGHuePn/J4o80SHieckI1taBsJrTQ/JwESYa8QUgT+segefEukoCuA==
X-Received: by 2002:a1c:1b8d:: with SMTP id b135mr13739901wmb.106.1642440609499;
        Mon, 17 Jan 2022 09:30:09 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id h17sm13847457wro.68.2022.01.17.09.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 09:30:08 -0800 (PST)
Message-ID: <c427371c-474e-1233-4e57-66210bfc5687@redhat.com>
Date:   Mon, 17 Jan 2022 18:30:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 2/4] KVM: x86: Partially allow KVM_SET_CPUID{,2} after
 KVM_RUN
Content-Language: en-US
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20220117150542.2176196-1-vkuznets@redhat.com>
 <20220117150542.2176196-3-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220117150542.2176196-3-vkuznets@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/22 16:05, Vitaly Kuznetsov wrote:
>   
> +/* Check whether the supplied CPUID data is equal to what is already set for the vCPU. */
> +static int kvm_cpuid_check_equal(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
> +				 int nent)
> +{
> +	struct kvm_cpuid_entry2 *best;
> +	int i;
> +
> +	for (i = 0; i < nent; i++) {
> +		best = kvm_find_cpuid_entry(vcpu, e2[i].function, e2[i].index);
> +		if (!best)
> +			return -EINVAL;
> +
> +		if (e2[i].eax != best->eax || e2[i].ebx != best->ebx ||
> +		    e2[i].ecx != best->ecx || e2[i].edx != best->edx)
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}

What about this alternative implementation:

/* Check whether the supplied CPUID data is equal to what is already set for the vCPU. */
static int kvm_cpuid_check_equal(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
                                  int nent)
{
         struct kvm_cpuid_entry2 *orig;
         int i;

         if (nent != vcpu->arch.cpuid_nent)
                 return -EINVAL;

         for (i = 0; i < nent; i++) {
                 orig = &vcpu->arch.cpuid_entries[i];
                 if (e2[i].function != orig->function ||
                     e2[i].index != orig->index ||
                     e2[i].eax != orig->eax || e2[i].ebx != orig->ebx ||
                     e2[i].ecx != orig->ecx || e2[i].edx != orig->edx)
                         return -EINVAL;
         }

         return 0;
}

avoiding the repeated calls to kvm_find_cpuid_entry?

Paolo

