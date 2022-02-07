Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A8F4AC9DB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 20:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240719AbiBGTr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 14:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240575AbiBGTpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 14:45:08 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDA6C0401E0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 11:45:07 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id u7so19687180lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 11:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lZDpDADdfwq40jZPbE/sznh7Bnymle3eu2MsiKyAnHI=;
        b=BdiDafPxAfgT1LadX6/qdSNo8n3l0Xa/GtCJEktDJMXEmp52SrE42F60zh+yNtgnej
         uafnZUT8MJqOawyMYksVSqsD8w5zXATUGodDDaf2n0OSYIP77vOHkN1WwPFv0stLOa78
         +4ATpfopW4dS5hdH2p54SyosNF1m7zjr8r+2YE4GWs0neqc92bzF3dIJD7hE8cA0PJPs
         kQu1XjE348Lq3znmdTjfrSq9FD04iuxmobdD48LoM7k4xW51/uiPDMkZVxL359FVEki8
         6hN3NzqdifRAShPzrX73QDVc8Pe4IH8JQaohdbJyNHzgPOa0p/tQFkgSdDhkiO0KiTmj
         Kknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZDpDADdfwq40jZPbE/sznh7Bnymle3eu2MsiKyAnHI=;
        b=7oGjJUIgFQyAcTPDXBuQpO1x+0P+4hMCtzxw6thuD+eNwkrKma++Uo5lX5QB9HjMwJ
         a/UHy+llEnqUcHmmvvJ2NGMiSb78KhmS7iJYQOJ6drf6GFeHiR38CWa059p+LXOhy81W
         eFjMSnJAOpchJurpkOvWmhr73YAqa/jVLZpZR8knAwUwavAHRLcEoZNWYSqkM5ZZGD5w
         UMixDNpH4C8qPbG1BiAsDrIR3F0nwcyadgIbGsGOappwqfhsqT3wzUIdjTjLgx1rRjqn
         KoVMWH7YGnFaMCCGKKUzqapGd/ge56WJuz1BovoQ7tm84/Jk3AF1RrCaFMcxdobkgGji
         qwjA==
X-Gm-Message-State: AOAM532VnRiJS2Y9hZEQn7F9Ddkmz2Ss6QRuYEBg/3gWC5Ul9p68LlQb
        WZHUuv4fKw7j9AXMxjhmNFur1jt1FbYF7lL623wc5A==
X-Google-Smtp-Source: ABdhPJwv1WF2F6ndc/bGUuNT+neSxWAOv6iXkCytc6pktYWRpfycPf6E/KpzZmQrd8aUu/NlJ8No19+iCvFMptVtXu4=
X-Received: by 2002:a2e:7c0c:: with SMTP id x12mr648215ljc.526.1644263105665;
 Mon, 07 Feb 2022 11:45:05 -0800 (PST)
MIME-Version: 1.0
References: <20220207165304.1046867-1-nathan@kernel.org>
In-Reply-To: <20220207165304.1046867-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 7 Feb 2022 11:44:53 -0800
Message-ID: <CAKwvOdkXe8CB3QGe2e6Fhz8_SLOsOpcMumoKBiAzGE_VTXCkVg@mail.gmail.com>
Subject: Re: [PATCH] drm/stm: Avoid using val uninitialized in ltdc_set_ycbcr_config()
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        dri-devel@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
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

On Mon, Feb 7, 2022 at 8:53 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Clang warns:
>
>   drivers/gpu/drm/stm/ltdc.c:625:2: warning: variable 'val' is used uninitialized whenever switch default is taken [-Wsometimes-uninitialized]
>           default:
>           ^~~~~~~
>   drivers/gpu/drm/stm/ltdc.c:635:2: note: uninitialized use occurs here
>           val |= LxPCR_YCEN;
>           ^~~
>   drivers/gpu/drm/stm/ltdc.c:600:9: note: initialize the variable 'val' to silence this warning
>           u32 val;
>                  ^
>                   = 0
>   1 warning generated.
>
> Use a return instead of break in the default case to fix the warning.
> Add an error message so that this return is not silent, which could hide
> issues in the future.
>
> Fixes: 484e72d3146b ("drm/stm: ltdc: add support of ycbcr pixel formats")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1575
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/gpu/drm/stm/ltdc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> index 5eeb32c9c9ce..447ddde1786c 100644
> --- a/drivers/gpu/drm/stm/ltdc.c
> +++ b/drivers/gpu/drm/stm/ltdc.c
> @@ -624,7 +624,8 @@ static inline void ltdc_set_ycbcr_config(struct drm_plane *plane, u32 drm_pix_fm
>                 break;
>         default:
>                 /* RGB or not a YCbCr supported format */
> -               break;
> +               drm_err(plane->dev, "Unsupported pixel format: %u\n", drm_pix_fmt);

This is fine, but in the future you should add an explicit
#include <drm/drm_print.h>
to avoid implicit header dependencies (like the ones that Mingo is
trying to detangle) for the declaration of drm_err. `drm_vprintf`
needs it, too.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> +               return;
>         }
>
>         /* Enable limited range */
>
> base-commit: 542898c5aa5c6a3179dffb1d1606884a63f75fed
> --
> 2.35.1
>


-- 
Thanks,
~Nick Desaulniers
