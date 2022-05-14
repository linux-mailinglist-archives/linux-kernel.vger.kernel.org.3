Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1224526F8D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiEND2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 23:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbiEND2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 23:28:13 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196964ECC3;
        Fri, 13 May 2022 20:28:12 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id b12so326179pju.3;
        Fri, 13 May 2022 20:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=2AYMjQ0FPtZrX3yrJlm16kLXC3jsNpv/dpUcXlVmXW8=;
        b=o4m2kFqfe35zknd+nm4pxEbQkwGchn4189T5GM+ZT99qaHIcTcBMVWhGjt6T/2j1Kp
         yXemAuRhBStnkDvCP/4Y/L/wFvM7LhxqFN0/2lWHpzTAJZ1LlKfEjTF2E2x8xkL3Cxr1
         7PdHgKpWzP7Q2u9zeqCynK7flnTNK2S7J/mixUvVpoLeWM46mTtPkTAu0y9DE1GYj+sB
         IxLjBIxu9kJzlmYccyw5nfruZJw/9VFuLZQGF/3z/nrtgq7LIi+gDW4zX5CApK312Wzx
         vWq1cAMYUlZ2Lu4MYJa6oT2JGxIChL2gBsDUu8ko0Qt/+RC5TYq1G9FU/rVkZwQA89Lo
         u3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=2AYMjQ0FPtZrX3yrJlm16kLXC3jsNpv/dpUcXlVmXW8=;
        b=DBGwYYsnoi5uWgFmD0x+eh5fPA/vpUaHvzEg5Ob0ctvz6n0ERn2WLJgQ8L8lgMJDZk
         aKByqCehBxdSg65JbXbqfXWIt/cr0c+9lsD6rR9A5LOfKiMd54yxrJ6Tm1sMksuQpLdm
         nHsY4+6yXaLEyABMgCyHzPW43JbWDHZBvP7svl5frNxNHhsl8b1w1VUgrtbFU2B7hfMe
         VgrPR9cywlm1HzYKcwsEwm7YxPBOfnSLlg47v2XEu1b2+wkrRkXDNx9EMIaFJZsKiMgM
         dEC8B1gWLOIEXWBKzzhpXl/CePoRwx/dAOMuGdOICoBlbd3ufgS4oCbiMXqDn9SRq2kK
         GpJw==
X-Gm-Message-State: AOAM530WasYL8RcetGyqVGDeCh2M8SPPbHHWXqMqjk88P7AARkpWxtte
        K+x+NAovZz3gn2YfwQmFei+kl+ymNY0lp1E=
X-Google-Smtp-Source: ABdhPJz/FT3B6Q6HpcRJed2meVLe750dPnJn1O3VXeQ2Hq3kPkL1U0bOr5FOSkWvOiwKA/PcaY27DA==
X-Received: by 2002:a17:90a:e7d2:b0:1dc:3762:c72d with SMTP id kb18-20020a17090ae7d200b001dc3762c72dmr19426320pjb.243.1652498891618;
        Fri, 13 May 2022 20:28:11 -0700 (PDT)
Received: from octoberrain (p0109759-vcngn.kngw.nt.ngn.ppp.ocn.ne.jp. [61.210.74.190])
        by smtp.gmail.com with ESMTPSA id a8-20020a170902710800b0015f2d625f4bsm2507410pll.274.2022.05.13.20.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 20:28:11 -0700 (PDT)
Date:   Sat, 14 May 2022 12:28:04 +0900
From:   Robert Eckelmann <longnoserob@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org, corbet@lwn.net,
        linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: serial: io_ti: Adding Agilent E5805A support
Message-ID: <20220514122804.05c69987@octoberrain>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
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

Hello Johan,

Below is a small patch regarding the io_ti driver.
This patch enables the use of the Agilent E5805A USB-RS232(x4) adapter.
It is a relabeled Inside Out Networks Edgeport with OEM USB-ID.



Signed-off-by: Robert Eckelmann <longnoserob@gmail.com>
---
 Documentation/usb/usb-serial.rst | 4 ++++
 drivers/usb/serial/io_ti.c       | 2 ++
 drivers/usb/serial/io_usbvend.h  | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/usb/usb-serial.rst b/Documentation/usb/usb-serial.rst
index 69586aeb60bb..d9cfb6cb2d07 100644
--- a/Documentation/usb/usb-serial.rst
+++ b/Documentation/usb/usb-serial.rst
@@ -412,6 +412,10 @@ Inside Out Networks Edgeport Driver
        - Edgeport/4 DIN
        - Edgeport/16 Dual

+  This dirver now also includes the Agilent E5805A usb-to-RS232 adapter device,
+  as this is a rebranded Edgeport device.
+
+
   For any questions or problems with this driver, please contact Greg
   Kroah-Hartman at greg@kroah.com

diff --git a/drivers/usb/serial/io_ti.c b/drivers/usb/serial/io_ti.c
index a7b3c15957ba..2810cefa628d 100644
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
index 52cbc353051f..3be6bce15d97 100644
--- a/drivers/usb/serial/io_usbvend.h
+++ b/drivers/usb/serial/io_usbvend.h
@@ -212,7 +212,7 @@
 //
 // Definitions for other product IDs
 #define ION_DEVICE_ID_MT4X56USB			0x1403	// OEM device
-
+#define ION_DEVICE_ID_E5805A			0x1A01  // OEM device (internals based on Edgeport/4?)

 #define	GENERATION_ID_FROM_USB_PRODUCT_ID(ProductId)				\
			((__u16) ((ProductId >> 8) & (ION_GENERATION_MASK)))
--
2.36.0
