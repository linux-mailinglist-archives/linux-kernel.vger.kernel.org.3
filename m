Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4457A5748C3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbiGNJ0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238237AbiGNJZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:25:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F37C95F7A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657790664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AAfRoyLsPfv15JpoNJzCUez3RnyFpKTG8pry8dsjYgY=;
        b=fN3n15NIM/uEJc3f1Ic07kE1nRlUICAbn6Boe4o6FOlm/7Ogi46ab35bF0LUu0Yq+V/crL
        5H9GBuahADgt/WJLj/1j8Q71MasSCcQD6m2qQ8lCpumP1u2UTyXjR3TULsa4qjbaOeBm6E
        YDASVxjta1Mx5licVpO/XKSteuI9K0A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567-lmO8ozbbMoKb0uYrODzoZA-1; Thu, 14 Jul 2022 05:24:23 -0400
X-MC-Unique: lmO8ozbbMoKb0uYrODzoZA-1
Received: by mail-wm1-f72.google.com with SMTP id t25-20020a7bc3d9000000b003a2ea772bd2so508761wmj.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=AAfRoyLsPfv15JpoNJzCUez3RnyFpKTG8pry8dsjYgY=;
        b=aYjwUuGfe3SHMWXn1UR3in0linLiY/JwknmNOhdkjm684uj19uPo1YEpyzRUV/qzMF
         QamJ6Tk+WPNaievvUySf9PriWmqw65wTdNFU3khHcNZv4SNby5nlxwMnbq2XT3xVdraj
         LekWH+ySwTo58aZ5cZ6ekE5Z23T+Ul5Ug6nqL8Zof3RWHF/I/OBgT/AnVkhJKu4zkEyQ
         9uaudXqSMn/qUUoLGuE58EgRRUn6l8Gt9MYiWeELiq/KXigg+whr4IcTTkfG5yhItexn
         ct9268agxNBB67bat7WQ4LDq+cTr8n1aFgomsqoWaDdebihVEIhm4FGYVYCgDx3zc0bM
         tl0g==
X-Gm-Message-State: AJIora/1qMB1z/6GI/iMlwAC7XCnyq1GaFIjo1anDXZbRfyTJdfNPOKf
        E5YrFXUUXVA2tIEmfi+CfijULV37zuX8ozWcrAtAdjO+lyF2OkTt6g5PLQZ8RIeQzaIuKwDJjOh
        UUc5t6GCOf5pJFttNHy+B89nm
X-Received: by 2002:a05:600c:1f16:b0:3a1:9cd3:856f with SMTP id bd22-20020a05600c1f1600b003a19cd3856fmr7774688wmb.55.1657790662264;
        Thu, 14 Jul 2022 02:24:22 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tZitMXzBSYaX1KnlvXZvZRjClLz1V3XvaqomxfS7Lm++YzJhsy0XaLdXT7Zua/NXXMP4lRlQ==
X-Received: by 2002:a05:600c:1f16:b0:3a1:9cd3:856f with SMTP id bd22-20020a05600c1f1600b003a19cd3856fmr7774673wmb.55.1657790662058;
        Thu, 14 Jul 2022 02:24:22 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id e9-20020a05600c4e4900b0039c811077d3sm1298363wmq.22.2022.07.14.02.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 02:24:21 -0700 (PDT)
Message-ID: <00c0442718a4f07c2f0ad9524cc5b13e59693c68.camel@redhat.com>
Subject: Re: [PATCH 0/3] KVM: x86: Hyper-V invariant TSC control feature
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Date:   Thu, 14 Jul 2022 12:24:19 +0300
In-Reply-To: <20220713150532.1012466-1-vkuznets@redhat.com>
References: <20220713150532.1012466-1-vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-07-13 at 17:05 +0200, Vitaly Kuznetsov wrote:
> Normally, genuine Hyper-V doesn't expose architectural invariant TSC
> (CPUID.80000007H:EDX[8]) to its guests by default. A special PV MSR
> (HV_X64_MSR_TSC_INVARIANT_CONTROL, 0x40000118) and corresponding CPUID
> feature bit (CPUID.0x40000003.EAX[15]) were introduced. When bit 0 of the
> PV MSR is set, invariant TSC bit starts to show up in CPUID. When the 
> feature is exposed to Hyper-V guests, reenlightenment becomes unneeded.

If I understood the feature correctly from the code, it allows the HyperV, or in this
case KVM acting as HyperV, to avoid unconditionally exposing the invltsc bit
in CPUID, but rather let the guest know that it can opt-in into this,
by giving the guest another CPUID bit to indicate this ability
and a MSR which the guest uses to opt-in.

Are there known use cases of this, are there guests which won't opt-in?

> 
> Note: strictly speaking, KVM doesn't have to have the feature as exposing
> raw invariant TSC bit (CPUID.80000007H:EDX[8]) also seems to work for
> modern Windows versions. The feature is, however, tiny and straitforward
> and gives additional flexibility so why not.

This means that KVM can also just unconditionally expose the invtsc bit
to the guest, and the guest still uses it.


Nitpick: It might be worth it to document it a bit better somewhere,
as I tried to do in this mail.


Best regards,
	Maxim Levitsky

> 
> Vitaly Kuznetsov (3):
>   KVM: x86: Hyper-V invariant TSC control
>   KVM: selftests: Fix wrmsr_safe()
>   KVM: selftests: Test Hyper-V invariant TSC control
> 
>  arch/x86/include/asm/kvm_host.h               |  1 +
>  arch/x86/kvm/cpuid.c                          |  7 ++
>  arch/x86/kvm/hyperv.c                         | 19 +++++
>  arch/x86/kvm/hyperv.h                         | 15 ++++
>  arch/x86/kvm/x86.c                            |  4 +-
>  .../selftests/kvm/include/x86_64/processor.h  |  2 +-
>  .../selftests/kvm/x86_64/hyperv_features.c    | 73 ++++++++++++++++++-
>  7 files changed, 115 insertions(+), 6 deletions(-)
> 


