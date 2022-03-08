Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836764D1D0E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348306AbiCHQWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243812AbiCHQWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:22:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 427A95FCE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646756474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CBvsK7yZkBxfmY+8RqkH2up0UVblpUA0JK9TMDfqBZE=;
        b=I46ezGuK34FQ+v2/UqGtQhFI7KzYJTYFA8sWSkRKffTTue0dDzwR7jlJhJ7MXENZ57auGD
        aXHU1Te6HwFQJi0hAbdMERswjGci6wlIE2qsjYBLE67g1QIzy3sVvF445l8d+k1MKoHqsS
        lnnU9Gwmmngwg0CQj+P4koHL/mxndtc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-260-ocQmvGTMMjWQ8wN8VPeZYQ-1; Tue, 08 Mar 2022 11:21:13 -0500
X-MC-Unique: ocQmvGTMMjWQ8wN8VPeZYQ-1
Received: by mail-ed1-f70.google.com with SMTP id cf6-20020a0564020b8600b00415e9b35c81so1516406edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 08:21:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CBvsK7yZkBxfmY+8RqkH2up0UVblpUA0JK9TMDfqBZE=;
        b=YH1GJW1Xn4zHvTu3nNUKxIA40c19QJPduMKpDHBkLohPVVFB+Ds9+9ZnOItAISHxq8
         nn0y4T6lqIyajhajKSyW8h6gJXdMYVF5aSd0wHLJpxzMbZbsVmcPyMSFbs7WHNSGs6el
         XBI3V4yn7viTYHSl1ED3WrLwcij0jNAd8Ojh30sFlmE31GUdDw/pzOTXsxrygJWNH6U5
         6MMGIaGfr8+yaRVLB5/SQJNC/6eoDYC4daIxg6tSQbxInyeaNNuW4MxcU4RfbAgfnYSz
         AR6OmumQSskPmXjjnGF6QONyYnsBm8arYzdVzNKiYIXyy/0bcMP454Y2Hkrngy9UKH/H
         l1HA==
X-Gm-Message-State: AOAM530ZDg4/fnfAcFpCLWxA7Eco9clb+XCMjSDaxu+yvzvwqiPWOd/x
        WOXi1MjeRAHpA7HmuJDqggkO6ep57WbY9CTKz7ihbY6XRCZ9kx1p0EccobJp8FJa0EBscpaC3TJ
        PPSzS+/C/xWyRsGXmSEigMym9
X-Received: by 2002:a17:906:7d83:b0:6ce:fee:9256 with SMTP id v3-20020a1709067d8300b006ce0fee9256mr14590789ejo.647.1646756471795;
        Tue, 08 Mar 2022 08:21:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzxQu7IYyETha9E2LZivWjB76N0egbFW8CxeJzmf5k7Cicjr6tmzT1LuArWcSRv8IfHIN9HAA==
X-Received: by 2002:a17:906:7d83:b0:6ce:fee:9256 with SMTP id v3-20020a1709067d8300b006ce0fee9256mr14590769ejo.647.1646756471507;
        Tue, 08 Mar 2022 08:21:11 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id s8-20020a170906354800b006da9dec91f2sm5746016eja.163.2022.03.08.08.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 08:21:10 -0800 (PST)
Message-ID: <2652c27e-ce8c-eb40-1979-9fe732aa9085@redhat.com>
Date:   Tue, 8 Mar 2022 17:21:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 01/25] KVM: x86/mmu: avoid indirect call for get_cr3
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        dmatlack@google.com
References: <20220221162243.683208-1-pbonzini@redhat.com>
 <20220221162243.683208-2-pbonzini@redhat.com> <YieBXzkOkB9SZpyp@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YieBXzkOkB9SZpyp@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/22 17:16, Sean Christopherson wrote:
> 
>> +static inline unsigned long kvm_mmu_get_guest_pgd(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu)
> Wrap the params, no reason to make this line so long.
> 
>> +{
>> +#ifdef CONFIG_RETPOLINE
>> +	if (mmu->get_guest_pgd == kvm_get_guest_cr3)
>> +		return kvm_read_cr3(vcpu);
> This is unnecessarily fragile and confusing at first glance.  Compilers are smart
> enough to generate a non-inline version of functions if they're used for function
> pointers, while still inlining where appropriate.  In other words, just drop
> kvm_get_guest_cr3() entirely, a al get_pdptr => kvm_pdptr_read().

Unfortunately this isn't entirely true.  The function pointer will not 
match between compilation units, in this case between the one that calls 
kvm_mmu_get_guest_pgd and the one that assigned kvm_read_cr3 to the 
function pointer.

Paolo

