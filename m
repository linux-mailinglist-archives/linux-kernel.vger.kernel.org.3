Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4066B57515E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 17:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239939AbiGNPDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 11:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239924AbiGNPC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 11:02:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09032606B4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 08:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657810977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NqsAwSpdF/R7wwQnaO/szXDTM83lVGdVmUrcXsOO7iA=;
        b=GTiINQgM13dl6Edg8RJJXPVOENegGtQqv/w1lpDGQin2I3P3vURX1lCuOZDp/5+naTleIV
        nlklM0pCKak911RrMKtBYNyNwzec9lQLXlsuWmdUrt71lh9wKpeKLtJR0A7RSfqOd0qMBj
        kFSZDtdjAwYUHb7aqwWu2kU4BqGO4Os=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-kXkbuptvNTmGjo7ZsKd8kw-1; Thu, 14 Jul 2022 11:02:55 -0400
X-MC-Unique: kXkbuptvNTmGjo7ZsKd8kw-1
Received: by mail-ej1-f69.google.com with SMTP id nc23-20020a1709071c1700b0072b94109144so861311ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 08:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=NqsAwSpdF/R7wwQnaO/szXDTM83lVGdVmUrcXsOO7iA=;
        b=E71wQfPZ6d9V6/p7fqgUdm7B3VbbHS2/B4ymLjT0sqG+FXRXyQGsXWu5zkNq9c+JmK
         Di6RsT7tfLKKgB6j/gtSKTPjvVX3qTUeT2LyVvvE2kTXgDhX83iK7zQ3gJEo7d6lbAg3
         Rvq3kdDH2JyeL6u7oif0BhlMLCuAeUvL3DomutNtmElLMHlNEqjgWICH7EXlUjfQoeWq
         wvMEd3Og+vbFGZJphoginiwdu6MAOQPUf9W0HC182HmVnWZv38ZPEr/YWikVH1is9ys8
         ikycRp1hTm+gAuM9QZwtlASS0ygJianrhbLTawSHgqKGbvEkQGM5Ck16Llmmn7bgOM4c
         RC8g==
X-Gm-Message-State: AJIora8GIYUKqrTJvfnAxU/IGqB0OMNpRh2R1jfOtS+B4igKFLLy6g4l
        I6Ewyiu8+cQtUj+fONOy8nwB/htZGou1fGFD+fvE+PP79RVWjYOwRCRebCpIW3GGewKhn+hi1Eg
        J0ZtZCiz54AC1z1MGoHHlrrx6
X-Received: by 2002:a17:907:3e07:b0:72e:e1e2:1415 with SMTP id hp7-20020a1709073e0700b0072ee1e21415mr2576992ejc.596.1657810974437;
        Thu, 14 Jul 2022 08:02:54 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1voM4036pGNdZE1gcb3qjiqVEqfZY8qFFV56JNgSHwHf7wwl2ewT8Gg8bBEGhKTBarV4JamiA==
X-Received: by 2002:a17:907:3e07:b0:72e:e1e2:1415 with SMTP id hp7-20020a1709073e0700b0072ee1e21415mr2576976ejc.596.1657810974249;
        Thu, 14 Jul 2022 08:02:54 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id h13-20020aa7c94d000000b0043ab36d6019sm1183260edt.9.2022.07.14.08.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 08:02:53 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 0/3] KVM: x86: Hyper-V invariant TSC control feature
In-Reply-To: <00c0442718a4f07c2f0ad9524cc5b13e59693c68.camel@redhat.com>
References: <20220713150532.1012466-1-vkuznets@redhat.com>
 <00c0442718a4f07c2f0ad9524cc5b13e59693c68.camel@redhat.com>
Date:   Thu, 14 Jul 2022 17:02:52 +0200
Message-ID: <8735f3ohyb.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxim Levitsky <mlevitsk@redhat.com> writes:

> On Wed, 2022-07-13 at 17:05 +0200, Vitaly Kuznetsov wrote:
>> Normally, genuine Hyper-V doesn't expose architectural invariant TSC
>> (CPUID.80000007H:EDX[8]) to its guests by default. A special PV MSR
>> (HV_X64_MSR_TSC_INVARIANT_CONTROL, 0x40000118) and corresponding CPUID
>> feature bit (CPUID.0x40000003.EAX[15]) were introduced. When bit 0 of the
>> PV MSR is set, invariant TSC bit starts to show up in CPUID. When the=20
>> feature is exposed to Hyper-V guests, reenlightenment becomes unneeded.
>
> If I understood the feature correctly from the code, it allows the HyperV=
, or in this
> case KVM acting as HyperV, to avoid unconditionally exposing the invltsc =
bit
> in CPUID, but rather let the guest know that it can opt-in into this,
> by giving the guest another CPUID bit to indicate this ability
> and a MSR which the guest uses to opt-in.
>
> Are there known use cases of this, are there guests which won't opt-in?
>

Linux prior to dce7cd62754b and some older Windows guests I guess.

>>=20
>> Note: strictly speaking, KVM doesn't have to have the feature as exposing
>> raw invariant TSC bit (CPUID.80000007H:EDX[8]) also seems to work for
>> modern Windows versions. The feature is, however, tiny and straitforward
>> and gives additional flexibility so why not.
>
> This means that KVM can also just unconditionally expose the invtsc bit
> to the guest, and the guest still uses it.

Yes, this feature doesn't bring much by itself (at least with modern
Windows versions). I've implemented it while debugging what ended up
being=20
https://lore.kernel.org/kvm/20220712135009.952805-1-vkuznets@redhat.com/
(so the issue wasn't enlightenments related after all) but as I think it
may come handy some day so why keeping it in my private stash.

>
>
> Nitpick: It might be worth it to document it a bit better somewhere,
> as I tried to do in this mail.

TLFS sounds like the right place for it but ... it's not there... oh well.

>
>
> Best regards,
> 	Maxim Levitsky
>
>>=20
>> Vitaly Kuznetsov (3):
>> =C2=A0 KVM: x86: Hyper-V invariant TSC control
>> =C2=A0 KVM: selftests: Fix wrmsr_safe()
>> =C2=A0 KVM: selftests: Test Hyper-V invariant TSC control
>>=20
>> =C2=A0arch/x86/include/asm/kvm_host.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>> =C2=A0arch/x86/kvm/cpuid.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++
>> =C2=A0arch/x86/kvm/hyperv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 19 +++++
>> =C2=A0arch/x86/kvm/hyperv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 15 ++++
>> =C2=A0arch/x86/kvm/x86.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +-
>> =C2=A0.../selftests/kvm/include/x86_64/processor.h=C2=A0 |=C2=A0 2 +-
>> =C2=A0.../selftests/kvm/x86_64/hyperv_features.c=C2=A0=C2=A0=C2=A0 | 73 =
++++++++++++++++++-
>> =C2=A07 files changed, 115 insertions(+), 6 deletions(-)
>>=20
>
>

--=20
Vitaly

