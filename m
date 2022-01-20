Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D410D494CA3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 12:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiATLSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:18:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28123 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229891AbiATLSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:18:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642677495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8fLvfx+nhdIogFNZUxlmf28QzOg0ipIY9RkITEbK86U=;
        b=M8YEc8hdvsM9zpCtc9Gy0L4lP4JV2hY4t69dAtDI9lIgZQA0VwDzYLtg9beQLZdHBbJxz6
        jGLOSaj8Mt5SO9xB0UCOCyv9DRBGwtTNpEYvqm/kcPA5AOR3B1ONmM+I2qxe7YiSFyCiXp
        86h+p2xbPPGaC7ueQ5psIPhsQgjouck=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-570-4Ko6DZhVN_iVFgwE_SCJfA-1; Thu, 20 Jan 2022 06:18:14 -0500
X-MC-Unique: 4Ko6DZhVN_iVFgwE_SCJfA-1
Received: by mail-wm1-f72.google.com with SMTP id v185-20020a1cacc2000000b0034906580813so6581128wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 03:18:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8fLvfx+nhdIogFNZUxlmf28QzOg0ipIY9RkITEbK86U=;
        b=pip0RW72BLPAzRiSNYpsSCaCvTkAlf8JU2Jkw9tHldxuJ8+8NvWdfotpMjbEolaGJs
         tg/Itx3EElG20sWv4V2wBBqdrS6jgg5cPdUmIoMe3oiNVz0qgQQjtOBnPFbk04UPD8FY
         hQZ6d0Cox7BUp4nMleYeEdd0eSjrNeRYe5/YFbEPtA/SLI7Dk3fPP2/v6GLM96Lv/0Zy
         Xuu5EqctvjQPJt5jWyLgv2YUVt/XUoJ7MAMlPFxr2PrFcLNyUBNMgYFLcIv+0RbI0OsE
         kiD/gYwi2yCgVQ8VJgII51VXp2XCYIErO3ghvMHB/WzfhpMwgZmioepjQpSJw0gdyUWD
         5Vzg==
X-Gm-Message-State: AOAM532VOjyCVQp2CbYUgDD0d8pmP5NvIRhQdKBSJMbZM/dm/OaFGD6r
        DtBi1cgaoBodv1IrNG162RaLxNZprvWVyf3V897XCdOoeor3akBZTSjtLj4xg/GnS1fCzrixGs1
        R/WFJ4VFaoOLBPFbNn2yTAorQ
X-Received: by 2002:a1c:f706:: with SMTP id v6mr8276395wmh.140.1642677493239;
        Thu, 20 Jan 2022 03:18:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJywNF89NvGIT4Ip1hINE2vTeF/eR8CdJEIqOXLj7k3HewnlhU31kPBlrqwvyvAIsXXDru/qEg==
X-Received: by 2002:a1c:f706:: with SMTP id v6mr8276364wmh.140.1642677492989;
        Thu, 20 Jan 2022 03:18:12 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id a1sm2618971wrf.42.2022.01.20.03.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 03:18:12 -0800 (PST)
Message-ID: <771780a3-39a7-f87e-4b5b-45cf95b3896a@redhat.com>
Date:   Thu, 20 Jan 2022 12:18:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 5/7] kvm/riscv: rework guest entry logic
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Cc:     aleksandar.qemu.devel@gmail.com, alexandru.elisei@arm.com,
        anup.patel@wdc.com, aou@eecs.berkeley.edu, atish.patra@wdc.com,
        borntraeger@linux.ibm.com, bp@alien8.de, catalin.marinas@arm.com,
        chenhuacai@kernel.org, dave.hansen@linux.intel.com,
        frankja@linux.ibm.com, frederic@kernel.org, gor@linux.ibm.com,
        hca@linux.ibm.com, james.morse@arm.com, jmattson@google.com,
        joro@8bytes.org, luto@kernel.org, maz@kernel.org, mingo@redhat.com,
        mpe@ellerman.id.au, nsaenzju@redhat.com, palmer@dabbelt.com,
        paulmck@kernel.org, paul.walmsley@sifive.com, peterz@infradead.org,
        seanjc@google.com, suzuki.poulose@arm.com, svens@linux.ibm.com,
        tglx@linutronix.de, tsbogend@alpha.franken.de, vkuznets@redhat.com,
        wanpengli@tencent.com, will@kernel.org
References: <20220119105854.3160683-1-mark.rutland@arm.com>
 <20220119105854.3160683-6-mark.rutland@arm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220119105854.3160683-6-mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/22 11:58, Mark Rutland wrote:
> +		 * There's no barrier which ensures that pending interrupts are
> +		 * recognised, so we just hope that the CPU takes any pending
> +		 * interrupts between the enable and disable.
>   		 */
>   		local_irq_enable();
> +		local_irq_disable();
>   

This should be the required architectural behavior: "a CSR access is 
performed after the execution of any prior instructions in program order 
whose behavior modifies or is modified by the CSR state and before the 
execution of any subsequent instructions in program order whose behavior 
modifies or is modified by the CSR state" (Zicsr spec, paragraph "CSR 
Access Ordering", available at 
https://www.five-embeddev.com/riscv-isa-manual/latest/csr.html#csrinsts).

Paolo

