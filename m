Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771AA5A162E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 17:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242846AbiHYP4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 11:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiHYP4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 11:56:30 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7A0AF4A1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 08:56:29 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id d12-20020a4aeb8c000000b004214e709b72so3497868ooj.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 08:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=2sx4/x621XjoOsAHsYvDRl4ejxU/tu33VcZX+qjgFuQ=;
        b=KNWI5qktF53AcillC2DCSWiSMqu5KKXeO611Cnlmb4y/p2HS/c9jInbRFwKBO5jQeo
         Y7897V7lMQH+5NADak9NVGSSLmZnKXjmw26GGfmBojo8/tPEaKuNbg0Dwrh4AQxEV743
         P4z9zEcmbJd+6MWh5l0VcTQqjvz/FMhSCXUVl8hUzj5ydVTx6jJWUoe1MAB9xm8aCCil
         73i/2UHIWsCXSNvpAZh1nI+IQ+J4MjSuje6h6/CXhMoyYzIjUq7SPvclAAZ1fRPuMrxC
         5MqsqtyOjdTvsuE0Sc3NNZ2l4JDf0F2xvYO7vDwxwyJusTfxvptmJEUY21rQkzF6U2Kn
         vPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=2sx4/x621XjoOsAHsYvDRl4ejxU/tu33VcZX+qjgFuQ=;
        b=8CQtlzMBJ7JJ5jr1yiqFcP+i6UQYzcGdnAU6JGn3XEQ+TtRALHCox/YdleB6pYQnst
         X95pqmO0r9lb2MtGuQzJujo+tJwsCa/AONsldT1VnOBrWco5JmyporxPr8sY7zu3xhWJ
         xIvTSlVXlKmBVvqjt3w358Q4Co72T4s96D65e8MezUY7vCc7QVN8T0BMYxMT6Z8rkYf1
         naPiUVit+qvfYjP5rWirFTPVYtDSobXplMZZza9D7PM5zfz6MPJVJiiqycaDto21+Z2C
         2VGVpe3Nzxn4HXA7SE1VFYgSivZ8uFowyPAnKhU57a267CcEbyrDgUXSfjU4HgiNemPz
         VOxA==
X-Gm-Message-State: ACgBeo0fTYgAmgRJghGoOXeNmQ+KSdeE+49YljGnkSBoz1aW4qfPfxZ7
        trxiokA5CkYYhV4otCfSktAj3cgPEFkeh0zekXLAKK3O
X-Google-Smtp-Source: AA6agR5GJTWv75t/YXIQTurxidXrwhktIW4TYORHY2v/FTLgQ5T+umce8C8KJ7FiylZz0JPLtVPXAHBMCboopaV7+Ic=
X-Received: by 2002:a4a:aa81:0:b0:44a:da30:274e with SMTP id
 d1-20020a4aaa81000000b0044ada30274emr1512269oon.97.1661442988766; Thu, 25 Aug
 2022 08:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220823064406.1874-1-jinsdb@126.com>
In-Reply-To: <20220823064406.1874-1-jinsdb@126.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 25 Aug 2022 11:56:17 -0400
Message-ID: <CADnq5_OZUX0UBOzQyQDi_oFQK1Pgno4sFrmV2FdA+a+2NiaSyA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: mmVM_L2_CNTL3 register not initialized correctly
To:     jinsdb@126.com
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

Alex

On Tue, Aug 23, 2022 at 3:15 AM <jinsdb@126.com> wrote:
>
> From: Qu Huang <jinsdb@126.com>
>
> The mmVM_L2_CNTL3 register is not assigned an initial value
>
> Signed-off-by: Qu Huang <jinsdb@126.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> index 1da2ec692057e..b8a987a032a8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> @@ -176,6 +176,7 @@ static void mmhub_v1_0_init_cache_regs(struct amdgpu_device *adev)
>         tmp = REG_SET_FIELD(tmp, VM_L2_CNTL2, INVALIDATE_L2_CACHE, 1);
>         WREG32_SOC15(MMHUB, 0, mmVM_L2_CNTL2, tmp);
>
> +       tmp = mmVM_L2_CNTL3_DEFAULT;
>         if (adev->gmc.translate_further) {
>                 tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3, BANK_SELECT, 12);
>                 tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3,
> --
> 2.31.1
>
