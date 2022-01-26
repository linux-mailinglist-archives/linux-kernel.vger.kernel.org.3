Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBEA49D383
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 21:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiAZUdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 15:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiAZUdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 15:33:09 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC690C06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 12:33:08 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id h7so1174919ejf.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 12:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ukliw9sukrQW6ow50YsY/2wbM/35BtcU0cL0HgzMnLM=;
        b=dw3QQ8Vjz4RduwkU+DfXuqaAy+1poDrHZmp7JJYsjaLqADGSWcua23elXiKOBrIfvN
         7CO/frPtzzCycKqxFaHsQjgqaBwhlBkfaPAiAt12zt7dDGhFRZ5HSbU8Tc3NkGYqK2HZ
         tJP3A1aldRNXuDeTtmADqnlbwfkrUlb4gBabTRzK6sM+zretwoncESlZN2lO8P9oGNN9
         bWlOLWD9XRdqWJSO2ppjA+34On1U64ijwC2ttfBT4VlMrCx0fZArv7BU10l7JL5KmR9d
         b+41zKo6P3DKTs3CiIBfV2ivx6KvXZ+lrQoJA/LTagjK6/Ww+5IGQ3IjvDlOnoLjnTmW
         Yw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ukliw9sukrQW6ow50YsY/2wbM/35BtcU0cL0HgzMnLM=;
        b=cNEZZJVCcK0fdiA37UGBa9fFsiyslhdlImLvs80fTuMyb24ZpT4ju0AVmVfw+PRDLE
         AhUzB5uicHZgC8FxAzcctTRPgP8j/QGRRdxOjrGJXMg1J5m4OMWn+NSXMsMb1QTjTEJY
         6ZejAoRcE6znqoiO2w7CtPMoie3IaIuvYeCzU/ZK9n0IZSJElpVY0uovl0lk2bJA1+fb
         o1ni2vMbaUD9v20k4H6OPs2MAklQCJ7pBCE6JyBzi1/GfgYyegnKTTSxXIFDkyh7Jn6y
         HT6B/xZDReq+z1wFESgWBR2TzO+irb7KY0Tu2q5EQg4/Aalo5FCqYspj34jqGQf2CEPN
         pzrQ==
X-Gm-Message-State: AOAM532Yu5NUzNkfYobf37fw5BFOALsZBZHeZvoHxNLjyGif2jwbe4qo
        3Va2Ek0RI6LZJIvaoPAYOW0N2b7xqb5Nv6bQGhw=
X-Google-Smtp-Source: ABdhPJyQZXqAslD5Wtaiq3Z87kAq/zpe6tUPp3S8ENbcd+fSsQYcZRU1nOoYAZmA9Ux5tlyjLlB5qq2nd3AnF2TWv0w=
X-Received: by 2002:a17:906:478c:: with SMTP id cw12mr414096ejc.214.1643229187072;
 Wed, 26 Jan 2022 12:33:07 -0800 (PST)
MIME-Version: 1.0
References: <20220126202427.3047814-1-pgwipeout@gmail.com>
In-Reply-To: <20220126202427.3047814-1-pgwipeout@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 26 Jan 2022 17:32:55 -0300
Message-ID: <CAOMZO5CesC_mZDHhF93_1u6rMrmtc-pMaB8X28CX-npY_5BaDA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: synopsys/dw-hdmi: set cec clock rate
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Pierre-Hugues Husson <phh@phh.me>,
        Archit Taneja <architt@codeaurora.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        linux-rockchip@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 5:25 PM Peter Geis <pgwipeout@gmail.com> wrote:

> +
> +               ret = clk_set_rate(hdmi->cec_clk, HDMI_CEC_CLK_RATE);
> +               if (ret)
> +                       dev_warn(hdmi->dev, "Cannot set HDMI cec clock rate: %d\n", ret);

You are setting the cec clock rate after it has been enabled, which
can be glitchy.

Better to set the rate prior to enabling the clock.
