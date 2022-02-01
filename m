Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2A84A624E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241434AbiBARY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:24:58 -0500
Received: from mta-12-4.privateemail.com ([198.54.127.107]:33003 "EHLO
        MTA-12-4.privateemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiBARY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:24:58 -0500
Received: from mta-12.privateemail.com (localhost [127.0.0.1])
        by mta-12.privateemail.com (Postfix) with ESMTP id 5C20F18000A1;
        Tue,  1 Feb 2022 12:24:57 -0500 (EST)
Received: from localhost.localdomain (unknown [10.20.151.177])
        by mta-12.privateemail.com (Postfix) with ESMTPA id 9F69918000A5;
        Tue,  1 Feb 2022 12:24:54 -0500 (EST)
From:   Jordy Zomer <jordy@pwning.systems>
To:     linux-kernel@vger.kernel.org
Cc:     Jordy Zomer <jordy@pwning.systems>,
        Oded Gabbay <ogabbay@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ofir Bitton <obitton@habana.ai>,
        Dani Liberman <dliberman@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>, Koby Elbaz <kelbaz@habana.ai>,
        farah kassabri <fkassabri@habana.ai>,
        Sagiv Ozeri <sozeri@habana.ai>,
        Yuri Nudelman <ynudelman@habana.ai>
Subject: [PATCH] habanalabs: fix potential spectre v1 gadgets
Date:   Tue,  1 Feb 2022 18:24:21 +0100
Message-Id: <20220201172424.3509544-1-jordy@pwning.systems>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It appears like nr could be a Spectre v1 gadget as it's supplied by a
user and used as an array index. Prevent the contents
of kernel memory from being leaked to userspace via speculative
execution by using array_index_nospec.

Signed-off-by: Jordy Zomer <jordy@pwning.systems>
---
 drivers/misc/habanalabs/common/habanalabs_ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 3ba3a8ffda3e..c1cdf712a10d 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -14,6 +14,7 @@
 #include <linux/fs.h>
 #include <linux/uaccess.h>
 #include <linux/slab.h>
+#include <linux/nospec.h>
 
 static u32 hl_debug_struct_size[HL_DEBUG_OP_TIMESTAMP + 1] = {
 	[HL_DEBUG_OP_ETR] = sizeof(struct hl_debug_params_etr),
@@ -849,6 +850,7 @@ long hl_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	}
 
 	if ((nr >= HL_COMMAND_START) && (nr < HL_COMMAND_END)) {
+		nr = array_index_nospec(nr, HL_COMMAND_END-1);
 		ioctl = &hl_ioctls[nr];
 	} else {
 		dev_err(hdev->dev, "invalid ioctl: pid=%d, nr=0x%02x\n",
@@ -872,6 +874,7 @@ long hl_ioctl_control(struct file *filep, unsigned int cmd, unsigned long arg)
 	}
 
 	if (nr == _IOC_NR(HL_IOCTL_INFO)) {
+		nr = array_index_nospec(nr, _IOC_NR(HL_IOCTL_INFO));
 		ioctl = &hl_ioctls_control[nr];
 	} else {
 		dev_err(hdev->dev_ctrl, "invalid ioctl: pid=%d, nr=0x%02x\n",
-- 
2.27.0

