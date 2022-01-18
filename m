Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2919C492885
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 15:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245580AbiAROhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 09:37:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56982 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245283AbiAROhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 09:37:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642516626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I1Roh1bswl/1psuf+8JsW8+b4eb0eTKZBCJnJTJbWm4=;
        b=gDt/k+wyRsLRO5okh/DOvrUraQnDWGVm97HP74TtRJij5ETIc5lwEnoLaDXn7+NAmOGUn+
        7Lmwbnmx+AbHW9n1XFRhbfI9SD4ak6YFBqCXqVv8k5BHvCLHPdx8m7PnaJcBAZm9tgNJfL
        IPMYm2MVvL39th2MxJRVc/mcB+qK8vY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-132-DhnUDoJ5NZKlXtQt1Z8H2Q-1; Tue, 18 Jan 2022 09:37:04 -0500
X-MC-Unique: DhnUDoJ5NZKlXtQt1Z8H2Q-1
Received: by mail-ed1-f72.google.com with SMTP id el8-20020a056402360800b00403bbdcef64so1262099edb.14
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 06:37:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=I1Roh1bswl/1psuf+8JsW8+b4eb0eTKZBCJnJTJbWm4=;
        b=LaXDqEcU5PphX9mzfcpzs3ws8hKYhnkWV1hh2Wta0ZhLKMy2zbAOaV3spAvk+LIcK0
         3P2h3mHwuM/+dhnFEvjZIFFHF4/Q0DpuCb9WU4h40AdYXRgFulMxMcmOwAoyZwAsPCeA
         JYBN0VUXVTUFZCdbceAuGdi9fZ65kv/1lQi0asfzwszb2Kce+wRFAe0c/xhfTVeL2c7W
         neZdeWbLat1DmoBx4RDsnPVJn9sIrz4iRzQMUU+uBy4cIcWxqPT/RPgnM+Vwwru+3uiz
         aFXPGzU+SPOrdroDgBsfgc5L6sUEI5WqlT5BWK59iYC1V2SVcD3/1jx/yOn3BE7ubszp
         ab8g==
X-Gm-Message-State: AOAM532jqyT+4dIX/7o7Uvq4EuA2s7LIx9PDQhIrfc+ZLd0sAUIwqJt2
        2nl/4dPjYcb5igvjepP2Z0m0pbu+EvKhcL4GmQzBUO1rHuZ1Zf+qxWqAHKF5gJytVu8OMTUnIJo
        pgXarAZnfz/gJl67pB5Usa/fS/GiCSgK8cF7/j2vHP8JXkBpzyR/BG0Occ0LkoPwjDGVdVF3SPb
        Ey
X-Received: by 2002:a17:907:7601:: with SMTP id jx1mr20555842ejc.696.1642516622950;
        Tue, 18 Jan 2022 06:37:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyJziAnMIo7Ue83WoM483kFpdpRDcWL4HxXt+a5HKtfJ+yVSF2XwVc5D5V3zdoybTJ7oVrJEw==
X-Received: by 2002:a17:907:7601:: with SMTP id jx1mr20555817ejc.696.1642516622684;
        Tue, 18 Jan 2022 06:37:02 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id sh38sm5304355ejc.70.2022.01.18.06.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 06:37:02 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] KVM: x86: Partially allow KVM_SET_CPUID{,2}
 after KVM_RUN
In-Reply-To: <87pmopl9m2.fsf@redhat.com>
References: <20220117150542.2176196-1-vkuznets@redhat.com>
 <20220117150542.2176196-3-vkuznets@redhat.com>
 <c427371c-474e-1233-4e57-66210bfc5687@redhat.com>
 <87pmopl9m2.fsf@redhat.com>
Date:   Tue, 18 Jan 2022 15:37:01 +0100
Message-ID: <87h7a1kt4i.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Paolo Bonzini <pbonzini@redhat.com> writes:
>
>> On 1/17/22 16:05, Vitaly Kuznetsov wrote:
>>>   
>>> +/* Check whether the supplied CPUID data is equal to what is already set for the vCPU. */
>>> +static int kvm_cpuid_check_equal(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
>>> +				 int nent)
>>> +{
>>> +	struct kvm_cpuid_entry2 *best;
>>> +	int i;
>>> +
>>> +	for (i = 0; i < nent; i++) {
>>> +		best = kvm_find_cpuid_entry(vcpu, e2[i].function, e2[i].index);
>>> +		if (!best)
>>> +			return -EINVAL;
>>> +
>>> +		if (e2[i].eax != best->eax || e2[i].ebx != best->ebx ||
>>> +		    e2[i].ecx != best->ecx || e2[i].edx != best->edx)
>>> +			return -EINVAL;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>
>> What about this alternative implementation:
>>
...
>>
>> avoiding the repeated calls to kvm_find_cpuid_entry?
>>
>
> My version is a bit more permissive as it allows supplying CPUID entries
> in any order, not necessarily matching the original. I *guess* this
> doesn't matter much for the QEMU problem we're trying to workaround,
> I'll have to check.

I tried this with QEMU and nothing blew up, during CPU hotplug entries
come in the same order as the original. v3 which I've just sent
implements this suggestion.

-- 
Vitaly

