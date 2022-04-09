Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF774FA1BA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 04:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240629AbiDICjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 22:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiDICjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 22:39:11 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB76B2B9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 19:37:05 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r66so9331450pgr.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 19:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k0r4eugt/zHQSwmjktu+6LYEjQZQ8ZAZdKlNVpJcKJU=;
        b=I8mJTJYqOErm2ec//WI+XTEovyymBRMahAIacDQgqkTgdMcYuibYVSQdv2LVeO0HOy
         8Lb1S2uWve12AKz9ZK8hFYNF5BXUrwfCVbrZuP5MWkmtfzkPUI0GJmyMLQkK/sh6pSO1
         WXgsqljLwtoYQl/lgROvlA8KTA8SFTlXG0EVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k0r4eugt/zHQSwmjktu+6LYEjQZQ8ZAZdKlNVpJcKJU=;
        b=C8m/0B6E+lODW5QljL8m6QRxDlD1wqezvSHhb7zNawgiaSokrrYBlZ66IYfECYT0Sc
         e/f4j7Ay+5EpevI0ZFh3YFLyoBjhxJs4Vly1Q1Yd2dPQVcEtPu5Yr197nwoNE+vdjqM/
         jmv0tsGY7QC+kcfo/3L2gNWEZXClNkXoi/9IuQvi06BY7h2hxZ55XE52ihn73vDl0z6k
         LZFR2nWsNg58o44OL4rkrV9scS8bTBmzzQGE1irI3vz3pWHvvLLNioWd4+x2yHnXAqlc
         dTODvmnxWecnxN/Alx/JiIzDq4dPKUEtBQDtKe6hqwWE+30GGRY8qtTRm1rkMJVYRn+/
         m3xw==
X-Gm-Message-State: AOAM532vsbs1P8RqfAiy0W2rCw4CnmmDfDxZ1Ym2APaWSGzTaJSP9tC/
        8A7TU+fJQ8w3LeYn1QO0q9xFEQ==
X-Google-Smtp-Source: ABdhPJyHdJUiczO0eILsMOQhkv7fmwI8W0QSVzkpdCsY8n0607fbDN/FuUPnIR7FGuzc6v2Ce5dP1w==
X-Received: by 2002:a63:6a88:0:b0:398:54fb:85ba with SMTP id f130-20020a636a88000000b0039854fb85bamr18035803pgc.88.1649471825230;
        Fri, 08 Apr 2022 19:37:05 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:17db:64e:48d4:a4e])
        by smtp.gmail.com with ESMTPSA id 188-20020a6215c5000000b0050597294893sm759999pfv.124.2022.04.08.19.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 19:37:04 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Robert Foss <robert.foss@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Philip Chen <philipchen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Kees Cook <keescook@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lyude Paul <lyude@redhat.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/6] drm/dp: Improvements for DP AUX channel
Date:   Fri,  8 Apr 2022 19:36:22 -0700
Message-Id: <20220409023628.2104952-1-dianders@chromium.org>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch addresses pre-existing issues that came up during the
review process of Sankeerth's series trying to add eDP for Qualcomm
SoCs [1].

It's really sorta two series but jammed into one. The first two
patches fix a problem with ps8640 when the panel doesn't finish
probing right away. The rest of the patches attempt to improve how eDP
panel drivers deal with the HPD signal. NOTE: if everyone hates the
"generic driver" that I added in the first patch, I have a different
version that just adds uses the Linux auxiliary bus stright in
ps8640. I'm happy to switch back to that, but it seemed like a buncha
copy-pasta that I was hoping to avoid.

I haven't done a crazy amount of testing with this, but it seems to
work and I wanted to get something out there. I'll try to do some more
testing next week. This is why I added the tag "RFC". It's entirely
possibled that I've actually caught all the bugs and this is great,
but I just wanted to be sure.

This _doesn't_ attempt to fix the Analogix driver. If this works out,
ideally someone can post a patch up to do that.

[1] https://lore.kernel.org/r/1648656179-10347-2-git-send-email-quic_sbillaka@quicinc.com/


Douglas Anderson (6):
  drm/dp: Helpers to make it easier for drivers to use DP AUX bus
    properly
  drm/bridge: parade-ps8640: Break probe in two to handle DP AUX better
  drm/dp: Add is_hpd_asserted() callback to struct drm_dp_aux
  drm/panel-edp: Take advantage of is_hpd_asserted() in struct
    drm_dp_aux
  drm/panel: atna33xc20: Take advantage of is_hpd_asserted() in struct
    drm_dp_aux
  drm/bridge: parade-ps8640: Provide is_hpd_asserted() in struct
    drm_dp_aux

 drivers/gpu/drm/bridge/parade-ps8640.c        |  87 +++++----
 drivers/gpu/drm/dp/drm_dp_aux_bus.c           | 165 +++++++++++++++++-
 drivers/gpu/drm/panel/panel-edp.c             |  37 +++-
 .../gpu/drm/panel/panel-samsung-atna33xc20.c  |  35 +++-
 include/drm/dp/drm_dp_aux_bus.h               |  58 ++++++
 include/drm/dp/drm_dp_helper.h                |  14 ++
 6 files changed, 353 insertions(+), 43 deletions(-)

-- 
2.35.1.1178.g4f1659d476-goog

