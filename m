Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E058547E557
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 16:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244129AbhLWPIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 10:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239868AbhLWPIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 10:08:43 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE286C061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 07:08:43 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso7365615otf.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 07:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1u8duC2IeWmL+KdsxLTbMsS3G/N3KVyTVG5m2HVZMZg=;
        b=Bed56Qw8wMYeIin9CNr9UYH/AqbY7DdY6GAq5FFzrAq9mlF3I3W0OdTZxN8giUqBnR
         gL0yD8AnRZoWftcF1BiGzZ3yqZHzYiZ5J9ULKiDpNKK/7AZ6eoqftlfZ0nFD8N3xT6Of
         xN9qGoS3c9zYmohpzzYPdKOGN9UjhLRISXCh1ywFrQ/oLI9gSf5pitMyFDNbW6fMoT6a
         +9YIvWPYfx3GqU4L4uMRKt4Bf9jgdHnRDBym6WiCUQU40NHzs8qCRZV5LU/tQqjZWRhF
         vf4r4he0+/AIYJ5Aqkx1bPJWHFtSMgRLCtsxGRXDGk3Nd5pZXBfFaAGiLM2r3+3ZJSTI
         V3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1u8duC2IeWmL+KdsxLTbMsS3G/N3KVyTVG5m2HVZMZg=;
        b=O1tXiNU/mwWhQ4htxHjSQlM5RIIKH7ybego2nIQylHHj7bgJsp6YK1K4NbR/XsuKan
         rhjasv2JvW9tv+voONEn9M33Gk8Ogo96ltmsMga9nZrrM559VDT2kbZgG/MqMYJ24uQB
         x9g/W2e0ylgdkC+sdvtJc58VkH0ocCfBMFQC4qv9Yzu9iWl6Ccq0jPnURk6lOYLG456h
         08T6pp/L5K3IlOGM2c6bkkcMd0Op8dU+4VmEvnagmSl0j/SXIf+Ux6/7QTJoHBNTy9KL
         AV4V/KCyy3swxI5opRAHWq3pEVVwmKhpYHbLZ076cIe+ZFpb2aB9FbViK/p4QXLnzWVT
         PByQ==
X-Gm-Message-State: AOAM5309U+958WsGoUigyP/kFLSp4+ZKF880xXWY7zrQYgkbzbsRxxwn
        +SMnTrXRcoERyisNukiFYRrO5BzgtRvND8ycDWGsUg==
X-Google-Smtp-Source: ABdhPJwXnzm70vqeatqGNT4zIBvnsyg6GXdzi5hGrjHB6FeauzUu8nkOBZ+tBDDztmjYpMuuA1jYUfDjmn9uRJL/MSA=
X-Received: by 2002:a9d:2ae1:: with SMTP id e88mr1644066otb.157.1640272122858;
 Thu, 23 Dec 2021 07:08:42 -0800 (PST)
MIME-Version: 1.0
References: <20211222075406.57191-1-qiang1.zhang@intel.com>
In-Reply-To: <20211222075406.57191-1-qiang1.zhang@intel.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 23 Dec 2021 16:08:31 +0100
Message-ID: <CANpmjNOmaSxqTjUd8y=A+sK0jGg6c00t8uvmOey+QrJsDamsmQ@mail.gmail.com>
Subject: Re: [PATCH] rcu: record kasan stack before enter local_irq_save()/restore()
 critical area
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, ryabinin.a.a@gmail.com, urezki@gmail.com,
        jun.miao@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2021 at 08:54, Zqiang <qiang1.zhang@intel.com> wrote:
> The kasan_record_aux_stack_noalloc() only record stack, it doesn't need
> to be called in local_irq_save()/restore() critical area, and the global
> spinlock (depot_lock) will be acquired in this function, When enable
> kasan stack, locking contention may increase the time in the critical area.

I think the change itself is harmless, because
kasan_record_aux_stack_noalloc() doesn't care if interrupts are
enabled or not when called, but the justification isn't clear to me.

What "locking contention" are you speaking about? You're moving a
local_irq_save() which disables interrupts. Yes, it might be nice to
reduce the time interrupts are disabled, but in this case the benefit
(if any) isn't clear at all, also because this only benefits
non-production KASAN kernels.

Can you provide better justification? Did you encounter a specific
problem, maybe together with data?

Thanks,
-- Marco

> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 347dae1876a6..5198e44cb124 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3030,8 +3030,8 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
>         }
>         head->func = func;
>         head->next = NULL;
> -       local_irq_save(flags);
>         kasan_record_aux_stack_noalloc(head);
> +       local_irq_save(flags);
>         rdp = this_cpu_ptr(&rcu_data);
>
>         /* Add the callback to our list. */
> --
> 2.25.1
>
