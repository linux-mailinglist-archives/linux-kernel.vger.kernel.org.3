Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2707533DF9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238159AbiEYNgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiEYNgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:36:43 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D6422A
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:36:40 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id p123so7141864qke.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Grl0Ici88Sz79dptO2NKdwHQ/Da4OTXc3PiSI2iuCc0=;
        b=a5EvdQu8GXKYLoSSQf4xu1FRP1hgPhOmTbu2FDWWbmOzV5Ntklf9Nlrv3nV6lJ7ekU
         C4qhdh1Gkmjti9yRGXzDw8ElJUJZ/SJum4YR5Uo3NqUZDhLtHJPHWqASQV7ExreaTWtV
         yJ7M/ZQarL7+2mOdB991AzntXNdtU+2AKk4hvgCgTgLjyF2OW6nfuGxaObE4LN+ruKRR
         a5FZ1ibYTUlzCTHLNd9xaqM7mIfxv4HFsfhZZbz0bk+5bC4qqVXMvkZQLnORCqz0iauu
         /sC+d/9sXN8rqezTGUE1TW/9imq5iX6i4ppYBnBPgmaf9Exgw5UfiIoor/0L0eG+L9vd
         cpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Grl0Ici88Sz79dptO2NKdwHQ/Da4OTXc3PiSI2iuCc0=;
        b=tIQDwxNmeeeLQE2uzPAsqZo4CQy3lqzyOfAm3MGtsiYMkj7IUmDoIYseEO47UzmWg/
         Y3eo0GQ0yhOo/yCK3D4MXU2vISKz5d6Hrp3opb+0KJX3g+aa771mY8xv6WcnxmqOw87c
         P2CVgzgGjFBY3Sn0O+fMGCsjHm0zoEoGWlv9eQyhyK8ROQOOo7kmYbDXcc13rtJEfN1E
         C98pPRg119COG0MI8Z/qBcuc5dvdbqhcnk18K8euUevvZUJFnq6zibE4VMh2VrWiXSFt
         oIsxGLOGw9oaXQwIMrzi8aopTqDHCoFYr/pud1ZvkEEYNVmJVCsxv5QVWvt0uP0+TZgE
         UMWQ==
X-Gm-Message-State: AOAM532Wa/3h2xjCWC/PEauJ/L4ZOk46p/ylChwucv1q09VDqZYphJy8
        bvOPQ+WBpylHOruddLsyTJvAEsvFdCUpWk9g5PDW0Q==
X-Google-Smtp-Source: ABdhPJw57giukrH8SEV/1DnIMT1VYzjINsEONrnCwIvtLMWg5+DgDLaOww+wXaHsR9IN4sMCXzPgBW5H8FKR1oaCfoQ=
X-Received: by 2002:a05:620a:414e:b0:6a5:8dec:57bb with SMTP id
 k14-20020a05620a414e00b006a58dec57bbmr2717852qko.30.1653485799502; Wed, 25
 May 2022 06:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220506123246.21788-1-yuehaibing@huawei.com> <CACRpkdZUwfVNZyS6RgcupJ+TRUZVM+1_3ABj_-f_3+v+wNE6mg@mail.gmail.com>
 <CACRpkdaKrk+cj9Yvpe3kmR1iJFczi-yckHiKeLGu9F=hRFiU9w@mail.gmail.com>
In-Reply-To: <CACRpkdaKrk+cj9Yvpe3kmR1iJFczi-yckHiKeLGu9F=hRFiU9w@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 25 May 2022 16:36:28 +0300
Message-ID: <CAA8EJpq7_V7mZbN+G5fZdK0a4kTcxROAd_bGJtQ5mhzdYr6pNQ@mail.gmail.com>
Subject: Re: [PATCH v2 -next] drm/display: Fix build error without CONFIG_OF
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     YueHaibing <yuehaibing@huawei.com>, airlied@linux.ie,
        daniel@ffwll.ch, tzimmermann@suse.de, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2022 at 15:55, Linus Walleij <linus.walleij@linaro.org> wrot=
e:
>
> On Mon, May 23, 2022 at 2:46 PM Linus Walleij <linus.walleij@linaro.org> =
wrote:
> > On Fri, May 6, 2022 at 2:33 PM YueHaibing <yuehaibing@huawei.com> wrote=
:
> >
> > > While CONFIG_OF is n but COMPILE_TEST is y, we got this:
> > >
> > > WARNING: unmet direct dependencies detected for DRM_DP_AUX_BUS
> > >   Depends on [n]: HAS_IOMEM [=3Dy] && DRM [=3Dy] && OF [=3Dn]
> > >   Selected by [y]:
> > >   - DRM_MSM [=3Dy] && HAS_IOMEM [=3Dy] && DRM [=3Dy] && (ARCH_QCOM ||=
 SOC_IMX5 || COMPILE_TEST [=3Dy]) && COMMON_CLK [=3Dy] && IOMMU_SUPPORT [=
=3Dy] && (QCOM_OCMEM [=3Dn] || QCOM_OCMEM [=3Dn]=3Dn) && (QCOM_LLCC [=3Dy] =
|| QCOM_LLCC [=3Dy]=3Dn) && (QCOM_COMMAND_DB [=3Dn] || QCOM_COMMAND_DB [=3D=
n]=3Dn)
> > >
> > > Make DRM_DP_AUX_BUS depends on OF || COMPILE_TEST to fix this warning=
.
> > >
> > > Fixes: f5d01644921b ("drm/msm: select DRM_DP_AUX_BUS for the AUX bus =
support")
> > > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> >
> > Patch applied to the DRM tree.
>
> Nope, failed:
>
> $ dim push-branch drm-misc-next
> dim: ac890b9eeb9b ("drm/display: Fix build error without CONFIG_OF"):
> Fixes: SHA1 in not pointing at an ancestor:
> dim:     f5d01644921b ("drm/msm: select DRM_DP_AUX_BUS for the AUX bus su=
pport")
> dim: ERROR: issues in commits detected, aborting
>
> I don't know what to do with this, sorry. The other committers are maybe =
better
> with this kind of situations. I think it is designed to stop me from
> shooting myself
> in the foot.

Linus, can we get an ack from you (or anybody else from DRM core) to
merge it through drm/msm tree?

--=20
With best wishes
Dmitry
