Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FAD56C557
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 02:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239103AbiGHX2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 19:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbiGHX2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 19:28:43 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65438419A0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 16:28:42 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id t5-20020a17090a6a0500b001ef965b262eso57160pjj.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 16:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e+NeNkk39ltiGV+dj2RQPj4kbFE+Sv627jjV0PX2d7M=;
        b=dsaUde/zuN7bmn8vqZ7jesXJOW7rruWwyUOCwZut7U6/s90osYHWC/m7gkxQZzagIR
         7VMXuxgh5ETurEMF4m6lWBbm3ivjiNjpQe0Jgtw5K0aGaQ42bfvRwYKRiVbqC10YEvG/
         z7c+TYBT3qYUktz2kFRF0nrKBBMo3avj/Bqtkki3olhZe4rd6NseXEf2yBqt7zhpzKB9
         dr52ycepMPEKdha3GdA65UWimWF5/WMnhL809v1Znt03cjUJMyalE18Y31IA/KTuPRhI
         y9JTSg3+HGKJOvXqEj3sgHdVzJ1i4D6YrZV0je5UQuIdXzOFATXg2SK+zOAHYx24qI2s
         Vyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e+NeNkk39ltiGV+dj2RQPj4kbFE+Sv627jjV0PX2d7M=;
        b=dG33t13Bpm6AQZsxMbfqPQBBqlJ3ffimGEEattQCkSv58L1G2aA4sIldoU+N1vgbbK
         lEBnKEd9Vhu28CH/YMYWA3QqOyHUqF9zp9wRj1Oo0lF/StCVy5CbEEAcbxWKNWoNODzL
         +gEkunB39cQLpk+WVwuEa1DhYNn30IeRyzMgLg50oULdADJVcqWD6anXjZo9FIAtxoBP
         t2QtJ0dB4+r0qrzv+UKBdlexZG646Vsq8CO4l9CHOHsDuqKn7CLouXANayZBHTQ2aDW3
         t925MJbkefVXDGUtL6K29Yt1SQ3gtVreevJUmk/xW5rOVoUpuvKQYoWKK/JreZlZjhdJ
         jq+A==
X-Gm-Message-State: AJIora/XVBAshwlmTj3El1sXFK0xXXjzr7WFol9OFfVEgijnX4gtxwM7
        sM/nSvWp2c2/S5aSo6ZC7eZwHgpvoLhTIQ==
X-Google-Smtp-Source: AGRyM1u/tDyTYyiQ9zhPGTuAVzDjyrmgTdmehsxbIKC6zKjYekVW5hGS+QKrJHiI8K7P1psxo5HuiQ==
X-Received: by 2002:a17:90b:3811:b0:1ef:d704:24cf with SMTP id mq17-20020a17090b381100b001efd70424cfmr2526527pjb.14.1657322921668;
        Fri, 08 Jul 2022 16:28:41 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902a3c500b0015e8d4eb2easm44851plb.308.2022.07.08.16.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 16:28:41 -0700 (PDT)
Date:   Fri, 8 Jul 2022 23:28:37 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 0/3] x86/crash: Fix double NMI shootdown bug
Message-ID: <Ysi9pVFHsqM3uivr@google.com>
References: <20220518001647.1291448-1-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518001647.1291448-1-seanjc@google.com>
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

On Wed, May 18, 2022, Sean Christopherson wrote:
> Fix a double NMI shootdown bug found and debugged by Guilherme, who did all
> the hard work.  NMI shootdown is a one-time thing; the handler leaves NMIs
> blocked and enters halt.  At best, a second (or third...) shootdown is an
> expensive nop, at worst it can hang the kernel and prevent kexec'ing into
> a new kernel, e.g. prior to the hardening of register_nmi_handler(), a
> double shootdown resulted in a double list_add(), which is fatal when running
> with CONFIG_BUG_ON_DATA_CORRUPTION=y.

...

> Sean Christopherson (3):
>   x86/crash: Disable virt in core NMI crash handler to avoid double
>     shootdown
>   x86/reboot: Disable virtualization in an emergency if SVM is supported
>   x86/virt: Fold __cpu_emergency_vmxoff() into its sole caller
> 
>  arch/x86/include/asm/reboot.h  |  1 +
>  arch/x86/include/asm/virtext.h | 14 +-----
>  arch/x86/kernel/crash.c        | 16 +-----
>  arch/x86/kernel/reboot.c       | 89 +++++++++++++++++++++++++---------
>  4 files changed, 69 insertions(+), 51 deletions(-)

Ping!  Still applies cleanly.
