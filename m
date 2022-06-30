Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA17B56233C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 21:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236819AbiF3Tfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 15:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbiF3Tfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 15:35:36 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E1740E7A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 12:35:34 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id go6so476078pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 12:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eLj8dvJU9XDGdoAEUQrG8roKjSZaW65W8uh/7Z2tEb4=;
        b=Cr2OkNDShHE/tpkskbgdgzNpd9VcMHfiSLuml4qpiKCxNHd2IHTb6pRuXSsp2mij7M
         OeOZgtI3wJX5wngKNIwvGuwZHxXPhXIjCigZzph4T6YpWjsoa8ucR6F3x9fsuhI62kp+
         oI0oUNt24YkmHODerH9z91Yy3wvmD24KLxPjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eLj8dvJU9XDGdoAEUQrG8roKjSZaW65W8uh/7Z2tEb4=;
        b=1iuVSTX4860x6dPaWnGH5sYicNcQQCDyVzwVaudpJ1o6rsBupFuIesePNSC7yGZ8Am
         kOWyGncoUVaA3pjtBlEBkrYj9aemwlgrELS4137QLbh/JATCVM4Zve60zsFuIf6T6N3A
         iu7lxyFgeMmo+6bTbsTs9yjQaZV7aj1luDfy/XEjl6uQBAmnD/YsRWwmsBVxIlGLicgP
         RBFgiEixf4do1SJoX7MBquZFOF2dbO//K23NOL6MIwE5H7lthBhRUzfzXFxuhJluJDbl
         cQpVH+EMpTvdY2Lk+18hKS+b6d6ff/EZxeUJIVjUuxSavN9E+eloA/BKDS8DwLeOFhV6
         RDww==
X-Gm-Message-State: AJIora9TrjG6yzUbs057u8yEfClvMWusaP0AAKXpIaAGeqSrghqB/Uck
        ubRmEj0F0+sW5whChe3kTurAsA==
X-Google-Smtp-Source: AGRyM1urILMFylb9/+Eu2UhE0mradGCNDT+MflhibGHUIW66ZDUEh1Qi9kXj1ir1A4CyKqenG8iAag==
X-Received: by 2002:a17:902:e3cd:b0:16a:6db:bf80 with SMTP id r13-20020a170902e3cd00b0016a06dbbf80mr15737386ple.0.1656617734294;
        Thu, 30 Jun 2022 12:35:34 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:9fbf:277c:23e1:eabb])
        by smtp.gmail.com with UTF8SMTPSA id p17-20020a170902c71100b001641a5d5786sm13728729plp.114.2022.06.30.12.35.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 12:35:33 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-usb@vger.kernel.org,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Roger Quadros <rogerq@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Peter Chen <peter.chen@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v24 0/4] usb: misc: Add onboard_usb_hub driver
Date:   Thu, 30 Jun 2022 12:35:26 -0700
Message-Id: <20220630193530.2608178-1-mka@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Changes in v24:
- changed USB_ONBOARD_HUB from bool to tristate and fixed Makefile
  entry
- renamed 'companion-hub' property to 'peer-hub'
- added comment to onboard_hub_create_pdevs() doc that explains the
  somewhat convoluted logic of the function
- only cancel the driver attach work in onboard_hub_remove() if the
  function wasn't called by the work job itself
- added patch "dt-bindings: usb: rts5411: Rename property
 'companion-hub' to 'peer-hub'"

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

Matthias Kaehlcke (4):
  of/platform: Add stubs for of_platform_device_create/destroy()
  dt-bindings: usb: rts5411: Rename property 'companion-hub' to
    'peer-hub'
  usb: misc: Add onboard_usb_hub driver
  usb: core: hub: Create platform devices for onboard hubs in
    hub_probe()

 .../sysfs-bus-platform-onboard-usb-hub        |   8 +
 .../bindings/usb/realtek,rts5411.yaml         |  10 +-
 MAINTAINERS                                   |   7 +
 drivers/usb/core/Makefile                     |   4 +
 drivers/usb/core/hub.c                        |   9 +-
 drivers/usb/core/hub.h                        |   1 +
 drivers/usb/misc/Kconfig                      |  16 +
 drivers/usb/misc/Makefile                     |   1 +
 drivers/usb/misc/onboard_usb_hub.c            | 428 ++++++++++++++++++
 drivers/usb/misc/onboard_usb_hub.h            |  17 +
 drivers/usb/misc/onboard_usb_hub_pdevs.c      | 142 ++++++
 include/linux/of_platform.h                   |  22 +-
 include/linux/usb/onboard_hub.h               |  18 +
 13 files changed, 673 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-hub
 create mode 100644 drivers/usb/misc/onboard_usb_hub.c
 create mode 100644 drivers/usb/misc/onboard_usb_hub.h
 create mode 100644 drivers/usb/misc/onboard_usb_hub_pdevs.c
 create mode 100644 include/linux/usb/onboard_hub.h

-- 
2.37.0.rc0.161.g10f37bed90-goog

