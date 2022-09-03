Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9732C5ABE5F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 12:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiICKBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 06:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiICKBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 06:01:35 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0365755A;
        Sat,  3 Sep 2022 03:01:33 -0700 (PDT)
Received: from localhost.localdomain ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 283A15mQ005669-283A15mT005669
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 3 Sep 2022 18:01:11 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        Hangyu Hua <hbh25y@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: misc: uss720: fix uninitialized variable rlen
Date:   Sat,  3 Sep 2022 18:00:01 +0800
Message-Id: <20220903100004.2874741-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dongliang Mu <mudongliangabcd@gmail.com>

Smatch reports the following error: uninitialized symbol 'rlen'

drivers/usb/misc/uss720.c:514 parport_uss720_epp_write_data() error
drivers/usb/misc/uss720.c:575 parport_uss720_ecp_write_data() error
drivers/usb/misc/uss720.c:593 parport_uss720_ecp_read_data() error
drivers/usb/misc/uss720.c:626 parport_uss720_write_compat() error

The root cause is, the failure of usb_bulk_msg leads to the
uninitialized variable rlen in printk function.

Fix this by initializing rlen with zero.

Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/usb/misc/uss720.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/misc/uss720.c b/drivers/usb/misc/uss720.c
index 0be8efcda15d..b00d92db5dfd 100644
--- a/drivers/usb/misc/uss720.c
+++ b/drivers/usb/misc/uss720.c
@@ -502,7 +502,7 @@ static size_t parport_uss720_epp_write_data(struct parport *pp, const void *buf,
 #else
 	struct parport_uss720_private *priv = pp->private_data;
 	struct usb_device *usbdev = priv->usbdev;
-	int rlen;
+	int rlen = 0;
 	int i;
 
 	if (!usbdev)
@@ -563,7 +563,7 @@ static size_t parport_uss720_ecp_write_data(struct parport *pp, const void *buff
 {
 	struct parport_uss720_private *priv = pp->private_data;
 	struct usb_device *usbdev = priv->usbdev;
-	int rlen;
+	int rlen = 0;
 	int i;
 
 	if (!usbdev)
@@ -581,7 +581,7 @@ static size_t parport_uss720_ecp_read_data(struct parport *pp, void *buffer, siz
 {
 	struct parport_uss720_private *priv = pp->private_data;
 	struct usb_device *usbdev = priv->usbdev;
-	int rlen;
+	int rlen = 0;
 	int i;
 
 	if (!usbdev)
@@ -614,7 +614,7 @@ static size_t parport_uss720_write_compat(struct parport *pp, const void *buffer
 {
 	struct parport_uss720_private *priv = pp->private_data;
 	struct usb_device *usbdev = priv->usbdev;
-	int rlen;
+	int rlen = 0;
 	int i;
 
 	if (!usbdev)
-- 
2.35.1

