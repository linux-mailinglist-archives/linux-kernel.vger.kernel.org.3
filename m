Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251704A85B2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350961AbiBCODL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:03:11 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57027 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350969AbiBCODK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:03:10 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1nFcZ8-0002cQ-AM; Thu, 03 Feb 2022 14:54:26 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1nFcZ1-009S1X-Nr; Thu, 03 Feb 2022 14:54:19 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v1] counter: fix NULL pointer dereference on counter_comp_u8_store()
Date:   Thu,  3 Feb 2022 14:54:18 +0100
Message-Id: <20220203135418.2252624-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current kernel will report NULL pointer dereference with following
back trace:
  interrupt_cnt_enable_write from counter_comp_u8_store+0xc0/0xf4
  counter_comp_u8_store from dev_attr_store+0x24/0x30
  dev_attr_store from sysfs_kf_write+0x48/0x54
  sysfs_kf_write from kernfs_fop_write_iter+0x128/0x1c8
  kernfs_fop_write_iter from vfs_write+0x124/0x1b4
  vfs_write from ksys_write+0x88/0xe0
  ksys_write from sys_write+0x18/0x1c
  sys_write from ret_fast_syscall+0x0/0x1c

Add missing dev_set_drvdata() to fix it.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/counter/counter-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
index 7e0957eea094..1de16d5e9fbc 100644
--- a/drivers/counter/counter-core.c
+++ b/drivers/counter/counter-core.c
@@ -98,6 +98,8 @@ struct counter_device *counter_alloc(size_t sizeof_priv)
 	counter = &ch->counter;
 	dev = &counter->dev;
 
+	dev_set_drvdata(dev, counter);
+
 	/* Acquire unique ID */
 	err = ida_alloc(&counter_ida, GFP_KERNEL);
 	if (err < 0)
-- 
2.30.2

