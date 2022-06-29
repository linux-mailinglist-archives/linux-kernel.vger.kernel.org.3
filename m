Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799E25605E7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiF2Qb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiF2QbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:31:25 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2743434667
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:31:24 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-101e1a33fe3so22098714fac.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q7thwy75XNsSCRPOWOozhMPbtUuFfDHqmCqTx7JYJDo=;
        b=XM+oHc1X7p1kNP/j9n6X2RjMFNVAgMi7Hl3RaZl7JOddM8RA2JxXBhUSZiA4OiquM5
         M2KlQCVxrnDLkjeugS1ikqmgd1pl7G/IAQ723Zy6R4AGzaaAOBmDeuUqHSrV304NOr1F
         UhiO7+/m+8LzUKmraoQGoHjHrforgc5lurae2h31n1RvtunY6unl53g73xAMbl0NcI5g
         n9i5oGNpcF7GD5Ry3X+iU4rW1icOI4AwoqslgQEh4YRMsH5ICJoqOWAiAhgO+QUPEAcV
         NgfLHgA2OS7hcHgz7U24ipW4WFjxYUC2+cds0E3mZHrOJjNOCPmI4ONJ1JnvA/Uvhzq/
         22Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q7thwy75XNsSCRPOWOozhMPbtUuFfDHqmCqTx7JYJDo=;
        b=TMmT73X9EKl2mu7S9Y3PpzVNO+l/RIm4ghijCpywhWQaviepcdimydUQNeGU4bI+J2
         2SAnMS8I4dW2GxTR8081v4ckYAoubx0QVr/9v1YP/hK6Al9UsWsejsbyUhtuYwsD40Zh
         iHUOR7yQ5HcUUG8XxUh2RIX7svubc+fL9xACbEA42CeAQBaFGHptH+JEFUx+WtAG6Vil
         0iVaWkkoXBR4Yqy7PyGNpLwdydP8Z3b9Ez4hf9B3Vku0vR9HVfU+Rk/BdktEbmzBucJh
         6rJk/TdZGLIZZ9BaEhQwcGj/okpq/ESe3dCcpBLF+4qr+gd7HYyTwxf46UftzqEOMLcD
         gL0w==
X-Gm-Message-State: AJIora9VS/ZdByP5f1OpE/SA8dea0TON3+QqRAujXhcScAzwMNdcRVjq
        uB4YZhjavAMQP9QP8ddaBa8GZWgURQ7xG5olNSBaWQ==
X-Google-Smtp-Source: AGRyM1u9TD9lOx2AIm1cqMUMRT2gwTyLTDprchu9bU7eiWqc2WXJ4sjR9kPK2AzybmpZbNtc5ympPlJJjJNqTtuNnkw=
X-Received: by 2002:a05:6870:c596:b0:101:6409:ae62 with SMTP id
 ba22-20020a056870c59600b001016409ae62mr3543919oab.112.1656520283337; Wed, 29
 Jun 2022 09:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220621150902.46126-1-mlevitsk@redhat.com> <20220621150902.46126-12-mlevitsk@redhat.com>
In-Reply-To: <20220621150902.46126-12-mlevitsk@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 29 Jun 2022 09:31:12 -0700
Message-ID: <CALMp9eSe5jtvmOPWLYCcrMmqyVBeBkg90RwtR4bwxay99NAF3g@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] KVM: x86: emulator/smm: preserve interrupt
 shadow in SMRAM
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
        x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>
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

On Tue, Jun 21, 2022 at 8:09 AM Maxim Levitsky <mlevitsk@redhat.com> wrote:
>
> When #SMI is asserted, the CPU can be in interrupt shadow
> due to sti or mov ss.
>
> It is not mandatory in  Intel/AMD prm to have the #SMI
> blocked during the shadow, and on top of
> that, since neither SVM nor VMX has true support for SMI
> window, waiting for one instruction would mean single stepping
> the guest.
>
> Instead, allow #SMI in this case, but both reset the interrupt
> window and stash its value in SMRAM to restore it on exit
> from SMM.
>
> This fixes rare failures seen mostly on windows guests on VMX,
> when #SMI falls on the sti instruction which mainfest in
> VM entry failure due to EFLAGS.IF not being set, but STI interrupt
> window still being set in the VMCS.

I think you're just making stuff up! See Note #5 at
https://sandpile.org/x86/inter.htm.

Can you reference the vendors' documentation that supports this change?
