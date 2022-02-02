Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404764A78B3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 20:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346321AbiBBT1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 14:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242974AbiBBT1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 14:27:15 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87818C06173B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 11:27:15 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id p5so1618213ybd.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 11:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MVFg7PnzCZUjUxdz0W83GsH6V6lHk0PTdYLQqbtG0AI=;
        b=VUwYV4hfYIJDeVqAbdSVlM+Ob6/tQmaK18WXFHl50OmP56SqFl78RfzWXIZAhDIEyA
         FBxi54PA6BaxdknZcdX6mGVwGAs5r4L/o1yfQC6tIb41idAtlSuLxodwGODXpdQYAoou
         gBYie3P3VedP1Q6B4Vq2tVEMo6OFvTZeK3j/8lCY2iRXtpCT1496pzBfM88SpAwUnR0v
         UejxgXYvo3gN1ViXSbsqRVrvbwtcYBPz5h9Qvvh/PT5PICdBHwABLDDpHlb87s9G/l6Q
         ExTcmFgmDUt5xNa5ZXPbgdrJftgwB8u6PIPXqmWn+Veh7T2F047aQbSZ1SEBqoDhU1wI
         bB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MVFg7PnzCZUjUxdz0W83GsH6V6lHk0PTdYLQqbtG0AI=;
        b=CsNIx+Nf5Mgnp2z4uL+B1QUu83f6k4QEpDtZyp4gFfhaO+QXr35szC/Y8C43oRS91G
         CB+My4wFg+OmXrSfJOY0+NXxy/ORPbS6dr702tegRXKVHfUjaFjhP3Ey2rK8dGiAT11z
         diMxlQxVhwiLelz4demeaUIH6qzlz1URDWxRYlJw/l1H0/YMmQipSDwlHCaLtjoedlDT
         kNXp2SywDwNufT/AcXE9Dvc/Ep9hzE1wCevfM6j5PLCoFw/GHaq0dueZYFK1oqImkOL9
         Ghuf3B+E8fg4/qq/TI5+nWWRlSudDseEX7moKjO3gZGxLmVCRnQFye8jjeAf523nf07U
         POig==
X-Gm-Message-State: AOAM5315JyXcQVHRg4TTYkAGGt+MTrXO8XJFKzSfgF1p60jf5ikJsf50
        FkRAGJkekCCRjD1GPLND9og4RLd+vvFSZ94sdT7bFQ==
X-Google-Smtp-Source: ABdhPJxjEkuDFLTtBXShgD0F0o0g/RNgC7ua+FWLePsV5R9uG8DZdnnVQ8u6OGlpCZe3rRIYPAUwctTIuW7JqlAHdlI=
X-Received: by 2002:a81:23d4:: with SMTP id j203mr2147372ywj.95.1643830034776;
 Wed, 02 Feb 2022 11:27:14 -0800 (PST)
MIME-Version: 1.0
References: <20220201161618.778455-1-robdclark@gmail.com> <20220201161618.778455-2-robdclark@gmail.com>
In-Reply-To: <20220201161618.778455-2-robdclark@gmail.com>
From:   Emma Anholt <emma@anholt.net>
Date:   Wed, 2 Feb 2022 11:27:03 -0800
Message-ID: <CADaigPUcA5+o2Cd+1YYTGbpnsj3Di=m2Q25OUeumz0HAQVFc9w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/msm/gpu: Add ctx to get_param()
To:     Rob Clark <robdclark@gmail.com>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        freedreno@lists.freedesktop.org,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        Yiwei Zhang <zzyiwei@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 8:16 AM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Prep work for next patch.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---

> diff --git a/drivers/gpu/drm/msm/msm_rd.c b/drivers/gpu/drm/msm/msm_rd.c
> index 7e4d6460719e..dd3605b46264 100644
> --- a/drivers/gpu/drm/msm/msm_rd.c
> +++ b/drivers/gpu/drm/msm/msm_rd.c
> @@ -197,13 +197,15 @@ static int rd_open(struct inode *inode, struct file *file)
>
>         /* the parsing tools need to know gpu-id to know which
>          * register database to load.
> +        *
> +        * Note: These particular param does not require a context
>          */

Minor typo fix, "param does not" -> "params do not"

Other than that, series
`Reviewed-by: Emma Anholt <emma@anholt.net>`

and I love that we're catching non-address-space associated faults now, too!
