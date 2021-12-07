Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517CA46AEC0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 01:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378035AbhLGAFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 19:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359871AbhLGAFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 19:05:12 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601B2C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 16:01:43 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id p3so11455475qvj.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 16:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RimBim2ZdnN1r478kYTmUZ/jBCYQVkhpHw/I4bytGeQ=;
        b=ewJsTCpxQ04qK97kihZ6mdX0RSRnimlPmjdXk/Orn8TgiFS8kidhM2qac/dXOdPi3M
         knQE4ZmBn4CFKLl4D57TTstKc/m7XwTo7lgXsfyFExi7S/ff9J8FfP4iubDvTPLZnBSr
         STzT9VOHY5FlJBkcPOsx8vopX3W07pkFtOm1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RimBim2ZdnN1r478kYTmUZ/jBCYQVkhpHw/I4bytGeQ=;
        b=5sNoGVX/xKouWBR4gjL73e5Cpd7X3sLt4sAHxAj2sTI6GyN3bGRNVrxKQO3eQW5NGF
         E6RQTMMPmj3mMnlsEyIUQVhUQb1pC9RZ6Jyc8FvBt3D4/hMfl0GQUG0dTI2q0PsSpLUS
         0O3D1TvGXMc3DN9di8FknXSil+Yz4O5dBDPh9ylfVkkdqHQ+zdx2SLFRhEtH91MYG/HQ
         LkckEispWyYTg4JRkIXWHwxhBWvnQOFcQdUp6U0gGdzbjIyi3Pi8m43QWvmCxaz3yfUS
         isc00JqTl0zilw/UCsV6reohKM2l2AbnLC6h+jUm7fzFk3ljGdXd+wE8ApEgfONmpQgo
         DBMg==
X-Gm-Message-State: AOAM531ax5/Mj14QAKHkZzAMYBLiLbaMZ8+/9wP5/YZ4ERwSVfuK87JY
        5QMIontPqhc/VBJAwnmx5CYL9qTQ1zb+wA==
X-Google-Smtp-Source: ABdhPJycf3be/KqfnO0CfvqpGtYLtNOdMRPDir72ZzDuD9/kZPfAKV7FofWywpVuY6Sww0uxD/Pc9A==
X-Received: by 2002:a05:6214:f61:: with SMTP id iy1mr40335740qvb.0.1638835301884;
        Mon, 06 Dec 2021 16:01:41 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id e13sm8697587qte.56.2021.12.06.16.01.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 16:01:41 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id v138so35942979ybb.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 16:01:41 -0800 (PST)
X-Received: by 2002:a05:6902:564:: with SMTP id a4mr46256085ybt.609.1638835300845;
 Mon, 06 Dec 2021 16:01:40 -0800 (PST)
MIME-Version: 1.0
References: <20211117065454.4142936-1-swboyd@chromium.org>
In-Reply-To: <20211117065454.4142936-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 6 Dec 2021 16:01:27 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XgV5=5mMuB5KbX38EFtZ6qxGGPMN6HFng_KJEc1KERxw@mail.gmail.com>
Message-ID: <CAD=FV=XgV5=5mMuB5KbX38EFtZ6qxGGPMN6HFng_KJEc1KERxw@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: qcom: Don't memcpy_toio more than is provided
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 16, 2021 at 10:55 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> If the string passed into qcom_pil_info_store() isn't as long as
> PIL_RELOC_NAME_LEN we'll try to copy the string assuming the length is
> PIL_RELOC_NAME_LEN to the io space and go beyond the bounds of the
> string. Let's only copy as many byes as the string is long, ignoring the
> NUL terminator.
>
> This fixes the following KASAN error:
>
>  BUG: KASAN: global-out-of-bounds in __memcpy_toio+0x124/0x140
>  Read of size 1 at addr ffffffd35086e386 by task rmtfs/2392
>
>  CPU: 2 PID: 2392 Comm: rmtfs Tainted: G        W         5.16.0-rc1-lockdep+ #10
>  Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
>  Call trace:
>   dump_backtrace+0x0/0x410
>   show_stack+0x24/0x30
>   dump_stack_lvl+0x7c/0xa0
>   print_address_description+0x78/0x2bc
>   kasan_report+0x160/0x1a0
>   __asan_report_load1_noabort+0x44/0x50
>   __memcpy_toio+0x124/0x140
>   qcom_pil_info_store+0x298/0x358 [qcom_pil_info]
>   q6v5_start+0xdf0/0x12e0 [qcom_q6v5_mss]
>   rproc_start+0x178/0x3a0
>   rproc_boot+0x5f0/0xb90
>   state_store+0x78/0x1bc
>   dev_attr_store+0x70/0x90
>   sysfs_kf_write+0xf4/0x118
>   kernfs_fop_write_iter+0x208/0x300
>   vfs_write+0x55c/0x804
>   ksys_pwrite64+0xc8/0x134
>   __arm64_compat_sys_aarch32_pwrite64+0xc4/0xdc
>   invoke_syscall+0x78/0x20c
>   el0_svc_common+0x11c/0x1f0
>   do_el0_svc_compat+0x50/0x60
>   el0_svc_compat+0x5c/0xec
>   el0t_32_sync_handler+0xc0/0xf0
>   el0t_32_sync+0x1a4/0x1a8
>
>  The buggy address belongs to the variable:
>   .str.59+0x6/0xffffffffffffec80 [qcom_q6v5_mss]
>
>  Memory state around the buggy address:
>   ffffffd35086e280: 00 00 00 00 02 f9 f9 f9 f9 f9 f9 f9 00 00 00 00
>   ffffffd35086e300: 00 02 f9 f9 f9 f9 f9 f9 00 00 00 06 f9 f9 f9 f9
>  >ffffffd35086e380: 06 f9 f9 f9 05 f9 f9 f9 00 00 00 00 00 06 f9 f9
>                     ^
>   ffffffd35086e400: f9 f9 f9 f9 01 f9 f9 f9 04 f9 f9 f9 00 00 01 f9
>   ffffffd35086e480: f9 f9 f9 f9 00 00 00 00 00 00 00 01 f9 f9 f9 f9
>
> Fixes: 549b67da660d ("remoteproc: qcom: Introduce helper to store pil info in IMEM")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/remoteproc/qcom_pil_info.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/remoteproc/qcom_pil_info.c b/drivers/remoteproc/qcom_pil_info.c
> index 7c007dd7b200..aca21560e20b 100644
> --- a/drivers/remoteproc/qcom_pil_info.c
> +++ b/drivers/remoteproc/qcom_pil_info.c
> @@ -104,7 +104,7 @@ int qcom_pil_info_store(const char *image, phys_addr_t base, size_t size)
>         return -ENOMEM;
>
>  found_unused:
> -       memcpy_toio(entry, image, PIL_RELOC_NAME_LEN);
> +       memcpy_toio(entry, image, strnlen(image, PIL_RELOC_NAME_LEN));

The above seems slightly sketchy...

Let's say:

image = "modem" (5 characters plus null termination)
PIL_RELOC_NAME_LEN = 8

...so strnlen(image, 8) = 5, right?
...so we'll copy characters _not_ including the NULL termination.

I guess that's OK as long as we're certain that the destination was
zero-initted, but maybe it would be better/safer to write:

memcpy_toio(entry, image, strnlen(image, PIL_RELOC_NAME_LEN - 1) + 1);

-Doug
