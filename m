Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41C44850BD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239248AbiAEKKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:10:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52115 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239230AbiAEKKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:10:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641377402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EYIR7J8q3TIsA84CjFhzw4cuwyQF/1ednNVnYGVZmik=;
        b=TRaxEw6jixPKdtJdxBDXtv+oHGee18f2BMho8y1tOJrN0sOX/5AlUzZSK6svp0xvc6E9+4
        5VxEKtxzoZ28CIsFNgMw7e6tn3R+2fu+kkte3jY1DUfqif22/DqFFM6oZ1lwgEFKCdOEdX
        MQ1I7B4B4+s2PmMWe8D5r69WPTIyQK8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-d7osVy-ANqaEG-D3u-m7tQ-1; Wed, 05 Jan 2022 05:10:01 -0500
X-MC-Unique: d7osVy-ANqaEG-D3u-m7tQ-1
Received: by mail-wm1-f72.google.com with SMTP id az9-20020a05600c600900b0034692565ca8so420604wmb.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 02:10:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=EYIR7J8q3TIsA84CjFhzw4cuwyQF/1ednNVnYGVZmik=;
        b=AaIePMDaL05h1uL5DqaAO7MFB5f9dUB9jLHlQlZGliu63cUIAyBq09l3+ZWQatZPiW
         nxbrBOxC22wzH1eTvBnIvWY0tvEdcfi86EtDRAJK3i5WD6U+GcyWnCUQk1iPXwsAQcpz
         npNxtjNbnMwdpbPT3pXvqCagQlSTAEtjnvz1EwoMZ1hGyYAZ0467f64XYyrxi/YE1qZa
         4xwBGEV7+U6xFpMF14U4IVMzDno+sFXYMrWQikFGqgdaCrQDkSI4aRqOjE8wEyNRSQOt
         YIzG+7l3bFhHkkhBRoUAW0RrKApva+S7ApJTVmVCQc+HiJLR3O5N0RIccbjtTevEZNru
         bVYA==
X-Gm-Message-State: AOAM531o6exH+D/FDNAYQcR6uGgvz59Rn5OXUQ7tvW6MJP5LX/oYJWcn
        01pPUDyDz+NqAl877YAIVFFLPH8xhv7m1wqmfDaXSdQk8yAGCcs96xtrX9YsVHgieLSzhaI1JSF
        Zmmx/ZpI+CYxzqDT8DhhzeBxAQ3ScpNuZvPuu1zAYgkd/5oLeHWLEc2gQPa9MS7OkRGWMdMr1nc
        OF
X-Received: by 2002:adf:e88a:: with SMTP id d10mr45695175wrm.114.1641377400050;
        Wed, 05 Jan 2022 02:10:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzoVBTcoWqt1ECD+LSMEnDyPI0xZ67s0U9dh842SryfHZy6fU5K7FRHxyT9LDZAuN/0IuqVnA==
X-Received: by 2002:adf:e88a:: with SMTP id d10mr45695160wrm.114.1641377399867;
        Wed, 05 Jan 2022 02:09:59 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id q3sm4505633wrr.55.2022.01.05.02.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 02:09:59 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>
Cc:     kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: x86: Forbid KVM_SET_CPUID{,2} after KVM_RUN
In-Reply-To: <ceb63787-b057-13db-4624-b430c51625f1@redhat.com>
References: <20211122175818.608220-1-vkuznets@redhat.com>
 <20211122175818.608220-3-vkuznets@redhat.com>
 <16368a89-99ea-e52c-47b6-bd006933ec1f@redhat.com>
 <20211227183253.45a03ca2@redhat.com>
 <61325b2b-dc93-5db2-2d0a-dd0900d947f2@redhat.com>
 <87mtkdqm7m.fsf@redhat.com> <20220103104057.4dcf7948@redhat.com>
 <875yr1q8oa.fsf@redhat.com>
 <ceb63787-b057-13db-4624-b430c51625f1@redhat.com>
Date:   Wed, 05 Jan 2022 11:09:58 +0100
Message-ID: <87o84qpk7d.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 1/3/22 13:56, Vitaly Kuznetsov wrote:
>>   'allowlist' of things which can change (and put
>> *APICids there) and only fail KVM_SET_CPUID{,2} when we see something
>> else changing.
>
> We could also go the other way and only deny changes that result in 
> changed CPU caps.  That should be easier to implement since we have 
> already a mapping from CPU capability words to CPUID leaves and registers.
>

Good idea, I'll look into it (if noone beats me to it).

-- 
Vitaly

