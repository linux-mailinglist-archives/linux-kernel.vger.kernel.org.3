Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830CE48EDBC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 17:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243171AbiANQM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 11:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243107AbiANQM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 11:12:56 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CE9C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 08:12:56 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id w9so12802779iol.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 08:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EPYjGXrXJzm3/2O9xWQaTqxgYIE2B54FIlQCIxIosGY=;
        b=VNoFwJfrEUUkkBi9mN8WLSQHc/uYB5+8/57AiBNaQ4YTSJZxzwxde3bDqPpVwNFJCy
         NoO82SKi9RlwsjwpceMIPaMlvTdVTN8sU8FiEoDr6Dej0i/f0ZOeN4I+yn8HSY1E368q
         qiSSqXDVbeR0Vq74cBIPbNYoPzGuGVoDlJKhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EPYjGXrXJzm3/2O9xWQaTqxgYIE2B54FIlQCIxIosGY=;
        b=CF1uaN9yXx/pSGyqRuqnMG73DELMqwS3RCgLeaV5hDw/8rCvGHv/S/Nyf2wD6Dtbh4
         sqZbjPHscndD8LTDIh/F2NZb42AX1R5vdMIkHCcCeGdr57UyuA4/PEarwpuE79FuhzRR
         SInEgOTjZ7aev1Ld4ST2m6D92lSdcDP1GqY58zUbn0KVsSOK5UbrfNGlTHbe2rsTJIxs
         f2EG04hbkNEbJbLHsxUPNqDAN1DuKHVkDelMPO56VFM1q32zpaKMi4EE5rbRZOrfnitC
         NX2GmnEz/wRAaa6Egsd/HP/u8vRzXTS7VRJuJ74kw+FodBLGfSJe1LJyjUtUAoAYZcye
         j5Cw==
X-Gm-Message-State: AOAM5338fiNO9IKP0So4ZunXfXZSABKewUwCtWSYu4ZwA0hWYdVedFL4
        CIgu3xEv0A41UQP1PvrLnmm4apLlC9LaaA==
X-Google-Smtp-Source: ABdhPJyv/+flF6/jxMNhsZKcnRS7vhZ3KkN6W7OEKuhYYhMOOWLuzLlSo2zSYFktvnfYeUvY+hRoDA==
X-Received: by 2002:a02:ad11:: with SMTP id s17mr4440625jan.209.1642176775321;
        Fri, 14 Jan 2022 08:12:55 -0800 (PST)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com. [209.85.166.170])
        by smtp.gmail.com with ESMTPSA id g10sm4771803ilf.46.2022.01.14.08.12.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 08:12:54 -0800 (PST)
Received: by mail-il1-f170.google.com with SMTP id e8so8708076ilm.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 08:12:53 -0800 (PST)
X-Received: by 2002:a05:6e02:2187:: with SMTP id j7mr5036103ila.120.1642176773592;
 Fri, 14 Jan 2022 08:12:53 -0800 (PST)
MIME-Version: 1.0
References: <YeDJKNTYVu/Fe9VS@google.com>
In-Reply-To: <YeDJKNTYVu/Fe9VS@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 14 Jan 2022 08:12:41 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UQdT==0KH+VsWcmHikTpwdDMSTkBa_GXRhXPacwrkR5Q@mail.gmail.com>
Message-ID: <CAD=FV=UQdT==0KH+VsWcmHikTpwdDMSTkBa_GXRhXPacwrkR5Q@mail.gmail.com>
Subject: Re: [PATCH] module: fix signature check failures when using in-kernel decompression
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 13, 2022 at 4:52 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> The new flag MODULE_INIT_COMPRESSED_FILE unintentionally trips check in
> module_sig_check(). The check was supposed to catch case when version
> info or magic was removed from a signed module, making signature
> invalid, but it was coded too broadly and was catching this new flag as
> well.
>
> Change the check to only test the 2 particular flags affecting signature
> validity.
>
> Fixes: b1ae6dc41eaa ("module: add in-kernel support for decompressing")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  kernel/module.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/module.c b/kernel/module.c
> index 201398d58079..24dab046e16c 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -2883,12 +2883,13 @@ static int module_sig_check(struct load_info *info, int flags)
>         const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
>         const char *reason;
>         const void *mod = info->hdr;
> -
> +       bool mangled_module = flags & (MODULE_INIT_IGNORE_MODVERSIONS |
> +                                      MODULE_INIT_IGNORE_VERMAGIC);
>         /*
> -        * Require flags == 0, as a module with version information
> -        * removed is no longer the module that was signed
> +        * Do not allow mangled modules as a module with version information
> +        * removed is no longer the module that was signed.
>          */
> -       if (flags == 0 &&
> +       if (!mangled_module &&

Seems reasonable to me. I guess the only question in my mind is
whether this is the best way to handle "unknown" new flags. If someone
introduces a new flag to "uapi/linux/module.h" should we consider it
as "mangled" or not? Given that I can't predict the future and the
comments seem to indicate that we're only trying to detect
version-related issues, your choice seems OK to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
