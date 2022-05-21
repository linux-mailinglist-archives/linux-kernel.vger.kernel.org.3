Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7397452FD22
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 16:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355057AbiEUOIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 10:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355026AbiEUOIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 10:08:20 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3985D5DE46;
        Sat, 21 May 2022 07:08:19 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id i24so9938325pfa.7;
        Sat, 21 May 2022 07:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=DR5VXAV46ZNrSUvYSzBBdYi4NqIK6+wyFDnsClAzea8=;
        b=YVk7W004WXd0BSeloz4SJsjaQlhDy4/cr1nhQchP54+vTXICvGLorc77k7b32WCtiY
         oaxAov9gQXknWuZFTKfar97SGW61tn7tmDZqCEmyIgEXSWIv9Jsaqz706MBWFHbOLieC
         knXGQz9J/pMh5KeidcZJblvKW3AVNbBhj2Dmw12mQSaLRdDaa1BY6VtDA9DHB3U95yX4
         Pfrops2IMNowERyu/Q0jw+4pkVesKrzpyr0Z+Z40vKs4KkwOq3UvTNNPMkPNxl+twpyJ
         ZCih8l+iFHk8N2YL7Teu5dagscaTVTJui3b3izB1X2TI3Ye9ihjf5YANhTMsmn7SmnW5
         qVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=DR5VXAV46ZNrSUvYSzBBdYi4NqIK6+wyFDnsClAzea8=;
        b=JB4V5EsHuBMBPNiUsVXvbeiRK1pX/LX8frdSWrhQvn0SC2A5MB0Te3AH+7VCb0qPb1
         Tg5Zv1pZlSgvsTz4/g8uoAwSoL22y1jZn9LDSR7omF9b9amLcLInSjg/5nMdzmY6jkLX
         fOKXr95uqlSgyBV6B9t7jcVGbE9gdACQBvTTO80fp6LiTgOv8Zb1ewcI4SdtUHmhKB60
         VGlf87vqp4Sp/QlfI1zKwM+2Tyi1lmnHMHz9bI+L3s/QFlJk3RiskOq9/F/lewPkDyJe
         cmI92KdqXuIy3doYTCdgUOH2R3rTKGRACcdBJ20DPOXprGfYCNqgqrLmXxv7J+Bf9ADf
         LB9g==
X-Gm-Message-State: AOAM5324/iCw6yEUHtT1gy2+4DlH71+L+4QLNvKR1jOOIHpLNgWAzC+6
        41gy0dmsD+54qe5fPveoCg==
X-Google-Smtp-Source: ABdhPJyDNdKp/dUUBsSOxK/CxADv5smFfLmHu4jn9nURvJIdXXX7P0f0IBfxT6dm8yLzHT8CDEYSKw==
X-Received: by 2002:a65:690a:0:b0:3f6:1815:f542 with SMTP id s10-20020a65690a000000b003f61815f542mr13019044pgq.275.1653142098581;
        Sat, 21 May 2022 07:08:18 -0700 (PDT)
Received: from octoberrain (p0109759-vcngn.kngw.nt.ngn.ppp.ocn.ne.jp. [61.210.74.190])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090a1b0600b001df7612950dsm3813773pjq.7.2022.05.21.07.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 07:08:18 -0700 (PDT)
Date:   Sat, 21 May 2022 23:08:08 +0900
From:   Robert Eckelmann <longnoserob@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: serial: io_ti: Adding Agilent E5805A support
Message-ID: <20220521230808.30931eca@octoberrain>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds support for Agilent E5805A (rebranded ION Edgeport/4) to
io_ti.

Signed-off-by: Robert Eckelmann <longnoserob@gmail.com>
---
output of lsusb -v (with Serial-Number of the device anonymized):

Bus 001 Device 024: ID 1608:1a01 Inside Out Networks [hex] E5805A USB/RS232 - 4 Port
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass         0 
  bDeviceProtocol       255 
  bMaxPacketSize0         8
  idVendor           0x1608 Inside Out Networks [hex]
  idProduct          0x1a01 
  bcdDevice            0.01
  iManufacturer           1 Agilent Technologies
  iProduct                2 E5805A USB/RS232 - 4 Port
  iSerial                 3 S12345678-0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x0035
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           5
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0 
      bInterfaceProtocol    255 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x87  EP 7 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval               1

Bus 001 Device 025: ID 1608:1a01 Inside Out Networks [hex] E5805A USB/RS232 - 4 Port
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass         0 
  bDeviceProtocol       255 
  bMaxPacketSize0         8
  idVendor           0x1608 Inside Out Networks [hex]
  idProduct          0x1a01 
  bcdDevice            0.01
  iManufacturer           1 Agilent Technologies
  iProduct                2 E5805A USB/RS232 - 4 Port
  iSerial                 3 S12345678-1
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x0035
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           5
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0 
      bInterfaceProtocol    255 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x87  EP 7 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval               1

Bus 001 Device 022: ID 1608:0281 Inside Out Networks [hex] 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 
  bDeviceProtocol         0 Full speed (or root) hub
  bMaxPacketSize0         8
  idVendor           0x1608 Inside Out Networks [hex]
  idProduct          0x0281 
  bcdDevice            1.51
  iManufacturer           0 
  iProduct                0 
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x0019
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0001  1x 1 bytes
        bInterval             255



Changes in v2:
  - removed documentation change
  - improvements to spaceing in io_usbvend.h
  - rephrasing comment in io_usbvend.h

 drivers/usb/serial/io_ti.c      | 2 ++
 drivers/usb/serial/io_usbvend.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/usb/serial/io_ti.c b/drivers/usb/serial/io_ti.c
index a7b3c15957ba..ff0d05f45fce 100644
--- a/drivers/usb/serial/io_ti.c
+++ b/drivers/usb/serial/io_ti.c
@@ -166,6 +166,7 @@ static const struct usb_device_id edgeport_2port_id_table[] = {
 	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_TI_EDGEPORT_8S) },
 	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_TI_EDGEPORT_416) },
 	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_TI_EDGEPORT_416B) },
+	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_E5805A)},
 	{ }
 };
 
@@ -204,6 +205,7 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_TI_EDGEPORT_8S) },
 	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_TI_EDGEPORT_416) },
 	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_TI_EDGEPORT_416B) },
+	{ USB_DEVICE(USB_VENDOR_ID_ION, ION_DEVICE_ID_E5805A)},
 	{ }
 };
 
diff --git a/drivers/usb/serial/io_usbvend.h b/drivers/usb/serial/io_usbvend.h
index 52cbc353051f..879ef755898f 100644
--- a/drivers/usb/serial/io_usbvend.h
+++ b/drivers/usb/serial/io_usbvend.h
@@ -213,6 +213,7 @@
 // Definitions for other product IDs
 #define ION_DEVICE_ID_MT4X56USB			0x1403	// OEM device
 
+#define ION_DEVICE_ID_E5805A			0x1A01  // OEM device (rebranded Edgeport/4)
 
 #define	GENERATION_ID_FROM_USB_PRODUCT_ID(ProductId)				\
 			((__u16) ((ProductId >> 8) & (ION_GENERATION_MASK)))
-- 
2.36.1

