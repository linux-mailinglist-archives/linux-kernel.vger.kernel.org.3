Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81C052AD15
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 22:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353109AbiEQUyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 16:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353060AbiEQUyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 16:54:32 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57868532D8
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 13:54:23 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id y63so301897oia.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 13:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=esDt/ygm4WEDZW7NMBdetNiik4xOkEth8NzDieBlCmM=;
        b=gKPmFVts67I2YaFCueBVBPv+QGDtrzBVPTDht4HFOb5YFVrVAJavab1X62rwiHplrN
         VncmnllGh57N9jrTzqfTqGc5yIPFpxPnljl/ZjIipTZTdtqC6C8zpFQf2s/qjCk33CJh
         8k12YFzRsrSu6fZp+UzNMxc9epUCkGnAnpBfTrytYfRjNFrn2EIHyS7UU++CwnQR70OU
         sM7VXfNgZZqhxwygU9E0tuwvWtOec/6A9sb7cgHCJaEOhxl/SScAbGLsrSIebHComKlX
         lnRhLgoCnY+rfY3t9H2mEbFQWJc1L0KeLSTYt9Kho1f4lacmL2xHeR2LD7E3OuxKacqq
         A2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=esDt/ygm4WEDZW7NMBdetNiik4xOkEth8NzDieBlCmM=;
        b=bgeEwoVgR9SBga12DIhsmKUVmJRgkLhEgXPGDf+hPxPWyU8YjzWJ64x15TpCwEUMiA
         6sbIoo8CUdCvriOpO2KEl9VRGgVtMVnBfm0w6aRmH72a3u/s2XUWQuyM0quGyHTvWKtE
         uAEAd7oPrfyblAtQhX+9n7j8/K35ivHw5WNbG8y8xRCvaH8wTXoXxJbh7JSdDaFBd4Ok
         nthtG2svU1XbohoSTjZf/+TYLFDKlrlC4EJn67eVMc6n4BrKLkD0dxTfRVamO9ddAonE
         0F+i58YwwmJARcVS4NY0dWVAT0cNJWfgZMsnhs8yPA68MXT6HQVk25XeTgcFxk4LF5vr
         t5sQ==
X-Gm-Message-State: AOAM533KhqkJdMFi2gfSHPOSRWl+cQadPzilZLQwpjl/l7D2GvNj1w57
        qXMUlv4x0w4vlP2yHEkiQJZX46odGuP23XtKZrVtX+DG
X-Google-Smtp-Source: ABdhPJw5kDEeaiSUetF9RsHYAT9bdeIQ0xtHtRebB/nPLWv2c7rooin4F070ALFh4+gFNaanpLJlsuw6NgGTUnO/ZC4=
X-Received: by 2002:a05:6808:f8e:b0:328:a601:a425 with SMTP id
 o14-20020a0568080f8e00b00328a601a425mr12159725oiw.253.1652820862717; Tue, 17
 May 2022 13:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220517095700.7291-1-ruc_gongyuanjun@163.com>
In-Reply-To: <20220517095700.7291-1-ruc_gongyuanjun@163.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 17 May 2022 16:54:11 -0400
Message-ID: <CADnq5_MM7pV-yXRdqRsqoWOugOF8SjXgvksXWoot5W+VkLeAGw@mail.gmail.com>
Subject: Re: [PATCH 1/1] radeon: fix a possible null pointer dereference
To:     Yuanjun Gong <ruc_gongyuanjun@163.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
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

On Tue, May 17, 2022 at 9:13 AM Yuanjun Gong <ruc_gongyuanjun@163.com> wrote:
>
> From: Gong Yuanjun <ruc_gongyuanjun@163.com>
>
> In radeon_fp_native_mode(), the return value of drm_mode_duplicate()
> is assigned to mode, which will lead to a NULL pointer dereference
> on failure of drm_mode_duplicate(). Add a check to avoid npd.
>
> The failure status of drm_cvt_mode() on the other path is checked too.
>
> Signed-off-by: Gong Yuanjun <ruc_gongyuanjun@163.com>
> ---
>  drivers/gpu/drm/radeon/radeon_connectors.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
> index 0cb1345c6ba4..fabe4f4ca124 100644
> --- a/drivers/gpu/drm/radeon/radeon_connectors.c
> +++ b/drivers/gpu/drm/radeon/radeon_connectors.c
> @@ -473,6 +473,8 @@ static struct drm_display_mode *radeon_fp_native_mode(struct drm_encoder *encode
>             native_mode->vdisplay != 0 &&
>             native_mode->clock != 0) {
>                 mode = drm_mode_duplicate(dev, native_mode);
> +               if (!mode)
> +                       return NULL;
>                 mode->type = DRM_MODE_TYPE_PREFERRED | DRM_MODE_TYPE_DRIVER;
>                 drm_mode_set_name(mode);
>
> @@ -487,6 +489,8 @@ static struct drm_display_mode *radeon_fp_native_mode(struct drm_encoder *encode
>                  * simpler.
>                  */
>                 mode = drm_cvt_mode(dev, native_mode->hdisplay, native_mode->vdisplay, 60, true, false, false);
> +               if (!mode)
> +                       return NULL;
>                 mode->type = DRM_MODE_TYPE_PREFERRED | DRM_MODE_TYPE_DRIVER;
>                 DRM_DEBUG_KMS("Adding cvt approximation of native panel mode %s\n", mode->name);
>         }
> --
> 2.17.1
>
