Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46DF58490A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 02:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbiG2AYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 20:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiG2AYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 20:24:04 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5958B7B1DC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 17:24:03 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ss3so5771724ejc.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 17:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=DEDxzOgHTQRQ+rvv/SEM8DOqN9V3eUaGY5hH+UtkIUE=;
        b=XgGvjKM+Hr42e4KmwAK3a1argfHnnskNbRdLej5zKrxwQdZsp8y8yMpZaRkfb6IxQr
         C8PRTgOCkSzXDctTwt3AbbUt42+nPjnl1Ik5fW1fT+au0znVnOZDXvJpfPbucVm4Bv+n
         ty8qUI1gfDrvRlxRV1sm3ItakjLTxp6xy+YLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=DEDxzOgHTQRQ+rvv/SEM8DOqN9V3eUaGY5hH+UtkIUE=;
        b=4AIiCBEVIo1djaY2h6AMwiZHNV4Gj6uZsLKP30TD0bh5zjz8md7p4M4NQdDP8q+Fnz
         KkYrDpWXbf++C/MpVa40PuKorxop2mZB0zftYoo/eCRGAcK4sA/GAcJ6SDONc1SnrvpY
         LPeXS2EN5NzKs52l4CLGSVwBvBm7GCZY/5fCqfArRnn2oUQ6UsXaaMWqmwYPjHfpAlZL
         TjtygMTP0RNg608Cx2REaOts8ucX6ppOH9G9NJenKKT+psA4Wf5G/zWgR1KqDpKgE3qW
         JJvSeYNJZMo/xJ4l5xmSSO4Ib/CblW2h3J4n9Vt29rEg9dWKSfr5+iNdCi/91juHp4OH
         3CYw==
X-Gm-Message-State: AJIora8cqMc9EVUhlnWUpfbR34JWeWbaTH+HbLW6y/G63n8vmxduznAt
        Y7LvDpNGj0jtDBpGQ3MlmXTn2C3FszsNjKzy
X-Google-Smtp-Source: AGRyM1vDfPCgxqosBxDGP629Tbh4824MjAn7tUo26+QoZML3NxFCjjVr/fPrCYT+5stBJD+numzM2Q==
X-Received: by 2002:a17:907:8a28:b0:72e:cef6:eba0 with SMTP id sc40-20020a1709078a2800b0072ecef6eba0mr936726ejc.765.1659054241469;
        Thu, 28 Jul 2022 17:24:01 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id b2-20020a1709064d4200b0072a430d2abdsm970815ejv.91.2022.07.28.17.24.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 17:24:01 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso3362654wma.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 17:24:01 -0700 (PDT)
X-Received: by 2002:a05:600c:2e48:b0:3a3:1ce3:3036 with SMTP id
 q8-20020a05600c2e4800b003a31ce33036mr1007498wmf.188.1659053924819; Thu, 28
 Jul 2022 17:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <1657544224-10680-1-git-send-email-quic_vpolimer@quicinc.com> <1657544224-10680-4-git-send-email-quic_vpolimer@quicinc.com>
In-Reply-To: <1657544224-10680-4-git-send-email-quic_vpolimer@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 28 Jul 2022 17:18:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UXKHrp63wosBdXDBKKcierbgfUOT-W1QF2N23No+MJBw@mail.gmail.com>
Message-ID: <CAD=FV=UXKHrp63wosBdXDBKKcierbgfUOT-W1QF2N23No+MJBw@mail.gmail.com>
Subject: Re: [PATCH v6 03/10] drm/msm/dp: use atomic callbacks for DP bridge ops
To:     Vinod Polimera <quic_vpolimer@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        quic_vproddut <quic_vproddut@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 11, 2022 at 5:57 AM Vinod Polimera
<quic_vpolimer@quicinc.com> wrote:
>
> Use atomic variants for DP bridge callback functions so that
> the atomic state can be accessed in the interface drivers.
> The atomic state will help the driver find out if the display
> is in self refresh state.
>
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c |  9 ++++++---
>  drivers/gpu/drm/msm/dp/dp_drm.c     | 17 ++++++++++-------
>  drivers/gpu/drm/msm/dp/dp_drm.h     |  9 ++++++---
>  3 files changed, 22 insertions(+), 13 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
