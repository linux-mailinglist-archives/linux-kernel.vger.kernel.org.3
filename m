Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D3349C347
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 06:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbiAZFbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 00:31:23 -0500
Received: from mx.msync.work ([95.217.65.204]:48834 "EHLO mx.msync.work"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233071AbiAZFbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 00:31:19 -0500
X-Greylist: delayed 47802 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Jan 2022 00:31:19 EST
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D1171282C37;
        Wed, 26 Jan 2022 05:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1643175075; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=43g7eQfNihO4PvfDCp/q0KW8Ai3xysLurmj0NB1X6JI=;
        b=VCRhhIFdjeNKSoofU6YOSCS+vKVgFmgWOdy4dfk2phMG7BiPvu5yIiEk0bRLtadwzZrGKB
        sZ8RMmMC7O/rPSq+BCegZ1CLVYNuf3BddjnixVjidxmtOdawNYXZtuPUOmBDMov9ivSsq2
        VP4fvjXz/dkCG2M/Q6vbmOMItp0/M6nHwjO1dQNZdCc2u9m0FACD9PFfQD1nlWrbyglxjn
        yjFCBHa6/hNJD02A3aFeeGTilkyTppNqXgfBXPPg5ouvc7F0gxanxih9a5g0PWUxKIms2r
        1jS+hqL+rECjxNgdcOTyWB9IShnJHEGPmMHHuW2flMc7V+3D8V+bQuPOtkVTnQ==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rudi Heitbaum <rudi@heitbaum.com>
Subject: [PATCH v6 2/2] Bluetooth: hci_h5: Add power reset via gpio in h5_btrtl_open
Date:   Wed, 26 Jan 2022 08:31:03 +0300
Message-Id: <20220126053103.3261693-3-adeep@lexina.in>
In-Reply-To: <20220126053103.3261693-1-adeep@lexina.in>
References: <20220126053103.3261693-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add power reset for bluetooth via enable-gpios in h5_btrtl_open function.

While testing the RTL8822CS SDIO WiFi/BT adapter, it was found that in some
cases the kernel could not initialize BT firmware. However, manually
resetting the adapter via gpio (off/on sequence) allows it to start
correctly.
Apparently, when the system starts, the adapter is in an undefined state
(including unknown gpio state after starting uboot). A forced reset helps
to initialize the adapter in most cases. It has been found experimentally that
100 ms is sufficient for a reset.

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---
 drivers/bluetooth/hci_h5.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 34286ffe0568..fdf504b0d265 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -966,6 +966,11 @@ static void h5_btrtl_open(struct h5 *h5)
 		pm_runtime_enable(&h5->hu->serdev->dev);
 	}
 
+	/* The controller needs reset to startup */
+	gpiod_set_value_cansleep(h5->enable_gpio, 0);
+	gpiod_set_value_cansleep(h5->device_wake_gpio, 0);
+	msleep(100);
+
 	/* The controller needs up to 500ms to wakeup */
 	gpiod_set_value_cansleep(h5->enable_gpio, 1);
 	gpiod_set_value_cansleep(h5->device_wake_gpio, 1);
-- 
2.30.2

