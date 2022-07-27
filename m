Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395AA582985
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 17:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbiG0PXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 11:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbiG0PXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 11:23:13 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DBD3205F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 08:23:12 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id sz17so32093122ejc.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 08:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3QoQIcw2k7KJYASXT3ZADS6J+gQkSi9pbz+G9ycdbwU=;
        b=HCbs8iPs9gJhX59IpgPJsCa2fuxs/UEAYiUEkx6VbdfgffAl0JiY0Kl0ovVFN7tKuH
         TBARPeHOi9Fkh83OJhx+l0/TUqfogT7lZ11O4JqeHqfZ5IoFAcw/yLWuF6Ke235el7oO
         Zr8ZOPAxr2g6sjyooHYIN8X8ZwZpJtRbfsTwOjiPJVt89aT5Hq2Ig8kVGTuhn3pijiwJ
         nMs9N0HehNF8gC+hhbxqFCl4uw+yje7AK2GbrG8SNULDXr/MrsOmw+l7xg3dABd1Fh7k
         yazGhqOdZz57nHnLxuiVfsnRmJaWH/D+70indNftdRsODejYRRxqf2MpT95NI+y66PkG
         8+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3QoQIcw2k7KJYASXT3ZADS6J+gQkSi9pbz+G9ycdbwU=;
        b=WvYyJkZFbXV2ZT4YCZlBlkNKjI2Jk0G4omcM99d/RaLDpNz6ghrzMTEOQD8YQQmAzO
         IbcypfyPAa9jVBsBuoq6nKg+/wTogA0BZDQCjxwXlNKIpUpRxYy3V7aSWUvdohZd2oII
         KSlhSklq3XtFc+L4oic/0LpOOhIhDmx+gXD6RMpqdSA3Rms9hqgyVcsC67mncnJem7v0
         WM/Itou+TXEUtpvw0LDQSrzGpL7RjkxZC6RA79I2+0QlswajWH4IxuZpSBHvFhmVXOUI
         O0pdk7awnX35ccM5/gWF8H3m6KhKWSbd9TlfTJhlqgsZDmjCO+9Qx+A6rm3/YSey8xku
         c0fw==
X-Gm-Message-State: AJIora/WIYqjJjuawCRJypfKs6UK0XChEEZZcwl9tTsNAo7FQMj+l8Am
        7NIycJw03yI6LYJ429P0gPnP57nb0OlRuoBUDjg=
X-Google-Smtp-Source: AGRyM1tsUeLUmrPGthGwyhSNHhxQUgBP/qJfxueLK6ioM0y8Wb7Fq8JANC1a+3Fzq9kK8Imtgrks58J9/2IY7PbLYcA=
X-Received: by 2002:a17:907:2723:b0:72b:5af3:5a11 with SMTP id
 d3-20020a170907272300b0072b5af35a11mr17884124ejl.584.1658935391241; Wed, 27
 Jul 2022 08:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220727144249.415228-1-Vijendar.Mukunda@amd.com>
 <CADnq5_PKjmNw+bAPCyDu_G=yNQcpJSpFd+EVzNwfNWzig8apFw@mail.gmail.com> <1031eddb-4cfa-e94a-e77e-03aa3cb8b680@amd.com>
In-Reply-To: <1031eddb-4cfa-e94a-e77e-03aa3cb8b680@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 27 Jul 2022 11:22:59 -0400
Message-ID: <CADnq5_NiaiwHFLeAcjPRvh2gCHvGQ_OJgwMS5jfFvzaZd4GzqQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix i2s_pdata out of bound array access
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
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

On Wed, Jul 27, 2022 at 11:16 AM Mukunda,Vijendar
<vijendar.mukunda@amd.com> wrote:
>
> On 7/27/22 8:25 PM, Alex Deucher wrote:
> > On Wed, Jul 27, 2022 at 10:42 AM Vijendar Mukunda
> > <Vijendar.Mukunda@amd.com> wrote:
> >>
> >> Fixed following Smatch static checker warning:
> >>
> >>     drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c:393 acp_hw_init()
> >>     error: buffer overflow 'i2s_pdata' 3 <= 3
> >>     drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c:396 acp_hw_init()
> >>     error: buffer overflow 'i2s_pdata' 3 <= 3
> >>
> >> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> >> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> >> ---
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 8 --------
> >>  1 file changed, 8 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> >> index bcc7ee02e0fc..6d72355ac492 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> >> @@ -390,14 +390,6 @@ static int acp_hw_init(void *handle)
> >>                 i2s_pdata[2].i2s_reg_comp1 = ACP_BT_COMP1_REG_OFFSET;
> >>                 i2s_pdata[2].i2s_reg_comp2 = ACP_BT_COMP2_REG_OFFSET;
> >>
> >> -               i2s_pdata[3].quirks = DW_I2S_QUIRK_COMP_REG_OFFSET;
> >> -               switch (adev->asic_type) {
> >> -               case CHIP_STONEY:
> >> -                       i2s_pdata[3].quirks |= DW_I2S_QUIRK_16BIT_IDX_OVERRIDE;
> >> -                       break;
> >> -               default:
> >> -                       break;
> >> -               }
> >
> > Is this actually not used or should we just increase the allocation size?
> >
> > Alex
> it's my bad. i2s_pdata array size is 3. when we recently included code
> changes for JD platform , this piece of code was added mistakenly for
> Stoney platform switch case.

Thanks.  Patch is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> --
> Vijendar
>
> >
> >>                 adev->acp.acp_res[0].name = "acp2x_dma";
> >>                 adev->acp.acp_res[0].flags = IORESOURCE_MEM;
> >>                 adev->acp.acp_res[0].start = acp_base;
> >> --
> >> 2.25.1
> >>
>
