Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E237494A8B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 10:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241489AbiATJSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 04:18:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29393 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238582AbiATJSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642670282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TDl62cJLzLieM8+MJy6Z/f4cSi0IK1TE0za11DkmZ4w=;
        b=eimzgECqr83IlSQfXnvTfdvvaNK4XmWN2gzW4r/l/NZJzp9+CNbis4WVpRnAUB7MW2tU6t
        FfqtdFfprJ4bHlkjG/RSflGjhnHfI2Wo2VjZ6CcLhW+Log3dj5cMQPK97RPgBlg9oPIW/g
        MKxc+iqsJSjic9UByTYCJeUn1QsLdqY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-EpjVWCmvMEqIIaF5Bzm15Q-1; Thu, 20 Jan 2022 04:18:00 -0500
X-MC-Unique: EpjVWCmvMEqIIaF5Bzm15Q-1
Received: by mail-wm1-f72.google.com with SMTP id l20-20020a05600c1d1400b0034c29cad547so6352256wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 01:18:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TDl62cJLzLieM8+MJy6Z/f4cSi0IK1TE0za11DkmZ4w=;
        b=kAoZA7UOfO/x1J9g6+4PibkqOVGamVvq9B7tPuZKdOEOwFZIzipbA0o8IBP4NbJVRL
         aSuA2gGWzAly+s2+FJ+ogk8oonB7FAtl8fvbydA62/9F7k6mb67tTThthqpGCkNqhlSK
         iPCHh+cZB6hMBIT24HQqvju2lLI9Z45H2+cEvVGZkkEeT2TTHGfuAMt5gDMlbQP7yWBe
         3b/sBZ9WKPGVKFNQ71zR8YzTLI68kyohHm9xsUmU/XmEYT3aJNDXeaHd8aI+xSWiwtmW
         Op4EuzHjX0ZFn5Ns8m6x0dOAPlyhkU7AvSNzKbDdkv8NM86LSDooswALqGiuLGG9Eqe4
         p7cA==
X-Gm-Message-State: AOAM532eqvhSlUrcGm86RNSCMGgq6NgOCrUh/u6C7kSoZqo4GncnHf0h
        ThTyvsTrC2e6LI4WpM17HBSGcydMvjvLn1oh1GHLj+g56IVNOj1awGcAB/TDQ6k8Ryj+IxbRalS
        hnoXLdFEwP4ZIInFld9rugSZp
X-Received: by 2002:a05:600c:a47:: with SMTP id c7mr7971029wmq.23.1642670279434;
        Thu, 20 Jan 2022 01:17:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRUHrzKn5gxWntlb8Fu8JBKs+vMEpvgw4xk4jSItBmMgSlUdakFidsONjuCM1Y6NcqCzQEdA==
X-Received: by 2002:a05:600c:a47:: with SMTP id c7mr7971010wmq.23.1642670279201;
        Thu, 20 Jan 2022 01:17:59 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id k37sm8659384wms.0.2022.01.20.01.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 01:17:58 -0800 (PST)
Message-ID: <19c4168f-c65b-fc9a-fe4c-152284e18d30@redhat.com>
Date:   Thu, 20 Jan 2022 10:17:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [DROP][PATCH] KVM: x86: Fix the #GP(0) and #UD conditions for
 XSETBV emulation
Content-Language: en-US
To:     Like Xu <like.xu.linux@gmail.com>,
        Jun Nakajima <jun.nakajima@intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220117072456.71155-1-likexu@tencent.com>
 <a133d6e2-34de-8a41-475e-3858fc2902bf@redhat.com>
 <9c655b21-640f-6ce8-61b4-c6444995091e@gmail.com>
 <0d7ed850-8791-42b4-ef9a-bbaa8c52279e@redhat.com>
 <92b16faf-c9a7-4be3-43f7-3450259346e9@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <92b16faf-c9a7-4be3-43f7-3450259346e9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/22 08:48, Like Xu wrote:
> 
> In the testcase "executing XSETBV with CR4.XSAVE=0",
> 
> - on the VMX, #UD delivery does not require vm-exit;

Not your fault, it would be nicer if the Intel manual told the truth;
it says: "The following instructions cause VM exits when they are
executed in VMX non-root operation: CPUID, GETSEC[1], INVD, and XSETBV."

Footnote [1] says "An execution of GETSEC causes an invalid-opcode
exception (#UD) if CR4.SMXE[Bit 14] = 0", and there is no such footnote
for XSETBV.  Nevertheless, when tracing xsave.flat, I see that there's
a #UD vmexit and not an XSETBV vmexit:

         qemu-kvm-1637698 [019] 758186.750321: kvm_entry:            vcpu 0, rip 0x4028b7
         qemu-kvm-1637698 [019] 758186.750322: kvm_exit:             vcpu 0 reason EXCEPTION_NMI rip 0x40048d info1 0x0000000000000000 info2 0x0000000000000000 intr_info 0x80000306 error_code 0x00000000
         qemu-kvm-1637698 [019] 758186.750324: kvm_emulate_insn:     0:40048d:0f 01 d1 (prot64)
         qemu-kvm-1637698 [019] 758186.750325: kvm_inj_exception:    #UD (0x0)

So while my gut feeling that #UD would not cause a vmexit was correct,
technically I was reading the SDM incorrectly.

Jun, can you have this fixed?

Paolo

> - on the SVM, #UD is trapped but goes to the ud_interception() path;

