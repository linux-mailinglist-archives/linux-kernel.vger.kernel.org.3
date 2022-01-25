Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D570549B872
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242353AbiAYQU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354290AbiAYQQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:16:53 -0500
Received: from mx.msync.work (mx.msync.work [IPv6:2a01:4f9:2b:2dc2::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06F9C061744
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:16:52 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B5866280BE1;
        Tue, 25 Jan 2022 16:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1643127257; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=ZaUa/CaL6dxwiDX9xBVtw2/ZWg2BaHlrMqUB+epYmUg=;
        b=dLHeUTAChNUc0fo0L5fQQcmbgb+RJFWBi1yNUJRTRReqcjhKuo629cJt1jRvJYLzI3lv6d
        1gmSrxUaQIgYFrxNKPSysToV1viAtXMX/7kA1fhJHl8FTSBNFTqVdY+O3d660zNOlp46Pp
        xlRz24w8tl1EoB75mNMbMJGPoIvaW1EZ6E6Gn5BtZ2kdpk8VwGcS9n0rUB66if0hzvtGPb
        4M+7pqysD00VeFM5yxa6Xd6ok1t81Yye/uc1zITw0jZZr8VM2xyWyI4e77M35CqNJSzQq3
        xcNp8dkh+xFcrWh+JKFRX6yCUp2Dd7jxyxlt9izyAJqR8KFrig0eMiORjSbevQ==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rudi Heitbaum <rudi@heitbaum.com>
Subject: [PATCH v5 2/2] Bluetooth: hci_h5: Add power reset via gpio in h5_btrtl_open
Date:   Tue, 25 Jan 2022 19:14:01 +0300
Message-Id: <20220125161401.729179-3-adeep@lexina.in>
In-Reply-To: <20220125161401.729179-1-adeep@lexina.in>
References: <20220125161401.729179-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add power reset for bluetooth via enable-gpios in h5_btrtl_open function.

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---

While testing the RTL8822CS SDIO WiFi/BT adapter, I found that in some
cases the kernel could not initialize it. However, manually resetting the
adapter via gpio allows it to start correctly.
Apparently at system start the adapter is in an undefined state (including
the unknown state of gpio after starting uboot). A forced reset helps to
initialize the adapter in most cases. Experimentally it was found that
100ms is enough to reset.

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

