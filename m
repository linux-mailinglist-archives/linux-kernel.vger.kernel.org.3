Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29B84DC8B8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbiCQO1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiCQO1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:27:02 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEAE194A80
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 07:25:45 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id d10so11042079eje.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 07:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vckV0ZlF5pMU5EOclP3oYh1APp1+Oy/OTUafdY9W0U0=;
        b=ElG57lX2M22jXW1614RoNU9sFuWlREI++GMdCXHsLsj2BBm34g8Dijq+uyt4VMOqPS
         jIPyiECtHE23o92fQCogKBNeqrdHbXvRmY7juhlGVe2IR9Qpd0vHZRYO41F+cmJpF8vS
         20z9bui8gwU5XmpwKvriWPh70C8sd47qi3nHdOW5EjNMkAOnWhaobCfkxCQhLmw417Gr
         q11yrzxYQBTuNOUk2uVPIu0O8TPpbJRF4UtW3eiWLPSLJvbiPdQjc54izEJOQIa447t6
         SvFmt9LbwzLzyGLpFVXMyoC/Irh7j2MAxnVx9inhaG07T9OG4Q6jwSD1lKI1+Q5sooPQ
         jWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vckV0ZlF5pMU5EOclP3oYh1APp1+Oy/OTUafdY9W0U0=;
        b=hwOsokPl7Nofo/6Azf4bzZbpEQpx5hsA7qXJybaY3+MRYDrs0xzDDm3s3qEd+Upn+9
         dz3Bumu/41eMiPXon+A/UFOcvjgCrvGwfrU4dmrNIKnOfmvsYhIQL1YAN/Q/q0jIq+Tm
         SsxSC80jZ9K8Qm6YjyaicJNWEd6vpfMNP6/YZAV5Qim0aVfvC8Mv04JhJAL8IQIv8q3+
         VOQiYGLm7MM6m8S519kmldOfED7GdwcbK0LExlkQrH2MHektlY/LA4nvK+j4BZTH/5de
         hTgnvJzeXhkmnKVuxe2MVVh9r6wyUMS9zm5Pj2ei2mCnO2aSOKVlmLckKxaKeHl6kZrw
         JAqw==
X-Gm-Message-State: AOAM533qqVSG2mIAo+jkuceaSPbfzqmkxNqhzBHTV8Yf6iMICbijwcHr
        TnlUm7EJZJcwj5t8gsOzGgX+Fp+rMbowfqkFeeSf+Q==
X-Google-Smtp-Source: ABdhPJwhCmmWamgxlR0O80jFQK/ZX8dRZaDWA+kvJU61ovH/1XbdFamrkCJOVBITnnHIsWStuCBud4PeQx2hX8JZYtY=
X-Received: by 2002:a17:906:d554:b0:6df:a6f8:799a with SMTP id
 cr20-20020a170906d55400b006dfa6f8799amr1274844ejc.492.1647527136467; Thu, 17
 Mar 2022 07:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220317140115.541007-1-shraash@google.com>
In-Reply-To: <20220317140115.541007-1-shraash@google.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 17 Mar 2022 07:25:25 -0700
Message-ID: <CABXOdTdGbSDuUepv_MRLYqAfRxB6UPQKP4QGSTmWRUSH3dg6AQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fixed the unused-but-set-variable warning
To:     Aashish Sharma <shraash@google.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
        Jake Wang <haonan.wang2@amd.com>,
        Anson Jacob <Anson.Jacob@amd.com>,
        Guenter Roeck <groeck@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Anthony Koo <Anthony.Koo@amd.com>,
        Wayne Lin <wayne.lin@amd.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
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

On Thu, Mar 17, 2022 at 7:01 AM Aashish Sharma <shraash@google.com> wrote:
>
> Fixed this kernel test robot warning:
>
> drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:2893:12:
> warning: variable 'temp' set but not used [-Wunused-but-set-variable]
>
> Replaced the assignment to the unused temp variable with READ_ONCE()
> macro to flush the writes.
>
> Signed-off-by: Aashish Sharma <shraash@google.com>
> ---
>  drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> index 873ecd04e01d..b7981a781701 100644
> --- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> +++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> @@ -2913,13 +2913,12 @@ static inline void dmub_rb_flush_pending(const struct dmub_rb *rb)
>         uint32_t wptr = rb->wrpt;
>
>         while (rptr != wptr) {
> -               uint64_t volatile *data = (uint64_t volatile *)((uint8_t *)(rb->base_address) + rptr);
> +               uint64_t *data = (uint64_t volatile *)((uint8_t *)(rb->base_address) + rptr);

also drop the volatile in the typecast

>                 //uint64_t volatile *p = (uint64_t volatile *)data;

The above commented out code serves no purpose and should be removed as well.

Thanks,
Guenter

> -               uint64_t temp;
>                 uint8_t i;
>
>                 for (i = 0; i < DMUB_RB_CMD_SIZE / sizeof(uint64_t); i++)
> -                       temp = *data++;
> +                       (void)READ_ONCE(*data++);
>
>                 rptr += DMUB_RB_CMD_SIZE;
>                 if (rptr >= rb->capacity)
> --
> 2.35.1.723.g4982287a31-goog
>
