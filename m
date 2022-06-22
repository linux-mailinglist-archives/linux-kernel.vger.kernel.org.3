Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309A4556DF1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 23:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbiFVVtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 17:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiFVVti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 17:49:38 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3781A3EF34
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 14:49:37 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q140so17283643pgq.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 14:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yr59+R9n9NhdYApBelLI06daIODj/6Mh7LKlQvJr/gw=;
        b=RcMS/jrweitn+T8xp2cfEG0KNvhEwT108ZvQZG52GLYIPrJRlJ2hppPz/aK21b2GFw
         0DneDDKV2ta3EO8l57p4cGXOGT/wrP7ZaFTnvLwi8BMb6N07y6hXRuX4Q9SUXwyApPhY
         nmYXMG0MIgLQtgS2BzUXiCm9K7qIi4kWylBAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yr59+R9n9NhdYApBelLI06daIODj/6Mh7LKlQvJr/gw=;
        b=dVrwfLhohtq7kgipRInd9zz6Qb/tIN4D9tNk0bb/wvlXNxpeacrBw9BXgvNHwCQb6l
         +gvN75pZ8jzODW0MvggGAjf58tcUcZuVAhexgV3PeFLCBspkAgcJgQ6AE9V1yMB7stqq
         GeRXMXxhnN5uniB0qDaymICVPbWkirjFBqU4P3Tn7IQxpOlaC0gh8EptTYo476Dkd5hr
         grT76q0cJoG0nArF9/5vE/Zo+Gj4hivCv9YURBC5YJxC6+XwhdDrPuuRBzb0t1//EMd2
         vmAbPZS9aOmPF+fjkISUxSBjnfMeb1xSgoKvJz2XYNBIEJmV+F6L+zgw04s6nS8g1rHK
         6wTw==
X-Gm-Message-State: AJIora/yi/SXIIdDPjb+RyBb5Vfp8i4E2fKru/nhD48K3MM1MPNp+cku
        xuxskiIA8xnOvOwS4htYFa3G/w==
X-Google-Smtp-Source: AGRyM1vp8OobL2BMitO/smIQP+sHw2vY8YWWz3fUJmlaNdjB8Oml7eic1gydaYb+0pzEHjN5KiNJzw==
X-Received: by 2002:a05:6a00:23ca:b0:525:28b4:9e3b with SMTP id g10-20020a056a0023ca00b0052528b49e3bmr15193756pfc.43.1655934576558;
        Wed, 22 Jun 2022 14:49:36 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:83c:92dc:a659:2900])
        by smtp.gmail.com with UTF8SMTPSA id f128-20020a62db86000000b00517c84fd24asm5339161pfg.172.2022.06.22.14.49.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 14:49:36 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bastien Nocera <hadess@hadess.net>, linux-usb@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Chen <peter.chen@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v23 0/3] usb: misc: Add onboard_usb_hub driver
Date:   Wed, 22 Jun 2022 14:49:28 -0700
Message-Id: <20220622214931.1914770-1-mka@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
- glue in the generic hub code to create and destroy the
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

Changes in v23:
- refactored onboard_hub_create_pdevs()
- got rid of CONFIG_USB_ONBOARD_HUB_ACTUAL

Changes in v22:
- call onboard_hub_create/destroy_pdevs() from hub_probe/disconnect()
  instead of doing it from the HCD. When the pdevs are create from the
  HCD usb_of_get_device_node() (called by onboard_hub_create_pdevs())
  may return NULL because the USB device for the root hub doesn't
  exist yet. Creating the pdevs from the hub code also has the
  advantage of enabling support for nested onboard hubs (as long as
  all hubs in the chain have DT nodes and are supported by the driver).
- moved onboard_hub_create_pdevs(), onboard_hub_destroy_pdevs() and
  of_is_onboard_usb_hub() into a separate file to allow them to be
  linked into the USB core module (if CONFIG_USB=m)
- Added extra checks to ensure only one platform device is created
  for each physical hub. This is necessary because
  onboard_hub_create_pdevs() is now called from hub_probe() instead
  of usb_add_hcd(). As a result the function is called twice for
  typical USB3 hub, once for the USB3 part of the hub, and once for
  USB <= 2.x. Generally the parent hub downstream of the primary HCD
  creates the onboard hub platform device.
- use kzalloc() instead of devm_kzalloc() to allocate list entries. Using
  managed memory can cause issues since the managed memory is allocated
  before the device is probed.
- use a workqueue to (re-)attach the USB driver during/after _probe().
  This is necessary to avoid self-deadlocks on systems with nested
  onboard hubs.
- don't initialize list_head in onboard_hub_create_pdevs(), this needs
  to be done by the owner, to ensure that onboard_hub_destroy_pdevs()
  is called with a struct that was properly initialized even when
  onboard_hub_create_pdevs() is not called.
- rebased series on v5.19-rc1

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
  usb: core: hub: Create platform devices for onboard hubs in
    hub_probe()

 .../sysfs-bus-platform-onboard-usb-hub        |   8 +
 MAINTAINERS                                   |   7 +
 drivers/usb/core/Makefile                     |   1 +
 drivers/usb/core/hub.c                        |   9 +-
 drivers/usb/core/hub.h                        |   1 +
 drivers/usb/misc/Kconfig                      |  16 +
 drivers/usb/misc/Makefile                     |   1 +
 drivers/usb/misc/onboard_usb_hub.c            | 427 ++++++++++++++++++
 drivers/usb/misc/onboard_usb_hub.h            |  17 +
 drivers/usb/misc/onboard_usb_hub_pdevs.c      | 137 ++++++
 include/linux/of_platform.h                   |  22 +-
 include/linux/usb/onboard_hub.h               |  18 +
 12 files changed, 659 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-hub
 create mode 100644 drivers/usb/misc/onboard_usb_hub.c
 create mode 100644 drivers/usb/misc/onboard_usb_hub.h
 create mode 100644 drivers/usb/misc/onboard_usb_hub_pdevs.c
 create mode 100644 include/linux/usb/onboard_hub.h

-- 
2.37.0.rc0.104.g0611611a94-goog

