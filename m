Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3315C57FAB9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbiGYIAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbiGYIAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:00:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AC713D11;
        Mon, 25 Jul 2022 01:00:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53DC8B80E06;
        Mon, 25 Jul 2022 08:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE027C341C7;
        Mon, 25 Jul 2022 08:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658736001;
        bh=Mcc6YivlY7VsK7Pilttr0NsQ6d26btY/8h5TMOw2PWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fTcdmQFFSblHtu/LzHjNKm3rcRHiKWRdZihdddxw9oTwwnBlupuck1iDCKWs4d5g0
         YGM6uJvZHBJWHJeZHCmdd6K0NcKtPFAw1iCLo9gLnR/U2dv5Vh/y7qBP7lS3weLxWy
         5Clbf5T0EzJLSPjt4OzU6Jn8dj4AHcU4MngcOSPrnt7O6qjt52OFW9yfVw3noHbMBu
         /J4w4GPSACf7GgaWXCd0zTzPo+j4u8ZqrGsBwY2cRrA6T4Yr9nrB6pbW7RdhL/qFnQ
         TaVjZr6n8nnPhv/CwMH8S3g9ghdQei0JpKGMtGFa3HqmYj53NA4gs3baPl4hbAyLCl
         2ilRyADzegWDA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oFt0e-0000K3-09; Mon, 25 Jul 2022 10:00:12 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Yan Xinyu <sdlyyxy@bupt.edu.cn>, linux-staging@lists.linux.dev,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/7] USB: cdc: add serial-state defines
Date:   Mon, 25 Jul 2022 09:58:36 +0200
Message-Id: <20220725075841.1187-3-johan@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725075841.1187-1-johan@kernel.org>
References: <20220725075841.1187-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add defines for the serial-state bitmap values from section 6.3.5
SerialState of the CDC specification version 1.1.

Note that the bTxCarrier and bRxCarrier bits have been named after their
RS-232 signal equivalents DSR and DCD.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 include/uapi/linux/usb/cdc.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/uapi/linux/usb/cdc.h b/include/uapi/linux/usb/cdc.h
index 372c81425cae..78caa9bdc4ae 100644
--- a/include/uapi/linux/usb/cdc.h
+++ b/include/uapi/linux/usb/cdc.h
@@ -306,6 +306,15 @@ struct usb_cdc_notification {
 	__le16	wLength;
 } __attribute__ ((packed));
 
+/* UART State Bitmap Values from 6.3.5 SerialState */
+#define USB_CDC_SERIAL_STATE_DCD		(1 << 0)
+#define USB_CDC_SERIAL_STATE_DSR		(1 << 1)
+#define USB_CDC_SERIAL_STATE_BREAK		(1 << 2)
+#define USB_CDC_SERIAL_STATE_RING_SIGNAL	(1 << 3)
+#define USB_CDC_SERIAL_STATE_FRAMING		(1 << 4)
+#define USB_CDC_SERIAL_STATE_PARITY		(1 << 5)
+#define USB_CDC_SERIAL_STATE_OVERRUN		(1 << 6)
+
 struct usb_cdc_speed_change {
 	__le32	DLBitRRate;	/* contains the downlink bit rate (IN pipe) */
 	__le32	ULBitRate;	/* contains the uplink bit rate (OUT pipe) */
-- 
2.35.1

