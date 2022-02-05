Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFEF4AA4ED
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 01:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378702AbiBEAOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 19:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239054AbiBEAOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 19:14:10 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EB3D8399EF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 16:14:08 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id h20-20020a17090adb9400b001b518bf99ffso14548001pjv.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 16:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=96SFyVQfbv/E/8NQyz3WLTVz461yfR2KLa0ZPZCtqDg=;
        b=IgKO/kM+ZjoHRFFP4hCXWCqNnbvj2TAjzdBKNPx82LhlBCVxOqy5DVhGwc1qu+2G9s
         jz147LFM9YpYPwlGTt3OMcFEO+GmtJUPTtuEL137l4L95KiMrLAYmrSIMuFpEXH7TOim
         u2JQ9Sj+1ruQBNcePfY+M4tDlzvVf2ueWWtxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=96SFyVQfbv/E/8NQyz3WLTVz461yfR2KLa0ZPZCtqDg=;
        b=VQwQKmQbeyDttIMO7fFARuo+l1N5eDdXBIQ3zVwjLs1mmAM8wropmdLTzldje/7OoE
         wVyzguFJrvySOvlrcJRRLu+exI7TArEd9alstavimQCynBmzc+a5EWBDfx//hTmB0isG
         KAfO517TpPNM8xHvTfu/eRdLk6xmZnHKEtCVLvGjYp4mZYTUDAUO1/7uwOo6GjekBNnc
         L2VyuA3FSevvcCV+j0qfzFklgNgEGTcpDAa02t0+42g4rfepMHggCEnLCpb9Ao7yhJdm
         8XFTlh6TKf7W0idId/9evl4asvsowD53Wz8VVTAPIV5Lg5BTkZBE7l8R2sbh2q03SFhY
         SK6Q==
X-Gm-Message-State: AOAM531IBA3g5WN0k6RTDw9IGzsrPdI3YeabwI2i80qOLKp5eWl0EiBH
        XH/coYrBgPd62Gd10UvNLyCorQ==
X-Google-Smtp-Source: ABdhPJw9uTa9AOHSgwRNU6QqwbQftcU9rsyBtjV4lm4ZSQb3R6M6nncuQObIRAtbxuD7CEaiIYIXQw==
X-Received: by 2002:a17:90b:3ec4:: with SMTP id rm4mr6007176pjb.102.1644020047929;
        Fri, 04 Feb 2022 16:14:07 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:d668:55ac:a465:88bf])
        by smtp.gmail.com with ESMTPSA id q13sm3720231pfj.44.2022.02.04.16.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 16:14:07 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        robert.foss@linaro.org, lschyi@chromium.org,
        Sam Ravnborg <sam@ravnborg.org>, jjsu@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] drm/panel-edp: Debugfs for panel-edp
Date:   Fri,  4 Feb 2022 16:13:39 -0800
Message-Id: <20220205001342.3155839-1-dianders@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main goal of this series is the final patch in the series: to
allow test code to reliably find out if we ended up hitting the
"fallback" case of the generic edp-panel driver where we don't
recognize a panel and choose to use super conservative timing.

Version 1 of the patch actually landed but was quickly reverted since
it was pointed out that it should have been done in debugfs, not
sysfs.

As discussed on IRC [1], we want this support to be under the
"connector" directory of debugfs but there was no existing way to do
that. Thus patch #2 in the series was born to try to plumb this
through. It was asserted that it would be OK to rely on a fairly
modern display pipeline for this plumbing and perhaps fail to populate
the debugfs file if we're using older/deprecated pipelines.

Patch #1 in the series was born because the bridge chip I was using
was still using an older/deprecated pipeline. While this doesn't get
us fully to a modern pipeline for ti-sn65dsi86 (it still doesn't move
to "NO_CONNECTOR") it hopefully moves us in the right direction.

This was tested on sc7180-trogdor devices with _both_ the ti-sn65dsi86
and the parade-ps8640 bridge chips (since some devices have one, some
the other). The parade-ps8640 already uses supports "NO_CONNECTOR",
luckily.

[1] https://people.freedesktop.org/~cbrill/dri-log/?channel=dri-devel&date=2022-02-02

Changes in v2:
- ("ti-sn65dsi86: Use drm_bridge_connector") new for v2.
- ("drm: Plumb debugfs_init through to panels") new for v2.
- Now using debugfs, not sysfs

Douglas Anderson (3):
  drm/bridge: ti-sn65dsi86: Use drm_bridge_connector
  drm: Plumb debugfs_init through to panels
  drm/panel-edp: Allow querying the detected panel via debugfs

 drivers/gpu/drm/bridge/panel.c         | 12 +++++
 drivers/gpu/drm/bridge/ti-sn65dsi86.c  | 72 +++++---------------------
 drivers/gpu/drm/drm_bridge_connector.c | 15 ++++++
 drivers/gpu/drm/drm_debugfs.c          |  3 ++
 drivers/gpu/drm/panel/panel-edp.c      | 37 +++++++++++--
 include/drm/drm_bridge.h               |  7 +++
 include/drm/drm_connector.h            |  7 +++
 include/drm/drm_panel.h                |  8 +++
 8 files changed, 98 insertions(+), 63 deletions(-)

-- 
2.35.0.263.gb82422642f-goog

