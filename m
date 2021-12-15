Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBA2475C7F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244330AbhLOP7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:59:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36498 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232587AbhLOP7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:59:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639583942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ee3a2nNJn1qDhuFcuIsHsDIPYmBR4a8NwMwEtT5aJqY=;
        b=IYugZ5OPYXT4Ih/L/OVibdeU2Wf11b7Rl/sevfSSamS4OAdseD/v37eKJe/Vr2BqxW/6+I
        VRKRUjDknBkJWsDHA03RDX3lI6jYI/PRS09gWzv4GP+3oMgGiCiCF5m4BHhojq1VLwRmqn
        SjGVy+K9Tr1S7EdyfplUHkt2YkKytAs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-172-rNSMuI74NJ6KUXhsnD5tXA-1; Wed, 15 Dec 2021 10:59:01 -0500
X-MC-Unique: rNSMuI74NJ6KUXhsnD5tXA-1
Received: by mail-wm1-f72.google.com with SMTP id f202-20020a1c1fd3000000b00344f1cae317so22324wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 07:59:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ee3a2nNJn1qDhuFcuIsHsDIPYmBR4a8NwMwEtT5aJqY=;
        b=QP4mrR7Cnej8wR14rqXOrpT+yfrVjs1bF/hX76LQTEvNq922mrTlBr0yyhDfYKR50w
         PNkY7PajPJJQ5B8xFu7EE/GbhmQuad0DEQy7HMpMko8mt1c51cn1W8IXcdXzniDCZme2
         vPZ71AZUwjdiN+/RNplbgwUwqwgHq4ie2hBpVnxZJTXiFsAB0QRUklNznePX6X2EPKx8
         26khapCiWwFbyUmMoJ34ILvFpiSm2PYwh64v25hv1bPsZo2LUPfQrNyT6LlFNJVhUoJr
         o7wepWXEHIE78km4JBrrt0UW+wmpi/uMcrTAABmTX596qummJpBgbfdI1jyR9VUzYRtB
         wVBw==
X-Gm-Message-State: AOAM5324Gk5VdqSe6BCkT0yy1zgNSJw/taOaoxpU/35zbfQNV3rZ2ssk
        MiC51Gpcvlsat9g2eaDKhuLmepCc52pOu5b+Idx1J7ywm954/bqVt60BAGTo0gqPDURQpsshizS
        0p0knJsulgRziKQ1yfdcvBhmE
X-Received: by 2002:adf:cf11:: with SMTP id o17mr5042863wrj.554.1639583939996;
        Wed, 15 Dec 2021 07:58:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzaNRZQnHx4dPArhfayJDD5m03QWjgmsTVKizylqLsrk4G9k9x+g6rNXJtal/SJiOJVxIzwsw==
X-Received: by 2002:adf:cf11:: with SMTP id o17mr5042842wrj.554.1639583939735;
        Wed, 15 Dec 2021 07:58:59 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id i17sm2581675wmq.48.2021.12.15.07.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 07:58:59 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, xudong.hao@intel.com,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [KVM]  feb627e8d6: kernel-selftests.kvm.vmx_pmu_msrs_test.fail
In-Reply-To: <20211215154643.GE34913@xsang-OptiPlex-9020>
References: <20211215154643.GE34913@xsang-OptiPlex-9020>
Date:   Wed, 15 Dec 2021 16:58:56 +0100
Message-ID: <87czlxvozj.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot <oliver.sang@intel.com> writes:

> Greeting,
>
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: feb627e8d6f69c9a319fe279710959efb3eba873 ("KVM: x86: Forbid KVM_SET_CPUID{,2} after KVM_RUN")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>

...

>
> # selftests: kvm: vmx_pmu_msrs_test
> # ==== Test Assertion Failure ====
> #   lib/x86_64/processor.c:874: rc == 0
> #   pid=10415 tid=10415 errno=22 - Invalid argument
> #      1	0x000000000040b24f: vcpu_set_cpuid at processor.c:873
> #      2	0x000000000040260a: main at vmx_pmu_msrs_test.c:115
> #      3	0x00007f07e1aec09a: ?? ??:0
> #      4	0x0000000000402759: _start at ??:?
> #   KVM_SET_CPUID2 failed, rc: -1 errno: 22
> not ok 33 selftests: kvm: vmx_pmu_msrs_test # exit=254
>

Hm, I'm pretty sure I've tested feb627e8d6f6 on both Intel and AMD and I
don't remember seeing this failure :-( . vmx_pmu_msrs_test test does
KVM_SET_CPUID after KVM_RUN and thus needs to be fixed too. Will send a
patch shortly.

-- 
Vitaly

