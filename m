Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1E04E795D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 17:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376524AbiCYQzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 12:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241225AbiCYQzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:55:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F66A37A0D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648227213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rn001TI2+ev3rjEVO1qe7SoRJL2l7+xuOCYmZgKJjK0=;
        b=LXek2/70F3XELFhVE1TAI2UBoGthTXqeNuPU5RyZpLwJ/19carEb/g1DDuoy0OFR06N2Ii
        ixF6k0A0VIur7Qg6rh0tg5GojulOvGdOhL3aZi5Sr52/YV6s4c2K2qPD/yfvthN+yo6mJF
        HaCPYOZkrUpxBhJJ1ZraOmJsQfZY25o=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-182-Cu_Fo8wQMLy6WtRjZHxdGA-1; Fri, 25 Mar 2022 12:53:32 -0400
X-MC-Unique: Cu_Fo8wQMLy6WtRjZHxdGA-1
Received: by mail-ed1-f72.google.com with SMTP id s9-20020a50d489000000b00418d556edbdso5271014edi.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Rn001TI2+ev3rjEVO1qe7SoRJL2l7+xuOCYmZgKJjK0=;
        b=EbXhLPZF15Ssw3YPOlSQO6PVq3fDDGK8Aw3aW1vznrzxIskX3aWVGa0XtL2cwrsMi/
         k4KoFC1PxD6jopG2EA1YIkhkMcr0p4C2LIBTRaF0j5FQhkqMh7T4nwwomxLN9/SS8vTA
         DcgJt0xHiqTz1bCaD4gSpO9cizSBEJyGz2A/qf4RR5uQ3thGC+nsjb81M5Y/ReHrzCQw
         +jLiWXEB05hu2wU2oHkPCm9gOR42r75nUUsHPbb3woaA2m8uBGDc9wyu72SVI5wNMpWM
         n8/vcDs/fVkCTWlefBGdQaQ0NJrQ2YLaha+L+uDfNXX1OC9IrVDFYUarx8c5uPaNi1On
         ykhw==
X-Gm-Message-State: AOAM531BaHkaoKQ1qfBX5v0mm06dkb17P1P2EGIrY0ngNieerBwIamCe
        ccbrGGIJGVsK45kLZbHliSnxx7n+a6ONRD7blYdAqCH0lGtNf1G3xoADqzqhXG2tLWbODE5DYRH
        2tlqgSfHAJ9v73nY9XCvy0gfh
X-Received: by 2002:a17:906:2646:b0:6d5:d889:c92b with SMTP id i6-20020a170906264600b006d5d889c92bmr12991677ejc.696.1648227211228;
        Fri, 25 Mar 2022 09:53:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzapKU8f2he+ofcyryhegTHBFNGgHx51LCluIK5c6uYkYMRuFnEOqVukQXj7BcKBky+vzWfsQ==
X-Received: by 2002:a17:906:2646:b0:6d5:d889:c92b with SMTP id i6-20020a170906264600b006d5d889c92bmr12991651ejc.696.1648227211033;
        Fri, 25 Mar 2022 09:53:31 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id a18-20020a170906671200b006e05929e66csm2511374ejp.20.2022.03.25.09.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 09:53:30 -0700 (PDT)
Message-ID: <632d3601-ecf4-12f3-4f3b-408c35f028f6@redhat.com>
Date:   Fri, 25 Mar 2022 17:53:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] Add KVM_EXIT_SHUTDOWN metadata for SEV-ES
Content-Language: en-US
To:     Peter Gonda <pgonda@google.com>
Cc:     kvm list <kvm@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Marc Orr <marcorr@google.com>,
        Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220325152758.335626-1-pgonda@google.com>
 <d0366a14-6492-d2b9-215e-2ee310d9f8ae@redhat.com>
 <CAMkAt6rACYqFXA_6pa9JUnx0=3vyM6PeaNkq-Yih4KM6saf6PQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CAMkAt6rACYqFXA_6pa9JUnx0=3vyM6PeaNkq-Yih4KM6saf6PQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/22 16:31, Peter Gonda wrote:
> On Fri, Mar 25, 2022 at 9:29 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 3/25/22 16:27, Peter Gonda wrote:
>>> SEV-ES guests can request termination using the GHCB's MSR protocol. See
>>> AMD's GHCB spec section '4.1.13 Termination Request'. Currently when a
>>> guest does this the userspace VMM sees an KVM_EXIT_UNKNOWN (-EVINAL)
>>> return code from KVM_RUN. By adding a KVM_EXIT_SHUTDOWN_ENTRY to kvm_run
>>> struct the userspace VMM can clear see the guest has requested a SEV-ES
>>> termination including the termination reason code set and reason code.
>>>
>>> Signed-off-by: Peter Gonda <pgonda@google.com>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Cc: Borislav Petkov <bp@alien8.de>
>>> Cc: Tom Lendacky <thomas.lendacky@amd.com>
>>> Cc: Brijesh Singh <brijesh.singh@amd.com>
>>> Cc: Joerg Roedel <jroedel@suse.de>
>>> Cc: Marc Orr <marcorr@google.com>
>>> Cc: Sean Christopherson <seanjc@google.com>
>>> Cc: kvm@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>
>> This is missing an update to Documentation/.
>>
> 
> My mistake. I'll send another revision. Is the behavior of
> KVM_CAP_EXIT_SHUTDOWN_REASON OK? Or should we only return 1 for SEV-ES
> guests?

No, you can return 1 unconditionally, but you should also set reason and 
clear ndata in the other cases that return KVM_EXIT_SHUTDOWN.

Paolo

