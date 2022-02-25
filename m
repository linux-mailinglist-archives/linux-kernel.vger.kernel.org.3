Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041EF4C4D6E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiBYSOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiBYSOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:14:30 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFB71F6347
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:13:58 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id u47-20020a4a9732000000b00316d0257de0so7345051ooi.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=Fagoys/mnguEDY3pl+5sEoAekwrN1hXZMmE77Ir6Qfs=;
        b=hxBADu8QpohF0yutsmwPqmQlJ5vH4rfHMO43pUPkQ3zD+/AxpPBOrlFKGve21EVmSn
         Pvx1oUpXteHi4Oe0mliT2aJlgWMAtBeq85PCVsob6gU3/c6aQfSkQeHJ3In7+IZd9RG4
         +j6cDftYrrsCehirVuVu0t3rhTorY76CTwgNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=Fagoys/mnguEDY3pl+5sEoAekwrN1hXZMmE77Ir6Qfs=;
        b=jM9rL9AuIsdy22fmLbpKtlbx4T7O8rvFGbQqWDF/wCtMMy78BMWeAHLKSVaUhazGG/
         9Ut/s77FcYcPuNy2qZvhkjicY4vR8OcLlZCqtdOOsPBAgX7XnS/odkYyPNNcgCP7QEO/
         UKVs1qvWoDUmVq9LYuit2Zjjh9lLAE7Udpudxm1XLmSlXYW2nATwl23MFkTHozl4mjNg
         +KLGphZr/R6peJI5qNp3sdsPyvE6ZdOGSxfEc7HeHWWY37oOpTIYVp4prXtjA+yrvS2H
         g65dZpm9GikbRBy6+kehB19L/WHHlMMsh+uCx9DURZ7+a2CgyqHnPjALpWf/zaOj32o2
         qxxA==
X-Gm-Message-State: AOAM5333jMBQ7vQ6f7dbvbMhQLV5L230J4kQrGb1o1K7mzdx/5MYLGuB
        1j+clG9GeBjqUX3uPPk6NNd4j78CSSHeBJZQWss07A==
X-Google-Smtp-Source: ABdhPJzLlkAkQdrZ22FiuMj2KKEe2l3uCK3eG6+MQ+vgJaB4N4/OV+2sjXjnVbX7YZ0UHqLBoWWYOwu4siva5+HTxms=
X-Received: by 2002:a05:6870:631a:b0:d1:7d97:806 with SMTP id
 s26-20020a056870631a00b000d17d970806mr1849727oao.8.1645812837029; Fri, 25 Feb
 2022 10:13:57 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Feb 2022 10:13:56 -0800
MIME-Version: 1.0
In-Reply-To: <1645576060-3046-4-git-send-email-quic_khsieh@quicinc.com>
References: <1645576060-3046-1-git-send-email-quic_khsieh@quicinc.com> <1645576060-3046-4-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 25 Feb 2022 10:13:56 -0800
Message-ID: <CAE-0n506iRCF0TjPDT2Aqe--RXEJbPe8961JiGmW6K2M5VJRUw@mail.gmail.com>
Subject: Re: [PATCH v10 3/4] drm/msm/dpu: revise timing engine programming to
 support widebus feature
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-02-22 16:27:39)
> Widebus feature will transmit two pixel data per pixel clock to interface.
> Timing engine provides driving force for this purpose. This patch base
> on HPG (Hardware Programming Guide) to revise timing engine register
> setting to accommodate both widebus and non widebus application. Also
> horizontal width parameters need to be reduced by half since two pixel
> data are clocked out per pixel clock when widebus feature enabled.
>
> Widebus can be enabled individually at DP. However at DSI, widebus have
> to be enabled along with DSC to achieve pixel clock rate be scaled down
> with same ratio as compression ratio when 10 bits per source component.
> Therefore this patch add no supports of DSI related widebus and compression.
>
> Changes in v2:
> -- remove compression related code from timing
> -- remove op_info from  struct msm_drm_private
> -- remove unnecessary wide_bus_en variables
> -- pass wide_bus_en into timing configuration by struct msm_dp
>
> Changes in v3:
> -- split patch into 3 patches
>
> Changes in v4:
> -- rework timing engine to not interfere with dsi/hdmi
> -- cover both widebus and compression
>
> Changes in v5:
> -- remove supports of DSI widebus and compression
>
> Changes in v7:
> -- split this patch into 3 patches
> -- add Tested-by
>
> Changes in v8:
> -- move new registers writes under DATA_HCTL_EN features check.
>
> Changes in v10:
> -- add const inside dpu_encoder_is_widebus_enabled()
> -- drop useless parenthesis please
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
