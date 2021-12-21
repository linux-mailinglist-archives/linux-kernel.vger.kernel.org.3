Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E84547B855
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 03:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhLUCUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 21:20:41 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:60506 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230060AbhLUCUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 21:20:40 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V.HldxN_1640053238;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V.HldxN_1640053238)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Dec 2021 10:20:38 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] usb: early: Fix an error code in xdbc_init()
Date:   Tue, 21 Dec 2021 10:20:36 +0800
Message-Id: <20211221022036.80706-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When xdbc_trace("hardware not used anymore\n") is performed,
ret should be assigned -ENODEV to indicate this.

Clean up smatch warning:
drivers/usb/early/xhci-dbc.c:972 xdbc_init() warn: missing error code
'ret'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/usb/early/xhci-dbc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/early/xhci-dbc.c b/drivers/usb/early/xhci-dbc.c
index 4502108069cd..fcb05a8948fa 100644
--- a/drivers/usb/early/xhci-dbc.c
+++ b/drivers/usb/early/xhci-dbc.c
@@ -969,6 +969,7 @@ static int __init xdbc_init(void)
 	if (early_xdbc_console.index == -1 ||
 	    (early_xdbc_console.flags & CON_BOOT)) {
 		xdbc_trace("hardware not used anymore\n");
+		ret = -ENODEV;
 		goto free_and_quit;
 	}
 
-- 
2.20.1.7.g153144c

