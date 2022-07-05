Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CFC567223
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiGEPKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiGEPJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:09:56 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484F7192B4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:08:03 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id g26so22170136ejb.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 08:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yUHKUShGAQP2s0iIm1zksJJpl/lyBcXlcuW/RNUcNOw=;
        b=IDDc7PbjlYsmcvapnMmOnTjbeWHQyiWvbpdubYiGv6GHn3wNXZw1SHsS26wKxR3lwK
         oD3T+GoCb0yTNmS+JT6WPxmg+gsNdf4D7eksw27wxHyEiQ7khLHq3dAmWRVk9KuUSwqa
         rziB77pfJPJKFjhFQuVIveMEvxy/7CKEGEntEfmHTnmv5h1WjyOsOYS8pJF9Lmw33gGb
         /QhsVPZHm+YUnJ2z0Ob6TuuDxd51yGJWszDdkBkSyRoAWk3diP6G+4QDBOA5vZZB7vT9
         zgi5XWaMKddZnBOmLB4yERgvna6wUF/FILWLaKbd3/hjYH+qpYcBn1llfAux1LZmpDNA
         NAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yUHKUShGAQP2s0iIm1zksJJpl/lyBcXlcuW/RNUcNOw=;
        b=EGdyf1H7kh7hrDPB59WlQBqavZIaOvvuWbheogJtddD28tjo24ViXe5k4twN/Y2cu9
         kzTDXJE2Jok/0xgQMZfekql9uSzHm4L8WFPa8QoqJO+nOzBYgfW+62aXMLtYXGVZRmC1
         7NEMYk7s7A/kFMeKKdL6FQT5r18Er6rlBfluZ2GjFc17ar5aVVFCXcMhfUlr6HyVuBFt
         cd17V6d2cIjRvLWo2VzJSyFCbc1u6Vu7oxnHMRL3zkwPYo7D4Q73r8088pdPvXYEI1JG
         lQ84EW3F2gubXsHD8hkb1n5VQg8DlpxCIm1Hd2hHMd1NHjhYCWVc0fvbuD0OcfFrXpoD
         s4QA==
X-Gm-Message-State: AJIora/2iMvIamBriqKCTD6L59kdGsXyxLDSo3sdS2Ps1pRbHUQl8/sm
        E2OX/Ev9XJfdDIUeu3e5YVitdqVy+Yx20pO9qbs=
X-Google-Smtp-Source: AGRyM1s+vm1yrGPFkRTzyEnJsJBVgVgLOikAVgvDRDQD3cUHQg60f6JD//PitFt+3o++hjcOjP1u/C54mVfPllNIJmc=
X-Received: by 2002:a17:906:dc93:b0:726:a75b:f60f with SMTP id
 cs19-20020a170906dc9300b00726a75bf60fmr33893933ejc.564.1657033681853; Tue, 05
 Jul 2022 08:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220705134603.2248455-1-niejianglei2021@163.com>
In-Reply-To: <20220705134603.2248455-1-niejianglei2021@163.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 5 Jul 2022 11:07:49 -0400
Message-ID: <CADnq5_P7Ojd8beMqZ-N9EJJV9eONJVXMpaSGQt=PC9YXJ_FmHQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/mes: Fix an error handling path in amdgpu_mes_self_test()
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Jack Xiao <Jack.Xiao@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        "Joshi, Mukul" <mukul.joshi@amd.com>,
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

On Tue, Jul 5, 2022 at 9:46 AM Jianglei Nie <niejianglei2021@163.com> wrote:
>
> if amdgpu_mes_ctx_alloc_meta_data() fails, we should call amdgpu_vm_fini()
> to handle amdgpu_vm_init().
>
> Add a new lable before amdgpu_vm_init() and goto this lable when
> amdgpu_mes_ctx_alloc_meta_data() fails.
>
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 69a70a0aaed9..7c196b8ac49f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -1157,7 +1157,7 @@ int amdgpu_mes_self_test(struct amdgpu_device *adev)
>         r = amdgpu_mes_ctx_alloc_meta_data(adev, &ctx_data);
>         if (r) {
>                 DRM_ERROR("failed to alloc ctx meta data\n");
> -               goto error_pasid;
> +               goto error_fini;
>         }
>
>         ctx_data.meta_data_gpu_addr = AMDGPU_VA_RESERVED_SIZE;
> @@ -1215,6 +1215,8 @@ int amdgpu_mes_self_test(struct amdgpu_device *adev)
>         BUG_ON(amdgpu_bo_reserve(ctx_data.meta_data_obj, true));
>         amdgpu_vm_bo_del(adev, ctx_data.meta_data_va);
>         amdgpu_bo_unreserve(ctx_data.meta_data_obj);
> +
> +error_fini:
>         amdgpu_vm_fini(adev, vm);
>
>  error_pasid:
> --
> 2.25.1
>
