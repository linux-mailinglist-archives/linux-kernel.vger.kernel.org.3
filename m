Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54D3543035
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238907AbiFHMXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238835AbiFHMXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:23:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23F7A1BE670
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 05:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654690995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/7XxU1vpb3i/RraPnT6M/WFHPAcSoIyxxdLxtdZ5+qs=;
        b=Ji0KK53ZUC+uK+8+aAecVE1Lq2owGPvvHNBWwK+F4GoJxBm6V31n+Q38KKQoV5518GimFX
        +DHRDeeBh9Htmkedfemcx/AX92Iuth8Y4xswuoTbYkX2JYdqIsNs27HK7vg/HVHRsmlIK/
        E+oDWD68t/R3hfn0hJNX/sf3Pcv79xw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-118-mrx_1gDlPWS-vK_0Y9v72A-1; Wed, 08 Jun 2022 08:23:14 -0400
X-MC-Unique: mrx_1gDlPWS-vK_0Y9v72A-1
Received: by mail-wr1-f70.google.com with SMTP id i10-20020a5d55ca000000b002103d76ffcaso4798303wrw.17
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 05:23:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/7XxU1vpb3i/RraPnT6M/WFHPAcSoIyxxdLxtdZ5+qs=;
        b=adpavlRAlz+DTitI/yjip0MLtU+s1qE+S3Pp9nfi/Nq7G4mVtass8yk91VzjQzqWmq
         q4R3lNNJc7IEogpkcMjbFIWSgV2fMpvbT3jkceA06jrX7WyGV2e9m0R1WyzHvuMD6vyH
         T9Sfgf9lnyIxJXq0rdd8DpasqoXpUTTioAQbuotjiB5R6tRf1Xg8Ak07+eCPMyeLzBgU
         zPDOzAF9dAAY21q4lIeSeSmNE/ZqIa/uDM3o8kcxzGUGhs00/fM0/R6fzsbFX7opcsNm
         SbFIjIUz8m0LUnMejliYyrq61psR8yLoNVyfASFr6Wn0me2rX3xhF5hfBCXySJC40N7L
         7o+w==
X-Gm-Message-State: AOAM532+9L04gUldbqV2JxOuC05CfIdnMoJUAL1Ns/aZLigVrqq4vpl+
        EqMYqjABIHhGdWkqSk/eTy1i39CzRHJCToTTXr56f9mWLfvoQKSvgdb2b0r43S3ND+W2nk8/OWP
        FufRXB0AQReYIg5r+NFC1bddr
X-Received: by 2002:adf:fc07:0:b0:216:af8b:f9cd with SMTP id i7-20020adffc07000000b00216af8bf9cdmr21074702wrr.680.1654690992405;
        Wed, 08 Jun 2022 05:23:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7WsdEYfoCh55L54FUdmNmsRWjSiCXBE/lIX3ZDIyUL/rx3Zhg+Z9Sh0NjvKQ2klhlnBUFVw==
X-Received: by 2002:adf:fc07:0:b0:216:af8b:f9cd with SMTP id i7-20020adffc07000000b00216af8bf9cdmr21074681wrr.680.1654690992164;
        Wed, 08 Jun 2022 05:23:12 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id m3-20020a05600c3b0300b003942a244f2fsm28862550wms.8.2022.06.08.05.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 05:23:11 -0700 (PDT)
Message-ID: <efa20602-b17b-adac-927f-fa38aa6d22d6@redhat.com>
Date:   Wed, 8 Jun 2022 14:23:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 0/8] KVM: x86: Emulator _regs fixes and cleanups
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Robert Dinse <nanook@eskimo.com>
References: <20220526210817.3428868-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220526210817.3428868-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/22 23:08, Sean Christopherson wrote:
> Clean up and harden the use of the x86_emulate_ctxt._regs, which is
> surrounded by a fair bit of magic.  This series was prompted by bug reports
> by Kees and Robert where GCC-12 flags an out-of-bounds _regs access.  The
> warning is a false positive due to a now-known GCC bug, but it's cheap and
> easy to harden the _regs usage, and doing so minimizing the risk of more
> precisely handling 32-bit vs. 64-bit GPRs.
> 
> I didn't tag patch 2 with Fixes or Cc: stable@.  It does remedy the
> GCC-12 warning, but AIUI the GCC-12 bug affects other KVM paths that
> already have explicit guardrails, i.e. fixing this one case doesn't
> guarantee happiness when building with CONFIG_KVM_WERROR=y, let alone
> CONFIG_WERROR=y.  That said, it might be worth sending to the v5.18 stable
> tree[*] as it does appear to make some configs/setups happy.
> 
> [*] KVM hasn't changed, but the warning=>error was introduced in v5.18 by
>     commit e6148767825c ("Makefile: Enable -Warray-bounds").
> 
> v2:
>    - Collect reviews and tests. [Vitaly, Kees, Robert]
>    - Tweak patch 1's changelog to explicitly call out that dirty_regs is a
>      4 byte field. [Vitaly]
>    - Add Reported-by for Kees and Robert since this does technically fix a
>      build breakage.
>    - Use a raw literal for NR_EMULATOR_GPRS instead of VCPU_REGS_R15+1 to
>      play nice with 32-bit builds. [kernel test robot]
>    - Reduce the number of emulated GPRs to 8 for 32-bit builds.
>    - Add and use KVM_EMULATOR_BUG_ON() to bug/kill the VM when an emulator
>      bug is detected.  [Vitaly]
> 
> v1: https://lore.kernel.org/all/20220525222604.2810054-1-seanjc@google.com
> 
> Sean Christopherson (8):
>    KVM: x86: Grab regs_dirty in local 'unsigned long'
>    KVM: x86: Harden _regs accesses to guard against buggy input
>    KVM: x86: Omit VCPU_REGS_RIP from emulator's _regs array
>    KVM: x86: Use 16-bit fields to track dirty/valid emulator GPRs
>    KVM: x86: Reduce the number of emulator GPRs to '8' for 32-bit KVM
>    KVM: x86: Bug the VM if the emulator accesses a non-existent GPR
>    KVM: x86: Bug the VM if the emulator generates a bogus exception
>      vector
>    KVM: x86: Bug the VM on an out-of-bounds data read
> 
>   arch/x86/kvm/emulate.c     | 26 ++++++++++++++++++++------
>   arch/x86/kvm/kvm_emulate.h | 28 +++++++++++++++++++++++++---
>   arch/x86/kvm/x86.c         |  9 +++++++++
>   3 files changed, 54 insertions(+), 9 deletions(-)
> 
> 
> base-commit: 90bde5bea810d766e7046bf5884f2ccf76dd78e9

Queued, thanks.

Paolo

