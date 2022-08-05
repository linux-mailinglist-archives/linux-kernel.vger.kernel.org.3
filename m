Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EFF58AE20
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 18:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241129AbiHEQ2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 12:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241058AbiHEQ2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 12:28:12 -0400
Received: from mx01.ayax.eu (mx01.ayax.eu [188.137.98.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A69CE2D
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 09:28:11 -0700 (PDT)
Received: from [192.168.192.146] (port=49798 helo=nx64de-df6d00)
        by mx01.ayax.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gszymaszek@short.pl>)
        id 1oK0B0-0007pk-My; Fri, 05 Aug 2022 18:27:58 +0200
Date:   Fri, 5 Aug 2022 18:27:53 +0200
From:   Grzegorz Szymaszek <gszymaszek@short.pl>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Grzegorz Szymaszek <gszymaszek@short.pl>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v2 2/4] staging: r8188eu: use KBUILD_MODNAME instead of a
 string constant
Message-ID: <0325540ba8be0a3dc4083d22e484a8a31fb2a892.1659715931.git.gszymaszek@short.pl>
Mail-Followup-To: Grzegorz Szymaszek <gszymaszek@short.pl>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <cover.1659715931.git.gszymaszek@short.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1659715931.git.gszymaszek@short.pl>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field .usbdrv.name of the struct rtw_usb_drv hardcoded the module
(driver) name as a constant string. Replace the string with the
KBUILD_MODNAME macro.

Link: https://lore.kernel.org/lkml/Yuy7QSh%2FclQ5Ki09@kroah.com/
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Grzegorz Szymaszek <gszymaszek@short.pl>
---
V1 -> V2: Split v1-0002 into v2-0002 and v2-0003. Replace the constant
          string with KBUILD_MODNAME instead of DRV_NAME

 drivers/staging/r8188eu/os_dep/usb_intf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 68869c5daeff..b845f5ec5489 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -54,7 +54,7 @@ struct rtw_usb_drv {
 };
 
 static struct rtw_usb_drv rtl8188e_usb_drv = {
-	.usbdrv.name = "r8188eu",
+	.usbdrv.name = KBUILD_MODNAME,
 	.usbdrv.probe = rtw_drv_init,
 	.usbdrv.disconnect = rtw_dev_remove,
 	.usbdrv.id_table = rtw_usb_id_tbl,
-- 
2.35.1
