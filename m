Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37B246B3E8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 08:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhLGHeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 02:34:24 -0500
Received: from marcansoft.com ([212.63.210.85]:35528 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229765AbhLGHeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 02:34:23 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 7EF2F41F7F;
        Tue,  7 Dec 2021 07:30:48 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH v2 0/3] drm/simpledrm: Apple M1 / DT platform support fixes
Date:   Tue,  7 Dec 2021 16:29:40 +0900
Message-Id: <20211207072943.121961-1-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi DRM folks,

This short series makes simpledrm work on Apple M1 (including Pro/Max)
platforms the way simplefb already does, by adding XRGB2101010 support
and making it bind to framebuffers in /chosen the same way simplefb
does.

This avoids breaking the bootloader-provided framebuffer console when
simpledrm is selected to replace simplefb, as these FBs always seem to
be 10-bit (at least when a real screen is attached).

Changes since v1:
- Moved the OF platform device setup code from simplefb into common
  code, instead of duplicating it in simpledrm
- Rebased on drm-tip

Hector Martin (3):
  of: Move simple-framebuffer device handling from simplefb to of
  drm/format-helper: Add drm_fb_xrgb8888_to_xrgb2101010_toio()
  drm/simpledrm: Add XRGB2101010 format

 drivers/gpu/drm/drm_format_helper.c | 62 +++++++++++++++++++++++++++++
 drivers/gpu/drm/tiny/simpledrm.c    |  2 +-
 drivers/of/platform.c               |  5 +++
 drivers/video/fbdev/simplefb.c      | 21 +---------
 include/drm/drm_format_helper.h     |  3 ++
 5 files changed, 72 insertions(+), 21 deletions(-)

-- 
2.33.0

