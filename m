Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C2048495C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 21:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbiADUhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 15:37:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44324 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231175AbiADUhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 15:37:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641328651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IPhI6OExXxGqKy+2lHJxiUzmlj9crTloqZOkCJImBO4=;
        b=BsZA73PlFR59YNPaF4OQLs7vEhQ5QYxrPqPiO6cATxexC6LhP94CxwADt+3O4Sfr7q8EwE
        NCCDMlgEUQS+2J504sm6k3KYLonA/U2lQXQJiWs5r85/WZbMzffCReQxff53EEyP2Ti+F6
        SajOluhyrZWy5QBmD1LTlzjZ0WpvHRM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-T6UpTj9KOUWYm5yldSdS0w-1; Tue, 04 Jan 2022 15:37:30 -0500
X-MC-Unique: T6UpTj9KOUWYm5yldSdS0w-1
Received: by mail-ed1-f70.google.com with SMTP id ay24-20020a056402203800b003f8491e499eso26160663edb.21
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 12:37:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IPhI6OExXxGqKy+2lHJxiUzmlj9crTloqZOkCJImBO4=;
        b=HuWW1N6JioF6n7BgxLt9rZUnfZzG1yy0T+0/IsJppnrCnV5o0Abr5xjiavsvCIytml
         /ioYmjo7nuu9meqQd6yDk++RdRDSXaFv9WSWMGQK6BrKT17QBTrem/zx2dJHTRTlbi+2
         lF+QS87rVtCaoelrKmr0jc5Fq24jCIU+d5Hq4ERFUi/9jnYXkTN2QpIPmHmVwzLX0vmF
         Ft20UCO9wbLumoG2XjQlxPDLoTP+J9dLSqxf4+z8C8dJY6y1ZO5iYbKsIothFF/G37Bt
         MJ9gbevtG8/IsmEDKKPQkFvarmZ3GAupGTLodzZisf0lWm7KW4VHsZH1e4WYgLSWhqXB
         /A2w==
X-Gm-Message-State: AOAM532sb0a9XKMNEe3F5btEP1GWJi5MBukmNBUq6X+slfDIA9eGsi/f
        pccSP59L4j/FQRoA0LL272G0UrG9o8sG685hV7HxB+4IiSM0ugkAJ7eyG2k6zemyjwy33OJ2957
        BcxdhpUrWJw6xi1CPKC/NDAee
X-Received: by 2002:a05:6402:2026:: with SMTP id ay6mr43319357edb.273.1641328649339;
        Tue, 04 Jan 2022 12:37:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxSTo5jntUK6ZUXSps5Zt9NElXirClnSHblVYWpRovERoE/hWEbYBTV+0Pgs9Fxl8dF4SQUEQ==
X-Received: by 2002:a05:6402:2026:: with SMTP id ay6mr43319345edb.273.1641328649166;
        Tue, 04 Jan 2022 12:37:29 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id s16sm15035345edt.30.2022.01.04.12.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 12:37:28 -0800 (PST)
Message-ID: <c16e310f-8ae5-9c29-04c7-7355834ce803@redhat.com>
Date:   Tue, 4 Jan 2022 21:37:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH 2/6] KVM: X86: Walk shadow page starting with
 shadow_root_level
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20211210092508.7185-1-jiangshanlai@gmail.com>
 <20211210092508.7185-3-jiangshanlai@gmail.com> <YdSvbsb5wt/WURtw@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YdSvbsb5wt/WURtw@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/22 21:34, Sean Christopherson wrote:
> On Fri, Dec 10, 2021, Lai Jiangshan wrote:
>> From: Lai Jiangshan<laijs@linux.alibaba.com>
>>
>> Walking from the root page of the shadow page table should start with
>> the level of the shadow page table: shadow_root_level.
>>
>> Also change a small defect in audit_mappings(), it is believed
>> that the current walking level is more valuable to print.
>>
>> Signed-off-by: Lai Jiangshan<laijs@linux.alibaba.com>
>> ---
>>   arch/x86/kvm/mmu/mmu_audit.c | 5 ++---
> 
> I vote we remove mmu_audit.c.  It has bitrotted horribly, and none of the
> current set of KVM developers even knows how to use it effectively.

No complaints.

Paolo

