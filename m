Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A052A597318
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236380AbiHQPdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 11:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240393AbiHQPdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 11:33:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8709B65CA
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 08:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660750400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iuF9WwZZgfyEZm95G/FWguHp30Ml1XgQgRW5a9g0ZoM=;
        b=iG7rbaioYPsy3R3OxJKHuprtGDBq0jdrYkYzNiNSNmQ6yR3IH2l4lpEiWUaj60p8XJngEh
        WHAM9maKoP+1ErVAd9arvcuT9+CEzpmlB77bMfdzuOEfpIKJcASnAXYHwW0s35xhnE9udk
        4y9k1tKqkxyvFi3N+WdQA0We9nVslBk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-300-e87EY1dUMzKKPkuW5pG19A-1; Wed, 17 Aug 2022 11:33:18 -0400
X-MC-Unique: e87EY1dUMzKKPkuW5pG19A-1
Received: by mail-ed1-f71.google.com with SMTP id y14-20020a056402440e00b0044301c7ccd9so8950376eda.19
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 08:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=iuF9WwZZgfyEZm95G/FWguHp30Ml1XgQgRW5a9g0ZoM=;
        b=WJ0S4yooEx6+z7fB1x4H5ObUqbna8ELnWqTnGZ2oxaK4pzLj2tMfYAxk02XURCQlRu
         dPrYuENKWmKzU1aplJ1lk9vScnavPJ1wYQiZFI+Zun7KY0NB7aXWHyt0yLghBKDdBPbx
         5m395HshwwroZQUe5VdS5itlj9yBgi44pCWj3VALDxiZ1GIQHzzRydXrt2EGxrZJdVvT
         YWeO1TCi+Xet86SvPN+lhJSYBb8oroHmKeSiJhjubESnYBjU6p5KUgqRepPEhphaHtKr
         AreRrNb9ymNfBGh1g2QZ3cLrXlgCQ+OWbeD1jVsi9qFGwu3GFI9MYwMsbxwQwq4CKm2U
         FykA==
X-Gm-Message-State: ACgBeo1JDQVN/zKknORdKNCG5wLcMhgV9BfFWLNfiYqi7YTgNYOO/GDO
        5I6+7Ua+l6bv2LPd3LNfY4eqTYMBjtxZoc81q07p7RvN/SCtGHvKwIZJh4IOzmyKygIKifRtfgv
        uQRxlzMIZqdKm46a7krOn7aHV
X-Received: by 2002:a05:6402:2384:b0:43c:fb7d:82a1 with SMTP id j4-20020a056402238400b0043cfb7d82a1mr23077310eda.82.1660750397450;
        Wed, 17 Aug 2022 08:33:17 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7aVKqN6utP4Sf93dSgCom2XulCnRuSNi5wYhTmLr8QlpKCywaQKjCxT7d9LxItWJolYFWBRQ==
X-Received: by 2002:a05:6402:2384:b0:43c:fb7d:82a1 with SMTP id j4-20020a056402238400b0043cfb7d82a1mr23077294eda.82.1660750397292;
        Wed, 17 Aug 2022 08:33:17 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id t7-20020a170906948700b0072b32de7794sm6874346ejx.70.2022.08.17.08.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 08:33:16 -0700 (PDT)
Message-ID: <20a1384f-3e05-15a0-1f27-ae7488e5d34f@redhat.com>
Date:   Wed, 17 Aug 2022 17:33:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 8/9] KVM: x86: lapic does not have to process INIT if
 it is blocked
Content-Language: en-US
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com
References: <20220811210605.402337-1-pbonzini@redhat.com>
 <20220811210605.402337-9-pbonzini@redhat.com> <YvwxJzHC5xYnc7CJ@google.com>
 <226aca0a2cc95f57364f330793a2f13446fcf7a0.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <226aca0a2cc95f57364f330793a2f13446fcf7a0.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/22 16:11, Maxim Levitsky wrote:
> 
> While reviwing this, I noticed that we have this code:
> 
> 
> static bool svm_apic_init_signal_blocked(struct kvm_vcpu *vcpu)
> {
>   struct vcpu_svm *svm = to_svm(vcpu);
> 
>   /*
>   * TODO: Last condition latch INIT signals on vCPU when
>   * vCPU is in guest-mode and vmcb12 defines intercept on INIT.
>   * To properly emulate the INIT intercept,
>   * svm_check_nested_events() should call nested_svm_vmexit()
>   * if an INIT signal is pending.
>   */
>   return !gif_set(svm) ||
>   (vmcb_is_intercept(&svm->vmcb->control, INTERCEPT_INIT));
> }
> 
> Is this workaround still needed? svm_check_nested_events does check
> the apic's INIT/SIPI status.
> 
> Currently the '.apic_init_signal_blocked' is called from
> kvm_vcpu_latch_init which itself is currently called from
> kvm_vcpu_latch_init which happens after we would vmexit if INIT is
> intercepted by nested hypervisor.
No, it shouldn't be needed anymore.

Paolo

