Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AA257E917
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 23:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbiGVVuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 17:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235910AbiGVVuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 17:50:04 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA42AB878A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 14:50:03 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id h22so4481901qta.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 14:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lY5HwzJY1HkC64NTT7rUzz8AV8+0iYgX1A3GOOVUboY=;
        b=gGSSMB3IuQ03GboemI4CuYy3gKQ3itbdhDripv2Bf+5aLkKcbxEm9Jnu1zZXTRqono
         TXJSA1bwkt2PbWgNi5oXyZ1jbxHwdKSM9vFC2pDtqwsX9sJ2+RAPB8rYGSyCHM9B+2KE
         /aw+T4CksZacPn6Na5E9FJpGS9Hc5wZbMmyz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lY5HwzJY1HkC64NTT7rUzz8AV8+0iYgX1A3GOOVUboY=;
        b=bZm/Dt12ypYIThDq4u+cIGERjqraWHE223lgMqf4GnaVu054RkKCZSrcyyohLzVc32
         +rYL54ZcYFhZA1djy5BcRPdM0j76m2wy1e/TIcsTZm3O9dwRCTYWvu4dIbR4fp7zmWdu
         AmrMAew0/aiUA3OCHtwZkGbmfbcKyHt1si/MicbkpbgcqH4u09XrXAR6JpOikTk3/XPt
         jhYox18jt6oxo+nizwx+OvU0u19olsdrOzN+nwY04N34tc9B/OvcHSTDlGZQrDefwjeu
         gwH/8dlxCzvagz31Ciwka3uQPgJ0r5cKnfvoCaNGnzueFtqJBJN/PuBm8Boez6otX8au
         PLUw==
X-Gm-Message-State: AJIora+xYOROZD0az5ZRn5LQzv6wv2FrYdrZLbEYwXx7mZzLTYAdsBoa
        fyRMnt8Fi9fBLDSgEsDRJaz72Zd9VYV36DYq
X-Google-Smtp-Source: AGRyM1t0bg10Rc1JMRJaH05Q/CdwawRrdAHKfoEN8GtAxOYBq6POcf0qA1/DpBwWt1/i1yyXyEb5Mw==
X-Received: by 2002:ac8:5e0d:0:b0:31f:239c:99c6 with SMTP id h13-20020ac85e0d000000b0031f239c99c6mr1969906qtx.189.1658526602771;
        Fri, 22 Jul 2022 14:50:02 -0700 (PDT)
Received: from jshargo (pool-108-14-42-16.nycmny.fios.verizon.net. [108.14.42.16])
        by smtp.gmail.com with ESMTPSA id h22-20020ac87156000000b0031ef622a6a2sm3399575qtp.17.2022.07.22.14.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 14:50:02 -0700 (PDT)
From:   Jim Shargo <jshargo@chromium.org>
To:     jshargo@google.com,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Jim Shargo <jshargo@chromium.org>, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] drm/vkms: Add ConfigFS Support
Date:   Fri, 22 Jul 2022 17:50:01 -0400
Message-Id: <20220722215001.1380608-1-jshargo@chromium.org>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intro
=====

This patchset adds basic ConfigFS support to VKMS, allowing users to
build new DRM devices with user-defined DRM objects and object
relationships by creating, writing, and symlinking files.

Usage
=====

Modprobe VKMS and mount ConfigFS:

  $ mkdir -p /config/; mount -t configfs
  $ modprobe vkms enable_overlay=1 enable_cursor=1 enable_writeback=1

This will create a `/config/vkms` directory, where users may create
new VKMS devices. The standard default device is still created, so
existing use-cases should be unaffected.

Creating a new device happens in three stages:

  1) Create a new directory to represent a new device:
       $ mkdir /config/vkms/dev

  2) Populate the new device with crtcs, planes, connectors, encoders,
     and CRTCs by mkdir'ing in the appropriate directories. Connect the
     objects via symlinks.

  3) To register the device:
       $ echo 1 > /config/vkms/dev/is_registered

If the write is successful, you have a new VKMS device ready to use!

See the updated vkms.rst for more details and a full example.

Changes within VKMS
===================

The most meaningful change within VKMS is the introduction of a list
of "cards" representing individual virtual drivers. Each card
maintains its own devices, arrays of objects, and output/writeback
machinery.

Until cards are registered, all of their data lives in within the
ConfigFS tree. Only during registration do we interface with DRM at
all to create the device.

Due to limitations with ConfigFS, the default device is a special
case, without all of the objects represented in its ConfigFS
directory.

Testing
=======

Suspend tests are not working in my VM, so I skipped those. Otherwise,
here are the tests that I have been running:

  $ igt-gpu-tools/scripts/run-tests.sh -x ".*suspend.*" \
        -t ".*kms_flip.*" \
        -t ".*kms_writeback.*" \
        -t ".*kms_cursor_crc*" \
        -t ".*kms_plane.*"

I've observed no changes between passed/failed tests before and after
my changes on the default device.

IGT revision: eddc67c5c85b8ee6eb4d13752ca43da5073dc985

I'll also note that I've been working on a VKMS test suite in IGT that
exercises the new ConfigFS behavior, and that it's a work-in-progress.

Future Work
===========

This should be the biggest and most invasive change in VKMS to make it
more configurable and able to mimic real devices. That said, it should
serve as a basis for additional useful features, including:

  - Simulating hot-plugging by keeping the connectors directory live
    and allowing users to add/remove connectors after the device is
    registered.
  - Additional properties could be turned on and off, or tuned, based
    on files within object directories. For instance, GAMMA/DEGAMMA
    LUT sizes could be configurable per-device, or support for
    individual formats could be turned on and off.

Additional Notes
================

This is my first kernel patchset, and though I've had it reviewed by
my team (with a lot of of kernel/drm expertise), I recommend reading
it with a bit of extra scrutiny. As you can tell by the fact this
didn't get mailed with the other patches :P.

Thanks!

Jim Shargo (5):
  drm/vkms: Merge default_config and device
  drm/vkms: VKMS now supports more than one "card"
  drm/vkms: Support multiple objects (crtcs, etc.) per card
  drm/vkms: Add ConfigFS scaffolding to VKMS
  drm/vkms: Support registering configfs devices

 Documentation/gpu/vkms.rst            |  76 ++++
 drivers/gpu/drm/Kconfig               |   1 +
 drivers/gpu/drm/vkms/Makefile         |   1 +
 drivers/gpu/drm/vkms/vkms_composer.c  |  28 +-
 drivers/gpu/drm/vkms/vkms_configfs.c  | 546 ++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_crtc.c      |  88 +++--
 drivers/gpu/drm/vkms/vkms_drv.c       | 204 ++++++----
 drivers/gpu/drm/vkms/vkms_drv.h       | 173 ++++++--
 drivers/gpu/drm/vkms/vkms_output.c    | 335 +++++++++++++---
 drivers/gpu/drm/vkms/vkms_plane.c     |  43 +-
 drivers/gpu/drm/vkms/vkms_writeback.c |  27 +-
 11 files changed, 1288 insertions(+), 234 deletions(-)
 create mode 100644 drivers/gpu/drm/vkms/vkms_configfs.c

-- 
2.37.1.359.gd136c6c3e2-goog

