Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9BE4AA987
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 15:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380225AbiBEOw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 09:52:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41713 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380219AbiBEOwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 09:52:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644072739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3lARlYWJDeletNZJMM+ZTQxspiOumhW2kAAZSQM40XY=;
        b=KSUWCkyNPd0XOy8hjRAhp/Ki/1u4KMK/NjMgVHgzzIaOcYay7TcdZZSbfiL32fobE9oYQf
        zXSkjQGR29348q+FcqjUJ9DOQaudiI7ZS2Of0cek0qR9og/owTpGy7mo4HE7jRpla7+mw+
        ffPXtB+fF+HJCCa8ulphHSmCPiR2amQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-ny3TtF4cOCuKMJUC_3im2A-1; Sat, 05 Feb 2022 09:52:18 -0500
X-MC-Unique: ny3TtF4cOCuKMJUC_3im2A-1
Received: by mail-ed1-f71.google.com with SMTP id k12-20020a50c8cc000000b0040f28426e5aso1130366edh.17
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 06:52:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3lARlYWJDeletNZJMM+ZTQxspiOumhW2kAAZSQM40XY=;
        b=lwrxmUHIysrCLeVwlsrxWtaot9GQ+EUghJpqURzSfHJWDJIavcD0jRISlPIVC86ujx
         REggbM/Gq94IF+gVLvEuU3n5OWWBX6vTwca7+k5/fxWZyT+AulspiBUs3Hkx0J5oDUUD
         s1TTKPvkCajapt2P6rOmwlbcm1NzeXEk6VL+FdyH745m/pbUdE7QnWr0R2lE0GJFUFs6
         g6LRSHGULsr3jtptLmFV4geDg1qaw3QpI1LyaYJi49H1mq10pCbudtgOksjdGscSoEYV
         ng8rhRb63la9WmMs19VKcINDp7iGvaQCGbRuEzhMw9OJc1wvk1NTHlwRS+zkk8Tzac20
         omGA==
X-Gm-Message-State: AOAM533umXisgS5OLD8OtNyvDO4VF2nttgnaDWTDs1l34Q6VwWJxsgyQ
        pRg/DmkTrAXKXL6zD9PwqUV2yOAsRd/79eAHxsL6romm6B0xsvZcmve4puME5s2hfI8L6UyqR8R
        SMuNv4shT8lRXUWIDLgFJcO9w
X-Received: by 2002:a17:907:6088:: with SMTP id ht8mr3163516ejc.619.1644072737064;
        Sat, 05 Feb 2022 06:52:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJypH0ci7mM7ixEHIqO1itdfG77maLYLOSfg5GdsnSqPQKtcDVLVYZQsVowBClda+vHT14MrPg==
X-Received: by 2002:a17:907:6088:: with SMTP id ht8mr3163504ejc.619.1644072736880;
        Sat, 05 Feb 2022 06:52:16 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id oz18sm1682235ejb.106.2022.02.05.06.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Feb 2022 06:52:16 -0800 (PST)
Message-ID: <8081cbe5-6d12-9f99-9f0f-13c1d7617647@redhat.com>
Date:   Sat, 5 Feb 2022 15:52:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 01/23] KVM: MMU: pass uses_nx directly to
 reset_shadow_zero_bits_mask
Content-Language: en-US
To:     David Matlack <dmatlack@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        seanjc@google.com, vkuznets@redhat.com
References: <20220204115718.14934-1-pbonzini@redhat.com>
 <20220204115718.14934-2-pbonzini@redhat.com> <Yf1pk1EEBXj0O0/p@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Yf1pk1EEBXj0O0/p@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/22 18:59, David Matlack wrote:
>> +	reset_shadow_zero_bits_mask(vcpu, context, is_efer_nx(context));
> 
> Out of curiousity, how does KVM mitigate iTLB multi-hit when shadowing
> NPT and the guest has not enabled EFER.NX?

You got me worried for a second but iTLB multihit is Intel-only, isn't it?

Paolo

