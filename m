Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E2B4E2085
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 07:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344557AbiCUGPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 02:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238570AbiCUGPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 02:15:15 -0400
Received: from mail.meizu.com (unknown [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DEAE096
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 23:13:50 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 21 Mar
 2022 14:13:51 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Mon, 21 Mar
 2022 14:13:48 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <dsterba@suse.com>, <elder@linaro.org>,
        <jcmvbkbc@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH v2] tty: synclink_cs: Use bitwise instead of arithmetic operator for flags
Date:   Mon, 21 Mar 2022 14:13:47 +0800
Message-ID: <1647843227-32098-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-125.meizu.com (172.16.1.125) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This silences the following coccinelle warning:
drivers/s390/char/tape_34xx.c:360:38-39: WARNING: sum of probable bitmasks, consider |

we will try to make code cleaner

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/char/pcmcia/synclink_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index 78baba5..e6f2186 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -922,7 +922,7 @@ static void rx_ready_async(MGSLPC_INFO *info, int tcd)
 		// BIT7:parity error
 		// BIT6:framing error
 
-		if (status & (BIT7 + BIT6)) {
+		if (status & (BIT7 | BIT6)) {
 			if (status & BIT7)
 				icount->parity++;
 			else
-- 
2.7.4

