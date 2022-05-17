Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C42D52A607
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244633AbiEQPU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236154AbiEQPUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:20:22 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB2C4BB97
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:20:17 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id m12so17622388plb.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hI8iEnp95mOjtG8Fe5uTOagxxaCYZFkPIW3iQUFV2UA=;
        b=JDmjl784I9z5AGCwwrRR1HxsYWuCaoMKbkkIfVqJw+KZi3d5YY5Y4p+qOU5BLiaTAH
         LtrMYJS4fdfUtKyQdFuXr2xM11A7NYZhYKKI4swC9VdWdWOvpYvFlfRr7YuhCE7iKKvZ
         1rRYl8Uaq+f6kt4CkNAFGHGJI0CLcObHpQ58Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hI8iEnp95mOjtG8Fe5uTOagxxaCYZFkPIW3iQUFV2UA=;
        b=k0FwZsfyYDmi133FWVDPXJYWSdKOUduPmfF+4WSI5noyqWZKndcHeMgiW0eL797M9x
         kQSdXviWMMFTbYbqEC2YKW3XqgvxkBLdqIj+i1Hm0C4tZ9F763G6e9jo5pXlgJ/XPwlE
         Qs3Ge0O/kUd10ORKyztL8x8A4nrPWm7N0olUl6pll/xjx2NU+lDMTg8IXusebxuUmYWJ
         1eupBgDHpWM3PF6lp4eN/8NU44eAPPZZGKEHBtPbVnK7v1wv78NAlrlZRnQOHAp4aVHJ
         BEZuKq4ei6vXBX33m5a77k1j1SVlzmTo3jxNHeaCvZ+tN4pJ5pKDdIT2fB0T7m0OHnA1
         UqTw==
X-Gm-Message-State: AOAM530cgOiaAaF6n514oDwBI3ycqj8S1uBdNvioC5CoCykD+I7cxvqs
        yj71aimKiPvprNr6Dx6dI/ZUNA==
X-Google-Smtp-Source: ABdhPJxt1rfNJ9hnt/W3AEaLefCTlQpYskarxSaYFzVo+0a0SaDy/QX12ruMLYt/qxUkas2GmO2dug==
X-Received: by 2002:a17:902:c947:b0:161:7b60:e712 with SMTP id i7-20020a170902c94700b001617b60e712mr10177339pla.121.1652800817034;
        Tue, 17 May 2022 08:20:17 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:641e:de1c:873b:321e])
        by smtp.gmail.com with UTF8SMTPSA id c13-20020a62f84d000000b0050e0dadb28dsm9088671pfm.205.2022.05.17.08.20.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 08:20:16 -0700 (PDT)
Date:   Tue, 17 May 2022 08:20:14 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Doug Anderson <dianders@chromium.org>,
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
Message-ID: <YoO9LqA0z8enTN5U@google.com>
References: <20220217184254.4141705-1-mka@chromium.org>
 <CAD=FV=XswQj+L6rRuWH-PdoGp9vVsWKTwz1bFM_fagy55tKqEg@mail.gmail.com>
 <YmGetA6Huz4Sj/RL@google.com>
 <YmffM2XuCiOghOLU@kroah.com>
 <894ea48c-7962-320e-e177-9652701c72fe@xilinx.com>
 <YoN8Ti3xk4ElTiLP@kroah.com>
 <53f2e0b9-2b5a-51e2-6a71-d831ad6cb484@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53f2e0b9-2b5a-51e2-6a71-d831ad6cb484@xilinx.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 01:06:29PM +0200, Michal Simek wrote:
> 
> 
> On 5/17/22 12:43, Greg Kroah-Hartman wrote:
> > On Tue, May 17, 2022 at 12:36:03PM +0200, Michal Simek wrote:
> > > Hi Greg,
> > > 
> > > On 4/26/22 14:01, Greg Kroah-Hartman wrote:
> > > > On Thu, Apr 21, 2022 at 11:13:08AM -0700, Matthias Kaehlcke wrote:
> > > > > Hi,
> > > > > 
> > > > > On Thu, Apr 07, 2022 at 12:41:22PM -0700, Doug Anderson wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > On Thu, Feb 17, 2022 at 10:43 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> > > > > > > 
> > > > > > > This series adds:
> > > > > > > - the onboard_usb_hub_driver
> > > > > > > - glue in the generic HCD code to create and destroy the
> > > > > > >     onboard_usb_hub platform devices if needed
> > > > > > > - device tree changes that add RTS5411 entries for the QCA SC7180
> > > > > > >     based boards trogdor and lazor
> > > > > > > - a couple of stubs for platform device functions to avoid
> > > > > > >     unresolved symbols with certain kernel configs
> > > > > > > 
> > > > > > > The main issue the driver addresses is that a USB hub needs to be
> > > > > > > powered before it can be discovered. For discrete onboard hubs (an
> > > > > > > example for such a hub is the Realtek RTS5411) this is often solved
> > > > > > > by supplying the hub with an 'always-on' regulator, which is kind
> > > > > > > of a hack. Some onboard hubs may require further initialization
> > > > > > > steps, like changing the state of a GPIO or enabling a clock, which
> > > > > > > requires even more hacks. This driver creates a platform device
> > > > > > > representing the hub which performs the necessary initialization.
> > > > > > > Currently it only supports switching on a single regulator, support
> > > > > > > for multiple regulators or other actions can be added as needed.
> > > > > > > Different initialization sequences can be supported based on the
> > > > > > > compatible string.
> > > > > > > 
> > > > > > > Besides performing the initialization the driver can be configured
> > > > > > > to power the hub off during system suspend. This can help to extend
> > > > > > > battery life on battery powered devices which have no requirements
> > > > > > > to keep the hub powered during suspend. The driver can also be
> > > > > > > configured to leave the hub powered when a wakeup capable USB device
> > > > > > > is connected when suspending, and power it off otherwise.
> > > > > > > 
> > > > > > > Changes in v21:
> > > > > > > - dropped patch 'driver core: Export device_is_bound()'
> > > > > > > - refactored _find_onboard_hub()
> > > > > > > - removed 'onboard_hub_dev' symlinks from USB devices
> > > > > > > - dropped patch 'arm64: dts: qcom: sc7180-trogdor: Add nodes for onboard USB hub'
> > > > > > >     (will be sent separately)
> > > > > > > - rebased series on v5.17-rc4
> > > > > > > 
> > > > > > > Changes in v20:
> > > > > > > - addressed review comments from Stephen
> > > > > > > - changed DT node names for hubs
> > > > > > > 
> > > > > > > Changes in v19:
> > > > > > > - added VID:PID pairs and compatible strings for RTS5414 hub
> > > > > > > - updated comments with RTS5411 USB versions to reflect those
> > > > > > >     reported/supported by the hub
> > > > > > > - rebased series on v5.16
> > > > > > > 
> > > > > > > Changes in v18:
> > > > > > > - introduced hidden Kconfig option to align module vs. builtin
> > > > > > >     choice with CONFIG_USB (thanks Doug!)
> > > > > > > - added patch 'driver core: Export device_is_bound()'
> > > > > > > - also adjust device tree of pompom rev1
> > > > > > > - dropped the following patches, which aren't needed anymore by this
> > > > > > >     series (though they might still be useful on their own):
> > > > > > >     - usb: Specify dependencies on USB_XHCI_PLATFORM with 'depends on'
> > > > > > >     - arm64: defconfig: Explicitly enable USB_XHCI_PLATFORM
> > > > > > >     - ARM: configs: Explicitly enable USB_XHCI_PLATFORM where needed
> > > > > > > 
> > > > > > > Changes in v17:
> > > > > > > - rebased on top of v5.16-rc1
> > > > > > > - moved creation of onboard_hub platform devices from xhci_platform
> > > > > > >     to the generic HCD code
> > > > > > > - addressed review comments for the onboard_hub driver
> > > > > > > - moved Kconfig/defconfig changes to the end of the series. The
> > > > > > >     onboard_hub driver doesn't depend on XHCI_PLATFORM anymore,
> > > > > > >     hence these changes aren't really required for the driver, but
> > > > > > >     they still seem to be a worthwhile improvement
> > > > > > > 
> > > > > > > Changes in v16:
> > > > > > > - added patch 'ARM: configs: Explicitly enable USB_XHCI_PLATFORM
> > > > > > >     where needed' to keep arm32 defconfigs effectively unchanged
> > > > > > > 
> > > > > > > Changes in v15:
> > > > > > > - adjusted dependencies of USB_DWC3_CORE to make sure it can only
> > > > > > >     be enabled when at least one of USB_DWC3_HOST, USB_DWC3_GADGET
> > > > > > >     or USB_DWC3_DUAL_ROLE is selectable
> > > > > > > 
> > > > > > > Changes in v14:
> > > > > > > - rebased on top of v5.14-rc1
> > > > > > > - dropped DT binding patch which landed in v5.13
> > > > > > > 
> > > > > > > Changes in v13:
> > > > > > > - added patch "usb: Specify dependency on USB_XHCI_PLATFORM with
> > > > > > >     'depends on'" to the series to avoid Kconfig conflicts
> > > > > > > - added patch "arm64: defconfig: Explicitly enable USB_XHCI_PLATFORM"
> > > > > > >     to the series to keep effective defconfig unchanged
> > > > > > > 
> > > > > > > Changes in v12:
> > > > > > > - onboard_hub driver: use IS_ENABLED(CONFIG_USB_ONBOARD_HUB_MODULE)
> > > > > > >     in onboard_hub.h to also check for the driver built as module
> > > > > > > - onboard_hub_driver: include onboard_hub.h again to make sure there
> > > > > > >     are prototype declarations for the public functions
> > > > > > > 
> > > > > > > Changes in v11:
> > > > > > > - support multiple onboard hubs connected to the same parent
> > > > > > > - don't include ‘onboard_hub.h’ from the onboard hub driver
> > > > > > > 
> > > > > > > Changes in v10:
> > > > > > > - always use of_is_onboard_usb_hub() stub unless ONBOARD_USB_HUB=y/m
> > > > > > > - keep 'regulator-boot-on' property for pp3300_hub
> > > > > > > 
> > > > > > > Changes in v9:
> > > > > > > - added dependency on ONBOARD_USB_HUB (or !ONBOARD_USB_HUB) to
> > > > > > >     USB_PLATFORM_XHCI
> > > > > > > 
> > > > > > > Changes in v7:
> > > > > > > - updated DT binding
> > > > > > > - series rebased on qcom/arm64-for-5.13
> > > > > > > 
> > > > > > > Changes in v6:
> > > > > > > - updated summary
> > > > > > > 
> > > > > > > Changes in v5:
> > > > > > > - cover letter added
> > > > > > > 
> > > > > > > Matthias Kaehlcke (3):
> > > > > > >     of/platform: Add stubs for of_platform_device_create/destroy()
> > > > > > >     usb: misc: Add onboard_usb_hub driver
> > > > > > >     usb: core: hcd: Create platform devices for onboard hubs in probe()
> > > > > > > 
> > > > > > >    .../sysfs-bus-platform-onboard-usb-hub        |   8 +
> > > > > > >    MAINTAINERS                                   |   7 +
> > > > > > >    drivers/usb/core/hcd.c                        |   6 +
> > > > > > >    drivers/usb/misc/Kconfig                      |  23 +
> > > > > > >    drivers/usb/misc/Makefile                     |   1 +
> > > > > > >    drivers/usb/misc/onboard_usb_hub.c            | 510 ++++++++++++++++++
> > > > > > >    include/linux/of_platform.h                   |  22 +-
> > > > > > >    include/linux/usb/hcd.h                       |   1 +
> > > > > > >    include/linux/usb/onboard_hub.h               |  18 +
> > > > > > >    9 files changed, 592 insertions(+), 4 deletions(-)
> > > > > > >    create mode 100644 Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-hub
> > > > > > >    create mode 100644 drivers/usb/misc/onboard_usb_hub.c
> > > > > > >    create mode 100644 include/linux/usb/onboard_hub.h
> > > > > > 
> > > > > > With v5.18-rc1 out the door, I wonder if it's a good time to look at
> > > > > > this series again. Are there any hidden blockers that it's waiting
> > > > > > for?
> > > > > 
> > > > > Greg, please let me know if any further changes are needed or if this
> > > > > series can be landed.
> > > > 
> > > > After 21 different versions, there's nothing left for me to object to,
> > > > so I'll go queue it up.  Thanks for sticking with it.
> > > 
> > > I just checked linux-next and this series is still not there. Are you going
> > > to merge it or are you waiting for v22?
> > 
> > It was merged, and I had to revert it based on reports of problems with
> > it.  See the thread here:
> > 	https://lore.kernel.org/r/20220502210728.0b36f3cd@canb.auug.org.au
> > for details.
> 
> Matthias: Are you going to send v22 version?

Greg wasn't too convinced [1] about the solution I had in mind (linking
onboard_hub_create/destroy_pdevs() into the USB core module) and offered to
look into it. It seems he hasn't found time for that yet. I plan to send out
v22 with the above solution in the next days if Greg doesn't propose
something better in the meantime.

[1] https://lore.kernel.org/all/YnAVxtQNOOhtz3lO@kroah.com/
