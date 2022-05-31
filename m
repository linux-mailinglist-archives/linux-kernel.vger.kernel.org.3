Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8C4539895
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 23:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347952AbiEaVVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 17:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237276AbiEaVVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 17:21:20 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74447035C
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 14:21:19 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id l9-20020a056830268900b006054381dd35so10451282otu.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 14:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=14I4UbwyvZc+eD1HbI5WSSoBcqZsYR0nCVcYOj4jF60=;
        b=e7xa2Dm/2h8eDTqriJXBMxIHmSbFZQ0dfVMW+2BL/ayhYBc8NQ6aVx9kfSTr2zW70D
         oK1GrCmhwwuCeeQC8incazQBla0C69caxYTNAKSqgANXCsni8+ZfbMYBcmDRId9Y5buJ
         5+y54PaJsZWyuP79FKE6tkFJaJVPrjvgLObCER5jsxb5o8RkU/r+ybMPSLHV9I3DmpzX
         RYwS+02PrTfn7YVXEJtipC9fMJyYImombjbBGbO1I8NW7JEwj+kH8PtZopqGBINM+hiC
         o6vEm7lTiI5hFxiH8fn9N+5GAbo4xwITjBKVoktqbwE9UcNDHGLTrCZAIWfuWPSp0fmi
         EryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=14I4UbwyvZc+eD1HbI5WSSoBcqZsYR0nCVcYOj4jF60=;
        b=3PeCRyFGB+Pmq8Tc9tyGlHQeSOvQywhe3tz1MHSAWiHfCIDaq2Jbns4ecdNL45Y6gW
         IV6e+cOtGjQeLm4zkicU8fmO4lZt7L2TZN7h1B5qiaaCL3+WqE867xMYTesVHp97ueYw
         Cpw499LJTC1WBb8souMRJHn3qpXVr2h9h/0T0rZbBPh+Zsqdca/HLqPzRZ/AE/Waw6Wq
         l+VZGv19lk1PInNrCMfJkhegYDoIwsFGS6ZQGG6+g7gGUwdpy9M4fVErC6lY3+TU/qmc
         BBAvS/SGHSxiq+qUoAYwEQAM78q7bXhn9JtJV0X4OPIGRpqrDy3Z8APtY3t5By6hV9HO
         DJrg==
X-Gm-Message-State: AOAM533lYVOeUE4nbHbx5d0aeG06+FooEOJItAQejuHLYyhf+Qr1pylc
        fGA+PqiZOiV1QpngkS16p/hnwCd6c3RkrGMFLEw=
X-Google-Smtp-Source: ABdhPJzoiG6lzp/Tvqt7hr1KyobU2ARwVzpPJeRBzYnmjIuTVY5TGAlERknSQVvMUgKTUfqVxToltdvmzLsIg8Sbx6c=
X-Received: by 2002:a9d:6b98:0:b0:60b:c54:e22b with SMTP id
 b24-20020a9d6b98000000b0060b0c54e22bmr18169628otq.357.1654032079055; Tue, 31
 May 2022 14:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220529072631.307922-1-sunliming@kylinos.cn>
In-Reply-To: <20220529072631.307922-1-sunliming@kylinos.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 31 May 2022 17:21:08 -0400
Message-ID: <CADnq5_Np4BrKwgV1ti2xxGS4k5XeWGc0+URuaibNmQxH3Ro5QQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix a missing break in gfx_v11_0_handle_priv_fault
To:     sunliming <sunliming@kylinos.cn>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        hristian.koenig@amd.com, xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Mike Lothian <mike@fireburn.co.uk>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        "Quan, Evan" <evan.quan@amd.com>,
        kernel test robot <lkp@intel.com>, kelulanainsley@gmail.com,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
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

On Sun, May 29, 2022 at 7:50 AM sunliming <sunliming@kylinos.cn> wrote:
>
> Fixes the following w1 warning:
>
> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:5873:2: warning: unannotated
> fall-through between switch labels [-Wimplicit-fallthrough].
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: sunliming <sunliming@kylinos.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index cb581cfc7464..628d3536938e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6028,6 +6028,7 @@ static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
>                 break;
>         default:
>                 BUG();
> +               break;
>         }
>  }
>
> --
> 2.25.1
>
