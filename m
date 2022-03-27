Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402894E8747
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 12:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiC0Kms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 06:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbiC0Kmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 06:42:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8113B1A389
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 03:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648377666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1mFTcX2t9p3wv/uCdWkqMzj2ugqVepjYfseDXDJCz6Q=;
        b=fD6DWWyS0GrjR47VNO3xunhsB+HEmcdvndl2xCpyQvWLpzCmlfYfhw1Cxn8gcQp9peR9SH
        hQQtT+vEXV7svQ+rZl/zTCzaW/YLKtnU00qQpKy1yblBgdUFYL67eEfKL/M1K6A15dIUQN
        7iTQUQG1xNVf60Xv4TbwJ78OAeF1LAE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-AF3y0RqQNeqlY3fUfc6sAw-1; Sun, 27 Mar 2022 06:41:04 -0400
X-MC-Unique: AF3y0RqQNeqlY3fUfc6sAw-1
Received: by mail-ed1-f71.google.com with SMTP id c31-20020a509fa2000000b004190d43d28fso7426023edf.9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 03:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1mFTcX2t9p3wv/uCdWkqMzj2ugqVepjYfseDXDJCz6Q=;
        b=e6w3e+ieaLG2Vs54xkHOaTvIgN84T9OqoNpfucKv34557WWlwSXaA+2hXbSsC9rhqI
         rY404cuReIwDHtrqKWp7fS4rfMLuBI9LqV+gU6/nWGpdI0HRmB44kuW7pBzwOZYJbWYm
         FZ/w3/1SGqUzKnTopI66F1pPcs3w99fpFaAbe8/AweoY//o6aoE63ZCSGsMsvv0TgAr4
         rAI7vgVmz4SLlNWaJiLAfpsmXJfFSIpGw4y1URgPGKFx9q/z5KI+NxC4BMKQ3NtpvXgP
         fIHV9VNx4+5BEJ1XH1Y1c+DRN9brwv6iEe3/x/aPPyv1jP0atPYztaqLrkg31dFXFtlW
         7wYQ==
X-Gm-Message-State: AOAM5316h1IAyr7vz44cov+cON0mM7NI3M5LvbZk758wL9+pkrx5Zn0q
        4rGpsVuco5Te+rCk3oBDESiBOE8ak5cdO/k4koVGDUTwPU4RkMum0uVcHgEWiHSCfVW5NIevzcH
        IQ2pE1YUSbWUjrz/MtjraLWHr
X-Received: by 2002:a17:906:17db:b0:6da:f8d8:ab53 with SMTP id u27-20020a17090617db00b006daf8d8ab53mr21089984eje.274.1648377663439;
        Sun, 27 Mar 2022 03:41:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytaQvKY2CY47C0QVZPuli4dV3wY/7Vyq9dDldBV4fgLQZcD0AOfYQcDpZA6+PHM7wg3h7irw==
X-Received: by 2002:a17:906:17db:b0:6da:f8d8:ab53 with SMTP id u27-20020a17090617db00b006daf8d8ab53mr21089962eje.274.1648377663200;
        Sun, 27 Mar 2022 03:41:03 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:8ca6:a836:a237:fed1? ([2001:b07:6468:f312:8ca6:a836:a237:fed1])
        by smtp.googlemail.com with ESMTPSA id v26-20020a50955a000000b00418ebdb07ddsm5606052eda.56.2022.03.27.03.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 03:41:02 -0700 (PDT)
Message-ID: <b754fa0a-4f9e-1ea5-6c77-f2410b7f8456@redhat.com>
Date:   Sun, 27 Mar 2022 12:40:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] KVM: x86/mmu: Speed up slot_rmap_walk_next for sparsely
 populated rmaps
Content-Language: en-US
To:     Vipin Sharma <vipinsh@google.com>,
        David Matlack <dmatlack@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220325233125.413634-1-vipinsh@google.com>
 <CALzav=e6W2VSp=btmqTpQJ=3bH+Bw3D8sLApkTTvMMKAnw_LAw@mail.gmail.com>
 <CAHVum0dOfJ5HuscNq0tA6BnUJK34v4CPCTkD4piHc7FObZOsng@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CAHVum0dOfJ5HuscNq0tA6BnUJK34v4CPCTkD4piHc7FObZOsng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/22 01:31, Vipin Sharma wrote:
>>> -static void slot_rmap_walk_next(struct slot_rmap_walk_iterator *iterator)
>>> +static noinline void
>>
>> What is the reason to add noinline?
> 
> My understanding is that since this method is called from
> __always_inline methods, noinline will avoid gcc inlining the
> slot_rmap_walk_next in those functions and generate smaller code.
> 

Iterators are written in such a way that it's way more beneficial to 
inline them.  After inlining, compilers replace the aggregates (in this 
case, struct slot_rmap_walk_iterator) with one variable per field and 
that in turn enables a lot of optimizations, so the iterators should 
actually be always_inline if anything.

For the same reason I'd guess the effect on the generated code should be 
small (next time please include the output of "size mmu.o"), but should 
still be there.  I'll do a quick check of the generated code and apply 
the patch.

Paolo

