Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E21249C894
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 12:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240688AbiAZLZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 06:25:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58227 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240683AbiAZLZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:25:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643196317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RugB18zzKbRgn6LvZeyf1FoU4E7um+w9W1X5QJPzYFM=;
        b=bgW2hP4MTtiL8XbjiHF63F59ukW4RQFZZLyCqyfBfdzGVsUepHv+j0hsx9EsEZXfc07Wof
        tepT1lfmq9IF+HviFnKRK0OjiTFNjm1avAlD6Bg878YKmconbafRcQSw4eaz/5TeQ0V3tV
        KnpjSpWm5mMVVLTXecuSCCC6TvdOGAI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-41-TzbiA_V4NpyGH5A2HesV8g-1; Wed, 26 Jan 2022 06:25:16 -0500
X-MC-Unique: TzbiA_V4NpyGH5A2HesV8g-1
Received: by mail-ed1-f72.google.com with SMTP id k5-20020a508ac5000000b00408dec8390aso3837048edk.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 03:25:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RugB18zzKbRgn6LvZeyf1FoU4E7um+w9W1X5QJPzYFM=;
        b=IE4LPWTKftjOoqEr5XdgN0dpRG+QFyKOZZZS2SyKTJKFwgjzDZj9e1mTSoE6/b29G5
         7ReMJ0zGZRk4fyD0sR5VhLM8sxHqWdepJNpyMAoKhbBIECluDKCDR81zEYrD6Wl6GSD3
         +f75di702CBLNTejhCwSozAQaFyuiGj9cQ5scnM6I4nll21pIxjNL4Ik5DAL+Q73SV3E
         Belm5aDOYDXpaMgKzDzP1dEtvElDl+HWQXXuVmzjJYcDzv3oWNjy0AkofARGA0Yhp9Wx
         rpZr07rZnbJp2xfgblcVVr6mYCUNhJQnW8p2XbJ74Y7POQQCe4x3EzBVAUia/PNKN37y
         EHdg==
X-Gm-Message-State: AOAM530nHNc7IBL4V07DqC9vQYpg5bUfmqcB+4xVWm6j/qHuQ/uiFJjG
        b6+q109yar0KTABFO6M92KF8J3H4TL2QGo20V8un+D+w0M7cjRddYsgw5kn8o9uUkMu9ZlYkfAx
        Tw94Z4uEN+LtyVRUQviRTntGZ
X-Received: by 2002:a05:6402:438a:: with SMTP id o10mr4302430edc.342.1643196315167;
        Wed, 26 Jan 2022 03:25:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxImZKf6pR4oZC3qtFGS/4GlD++FABJyJ71KQ0vadXdqMog7wkfs9WYkA8tcKQSDzy+j2+lPA==
X-Received: by 2002:a05:6402:438a:: with SMTP id o10mr4302410edc.342.1643196315002;
        Wed, 26 Jan 2022 03:25:15 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id q10sm7328671ejn.3.2022.01.26.03.25.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 03:25:14 -0800 (PST)
Message-ID: <7a8940e0-499c-000e-351a-fe1825f7d9ba@redhat.com>
Date:   Wed, 26 Jan 2022 12:25:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] KVM: x86: Free kvm_cpuid_entry2 array on post-KVM_RUN
 KVM_SET_CPUID{,2}
Content-Language: en-US
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+be576ad7655690586eec@syzkaller.appspotmail.com
References: <20220125210445.2053429-1-seanjc@google.com>
 <875yq6iwjc.fsf@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <875yq6iwjc.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/22 12:08, Vitaly Kuznetsov wrote:
> Reviewed-by: Vitaly Kuznetsov<vkuznets@redhat.com>

Queued, thanks.

Paolo

