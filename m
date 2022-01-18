Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12034492153
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 09:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344481AbiARIhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 03:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343864AbiARIhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 03:37:08 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79B1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 00:37:08 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id l6-20020a17090a4d4600b001b44bb75a8bso2135134pjh.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 00:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tclGn/FiRJQbwpHi1/YABi2ORnKVDKyi6q1jYS35leY=;
        b=GcqAKeMVa6/4IkNacCw9otDzRpDX28nVEv5OF1TpqZZmJ1ZQb6TtCcfLTuGFsSu1hO
         phW4KAfvQTwiSSYwxeFoyrjrRaa7gUIKxv1vw8SVXmyLt/vJ/ZMUX9x+FXizkJ4rEJ0f
         pjNyCl4EhDmUQkBWi6rcWCTktIfwVgruK8aQWY8NTRVkJiPYNd9AHtPD4wAH2IR8+07t
         p+hLd47qhOrNOTkQHGmwuV/WoQVtSjhKtDExWoSOMCeiMtfScXXmj8HtHmloHDtqEV0w
         hLWBD6nlL5jPFFS7HE8id7wChtC7OVwufUwqS1i4cYOU9VXcC7k45L4aXnauGeepsS/Y
         dedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tclGn/FiRJQbwpHi1/YABi2ORnKVDKyi6q1jYS35leY=;
        b=OZes7L9MtLhX9H8Uf3DIvN2b8cM+e2M3+T23If4DdVHLYV3pg5XvHN3COIzJjbfc9O
         b1rbBhxQj2uYj39Rzr0/Kd7sjB0SztVfUqMuF24hPWtV14vLbh0TQIzX9+l9YqokSYr+
         Kbs1/Mf62YB7I/cMgIv43OSxfYM8AE33YfD9ao/8Hn4UqFd0N0dPJi8AKZtzYunXwBb/
         uIl3v+PsF2gh4AOEiq8oUFrHjrH/PpSuMvuZrBX1S8P4GpBZg/nmny2IAenQUnfhEpoo
         mEIybfMvgTMer6Ha/cFrc6dO20kjVY+zo+YmrzXiyax2SPbYC+YhIKiCsRcUzf28x8CC
         0mlA==
X-Gm-Message-State: AOAM532od/tekeVQtpuDlP/ZU0riYam0nn3x68EQhJICdwngMadsf5LY
        EhHpJmzLYyb/amEOPU1dMmMnOA==
X-Google-Smtp-Source: ABdhPJwfNHQ492Uz1jSVXHWDHlMxibTErMr09yFvEjODMjXrCCY9QQ/D08NSZpGdiZoI/53grjN20A==
X-Received: by 2002:a17:902:d483:b0:14a:58c5:3bf3 with SMTP id c3-20020a170902d48300b0014a58c53bf3mr26390855plg.106.1642495028323;
        Tue, 18 Jan 2022 00:37:08 -0800 (PST)
Received: from aqua.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id c6sm1775615pjo.39.2022.01.18.00.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 00:37:07 -0800 (PST)
From:   Tomohito Esaki <etom@igel.co.jp>
To:     dri-devel@lists.freedesktop.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ben Skeggs <bskeggs@redhat.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <mdaenzer@redhat.com>,
        Simon Ser <contact@emersion.fr>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Mark Yacoub <markyacoub@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Evan Quan <evan.quan@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org, Daniel Stone <daniel@fooishbar.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomohito Esaki <etom@igel.co.jp>,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>,
        Takanari Hayama <taki@igel.co.jp>
Subject: [RFC PATCH v4 0/3] Add support modifiers for drivers whose planes only support linear layout
Date:   Tue, 18 Jan 2022 17:36:49 +0900
Message-Id: <20220118083652.16335-1-etom@igel.co.jp>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers whose planes only support linear layout fb do not support format
modifiers.
These drivers should support modifiers, however the DRM core should handle this
rather than open-coding in every driver.

In this patch series, these drivers expose format modifiers based on the
following suggestion[1].

On Thu, Nov 18, 2021 at 01:02:11PM +0000, Daniel Stone wrote:
> I think the best way forward here is:
>   - add a new mode_config.cannot_support_modifiers flag, and enable
> this in radeon (plus any other drivers in the same boat)
>   - change drm_universal_plane_init() to advertise the LINEAR modifier
> when NULL is passed as the modifier list (including installing a
> default .format_mod_supported hook)
>   - remove the mode_config.allow_fb_modifiers hook and always
> advertise modifier support, unless
> mode_config.cannot_support_modifiers is set


[1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20190509054518.10781-1-etom@igel.co.jp/#24602575

v4:
* modify documentation for fb_modifiers_not_supported flag in kerneldoc

v3: https://www.spinics.net/lists/dri-devel/msg329102.html
* change the order as follows:
   1. add fb_modifiers_not_supported flag
   2. add default modifiers
   3. remove allow_fb_modifiers flag
* add a conditional disable in amdgpu_dm_plane_init()

v2: https://www.spinics.net/lists/dri-devel/msg328939.html
* rebase to the latest master branch (5.16.0+)
      + "drm/plane: Make format_mod_supported truly optional" patch [2]
  [2] https://patchwork.freedesktop.org/patch/467940/?series=98255&rev=3

v1: https://www.spinics.net/lists/dri-devel/msg327352.html
* The initial patch set

Tomohito Esaki (3):
  drm: introduce fb_modifiers_not_supported flag in mode_config
  drm: add support modifiers for drivers whose planes only support
    linear layout
  drm: remove allow_fb_modifiers

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  6 ++---
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |  2 ++
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |  2 ++
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |  1 +
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |  2 ++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 +++
 drivers/gpu/drm/drm_framebuffer.c             |  6 ++---
 drivers/gpu/drm/drm_ioctl.c                   |  2 +-
 drivers/gpu/drm/drm_plane.c                   | 22 +++++++++----------
 drivers/gpu/drm/nouveau/nouveau_display.c     |  6 +++--
 drivers/gpu/drm/radeon/radeon_display.c       |  2 ++
 .../gpu/drm/selftests/test-drm_framebuffer.c  |  1 -
 include/drm/drm_mode_config.h                 | 18 +++++----------
 include/drm/drm_plane.h                       |  3 +++
 14 files changed, 43 insertions(+), 33 deletions(-)

-- 
2.25.1

