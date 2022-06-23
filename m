Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA54557D9D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 16:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiFWOS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 10:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiFWOS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:18:58 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47223668A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 07:18:57 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3176d94c236so195729707b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 07:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3ttjwutrYzRtOS2BJTBkTWyAMoMq6/UV2GWdzOFapio=;
        b=sfBsAoU06byqlOa+VeO2lPzCt3r5KJeWqK4XfqR/e8RsEwzGOfnOs2sO54HxJlwsMe
         5+uG9KuFnCwiTbujHCqRhYJ7B+PrG9xsGqoeEYZQs9bzM3zlPs5LxUnwHU8ZfCbEANAn
         u2Vi6juNku400dA/YZl9Kmph8Uo44ZIkjo2tQBAvi9OhEUu/wIGnQ0uprpINRFot8IgY
         FaW7a0TzEjuW1HnLDm4n8N8muv1UJxL4gETrdhqU+D1VqQfR2NtP/NgI07cIwc0WQ75F
         7VomjOBnH/Y55G/iSI5+rKIcn9NF++wZjVcPbPtFnv3HQrJUMyZCOQ5k9F+yXKwd5v0G
         cnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3ttjwutrYzRtOS2BJTBkTWyAMoMq6/UV2GWdzOFapio=;
        b=x2ycwNN82TgaBEm5fVuxLgX/TVZUn+fF20CsZeUHZ+BUnnbQnyQLckV5YL6nkAS8l7
         +a5Ouh4TgnJFe5Rt8VoijllTgFFdpZCpiA650OPeSk+Hb5+mxf6TbF9rZwHXutXfmky5
         2OuJFb4Uq7Bbzf+9dH1smKXa6+Fk1w24fX3LTHv6qyQSErRToFw67/VHYxD2YD2f6XSC
         GcY/qf4WTJEr5Ih9KLYoCiBEfCOJvnH0CLxM34F29AmasPMRECKXSNQCR90DD+Y/Fx8y
         zcjPQwqsAY+eL7FHmn66jctYj3qIrXJNizAAXyWzZNK8c7JtCcB8lCsxOn5/r3451/ON
         s2iQ==
X-Gm-Message-State: AJIora+v8n8PuzyzZcO2X39bv3QCjqmmnjKMcFlz3b0OWoS99yyMx8AN
        q8425MDZzEC3oGlPrmz7PSyHxxJJeJOSHjvIY8aIWw==
X-Google-Smtp-Source: AGRyM1uhwbGkCiSphmkJsR9TFQpk35mHCv4z7e/K3gkNQ9fydR1ce9ALqQr5ErSs2vU6+fLkHj4bxleqmQps/4lpgyU=
X-Received: by 2002:a81:d05:0:b0:317:76a1:9507 with SMTP id
 5-20020a810d05000000b0031776a19507mr11294211ywn.151.1655993936782; Thu, 23
 Jun 2022 07:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220611041612.1976-1-yuehaibing@huawei.com>
In-Reply-To: <20220611041612.1976-1-yuehaibing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Jun 2022 16:18:45 +0200
Message-ID: <CACRpkda6OY3Cp0+pWmg0E=9nRLbEmwp8x0rF81McYFHVnTno1A@mail.gmail.com>
Subject: Re: [PATCH v3 -next] drm/display: Fix build error without CONFIG_OF
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, tzimmermann@suse.de,
        lyude@redhat.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org,
        quic_abhinavk@quicinc.com
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

On Sat, Jun 11, 2022 at 6:16 AM YueHaibing <yuehaibing@huawei.com> wrote:

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
> Fixes: 1e0f66420b13 ("drm/display: Introduce a DRM display-helper module"=
)
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> v3: use correct Fixes tag

Patch applied for next as non-urgent fix.

Yours,
Linus Walleij
