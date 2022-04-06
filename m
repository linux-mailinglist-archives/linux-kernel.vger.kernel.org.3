Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A224A4F606E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbiDFNvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbiDFNvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:51:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D2B7D59BC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 04:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649244365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=clK4mQhSKxURoMrRIrMnAnalT08fuiMGN0eGeD3I/lY=;
        b=YZSOPJBByx4IAOm8bAOITjwKkVE+h4ryWxB7HZQovZueDUQ0G+XZQm1xzPC47thp94HTpV
        kors3Q+K185WcNOf3HMuLT/dgQPAZ0VwW0a/fjRkYVVjD/p/UbhpiVcwt1MiZJSALgjo68
        dR1lgsoRGPLfCj95U4qGYNyc/hwku3k=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520-y7EyUPy8NFWq30-3pZuXPw-1; Wed, 06 Apr 2022 07:26:04 -0400
X-MC-Unique: y7EyUPy8NFWq30-3pZuXPw-1
Received: by mail-ed1-f71.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso1036280edt.20
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 04:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=clK4mQhSKxURoMrRIrMnAnalT08fuiMGN0eGeD3I/lY=;
        b=kMevSrWgqcli0jAlWKg5SqlquS3Yy03rU+LCkl+mGI1d5fT7/6+EqgoQDdR1wj72l7
         kMlpIOSTscFqlGP2t3Vi3B6VaK4eRqJVBDJFoJCdj6hAp3Kth3FKf5ZQuEux9tMvZbWp
         LKs5aXJ7LVxWI+kAUoy7YaYa5M5iWAZIKS/Gk98v7AgWLMepNiYtysn51FEzkGGKxICX
         6tFt/Q1Er0jq1MDm510MybrvqEddpJ6gZeAGfgdbRsPwUC8bbfHJtgm0nrDiOMTUCA+0
         311tDI+e1IBi8Itp4zY6TUa01NPh7IiJMdU1iIQGRUitsJ1+h0EaAVjvLqskNT4UyhQ+
         TXZQ==
X-Gm-Message-State: AOAM5332ydZwbzTPvM56W330UHL/7SMr7SMmiR+PfTt87X9LpaPcYfsV
        PqTPEKvfPwNWUxiflVskqBkRIu7fnWGgcqvicTxM7LecU76PMPYpM3frYDtJraT5phS6wljZQOV
        jPVBxCwdWpSM5uM+HKovd9iZJ
X-Received: by 2002:a17:907:eaa:b0:6e8:2f3:45f9 with SMTP id ho42-20020a1709070eaa00b006e802f345f9mr8050128ejc.323.1649244363397;
        Wed, 06 Apr 2022 04:26:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwR7GzG0hS7kBevOXm+ERUBNeUao9+p0S9glggxmPxAvVTf3S4VH6qrS14gYIvTbRpsyWqEHA==
X-Received: by 2002:a17:907:eaa:b0:6e8:2f3:45f9 with SMTP id ho42-20020a1709070eaa00b006e802f345f9mr8050115ejc.323.1649244363157;
        Wed, 06 Apr 2022 04:26:03 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id cn27-20020a0564020cbb00b00418b0c7fbbfsm7634266edb.32.2022.04.06.04.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 04:26:02 -0700 (PDT)
Message-ID: <b69fa64d-9d84-d0ce-146e-09412e8f7862@redhat.com>
Date:   Wed, 6 Apr 2022 13:26:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v5 033/104] KVM: x86: Add infrastructure for stolen
 GPA bits
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>, isaku.yamahata@intel.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@gmail.com, Jim Mattson <jmattson@google.com>,
        erdemaktas@google.com, Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>
References: <cover.1646422845.git.isaku.yamahata@intel.com>
 <a21c1f9065cf27db54820b2b504db4e507835584.1646422845.git.isaku.yamahata@intel.com>
 <2b8038c17b85658a054191b362840240bd66e46b.camel@intel.com>
 <5443b630-d2c8-b0c3-14f5-2b6b3f71221c@redhat.com>
 <f9cd6947441e43cc27a6b21a089da61bb7fed9b0.camel@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <f9cd6947441e43cc27a6b21a089da61bb7fed9b0.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/22 04:23, Kai Huang wrote:
>>
>>>>
>>>>   
>>>> -		gfn = gpte_to_gfn(gpte);
>>>> +		gfn = gpte_to_gfn(vcpu, gpte);
>>>>   		pte_access = sp->role.access;
>>>>   		pte_access &= FNAME(gpte_access)(gpte);
>>>>   		FNAME(protect_clean_gpte)(vcpu->arch.mmu, &pte_access, gpte);
>>>
>>> In commit message you mentioned "Don't support stolen bits for shadow EPT" (you
>>> actually mean shadow MMU I suppose), yet there's bunch of code change to shadow
>>> MMU.
>>
>> It's a bit ugly, but it's uglier to keep two versions of gpte_to_gfn.
> 
> gpte_to_gfn() is only used in paging_tmpl.h.  Could you elaborate why we need to
> keep two versions of it?

You're right.  Yeah, considering page table walks are not supported when 
private memory is available, it shouldn't be necessary to change 
paging_tmpl.h.

Paolo

