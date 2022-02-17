Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3184BA89F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244519AbiBQSnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:43:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236209AbiBQSnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:43:19 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F255025E2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 10:43:04 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id n19-20020a17090ade9300b001b9892a7bf9so10198762pjv.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 10:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rAEfKkNmvagiynvGDi/apekp0UfKH1dAb6Tj2Y3Vkq0=;
        b=NbAGF7Vib1lDY8lKKcb7Zq+8/W9VK5mCe/TsBp776FwUuzb0D0lml9yCiu08QBHEX0
         OO+yU2mPKel6ro5lNwRRfpAGe8vXMOlbhv0eVxjMIx4m9pJ4djXZ5liTQ8yXuaSmwPDL
         LHaAdj7rDFmEXJCtlKBl49bEp8iBpi0mzwXsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rAEfKkNmvagiynvGDi/apekp0UfKH1dAb6Tj2Y3Vkq0=;
        b=g1rsge+qDsyOQMlgPTMxfmfApLu2+Q5y8C4FistYjA8a37vEz1uFdtadeCfehZF0ZU
         G6Ga00W/8zQT83lmj76A9iaVhMrbG4q1Zi8D/QqwZJZzF/E4gT2dJHN9flfIIAhuZ+5c
         eAPkkxQhfkNkbbHR50CqyPopnNvkg10Ha8wgswpmTfH9d/eqLNltlBjl3k86WTZ0oCaR
         paUtMNmjfZYQqhus/xVwEBMYMzbyzx2cztKnh4+bH+UwiOTlI7rPriBqRsT4ngYQiQ2Z
         QGjeSDCJVxbUEYWkclYe3W0uoA3WJ129ZWB4gCb0U1TmCmlYkuD79lFVEw8k+VZQb6Mm
         sn+Q==
X-Gm-Message-State: AOAM533Znv6YAOeEjRgVx0vTvG/DUL6QweqwE7pgoL+pWH/iEduqu9eG
        G6DZfxV46T12nYZz9/Hn7huapQ==
X-Google-Smtp-Source: ABdhPJzHzxnE860Wyl4mLXhd+D2UJGbeiR76r5v3JFRsrJBW07XFdt+A2lcmzRfQOs1FnvR1W2J0WA==
X-Received: by 2002:a17:902:8210:b0:14d:6607:bdc4 with SMTP id x16-20020a170902821000b0014d6607bdc4mr4051047pln.165.1645123384369;
        Thu, 17 Feb 2022 10:43:04 -0800 (PST)
Received: from localhost ([2620:15c:202:201:b42d:98cc:5dcc:5ef5])
        by smtp.gmail.com with UTF8SMTPSA id bj26sm8598333pgb.81.2022.02.17.10.43.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 10:43:03 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-usb@vger.kernel.org,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Roger Quadros <rogerq@kernel.org>,
        linux-kernel@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Douglas Anderson <dianders@chromium.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Stephen Boyd <swboyd@chromium.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Li Jun <jun.li@nxp.com>, Peter Chen <peter.chen@nxp.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v21 0/3] usb: misc: Add onboard_usb_hub driver
Date:   Thu, 17 Feb 2022 10:42:51 -0800
Message-Id: <20220217184254.4141705-1-mka@chromium.org>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Changes in v21:
- dropped patch 'driver core: Export device_is_bound()'
- refactored _find_onboard_hub()
- removed 'onboard_hub_dev' symlinks from USB devices
- dropped patch 'arm64: dts: qcom: sc7180-trogdor: Add nodes for onboard USB hub'
  (will be sent separately)
- rebased series on v5.17-rc4

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

Matthias Kaehlcke (3):
  of/platform: Add stubs for of_platform_device_create/destroy()
  usb: misc: Add onboard_usb_hub driver
  usb: core: hcd: Create platform devices for onboard hubs in probe()

 .../sysfs-bus-platform-onboard-usb-hub        |   8 +
 MAINTAINERS                                   |   7 +
 drivers/usb/core/hcd.c                        |   6 +
 drivers/usb/misc/Kconfig                      |  23 +
 drivers/usb/misc/Makefile                     |   1 +
 drivers/usb/misc/onboard_usb_hub.c            | 510 ++++++++++++++++++
 include/linux/of_platform.h                   |  22 +-
 include/linux/usb/hcd.h                       |   1 +
 include/linux/usb/onboard_hub.h               |  18 +
 9 files changed, 592 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-hub
 create mode 100644 drivers/usb/misc/onboard_usb_hub.c
 create mode 100644 include/linux/usb/onboard_hub.h

-- 
2.35.1.473.g83b2b277ed-goog

