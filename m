Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31DF483495
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbiACQIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 11:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiACQIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:08:51 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25BEC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 08:08:50 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id i31so75838587lfv.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 08:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d15sFOXBRn1YqhFC4TPixMjg1M5xVWdy0HG7Tbw2VS8=;
        b=PCaiyQUwGEJ0jk+jkX8VQC4cWXFIdjqjjN69Y6GHLrryoj23s21XlrBCRyojuWiWFK
         vy05fS60ispggk3vhZ/hn+35UxzvSI55dH6KB4C0MHrNashHD4T7d/QuL51KbDG4w+K3
         q7n0HDXZ5tTth8idKyo9CDKoYshuFXW1dObkqsT+cR8hBriwkUpgJBV/tlpsV7shpMic
         LzZA7cB9uaEfxoW4b0Ium+Uvbt7qpgozk+B3GKBA7xVRWTelJRw7pxIGzZOsu9UTfcds
         N2VkaqEm+HwEkhUM9HYDfLpK/VroB09Wtcwtty4q37TFtFPznZbAl6aKPFCSmwDytPTu
         LVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d15sFOXBRn1YqhFC4TPixMjg1M5xVWdy0HG7Tbw2VS8=;
        b=bjlUM02PW94mCq6jDCRvj98Ajcn54iK9k9W9bYmw8vmZu4OBoh2k/vdZF0Vy3ihHw7
         9FEzLKAs0GFa2+JehlmNi09kRQBTNTLpsIK4ttAOtugebw+waXBs6c+pYYbHhTFvGIPa
         y9eXej8CE2duO50v3OeYbB5GcD/DKNk/DfI0RcTeKC9oJpt1WXEsn6jLtX/x2vOoKM6Z
         XOiWQrw45tLhwb+nzXJJCnkRTyKrGBM0dVjs9RbECMuTtoSZKDuYu/SVQqddC9L1YUNf
         zvy4WOo1dyAfSGXhz4CJ0afRq16KxGRiwb396nDkzKlSTZ2r3axJWaefQE2VwQYvXMat
         sRqw==
X-Gm-Message-State: AOAM530L0rzn/pgP0Hg55Um0x7vS1PttMCxsm8N5+XfeUVGJIaKCGX16
        ypsCT6NcbBUhU8NCok9ZhsHQtw9E/XGeWjitgJbaLg==
X-Google-Smtp-Source: ABdhPJxt0wIPKfwW66vV+3HOE1EluXKL9L7UPc/8gBQvU0y+lbiesC1pq+avNrHr74rUT6H+QvdpFlNYiWxKjsLx1MQ=
X-Received: by 2002:a05:6512:234d:: with SMTP id p13mr35033232lfu.157.1641226128950;
 Mon, 03 Jan 2022 08:08:48 -0800 (PST)
MIME-Version: 1.0
References: <20220103160002.1068356-1-Jason@zx2c4.com>
In-Reply-To: <20220103160002.1068356-1-Jason@zx2c4.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 3 Jan 2022 17:08:21 +0100
Message-ID: <CAG48ez2FfXLfCiF5PZdyUM4oZVCL0MtN8+mT6Zb-7kn69-Xs8A@mail.gmail.com>
Subject: Re: [PATCH] random: reseed in RNDRESEEDCRNG for the !crng_ready() case
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 3, 2022 at 5:00 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Userspace often wants to seed the RNG from disk, without knowing how
> much entropy is really in that file. In that case, userspace says
> there's no entropy, so none is credited. If this happens in the
> crng_init==1 state -- common at early boot time when such seed files are
> used -- then that seed file will be written into the pool, but it won't
> actually help the quality of /dev/urandom reads. Instead, it'll sit
> around until something does credit sufficient amounts of entropy, at
> which point, the RNG is seeded and initialized.
>
> Rather than let those seed file bits sit around unused until "sometime
> later", userspaces that call RNDRESEEDCRNG can expect, with this commit,
> for those seed bits to be put to use *somehow*. This is accomplished by
> extracting from the input pool on RNDRESEEDCRNG, xoring 32 bytes into
> the current crng state.
>
> Suggested-by: Jann Horn <jannh@google.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Jann - this is the change I think you were requesting when we discussed
> this. Please let me know if it matches what you had in mind.

Yeah, this looks good.

Reviewed-by: Jann Horn <jannh@google.com>

>  drivers/char/random.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 17ec60948795..805e509d9c30 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -1961,8 +1961,17 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
>         case RNDRESEEDCRNG:
>                 if (!capable(CAP_SYS_ADMIN))
>                         return -EPERM;
> -               if (crng_init < 2)
> +               if (!crng_ready()) {

Non-actionable review note: We can race with crng_ready() becoming
true in parallel, but that's probably fine - after all, that'll also
do the CRNG reseeding stuff on its own.

> +                       unsigned long flags, i;
> +                       u32 new_key[8];
> +                       _extract_entropy(&input_pool, new_key, sizeof(new_key), 0);
> +                       spin_lock_irqsave(&primary_crng.lock, flags);
> +                       for (i = 0; i < ARRAY_SIZE(new_key); ++i)
> +                               primary_crng.state[4 + i] ^= new_key[i];
> +                       spin_unlock_irqrestore(&primary_crng.lock, flags);

Non-actionable review note: This doesn't need the same
crng_global_init_time bump as below because at this point, no NUMA
pools exist yet, only the single shared primary_crng.

> +                       memzero_explicit(new_key, sizeof(new_key));
>                         return -ENODATA;
> +               }
>                 crng_reseed(&primary_crng, &input_pool);
>                 WRITE_ONCE(crng_global_init_time, jiffies - 1);
>                 return 0;
> --
> 2.34.1
>
