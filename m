Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB763474E62
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 23:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237943AbhLNW7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 17:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235030AbhLNW7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 17:59:33 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D12EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 14:59:33 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id t5so68095804edd.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 14:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=khVptH+M0tfn36lg9TBFDzwD3VeLdbUmAWzNh6/qLO0=;
        b=rJsbXgWLM3XVCagULFVF8jOXjqBhzFe4TGokRhLqIumiOWwYYAWMmkeXiQHhYh/Ihf
         51DpW6Wy6mANL4BR0LqusesI0F4cnrPBmfX05RyU5zKCDTmvKz6+dXRrKgr7UXT+EAzl
         yyuMhzhNCFa7hH5IPayUhM6IFvXZCyKqkUgv5yGFBp4S4NOOVGrj0w3JakoeSbKSqpqP
         tVfDPb7ltetkGxdOSPgrdFnVh/aUB71mp0fhrp+OZbdMRIDlfVHecvoHt28yMo/vzH6I
         HTHwDxd8BFGTI7OnhucdsHJ/+2D8S5rtq+McqwUgqd1aaI3peOFv0MPOIPI5qAaoLs7t
         nyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=khVptH+M0tfn36lg9TBFDzwD3VeLdbUmAWzNh6/qLO0=;
        b=Q3Wbcxf26oktszIQfrWdhP9VHZsEpkqG9IfZrp3DqRagOZI99jEcTCfcopU9FHkf/g
         jdTeV/QBAaarxzDllLstegzBO81ko9ep7ySgrOLUy/SnIBrtnC0RDPIkS5oi+TORLZCg
         Hc9abypvse15q7wvrr/K09xQdteczycp9KiB7Oih+STX9PfnXO+PBm/9tEOy62x92TDZ
         XDnv6Q1faTBVLU0Ajr2B2DyC3mbsK/1kaB+Y2Rvr/a2nTUvTLv9799JhDst7zn8x9qQ8
         OVWE6vAdDNdBKjvfY/Y3LvEtn36RUUEDJTNDWSKADdpuKPkoJvy+qQ/aMyBp3rfeSK+p
         SrFw==
X-Gm-Message-State: AOAM533ATQeukL3BTAdbwffrC0DmN//9wsm5UEdaZ8BpAP2U9SY6CrP/
        5Scl71oWI1TzRUkrFzDKkQ6qBBlU2X+LQmLkk3+b
X-Google-Smtp-Source: ABdhPJwDaxZJiRGG8M2ITTDZmRyH/uAtqgn33PJ7PGjh9HnVGALZ16WyupWf4FRPUBGuiIBz54Ny1EOXpoRuxkdI4bk=
X-Received: by 2002:a05:6402:520e:: with SMTP id s14mr11437825edd.213.1639522772037;
 Tue, 14 Dec 2021 14:59:32 -0800 (PST)
MIME-Version: 1.0
References: <tencent_D0F3F07E25927F681055E6A35C038E168A07@qq.com>
In-Reply-To: <tencent_D0F3F07E25927F681055E6A35C038E168A07@qq.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 14 Dec 2021 17:59:21 -0500
Message-ID: <CAHC9VhRa3H7_CxP_pTsXPgmkTt908k6epMUaK84-FWyvikofpA@mail.gmail.com>
Subject: Re: [PATCH] selinux: check the return value of audit_log_start()
To:     xkernel.wang@foxmail.com
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 1:20 AM <xkernel.wang@foxmail.com> wrote:
>
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
>
> audit_log_start() returns audit_buffer pointer on success or NULL on
> error. It is better to check the return value of it so to prevent
> potential memory access error.

The audit_log_start() function can return NULL in normal use, it does
not always indicate an error; returning NULL simply indicates that no
auditing should be done for this particular instance, e.g. an audit
filter is excluding the record.  Further, there is no potential memory
access error as the audit_log_*() functions are designed to accept a
NULL audit_buffer and return without error.

There have been some cases where we check for a NULL audit_buffer and
skip the following audit_log_*() calls, but that is typically in
performance critical code where the additional function calls would
have an impact (small as they might be).  In the case below, this is
not a critical code path, it is an error path, and here I would rather
have the code as it currently stands; I believe it is cleaner and
easier to read this way.

Regardless, thank you for taking the time to submit a patch.

> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
>  security/selinux/ss/services.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index e5f1b27..759d878 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -3277,11 +3277,13 @@ int security_sid_mls_copy(struct selinux_state *state,
>                                 ab = audit_log_start(audit_context(),
>                                                      GFP_ATOMIC,
>                                                      AUDIT_SELINUX_ERR);
> -                               audit_log_format(ab,
> -                                                "op=security_sid_mls_copy invalid_context=");
> -                               /* don't record NUL with untrusted strings */
> -                               audit_log_n_untrustedstring(ab, s, len - 1);
> -                               audit_log_end(ab);
> +                               if (ab) {
> +                                       audit_log_format(ab,
> +                                                       "op=security_sid_mls_copy invalid_context=");
> +                                       /* don't record NUL with untrusted strings */
> +                                       audit_log_n_untrustedstring(ab, s, len - 1);
> +                                       audit_log_end(ab);
> +                               }
>                                 kfree(s);
>                         }
>                         goto out_unlock;

-- 
paul moore
www.paul-moore.com
