Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DE050B96B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448182AbiDVOGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386092AbiDVOGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:06:19 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0905A15B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:03:25 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b24so10537474edu.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XXfqebKK5B9iW+cuu7Wrx8oyDP/rWO517FbDuh8GYTA=;
        b=EwnC0F+Pg4MtRzeeWPuywGVVfrIfoQpkjZejmyOOhaV3NRtb5XzudpYoMW98fIdcAm
         NUM6hR06S3J+6kzWZeWdVcyZdI0Toqj/vsaUJ+zpNTbPAQhBWPEucmWtE0wTHtBDsJ05
         p7cS3QW5VSa1GBar/5aair5GlO7o2wDtoN4xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XXfqebKK5B9iW+cuu7Wrx8oyDP/rWO517FbDuh8GYTA=;
        b=SdXIYNi/QOcFtEos2Kt19n071CL9xsqiwQJk54LNQqnoFGZv/nqXHpyJQZb9ou7nHq
         aSkNr3McycoTH+i7sjs6nhdfQev0Azc9iAA4RuYmof2/XFXp2gr//GtTS7QpkuHm3+gs
         +d/+wrS9D8v8zi8XlSBlU8tqsyWpBODfd1Qj1sDpzD9/F4N35BG18w8LV3FFjvpWFQjo
         I6WfvTQGcZN7bRLznUknS9YjRJ7yCkvjKeDPAtJ8//fp4mb5dCLVx9YMUiB8FZJccVvp
         Fxy2D4n2Q9Vif3k1hr2UNvISCURZ30uevnwvkH9+X6PXtKNbKMxYvSp6RChj1IEBCJXb
         sw0Q==
X-Gm-Message-State: AOAM532ev28zNhV3sG8Go+Apaqn3AAygqq9i/uk0Idi2WAs0ttKhzl5c
        usPrplB1FsGEwV//AIHWzhKMSpMHVdNskqeZh9I=
X-Google-Smtp-Source: ABdhPJx7Vy8B621KRVQFp35IjA8tgGKJpsjK1n189P2UoiislleaiLeg4dZC/MZN31nQSnw4uqH8tw==
X-Received: by 2002:a05:6402:26cd:b0:423:b43d:8b09 with SMTP id x13-20020a05640226cd00b00423b43d8b09mr5050901edd.400.1650636204047;
        Fri, 22 Apr 2022 07:03:24 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id y22-20020a170906559600b006e858ba2549sm787199ejp.49.2022.04.22.07.03.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 07:03:22 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id e28so1003711wra.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:03:22 -0700 (PDT)
X-Received: by 2002:a5d:6506:0:b0:20a:c240:90e2 with SMTP id
 x6-20020a5d6506000000b0020ac24090e2mr3855081wru.342.1650636201140; Fri, 22
 Apr 2022 07:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <1650618666-15342-1-git-send-email-quic_sbillaka@quicinc.com> <1650618666-15342-2-git-send-email-quic_sbillaka@quicinc.com>
In-Reply-To: <1650618666-15342-2-git-send-email-quic_sbillaka@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 22 Apr 2022 07:03:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U9M_qsEacBHundgZAHMg7NEnW1LKZX6niN4fmsKUwt6A@mail.gmail.com>
Message-ID: <CAD=FV=U9M_qsEacBHundgZAHMg7NEnW1LKZX6niN4fmsKUwt6A@mail.gmail.com>
Subject: Re: [PATCH v9 1/4] drm/msm/dp: Add eDP support via aux_bus
To:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        quic_vproddut <quic_vproddut@quicinc.com>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        Steev Klimaszewski <steev@kali.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 22, 2022 at 2:11 AM Sankeerth Billakanti
<quic_sbillaka@quicinc.com> wrote:
>
> This patch adds support for generic eDP sink through aux_bus. The eDP/DP
> controller driver should support aux transactions originating from the
> panel-edp driver and hence should be initialized and ready.
>
> The panel bridge supporting the panel should be ready before the bridge
> connector is initialized. The generic panel probe needs the controller
> resources to be enabled to support the aux transactions originating from
> the panel probe.
>
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> ---
> Changes in v9:
>   - add comments for panel probe
>   - modify the error handling checks
>
> Changes in v8:
>   - handle corner cases
>   - add comment for the bridge ops
>
> Changes in v7:
>   - aux_bus is mandatory for eDP
>   - connector type check modified to just check for eDP
>
> Changes in v6:
>   - Remove initialization
>   - Fix aux_bus node leak
>   - Split the patches
>
>  drivers/gpu/drm/msm/dp/dp_display.c | 73 +++++++++++++++++++++++++++++++++++--
>  drivers/gpu/drm/msm/dp/dp_display.h |  1 +
>  drivers/gpu/drm/msm/dp/dp_drm.c     | 21 +++++++++--
>  drivers/gpu/drm/msm/dp/dp_parser.c  | 23 +-----------
>  drivers/gpu/drm/msm/dp/dp_parser.h  | 13 ++++++-
>  5 files changed, 101 insertions(+), 30 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
