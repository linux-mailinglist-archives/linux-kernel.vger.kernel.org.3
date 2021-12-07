Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF43446B1FF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 05:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbhLGEwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 23:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236300AbhLGEwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 23:52:43 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E6FC061354
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 20:49:14 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id x3-20020a05683000c300b0057a5318c517so16484413oto.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 20:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UTfE57hDt0Q1t21GfBm6n8K6yEgT14DAseiofTENeLw=;
        b=j/J9aSDToSml0nWZkGymGAw76ilWvQG3kd+IRYnv7bpqMrtq6H4EJJ6z2RiZGfm7ZB
         7IuYdd/4m6b5bYEpydg0OeMsYzYWyMRgyGb3MFeq9bSIj6Vg+sECRQkwueLsDRKRU3Kw
         4qomi7hTS8jaS1r8enAvLg9EEpzRFvPJuYIFUTfi877BLspYfMWq7U0R2Z0IFU4WCv8F
         uQmJ9Z8BHPBmzr//mD2UmMzGVIx+gSqX56TVmuME9awWtxK/VArm1mfgu7TPmw4z+oT2
         dsVIBRaQSl30NYbDnbIBy1h5caSxTwBXUCL2Yp1Ux34OW9kizi2Z8t4FQT6HNO4EIF8N
         H/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UTfE57hDt0Q1t21GfBm6n8K6yEgT14DAseiofTENeLw=;
        b=fYpl0Rfsqt62AUQ5EH0bYoVz0JXwEFtimAZ4jQRcv66/9MdaIL2MbYw5ol0tl1dCyZ
         W5G8E3/Clpe9HWOG0u+Ej5TErYPc5l+ej1faQdiDearq+frTsgXyPF4HwdbOmZJ8YVEB
         86JgApSd4CBPrj6N5dsomyTqCvSAx/jUMd0togAllHyaEaOh/TOqlZi2BNH1yhoOewju
         xHe8q1+wjvoOcswADD4CQY8yk7R+o570PevNpzQCR7t8I9uboKyYJ7cSDlyeBziSVF/W
         RJqHTRZWY8Z3sPl/im0iIxM7P3z14OlEY+MOFM3IoTykZxlR5bQq6gPeCOf5JeIynxZ/
         7p/w==
X-Gm-Message-State: AOAM531IVkAKBFEsMkLRtO37i+sWnC/IPV0E02KdM9VubczG9SVrJNJ1
        EdwF37ocVqYD1LANudSLNHx/kDZEMGigojud1MT66g==
X-Google-Smtp-Source: ABdhPJwEir1iDUP4omv+M30OPgzbw9/Of8I3CUUiyBZfZpFXmSQAQJYE84LCC9cuBLCI/LTjRsVtzO4yOJwoZrazxwY=
X-Received: by 2002:a05:6830:601:: with SMTP id w1mr32608951oti.267.1638852553110;
 Mon, 06 Dec 2021 20:49:13 -0800 (PST)
MIME-Version: 1.0
References: <20211207043100.3357474-1-marcorr@google.com>
In-Reply-To: <20211207043100.3357474-1-marcorr@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 6 Dec 2021 20:49:02 -0800
Message-ID: <CALMp9eR6tORQsSm6fGYumY9QrQVHTo3BxempwYRyOEYrv+zHew@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Always set kvm_run->if_flag
To:     Marc Orr <marcorr@google.com>
Cc:     pbonzini@redhat.com, seanjc@google.com, vkuznets@redhat.com,
        wanpengli@tencent.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, thomas.lendacky@amd.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 8:31 PM Marc Orr <marcorr@google.com> wrote:
>
> The kvm_run struct's if_flag is apart of the userspace/kernel API. The

Typo: 'a part'.

> SEV-ES patches failed to set this flag because it's no longer needed by
> QEMU (according to the comment in the source code). However, other
> hypervisors may make use of this flag. Therefore, set the flag for
> guests with encrypted regiesters (i.e., with guest_state_protected set).

Typo: 'registers'.

> Fixes: f1c6366e3043 ("KVM: SVM: Add required changes to support intercepts under SEV-ES")
> Signed-off-by: Marc Orr <marcorr@google.com>
> ---

> -       /*
> -        * if_flag is obsolete and useless, so do not bother
> -        * setting it for SEV-ES guests.  Userspace can just
> -        * use kvm_run->ready_for_interrupt_injection.
> -        */
> -       kvm_run->if_flag = !vcpu->arch.guest_state_protected
> -               && (kvm_get_rflags(vcpu) & X86_EFLAGS_IF) != 0;
> -
> +       kvm_run->if_flag = static_call(kvm_x86_get_if_flag)(vcpu);

I'm sorry that I missed that change when it first went by. Maintaining
backwards compatibility with existing userspace code is a fundamental
tenet of Linux kernel development.

Acked-by: Jim Mattson <jmattson@google.com>
