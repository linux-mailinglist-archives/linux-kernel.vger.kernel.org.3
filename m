Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBE4494EAE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 14:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245206AbiATNNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 08:13:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:31987 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235735AbiATNNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 08:13:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642684396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PlG/UY1EoRpZ+sBIhBb6wHnDaPgIOBEAu+WNugc1JUk=;
        b=QR+fkKlPTNsS4jChX67KqkApEWG9MYLcTeDrMLBhDEuR9BGluBK5M6o3Z//ztPxhvQbKtH
        npfp1wgqr6v3conUoQVJ6PAOCG+xlfez9Mf3cxC8JbEhiNNV9WRslDutqfawFRnWdsbY0a
        MtPA2msg9zw+WjzKH4sP3hPuHOXRRto=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-5NL6Jp9AMdmXnlTFcoss1g-1; Thu, 20 Jan 2022 08:13:14 -0500
X-MC-Unique: 5NL6Jp9AMdmXnlTFcoss1g-1
Received: by mail-wm1-f72.google.com with SMTP id s17-20020a7bc0d1000000b00348737ba2a2so4056426wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 05:13:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PlG/UY1EoRpZ+sBIhBb6wHnDaPgIOBEAu+WNugc1JUk=;
        b=o+AywXlVbHoWmdTgy4VDLj3EkChS0I8sDVNRrGSacGYE1mtEtngcuwdE1ic0btgn+G
         2uCdWqigXGB07PQ+b698OrZ6TRV4VGUZT99LuErm1VzBcF3vvu/cfuWnQF11Oa8Y1cHd
         e6wHccid/PTMrP2TAUm4S6rIpMDvHL2wkVtlLiwFhx3llE2IJ+BQM2rfAyKuVynKTGxj
         tn7GBgsTsMFCkDesSBNcLaTEmDUigUoOp5LVF3agTr6gd9KMgg2X7Z4waSVLAforCRuG
         PnpUAU3m8dgwApKnabCW/b1zuTeNTsCBTKw+JOGZVAzxwMQMZ7JiyZjCvz9okO0ui2x8
         E8zw==
X-Gm-Message-State: AOAM531vxnSaX65cEOi05aKfeIhUFts3qbsJT+ZhsJ4AVgZ4TBLHEtvn
        JqZ5o0sycyS8Bo5CtO2NDzMKXafHiJO050VJ5KHrTYDb9iOzcUALjQhq8rK9MVbWwfgP0SwuCp8
        G+ZYoK5j6v5p+GsiYR7YGLR7g
X-Received: by 2002:a5d:6250:: with SMTP id m16mr28816395wrv.412.1642684393628;
        Thu, 20 Jan 2022 05:13:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJybDtc8wRMaWoutaI3x5E7U4r2XuIsjC+EU8HfkovMp8xSO/JskEJQ/iuy25/gHE9m0v4NMkQ==
X-Received: by 2002:a5d:6250:: with SMTP id m16mr28816349wrv.412.1642684393407;
        Thu, 20 Jan 2022 05:13:13 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id a26sm7524301wmb.37.2022.01.20.05.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 05:13:12 -0800 (PST)
Message-ID: <f39d3e7e-8eee-a371-b2b6-175d4b023720@redhat.com>
Date:   Thu, 20 Jan 2022 14:13:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 5/7] kvm/riscv: rework guest entry logic
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>, palmer@dabbelt.com
Cc:     linux-kernel@vger.kernel.org, aleksandar.qemu.devel@gmail.com,
        alexandru.elisei@arm.com, anup.patel@wdc.com,
        aou@eecs.berkeley.edu, atish.patra@wdc.com,
        borntraeger@linux.ibm.com, bp@alien8.de, catalin.marinas@arm.com,
        chenhuacai@kernel.org, dave.hansen@linux.intel.com,
        frankja@linux.ibm.com, frederic@kernel.org, gor@linux.ibm.com,
        hca@linux.ibm.com, james.morse@arm.com, jmattson@google.com,
        joro@8bytes.org, luto@kernel.org, maz@kernel.org, mingo@redhat.com,
        mpe@ellerman.id.au, nsaenzju@redhat.com, paulmck@kernel.org,
        paul.walmsley@sifive.com, peterz@infradead.org, seanjc@google.com,
        suzuki.poulose@arm.com, svens@linux.ibm.com, tglx@linutronix.de,
        tsbogend@alpha.franken.de, vkuznets@redhat.com,
        wanpengli@tencent.com, will@kernel.org
References: <20220119105854.3160683-1-mark.rutland@arm.com>
 <20220119105854.3160683-6-mark.rutland@arm.com>
 <771780a3-39a7-f87e-4b5b-45cf95b3896a@redhat.com>
 <YelcA/jl6YEfk7m4@FVFF77S0Q05N>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YelcA/jl6YEfk7m4@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/22 13:56, Mark Rutland wrote:
>> This should be the required architectural behavior: "a CSR access is
>> performed after the execution of any prior instructions in program order
>> whose behavior modifies or is modified by the CSR state and before the
>> execution of any subsequent instructions in program order whose behavior
>> modifies or is modified by the CSR state" (Zicsr spec, paragraph "CSR Access
>> Ordering", available at
>> https://www.five-embeddev.com/riscv-isa-manual/latest/csr.html#csrinsts).
>
> I think that's necessary, but not sufficient.
> 
> IIUC that wording means that writes to the CSR state occur in program order
> without requiring additional barriers to take effect. The current value of the
> CSR determines whether interrupts *can* be taken, but that doesn't say that
> pending interrrupts *must*  be taken immediately when unmasked in the CSR.

I see.  Yeah, my reasoning was that there would be _different_ 
instructions executed after the CSR write if an interrupt has to be 
taken, but perhaps that's a bit of a stretch.

Paolo

