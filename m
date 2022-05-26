Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16044534C8E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 11:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346866AbiEZJde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 05:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbiEZJd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 05:33:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0417C8BDD
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 02:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653557607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=442/sEhT/KjozGhioXB11LvxDiU/RtvP7q/byJd9TZ0=;
        b=h6jpBhuHdWPXM7l53ZtMAUqU2dYuGiXQ0ZN6crlshzRNpTD5BiF3LUrQF6VGK3t0R0kPAM
        I+E+8PFGrpNsfLmhYoZEAutiLt8dVH1PXzVYeStGd8I0PRjDoVjB5VZpThLu24zBOBze9C
        2Kydda/qBh8K4qW2N8ooBvcIu30OIdE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-s4KE7ksuNOyzkWwSx5kOpg-1; Thu, 26 May 2022 05:33:26 -0400
X-MC-Unique: s4KE7ksuNOyzkWwSx5kOpg-1
Received: by mail-ed1-f70.google.com with SMTP id bm4-20020a0564020b0400b0042be0b4ba34so196990edb.20
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 02:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=442/sEhT/KjozGhioXB11LvxDiU/RtvP7q/byJd9TZ0=;
        b=uOv0LQhEK6A2ftIjS90Ppb7GQcc+lFvaq0G5Gv6y9IHZYenS2D7HJ02kmBj45g4DhP
         RXZFR+NqTZkaZRq/Ri9JFsZ1sI60IGGltaf4PsZTo8HLYvIEI1IduyqAefRDe9lrHYXZ
         65Ysw5McZ7+uDL5aqsT0oZjQujVKNdUTFupZS0V5oxTtXYoag/af+NK7c6zLGneKWrfQ
         U15BoZZGG5hiM1eXau01GLUpHGPY6YZsmOjjUAL8gUTdGhYF3tv4gmDbAvMXu4NnE4td
         LOrAn7sjMPsdilyBBFIvx+ArF/ujWl0KD2UlWYlZwmMg3XLZZuKPGifivauz2cxbpaWH
         B5Bw==
X-Gm-Message-State: AOAM533//fGbQfq7E/x94sqaa0RMWXvmgFUgWjHPgF4Fpn7FYHQmoRzf
        soCJnT5KBcD1Uj3ejelq1MwblFsR8rj9gkRXwv8hwVo6G4P+Dg9TfXcsDyZPQaP6fIxcKCZ7/WA
        0rQKY02Np9PIKqz0NPp9MQxTS
X-Received: by 2002:a05:6402:d0e:b0:413:3d99:f2d6 with SMTP id eb14-20020a0564020d0e00b004133d99f2d6mr38958423edb.189.1653557604946;
        Thu, 26 May 2022 02:33:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqSsXCi6PxT14nsvsTlFKkySb/GyEUKsXpWJ0h2IKEYKZVM1vn3NIGt4AaqLGQPGODtkNUbQ==
X-Received: by 2002:a05:6402:d0e:b0:413:3d99:f2d6 with SMTP id eb14-20020a0564020d0e00b004133d99f2d6mr38958392edb.189.1653557604732;
        Thu, 26 May 2022 02:33:24 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id eb21-20020a170907281500b006fecf23fecdsm346256ejc.127.2022.05.26.02.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 02:33:23 -0700 (PDT)
Message-ID: <70cec00b-428f-9310-96b6-c6257fe36dec@redhat.com>
Date:   Thu, 26 May 2022 11:33:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        David Matlack <dmatlack@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Avi Kivity <avi@redhat.com>, kvm list <kvm@vger.kernel.org>
References: <20220415103414.86555-1-jiangshanlai@gmail.com>
 <YoK3zEVj+DuIBEs7@google.com>
 <CALzav=c_WfJ0hvHUFHkLH-+zrDXZSCzKsGHP6kPYd77adwHkUQ@mail.gmail.com>
 <CAJhGHyBtVwZ9G+Mv8FMwC4Uku_gK4-Ng7+x+FqykZLftANm0Yg@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] kvm: x86/svm/nested: Cache PDPTEs for nested NPT in PAE
 paging mode
In-Reply-To: <CAJhGHyBtVwZ9G+Mv8FMwC4Uku_gK4-Ng7+x+FqykZLftANm0Yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/22 10:38, Lai Jiangshan wrote:
>> (Although the APM does say that "modern processors" do not pre-load
>> PDPTEs.)

This changed between the Oct 2020 and Nov 2021, so I suppose the change 
was done in Zen 3.

> Oh, I also missed the fact that L1 is the host when emulating it.
> 
> The code is for host-mode (L1)'s nested_cr3 which is using the
> traditional PAE PDPTEs loading and checking.
> 
> So using caches is the only correct way, right?

The caching behavior for NPT PDPTEs does not matter too much.  What 
matters is that a PDPTE with reserved bits should cause a #NPF at usage 
time rather than a VMentry failure or a #NPF immediately after VMentry.

Paolo

