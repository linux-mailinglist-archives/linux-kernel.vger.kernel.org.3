Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65B048F0D2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 21:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244215AbiANURM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 15:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbiANURK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 15:17:10 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A820FC06161C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 12:17:10 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id hv15so14349567pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 12:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1KlPp5hV7fm0qq5cqvD5aoj0BfkxebgR6vlczP+kuR0=;
        b=hPBL7+GzXtx7Xy9BNRGobBHcJh3in4NXqnnYC06hntRlpfp/vjmD9i9XpuCMkppYe0
         KTPskbaS26eaCBp9BJJSJSoDjVC7Re+360GTMca2engSbymUQqzvGV7YvvxDdrJ6Auu1
         1qigxd68D5GnHmbXdB/NPhH0nNGBQ1nZC2LHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1KlPp5hV7fm0qq5cqvD5aoj0BfkxebgR6vlczP+kuR0=;
        b=wGLNXaNQiK/4UXjLrIDgh6Z+1+U9ezBXOdVSTH2gm38Gy91qfkSyYY1qBx/8Z4RsIo
         zyvE4fZMDdQacfpjQICMuhXf8qtuH6oF5biU+5UD7suIAGjYdK37Ntyh18e+h/DUTTGF
         Gd4LQLL4yABHQEqU7gIAfHs+R9K6R6ZHNKyLLgd5T70I5eLHY37XwgbOqDAjBf2JxOLY
         MazOvSJK0MOd0FTaKz3BQYBBeQedYPqkkpahFGfMt5qrAFrQYxM+YW93guQ6LnyTVu+r
         omTsLaP9H+BHC3E6bb1i876Tw3U+ivB4zfvGcb1sgVLjr+JY4f0GZ2R4H50b3FC8hbNa
         w4hQ==
X-Gm-Message-State: AOAM531hwtFZvx5c/RJbF+9UHEUZoKK9e9lFcoE03++m2eGGKVLwIKc4
        NsuPM/9o8QMSkQG91aaliik9rg==
X-Google-Smtp-Source: ABdhPJyYDhYmzb1m8B5ltHSl6+g7+4DhFkP602unTzHjzxK1IseRAPUhU48jZq5jKbANYv16P6nwIQ==
X-Received: by 2002:a17:902:ea07:b0:14a:45c0:78a7 with SMTP id s7-20020a170902ea0700b0014a45c078a7mr11123208plg.92.1642191430200;
        Fri, 14 Jan 2022 12:17:10 -0800 (PST)
Received: from localhost ([2620:15c:202:201:76ab:ede1:503d:1c39])
        by smtp.gmail.com with UTF8SMTPSA id q12sm6599881pfk.136.2022.01.14.12.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 12:17:09 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, Sandy Huang <hjc@rock-chips.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Lin Huang <hl@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 0/3] (Re)enable DP/HDMI audio for RK3399 Gru
Date:   Fri, 14 Jan 2022 12:16:49 -0800
Message-Id: <20220114201652.3875838-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes DP/HDMI audio for RK3399 Gru systems.

First, there was a regression with the switch to SPDIF. Patch 1 can be
taken separately as a regression fix if desired. But it's not quite so
useful (at least on Chrome OS systems) without the second part.

Second, jack detection was never upstreamed, because the hdmi-codec
dependencies were still being worked out when this platform was first
supported.

Patches cover a few subsystems. Perhaps this is something for arm-soc?


Brian Norris (3):
  arm64: dts: rockchip: Switch RK3399-Gru DP to SPDIF output
  drm/rockchip: cdn-dp: Support HDMI codec plug-change callback
  ASoC: rk3399_gru_sound: Wire up DP jack detection

 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 10 +++----
 drivers/gpu/drm/rockchip/cdn-dp-core.c       | 28 ++++++++++++++++++++
 drivers/gpu/drm/rockchip/cdn-dp-core.h       |  4 +++
 sound/soc/rockchip/rk3399_gru_sound.c        | 20 ++++++++++++++
 4 files changed, 57 insertions(+), 5 deletions(-)

-- 
2.34.1.703.g22d0c6ccf7-goog

