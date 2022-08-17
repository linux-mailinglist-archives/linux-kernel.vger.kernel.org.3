Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43C0597486
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241172AbiHQQt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241181AbiHQQth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:49:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D6259274
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660754974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/1ipQ5oQZFUN9YfGsBUkFyNrn9BZ6I7shHodgrk8s0Y=;
        b=Yv/wf5iwER4NXZKqycipmy1JG1mDoh7OhYbihIPASOuTqeqsh9ZfEoZ8ksSRMIT5TiDJRT
        KfCFAypos07DfrymDaDj3L+NfxHUJ8Vut6QbfOUicp5xPJjc9lq+TSZvmsKoaem20PAeqG
        hvBya1EmshfgMzWY8U+Fc0gHh1tIqE4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-413-tn3FEFwyPpqW1VBJvEn96A-1; Wed, 17 Aug 2022 12:49:31 -0400
X-MC-Unique: tn3FEFwyPpqW1VBJvEn96A-1
Received: by mail-ej1-f71.google.com with SMTP id js11-20020a17090797cb00b00730d73eac83so3141100ejc.19
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=/1ipQ5oQZFUN9YfGsBUkFyNrn9BZ6I7shHodgrk8s0Y=;
        b=ufXt33laSmVzrUnliQ6Yj9TPiFPcrTX+nYOeos0q+rtOLBdONUuoGdRfL3esiCTC+O
         jglMlOqUmeDTJc9mbaU+3V3NX/a50TEYwzSaPc8KVTdfEuFWxye6mN7mLXFtmzNrbuBv
         XLL4LyRKelNXrey/bv6I5rFq0JgBO7DTzmTfE5OoaKZpXVTvTLjNncD5spA9yaEhJ0dF
         A+T+Tp5xMVkdcj9J6pgEqaOOmmdZAiTKj+wassjJwl63z8arpsOK5qf3JcIabOk1zqsz
         J1JcOtB4pxeLF/Q1fUWVMyQPYs9lmCnRNAn3HbRk29g9c0xptDNgs3gtJIteJY4ziZfa
         KIaw==
X-Gm-Message-State: ACgBeo37/Y2vmqVYdhIRGZmPJYWyGiQpkUMGA+JiLRZ0qNSSJt2MB/7A
        yEr+Yd4Grt8xwY/De53iLXLg0y4Wlas8Ap8ESoietRbrJuQUaSX3U1qBUw58mntzUTLKaEj/5Ck
        MmQd0X2JLw8qqXaNr7AuevBCc
X-Received: by 2002:a17:907:28d6:b0:731:100c:8999 with SMTP id en22-20020a17090728d600b00731100c8999mr17172348ejc.210.1660754970462;
        Wed, 17 Aug 2022 09:49:30 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7MrOYH1NnxHco479ZJzy2zL+mc4tH6RAgfWX0tYEUKApZKrUDtPkzquVyBCD6/hlYsBWXJmw==
X-Received: by 2002:a17:907:28d6:b0:731:100c:8999 with SMTP id en22-20020a17090728d600b00731100c8999mr17172340ejc.210.1660754970221;
        Wed, 17 Aug 2022 09:49:30 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id u4-20020a50eac4000000b0043ba7df7a42sm11094531edp.26.2022.08.17.09.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 09:49:29 -0700 (PDT)
Message-ID: <69d0b2c3-0c14-83c8-0913-4ee163f9c1df@redhat.com>
Date:   Wed, 17 Aug 2022 18:49:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 2/9] KVM: x86: remove return value of kvm_vcpu_block
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        mlevitsk@redhat.com, vkuznets@redhat.com
References: <20220811210605.402337-1-pbonzini@redhat.com>
 <20220811210605.402337-3-pbonzini@redhat.com> <Yvwpb6ofD1S+Rqk1@google.com>
 <78616cf8-2693-72cc-c2cc-5a849116ffc7@redhat.com>
 <Yv0aHXcmuivyJDXw@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Yv0aHXcmuivyJDXw@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/22 18:41, Sean Christopherson wrote:
> On Wed, Aug 17, 2022, Paolo Bonzini wrote:
>> On 8/17/22 01:34, Sean Christopherson wrote:
>>> Isn't freeing up the return from kvm_vcpu_check_block() unnecessary?  Can't we
>>> just do:
>>>
>>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>>> index 9f11b505cbee..ccb9f8bdeb18 100644
>>> --- a/arch/x86/kvm/x86.c
>>> +++ b/arch/x86/kvm/x86.c
>>> @@ -10633,7 +10633,7 @@ static inline int vcpu_block(struct kvm_vcpu *vcpu)
>>>                   if (hv_timer)
>>>                           kvm_lapic_switch_to_hv_timer(vcpu);
>>>
>>> -               if (!kvm_check_request(KVM_REQ_UNHALT, vcpu))
>>> +               if (!kvm_arch_vcpu_runnable(vcpu))
>>>                           return 1;
>>>           }
>>>
>>>
>>> which IMO is more intuitive and doesn't require reworking halt-polling (again).
>>
>> This was my first idea indeed.  However I didn't like calling
>> kvm_arch_vcpu_runnable() again and "did it schedule()" seemed to be a less
>> interesting result from kvm_vcpu_block() (and in fact kvm_vcpu_halt() does
>> not bother passing it up the return chain).
> 
> The flip side of calling kvm_arch_vcpu_runnable() again is that KVM will immediately
> wake the vCPU if it becomes runnable after kvm_vcpu_check_block().  The edge cases
> where the vCPU becomes runnable late are unlikely to truly matter in practice, but
> on the other hand manually re-checking kvm_arch_vcpu_runnable() means KVM gets both
> cases "right" (waited=true iff vCPU actually waited, vCPU awakened ASAP), whereas
> squishing the information into the return of kvm_vcpu_check_block() means KVM gets
> both cases "wrong" (waited=true even if schedule() was never called, vCPU left in
> a non-running state even though it's runnable).
> 
> My only hesitation with calling kvm_arch_vcpu_runnable() again is that it could be
> problematic if KVM somehow managed to consume the event that caused kvm_vcpu_has_events()
> to return true, but I don't see how that could happen without it being a KVM bug.

No, I agree that it cannot happen, and especially so after getting rid 
of the kvm_check_nested_events() call in kvm_arch_vcpu_runnable().

I'll reorder the patches and apply your suggestion.

Paolo

