Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920904D11DC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344803AbiCHIOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344390AbiCHIOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:14:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BFF53BBD7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 00:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646727220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vo5Lpx3jhLk8XX96vRv3ILFXkCDbfnvle5Ey5/KCjRw=;
        b=QIR/Bj6HFbSi5wL0FNTea5LnFhfUvJweag2bHmXjMPsvJGfb/x2jkh2fkOwFF5qHHnqlwN
        KG1MSCJ+nB9+9UwyNV7zlwLbNepFM52268kMIbfObFUi4ANErkJcLuRM/EL0CnSTW4AxRm
        kHw4eG8zKan6XqJcrFRNPWbeLCiRGdk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-g_4EX6fxMyS9uqZ0JEOtpA-1; Tue, 08 Mar 2022 03:13:38 -0500
X-MC-Unique: g_4EX6fxMyS9uqZ0JEOtpA-1
Received: by mail-ej1-f69.google.com with SMTP id k16-20020a17090632d000b006ae1cdb0f07so8260938ejk.16
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 00:13:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Vo5Lpx3jhLk8XX96vRv3ILFXkCDbfnvle5Ey5/KCjRw=;
        b=oNWwuM7QT+MblpBbtgFQ7vUXCqD3FORxZYV0XPl92lFviCuwdcfE/1KSkV6cJvvjc5
         Aox09DiVKi08Cvlbg+bGem2ajqU9actFzSQZMNa1yVmnyXi9lyGFXnMai4ZhmIg5SEF+
         Flfn7t7E0WPzV/yER5LCBiWCz2jLh/mKIleVvAV/InIvwb1KVr2kN/dA8RQS/xcBowg5
         fj2RVUCk60rGL1KyIZmY6rKY/CCSw8SsC+KpO4W4YjhCqWQrepyx543/V/F44jEYvtO0
         NptaMm+tXY5ChPO46303fzeUVwEYA5yfCfr+dJKmt1K1Uh3AQ9lClHz8c5fM+LwdnCFQ
         4pdQ==
X-Gm-Message-State: AOAM533QuDYXFV9K8GQiEBA991o5TNwhJdteQoUmP/PxB2MWs9suUsQU
        bGyaGOgegWN6TKecFeyOcOXUeGmhw0ayUk04nZfoyevqfbG9Hnjy7/TKZW3l/Gc5Oqs3UAJ2cVJ
        4phphWBxD2xI/TTdOLs7FXBkM
X-Received: by 2002:a17:906:b1da:b0:6d6:dd9a:3a9b with SMTP id bv26-20020a170906b1da00b006d6dd9a3a9bmr12184309ejb.766.1646727216613;
        Tue, 08 Mar 2022 00:13:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwOdQ+BohdQua/sHBPJ2tnTmtj+3a1NGelClPL4W5LFDCZ3aUUnjuGf+CRHhRg8ebjHW7FsPw==
X-Received: by 2002:a17:906:b1da:b0:6d6:dd9a:3a9b with SMTP id bv26-20020a170906b1da00b006d6dd9a3a9bmr12184295ejb.766.1646727216358;
        Tue, 08 Mar 2022 00:13:36 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id u5-20020a170906780500b006d0b99162casm5562848ejm.114.2022.03.08.00.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 00:13:35 -0800 (PST)
Message-ID: <5cb1e32e-c880-fa48-aa25-7660d8ad0cdd@redhat.com>
Date:   Tue, 8 Mar 2022 09:13:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] kvm: x86: Improve virtual machine startup performance
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Hao Peng <flyingpenghao@gmail.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220301063756.16817-1-flyingpeng@tencent.com>
 <Yh5d7XBD9D4FhEe3@google.com>
 <CAPm50a+p2pSjExDwPmGpZ_aTuxs=x6RZ4-AAD19RDQx2o-=NCw@mail.gmail.com>
 <YiAZ3wTICeLTVnJz@google.com>
 <CAPm50aLJ51mm9JVpTMQCkNENX_9-Do5UeH5zxu-5byOcOFsJBg@mail.gmail.com>
 <Yia5hsoq2ZZJM8gx@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Yia5hsoq2ZZJM8gx@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/22 03:03, Sean Christopherson wrote:
> On Thu, Mar 03, 2022, Hao Peng wrote:
>> On Thu, Mar 3, 2022 at 9:29 AM Sean Christopherson <seanjc@google.com> wrote:
>>>
>>> On Wed, Mar 02, 2022, Hao Peng wrote:
>>>> Thanks for pointing this out. However, other than shadow_root_level,
>>>> other fields of context will not
>>>> change during the entire operation, such as
>>>> page_fault/sync_page/direct_map and so on under
>>>> the condition of tdp_mmu.
>>>> Is this patch still viable after careful confirmation of the fields
>>>> that won't be modified?
>>>
>>> No, passing around the "init" flag is a hack.
>>>
>>> But, we can achieve what you want simply by initializing the constant data once
>>> per vCPU.  There's a _lot_ of state that is constant for a given MMU now that KVM
>>> uses separate MMUs for L1 vs. L2 when TDP is enabled.  I should get patches posted
>>> tomorrow, just need to test (famous last words).
> 
> Famous last words indeed.  Long story short, the patches were mostly easy, but I
> wandered deep into a rabbit hole when trying to make ->inject_page_fault() constant
> per MMU.  I'll get something posted this week, though exactly what that something is
> remains to be seen :-)

This is exactly what I have posted a few weeks ago:

https://patchew.org/linux/20220221162243.683208-1-pbonzini@redhat.com/

See in particular

   KVM: nVMX/nSVM: do not monkey-patch inject_page_fault callback
   KVM: x86/mmu: initialize constant-value fields just once

Paolo

