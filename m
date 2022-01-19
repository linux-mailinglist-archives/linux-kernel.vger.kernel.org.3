Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0EA4941F8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 21:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240237AbiASUnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 15:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244899AbiASUny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 15:43:54 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC079C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 12:43:53 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o64so3630736pjo.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 12:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V5BiuoCL3BS3pY0KUVzisKn5l9i+TTVG+bwUeabMhEk=;
        b=OEC8GOFWmRCAUxMjicI179DKwx/otRIOUBh46/TZ2A9xSSIgYqB+478N/yd0nhPR3W
         mYtwF2Sxu0/7XjCAZ/4uJbHdI20gy2o3yysOiVdr2kKi24Brvp8Y/9+zfWgM7VFgpCwz
         roZ+4JWM1oD1YKA5guUn28hTf+tvJoGcWlA2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V5BiuoCL3BS3pY0KUVzisKn5l9i+TTVG+bwUeabMhEk=;
        b=nj9UNRw0CKE3VYM87mjofedHJMR/mV4I8C4bpftriEEJD3h6OxXMnN89agoMZmXyFz
         CzNLKF8/fr7aOg9pCqLi75SZD4tM4IMkamaAMuhz0xXSqUnuClihvXUghwntRczNT/Fh
         KEEHvQ+KRA4MP6NFUM/smTfH8LEVDlQFJ6POq1RTynNExnTxqey8CA3/FCL2384aTVJZ
         f1KzVGRsgNCgNp1a/7tcQfb66NwDP1WmdDNNwUw7rL08KgaKuF7Um1cTGDtnK2vnfB1G
         DLkss5bwbjp66hdpDNN3S0TkTHkCqDTWtHX7U9dFQHAERow88LGOMXOET5Nco04jWuPZ
         lNfQ==
X-Gm-Message-State: AOAM531qMhaRMS+LWET0uQ+M5pH/gHgtyGfVjhFDHCPm3pwBSTbsiHlV
        gdG171H/McNWX86SZ6phrMhccw==
X-Google-Smtp-Source: ABdhPJxjDw9F9EjF82NyBugY9LUS3IT0bEW9DZGFW+WJoX48x2Rllr6J+1usnpzep/toZlKfpHe46w==
X-Received: by 2002:a17:90b:4b8c:: with SMTP id lr12mr6405892pjb.32.1642625033208;
        Wed, 19 Jan 2022 12:43:53 -0800 (PST)
Received: from localhost ([2620:15c:202:201:618e:efc:c014:d89c])
        by smtp.gmail.com with UTF8SMTPSA id ip2sm7033428pjb.11.2022.01.19.12.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 12:43:52 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Chen <peter.chen@kernel.org>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Roger Quadros <rogerq@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-usb@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Li Jun <jun.li@nxp.com>, Peter Chen <peter.chen@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v20 0/5] usb: misc: Add onboard_usb_hub driver
Date:   Wed, 19 Jan 2022 12:43:40 -0800
Message-Id: <20220119204345.3769662-1-mka@chromium.org>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds:
- the onboard_usb_hub_driver
- glue in the generic HCD code to create and destroy the
  onboard_usb_hub platform devices if needed
- device tree changes that add RTS5411 entries for the QCA SC7180
  based boards trogdor and lazor
- a couple of stubs for platform device functions to avoid
  unresolved symbols with certain kernel configs

The main issue the driver addresses is that a USB hub needs to be
powered before it can be discovered. For discrete onboard hubs (an
example for such a hub is the Realtek RTS5411) this is often solved
by supplying the hub with an 'always-on' regulator, which is kind
of a hack. Some onboard hubs may require further initialization
steps, like changing the state of a GPIO or enabling a clock, which
requires even more hacks. This driver creates a platform device
representing the hub which performs the necessary initialization.
Currently it only supports switching on a single regulator, support
for multiple regulators or other actions can be added as needed.
Different initialization sequences can be supported based on the
compatible string.

Besides performing the initialization the driver can be configured
to power the hub off during system suspend. This can help to extend
battery life on battery powered devices which have no requirements
to keep the hub powered during suspend. The driver can also be
configured to leave the hub powered when a wakeup capable USB device
is connected when suspending, and power it off otherwise.

Changes in v20:
- addressed review comments from Stephen
- changed DT node names for hubs

Changes in v19:
- added VID:PID pairs and compatible strings for RTS5414 hub
- updated comments with RTS5411 USB versions to reflect those
  reported/supported by the hub
- rebased series on v5.16

Changes in v18:
- introduced hidden Kconfig option to align module vs. builtin
  choice with CONFIG_USB (thanks Doug!)
- added patch 'driver core: Export device_is_bound()'
- also adjust device tree of pompom rev1
- dropped the following patches, which aren't needed anymore by this
  series (though they might still be useful on their own):
  - usb: Specify dependencies on USB_XHCI_PLATFORM with 'depends on'
  - arm64: defconfig: Explicitly enable USB_XHCI_PLATFORM
  - ARM: configs: Explicitly enable USB_XHCI_PLATFORM where needed

Changes in v17:
- rebased on top of v5.16-rc1
- moved creation of onboard_hub platform devices from xhci_platform
  to the generic HCD code
- addressed review comments for the onboard_hub driver
- moved Kconfig/defconfig changes to the end of the series. The
  onboard_hub driver doesn't depend on XHCI_PLATFORM anymore,
  hence these changes aren't really required for the driver, but
  they still seem to be a worthwhile improvement

Changes in v16:
- added patch 'ARM: configs: Explicitly enable USB_XHCI_PLATFORM
  where needed' to keep arm32 defconfigs effectively unchanged

Changes in v15:
- adjusted dependencies of USB_DWC3_CORE to make sure it can only
  be enabled when at least one of USB_DWC3_HOST, USB_DWC3_GADGET
  or USB_DWC3_DUAL_ROLE is selectable

Changes in v14:
- rebased on top of v5.14-rc1
- dropped DT binding patch which landed in v5.13

Changes in v13:
- added patch "usb: Specify dependency on USB_XHCI_PLATFORM with
  'depends on'" to the series to avoid Kconfig conflicts
- added patch "arm64: defconfig: Explicitly enable USB_XHCI_PLATFORM"
  to the series to keep effective defconfig unchanged

Changes in v12:
- onboard_hub driver: use IS_ENABLED(CONFIG_USB_ONBOARD_HUB_MODULE)
  in onboard_hub.h to also check for the driver built as module
- onboard_hub_driver: include onboard_hub.h again to make sure there
  are prototype declarations for the public functions

Changes in v11:
- support multiple onboard hubs connected to the same parent
- don't include ‘onboard_hub.h’ from the onboard hub driver

Changes in v10:
- always use of_is_onboard_usb_hub() stub unless ONBOARD_USB_HUB=y/m
- keep 'regulator-boot-on' property for pp3300_hub

Changes in v9:
- added dependency on ONBOARD_USB_HUB (or !ONBOARD_USB_HUB) to
  USB_PLATFORM_XHCI

Changes in v7:
- updated DT binding
- series rebased on qcom/arm64-for-5.13

Changes in v6:
- updated summary

Changes in v5:
- cover letter added

Matthias Kaehlcke (5):
  of/platform: Add stubs for of_platform_device_create/destroy()
  driver core: Export device_is_bound()
  usb: misc: Add onboard_usb_hub driver
  usb: core: hcd: Create platform devices for onboard hubs in probe()
  arm64: dts: qcom: sc7180-trogdor: Add nodes for onboard USB hub

 .../sysfs-bus-platform-onboard-usb-hub        |   8 +
 MAINTAINERS                                   |   7 +
 .../boot/dts/qcom/sc7180-trogdor-lazor-r0.dts |  19 +-
 .../boot/dts/qcom/sc7180-trogdor-lazor-r1.dts |  12 +-
 .../dts/qcom/sc7180-trogdor-pompom-r1.dts     |  11 +-
 .../arm64/boot/dts/qcom/sc7180-trogdor-r1.dts |  19 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  |  20 +-
 drivers/base/dd.c                             |   1 +
 drivers/usb/core/hcd.c                        |   6 +
 drivers/usb/misc/Kconfig                      |  23 +
 drivers/usb/misc/Makefile                     |   1 +
 drivers/usb/misc/onboard_usb_hub.c            | 511 ++++++++++++++++++
 include/linux/of_platform.h                   |  22 +-
 include/linux/usb/hcd.h                       |   1 +
 include/linux/usb/onboard_hub.h               |  18 +
 15 files changed, 638 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-hub
 create mode 100644 drivers/usb/misc/onboard_usb_hub.c
 create mode 100644 include/linux/usb/onboard_hub.h

-- 
2.34.1.703.g22d0c6ccf7-goog

