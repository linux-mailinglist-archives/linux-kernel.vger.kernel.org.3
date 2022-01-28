Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D4B49FC8C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 16:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240275AbiA1PPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 10:15:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20430 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232342AbiA1PPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:15:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643382913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oxP+zl0DjqDa9zgyvpKYSPRWs2TE9ycamFWRg9ETbI0=;
        b=K5Gdt8PBs5skF3Z3s9Ntl26+7+qx1qppXcUKKWKgltAJXwyMuKZTLsojO5Z/tZA7Pk3v3a
        WNDuLHPGUclZQK/9DIveksHGyDjyOFqm+ZddjoZx3M3J7WOetfaaJjaejCW9l2YInPDYbV
        AGwi7au+zs6MCYbcdDZNd1BVQzhxORA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-vN1GjSjWPzaXmffNY8wYhA-1; Fri, 28 Jan 2022 10:15:12 -0500
X-MC-Unique: vN1GjSjWPzaXmffNY8wYhA-1
Received: by mail-ed1-f72.google.com with SMTP id p17-20020aa7c891000000b004052d1936a5so3186593eds.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 07:15:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oxP+zl0DjqDa9zgyvpKYSPRWs2TE9ycamFWRg9ETbI0=;
        b=gzpshIzGOZH/7JZUadRGNMYi0CA4HzDCEpqmaTrkmEBWN5TlnDQlgfDf3cCILDuucP
         NyrRgorVLOaT58VOy9cu0VaziCteyXoGRSRlKzHJg1wEuGSmwUnJYnanujlgVMBlSGkb
         DRCJS/ncn5I7pcS1haY4nR0wzeX0ZGGCww35kz111TtCfgpYDjYQUo9+TsQFQfKSjFQW
         9ApXzGfJAYFTmS6QZqLA0wgLvBvHco7lgmKiZ0Yhb7DIj02xizm+NuMS889KUdQUloex
         o3+e4C5UOl6HTS9R+/YqL1hp5WbWaOyjA6qfK97W/VFNwXp9DKdxfTqjD/r4mUbpnxv3
         jpjA==
X-Gm-Message-State: AOAM533zvT3RVFvhM96z8phg+Kj84ucoBDhvBw2dRNoT2Md1bifMOF86
        Rb5Wdnh2iGlV5dCy820FFqsR/REeP+qKwvucNctMvoYbF7JvxbXdPU0qV74W8RMLGvKNMO9kioW
        uixG8K58OQEPtoq67TDVF3rLH
X-Received: by 2002:a17:907:1c0b:: with SMTP id nc11mr7140735ejc.665.1643382911071;
        Fri, 28 Jan 2022 07:15:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyBFwvgdbLX3zUm783ApdawZ6SC1yXHRhEfQLr8IUgzHwKmLPpfzQIkSw9+0mcZ+I2G2HPaog==
X-Received: by 2002:a17:907:1c0b:: with SMTP id nc11mr7140707ejc.665.1643382910821;
        Fri, 28 Jan 2022 07:15:10 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id u3sm10186042ejz.99.2022.01.28.07.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 07:15:10 -0800 (PST)
Message-ID: <b84dbb2c-0319-e9cc-adbe-bf78be6652d5@redhat.com>
Date:   Fri, 28 Jan 2022 16:15:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 0/5] KVM: nVMX: Fix Windows 11 + WSL2 + Enlightened
 VMCS
Content-Language: en-US
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20220112170134.1904308-1-vkuznets@redhat.com>
 <87k0exktsx.fsf@redhat.com> <86b78fe0-7123-4534-6aaf-12bd30463665@redhat.com>
 <87wnikeyr9.fsf@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <87wnikeyr9.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/22 15:11, Vitaly Kuznetsov wrote:
> I see your pull request to Linus, will send the backport when it lands.
> In fact, all 5 patches apply to 5.16 without issues but I guess stable@
> tooling won't pick them up automatically.

I noticed, but I wasn't sure what the dependencies were among them and 
whether you'd prefer to only have patches 3-5; so I didn't just add "Cc: 
stable" myself.

Paolo

