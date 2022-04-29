Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8474D514E45
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 16:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377972AbiD2Oxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 10:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377264AbiD2Ox2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 10:53:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8496962BCE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651243807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R/HIMZ6Oktz/QstIS528YwovKn42Z3tRqotPYo1Io2Q=;
        b=WLl1K1Bq5tgPHDoWsow9CdZUHVS6cHAkn7FhdMYj9gSH9tJNi4iSZFIv82y0KvDOAypufo
        mckefnEP99BR0fBkodWca5/hwxVo+0XHbeCjAhJFmS6e7T922Nh9jA4KRbPIdkMSrQ10V8
        eAfK/t/ymw+roLL3k0+QSFNCPI5Gn8s=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-379-M3X3tszMNCy_qS1ggAoF8g-1; Fri, 29 Apr 2022 10:50:05 -0400
X-MC-Unique: M3X3tszMNCy_qS1ggAoF8g-1
Received: by mail-ej1-f71.google.com with SMTP id qa34-20020a17090786a200b006f3de9cc704so2816437ejc.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R/HIMZ6Oktz/QstIS528YwovKn42Z3tRqotPYo1Io2Q=;
        b=wRoBKzRzUdH35/6Na7flyzTa9wJ40afoN/h/zUYZsySykAQmN4krGZiHv6FRgnJxzH
         3oyFgSv8EyCkPYixq/Thz80jmKByB1BkvkTBROgyHgy10lLahoFrXzB9c3TkEtnuFSFf
         yEZM2LzvR68P6hGhXc63q3ds3MHM7YfxoqML9eeC7Knw0LUb+x05qdIVo4UuQ7pCXTmM
         +wbf0t3+zOcHzuUA4eG8AWQrgjex73SBtACTETUaAKccIlmWRBoWG7RZkDN/QgHsNEaV
         GTHXvLXpiQOqNQt708eR9Odi4DlRbSYUVdo8X+S1BXMPsrzj2wtDWTYUUEY3SFLoAcBF
         XdTQ==
X-Gm-Message-State: AOAM532uSMJZR0+18HvP3QUL8ktUc9DBaBxtctJYpsWbth4dvTmDajra
        mPqyz7IEaG7GLFuxG9qjMe7I53nEhuQy3dKxuQnOvr9zlaGLlPZnKwmT+EhohnhG0PQYPgP6D9Q
        jOu5DqyOReLBO6eEXj+uaLOZb
X-Received: by 2002:a17:906:2883:b0:6e8:7012:4185 with SMTP id o3-20020a170906288300b006e870124185mr36210391ejd.204.1651243803839;
        Fri, 29 Apr 2022 07:50:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZFcDdJ777PCagHlCFXYEjaFKGxJWoHjheaHR1/IWKZ2cPqT1U3WomCL06afEk7K1d/aYIHw==
X-Received: by 2002:a17:906:2883:b0:6e8:7012:4185 with SMTP id o3-20020a170906288300b006e870124185mr36210371ejd.204.1651243803634;
        Fri, 29 Apr 2022 07:50:03 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id qz24-20020a170907681800b006f3ef214de0sm706876ejc.70.2022.04.29.07.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 07:50:03 -0700 (PDT)
Message-ID: <e5864cb4-cce8-bd32-04b0-ecb60c058d0b@redhat.com>
Date:   Fri, 29 Apr 2022 16:50:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] KVM: x86/mmu: Do not create SPTEs for GFNs that exceed
 host.MAXPHYADDR
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>,
        Ben Gardon <bgardon@google.com>,
        David Matlack <dmatlack@google.com>
References: <20220428233416.2446833-1-seanjc@google.com>
 <337332ca-835c-087c-c99b-92c35ea8dcd3@redhat.com>
 <Ymv1I5ixX1+k8Nst@google.com>
 <20e1e7b1-ece7-e9e7-9085-999f7a916ac2@redhat.com>
 <Ymv5TR76RNvFBQhz@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Ymv5TR76RNvFBQhz@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/22 16:42, Sean Christopherson wrote:
> On Fri, Apr 29, 2022, Paolo Bonzini wrote:
>> On 4/29/22 16:24, Sean Christopherson wrote:
>>> I don't love the divergent memslot behavior, but it's technically correct, so I
>>> can't really argue.  Do we want to "officially" document the memslot behavior?
>>>
>>
>> I don't know what you mean by officially document,
> 
> Something in kvm/api.rst under KVM_SET_USER_MEMORY_REGION.

Not sure if the API documentation is the best place because userspace 
does not know whether shadow paging is on (except indirectly through 
other capabilities, perhaps)?

It could even be programmatic, such as returning 52 for 
CPUID[0x80000008].  A nested KVM on L1 would not be able to use the 
#PF(RSVD) trick to detect MMIO faults.  That's not a big price to pay, 
however I'm not sure it's a good idea in general...

Paolo

> 
>> but at least I have relied on it to test KVM's MAXPHYADDR=52 cases before
>> such hardware existed.  :)
> 
> Ah, that's a very good reason to support this for shadow paging.  Maybe throw
> something about testing in the changelog?  Without considering the testing angle,
> it looks like KVM supports max=52 for !TDP just because it can, because practically
> speaking there's unlikely to be a use case for exposing that much memory to a
> guest when using shadow paging.
> 

