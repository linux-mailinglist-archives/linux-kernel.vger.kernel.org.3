Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A78549030C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 08:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237629AbiAQHpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 02:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiAQHpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 02:45:22 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AACAC06161C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 23:45:22 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id m3so40273186lfu.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 23:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nVojK749fmbikJ8Ylv61w+rfH9eMOuHdf6x9SWu9cSY=;
        b=SUwsxZsxjvlQaEwoE7XT7C+KHZ9jGQQayZYDeXg5DlUCjdR5AwuUOSqu5Vnxhj5hfU
         cZct8MLYPqEIXtyX72Hymgmw/UKBQ1+Skmdl8fCeXQDsuDDeIpc+chJKRuX7BUddxkgp
         I/CiGnBzl6R++Z3e4nfaDlKGmOZMTWnoQWeYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nVojK749fmbikJ8Ylv61w+rfH9eMOuHdf6x9SWu9cSY=;
        b=G/lhpbsqegIlO3kvOWkoAizmsGmwCmS36k+Ow4iHMBD9sTjX9FBGPaZyuyM3bw1Ptj
         jCucIcvAnViREOiUM7oJzKeE2hFeuLTmoAvTLsU/RrMpEFxRuBLJXDFFcqGqlicTBd22
         TCdUW6Yh9Skh+oTiZb5DAH/RWP2/xhhXzGUPfSMYrEq2K07O1LuE24fNfsJ0wCiTnh3K
         9BolPfzfQ8p6doK9uZrFAlvcPexIZlboWyyFgvBsFx+RFS5CbFjhkLBrrjxAiWeVsTH2
         xgVof2dUrs06jgu7W2wV9ODqmoYJVOXH+Fmn5MqT23exqZmX6lcSCCvaShKE26gybEKH
         1rGA==
X-Gm-Message-State: AOAM530CpNCRB6nvR/XV5GTMq0jQKY71xBWPWvrzYd6ZLopP5NCBIOdB
        pBqShIgrQ3D7MQfBEOEWZds9/arn+2DC2AkdfoaJ5g==
X-Google-Smtp-Source: ABdhPJwG9NvWR9p35lcYW0jwX/k5v4481qRKalDO5NxJSEYxWGLzootcvrIELTsY/GzSoLCDQfiA7L3OWsPgQKfrGNM=
X-Received: by 2002:a2e:2285:: with SMTP id i127mr4064849lji.414.1642405520722;
 Sun, 16 Jan 2022 23:45:20 -0800 (PST)
MIME-Version: 1.0
References: <20220114230209.4091727-1-briannorris@chromium.org> <20220114150129.v2.2.I20d754a1228aa5c51a18c8eb15a2c60dec25b639@changeid>
In-Reply-To: <20220114150129.v2.2.I20d754a1228aa5c51a18c8eb15a2c60dec25b639@changeid>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 17 Jan 2022 15:45:09 +0800
Message-ID: <CAGXv+5Gm4ru8m5bZV_zm10U+FQRBSw7qq1eiL+hh+Z=5pZ7pYQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] drm/rockchip: cdn-dp: Support HDMI codec
 plug-change callback
To:     Brian Norris <briannorris@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-rockchip@lists.infradead.org, Lin Huang <hl@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Sandy Huang <hjc@rock-chips.com>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2022 at 7:03 AM Brian Norris <briannorris@chromium.org> wrote:
>
> Some audio servers like to monitor a jack device (perhaps combined with
> EDID, for audio-presence info) to determine DP/HDMI audio presence.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
