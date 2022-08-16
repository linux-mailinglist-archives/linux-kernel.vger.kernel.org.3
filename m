Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD964595FF7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 18:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbiHPQPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 12:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235868AbiHPQPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 12:15:04 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E018606BD
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 09:14:59 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x21so14141967edd.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 09:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=croix-rouge-fr.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=IwJY805e5ibf53/jFjH/AJK2o+b+iwdmUySYuPRA6GM=;
        b=EphVtzQnNbhIRnuGeq6wu/LKICtxVFAUeBkHWk1cy8I1K6QRsiv3jowJvIlvdazPuI
         eV/osyzmuyhjtzbtZ/1LojP1GkITm9i/XTsm5Py2+IV1hSIHO6sblclSjnhA9TU098OT
         VjTLNGahfxvUcF5hNY/lz4DsyHLgrSNqCpC+7VA1W+ZAMn1iusHKR8YTQQW5dmuGfFyv
         1KQuXDb9VJTS1GUS4nO9nC7Lm8nSmItr2+xwt9FiV3TkA7+gPW06x6kVCtJjGoFLeeF3
         1T0zxb636Z2Zecn40Oi5jA9Fp29/dGGuJKjs/LWMOh9CMwdIYb6o30152w8lXsWU2BVS
         /mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=IwJY805e5ibf53/jFjH/AJK2o+b+iwdmUySYuPRA6GM=;
        b=r0G4ENGc0xYRK1EiBLB45006IoYG1PfOjJKeMhiBVZTEjxQldt4CWc9FnmrYiZEOfj
         hFhtXUEEfxBMQGHm1bJ6l4rfHuR+h8DV6mPi7fmBD+YVAMWbPFHBQ4l2YWZT1ToISahw
         oOyS9f+7yr8I52QThYbysqorXTO6iwaWXjXl1wKvFvntpEswgHM0gplM6hmKQ63LMfS5
         XVdfgsNrWELhr8FTu1WJeJEtaIN6GaOIdfe5uBfyX8c5DYL4nCk35goMqAwbUfBvEu1A
         f2r+TiUiHdnaW7CdVGLl3VMtSbwTO0svbp66ip8r/LUpHkUcrOfM2+Akjb8mD1MCwA07
         6bTA==
X-Gm-Message-State: ACgBeo2tTRWrbNI/xLQAgWqHPA9FfinynF2iT/t/LVbLmamt2kaoUoLp
        FM4esSejuVHmLD6a+ZlFZbaHrFvb2CeGpA1MAC+/fg==
X-Google-Smtp-Source: AA6agR4cmH6Q5qQoe8xQRk5OG/S/RKElwaNLwm91GCslsF+cVkm2TAHofppf+4+zQ8FqXvKGutd/8Q1CW07ih7n40pM=
X-Received: by 2002:a05:6402:293:b0:43d:3936:66b0 with SMTP id
 l19-20020a056402029300b0043d393666b0mr19081057edv.404.1660666497863; Tue, 16
 Aug 2022 09:14:57 -0700 (PDT)
MIME-Version: 1.0
From:   Thierry Guibert <thierry.guibert@croix-rouge.fr>
Date:   Tue, 16 Aug 2022 18:14:21 +0200
Message-ID: <CAEzRux_E+EAEkdr8RVGq4BTJ87G75fwXf4gveLTmk_P3nxizvw@mail.gmail.com>
Subject: [PATCH] CDC-ACM : Add Icom PMR F3400 support (0c26:0020)
To:     oneukum@suse.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From cf6471caeee7ac7d92bfa4ceaaa16ab461846e65 Mon Sep 17 00:00:00 2001
From: Thierry GUIBERT <thierry.guibert@croix-rouge.fr>
Date: Tue, 16 Aug 2022 00:46:01 +0200
Subject: [PATCH] CDC-ACM : Add Icom PMR F3400 support (0c26:0020)

Supports for ICOM F3400 and ICOM F4400 PMR radios in CDC-ACM driver
enabling the AT serial port.
The Vendor Id is 0x0C26
The Product ID is 0x0020

Output of lsusb :
Bus 001 Device 009: ID 0c26:0020 Prolific Technology Inc. ICOM Radio
Couldn't open device, some information will be missing
Device Descriptor:
 bLength                18
 bDescriptorType         1
 bcdUSB               2.00
 bDeviceClass            2 Communications
 bDeviceSubClass         0
 bDeviceProtocol         0
 bMaxPacketSize0        64
 idVendor           0x0c26 Prolific Technology Inc.
 idProduct          0x0020
 bcdDevice            0.00
 iManufacturer           1 ICOM Inc.
 iProduct                2 ICOM Radio
 iSerial                 3 *obfuscated*
 bNumConfigurations      1
 Configuration Descriptor:
   bLength                 9
   bDescriptorType         2
   wTotalLength       0x0030
   bNumInterfaces          2
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
     bNumEndpoints           1
     bInterfaceClass         2 Communications
     bInterfaceSubClass      2 Abstract (modem)
     bInterfaceProtocol      1 AT-commands (v.25ter)
     iInterface              0
     Endpoint Descriptor:
       bLength                 7
       bDescriptorType         5
       bEndpointAddress     0x83  EP 3 IN
       bmAttributes            3
         Transfer Type            Interrupt
         Synch Type               None
         Usage Type               Data
       wMaxPacketSize     0x0040  1x 64 bytes
       bInterval              12
   Interface Descriptor:
     bLength                 9
     bDescriptorType         4
     bInterfaceNumber        1
     bAlternateSetting       0
     bNumEndpoints           2
     bInterfaceClass        10 CDC Data
     bInterfaceSubClass      0
     bInterfaceProtocol      0
     iInterface              0
     Endpoint Descriptor:
       bLength                 7
       bDescriptorType         5
       bEndpointAddress     0x82  EP 2 IN
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

Signed-off-by: Thierry GUIBERT <thierry.guibert@croix-rouge.fr>
---
drivers/usb/class/cdc-acm.c | 4 ++++
1 file changed, 4 insertions(+)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 9b9aea24d58c..091fcfac3717 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1813,6 +1813,10 @@ static const struct usb_device_id acm_ids[] = {
       { USB_DEVICE(0x0ca6, 0xa050), /* Castles VEGA3000 */
       .driver_info = NO_UNION_NORMAL, /* reports zero length descriptor */
       },
+       { USB_DEVICE(0x0c26, 0x0020), /* Icom ICF3400 Serie */
+       .driver_info = NO_UNION_NORMAL, /* reports zero length descriptor */
+       },
+

       { USB_DEVICE(0x2912, 0x0001), /* ATOL FPrint */
       .driver_info = CLEAR_HALT_CONDITIONS,
--
2.37.2
