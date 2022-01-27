Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E570649D92D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 04:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbiA0DZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 22:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiA0DZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 22:25:52 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3367C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 19:25:52 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id my12-20020a17090b4c8c00b001b528ba1cd7so1590817pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 19:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kijqoOwlh2nBinX5T4jaToM6MBMxe8W6w3/1AdS3Yq4=;
        b=UZ/5sgr03EHCHuKWtyXr3V6fpDy0NQnn2m8IOrHrEIpwrXMhmlcleuv3c66PXbvwGm
         eTEfreUdGDHQHMzxgMMhHmYHYdPbdbyG/R3F0b0lGmHkAMWK6erVFMHU2NEGI4MU2X3h
         E3DD4PLRhTR7xYsYhpS8/K8UOKyLizlmg9d8btyW4pYji/92OuvsZNaef8qwIsu5R0ir
         qR94W7u2/of6FedsP1qR0u+uhm+NtIRMi0xul1S7dqty0VRimsPLf2HtFITMtzqrHeJL
         +gsRsF6L1O0jt1sWX8AvhnvLa09oQ+VsNLoRkI3A33w6dACWp5uaErUPSPWCgAU+eLGI
         MNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kijqoOwlh2nBinX5T4jaToM6MBMxe8W6w3/1AdS3Yq4=;
        b=ONJDPF4pUGzxhWeJxG8vTsd22l8agB33N0Gg4AVcDUwCp8A+Hfb4JltuGY1pgwhe5Y
         FT5i2Okjin9kahGNcoEcQYEXfZqVI4zFu+lP8myLw7kU15ScilPVxhBiRF63pgnmv/UK
         oRiiXsb/Svnl+bVbKAZd1zgFOjQqAvOFyjkSSTJ+d7OJxz7Z5L6O+5mOk8jlbLcc8Cz9
         CUY/nn/LVRv+jPhtys+iVGxU6DUZA0Yhgrj39G78CVov+tdPSmKj8xDHBYVfj0U4HkTf
         TzmLV19i5VaQWIuGTiv+t7mMnBeU+3PQqhew9+QN0u8PuN5moNoIZD7Z95yreSQ65GhA
         08OQ==
X-Gm-Message-State: AOAM533gFiRVEvL64YsrD1VuPP3bFpWG+0KBdAuPEk7SOO3XAFOWdiYO
        Vh+WU9WiNXasf5KLJUudloNEuA==
X-Google-Smtp-Source: ABdhPJyNPV3msBn+KKKict8VHo/xq7GgpwlrbMX/o5U/v/DVxAdiwwKL3Q8bOpUtoZ9o+KbrRIZWIQ==
X-Received: by 2002:a17:902:be14:: with SMTP id r20mr1677757pls.97.1643253952215;
        Wed, 26 Jan 2022 19:25:52 -0800 (PST)
Received: from aqua.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id t15sm4203111pjy.17.2022.01.26.19.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 19:25:51 -0800 (PST)
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
Subject: [RFC PATCH v5 0/3] Add support modifiers for drivers whose planes only support linear layout
Date:   Thu, 27 Jan 2022 12:25:36 +0900
Message-Id: <20220127032539.9929-1-etom@igel.co.jp>
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

v5:
* rebase to the latest master branch (5.17-rc1+)
	+ "drm/plane: Make format_mod_supported truly optional" patch [2]
  [2] https://patchwork.freedesktop.org/patch/467940/?series=98255&rev=3

* change default_modifiers array from non-static to static
* remove terminator in default_modifiers array
* use ARRAY_SIZE to get the format_modifier_count
* keep a sanity check in plane init func
* modify several kerneldocs

v4: https://www.spinics.net/lists/dri-devel/msg329508.html
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
 drivers/gpu/drm/drm_plane.c                   | 23 +++++++++++--------
 drivers/gpu/drm/nouveau/nouveau_display.c     |  6 +++--
 drivers/gpu/drm/radeon/radeon_display.c       |  2 ++
 .../gpu/drm/selftests/test-drm_framebuffer.c  |  1 -
 include/drm/drm_mode_config.h                 | 18 +++++----------
 include/drm/drm_plane.h                       |  3 +++
 14 files changed, 45 insertions(+), 32 deletions(-)

-- 
2.25.1

