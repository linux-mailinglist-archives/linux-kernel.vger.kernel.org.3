Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308785075F3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349165AbiDSRHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355736AbiDSRGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:06:55 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E17713CE0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:01:02 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id u5-20020a17090a6a8500b001d0b95031ebso2479971pjj.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9jOurR+gBeTzso4yvaJAHtAS98sqnrl9e0cTwGxsGI0=;
        b=E5zCqZZl5R98J3+JPforMtTZJRUIte3wm1tfA/2uivf21uWK+9MWrmrODn7aQ0kLpi
         6OdRo16lVgtm0pKfCt/vKx22BZgDhXwV4ARtMQRWqWIc62MXDTx6XJZc29PZYmb7fuV5
         fQFQdFTtSrmXUmWJyBmICA25mNPOsNQD5+15P2FZCbV74JUl/HCYebfkk0uUWIbSZpeN
         HZNP1oP6770RrKcEW1hioIPSFg4ldVg9/SOcTt6lkVaTjUENuH9lh6YXDanO9FNw3kNj
         9GosekmXXKMnTw+URy39aEeXJ9VdZYY0UWf2cTgA6ipIRSEpjaj4krP4ohQ1PJcUEYf+
         yvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9jOurR+gBeTzso4yvaJAHtAS98sqnrl9e0cTwGxsGI0=;
        b=AmvTZq5DmGriIJaGQce+llkTl8as6RRB3IwFYC8KGOHCMT+lCXNBYXMXT4w6mC7q0V
         jPrmDmw0C7Vpm5k1aPs0gLUXAsgT+rIUYHXRTAVZadcrUqThucUMUo0MdxUgN+2+O1dB
         MA33BBdOjWccK86svzbrmeyiMhM/lY9L3wsC//GgsUwnUt1kcAmCBUZjh9yjfCqOgyW8
         XE4RuQzDOjzot4u+9QDQ7JfFDcgBf0XnaJGqtG349w32E45grnJYPJ/G7rJLB2/+S05M
         C3OJHLFzvdZVaowiFk+X0ePZ9Y5pyEmOV34d6gg5I7paiCAXMFQ2HlOlH80dH/OfE6EH
         qvsw==
X-Gm-Message-State: AOAM532teH+j49Bqj0bjMzL7+atRvQHUyscXcHgybrS7AD9c2NHiOdcX
        RAv7yWU+bNb4ELiTIF62lOy8indwLy8yt+4z5XsgMw==
X-Google-Smtp-Source: ABdhPJwm798+IVrQZxr/r+hyLACw0yUGxBuAo0d6wjGnSnNekXfq8Uj0LOHgkdJZ4cq0435fsCDFQ8o8c+sS+YW/ARM=
X-Received: by 2002:a17:90b:3e84:b0:1d2:c015:2182 with SMTP id
 rj4-20020a17090b3e8400b001d2c0152182mr7222190pjb.232.1650387661577; Tue, 19
 Apr 2022 10:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220408013034.673418-1-nfraprado@collabora.com> <20848108-31bc-357c-224b-9cbdd465b195@collabora.com>
In-Reply-To: <20848108-31bc-357c-224b-9cbdd465b195@collabora.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 19 Apr 2022 19:00:50 +0200
Message-ID: <CAG3jFytRcM2bnKu0gLwZ9Wyn5eRvO16+OLJHt+a=pAAM9a=vww@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: Use uint8 for lane-swing arrays
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>, kernel@collabora.com,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Xin Ji <xji@analogixsemi.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

On Fri, 8 Apr 2022 at 10:21, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 08/04/22 03:30, N=C3=ADcolas F. R. A. Prado ha scritto:
> > As defined in the anx7625 dt-binding, the analogix,lane0-swing and
> > analogix,lane1-swing properties are uint8 arrays. Yet, the driver was
> > reading the array as if it were of uint32 and masking to 8-bit before
> > writing to the registers. This means that a devicetree written in
> > accordance to the dt-binding would have its values incorrectly parsed.
> >
> > Fix the issue by reading the array as uint8 and storing them as uint8
> > internally, so that we can also drop the masking when writing the
> > registers.
> >
> > Fixes: fd0310b6fe7d ("drm/bridge: anx7625: add MIPI DPI input feature")
> > Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> >
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>

Applied to drm-misc-next
