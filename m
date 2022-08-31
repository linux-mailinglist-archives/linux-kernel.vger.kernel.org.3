Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EB55A898D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 01:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiHaXmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 19:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiHaXmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 19:42:16 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B1AE3960
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 16:42:15 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-12243fcaa67so5247194fac.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 16:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Gbm2YDpQFjBB1C/MWGwxozhGDn3//MPNQbYc8/MnpoE=;
        b=sv9KHad0cGJmeFGaf+ztBX4dGte7jbjk12BGsqagdw6/6nJv9XOTZ9/sJAS4nx286i
         +crmGCs/+kfmV1tOSy25eInQxv899WJiLA4AcqJlJn6mVknCPa4dZ1v9iwMavURrTqtu
         86WJSYXKDHX27MZJYwC265oE7nZVOIrHUw5GwYPANm9iwRIQluBoVdT9rRkRB7SsIUHZ
         UOIqzitSK5fGiH7Yvs/QVF0jMZyB7UxOy0NstjpSsLyqttn0w7dcEDpiHsRxyA0OwbF8
         NfyDy5CLQa2u0Cn2rg0SUELBVVzxKOn/Om8OqKj/70sQ/TrGFZhx/NEOYJlMNeil8emJ
         p+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Gbm2YDpQFjBB1C/MWGwxozhGDn3//MPNQbYc8/MnpoE=;
        b=q1a/A15NtCj/8T7CoxLf8y3kQEJSbq1oKRqVgQq/OnDP/544+ju7iWV27NV3MagqLz
         RvA4rFrv+r6PkWAufFezYoDl/eIfym1vJTHPeAsv4meSE7Wc1PaaYl/0SWGNqn1v8Ehg
         f2zCCeIYrAXLV5x9H+HqnRn+bMa3mIuvApjxZsUIuDzGLrlfykCXzCBV1tIpTTtfk0Cj
         Rt6LBVmYNN4k29Cf878O9YA9+gHaOLgDiq6PypRTQV2lOAxcsRQYnPmg/6058Di9d0xZ
         wUjDUq5MNcz6Eed5n+gVNEWwOQxNxIaaV1nsqe1OSkK1m0ryfBdLMstRKaixx3nizgiG
         RE9g==
X-Gm-Message-State: ACgBeo1P4J/5mYVAQ+1iCsNaVbZk2UyhS8IIcRCCwmDBVy16ZpnzjzVM
        9mnIL65dFFQInd2y1HXW72PUwGDFCYO17o6KxZNCYg==
X-Google-Smtp-Source: AA6agR793of2eSi6hkm3OSxzP8r3isyPimVdewi75reSxnQQZJbBYzdZG8VQmDhfZhM8j82TPUYrgl/5v6iD8rMSisk=
X-Received: by 2002:a05:6870:5a5:b0:122:5662:bee6 with SMTP id
 m37-20020a05687005a500b001225662bee6mr756255oap.181.1661989334489; Wed, 31
 Aug 2022 16:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220829100850.1474-1-santosh.shukla@amd.com> <20220829100850.1474-2-santosh.shukla@amd.com>
In-Reply-To: <20220829100850.1474-2-santosh.shukla@amd.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 31 Aug 2022 16:42:03 -0700
Message-ID: <CALMp9eTrz2SkK=CjTSc9NdHvP4qsP+UWukFadbqv+BA+KdtMMg@mail.gmail.com>
Subject: Re: [PATCHv4 1/8] x86/cpu: Add CPUID feature bit for VNMI
To:     Santosh Shukla <santosh.shukla@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mlevitsk@redhat.com,
        mail@maciej.szmigiero.name
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 3:09 AM Santosh Shukla <santosh.shukla@amd.com> wrote:
>
> VNMI feature allows the hypervisor to inject NMI into the guest w/o
> using Event injection mechanism, The benefit of using VNMI over the
> event Injection that does not require tracking the Guest's NMI state and
> intercepting the IRET for the NMI completion. VNMI achieves that by
> exposing 3 capability bits in VMCB intr_cntrl which helps with
> virtualizing NMI injection and NMI_Masking.
>
> The presence of this feature is indicated via the CPUID function
> 0x8000000A_EDX[25].
>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index ef4775c6db01..33e3603be09e 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -356,6 +356,7 @@
>  #define X86_FEATURE_VGIF               (15*32+16) /* Virtual GIF */
>  #define X86_FEATURE_X2AVIC             (15*32+18) /* Virtual x2apic */
>  #define X86_FEATURE_V_SPEC_CTRL                (15*32+20) /* Virtual SPEC_CTRL */
> +#define X86_FEATURE_V_NMI              (15*32+25) /* Virtual NMI */
>  #define X86_FEATURE_SVME_ADDR_CHK      (15*32+28) /* "" SVME addr check */

Why is it "V_NMI," but "VGIF"?

Reviewed-by: Jim Mattson <jmattson@google.com>
