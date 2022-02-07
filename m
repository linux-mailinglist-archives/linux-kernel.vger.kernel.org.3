Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4D04ACACF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbiBGVAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiBGVA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:00:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE2ECC06109E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 13:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644267624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=APAIHIfLKDR39mYklb+NvCddkgGL2qEPzPydIttXeMI=;
        b=LvceHLO6iYgZ/WXpyG+2QsHIzrvv1gD7Xh6pGsC95BAg8Vy3cGeZGXAy45Gy4XxoCYkQ9z
        epbtfV2VjG98B+R7ABFHI28/336WKN/kEuD8Kvur5XBgjSyBef7BHCXJCvsHBCRoWSKYA2
        XN29ki17Ti1EXKCAlh+k7a/yABL/c/M=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-601-9x2S6K6NMySjab6IdKKTag-1; Mon, 07 Feb 2022 16:00:23 -0500
X-MC-Unique: 9x2S6K6NMySjab6IdKKTag-1
Received: by mail-ed1-f69.google.com with SMTP id en7-20020a056402528700b00404aba0a6ffso8516139edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 13:00:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=APAIHIfLKDR39mYklb+NvCddkgGL2qEPzPydIttXeMI=;
        b=lbP8O+V8EOX3GqM+T5eNCN94GyYQdjjRoRontBuhn/uYnURIOxjJDXlYd4acFsk6bR
         G12/d5pXKhRL3b8Z5OixUjskItPMEElGF7f7GV/ik/bU56N6xiMt3y1b/9Hlfv2Gd6A0
         XCalxqbNyP1hAQDT4TQ7NL0NjWSo4oXmO6H7ZcBHbHpMu2yShaDg1uzF35RfAh8hFFVd
         VQEGsDn8mjN0gsHjVOO2C66W5aTzbnAeB6CYOijbXoD0n+Eku0DHVLBlqRi+rM7XA/ib
         k6QsUFdQhUebN4rcnmqwn9gz5RqaGPG7R0fdLdsB87x/Spx5W57bjX14V7DFIZj9t2Z1
         hG3w==
X-Gm-Message-State: AOAM530j5BDDQRsIvA/OCVvEKgRK/JSI3Vh26+15uhzE4zLpzB2LXrcg
        Xq3iFur2zP4d6wHiRejDxMKJu+6sgdG2fqiXP+2nvRCKcHh4nx96Ie5bpOreIcPylnf1HxJMv1j
        uYpdwiw7vb6czEvyE8XqilkDf
X-Received: by 2002:aa7:d949:: with SMTP id l9mr1313615eds.348.1644267622109;
        Mon, 07 Feb 2022 13:00:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVDJ2TFOaIxQ8E6piYDwdPjaRqm3tNCt4nDtxngH3t9659NGzChERZdm2XkY3RXlt3ZK2LmQ==
X-Received: by 2002:aa7:d949:: with SMTP id l9mr1313584eds.348.1644267621881;
        Mon, 07 Feb 2022 13:00:21 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id a19sm2238528ejt.7.2022.02.07.13.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 13:00:21 -0800 (PST)
Message-ID: <8bf8ba96-94a8-663a-ccbf-ffeab087c370@redhat.com>
Date:   Mon, 7 Feb 2022 22:00:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 1/2] x86/kvm/fpu: Mask guest fpstate->xfeatures with
 guest_supported_xcr0
Content-Language: en-US
To:     Leonardo Bras Soares Passos <leobras@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220205081658.562208-1-leobras@redhat.com>
 <20220205081658.562208-2-leobras@redhat.com>
 <f2b0cac2-2f8a-60e8-616c-73825b3f62a6@redhat.com>
 <CAJ6HWG7DV-AeWyXxGwMMV61BejcCdpTc=U+4U6eY4gx4hfhP-g@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CAJ6HWG7DV-AeWyXxGwMMV61BejcCdpTc=U+4U6eY4gx4hfhP-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/22 21:24, Leonardo Bras Soares Passos wrote:
>> With this patch,
>> we have to reason about the effect of calling KVM_SET_CPUID2 twice calls
>> back to back.  I think an "&=" would be wrong in that case.
> 
> So, you suggest something like this ?
> 
> vcpu->arch.guest_fpu.fpstate->xfeatures =
>         fpu_user_cfg.default_features & vcpu->arch.guest_supported_xcr0;
> 

Yes, but you need to change user_xfeatures instead of xfeatures. 
KVM_GET_XSAVE and KVM_SET_XSAVE will take it into account automatically:

- KVM_GET_XSAVE: fpu_copy_guest_fpstate_to_uabi -> __copy_xstate_to_uabi_buf

- KVM_SET_XSAVE: fpu_copy_uabi_to_guest_fpstate -> 
copy_uabi_from_kernel_to_xstate -> copy_uabi_to_xstate -> 
validate_user_xstate_buffer

Paolo

