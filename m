Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F0B48746A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 10:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346320AbiAGJCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 04:02:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39180 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236447AbiAGJCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 04:02:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641546173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CJchP5kOngEUoTXC4a4FHodWajBGnUqSRJ+6FN2eEDs=;
        b=S5a7WvbxjR2nFOMopatoPuxdO+FL/gI/dk+n0qAcTF/w3CL86xD6JBHogLnIKXCyJehHTA
        UOEsffVFazgkbl+cmsRlmYP7LAhGAwSlFIgRwfmD5REqgfkdozlE5lKxLSmQno9Sp/G66Q
        882ysD8iJjVSmCkvm1P7xj67YJY3vho=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-402-qTWjSXsXPI2N_r5u5P17Jg-1; Fri, 07 Jan 2022 04:02:51 -0500
X-MC-Unique: qTWjSXsXPI2N_r5u5P17Jg-1
Received: by mail-wm1-f72.google.com with SMTP id b9-20020a7bc249000000b00347c5699809so311179wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 01:02:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=CJchP5kOngEUoTXC4a4FHodWajBGnUqSRJ+6FN2eEDs=;
        b=kLLutbGt95N/0EqAcpHoWEvp+jI6uN2SK9ZKaP2v7FtK+8ndknCwFBJShAptUwryd+
         7MJUBtddzL2vcWxy7jAE8FZuinwXEbaxHHMI6jTE72gAB8zRQtXBjPg2sphnnxzIb6zb
         POOYo1STnpsFbOk6BHyETBZD7qggOH5uzIWC55jJtOIzi0J+E6GClWEaWpyZLXaC1CUN
         TZOCAvvrLmmpf/0uXF4/zmdbsS5iNO46Klg/0jpkJEK4jOxrEWbSwCteViC0WCneEyDz
         fmUgKy09e5+D7XQ4TL8K6K0BEcgX8c6740adgIgWjk2iHIhpkPie3JWyYAcxQ4++Hwt4
         CAaw==
X-Gm-Message-State: AOAM530nGbQalxmwPDV0gBRPAvcxPkFev6VzxyjrQ+ZvmPMCWu82rIo/
        WxSWHEmluH4oyASHpLLl3Uow+gB5qDkB6BhvEmcw3v/KAczJPcXIUaLqR/V8GEKB6qbAaJxBAAB
        byd2Seow9sA17eiXWEGwi7Q/Xny707wyEJJNjSG9eQGI5J5tqmX/zWU01iEMV1rz7l2+TH2mXDj
        GM
X-Received: by 2002:a05:6000:18af:: with SMTP id b15mr54674608wri.616.1641546170662;
        Fri, 07 Jan 2022 01:02:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyUgmSz+l/wRVwxeLTLElb+dNEm/Bi1KmSXD60E+b+hiSO3aMTKaLSf5ws/BZMiISGTJPusOQ==
X-Received: by 2002:a05:6000:18af:: with SMTP id b15mr54674587wri.616.1641546170411;
        Fri, 07 Jan 2022 01:02:50 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id y11sm4159245wrp.86.2022.01.07.01.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 01:02:49 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>
Cc:     kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: x86: Forbid KVM_SET_CPUID{,2} after KVM_RUN
In-Reply-To: <87o84qpk7d.fsf@redhat.com>
References: <20211122175818.608220-1-vkuznets@redhat.com>
 <20211122175818.608220-3-vkuznets@redhat.com>
 <16368a89-99ea-e52c-47b6-bd006933ec1f@redhat.com>
 <20211227183253.45a03ca2@redhat.com>
 <61325b2b-dc93-5db2-2d0a-dd0900d947f2@redhat.com>
 <87mtkdqm7m.fsf@redhat.com> <20220103104057.4dcf7948@redhat.com>
 <875yr1q8oa.fsf@redhat.com>
 <ceb63787-b057-13db-4624-b430c51625f1@redhat.com>
 <87o84qpk7d.fsf@redhat.com>
Date:   Fri, 07 Jan 2022 10:02:49 +0100
Message-ID: <877dbbq5om.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Paolo Bonzini <pbonzini@redhat.com> writes:
>
>> On 1/3/22 13:56, Vitaly Kuznetsov wrote:
>>>   'allowlist' of things which can change (and put
>>> *APICids there) and only fail KVM_SET_CPUID{,2} when we see something
>>> else changing.
>>
>> We could also go the other way and only deny changes that result in 
>> changed CPU caps.  That should be easier to implement since we have 
>> already a mapping from CPU capability words to CPUID leaves and registers.
>>
>
> Good idea, I'll look into it (if noone beats me to it).

(just getting to it)

On the other hand, e.g. MAXPHYADDR (CPUID 0x80000008.EAX) is not a CPU
cap but it's one of the main reasons why we want to forbid
KVM_SET_CPUID{,2} after KVM_RUN in the first place. I'm also not sure
about allowing PV feature bits changes (KVM, Hyper-V, Xen) and I don't
think there's a need for that.

I'm again leaning towards an allowlist and currently I see only two
candidates:

CPUID.01H.EBX bits 31:24 (initial LAPIC id)
CPUID.0BH.EDX (x2APIC id)

Anything else I'm missing?

-- 
Vitaly

