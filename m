Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553CD487C25
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241026AbiAGS0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:26:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34733 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240901AbiAGS0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:26:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641579969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bXJcSEUZk6XoSn4xntB0L6+vAQub2RrKf5apdg2mID0=;
        b=bq+vnejN+slDpVHYk/2fgFOfXL6f0JjDVhT7/mTUtdbZenvuPSzJMixXERKI91xYk/HdyZ
        u52cc+HTzCDPIn97MlWJW9t91FEEt6Lymt5qH7rcZhvq5M1LJaRAujkWMx2e9wvE9MQhFg
        uC708u0fNrV5IKv9Tg+Rr6XByy+R3YM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-EJxO7K9mOviLx_hb568KDw-1; Fri, 07 Jan 2022 13:15:48 -0500
X-MC-Unique: EJxO7K9mOviLx_hb568KDw-1
Received: by mail-ed1-f71.google.com with SMTP id z3-20020a05640240c300b003f9154816ffso5283668edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 10:15:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bXJcSEUZk6XoSn4xntB0L6+vAQub2RrKf5apdg2mID0=;
        b=f1HRy0dAMSVWQJEMHFukMs/Hon7Nf6yDqhU92aLFcKLzeoxNvhOITrC9BLwxl7WhPz
         XNP8yY/BXkNsO3YBb0Pe+XBbDV1H6qXbucg+KITSzEqhuWqdOpevRoIcvgOWMim7ojr9
         gOovESk+tnEVXAFmJaPf2DNc8RdQeLyz596RlI2OumItE+mbDShuM+q/f01HaNy2r/KR
         yBIFMqnQrnAI+sErF0ISSwxfKisBrgKFTcyIXL6ST2+mwnuOLmouPyjkllFtNoySCfyK
         IR1wNyMl+6XMwxA1ImNqqDU5x5R0ykN8HN84tw0sHyyXawzGf0A9pgnm3lw6ltcRHxeR
         iEDQ==
X-Gm-Message-State: AOAM532Ds1o2lxjLIBIvAL9YXKWTXsS5Ryaro68UWlgnzCpLpZ9WmouW
        IqglvC9CxKkhvPNJvLHsID5AVek6BvCPowzVKA3m28QTSxQEyOHdzQgkxnvGLHiX/Pt1VfLaiSh
        b4sN7xZXSQi5pr6Osp4tY4W2n
X-Received: by 2002:a05:6402:5107:: with SMTP id m7mr64754800edd.266.1641579347040;
        Fri, 07 Jan 2022 10:15:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxxw8K74GgJQBPwCf8t35W2906y+r7Hs2y8F63RdQYJAk2qOp0YdFRFajSxF5czTTL8r3YW2A==
X-Received: by 2002:a05:6402:5107:: with SMTP id m7mr64754784edd.266.1641579346822;
        Fri, 07 Jan 2022 10:15:46 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id r8sm2398775edd.39.2022.01.07.10.15.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 10:15:46 -0800 (PST)
Message-ID: <5505d731-cf87-9662-33f3-08844d92877c@redhat.com>
Date:   Fri, 7 Jan 2022 19:15:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/2] KVM: x86: Forbid KVM_SET_CPUID{,2} after KVM_RUN
Content-Language: en-US
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>
Cc:     kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
References: <20211122175818.608220-1-vkuznets@redhat.com>
 <20211122175818.608220-3-vkuznets@redhat.com>
 <16368a89-99ea-e52c-47b6-bd006933ec1f@redhat.com>
 <20211227183253.45a03ca2@redhat.com>
 <61325b2b-dc93-5db2-2d0a-dd0900d947f2@redhat.com> <87mtkdqm7m.fsf@redhat.com>
 <20220103104057.4dcf7948@redhat.com> <875yr1q8oa.fsf@redhat.com>
 <ceb63787-b057-13db-4624-b430c51625f1@redhat.com> <87o84qpk7d.fsf@redhat.com>
 <877dbbq5om.fsf@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <877dbbq5om.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/22 10:02, Vitaly Kuznetsov wrote:
> 
> I'm again leaning towards an allowlist and currently I see only two
> candidates:
> 
> CPUID.01H.EBX bits 31:24 (initial LAPIC id)
> CPUID.0BH.EDX (x2APIC id)
> 
> Anything else I'm missing?

I would also ignore completely CPUID leaves 03H, 04H, 0BH, 80000005h, 
80000006h, 8000001Dh, 8000001Eh (cache and processor topology), just to 
err on the safe side.

We could change kvm_find_cpuid_entry to WARN if any of those leaves are 
passed.

Paolo

