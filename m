Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E281F484FD0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238769AbiAEJLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:11:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27946 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238777AbiAEJLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:11:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641373873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wGXuV03c1XyCUjItCLnIsyd8BI3JnVSWBblM+WpqoH8=;
        b=fA4Rlxe3qKLyNCbAo2AlUtPrPE49VAkNx0Gdh7VY0SlezuxWhfr1YImTnx34Lq9W+NNcVA
        2/oxKQ5Uxqn7fqNFhOWzB0ZF9GtqSyJBa2l2vEbznTnkTESGo/nlrJCnuGhazyo/jqjSqT
        nw9Fqg0E72ZF7ABcLKSubCQSd+eiVYE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-196-vJUGEg05Px2dsC4uD2klmA-1; Wed, 05 Jan 2022 04:11:12 -0500
X-MC-Unique: vJUGEg05Px2dsC4uD2klmA-1
Received: by mail-ed1-f69.google.com with SMTP id t1-20020a056402524100b003f8500f6e35so27531592edd.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 01:11:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wGXuV03c1XyCUjItCLnIsyd8BI3JnVSWBblM+WpqoH8=;
        b=k7AwNXEqhlDRjfqrBImeJ1kESSJhBKJ6JD9p9LZZhwEDISLFFPVX/JaLHN64liAfUc
         zg5wo9GerVAd4oFqvWjyXJV8qLUzq9gmuMcprMB9I6qBc89SUICehsLt49msWcbXXfte
         xihZNzF2n4lE5YR4HVU9gKTwokXseOHe1Zp0BYxYO8o1Eh1XUU+0CAmJKz5ISoRH4SCR
         sxltrYwRxjzuaz5oZZ4J7CRl/WWx9kmsm15H8IikTokBK5rGW9srDNANU4lyZq3BZ30W
         2lF0+0BTHRPeZ+q/TocoWBPoqVe2Vdvpgpz96i431aXGdEb2SNIJGpP/rUJO60Xd1p8C
         yvBA==
X-Gm-Message-State: AOAM5331qbSb06cWMbVnKPWVC+7cHiHYaVvfobUsbxbr+Th/D+bVx0z+
        kpXI8ZVPO9ECQVJ74AayNUi+fUxtae0zvjDAynYh5IPOuRbKGAYM8/DiGoKgxfz1lmOnSNhtM+C
        uO9D6Dr2ECNFqWP36K0e1dGsR
X-Received: by 2002:a17:906:cec5:: with SMTP id si5mr43790752ejb.17.1641373871343;
        Wed, 05 Jan 2022 01:11:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxj6BBCCUzfRQ9E8WIhaByAQU1q2z68Us8hyGT7uWXlHr551Ke+nkWueqXord49AuXdZQfWiQ==
X-Received: by 2002:a17:906:cec5:: with SMTP id si5mr43790742ejb.17.1641373871189;
        Wed, 05 Jan 2022 01:11:11 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id u14sm15475720edv.92.2022.01.05.01.11.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 01:11:10 -0800 (PST)
Message-ID: <ceb63787-b057-13db-4624-b430c51625f1@redhat.com>
Date:   Wed, 5 Jan 2022 10:10:54 +0100
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
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <875yr1q8oa.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/22 13:56, Vitaly Kuznetsov wrote:
>   'allowlist' of things which can change (and put
> *APICids there) and only fail KVM_SET_CPUID{,2} when we see something
> else changing.

We could also go the other way and only deny changes that result in 
changed CPU caps.  That should be easier to implement since we have 
already a mapping from CPU capability words to CPUID leaves and registers.

Paolo

