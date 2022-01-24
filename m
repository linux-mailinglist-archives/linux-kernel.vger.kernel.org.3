Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F6F4985E2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244133AbiAXRHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:07:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:39605 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244146AbiAXRHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:07:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643044051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LKa+X5L3QDzxsSkbPXeCVIlZkDz5is1AA5jgaq4zus0=;
        b=UGJTTA097mL2pSxyZpj+mJ5VM6KYiU1AcM698PvC25wq6QEKaRL2AlgaYkdwmBPCzRNslh
        WMx8NglSUN9JSmOje4i0cTB2cIEvv2umxbQ83Hw2R6JQcNKJpVV+6Ki3MWOQ9okI18oVZj
        nm6TWBYk+iC8CgZ1x7bmGeBv37zOy+M=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-Oahr_3HmOwisqP6lFemhpA-1; Mon, 24 Jan 2022 12:07:30 -0500
X-MC-Unique: Oahr_3HmOwisqP6lFemhpA-1
Received: by mail-ed1-f72.google.com with SMTP id w23-20020a50d797000000b00406d33c039dso5961423edi.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 09:07:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LKa+X5L3QDzxsSkbPXeCVIlZkDz5is1AA5jgaq4zus0=;
        b=5h0J3l/Fxeh/VWSwnQ7Wqp+9xTusy0anoxlzCBHjgIXg4FNGT3eN9RFz8RzVGnxN0j
         1+QkwmNc6xl3GdLi7uQ1voFUmOV1I6jYIjkFcb8OVooh1Du1RcKAD67U5+jpFDVTFAaO
         ZbJIbAZL2EqoD4BpYUVw4cFQGOqEhnspHXPTCYBIMwIdqg6SJuwDxRGnZSyOxdfi42U1
         VH59K+YBVyTGecfjB5EX/mBddaz61yFv5CUvttPrnzASEjg6FuAnN3xTtC+ieG7cH/pv
         y6zFIO8FXxcV25BRQIxkOlbz9htDgrRJJ0uAd7bfy0/YXY14Z6my58vQIiojTiR4ZVEX
         RJoQ==
X-Gm-Message-State: AOAM533Ip8BZhCyXm32n7IrzBGIgQ0oM6kArA2juPqe1v5AliEquMxJJ
        q8pA/9uiMZfW59IwNOWUamiihmMmGLWCSdQTPXj3o2hddyv6Yr6lTHEIt+a6luoNAuaLFE67fA9
        /SRxYd3ICNiGlwXSn9DprYbgK
X-Received: by 2002:a05:6402:3719:: with SMTP id ek25mr16624316edb.184.1643044049417;
        Mon, 24 Jan 2022 09:07:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJztXM9zvZpq8MpyKh4SDBBtgMtS5GEB+X+ZtAPHxie4kGfRsFVN/rTbpfOQiG00Gi+lx8gdEg==
X-Received: by 2002:a05:6402:3719:: with SMTP id ek25mr16624303edb.184.1643044049234;
        Mon, 24 Jan 2022 09:07:29 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id u12sm6951407edq.8.2022.01.24.09.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 09:07:28 -0800 (PST)
Message-ID: <979883b4-8fcd-7488-0313-de6348863b21@redhat.com>
Date:   Mon, 24 Jan 2022 18:07:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/2] KVM: x86: Use memcmp in kvm_cpuid_check_equal()
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20220124103606.2630588-1-vkuznets@redhat.com>
 <20220124103606.2630588-3-vkuznets@redhat.com>
 <95f63ed6-743b-3547-dda1-4fe83bc39070@redhat.com> <87bl01i2zl.fsf@redhat.com>
 <Ye7ZQJ6NYoZqK9yk@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Ye7ZQJ6NYoZqK9yk@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 17:52, Sean Christopherson wrote:
> On Mon, Jan 24, 2022, Vitaly Kuznetsov wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>>> +	if (memcmp(e2, vcpu->arch.cpuid_entries, nent * sizeof(*e2)))
>>>> +		return -EINVAL;
>>>
>>> Hmm, not sure about that due to the padding in struct kvm_cpuid_entry2.
>>>    It might break userspace that isn't too careful about zeroing it.
> 
> Given that we already are fully committed to potentially breaking userspace by
> disallowing KVM_SET_CPUID{2} after KVM_RUN, we might as well get greedy.

Hmm, I thought this series was because we were _not_ fully committed. :)

>> FWIW, QEMU zeroes the whole thing before setting individual CPUID
>> entries. Legacy KVM_SET_CPUID call is also not afffected as it copies
>> entries to a newly allocated "struct kvm_cpuid_entry2[]" and explicitly
>> zeroes padding.
>>
>> Do we need to at least add a check for ".flags"?
> 
> Yes.

Yes, we do.  Alternatively, we can replace memdup with a copy in the 
style of KVM_CPUID.

Paolo

