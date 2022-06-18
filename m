Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE56550666
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 19:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237283AbiFRRlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 13:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiFRRlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 13:41:50 -0400
X-Greylist: delayed 402 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 18 Jun 2022 10:41:49 PDT
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38E5712740;
        Sat, 18 Jun 2022 10:41:49 -0700 (PDT)
Received: from [192.168.0.2] (chello089173232159.chello.sk [89.173.232.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 909537A021E;
        Sat, 18 Jun 2022 19:35:04 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Getting Backpack USB drives to work - looking for lost firmware
Date:   Sat, 18 Jun 2022 19:35:01 +0200
User-Agent: KMail/1.9.10
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202206181935.01392.linux@zary.sk>
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USB_DRIVES autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I'm trying to get Micro Solutions Backpack USB CD-RW to work and maybe write a simple firmware loader module. It's based on Cypress EZ-USB FX2 so it should be easy (the loading code is already present in the kernel for other devices).

Micro Solutions released firmware and load scrips for Linux - it used to be called bpck-usb-firmware-1.1.tgz but seems to have vanished from the web, even archive.org does not have it. Frugalware distro used to include a package bpck-usb-firmware-1.1-1-i686.fpm until version 1.7 (it was removed in 1.8) but I was not able to find it anywhere (even tried Frugalware developers).

At least the load script can be found here:
https://www.linuxquestions.org/questions/linux-hardware-18/external-usb-backpack-cd-rewriter-problem-212360/
Firmware filenames extracted from the script:
BP1SCAN.HEX, BP2SCAN.HEX (scan firmwares)
BP1CD5.HEX, BP1CD6.HEX, BP1HD5.HEX, BP1HD6.HEX (for USB 1 chips)
BP2CD5.HEX, BP2CD6.HEX, BP2HD5.HEX, BP2HD6.HEX (for USB 2 chips)
BPINTCD.HEX, BPINTHD.HEX (for internal USB 2 chips)

So there seems to be two kinds of external USB adapters/cables - with FX (USB 1) and FX2 (USB 2) chips. First, a "scan" firmware is loaded that identifies the drive type and changes the ID appropriately. Then a final firmware is loaded, depending on the chip type, drive version (5 or 6) and drive type (CD or HDD).
The latest devices have integrated USB support - no scanning is needed, just a CD or HDD firmware is loaded, depending on the ID.

My device (model 222011 with integrated USB) identifies as 0ac9:0010. Once the firmware is loaded, the identification changes to 0ac9:1234. I've tested it in Windows and extracted the firmware from usbsnoop dump. After loading using fxload, the ID changed but the device still reports vendor specific class. Probably the firmware for Windows is not the same as for Linux and is not fully USB mass storage compatible :( 

lsusb output (before loading firmware):
Bus 002 Device 002: ID 0ac9:0010 Micro Solutions, Inc. BACKPACK
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x0ac9 Micro Solutions, Inc.
  idProduct          0x0010 BACKPACK
  bcdDevice            1.82
  iManufacturer           1 Micro Solutions
  iProduct                3 Micro Solutions BACKPACK
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x0020
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xc0
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol    255 Vendor Specific Protocol
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x88  EP 8 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
Device Qualifier (for other device speed):
  bLength                10
  bDescriptorType         6
  bcdUSB               2.00
  bDeviceClass            0
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  bNumConfigurations      1
Device Status:     0x0000
  (Bus Powered)

After loading firmware, only idProduct changes to 0x1234. Everything else remains.

-- 
Ondrej Zary
