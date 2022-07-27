Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD73558291D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 16:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbiG0Oz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 10:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiG0Oz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 10:55:26 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893D3659A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:55:25 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id m8so21702886edd.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WrAxAwQvWkNvn9iTR8AvgTpHQwZ7heaV6m22/yIWhK0=;
        b=Q0T1JN9hd9Oi1QPMQUOoi3FKjamneDsM2FMlfalCMAcLaxJrnG/um/ftBNacBz+jY4
         1VD4bzLO2cYhyiAQ0hGYxcoEmPSbJw6SoOE4DzNGODp0C92jX+77TLJ37R6bT5uUKkZh
         VdmRqYiGh/Ghe070Tad3H67U+plMcZ3BBjwC7GZDNnyv4ycuy7hZoq0IMRGOeYVqm1bm
         VuQCxIUUP9aa7EQCyOA1tXxfxUw/VbPmbo/415UyjDE6Y8XBXRbvEUS8whW4nG3sf684
         a3lKhKnVEoTlndTbusm9wbRzg0wgziQ1lnW1C+cSOzyggWIV4QjrcHzuZ1XSSSbG8CRB
         3FJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WrAxAwQvWkNvn9iTR8AvgTpHQwZ7heaV6m22/yIWhK0=;
        b=PYbdBg1KPbiX16E//Hha4taubGK1ZpAAj5lzH67CkqH32p8toG+Olq2v+bENhrrsc2
         JRrV1cF/klWESmzuZUkbtcA/TYJDJVzau2339se0zdhH5QJK8B2TElTqWCvbIrtFPIMI
         JvrGYf0gJR1tScede/Po+4XHbqAaMydyybeJAMtj0CxNsCVSs5fAxPubhhT9mbAqKVT4
         bHdASyg08nExwMa6WNcyjdRx+MpW+CrRQtwwvd6mEFPMEFXY+CNw+xCcW0RwP112zvTy
         Hq7TvgDpp4VuBvdxFevA4z7KHyy/8wP+anFU0tb8xuwqWBGhKMXmjc5mAJU5rDJDmWUY
         fLWw==
X-Gm-Message-State: AJIora9KLNfjDEkkq4HtAHJJLjq7bVBUSejL4MRAosPI+I8l+b1IrT0J
        yPPW5Oknmqroyb6EHTlv079ZXUsBPCn1byxNGoQ=
X-Google-Smtp-Source: AGRyM1v0BqXlMXy1WlRwkM9yfv7uDOAHmzaEtW9pVP6NfvUnezvmE61b1xrJzvro6l2dJmmnl6FJVKd2IeFoCa5Tpew=
X-Received: by 2002:a05:6402:500e:b0:43b:6f0:756b with SMTP id
 p14-20020a056402500e00b0043b06f0756bmr24034075eda.221.1658933724075; Wed, 27
 Jul 2022 07:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220727144249.415228-1-Vijendar.Mukunda@amd.com>
In-Reply-To: <20220727144249.415228-1-Vijendar.Mukunda@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 27 Jul 2022 10:55:12 -0400
Message-ID: <CADnq5_PKjmNw+bAPCyDu_G=yNQcpJSpFd+EVzNwfNWzig8apFw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix i2s_pdata out of bound array access
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Sunil-kumar.Dommati@amd.com, David Airlie <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        dan.carpenter@oracle.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 10:42 AM Vijendar Mukunda
<Vijendar.Mukunda@amd.com> wrote:
>
> Fixed following Smatch static checker warning:
>
>     drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c:393 acp_hw_init()
>     error: buffer overflow 'i2s_pdata' 3 <= 3
>     drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c:396 acp_hw_init()
>     error: buffer overflow 'i2s_pdata' 3 <= 3
>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> index bcc7ee02e0fc..6d72355ac492 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> @@ -390,14 +390,6 @@ static int acp_hw_init(void *handle)
>                 i2s_pdata[2].i2s_reg_comp1 = ACP_BT_COMP1_REG_OFFSET;
>                 i2s_pdata[2].i2s_reg_comp2 = ACP_BT_COMP2_REG_OFFSET;
>
> -               i2s_pdata[3].quirks = DW_I2S_QUIRK_COMP_REG_OFFSET;
> -               switch (adev->asic_type) {
> -               case CHIP_STONEY:
> -                       i2s_pdata[3].quirks |= DW_I2S_QUIRK_16BIT_IDX_OVERRIDE;
> -                       break;
> -               default:
> -                       break;
> -               }

Is this actually not used or should we just increase the allocation size?

Alex

>                 adev->acp.acp_res[0].name = "acp2x_dma";
>                 adev->acp.acp_res[0].flags = IORESOURCE_MEM;
>                 adev->acp.acp_res[0].start = acp_base;
> --
> 2.25.1
>
