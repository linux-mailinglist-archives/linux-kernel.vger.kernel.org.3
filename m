Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A8650FC6A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349733AbiDZMFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 08:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbiDZMFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:05:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1451C69731;
        Tue, 26 Apr 2022 05:02:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A23C061450;
        Tue, 26 Apr 2022 12:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4ADC385AA;
        Tue, 26 Apr 2022 12:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650974519;
        bh=crdW+PWFPIlqWU/xkDEBzMFGR+JLIJwz1ThC+HJuNoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i+GY25+XpjbYrqmKNq9MpW35s8r/kxUYOO7uGlRxbqNc40GW+JUIDwL5loAluxZdg
         GurEXtHEtXzcfdMg0fj36gcwDHBu3ji8H6AoaKL/zumzIyxLraYCxRmgt0pgmXXj4V
         lWwyb3wxo80+mbSZscDAXO3kQO+GfUd7vQ6RKK94=
Date:   Tue, 26 Apr 2022 14:01:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Roger Quadros <rogerq@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Stephen Boyd <swboyd@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Li Jun <jun.li@nxp.com>, Peter Chen <peter.chen@nxp.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH v21 0/3] usb: misc: Add onboard_usb_hub driver
Message-ID: <YmffM2XuCiOghOLU@kroah.com>
References: <20220217184254.4141705-1-mka@chromium.org>
 <CAD=FV=XswQj+L6rRuWH-PdoGp9vVsWKTwz1bFM_fagy55tKqEg@mail.gmail.com>
 <YmGetA6Huz4Sj/RL@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YmGetA6Huz4Sj/RL@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 11:13:08AM -0700, Matthias Kaehlcke wrote:
> Hi,
> 
> On Thu, Apr 07, 2022 at 12:41:22PM -0700, Doug Anderson wrote:
> > Hi,
> > 
> > On Thu, Feb 17, 2022 at 10:43 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> > >
> > > This series adds:
> > > - the onboard_usb_hub_driver
> > > - glue in the generic HCD code to create and destroy the
> > >   onboard_usb_hub platform devices if needed
> > > - device tree changes that add RTS5411 entries for the QCA SC7180
> > >   based boards trogdor and lazor
> > > - a couple of stubs for platform device functions to avoid
> > >   unresolved symbols with certain kernel configs
> > >
> > > The main issue the driver addresses is that a USB hub needs to be
> > > powered before it can be discovered. For discrete onboard hubs (an
> > > example for such a hub is the Realtek RTS5411) this is often solved
> > > by supplying the hub with an 'always-on' regulator, which is kind
> > > of a hack. Some onboard hubs may require further initialization
> > > steps, like changing the state of a GPIO or enabling a clock, which
> > > requires even more hacks. This driver creates a platform device
> > > representing the hub which performs the necessary initialization.
> > > Currently it only supports switching on a single regulator, support
> > > for multiple regulators or other actions can be added as needed.
> > > Different initialization sequences can be supported based on the
> > > compatible string.
> > >
> > > Besides performing the initialization the driver can be configured
> > > to power the hub off during system suspend. This can help to extend
> > > battery life on battery powered devices which have no requirements
> > > to keep the hub powered during suspend. The driver can also be
> > > configured to leave the hub powered when a wakeup capable USB device
> > > is connected when suspending, and power it off otherwise.
> > >
> > > Changes in v21:
> > > - dropped patch 'driver core: Export device_is_bound()'
> > > - refactored _find_onboard_hub()
> > > - removed 'onboard_hub_dev' symlinks from USB devices
> > > - dropped patch 'arm64: dts: qcom: sc7180-trogdor: Add nodes for onboard USB hub'
> > >   (will be sent separately)
> > > - rebased series on v5.17-rc4
> > >
> > > Changes in v20:
> > > - addressed review comments from Stephen
> > > - changed DT node names for hubs
> > >
> > > Changes in v19:
> > > - added VID:PID pairs and compatible strings for RTS5414 hub
> > > - updated comments with RTS5411 USB versions to reflect those
> > >   reported/supported by the hub
> > > - rebased series on v5.16
> > >
> > > Changes in v18:
> > > - introduced hidden Kconfig option to align module vs. builtin
> > >   choice with CONFIG_USB (thanks Doug!)
> > > - added patch 'driver core: Export device_is_bound()'
> > > - also adjust device tree of pompom rev1
> > > - dropped the following patches, which aren't needed anymore by this
> > >   series (though they might still be useful on their own):
> > >   - usb: Specify dependencies on USB_XHCI_PLATFORM with 'depends on'
> > >   - arm64: defconfig: Explicitly enable USB_XHCI_PLATFORM
> > >   - ARM: configs: Explicitly enable USB_XHCI_PLATFORM where needed
> > >
> > > Changes in v17:
> > > - rebased on top of v5.16-rc1
> > > - moved creation of onboard_hub platform devices from xhci_platform
> > >   to the generic HCD code
> > > - addressed review comments for the onboard_hub driver
> > > - moved Kconfig/defconfig changes to the end of the series. The
> > >   onboard_hub driver doesn't depend on XHCI_PLATFORM anymore,
> > >   hence these changes aren't really required for the driver, but
> > >   they still seem to be a worthwhile improvement
> > >
> > > Changes in v16:
> > > - added patch 'ARM: configs: Explicitly enable USB_XHCI_PLATFORM
> > >   where needed' to keep arm32 defconfigs effectively unchanged
> > >
> > > Changes in v15:
> > > - adjusted dependencies of USB_DWC3_CORE to make sure it can only
> > >   be enabled when at least one of USB_DWC3_HOST, USB_DWC3_GADGET
> > >   or USB_DWC3_DUAL_ROLE is selectable
> > >
> > > Changes in v14:
> > > - rebased on top of v5.14-rc1
> > > - dropped DT binding patch which landed in v5.13
> > >
> > > Changes in v13:
> > > - added patch "usb: Specify dependency on USB_XHCI_PLATFORM with
> > >   'depends on'" to the series to avoid Kconfig conflicts
> > > - added patch "arm64: defconfig: Explicitly enable USB_XHCI_PLATFORM"
> > >   to the series to keep effective defconfig unchanged
> > >
> > > Changes in v12:
> > > - onboard_hub driver: use IS_ENABLED(CONFIG_USB_ONBOARD_HUB_MODULE)
> > >   in onboard_hub.h to also check for the driver built as module
> > > - onboard_hub_driver: include onboard_hub.h again to make sure there
> > >   are prototype declarations for the public functions
> > >
> > > Changes in v11:
> > > - support multiple onboard hubs connected to the same parent
> > > - don't include ‘onboard_hub.h’ from the onboard hub driver
> > >
> > > Changes in v10:
> > > - always use of_is_onboard_usb_hub() stub unless ONBOARD_USB_HUB=y/m
> > > - keep 'regulator-boot-on' property for pp3300_hub
> > >
> > > Changes in v9:
> > > - added dependency on ONBOARD_USB_HUB (or !ONBOARD_USB_HUB) to
> > >   USB_PLATFORM_XHCI
> > >
> > > Changes in v7:
> > > - updated DT binding
> > > - series rebased on qcom/arm64-for-5.13
> > >
> > > Changes in v6:
> > > - updated summary
> > >
> > > Changes in v5:
> > > - cover letter added
> > >
> > > Matthias Kaehlcke (3):
> > >   of/platform: Add stubs for of_platform_device_create/destroy()
> > >   usb: misc: Add onboard_usb_hub driver
> > >   usb: core: hcd: Create platform devices for onboard hubs in probe()
> > >
> > >  .../sysfs-bus-platform-onboard-usb-hub        |   8 +
> > >  MAINTAINERS                                   |   7 +
> > >  drivers/usb/core/hcd.c                        |   6 +
> > >  drivers/usb/misc/Kconfig                      |  23 +
> > >  drivers/usb/misc/Makefile                     |   1 +
> > >  drivers/usb/misc/onboard_usb_hub.c            | 510 ++++++++++++++++++
> > >  include/linux/of_platform.h                   |  22 +-
> > >  include/linux/usb/hcd.h                       |   1 +
> > >  include/linux/usb/onboard_hub.h               |  18 +
> > >  9 files changed, 592 insertions(+), 4 deletions(-)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-hub
> > >  create mode 100644 drivers/usb/misc/onboard_usb_hub.c
> > >  create mode 100644 include/linux/usb/onboard_hub.h
> > 
> > With v5.18-rc1 out the door, I wonder if it's a good time to look at
> > this series again. Are there any hidden blockers that it's waiting
> > for?
> 
> Greg, please let me know if any further changes are needed or if this
> series can be landed.

After 21 different versions, there's nothing left for me to object to,
so I'll go queue it up.  Thanks for sticking with it.

greg k-h
