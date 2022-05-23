Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4D853102C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbiEWMqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbiEWMqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:46:19 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87807427FF
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 05:46:17 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id p139so25144987ybc.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 05:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O+ppO6uaT3HzCMb3hULH8hCXzl7PiBlC1jwCnqcgfHE=;
        b=WEtOarK4jpq+wCwX/9yC+UTrfJxpv7OHii0oCYtPbf3H56WwfrhYrsmCvVfpgKdwIa
         +pxhCdioQJtxmpQ9SJzV+cy5Vf/1hnJWlrslH6EiXg0KZClSN4C3pmVoFU+rd+Et80SY
         PKbZxRzi9Xtv/MuxGyKS4t87kUGCOWVLmrhc51oLcUzm0fpig+p9VS8WmTTPazWJxxb+
         LuJdDyw+uenhYOjkQdSuZiKM2PqkzOmR+BR00LbtMQnrUesNgG2B4Qhs2dec50umM7cb
         Dnah/hN+EzOePcrwGmlwc+KOl2q3a8ELivybRCpu47yEporw6ejYIS11ugKC6IZLToIu
         5wPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O+ppO6uaT3HzCMb3hULH8hCXzl7PiBlC1jwCnqcgfHE=;
        b=XTLKQ31dzci1TGSy5leCA0fGgiWnEaXLlTR2lXjmEccUKOI95Kek/rImh19n1/ik3j
         8GzVXx21VwOQWswo51C2DnxxhxT+Xrc6VvM2W87Dj+rkLCFDhcgQQerIwvqPrUE5FKO7
         fesqg33Lmgn4WRoR99HvVdWKAPdjT2R/UDV2luA0HdeIITY9N10DXy/hvgkJlghwENyt
         qZ7gJrAlOUBIYOZHEfejFxNnGQvxrbMpq9ill4vKU1qDfuu+5Xl4BcAUEZXI/Xf2BQHY
         6Mx9OnEIGioMLm3LerLzMkva0CeXTEJW+b2uCceI+yzdO24iARE9v+YP+fVj5CoRd3As
         558g==
X-Gm-Message-State: AOAM5335bxC0/B1sE5EX7Oo7PxQN48uGJ2n0UX+Tc3/oHYgVAj0i++qV
        mD500xruJuzYaUbG4Qz2NzUT6HJ+EYuFmPtEQjOolg==
X-Google-Smtp-Source: ABdhPJwouBMGBTgRpDxe5aoUB6mzxiwqDafQ4SxktusCLNK6ylCETjs4yu813XGYZcUR/Th38ypf5hUsI1iX0luoVyU=
X-Received: by 2002:a5b:302:0:b0:64b:a20a:fcd9 with SMTP id
 j2-20020a5b0302000000b0064ba20afcd9mr21068986ybp.492.1653309976782; Mon, 23
 May 2022 05:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220506123246.21788-1-yuehaibing@huawei.com>
In-Reply-To: <20220506123246.21788-1-yuehaibing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 23 May 2022 14:46:05 +0200
Message-ID: <CACRpkdZUwfVNZyS6RgcupJ+TRUZVM+1_3ABj_-f_3+v+wNE6mg@mail.gmail.com>
Subject: Re: [PATCH v2 -next] drm/display: Fix build error without CONFIG_OF
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, tzimmermann@suse.de,
        dmitry.baryshkov@linaro.org, linux-kernel@vger.kernel.org,
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

On Fri, May 6, 2022 at 2:33 PM YueHaibing <yuehaibing@huawei.com> wrote:

> While CONFIG_OF is n but COMPILE_TEST is y, we got this:
>
> WARNING: unmet direct dependencies detected for DRM_DP_AUX_BUS
>   Depends on [n]: HAS_IOMEM [=3Dy] && DRM [=3Dy] && OF [=3Dn]
>   Selected by [y]:
>   - DRM_MSM [=3Dy] && HAS_IOMEM [=3Dy] && DRM [=3Dy] && (ARCH_QCOM || SOC=
_IMX5 || COMPILE_TEST [=3Dy]) && COMMON_CLK [=3Dy] && IOMMU_SUPPORT [=3Dy] =
&& (QCOM_OCMEM [=3Dn] || QCOM_OCMEM [=3Dn]=3Dn) && (QCOM_LLCC [=3Dy] || QCO=
M_LLCC [=3Dy]=3Dn) && (QCOM_COMMAND_DB [=3Dn] || QCOM_COMMAND_DB [=3Dn]=3Dn=
)
>
> Make DRM_DP_AUX_BUS depends on OF || COMPILE_TEST to fix this warning.
>
> Fixes: f5d01644921b ("drm/msm: select DRM_DP_AUX_BUS for the AUX bus supp=
ort")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch applied to the DRM tree.

Yours,
Linus Walleij
