Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3924B4B54B6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355837AbiBNPYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:24:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240044AbiBNPYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:24:07 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E720D60AA6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:23:58 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id b8so2981283pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XhJtpZeOTdYyGP8p2E+Zf5kH9MRPmhWE9u/AfJAE6Mo=;
        b=kNpDvUysQUEvmZ5w3BuqltpbmJ+AQHLHIWMDxiQovbpTsVj+9FuZt99RgOUZq5xE5z
         Fy2dNXffr+aoxtptpQ/CV8xakhdCRr4LHFq1eSsU3cVa+dY+n41TsXH2Z6xc86dL6awH
         ef9O6j2VP40vC7v4gP52Wcj5FIV0DOn0uVyLtj/rGPUO3CTGm4aw+hqLp7yT6PQkvzwM
         sVfXFiBx7xSTvXvTAcxFzhm0KA8mvLCXx6ZenfBIVt1SJiKYAnJqiPyjtrsF16J5xwPD
         Nxyf4qD1dnaYivBr6+AY/QVA5CHwA3jyuRF0JgouQt3REhlyIb1nI0vKqWelcDKivJgP
         a3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XhJtpZeOTdYyGP8p2E+Zf5kH9MRPmhWE9u/AfJAE6Mo=;
        b=Vc2rAGHhwpsXU7gwece5u2rS65xFr5F1Bdo/B/F/xQcumJEK/faCFaCrsyQhXxyjGi
         5tNyzdsvi/uUEBQLXaZ7AFNKKICM41T86QV0V9WlWb6H/yQxrhCACE63tPg7cMqeeCzJ
         Itfip8hG1bH3FtOLzf0Q4MljKSgNxTRWrr1bHnO2UV4oGIZrqXO5/qd1Eur99YllGVtW
         NMnMqeo5gt2+ukSLh4V5gPLFG5qDcPVVMrnOlDTeu3UdI98DqJcFhclJU9UTgfdJR/fR
         vnjePgq2PnKFHezSGpVtZ8ff4yTcKL6ip+JUa5DguHcMJBE+oxBFOYsxrFGI8mHJBX5f
         +nkg==
X-Gm-Message-State: AOAM531o5UsYcY9+NI/OD4b8lSjFJnyz/szxhtob4opC0jgQqs5KJx8C
        CRhZcPiK2oOLT47947/ZGg4RPkaPxMZwhkVZJKcqZA==
X-Google-Smtp-Source: ABdhPJxzlo2fKWRLWKCCBqGfAnMwp753+nt7M/y+3k0m/Ol30ZMFZpSc4+cJI/8d6Ccy3kODmtUkt+Ih+lUayKYwZvY=
X-Received: by 2002:a17:90b:1b46:: with SMTP id nv6mr15409095pjb.179.1644852238358;
 Mon, 14 Feb 2022 07:23:58 -0800 (PST)
MIME-Version: 1.0
References: <20220210103827.402436-1-treapking@chromium.org>
In-Reply-To: <20220210103827.402436-1-treapking@chromium.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 14 Feb 2022 16:23:47 +0100
Message-ID: <CAG3jFytQUetqJ+HrCxSg8njmErCNRSTthCKMy+BRC6LBU0vR6Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: anx7625: Fix overflow issue on reading EDID
To:     Pin-Yen Lin <treapking@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Xin Ji <xji@analogixsemi.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2022 at 11:38, Pin-Yen Lin <treapking@chromium.org> wrote:
>
> The length of EDID block can be longer than 256 bytes, so we should use
> `int` instead of `u8` for the `edid_pos` variable.
>
> Fixes: 8bdfc5dae4e3 ("drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to DP")
> Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>
> Changes in v2:
> - add "Fixes" tag
> - collect review tag
>
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 2346dbcc505f..e596cacce9e3 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -846,7 +846,8 @@ static int segments_edid_read(struct anx7625_data *ctx,
>  static int sp_tx_edid_read(struct anx7625_data *ctx,
>                            u8 *pedid_blocks_buf)
>  {
> -       u8 offset, edid_pos;
> +       u8 offset;
> +       int edid_pos;
>         int count, blocks_num;
>         u8 pblock_buf[MAX_DPCD_BUFFER_SIZE];
>         u8 i, j;
> --
> 2.35.0.263.gb82422642f-goog
>

Applied to drm-misc-next.
