Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB244950C5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376286AbiATPA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:00:59 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:59005 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235669AbiATPAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:00:50 -0500
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 2708D200010;
        Thu, 20 Jan 2022 15:00:43 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v10 0/6] drm: LogiCVC display controller support
Date:   Thu, 20 Jan 2022 16:00:18 +0100
Message-Id: <20220120150024.646714-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces support for the LogiCVC display controller.
The controller is a bit unusual since it is usually loaded as
programmable logic on Xilinx FPGAs or Zynq-7000 SoCs.
More details are presented on the main commit for the driver.

More information about the controller is available on the dedicated
web page: https://www.logicbricks.com/Products/logiCVC-ML.aspx

Note that this driver has rather simple connector management, which was
not converted to drm_panel_bridge to keep the ability to enable the panel
at first vblank but also to support DVI.

Changes since v9:
- Added common compatibles for major logicvc versions;
- Add support for logicvc-5;
- Rebased on latest drm-misc next.

Changes since v8:
- Rebased on top of the latest drm-misc-next;
- Dropped useless phandle-based syscon regmap support;
- Switched to a single-port graph description;
- Updated the device-tree schema to the port schema and added a
  description for the port.

Change since v7:
- Replaced DRM_INFO/DRM_ERROR/DRM_DEBUG_DRIVER with fashions using drm_device;
- Fixed yaml binding alignment issue;
- Renamed logicvc-display name to the generic "display" name;
- Added patternProperties match for display in the parent mfd binding;
- Used drm_atomic_get_new_crtc_state when needed;
- Checked mode in mode_valid instead of atomic_check;
- Switched to drmm_mode_config_init;
- Removed useless logicvc_connector_destroy wrapper;
- Removed useless drm_dev_put calls;
- Removed atomic_commit_tail that enables the panel and streamlined the logic;
- Reworked Makefile cosmetics;
- Fixed checkpatch issues.

Changes since v6:
- Updated to the latest DRM internal API changes; 
- Used an enum to index dt properties instead of the name string.

Changes since v5:
- Subclass DRM device and use devm_drm_dev_alloc for allocation;
- Removed call to drm_mode_config_cleanup (done automatically with devm);
- Some related code cleanups;
- Bring back not-for-merge patch adding colorkey support.

Changes since v4:
- Updated to internal DRM API changes (rebased on drm-misc-next);
- Added Kconfig dependency on OF;
- Added MAINTAINERS entry;
- Used drm_err and dev_err instead of DRM_ERROR where possible;
- Various cosmetic changes.

Changes since v3:
- Rebased on latest drm-misc;
- Improved event lock wrapping;
- Added collect tag;
- Added color-key support patch (not for merge, for reference only).

Changes since v2:
- Fixed and slightly improved dt schema.

Changes since v1:
- Switched dt bindings documentation to dt schema;
- Described more possible dt parameters;
- Added support for the lvds-3bit interface;
- Added support for grabbing syscon regmap from parent node;
- Removed layers count property and count layers child nodes instead.

Paul Kocialkowski (6):
  dt-bindings: mfd: logicvc: Add a compatible with the major version
    only
  dt-bindings: gpio: logicvc: Add a compatible with major version only
  gpio: logicvc: Support compatible with major version only
  dt-bindings: display: Add compatibles with major versions only
  drm: Add support for the LogiCVC display controller
  NOTFORMERGE: drm/logicvc: Add plane colorkey support

 .../display/xylon,logicvc-display.yaml        |   3 +
 .../bindings/gpio/xylon,logicvc-gpio.yaml     |   1 +
 .../bindings/mfd/xylon,logicvc.yaml           |   1 +
 MAINTAINERS                                   |   6 +
 drivers/gpio/gpio-logicvc.c                   |   5 +-
 drivers/gpu/drm/Kconfig                       |   2 +
 drivers/gpu/drm/Makefile                      |   1 +
 drivers/gpu/drm/logicvc/Kconfig               |   9 +
 drivers/gpu/drm/logicvc/Makefile              |   9 +
 drivers/gpu/drm/logicvc/logicvc_crtc.c        | 280 +++++++
 drivers/gpu/drm/logicvc/logicvc_crtc.h        |  21 +
 drivers/gpu/drm/logicvc/logicvc_drm.c         | 483 +++++++++++
 drivers/gpu/drm/logicvc/logicvc_drm.h         |  67 ++
 drivers/gpu/drm/logicvc/logicvc_interface.c   | 214 +++++
 drivers/gpu/drm/logicvc/logicvc_interface.h   |  28 +
 drivers/gpu/drm/logicvc/logicvc_layer.c       | 767 ++++++++++++++++++
 drivers/gpu/drm/logicvc/logicvc_layer.h       |  71 ++
 drivers/gpu/drm/logicvc/logicvc_mode.c        |  80 ++
 drivers/gpu/drm/logicvc/logicvc_mode.h        |  15 +
 drivers/gpu/drm/logicvc/logicvc_of.c          | 185 +++++
 drivers/gpu/drm/logicvc/logicvc_of.h          |  46 ++
 drivers/gpu/drm/logicvc/logicvc_regs.h        |  88 ++
 22 files changed, 2379 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/logicvc/Kconfig
 create mode 100644 drivers/gpu/drm/logicvc/Makefile
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_crtc.c
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_crtc.h
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_drm.c
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_drm.h
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_interface.c
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_interface.h
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_layer.c
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_layer.h
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_mode.c
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_mode.h
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_of.c
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_of.h
 create mode 100644 drivers/gpu/drm/logicvc/logicvc_regs.h

-- 
2.34.1

