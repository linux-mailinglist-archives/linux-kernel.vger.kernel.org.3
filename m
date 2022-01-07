Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DED4879C0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 16:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239665AbiAGPdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 10:33:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46545 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239528AbiAGPdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 10:33:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641569581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H/H2mDX2q8rcyZbVzf/HillL5w4kGErId3g4pPO9m2w=;
        b=MzCGZCmGgOufnL7VYI+cvKSwNO9fY3Fa3BfZ7OMbELooLoFcFx2orU4P34kjPYFRB4BMwP
        dKmNO08djGPlFPqOgTSVipzwAsnY+0dPxfIe3Y6vPrfMQPPcRLsgPkqm1EAHnv6m8Ox92C
        t8CvaSDqfqOEkcUnn+2wVyuCcPHNHt8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-Kp8eicLQNbGSo3uGWEuH6g-1; Fri, 07 Jan 2022 10:33:00 -0500
X-MC-Unique: Kp8eicLQNbGSo3uGWEuH6g-1
Received: by mail-ed1-f69.google.com with SMTP id s7-20020a056402520700b003f841380832so4962816edd.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 07:33:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H/H2mDX2q8rcyZbVzf/HillL5w4kGErId3g4pPO9m2w=;
        b=ARNZmovNOm4oIj/v3ve6cGEaByf0ef/XfOQ9DbomH8lAmCR+uQbi9+IKl8lrNQL/Qw
         AEaa6FfaOPhb5kw+YL0GVl/byrka9F9pJMq0rwlEdEvaMZeLJnX+GAcF25NLc1mkHXWu
         8CaWpnX3P+UL8Qktj43OrfDK/fXzDWX70y2YL5TyWGl03EX0dLyWTIPWfVMIdr3glXFQ
         wcH9/eMYb62ql3S+qOipDAOmMxsI1d47n10DywzZR7S5Gl6btxM/9mpR2KYjWRKqM6ri
         QSmyKqm/pJbL/pWh4rYqKfQPNzaE4EVhh/5nJAMdljMtjk4qlwdYiCTIzenM3BbaGj0m
         g1yg==
X-Gm-Message-State: AOAM530jDlxfUHPGS8Vy2QpE2WPgjLjlf1rRxU07uy8RklGZ38Bz3nfT
        wgnUoxgrZTf/VIFvt7TaTSetyB9UcYyaoiIN3rMgQx5NobO5Z6Zge0VVro/lbOfcrDG23AVatr6
        wgFoS/sAcCj5hq+UadgUxFcYz
X-Received: by 2002:a17:906:f02:: with SMTP id z2mr40837786eji.499.1641569569288;
        Fri, 07 Jan 2022 07:32:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXPZxhuv8SeNED/De3domyV+TcjynfaIg7g6FcPzOCYEs+sBMHCOkLDFMiOd6U29lCQOssLg==
X-Received: by 2002:a17:906:f02:: with SMTP id z2mr40837765eji.499.1641569569065;
        Fri, 07 Jan 2022 07:32:49 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id gs9sm1490609ejc.30.2022.01.07.07.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 07:32:48 -0800 (PST)
Message-ID: <6a11edec-c29a-95df-393e-363e1af46257@redhat.com>
Date:   Fri, 7 Jan 2022 16:32:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 3/5] KVM: SVM: fix race between interrupt delivery and
 AVIC inhibition
Content-Language: en-US
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@redhat.com>
References: <20211213104634.199141-1-mlevitsk@redhat.com>
 <20211213104634.199141-4-mlevitsk@redhat.com> <YdTPvdY6ysjXMpAU@google.com>
 <628ac6d9b16c6b3a2573f717df0d2417df7caddb.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <628ac6d9b16c6b3a2573f717df0d2417df7caddb.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/22 12:03, Maxim Levitsky wrote:
>>> -	if (!vcpu->arch.apicv_active)
>>> -		return -1;
>>> -
>>> +	/*
>>> +	 * Below, we have to handle anyway the case of AVIC being disabled
>>> +	 * in the middle of this function, and there is hardly any overhead
>>> +	 * if AVIC is disabled.  So, we do not bother returning -1 and handle
>>> +	 * the kick ourselves for disabled APICv.
>> Hmm, my preference would be to keep the "return -1" even though apicv_active must
>> be rechecked.  That would help highlight that returning "failure" after this point
>> is not an option as it would result in kvm_lapic_set_irr() being called twice.
> I don't mind either - this will fix the tracepoint I recently added to report the
> number of interrupts that were delivered by AVIC/APICv - with this patch,
> all of them count as such.

The reasoning here is that, unlike VMX, we have to react anyway to 
vcpu->arch.apicv_active becoming false halfway through the function.

Removing the early return means that there's one less case of load 
(mis)reordering that the reader has to check.  So I really would prefer 
to remove it.

Agreed with the other feedback.

Paolo

