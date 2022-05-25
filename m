Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C05C533EE8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244584AbiEYONu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiEYONo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:13:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39DF0ABF79
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653488022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EdOLHm07LUB9vwUNI1PRD+Bq0WLvIt36W6/LKY8CGGM=;
        b=YW5/YHccquoHZzOsHetsfg8iw+AG/3VRLNVkQDU36ERZ5OeRG5G577CbCtOJhN/w7adXrV
        ZmF48Fd5W1EIZ8bywuWluXsVm4VoBgCG4AHh0xuBmNAoR0k2NidoU/5XobIhiR94FfvZtS
        qIudOpX/ZRrDgqVcgcQyjm+P88S1xNA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-363-BOeO7QmsO_K19jUMjAPeew-1; Wed, 25 May 2022 10:13:41 -0400
X-MC-Unique: BOeO7QmsO_K19jUMjAPeew-1
Received: by mail-ed1-f69.google.com with SMTP id b3-20020aa7d483000000b004282ca95814so14847528edr.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EdOLHm07LUB9vwUNI1PRD+Bq0WLvIt36W6/LKY8CGGM=;
        b=KVgky9iG6L+8nVgG7lBrPPOD8I59uAfiwX2+SdQp1bTWZHRXPpGHrZL46qXH9LXdJg
         3SWPPrpXs3cL4j7wb/CTZuV6CXEPWyVgRH78L1DLZTSvzaW3yXmAnJrej9Ny41WxhDUI
         gnNzxLOfz1pwNrVrLb9y4EK5ur0n+ptXhJzAZ4bKOY3YSwkiJvW1tTsKeNZvPJpNHP3J
         oWMGGy1gao1l26GUZzUyKu29l57lpEU7T5PQ1lZqGgYN1ZnaL44+Ky9QYwo/y8joz3JC
         SxCRsQulKa4Fz0bDgDtS5QquAPXG+sY94QkuQGyGV6F10M5mfHUEfnmuYv8teXgyPcCS
         0GFw==
X-Gm-Message-State: AOAM530hxREncO1eNeo5i0u6ZqhdJ3STOgCZIO4pOffjLTMKlncmmP2x
        3HOJJiuc9CPoLPhJD6OuxGXBTR4PO09hqcR63Qr6jKNZ4H8o+FM1rZacTu3jSm/jBIxT+XLV4pR
        Z4QGV4ncKi/KInjTTS7VFGQZk
X-Received: by 2002:a17:906:7944:b0:6da:b834:2f3e with SMTP id l4-20020a170906794400b006dab8342f3emr29857524ejo.353.1653488019888;
        Wed, 25 May 2022 07:13:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzTqkBVEoLUd+XxgAzkMJHWl6aJxHKdYfp/aq/LnXRT2GqejWFSJA3UNtUebVBHJT+aWSV4Q==
X-Received: by 2002:a17:906:7944:b0:6da:b834:2f3e with SMTP id l4-20020a170906794400b006dab8342f3emr29857503ejo.353.1653488019678;
        Wed, 25 May 2022 07:13:39 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id x2-20020a170906b08200b006feb4490600sm5450529ejy.213.2022.05.25.07.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 07:13:39 -0700 (PDT)
Message-ID: <eb34985a-3f21-f4d7-f25d-28f24c9794be@redhat.com>
Date:   Wed, 25 May 2022 16:13:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH RESEND v12 00/17] KVM: x86/pmu: Add basic support to
 enable guest PEBS via DS
Content-Language: en-US
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        Like Xu <like.xu.linux@gmail.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20220411101946.20262-1-likexu@tencent.com>
 <87fsl5u3bg.fsf@redhat.com> <e0b96ebd-00ee-ead4-cf35-af910e847ada@gmail.com>
 <d7461fd4-f6ec-1a0b-6768-0008a3092add@gmail.com> <874k1ltw9y.fsf@redhat.com>
 <f379a933-15b0-6858-eeef-5fbef6e5529c@gmail.com>
 <0848a2da-c9cf-6973-c774-ff16c3e8a248@redhat.com>
 <289d0c88-36a0-afd4-4d47-f2db3fb63654@gmail.com>
 <48b495c5610d25596a268c71b627b2e2136ac0bd.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <48b495c5610d25596a268c71b627b2e2136ac0bd.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/22 16:12, Maxim Levitsky wrote:
> FYI, this patch series also break 'msr' test in kvm-unit tests.
> (kvm/queue of today, and master of the kvm-unit-tests repo)
> 
> The test tries to set the MSR_IA32_MISC_ENABLE to 0x400c51889 and gets #GP.
> 
> 
> Commenting this out, gets rid of #GP, but test still fails with unexpected result
> 
> 		if (!msr_info->host_initiated &&
> 		    ((old_val ^ data) & MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL))
> 			return 1;
> 
> 
> 
> 
> It is very possible that the test is broken, I'll check this later.

Yes, for that I've sent a patch already:

https://lore.kernel.org/kvm/20220520183207.7952-1-pbonzini@redhat.com/

Paolo

