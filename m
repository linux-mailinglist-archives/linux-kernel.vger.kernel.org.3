Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55664A76B0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346175AbiBBRT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:19:57 -0500
Received: from mta-11-4.privateemail.com ([198.54.127.104]:45250 "EHLO
        MTA-11-4.privateemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiBBRT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:19:56 -0500
Received: from mta-11.privateemail.com (localhost [127.0.0.1])
        by mta-11.privateemail.com (Postfix) with ESMTP id CAA4C18000AA;
        Wed,  2 Feb 2022 12:19:55 -0500 (EST)
Received: from localhost.localdomain (unknown [10.20.151.154])
        by mta-11.privateemail.com (Postfix) with ESMTPA id 108D618000AE;
        Wed,  2 Feb 2022 12:19:52 -0500 (EST)
From:   Jordy Zomer <jordy@pwning.systems>
To:     linux-kernel@vger.kernel.org
Cc:     Jordy Zomer <jordy@pwning.systems>,
        Oded Gabbay <ogabbay@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ofir Bitton <obitton@habana.ai>,
        Dani Liberman <dliberman@habana.ai>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Sagiv Ozeri <sozeri@habana.ai>,
        Yuri Nudelman <ynudelman@habana.ai>,
        farah kassabri <fkassabri@habana.ai>,
        Koby Elbaz <kelbaz@habana.ai>
Subject: [PATCHv2] habanalabs: fix potential spectre v1 gadgets
Date:   Wed,  2 Feb 2022 18:19:24 +0100
Message-Id: <20220202171931.3525220-1-jordy@pwning.systems>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <CAFCwf12QygXk=8WbH9qDhyyqKY6ZGVCUSJM93viQ0armc8dgfg@mail.gmail.com>
References: <CAFCwf12QygXk=8WbH9qDhyyqKY6ZGVCUSJM93viQ0armc8dgfg@mail.gmail.com>
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

Thanks for noticing Oded, made the changes.

Signed-off-by: Jordy Zomer <jordy@pwning.systems>

---
Changes v1 -> v2: Added the correct offsets
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
+		nr = array_index_nospec(nr, HL_COMMAND_END);
 		ioctl = &hl_ioctls[nr];
 	} else {
 		dev_err(hdev->dev, "invalid ioctl: pid=%d, nr=0x%02x\n",
@@ -872,6 +874,7 @@ long hl_ioctl_control(struct file *filep, unsigned int cmd, unsigned long arg)
 	}
 
 	if (nr == _IOC_NR(HL_IOCTL_INFO)) {
+		nr = array_index_nospec(nr, _IOC_NR(HL_IOCTL_INFO)+1);
 		ioctl = &hl_ioctls_control[nr];
 	} else {
 		dev_err(hdev->dev_ctrl, "invalid ioctl: pid=%d, nr=0x%02x\n",
-- 
2.27.0

