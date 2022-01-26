Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43BC49CED6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243082AbiAZPqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:46:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53212 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236060AbiAZPqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643211961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=85xNqoR4ThIkZTm0ksRjdnAn/hdDPYPlrpJkOEBO+Gw=;
        b=JTGWsYQpM5dbPo8z68CO+kDCdhUNr3ZE0QphQQSfnErwJFOKlPgzDh0pdWmnvvfwlp21Ya
        vTfwPX+JOFNryHGSlAlRXYfXmBdJdVXiMKdromNdwvnnLNNTMKzCCe/eU+HMwuGWQMJeRZ
        Hd95iOO723ip1ZmhnB8xRgrPXh5zwS4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-w8pKpwHhMzWX8V5kP8xW8w-1; Wed, 26 Jan 2022 10:45:59 -0500
X-MC-Unique: w8pKpwHhMzWX8V5kP8xW8w-1
Received: by mail-ed1-f71.google.com with SMTP id h11-20020a05640250cb00b003fa024f87c2so16899063edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 07:45:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=85xNqoR4ThIkZTm0ksRjdnAn/hdDPYPlrpJkOEBO+Gw=;
        b=Phsx/GOeIZyTvsAa9gj9zn/lYBkYtjK3BlO7cqkAxw19gFIwVVmf3r5u0HgATgrIBt
         cA5xoLQcBPPY5JPjV/9oni8UW6xCzkpnamJBo8AD9WlyhsJ6h3/Jeu3VRlDy2PCOafrP
         SGiT6rQsSSxmo+Op+XSrOB5B1yuYK456dYSgTbtOAeHkkIE3lT+1yAztbg1TLTyLuHJy
         9BcXvbnZ4a480BYxJ2aSxmBCqoMSd5VM0bwk70KgMaRoO3IfVv3n1mhTGMcd7OyF9TUu
         5zayX4fJilELVokY24n+WlWr1l3a9ijWuLxrd1jkL9IsMVpvbULMm8VyET9ucN3jn23N
         axfA==
X-Gm-Message-State: AOAM532o5j3wcbfKMQUnCm/Gvldn/zquYRefOChju7k1fHn1xS43m/QJ
        Njh1juyZWz79fal2CY3YjLvsCcygYtE2QdOh4poxxp1x1B1STANuPLjud2fyIa3FiC0X0vVahau
        tbaPQ63rgnENyiSfdhbO6Gx8J
X-Received: by 2002:a17:907:608b:: with SMTP id ht11mr19968281ejc.644.1643211957978;
        Wed, 26 Jan 2022 07:45:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxpEDNBOKy7dIjLhVKX4NyD/FEvAkY4wpp1H4YHhCLVbMYQN/BtgG/EAr7zu3rkoVxfQk9vLQ==
X-Received: by 2002:a17:907:608b:: with SMTP id ht11mr19968273ejc.644.1643211957786;
        Wed, 26 Jan 2022 07:45:57 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id l5sm7667966ejn.59.2022.01.26.07.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 07:45:57 -0800 (PST)
Message-ID: <e570f7d2-03fc-1498-bd91-6fd7aabae766@redhat.com>
Date:   Wed, 26 Jan 2022 16:45:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] KVM: selftests: Don't skip L2's VMCALL in SMM test for
 SVM guest
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
References: <20220125221725.2101126-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220125221725.2101126-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/22 23:17, Sean Christopherson wrote:
> Don't skip the vmcall() in l2_guest_code() prior to re-entering L2, doing
> so will result in L2 running to completion, popping '0' off the stack for
> RET, jumping to address '0', and ultimately dying with a triple fault
> shutdown.
> 
> It's not at all obvious why the test re-enters L2 and re-executes VMCALL,
> but presumably it serves a purpose.  The VMX path doesn't skip vmcall(),
> and the test can't possibly have passed on SVM, so just do what VMX does.
> 
> Fixes: d951b2210c1a ("KVM: selftests: smm_test: Test SMM enter from L2")
> Cc: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   tools/testing/selftests/kvm/x86_64/smm_test.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/smm_test.c b/tools/testing/selftests/kvm/x86_64/smm_test.c
> index 2da8eb8e2d96..a626d40fdb48 100644
> --- a/tools/testing/selftests/kvm/x86_64/smm_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/smm_test.c
> @@ -105,7 +105,6 @@ static void guest_code(void *arg)
>   
>   		if (cpu_has_svm()) {
>   			run_guest(svm->vmcb, svm->vmcb_gpa);
> -			svm->vmcb->save.rip += 3;
>   			run_guest(svm->vmcb, svm->vmcb_gpa);
>   		} else {
>   			vmlaunch();
> 
> base-commit: e2e83a73d7ce66f62c7830a85619542ef59c90e4

Queued, thanks.

Paolo

