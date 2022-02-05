Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF014AA982
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 15:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380185AbiBEOtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 09:49:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21690 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231243AbiBEOtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 09:49:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644072559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mEQgZRFo19fQmRy71r2Qbo6cuNaBpLeNkSeQZXsWNWs=;
        b=F6lJ93XZXzm/NGgpUguu0rJ876uem5c3SATGVTUAXakA84yuy8AaLTpmD/5Kz0vMT+jc2h
        g6MXoSACW3BUr72/QxeHrNsXJkvCjVjXwZI/7C2gVxzQq0NjUdM5AMJS0+AQgTTQdvuV0p
        6pgLV7rPOaz5ch0Q4SqV8b+hnI3WVw8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-198-wfIHgzJFO-q7KKR_EktgYA-1; Sat, 05 Feb 2022 09:49:16 -0500
X-MC-Unique: wfIHgzJFO-q7KKR_EktgYA-1
Received: by mail-ed1-f70.google.com with SMTP id n8-20020a50cc48000000b0040f345d624aso581939edi.6
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 06:49:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mEQgZRFo19fQmRy71r2Qbo6cuNaBpLeNkSeQZXsWNWs=;
        b=J6A3ZlmFd3rqmupR53iGTNfJHXumudCsmRijBslXaPdSClC1k+B4R20nwvXaE+qD1n
         PFP3Z+y6P00mek6xQJjlmmfKAUC+40NWdWcNhO8zaYZsCXGBv2PaNVp8pYoBzKNEfK5F
         yAseT/deFS2Qe3qRvnsz6FEXuXrkhk2Z644poo8RAXI/FuuIFJt8S/EJRx2eGvv+rwDt
         uwYAkjvw5VPts214F8gNlIgRqaJq1bEMl3CH8sGdMaTRvfaq6o7cJmJ0/CRkWxLG0LZ3
         43yVAQJESPkY1GwghGIBtWcxDycNn2CnM99wBnv/ZTRq+h402M/w7AwC4iiePIL2Uxnl
         Y2jw==
X-Gm-Message-State: AOAM531FDfoDH/ZbF1M+pp8E97R+anVHhEhS9OPJJG9KNDhM3m8rvN8X
        rbWq290NIyCXux/B2cSnSu/8muANcy/bS394HIjvn5lVZ5M3lsYnoz2ngrV4Kr943buTDX3LTmc
        Ra3LzR0EdafYohI0rWOSWkEZH
X-Received: by 2002:a17:906:dc8f:: with SMTP id cs15mr3382089ejc.546.1644072555411;
        Sat, 05 Feb 2022 06:49:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz2noQzSGGTR+SnUN5urdwpcBxU4qPHHVk3X54hpTgU6RrgahhAgZuqkLzVhOyCr6OCw0/nCA==
X-Received: by 2002:a17:906:dc8f:: with SMTP id cs15mr3382074ejc.546.1644072555177;
        Sat, 05 Feb 2022 06:49:15 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id x12sm2210959edv.57.2022.02.05.06.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Feb 2022 06:49:14 -0800 (PST)
Message-ID: <04e568ee-8e44-dabe-2cc3-94b9c95287e1@redhat.com>
Date:   Sat, 5 Feb 2022 15:49:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 10/23] KVM: MMU: split cpu_role from mmu_role
Content-Language: en-US
To:     David Matlack <dmatlack@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        seanjc@google.com, vkuznets@redhat.com
References: <20220204115718.14934-1-pbonzini@redhat.com>
 <20220204115718.14934-11-pbonzini@redhat.com> <Yf2hRltaM1Ezd6SM@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Yf2hRltaM1Ezd6SM@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/22 22:57, David Matlack wrote:
>> +	vcpu->arch.root_mmu.cpu_role.base.level = 0;
>> +	vcpu->arch.guest_mmu.cpu_role.base.level = 0;
>> +	vcpu->arch.nested_mmu.cpu_role.base.level = 0;
> Will cpu_role.base.level already be 0 if CR0.PG=0 && !tdp_enabled? i.e.
> setting cpu_role.base.level to 0 might not have the desired effect.
> 
> It might not matter in practice since the shadow_mmu_init_context() and
> kvm_calc_mmu_role_common() check both the mmu_role and cpu_role, but does
> make this reset code confusing.
> 

Good point.  The (still unrealized) purpose of this series is to be able 
to check mmu_role only, so for now I'll just keep the valid bit in the 
ext part of the cpu_role.  The mmu_role's level however is never zero, 
so I can already use the level when I remove the ext part from the mmu_role.

I'll remove the valid bit of the ext part only after the cpu_role check 
is removed, because then it can trivially go.

Paolo

