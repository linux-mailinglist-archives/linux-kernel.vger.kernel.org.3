Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEABF4A3025
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 15:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbiA2O7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 09:59:08 -0500
Received: from h2.fbrelay.privateemail.com ([131.153.2.43]:56371 "EHLO
        h2.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231262AbiA2O7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 09:59:06 -0500
Received: from MTA-15-3.privateemail.com (MTA-15-1.privateemail.com [198.54.118.208])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by h1.fbrelay.privateemail.com (Postfix) with ESMTPS id 22B601804EF8
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 09:59:06 -0500 (EST)
Received: from mta-15.privateemail.com (localhost [127.0.0.1])
        by mta-15.privateemail.com (Postfix) with ESMTP id 0C82F18000A1;
        Sat, 29 Jan 2022 09:59:05 -0500 (EST)
Received: from localhost.localdomain (unknown [10.20.151.152])
        by mta-15.privateemail.com (Postfix) with ESMTPA id A85C118000BC;
        Sat, 29 Jan 2022 09:59:03 -0500 (EST)
From:   Jordy Zomer <jordy@pwning.systems>
To:     linux-kernel@vger.kernel.org
Cc:     Jordy Zomer <jordy@pwning.systems>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Subject: [PATCH v2] dm ioct: prevent potential specter v1 gadget
Date:   Sat, 29 Jan 2022 15:58:39 +0100
Message-Id: <20220129145839.3461330-1-jordy@pwning.systems>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220129143722.3460829-1-jordy@pwning.systems>
References: <20220129143722.3460829-1-jordy@pwning.systems>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It appears like cmd could be a Spectre v1 gadget as it's supplied by a
user and used as an array index. Prevent the contents
of kernel memory from being leaked to userspace via speculative
execution by using array_index_nospec.

Forgot to add the nospec include, that's the reason for the v2 :)

Signed-off-by: Jordy Zomer <jordy@pwning.systems>
---
 drivers/md/dm-ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 21fe8652b095..901abd6dea41 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -18,6 +18,7 @@
 #include <linux/dm-ioctl.h>
 #include <linux/hdreg.h>
 #include <linux/compat.h>
+#include <linux/nospec.h>
 
 #include <linux/uaccess.h>
 #include <linux/ima.h>
@@ -1788,6 +1789,7 @@ static ioctl_fn lookup_ioctl(unsigned int cmd, int *ioctl_flags)
 	if (unlikely(cmd >= ARRAY_SIZE(_ioctls)))
 		return NULL;
 
+	cmd = array_index_nospec(cmd, ARRAY_SIZE(_ioctls));
 	*ioctl_flags = _ioctls[cmd].flags;
 	return _ioctls[cmd].fn;
 }
-- 
2.27.0

