Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7DD349070B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 12:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbiAQLTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 06:19:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58389 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236728AbiAQLTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 06:19:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642418344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jNK4+oxv+4tUoh6c7iPxH0pa9jSuShrN6epRZwOx+g8=;
        b=iYne2BeWRIJvo17MaDfV0Rvy1SxwDEtqAgGUgdDGC/H/+5YowMT5Rp2vfE6+pS+Px2qdDw
        C/FmlXexI8gGc/GNJMkUHDShx9fMRrdbFHP8nxMeXFGJUJLNX59vsiwEkiGIJjKnWL9APV
        3OIiOlzcsWr3B3KpShp0/z1S/+n6z9U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-MGjgVKL2PKeyaDT0rxv0Vg-1; Mon, 17 Jan 2022 06:19:02 -0500
X-MC-Unique: MGjgVKL2PKeyaDT0rxv0Vg-1
Received: by mail-wm1-f70.google.com with SMTP id 20-20020a05600c22d400b00349067fe7b7so5104348wmg.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 03:19:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jNK4+oxv+4tUoh6c7iPxH0pa9jSuShrN6epRZwOx+g8=;
        b=c8aede8p/t+hZgVOZ0vou9Mcy3IUBUBjgVrxGPgcUOl2H0s6OHuHJSyv5uso+SHRc9
         lxud6XGJkUBPL21fCuXJacGVNTnBoenwl8c/Rs7rH6lDjjofcmcIJZg0Ga0dn6DJRem0
         59eZV0pyceQmdsLhFYFlvECxt9r+xhDNBL9e9hkex+jKUBOAa6Aw6LB6/uCc0xxgHYtx
         HfYfOiTzjYsA1CzKz8esLcPUur1UzNmunF8O5SL6bQXDKK+AvhMT075x1JJufNx4U5JV
         oilo8U9LPIYtoLvFzY2Be4FIJnmJZ7/2K+7HErmvI9ZqZ8eyBgEyiDjdORZsIMPs/yoM
         2z0g==
X-Gm-Message-State: AOAM533atGYHgivuaLrJ0IkKgNBPBU9yY9sQbn29MCREKeDD+5f8rZe0
        rgsmY3RqeTTXJsmwvX7+OHVb9Wf2NkLM0y9I07K7GQaJBf2kPT1vy1mYtmyhi16R9ryTuQLgSTj
        WqnWgiVsEtQUQVeTejOi/LojB
X-Received: by 2002:a05:6000:1d84:: with SMTP id bk4mr18138804wrb.708.1642418341560;
        Mon, 17 Jan 2022 03:19:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxkySeRJ518V0ql4/t4EDjr/Kj0bMU4K2b+p+m/zTp+DSVcerQx3GdHw1LNVoPty+m2NvmyfA==
X-Received: by 2002:a05:6000:1d84:: with SMTP id bk4mr18138781wrb.708.1642418341354;
        Mon, 17 Jan 2022 03:19:01 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id b6sm6340753wri.108.2022.01.17.03.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 03:19:00 -0800 (PST)
Message-ID: <0d7ed850-8791-42b4-ef9a-bbaa8c52279e@redhat.com>
Date:   Mon, 17 Jan 2022 12:18:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] KVM: x86: Fix the #GP(0) and #UD conditions for XSETBV
 emulation
Content-Language: en-US
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220117072456.71155-1-likexu@tencent.com>
 <a133d6e2-34de-8a41-475e-3858fc2902bf@redhat.com>
 <9c655b21-640f-6ce8-61b4-c6444995091e@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <9c655b21-640f-6ce8-61b4-c6444995091e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/22 10:44, Like Xu wrote:
>> Also, the "Fixes" tag is not really correct as the behavior was the 
>> same before.  Rather, it fixes commit 02d4160fbd76 ("x86: KVM: add 
>> xsetbv to the 
> 
> It seems the original code comes from 81dd35d42c9a ("KVM: SVM: Add 
> xsetbv intercept").
> 2acf923e38 ("KVM: VMX: Enable XSAVE/XRSTOR for guest") and 92f9895c146d.
> 
>> emulator", 2019-08-22).  Checking OSXSAVE is a bug in the emulator 
>> path, even though it's not needed in the XSETBV vmexit case.
> 
> The kvm_emulate_xsetbv() has been removed from the emulator path.
> I'm not really sure why it's not needed in the XSETBV vmexit case. More 
> details ?

Nevermind, I confused AMD (where #UD is generated before checking for 
exceptions) with Intel where it's unconditional.

So the bug should be there since 2acf923e38 by executing XSETBV with 
CR4.XSAVE=0.  If so, please include a testcase.

Paolo

>>
>> Thanks,
>>
>> Paolo
>>
>>> +    if ((is_protmode(vcpu) && static_call(kvm_x86_get_cpl)(vcpu) != 
>>> 0) ||
>>>           __kvm_set_xcr(vcpu, kvm_rcx_read(vcpu), 
>>> kvm_read_edx_eax(vcpu))) {
>>>           kvm_inject_gp(vcpu, 0);
>>>           return 1;
>>
>>
> 

