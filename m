Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DB648D51F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 10:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbiAMJom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 04:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbiAMJog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:44:36 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70254C06173F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 01:44:36 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so18033154pjf.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 01:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p2XMzbBQjwW2hx/1bJAlmu8DNl3VlCTbTmtTvs1HKdQ=;
        b=sgLoGkz01hpZ513v3xEBTJO4YXazIJg9HYz0Ijw0OtM805EuQ6WfiIaPrI2V8bWfU7
         PaFYOmn54dp/Q/8f0CnUKUvjJVfOyUUBHShabNqZouJ9uXwwqulB4R0VjPW1TZVE3M+z
         xs2QLmJTlimxywzjcMvnCi2QwRVroOd9UM3TTYir5WsFzJFL4r87K/QJCqQx+YoFvYv0
         fiLkmjxy6kyB5Ggr0Q/+HU6YGvCyo+XIeY/tew6H+mWAkiRdPCkyw++dV0oBQ5brIx3g
         V8ZQLdNBc39XZnVIT9DFPKmCtnRjxH6qmAXYfcSCHf7xfiQcvUBWfFcONxdMmnkExODZ
         XGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p2XMzbBQjwW2hx/1bJAlmu8DNl3VlCTbTmtTvs1HKdQ=;
        b=bu/4kqoFVUBUGQbE9veHG7ahsVD/Zu3wRxDyVaLJrnCe6KkuQ5Szpk9iGq+Qk+CYCa
         GSuYD+IqdKH8CjLGdpZbjxbYMEAfq7QcYxUPdHsLnrbM1EB96OJMTEFkFGhFhlk4Mura
         hfm2ilQVJ34wSl3WRYrksyqk3XsHhUEufkSerrBCesf8f9fIajF7A9jZLiEPVAUeLYPP
         2yfYTJYf9QI+95jcFnDhugRbwWUuNtu3kXIoM+YxrWXVqNTIcMyPw63RsPF7bFznokpH
         zg8wRNH0CdpH0v4QdzwZ613alJJALkHjPDSxo0XtgsGVOsFyb9PhAmDb/3TnZAIdgWt6
         8vaw==
X-Gm-Message-State: AOAM533R3uJYV1Zf7T7ny+1IopGEB2FtmN3mFPDwFsT1HSF0N04AH/o3
        K6nDSKHaC89pWsa4UKui/bGQEw==
X-Google-Smtp-Source: ABdhPJw9HSf4DIolGlkgj/zyF2Kb7dNrSd+8P16LFtdLMslnsz37xKEfwmB+QwE5Eps5KmyIYR3/XA==
X-Received: by 2002:a17:902:9693:b0:149:1ce6:c284 with SMTP id n19-20020a170902969300b001491ce6c284mr3900970plp.119.1642067075969;
        Thu, 13 Jan 2022 01:44:35 -0800 (PST)
Received: from aqua.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id rm4sm2207154pjb.4.2022.01.13.01.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 01:44:35 -0800 (PST)
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
Subject: [RFC PATCH v2 0/3] Add support modifiers for drivers whose planes only support linear layout
Date:   Thu, 13 Jan 2022 18:44:16 +0900
Message-Id: <20220113094419.12433-1-etom@igel.co.jp>
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


v2:
* rebase to the latest master branch (5.16.0+) + "drm/plane: Make format_mod_supported truly optional" patch [2]
  [2] https://patchwork.freedesktop.org/patch/467940/?series=98255&rev=3

v1: https://www.spinics.net/lists/dri-devel/msg327352.html
* The initial patch set


Tomohito Esaki (3):
  drm: add support modifiers for drivers whose planes only support
    linear layout
  drm: set fb_modifiers_not_supported flag in legacy drivers
  drm: replace allow_fb_modifiers with fb_modifiers_not_supported

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  6 ++---
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |  2 ++
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |  2 ++
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |  1 +
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |  2 ++
 drivers/gpu/drm/drm_framebuffer.c             |  6 ++---
 drivers/gpu/drm/drm_ioctl.c                   |  2 +-
 drivers/gpu/drm/drm_plane.c                   | 22 +++++++++----------
 drivers/gpu/drm/nouveau/nouveau_display.c     |  6 +++--
 drivers/gpu/drm/radeon/radeon_display.c       |  2 ++
 .../gpu/drm/selftests/test-drm_framebuffer.c  |  1 -
 include/drm/drm_mode_config.h                 | 18 +++++----------
 include/drm/drm_plane.h                       |  3 +++
 13 files changed, 40 insertions(+), 33 deletions(-)

-- 
2.25.1

