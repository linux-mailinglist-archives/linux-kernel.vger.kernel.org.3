Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5551150A6C7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390634AbiDURRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390626AbiDURRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:17:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67E8149F2E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650561265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1YMKcSiA0LOgoG4cDHR7os5spSf2HROMrqJ1+238Lww=;
        b=cj0fzBHYl4qY6eYwpBOee9+Qmka1dtm0noXOISNgxRlSq/aYNsoi2veTYPwZRTLxxmCGRu
        43ecHb2GUvN5r35njLRQgS571QRJZ3F53RQ/E3NCyjFNnnIxDRmXny9+tMHVzY7r/IiqRv
        hJJmc0gTEx/eItYe0+w0IzhgGwMteAw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-2-os2hqjM1O64mtrhsg7Yg-1; Thu, 21 Apr 2022 13:14:24 -0400
X-MC-Unique: 2-os2hqjM1O64mtrhsg7Yg-1
Received: by mail-ed1-f71.google.com with SMTP id cf15-20020a0564020b8f00b0042599227276so1243972edb.21
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1YMKcSiA0LOgoG4cDHR7os5spSf2HROMrqJ1+238Lww=;
        b=awnBspuOACJnNErimu6vLZ9QcHxJeXdmBXjxEFNA8MSfKaCMKy0ZDr415/bohvYNsF
         7B4Z9m8RNmLwlvT1c/tCK5IM8K9VR+ELUGcIceawJ/8MqR3XPfSGn6SbsVDvB3n12rEh
         f7fq3JaO4NY7+it6wdUPTPWTsiraupL9zCp8Fg1hMIzGhJtQaP22oCoFw7YQ4rloTo1Y
         CA+mOT1lLkkbebufkZWMBimdap8LoZBueRicN489zgoCrTOb8DSKofVKLHB71mr/mSUU
         GaSc46oqh6Q33xu4ztoTILlIO5k3FP98Qqm1GVyNa2kzprSrrgwnEONyLI3jIjrueKdt
         tnwQ==
X-Gm-Message-State: AOAM531cKZV5IqJCG7udO8qLETwEjD7jc9Q5+xrMOSsXVYk5aPI6ffmW
        39AM2vtIbsR3lqCqbikz61qavyDjTG10z6AKcSgOI3sTNw85LqimfFSVPWLtIeuD9msUnGfflnS
        9gbOoR78ZaOxFlyV2mJzJm9JD
X-Received: by 2002:a17:907:7815:b0:6ce:5242:1280 with SMTP id la21-20020a170907781500b006ce52421280mr466144ejc.217.1650561263077;
        Thu, 21 Apr 2022 10:14:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjpxVRQrq2bmfsUTwiZkkocLi9PluIUEZjPLmqlLk+39bZSgQ5aZ8L7QdX/BJW0PyqWPmlIA==
X-Received: by 2002:a17:907:7815:b0:6ce:5242:1280 with SMTP id la21-20020a170907781500b006ce52421280mr466118ejc.217.1650561262828;
        Thu, 21 Apr 2022 10:14:22 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id e12-20020a170906c00c00b006e66eff7584sm8022976ejz.102.2022.04.21.10.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 10:14:22 -0700 (PDT)
Message-ID: <b1b04160-1604-8281-4c82-09b1f84ba86c@redhat.com>
Date:   Thu, 21 Apr 2022 19:14:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] KVM: x86: add HC_VMM_CUSTOM hypercall
Content-Language: en-US
To:     Peter Oskolkov <posk@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     kvm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Paul Turner <pjt@google.com>, Peter Oskolkov <posk@posk.io>
References: <20220421165137.306101-1-posk@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220421165137.306101-1-posk@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/22 18:51, Peter Oskolkov wrote:
> Allow kvm-based VMMs to request KVM to pass a custom vmcall
> from the guest to the VMM in the host.
> 
> Quite often, operating systems research projects and/or specialized
> paravirtualized workloads would benefit from a extra-low-overhead,
> extra-low-latency guest-host communication channel.

You can use a memory page and an I/O port.  It should be as fast as a 
hypercall.  You can even change it to use ioeventfd if an asynchronous 
channel is enough, and then it's going to be less than 1 us latency.

Paolo

> With cloud-hypervisor modified to handle the new hypercall (simply
> return the sum of the received arguments), the following function in
> guest_userspace_  completes, on average, in 2.5 microseconds (walltime)
> on a relatively modern Intel Xeon processor:

