Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E548484E59
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiAEGZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:25:57 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:45870
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231226AbiAEGZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:25:55 -0500
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3C5C13F32C
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 06:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641363954;
        bh=xomhhkzb4Z1O5iHppXgwZxPb/WI2sM/cur7jA0CYYrQ=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=GvZB+qBzb4eaMW2NSOEa9gzaGPTkWO8FKoY2PwNg+6DCRo3P804wegEqVCh+Ys72M
         7skbUGvxAw3p5q4sodgyCr6bmHpBxgHMNvV++AcQyHBlgP9Q7cs3UqN6OyJehr38qD
         +veODp8bVUxGQFMIG32Qkjrlwzd5040Apit/N+IAK8Vvhx7HWF0JALLbvQO15u9fkU
         qXkHUlmOah4R+MkRR/EGwFL3JpvlPu/s2rqIkwgnuAQYEH8rfovdY2VWOCTyuaV+LK
         pOWB4LF8qGCDIKMIkh8KS4KLqxsG0j/8JVpAsEmN8H6zia+7EaD3EcuDw4eCYpCjNg
         IuXJ7q5JFTUGw==
Received: by mail-oo1-f69.google.com with SMTP id a7-20020a4ad5c7000000b002dacfc3d40cso19288095oot.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 22:25:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xomhhkzb4Z1O5iHppXgwZxPb/WI2sM/cur7jA0CYYrQ=;
        b=CJmETbI2DPxC8VECi7UpNnCOTmLLzeLoSD87OZVRRMQwIczZ0ENAeUBrTg6SllODhm
         WnyhMJHRoVX58PSc4YFHl5cf7Sm/FF0H3mgRsEItSNJ11cdZknKcKzaapmbUfiHnJUwb
         cdv2w4f14qxX/sDAx7FpHMf6yVgj+ybZTTvCmTRHtO8oObbowfRupB1qWBMqaqN3JBQS
         Dn6Pt7GQGp2uiTjSvzMTLRuH0XwNinhX0xG7JfPK/UrQy9AXg37+aTAvyr97ISOWdS2x
         aBrnlMr2DucAUwrqyytqq2N1SAWNn2me32t7DL1hBmSSaQMO3imj4akI6uvUL7NIy8vH
         Gv8g==
X-Gm-Message-State: AOAM533VqEtNb5I4lDM2bGU7JM+PGUgQRJfZFusqxRLtUQqM3FtcmMSa
        ULAC191kxT+/vmCqyJzZ5PR61FjAryHlsmi4M3yZ9ztqU8i7NJDMi7zbH0Jw2+8J8uhPAfKKWMF
        0zmblVrSbRPr1JTvYaiF/2PzHXAaaWF9ZTMvAX8un7tqf8fH1DHBJupBEuw==
X-Received: by 2002:a05:6808:199c:: with SMTP id bj28mr1442696oib.98.1641363953091;
        Tue, 04 Jan 2022 22:25:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzQaOHm3+8PGfDYsyMcUxd+G2XwSkTRF+6qtXIBIEoloPxpCcNBr1aSZuPz6YVY0mLiFhUSuDrJYXHVat6+5Dw=
X-Received: by 2002:a05:6808:199c:: with SMTP id bj28mr1442672oib.98.1641363952766;
 Tue, 04 Jan 2022 22:25:52 -0800 (PST)
MIME-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com> <20190820001805.241928-13-matthewgarrett@google.com>
In-Reply-To: <20190820001805.241928-13-matthewgarrett@google.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 5 Jan 2022 14:25:41 +0800
Message-ID: <CAAd53p6d2CsZcwaX0ZtjmOmQv1Dru4qmM-uRxtHJi0k5PnFMFQ@mail.gmail.com>
Subject: Re: [PATCH V40 12/29] x86: Lock down IO port access when the kernel
 is locked down
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On Tue, Aug 20, 2019 at 8:20 AM Matthew Garrett
<matthewgarrett@google.com> wrote:
>
> From: Matthew Garrett <mjg59@srcf.ucam.org>
>
> IO port access would permit users to gain access to PCI configuration
> registers, which in turn (on a lot of hardware) give access to MMIO
> register space. This would potentially permit root to trigger arbitrary
> DMA, so lock it down by default.
>
> This also implicitly locks down the KDADDIO, KDDELIO, KDENABIO and
> KDDISABIO console ioctls.
>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> cc: x86@kernel.org
> Signed-off-by: James Morris <jmorris@namei.org>

This patch breaks ioperm() usage from userspace programs with CAP_SYS_RAWIO cap.

I wonder if it's possible to revert this commit?

Kai-Heng

> ---
>  arch/x86/kernel/ioport.c     | 7 +++++--
>  include/linux/security.h     | 1 +
>  security/lockdown/lockdown.c | 1 +
>  3 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
> index 0fe1c8782208..61a89d3c0382 100644
> --- a/arch/x86/kernel/ioport.c
> +++ b/arch/x86/kernel/ioport.c
> @@ -11,6 +11,7 @@
>  #include <linux/errno.h>
>  #include <linux/types.h>
>  #include <linux/ioport.h>
> +#include <linux/security.h>
>  #include <linux/smp.h>
>  #include <linux/stddef.h>
>  #include <linux/slab.h>
> @@ -31,7 +32,8 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
>
>         if ((from + num <= from) || (from + num > IO_BITMAP_BITS))
>                 return -EINVAL;
> -       if (turn_on && !capable(CAP_SYS_RAWIO))
> +       if (turn_on && (!capable(CAP_SYS_RAWIO) ||
> +                       security_locked_down(LOCKDOWN_IOPORT)))
>                 return -EPERM;
>
>         /*
> @@ -126,7 +128,8 @@ SYSCALL_DEFINE1(iopl, unsigned int, level)
>                 return -EINVAL;
>         /* Trying to gain more privileges? */
>         if (level > old) {
> -               if (!capable(CAP_SYS_RAWIO))
> +               if (!capable(CAP_SYS_RAWIO) ||
> +                   security_locked_down(LOCKDOWN_IOPORT))
>                         return -EPERM;
>         }
>         regs->flags = (regs->flags & ~X86_EFLAGS_IOPL) |
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 2b763f0ee352..cd93fa5d3c6d 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -108,6 +108,7 @@ enum lockdown_reason {
>         LOCKDOWN_KEXEC,
>         LOCKDOWN_HIBERNATION,
>         LOCKDOWN_PCI_ACCESS,
> +       LOCKDOWN_IOPORT,
>         LOCKDOWN_INTEGRITY_MAX,
>         LOCKDOWN_CONFIDENTIALITY_MAX,
>  };
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 410e90eda848..8b7d65dbb086 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -23,6 +23,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>         [LOCKDOWN_KEXEC] = "kexec of unsigned images",
>         [LOCKDOWN_HIBERNATION] = "hibernation",
>         [LOCKDOWN_PCI_ACCESS] = "direct PCI access",
> +       [LOCKDOWN_IOPORT] = "raw io port access",
>         [LOCKDOWN_INTEGRITY_MAX] = "integrity",
>         [LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
> --
> 2.23.0.rc1.153.gdeed80330f-goog
>
