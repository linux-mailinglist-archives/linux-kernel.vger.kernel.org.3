Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BF2539FE5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350934AbiFAIyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237064AbiFAIyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:54:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA8013EB83
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 01:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654073658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LOlu3mepJdx7Wf6vk2GNDsoaWQTiVkUMcr9IDdeUKvQ=;
        b=JafDHooeic0gfzUtZZg49hpzxOwSQi5o9mAk42g5ekpHSW3FYbsgXXiVELmpkqJgPftXmI
        4wx0h+axqH39pfnqtb14N5GJOTRl2bxuyIiJPPnKKP0PKP/8WSdqOYg+1MVVq5NAnabXgG
        4L79RqyFEyGm0G46SRRLZIXerw4NReo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-xxhjEPE9NO6cUZTAOR7tIQ-1; Wed, 01 Jun 2022 04:54:15 -0400
X-MC-Unique: xxhjEPE9NO6cUZTAOR7tIQ-1
Received: by mail-ed1-f71.google.com with SMTP id k21-20020aa7d2d5000000b0042dcac48313so801395edr.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 01:54:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LOlu3mepJdx7Wf6vk2GNDsoaWQTiVkUMcr9IDdeUKvQ=;
        b=Pj3haem3nW7o2yDaf+UlwSCpdiJBOeRxMWp1I52Ll0DwjyyQfgKNNIEQ5zBd2h14PE
         HX9CJ9kTEj2ACjn8a+rwygbrfKMGx/Bp6RtLrimJxwRmlBDzpS4HayjjOeDLADg2DCi+
         zOqxHNwfAQBxpMFaJ8NADAVJZjePPPkeVzHPVHm0EQcHIVaQAK0LLEWpEICsrvAnuGII
         KtAGOUFtsbfR78/Zmq0F45m2Kjtx/nHCJkUhdJNh8pC3N5HTxHcEOx+2qzHLWZ7HNyod
         VcPSH3vZNK1cCcMZsqKZu7BIvnXF2CHZGqpzUVH3aFJEfPFeLnQF7wGSpt5oLn5olsMP
         8hMA==
X-Gm-Message-State: AOAM530HpYTZ767W31o2OwuiR+MiakZxgVb5ncIO8vpkC4tFhUtS2zPT
        UyzlRupDanCS9vP4irTVy3dfLWZxn3wQi6OKAxy4kLq6NboyJ3utvYkIRW2qTj0v96PcgjlG72j
        RUzikMGCDIQDx5U+gTB9N1saW
X-Received: by 2002:a17:907:162a:b0:6fe:c691:47f5 with SMTP id hb42-20020a170907162a00b006fec69147f5mr5234900ejc.289.1654073654325;
        Wed, 01 Jun 2022 01:54:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUd8lcyszMcB8ocabW8xLa9jXoH+xjNMpG4v9dw6i4KceyMi+eG7g0nhlauX9AQpKgumjrwg==
X-Received: by 2002:a17:907:162a:b0:6fe:c691:47f5 with SMTP id hb42-20020a170907162a00b006fec69147f5mr5234888ejc.289.1654073654108;
        Wed, 01 Jun 2022 01:54:14 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id g23-20020a170906595700b006f3ef214d9fsm456978ejr.5.2022.06.01.01.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 01:54:13 -0700 (PDT)
Message-ID: <4b59b1c0-112b-5e07-e613-607220c3b597@redhat.com>
Date:   Wed, 1 Jun 2022 10:54:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] KVM: vmx, pmu: accept 0 for absent MSRs when
 host-initiated
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        likexu@tencent.com, Yang Weijiang <weijiang.yang@intel.com>
References: <20220531175450.295552-1-pbonzini@redhat.com>
 <20220531175450.295552-2-pbonzini@redhat.com> <YpZgU+vfjkRuHZZR@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YpZgU+vfjkRuHZZR@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/22 20:37, Sean Christopherson wrote:
>> +
>>   		/*
>>   		 * Writing depth MSR from guest could either setting the
>>   		 * MSR or resetting the LBR records with the side-effect.
>> @@ -535,6 +542,8 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>   	case MSR_ARCH_LBR_CTL:
>>   		if (!arch_lbr_ctl_is_valid(vcpu, data))
>>   			break;
>> +		if (!guest_cpuid_has(vcpu, X86_FEATURE_ARCH_LBR))
>> +			return 0;
> 
> Similar bug here.
> 
> Can we just punt this out of kvm/queue until its been properly reviewed?

Yes, I agree.  I have started making some changes and pushed the result 
to kvm/arch-lbr-for-weijiang.

Most of the MSR handling is rewritten (and untested).

The nested VMX handling was also completely broken so I just removed it. 
  Instead, KVM should be adjusted so that it does not whine.

Paolo

