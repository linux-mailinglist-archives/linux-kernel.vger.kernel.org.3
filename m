Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C427C4955EB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 22:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377821AbiATVY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 16:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347775AbiATVY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 16:24:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67910C06161C;
        Thu, 20 Jan 2022 13:24:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0637B60018;
        Thu, 20 Jan 2022 21:24:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5ACC340E5;
        Thu, 20 Jan 2022 21:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642713896;
        bh=hHa2vsWqZope6dE5BM2dTH63C6nTwIElUo+CDUVb3Vs=;
        h=Date:From:To:Cc:Subject:From;
        b=fn3W2BEfiC+mCMp8OUuAvEWXUn55FurdT4wdFl9zaZfJ10KfHcHQGzn7x12AnpJ3E
         vkqNSkN8COcHEHipYoa+D48mYYhM+DMsSlorf0Hgwg0Ohw57n1Lxr8K/RyMx3uzIxE
         vi7QY/hup/Utf1+e6yGi5Gm0Un+PliO/aeVJ8GQ7sZkdZlsAmvEC4yf2gvrR+4dD9f
         j2pUyP2v2W7usBXU7x3fAqcBs9jIAcxTtlPKleWq01pe+AsNTZ3It/rluxIeQhVU8V
         mhJMzKu8W/ymSVnSrVXxcE8LKFIAiaBcOSiqva3wh9MMA3HQzVuO+QpMS78/7/lau2
         wmPaOR/wjNCUA==
Date:   Thu, 20 Jan 2022 15:31:31 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] USB: serial: ti_usb_3410_5052: Use struct_size()
 helper in ti_write_byte()
Message-ID: <20220120213131.GA32119@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version,
in order to avoid any potential type mistakes or integer overflows that,
in the worst scenario, could lead to heap overflows.

Also, address the following sparse warnings:
drivers/usb/serial/ti_usb_3410_5052.c:1521:16: warning: using sizeof on a flexible structure

Link: https://github.com/KSPP/linux/issues/174
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/usb/serial/ti_usb_3410_5052.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/ti_usb_3410_5052.c b/drivers/usb/serial/ti_usb_3410_5052.c
index 18c0bd853392..03f98e61626f 100644
--- a/drivers/usb/serial/ti_usb_3410_5052.c
+++ b/drivers/usb/serial/ti_usb_3410_5052.c
@@ -1512,13 +1512,13 @@ static int ti_write_byte(struct usb_serial_port *port,
 			 u8 mask, u8 byte)
 {
 	int status;
-	unsigned int size;
+	size_t size;
 	struct ti_write_data_bytes *data;
 
 	dev_dbg(&port->dev, "%s - addr 0x%08lX, mask 0x%02X, byte 0x%02X\n", __func__,
 		addr, mask, byte);
 
-	size = sizeof(struct ti_write_data_bytes) + 2;
+	size = struct_size(data, bData, 2);
 	data = kmalloc(size, GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
-- 
2.27.0

