Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0185547F9A4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 02:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbhL0BYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 20:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234919AbhL0BYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 20:24:17 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1920C06173E;
        Sun, 26 Dec 2021 17:24:16 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a9so29451025wrr.8;
        Sun, 26 Dec 2021 17:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l7XaE1ox+EybYQK2y5B/cfNwNeDOTbXqYvl+5XQIXz8=;
        b=T/9OKp2AOg9HhQCvM2Sp4xnYrs66KRUOqO2U/euyTKbk1tGH4PMxPRCiAGsRkdxbig
         l/cUpAgd2c/0eltisAEBkmUNB0AuHv2YPVLMt5hgWELPVGlQQC+FtScEHXjlIj2Sv1fi
         9CORxmbOyPGklz1uRLH8yJHS8wHcdvYacrzjAl+MWC7s16+yBpLA6gr0YEHMJFpsjmjW
         HrsBowXv/GGpqBDUil7uMhA9zHUcfHFrU9IQoOngIhe0ZKKD1t3LmJQDdmNVQ95F+2xD
         hfzViUM/m7up6QJKjBilrS1s+BkTkMrgcWnqRnnkp4n2REvKJpMasgyeg3q7DS00BmmL
         68dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l7XaE1ox+EybYQK2y5B/cfNwNeDOTbXqYvl+5XQIXz8=;
        b=fJetgztvC0wG64JAJpKqOJCUp17bmHVZowC8JME5kCmGGM3z6Lseg7yZQRp9+mSqKT
         qzLiIuAjqVv+a4up6f2z6sangxF6hjSv45cP4umLpfrPlk/3RCSeG/D6igGos0+ZzRuV
         0fyT1E4ur2Umw9Q+XlbW92x2zw7387LfQCZZZsF+BBNsCXpbXGZFtjKnJ95lwxBDwlII
         NMHwo/DK62EbDqYOvkz7MTpKrOJUPqNnBHFvRmOCnBmMkc91IdIjvIZ1kqnEWO5jby2c
         P3pAIJuJchvtoBbUwqYLOFVdCB+7Lrxtluq7LspJq5IDGK5YV2//s+wc4wJQ1o0Va6PC
         AgRQ==
X-Gm-Message-State: AOAM532aaETwhz5U361CSbDkfK/7ILcBQfMz+kkMGoBf9DgvnTSUc9i2
        41rlLlRI1FaHu5CLK0smMk4Hen1m7WQ=
X-Google-Smtp-Source: ABdhPJzehXw034muaUcXaBIHhswRgEv6TPVYwXq5XDXCAG+bmTwOZeUL+D6AuLTP6rGzDfrrGXmezg==
X-Received: by 2002:a05:6000:124a:: with SMTP id j10mr10838235wrx.110.1640568254699;
        Sun, 26 Dec 2021 17:24:14 -0800 (PST)
Received: from morpheus.home.roving-it.com (a.7.4.5.7.2.7.b.4.1.9.2.a.3.0.0.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:fb11:2681:3a:2914:b727:547a])
        by smtp.googlemail.com with ESMTPSA id g5sm14066000wru.48.2021.12.26.17.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 17:24:14 -0800 (PST)
From:   Peter Robinson <pbrobinson@gmail.com>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Johan Hovold <johan@kernel.org>
Subject: [RFC PATCH] gnss: usb: add support for U-Blox NEO-M9N
Date:   Mon, 27 Dec 2021 01:23:57 +0000
Message-Id: <20211227012357.788966-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the USB interface of the SparkFun NEO-M9N
GPS Breakout receiver.

Bus 001 Device 005: ID 1546:01a9 U-Blox AG u-blox GNSS receiver
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            2 Communications
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x1546 U-Blox AG
  idProduct          0x01a9
  bcdDevice            4.04
  iManufacturer           1 u-blox AG - www.u-blox.com
  iProduct                2 u-blox GNSS receiver
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x003e
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
      CDC Header:
        bcdCDC               1.10
      CDC ACM:
        bmCapabilities       0x02
          line coding and serial state
      CDC Call Management:
        bmCapabilities       0x03
          call management
          use DataInterface
        bDataInterface          1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval             255
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass        10 CDC Data
      bInterfaceSubClass      0
      bInterfaceProtocol    255 Vendor specific
      iInterface              0
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
Device Status:     0x0001
  Self Powered

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
Cc: Johan Hovold <johan@kernel.org>
---
Hi Johan,

I've tested your GNSS USB series with a pair of U-Blox devices, adding
the above USB ID. Only one included here for feedback to guage your thoughts.
By defauly The U-Blox devices enumerate with the CDC ACM driver and output
NMEA data via /dev/ttyACM0. With this patch and cdc_acm blocked I get
/dev/gnss0 and can cat it to get NMEA data. Is your expectation to move
these sort of devices over to the usb gnss driver too?

Peter

 drivers/gnss/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gnss/usb.c b/drivers/gnss/usb.c
index 792235a688ea..775d58c2dbe1 100644
--- a/drivers/gnss/usb.c
+++ b/drivers/gnss/usb.c
@@ -18,6 +18,7 @@
 
 static const struct usb_device_id gnss_usb_id_table[] = {
 	{ USB_DEVICE(0x1199, 0xb000) },		/* Sierra Wireless XM1210 */
+	{ USB_DEVICE(0x1546, 0x01a9) },		/* U-Blox NEO-M9N GNSS receiver */
 	{ }
 };
 MODULE_DEVICE_TABLE(usb, gnss_usb_id_table);
-- 
2.33.1

