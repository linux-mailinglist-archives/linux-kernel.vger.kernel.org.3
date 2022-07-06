Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9868D568E5C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 17:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbiGFPv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 11:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbiGFPvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 11:51:05 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856C62A268
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 08:48:48 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z41so19853103ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 08:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=00PsEcFRen9hQVc5J36/2xhprKBUXZ2hnp6jcmTfM4w=;
        b=pNXn7TgzsCEm/pHTxWSPmtbN7IRdsA9BW/X0mOqzxpyXhEA83+pdsT0vK29YfnciIQ
         sZ7V6TIXe/zoYx9KLNvKLtd5mGEK3p3q+Z3kMnAhD8AzjDq9gN0PQm728q5MCwLsu7ML
         J/AI2PFIVxVzc9uuCMchCNxUPl3BVwMspju1Bv4nqXFyOx43M3rMxFvoA5GxyPvUWtJz
         7w5N5xmC+jmUslNTsEhsXfFXgzK3GZ6fHqpqQRyx5McVPFA0gkOopSPmfHRJ4vg8UiPT
         n9Vu97o6JYGYb40mNuiO+byqZjVJ/M97EqRyK90BwycxBN+CoIyvrotwsI0kxRDLb05O
         uTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=00PsEcFRen9hQVc5J36/2xhprKBUXZ2hnp6jcmTfM4w=;
        b=CcmQPUcYxXJMdTVxIEbY3A/i5mkO5hhfJsK2lTPgz9bThrfmmcu8Zi5SgbKVZiw14Q
         E/V3e2x0CpCotnSTPuniDeSYuQPHutDynVH4J5lcOmTkX1NCnP3dqrOr62QfHkzsCK5q
         diAnPQ5EUUyPQwqB4zSXaedSihqpsL/Pg5sEopOY9LSFM3uUIgwW+GSIuJ/O+zqH+i5P
         SXel6fniPp9ic/KNM92H66aO5CEp41/9fvi7KfPGff2Uu1fPFdLN8BHTC9lAlc1bFLBX
         cQPM7szcRaEdlp1ufgYjEFp9MYiu0zrh5j23lG3ar9skmSXYVrmoYVfAj17br6M2XOY8
         OmNA==
X-Gm-Message-State: AJIora8ZtgV/juaJ1eL1CVUZt3hoT9Oca/a8KBUWxsFODNZEwi/VQJZ/
        5SWsR/XjGG2rab73JQl4XRcplqW1YWnJx+HOMuQ=
X-Google-Smtp-Source: AGRyM1tB0NAdoSnEuojTwit1peoREjx9nSZ+7zzDEGX3zBIahqBsrEIZ7Ikq39RHS0L39MfpGQKW8Vs4aGbTClM6clQ=
X-Received: by 2002:a05:6402:28c3:b0:43a:6d78:1b64 with SMTP id
 ef3-20020a05640228c300b0043a6d781b64mr19326670edb.93.1657122527099; Wed, 06
 Jul 2022 08:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220706045712.19930-1-hbut_tan@163.com>
In-Reply-To: <20220706045712.19930-1-hbut_tan@163.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 6 Jul 2022 11:48:35 -0400
Message-ID: <CADnq5_MjpC988eDN8ODb_Lg5n1uLexWyQKEu=B+Cc0bRgvhAxQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: Remove duplicated argument to ||
To:     Zhongjun Tan <hbut_tan@163.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chandan Vurdigere Nataraj <chandan.vurdigerenataraj@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Zhongjun Tan <tanzhongjun@coolpad.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Wed, Jul 6, 2022 at 3:41 AM Zhongjun Tan <hbut_tan@163.com> wrote:
>
> From: Zhongjun Tan <tanzhongjun@coolpad.com>
>
> Remove duplicated argument to ||
>
> Signed-off-by: Zhongjun Tan <tanzhongjun@coolpad.com>
> ---
>  .../gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
> index 07f3a85f8edf..5a701d9df0f7 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
> @@ -275,7 +275,7 @@ void dml32_CalculateBytePerPixelAndBlockSizes(
>                 *BytePerPixelDETC = 0;
>                 *BytePerPixelY = 4;
>                 *BytePerPixelC = 0;
> -       } else if (SourcePixelFormat == dm_444_16 || SourcePixelFormat == dm_444_16) {
> +       } else if (SourcePixelFormat == dm_444_16) {
>                 *BytePerPixelDETY = 2;
>                 *BytePerPixelDETC = 0;
>                 *BytePerPixelY = 2;
> --
> 2.29.0
>
