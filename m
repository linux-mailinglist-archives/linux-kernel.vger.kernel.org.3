Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE2A471AF3
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 15:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhLLOua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 09:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhLLOu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 09:50:29 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073ABC061714;
        Sun, 12 Dec 2021 06:50:29 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id z8so20305709ljz.9;
        Sun, 12 Dec 2021 06:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ozulntsIRFIf7sG1Mn+ueuvrGY7+eE7tUHdbtMSCB9g=;
        b=Hoq8ZZIHwuGXKF5mMDSZWJx38WYaCg0jCTclOkhJ+RQWRB4awXwJBI9lh4rA0B/g5X
         53ZjdPLF9kLrAagsXMfALHMm1/xuuq1UFVMPWkFJgqoVKtPRH5dKIyCnF++bJXQAy1ni
         DgXLR3G4QrQlBDYlra3e/WevuzXx9HgDTtl+d8edT49kXinDrKqCDjQ1gjysMATkePZ1
         9C40innq+rXLs+m+ucof1hoE6uRip3mzePiZ+rtI59vLyyNpsPNf19ew/Tw2YJyiutwu
         BRtB0N1w8Rz40cmKtnAi6TcbcI4L+K/fXvUmCE4mIFdbp3bjeU/uk9ECteGDgb+8YnLq
         Vq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ozulntsIRFIf7sG1Mn+ueuvrGY7+eE7tUHdbtMSCB9g=;
        b=4i19ereJKMQ4WqnAMTJ7/EB2eTepiKzLJMqfaOGMe7Wb+MmHiCkkchMcPpnd5VCMxJ
         7C1vcJwqu8t63V1sVJcSDYQL69mbXMK6SqYtRTb1YuK24K0Ca4paRYJ76myYWnjDI2Xi
         jSnv8JoqGvx4LvNKVvp4/A3EL+j12NL/aXfCjrgroEfyIJ4d8WcbL6D6axQxY5rV1L0/
         Cwx/yLylxLmx5lgYyA89bZ0uMvM9T7qwCttZmf9xcoMe75LIaQxSfy1sxXNZ9e/2+v3W
         PFDztTMVANc3mj2vNy0QM17kyvWb8lW5M852vHd1WhkLZa0D5/RmcbQDrwB3heqZnXF0
         M/lw==
X-Gm-Message-State: AOAM530zBWOOaO5z+Uj7zkenx3xrPKkS8E17qrpYqChkaFebQwdYcXnZ
        Y6mKsimXmgwml3J2iHvuRaU=
X-Google-Smtp-Source: ABdhPJwoafQFUVY+djjccyUhfv7DafXubgwpmptr1qgVov/hkWyUUTEysjel7p0dkbhRyA9avC1xyQ==
X-Received: by 2002:a05:651c:50c:: with SMTP id o12mr25271211ljp.88.1639320627344;
        Sun, 12 Dec 2021 06:50:27 -0800 (PST)
Received: from trashcan (public-nat-10.vpngate.v4.open.ad.jp. [219.100.37.242])
        by smtp.gmail.com with ESMTPSA id e21sm192075lfc.229.2021.12.12.06.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 06:50:26 -0800 (PST)
Date:   Sun, 12 Dec 2021 14:16:01 +0000
From:   Vladimir Lypak <vladimir.lypak@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Kristian H. Kristensen" <hoegsberg@google.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/a5xx: Add support for Adreno 506 GPU
Message-ID: <YbYEIcBSXK9Z0uun@trashcan>
References: <20211022114349.102552-1-vladimir.lypak@gmail.com>
 <YXL16V17upehvUwt@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXL16V17upehvUwt@ripper>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 10:33:29AM -0700, Bjorn Andersson wrote:
> On Fri 22 Oct 04:43 PDT 2021, Vladimir Lypak wrote:
> 
> > This GPU is found on SoCs such as MSM8953(650MHz), SDM450(600MHz),
> > SDM632(725MHz).
> > 
> > Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> > ---
> >  drivers/gpu/drm/msm/adreno/a5xx_gpu.c      | 34 ++++++++++++++--------
> >  drivers/gpu/drm/msm/adreno/adreno_device.c | 18 ++++++++++++
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  5 ++++
> >  3 files changed, 45 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> > index 5e2750eb3810..249a0d8bc673 100644
> > --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> > @@ -441,7 +441,7 @@ void a5xx_set_hwcg(struct msm_gpu *gpu, bool state)
> >  	const struct adreno_five_hwcg_regs *regs;
> >  	unsigned int i, sz;
> >  
> > -	if (adreno_is_a508(adreno_gpu)) {
> > +	if (adreno_is_a506(adreno_gpu) || adreno_is_a508(adreno_gpu)) {
> >  		regs = a50x_hwcg;
> >  		sz = ARRAY_SIZE(a50x_hwcg);
> >  	} else if (adreno_is_a509(adreno_gpu) || adreno_is_a512(adreno_gpu)) {
> > @@ -485,7 +485,7 @@ static int a5xx_me_init(struct msm_gpu *gpu)
> >  	OUT_RING(ring, 0x00000000);
> >  
> >  	/* Specify workarounds for various microcode issues */
> > -	if (adreno_is_a530(adreno_gpu)) {
> > +	if (adreno_is_a506(adreno_gpu) || adreno_is_a530(adreno_gpu)) {
> >  		/* Workaround for token end syncs
> >  		 * Force a WFI after every direct-render 3D mode draw and every
> >  		 * 2D mode 3 draw
> > @@ -620,8 +620,17 @@ static int a5xx_ucode_init(struct msm_gpu *gpu)
> >  
> >  static int a5xx_zap_shader_resume(struct msm_gpu *gpu)
> >  {
> > +	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
> >  	int ret;
> >  
> > +	/*
> > +	 * Adreno 506,508,512 have CPZ Retention feature and
> > +	 * don't need to resume zap shader
> > +	 */
> > +	if (adreno_is_a506(adreno_gpu) || adreno_is_a508(adreno_gpu) ||
> > +	    adreno_is_a512(adreno_gpu))
> > +		return 0;
> 
> Afaict all other changes in the patch adds a506 support, but this hunk
> changes a508 and a512 behavior.
> 
> I'm not saying that the change is wrong, but this hunk deserves to be in
> it's own patch - so that if there's any impact on those other versions
> it can be tracked down to that specific patch.
> 
> Thanks,
> Bjorn

Hello, Bjorn.

You're right on that. I'm going to remove those changes in V2, since
that SCM call only causes problems on A506 and i can't test it on other
GPUs.

Best regards,
Vladimir
