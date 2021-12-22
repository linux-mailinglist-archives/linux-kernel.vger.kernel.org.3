Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C694047CCA6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 06:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241868AbhLVF1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 00:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbhLVF1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 00:27:38 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC196C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 21:27:38 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id r138so1065718pgr.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 21:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9q1trsl42X2XG3aKGHikEKkUb0EC574TM7EXShQRQcE=;
        b=4kR2BHFtUXwCL5DcgXSXuRhVxvqeUnA6q6mLf3s1u/IfZSeJ57CtUT8ElTNyrWDC5A
         O8xxlScCb7DYJ+cv79NjTfAj/5LTlzHFTTuqluyQo1oToCEg1JiBKOzEWO23jP1yyHVW
         O+ez1E8IjVlIFxARG5meWo3ehA9CUwpjAOp+J5MVEHUxvcOIjH6IvN50ePJ+xGIYeio6
         b4lIfKwYrkPzgOigc5K8VcxRpWZz+oMCzPDlG7B+apdS9VG/jEhfiskVn5xxsd1uyrzv
         aIiOdHJZE+CJ8sE41m+6G7dx9MTevFBb+9uyVe8dAJn1yuVR3TetvxyQObQhlxvdrb+A
         Szxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9q1trsl42X2XG3aKGHikEKkUb0EC574TM7EXShQRQcE=;
        b=Kiugv8L2X8iTDtg4xBjkvl0OOS92cTpiNG/6whivNgD+jz9QMizNTNFzl9iltbzGv5
         pjJx1+ZqBkjuZvXoBR/CYqMpsgJbN8dFqdNOYUSjNamkFSVLvqE89fpNxAS1CpFCJalX
         oh4ygz039qHheRZyk8SiweF6ZnLy06LE8QiNBnP4Ix79T08YTwLg13+efwz3WX5fdcPa
         Sc+bMNpH3ACGYGije+YmR6oOiVgOtXGOClrGgppX5XfJPufB33DBJ0MUJXeVGsqpEYvy
         TXAeeyWWygx0BjwDo3EYSJoDz1es9vEIB1zPwK6ErwYIj4NS/6mPM+SHdYNdMHDKzW88
         r8Ng==
X-Gm-Message-State: AOAM531eZkV80xky5EE7Ah4WcG1r3JCX+QJwpFDNNjgP74069hf9o//u
        fAMIcvnVsc6A+tHRk3Npi9h4/A==
X-Google-Smtp-Source: ABdhPJzR9+Nt6GYIKekgjSsIg+Hr4zJi/uXp6MFOIzEbn+Y6xAXUkBAqSDmlpkyMz5zshJTmt75I1w==
X-Received: by 2002:a62:25c3:0:b0:4ba:7afa:3788 with SMTP id l186-20020a6225c3000000b004ba7afa3788mr1692806pfl.23.1640150857792;
        Tue, 21 Dec 2021 21:27:37 -0800 (PST)
Received: from aqua.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id v63sm737465pgv.71.2021.12.21.21.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 21:27:37 -0800 (PST)
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
        nouveau@lists.freedesktop.org, Tomohito Esaki <etom@igel.co.jp>,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>,
        Takanari Hayama <taki@igel.co.jp>
Subject: [RFC PATCH 0/3] Add support modifiers for drivers whose planes only support linear layout
Date:   Wed, 22 Dec 2021 14:27:24 +0900
Message-Id: <20211222052727.19725-1-etom@igel.co.jp>
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


Tomohito Esaki (3):
  drm: add support modifiers for drivers whose planes only support
    linear layout
  drm: set fb_modifiers_not_supported flag in legacy drivers
  drm: replace allow_fb_modifiers with fb_modifiers_not_supported

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  6 +--
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |  2 +
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |  2 +
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |  1 +
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |  2 +
 drivers/gpu/drm/drm_framebuffer.c             |  6 +--
 drivers/gpu/drm/drm_ioctl.c                   |  2 +-
 drivers/gpu/drm/drm_plane.c                   | 41 +++++++++++--------
 drivers/gpu/drm/nouveau/nouveau_display.c     |  6 ++-
 drivers/gpu/drm/radeon/radeon_display.c       |  2 +
 .../gpu/drm/selftests/test-drm_framebuffer.c  |  1 -
 include/drm/drm_mode_config.h                 | 18 +++-----
 include/drm/drm_plane.h                       |  3 ++
 13 files changed, 54 insertions(+), 38 deletions(-)

-- 
2.17.1
