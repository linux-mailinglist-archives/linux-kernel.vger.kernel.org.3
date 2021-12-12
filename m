Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEDF64718DB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 07:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbhLLGYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 01:24:21 -0500
Received: from marcansoft.com ([212.63.210.85]:49568 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229511AbhLLGYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 01:24:18 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 990CF424CD;
        Sun, 12 Dec 2021 06:24:12 +0000 (UTC)
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
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: [PATCH v3 0/3] drm/simpledrm: Apple M1 / DT platform support fixes
Date:   Sun, 12 Dec 2021 15:24:04 +0900
Message-Id: <20211212062407.138309-1-marcan@marcan.st>
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

Changes since v2:
- Made 10-bit conversion code fill the LSBs
- Added ARGB2101010 to supported formats list
- Simplified OF core code per review feedback
Hector Martin (3):
  of: Move simple-framebuffer device handling from simplefb to of
  drm/format-helper: Add drm_fb_xrgb8888_to_xrgb2101010_toio()
  drm/simpledrm: Add [AX]RGB2101010 formats

 drivers/gpu/drm/drm_format_helper.c | 64 +++++++++++++++++++++++++++++
 drivers/gpu/drm/tiny/simpledrm.c    |  4 +-
 drivers/of/platform.c               |  4 ++
 drivers/video/fbdev/simplefb.c      | 21 +---------
 include/drm/drm_format_helper.h     |  3 ++
 5 files changed, 74 insertions(+), 22 deletions(-)

-- 
2.33.0

