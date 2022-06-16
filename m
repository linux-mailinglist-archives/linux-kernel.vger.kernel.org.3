Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B93254E589
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377565AbiFPPAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377564AbiFPPA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:00:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B287A3DA5A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655391627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sXxXlYnYhCGpc7S9VveQqavZUJPHiAJ+eb7im3bQ2A8=;
        b=J613xKgAmiRHwuYyHjAZmELJRvhrAEDdOClQJAYv8t6gwiG8VgNMrA8vfzz0jdOQRzapYX
        ASxmo/lWfCdS1b0VcWqt56mv1facitWflFHNEcgLz/F5vDBgCdssXYzovdek9PMewfZtbJ
        cukitZ7pXzisKN71fnAVj8I/r4YlnWQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-du08HW7xOvWjmGcMAh4hgQ-1; Thu, 16 Jun 2022 11:00:26 -0400
X-MC-Unique: du08HW7xOvWjmGcMAh4hgQ-1
Received: by mail-ed1-f70.google.com with SMTP id k21-20020aa7d2d5000000b0042dcac48313so1451625edr.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sXxXlYnYhCGpc7S9VveQqavZUJPHiAJ+eb7im3bQ2A8=;
        b=JgbldISVSDoMIqpIIH9jobRtXUgpklawogelWYTZ+5f5e48MSZHLWs2q6ZyiikfOa6
         cDFKvwX2furN70MX6KirGUX+c+xHS4X+ZJfoVaO2YkbPt2pgKbblSpmfhUN6j9MFHIe9
         EdP4t5JWCHQfxicaDf/EKYzUCOkdwbQFZWezIHxTjM126q5YJLdMTM+HE+ec3wBHKPAJ
         IcYKTfQtZ065WWFBbxf66fiTv/N8yaYKzK5PZ+nb/9VtU5dvhLYykGJrmKnJrzN8eACF
         U+eKG8QMZq3r6PPQEBxPSqWGfrtiBr2vX64r4rzmfPWbVryvpQ1fkAo7y57VVqjMNLW7
         7qYQ==
X-Gm-Message-State: AJIora/7eCbHoZhSrv8tje+5g8lyV4m052R21KiHLRJ8JWs9Mr1aJKBP
        6qSqk4LLMKSNbcTKsc85T1I3O1vmukZA4eIapXOouSD6CIK7EzrOr929JMKwFsk8JBrRxO10S6D
        ZYLqBcrOz1CVTNAL7Vp0rIYwZ
X-Received: by 2002:a05:6402:42c8:b0:42d:f0b0:c004 with SMTP id i8-20020a05640242c800b0042df0b0c004mr6895714edc.356.1655391624770;
        Thu, 16 Jun 2022 08:00:24 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uLrXhf+s+0dq937PbW8fcacrqQrsPZ9lwKsPd2mBj0KcNbkNXCt99ZEqW7ol+UYPqFEvfXtQ==
X-Received: by 2002:a05:6402:42c8:b0:42d:f0b0:c004 with SMTP id i8-20020a05640242c800b0042df0b0c004mr6895697edc.356.1655391624592;
        Thu, 16 Jun 2022 08:00:24 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id ky4-20020a170907778400b006fe921fcb2dsm897605ejc.49.2022.06.16.08.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 08:00:23 -0700 (PDT)
Message-ID: <e793f8f4-69dd-1824-7bb1-048428d977f4@redhat.com>
Date:   Thu, 16 Jun 2022 17:00:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 04/10] KVM: Avoid pfn_to_page() and vice versa when
 releasing pages
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220429010416.2788472-1-seanjc@google.com>
 <20220429010416.2788472-5-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220429010416.2788472-5-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/22 03:04, Sean Christopherson wrote:
> -
> +/*
> + * Note, checking for an error/noslot pfn is the caller's responsibility when
> + * directly marking a page dirty/accessed.  Unlike the "release" helpers, the
> + * "set" helpers are not to be unused when the pfn might point at garbage.
> + */

s/unused/unused/

But while at it, I'd rather add a WARN_ON(is_error_noslot_pfn(pfn)).

Paolo

>   void kvm_set_pfn_dirty(kvm_pfn_t pfn)
>   {
> -	if (kvm_is_ad_tracked_pfn(pfn))
> -		SetPageDirty(pfn_to_page(pfn));
> +	if (pfn_valid(pfn))
> +		kvm_set_page_dirty(pfn_to_page(pfn));
>   }
>   EXPORT_SYMBOL_GPL(kvm_set_pfn_dirty);
>   
>   void kvm_set_pfn_accessed(kvm_pfn_t pfn)
>   {
> -	if (kvm_is_ad_tracked_pfn(pfn))
> -		mark_page_accessed(pfn_to_page(pfn));
> +	if (pfn_valid(pfn))
> +		kvm_set_page_accessed(pfn_to_page(pfn));
>   }
>   EXPORT_SYMBOL_GPL(kvm_set_pfn_accessed);

