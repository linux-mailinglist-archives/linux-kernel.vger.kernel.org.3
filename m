Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06EFE49C4A6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 08:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238002AbiAZHjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 02:39:21 -0500
Received: from mx.msync.work ([95.217.65.204]:52780 "EHLO mx.msync.work"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229676AbiAZHjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 02:39:18 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2EDF02832C1;
        Wed, 26 Jan 2022 07:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1643182757; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=gNondfYloya5eVokEo9OWDbeyWm4oRwSK5gz16WAuwY=;
        b=n9109b9nvfihvFC5I3TfE9rCQZWQIqe76Etm10sNl9Kaa6fbFfKJ7YA6rPEJDlt1KokCwX
        VoYAAFcOEke4pIhdDC6cuhq06tMoExpx9UrJF6M1Py8SO6Xb1Bhzw02O7pMfLwJmCa0tMk
        QfUN42uc0gk3HEBADYgqGLxk2T58DIA0eu6MctYQuhC0KQ/I+ksa4ycwowkKVb19/CBp1g
        yPi8pcRQisSP9Mn/+EZ+cKyz74OvL01CGeafr0V42GavAlTQl2ZVmD/TsoNEj9wgsQqAZX
        7xDqb8ZLgGQj21W/GcJp7Cj5K0BTu8pXZF57zUk8f0gN2H7CL2LVatLY5FfIoQ==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rudi Heitbaum <rudi@heitbaum.com>
Subject: [PATCH v7 2/2] Bluetooth: hci_h5: Add power reset via gpio in h5_btrtl_open
Date:   Wed, 26 Jan 2022 10:39:05 +0300
Message-Id: <20220126073905.3637841-3-adeep@lexina.in>
In-Reply-To: <20220126073905.3637841-1-adeep@lexina.in>
References: <20220126073905.3637841-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add power reset for bluetooth via enable-gpios in h5_btrtl_open function.

While testing the RTL8822CS SDIO WiFi/BT adapter, it was found that in
some cases the kernel could not initialize BT firmware. However,
manually resetting the adapter via gpio (off/on sequence) allows it to
start correctly.
Apparently, when the system starts, the adapter is in an undefined state
(including unknown gpio state after starting uboot). A forced reset helps
to initialize the adapter in most cases. It has been found experimentally
that 100 ms is sufficient for a reset.

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

