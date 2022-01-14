Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9516F48EC5A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238541AbiANPMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbiANPMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:12:05 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B387C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:12:05 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso7884616wmj.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gtoGJAaTWD5rbU4WeYi3UYwlPvJul/pQmYMABUYT0Jg=;
        b=ITDoa7bvgJ+YJ/qRmBmFAnI9lEW9gSSsjrqotP+onQB+D541L3lqCUZFGN2MY83aBx
         XFvWKPRgU/sm1XJwMqEsv5hJZ49truclUavCRAyF9zDrGXa8LoNydG61zqysN9tH3tQq
         DaUUzlGXVjXUlsa8pvFCx6lttn5OF8RCq0njc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gtoGJAaTWD5rbU4WeYi3UYwlPvJul/pQmYMABUYT0Jg=;
        b=Bw/zouMT05DRyh5Y+ltGhueGNBEjqrsescv8G/sb9NiK6w4PrSeKVXNEQBVlZxHlAQ
         YWyZNHGUesyzPMjKVjtkcghUIjxZjn/uUJtBugQtaEkCc30O5/uzKh+M+IfkM9qO34+k
         ePzTmxemW4mZ+E+77HJY6ML8GHulpoer1fjYREwq+AHnt1ElR4tMillyEi1ahksI42f8
         0tx7jq42BtmcvcYwKsHgoIL8QyAjTd5RRYzqS2l4Jak9K7aD6+sImV/Fq7LxpjazgfqG
         TGEQVpJJCqAFdoztfRVi7eQtaAb02llzMP4owvMxOqWyIP4h4o5KJ7y2uaiqieVQq44F
         izSQ==
X-Gm-Message-State: AOAM5304QjpWF2Uu0xCrJPWc1H9UGTqAIfa0pUkORyy4KUJBtpqt26Qy
        8wN686nnI//8TksuMxatrU0lYw==
X-Google-Smtp-Source: ABdhPJygeS7NtZxiP1HYdBCgm7FYn7wyqKB4fqKUlUDgd8s+Q4YMeJf5ViieOoUukluFlZJo3mjMaQ==
X-Received: by 2002:a17:907:724e:: with SMTP id ds14mr3159406ejc.711.1642173123598;
        Fri, 14 Jan 2022 07:12:03 -0800 (PST)
Received: from alco.corp.google.com ([100.104.168.197])
        by smtp.gmail.com with ESMTPSA id di18sm1891356ejc.56.2022.01.14.07.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:12:03 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH] media: uvcvideo: Recover stalled ElGato devices
Date:   Fri, 14 Jan 2022 16:11:45 +0100
Message-Id: <20220114151145.381637-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Elgato Cam Link 4k can be in a stalled state if the resolution of
the external source has changed while the firmware initializes.
Once in this state, the device is useless until it receives a
USB reset. It has even been observed that the stalled state will
continue even after unplugging the device.

lsusb -v

Bus 002 Device 002: ID 0fd9:0066 Elgato Systems GmbH Cam Link 4K
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               3.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0         9
  idVendor           0x0fd9 Elgato Systems GmbH
  idProduct          0x0066
  bcdDevice            0.00
  iManufacturer           1 Elgato
  iProduct                2 Cam Link 4K
  iSerial                 4 0005AC52FE000
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x01ca
    bNumInterfaces          5
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              800mA
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         0
      bInterfaceCount         2
      bFunctionClass         14 Video
      bFunctionSubClass       3 Video Interface Collection
      bFunctionProtocol       0
      iFunction               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      1 Video Control
      bInterfaceProtocol      0
      iInterface              5 Cam Link 4K
      VideoControl Interface Descriptor:
        bLength                13
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdUVC               1.10
        wTotalLength       0x002b
        dwClockFrequency        0.000000MHz
        bInCollection           1
        baInterfaceNr( 0)       1
      VideoControl Interface Descriptor:
        bLength                 8
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             1
        wTerminalType      0x0200 Input Vendor Specific
        bAssocTerminal          0
        iTerminal               0
      VideoControl Interface Descriptor:
        bLength                13
        bDescriptorType        36
        bDescriptorSubtype      5 (PROCESSING_UNIT)
        bUnitID                 2
        bSourceID               1
        wMaxMultiplier          0
        bControlSize            3
        bmControls     0x0000000f
          Brightness
          Contrast
          Hue
          Saturation
        iProcessing             0
        bmVideoStandards     0x00
      VideoControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             3
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               2
        iTerminal               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
        bMaxBurst               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0
      iInterface              5 Cam Link 4K
      VideoStreaming Interface Descriptor:
        bLength                            16
        bDescriptorType                    36
        bDescriptorSubtype                  1 (INPUT_HEADER)
        bNumFormats                         3
        wTotalLength                   0x00cd
        bEndpointAddress                 0x83  EP 3 IN
        bmInfo                              0
        bTerminalLink                       3
        bStillCaptureMethod                 1
        bTriggerSupport                     0
        bTriggerUsage                       0
        bControlSize                        1
        bmaControls( 0)                     0
        bmaControls( 1)                     0
        bmaControls( 2)                     0
      VideoStreaming Interface Descriptor:
        bLength                            27
        bDescriptorType                    36
        bDescriptorSubtype                  4 (FORMAT_UNCOMPRESSED)
        bFormatIndex                        1
        bNumFrameDescriptors                1
        guidFormat                            {3231564e-0000-0010-8000-00aa00389b71}
        bBitsPerPixel                      12
        bDefaultFrameIndex                  1
        bAspectRatioX                       0
        bAspectRatioY                       0
        bmInterlaceFlags                 0x00
          Interlaced stream or variable: No
          Fields per frame: 2 fields
          Field 1 first: No
          Field pattern: Field 1 only
        bCopyProtect                        0
      VideoStreaming Interface Descriptor:
        bLength                            30
        bDescriptorType                    36
        bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
        bFrameIndex                         1
        bmCapabilities                   0x01
          Still image supported
        wWidth                           3840
        wHeight                          2160
        dwMinBitRate                2985984000
        dwMaxBitRate                2985984000
        dwMaxVideoFrameBufferSize    12441600
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  1
        dwFrameInterval( 0)            333333
      VideoStreaming Interface Descriptor:
        bLength                             6
        bDescriptorType                    36
        bDescriptorSubtype                 13 (COLORFORMAT)
        bColorPrimaries                     1 (BT.709,sRGB)
        bTransferCharacteristics            1 (BT.709)
        bMatrixCoefficients                 1 (BT.709)
      VideoStreaming Interface Descriptor:
        bLength                            27
        bDescriptorType                    36
        bDescriptorSubtype                  4 (FORMAT_UNCOMPRESSED)
        bFormatIndex                        2
        bNumFrameDescriptors                1
        guidFormat                            {3231564e-0000-0010-8000-00aa00389b71}
        bBitsPerPixel                      12
        bDefaultFrameIndex                  1
        bAspectRatioX                       0
        bAspectRatioY                       0
        bmInterlaceFlags                 0x00
          Interlaced stream or variable: No
          Fields per frame: 2 fields
          Field 1 first: No
          Field pattern: Field 1 only
        bCopyProtect                        0
      VideoStreaming Interface Descriptor:
        bLength                            30
        bDescriptorType                    36
        bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
        bFrameIndex                         1
        bmCapabilities                   0x01
          Still image supported
        wWidth                           3840
        wHeight                          2160
        dwMinBitRate                2985984000
        dwMaxBitRate                2985984000
        dwMaxVideoFrameBufferSize    12441600
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  1
        dwFrameInterval( 0)            333333
      VideoStreaming Interface Descriptor:
        bLength                             6
        bDescriptorType                    36
        bDescriptorSubtype                 13 (COLORFORMAT)
        bColorPrimaries                     1 (BT.709,sRGB)
        bTransferCharacteristics            1 (BT.709)
        bMatrixCoefficients                 1 (BT.709)
      VideoStreaming Interface Descriptor:
        bLength                            27
        bDescriptorType                    36
        bDescriptorSubtype                  4 (FORMAT_UNCOMPRESSED)
        bFormatIndex                        3
        bNumFrameDescriptors                1
        guidFormat                            {30323449-0000-0010-8000-00aa00389b71}
        bBitsPerPixel                      12
        bDefaultFrameIndex                  1
        bAspectRatioX                       0
        bAspectRatioY                       0
        bmInterlaceFlags                 0x00
          Interlaced stream or variable: No
          Fields per frame: 2 fields
          Field 1 first: No
          Field pattern: Field 1 only
        bCopyProtect                        0
      VideoStreaming Interface Descriptor:
        bLength                            30
        bDescriptorType                    36
        bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
        bFrameIndex                         1
        bmCapabilities                   0x01
          Still image supported
        wWidth                           3840
        wHeight                          2160
        dwMinBitRate                2985984000
        dwMaxBitRate                2985984000
        dwMaxVideoFrameBufferSize    12441600
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  1
        dwFrameInterval( 0)            333333
      VideoStreaming Interface Descriptor:
        bLength                             6
        bDescriptorType                    36
        bDescriptorSubtype                 13 (COLORFORMAT)
        bColorPrimaries                     1 (BT.709,sRGB)
        bTransferCharacteristics            1 (BT.709)
        bMatrixCoefficients                 1 (BT.709)
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst              15
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         2
      bInterfaceCount         1
      bFunctionClass          3 Human Interface Device
      bFunctionSubClass       0
      bFunctionProtocol       0
      iFunction               5 Cam Link 4K
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.01
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     207
         Report Descriptors:
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x86  EP 6 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval              10
        bMaxBurst               0
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         3
      bInterfaceCount         2
      bFunctionClass          1 Audio
      bFunctionSubClass       2 Streaming
      bFunctionProtocol       0
      iFunction               6 Cam Link 4K
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol      0
      iInterface              6 Cam Link 4K
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength       0x001e
        bInCollection           1
        baInterfaceNr(0)        4
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             1
        wTerminalType      0x0602 Digital Audio Interface
        bAssocTerminal          0
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0
        iTerminal               0
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             2
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               1
        iTerminal               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        4
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0
      iInterface              6 Cam Link 4K
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        4
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0
      iInterface              6 Cam Link 4K
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           2
        bDelay                  1 frames
        wFormatTag         0x0001 PCM
      AudioStreaming Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x00c0  1x 192 bytes
        bInterval               4
        bRefresh                0
        bSynchAddress           0
        bMaxBurst               0
        AudioStreaming Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x00
          bLockDelayUnits         0 Undefined
          wLockDelay         0x0000
Binary Object Store Descriptor:
  bLength                 5
  bDescriptorType        15
  wTotalLength       0x0016
  bNumDeviceCaps          2
  USB 2.0 Extension Device Capability:
    bLength                 7
    bDescriptorType        16
    bDevCapabilityType      2
    bmAttributes   0x00000002
      HIRD Link Power Management (LPM) Supported
  SuperSpeed USB Device Capability:
    bLength                10
    bDescriptorType        16
    bDevCapabilityType      3
    bmAttributes         0x00
    wSpeedsSupported   0x000e
      Device can operate at Full Speed (12Mbps)
      Device can operate at High Speed (480Mbps)
      Device can operate at SuperSpeed (5Gbps)
    bFunctionalitySupport   3
      Lowest fully-functional device speed is SuperSpeed (5Gbps)
    bU1DevExitLat           0 micro seconds
    bU2DevExitLat           0 micro seconds
Device Status:     0x0000
  (Bus Powered)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 1b4cc934109e..818e504eb62a 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -129,12 +129,12 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
 	return -EPIPE;
 }
 
+static const struct usb_device_id elgato_cam_link_4k = {
+						USB_DEVICE(0x0fd9, 0x0066)};
+
 static void uvc_fixup_video_ctrl(struct uvc_streaming *stream,
 	struct uvc_streaming_control *ctrl)
 {
-	static const struct usb_device_id elgato_cam_link_4k = {
-		USB_DEVICE(0x0fd9, 0x0066)
-	};
 	struct uvc_format *format = NULL;
 	struct uvc_frame *frame = NULL;
 	unsigned int i;
@@ -292,7 +292,7 @@ static int uvc_get_video_ctrl(struct uvc_streaming *stream,
 		dev_err(&stream->intf->dev,
 			"Failed to query (%u) UVC %s control : %d (exp. %u).\n",
 			query, probe ? "probe" : "commit", ret, size);
-		ret = -EIO;
+		ret = (ret == -EPROTO) ? -EPROTO : -EIO;
 		goto out;
 	}
 
@@ -2102,6 +2102,20 @@ int uvc_video_init(struct uvc_streaming *stream)
 	 * request on the probe control, as required by the UVC specification.
 	 */
 	ret = uvc_get_video_ctrl(stream, probe, 1, UVC_GET_CUR);
+
+	/*
+	 * Elgato Cam Link 4k can be in a stalled state if the resolution of
+	 * the external source has changed while the firmware initializes.
+	 * Once in this state, the device is useless until it receives a
+	 * USB reset. It has even been observed that the stalled state will
+	 * continue even after unplugging the device.
+	 */
+	if (usb_match_one_id(stream->dev->intf, &elgato_cam_link_4k) &&
+	    (ret == -EPROTO)) {
+		usb_reset_device(stream->dev->udev);
+		dev_err(&stream->intf->dev, "Restarting Elgato Cam Link 4K\n");
+	}
+
 	if (ret < 0)
 		return ret;
 
-- 
2.34.1.703.g22d0c6ccf7-goog

