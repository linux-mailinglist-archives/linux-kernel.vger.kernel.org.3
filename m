Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C03953A25F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351986AbiFAKPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351717AbiFAKPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:15:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C833694A8
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 03:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654078536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pRj9AHzyKB5TJaXwR3OJtsa75/r0XrfKTmyjjvhcZMw=;
        b=cuJyXQEaVLogxYbOpQ3a79TlEbJmizQGmwSTsivvekaOBR75d+qJLMOU7g9SjqvFmSxYnB
        ywDRgxrLLOO+VK0wgxFd8J4lhgvQgn7EQP0v/Dkb5nw9rWtRlB1EGHYTzc37+OkOM96aPU
        5fFq3CFGJ3gPh1/A/3nC35OEQPtD0oI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-ik_0KY5XPBWYANmTfqDesw-1; Wed, 01 Jun 2022 06:15:35 -0400
X-MC-Unique: ik_0KY5XPBWYANmTfqDesw-1
Received: by mail-ej1-f69.google.com with SMTP id gh15-20020a170906e08f00b006fea2a22319so699347ejb.20
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 03:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pRj9AHzyKB5TJaXwR3OJtsa75/r0XrfKTmyjjvhcZMw=;
        b=emXBNWCtIpVijvqx/Z2daJfb44M5gwmVP2imgr9ZO1FaAz6TWrxk0+utE+2y/ABu4B
         YQmfo6qPIZH7IozdD9Hl8277F0MJwYNspycfGS/N7KBDgaDxYiCRMKDzgy8IvoJQVF6l
         UQ3hhBj0gVaqK4i66QO44AGNjBgmUOBP/MFVrPNukLgKkcDETWrhm+uUZ+zzC5W2caaZ
         or0ZgRc9LjGNLGWeYXMjRZsmLDt1DJMtHCmSwk9QVXYs624Ux8wuKFfaFMm/0J9QuY3K
         ciwwpLPiRnDKFMpd1EvS9l8aPeNfwWFrU8SbqXJ7MTMXK1RqaRhF4jlFdLZ2hoNNuriB
         oHlA==
X-Gm-Message-State: AOAM532Z/71yYb4d57tnbGqQXol/Q00ESD/opmEYRB0Ai2uDXNXeat8r
        7VmRP2WqM7oaXZwAPxOnzTSy5fMnCPBzZ727Aic9KPyrOId35Tjgtqv0wPgCF4auDer6sfAumYa
        TNUy47EybdPvKiQwK+yxg0zd8
X-Received: by 2002:a05:6402:1103:b0:42a:ac6a:d1b8 with SMTP id u3-20020a056402110300b0042aac6ad1b8mr69810007edv.423.1654078533629;
        Wed, 01 Jun 2022 03:15:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjPlDFZ4m3jl2mHYnJxR1MRHp0SU0CR5tQK2+XwP4JW9fIvKVcf846AM5AocPVc/+iuk2Oqw==
X-Received: by 2002:a05:6402:1103:b0:42a:ac6a:d1b8 with SMTP id u3-20020a056402110300b0042aac6ad1b8mr69809955edv.423.1654078532925;
        Wed, 01 Jun 2022 03:15:32 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id n19-20020a05640205d300b0042de8155fa1sm764124edx.0.2022.06.01.03.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 03:15:32 -0700 (PDT)
Message-ID: <afa804c8-abed-3353-1f0d-fdf6cd5eab00@redhat.com>
Date:   Wed, 1 Jun 2022 12:15:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] KVM: vmx, pmu: accept 0 for absent MSRs when
 host-initiated
Content-Language: en-US
To:     "Yang, Weijiang" <weijiang.yang@intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        likexu@tencent.com
References: <20220531175450.295552-1-pbonzini@redhat.com>
 <20220531175450.295552-2-pbonzini@redhat.com> <YpZgU+vfjkRuHZZR@google.com>
 <4b59b1c0-112b-5e07-e613-607220c3b597@redhat.com>
 <2b3be388-400e-7871-7d73-aba50d49a9b7@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <2b3be388-400e-7871-7d73-aba50d49a9b7@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/22 11:12, Yang, Weijiang wrote:
>>>
>>
>> Yes, I agree.  I have started making some changes and pushed the 
>> result to kvm/arch-lbr-for-weijiang.
>>
>> Most of the MSR handling is rewritten (and untested).
>>
>> The nested VMX handling was also completely broken so I just removed 
>> it.  Instead, KVM should be adjusted so that it does not whine.
> 
> Noted, I'll run tests based on it, thanks a lot!
> 
> Has the branch been pushed? I cannot see it.

It's just lbr-for-weijiang, sorry for mistyping.

Paolo

