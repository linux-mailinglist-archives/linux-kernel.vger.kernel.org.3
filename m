Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FABB47190B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 08:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhLLHS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 02:18:59 -0500
Received: from smtpbg587.qq.com ([113.96.223.105]:33635 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229450AbhLLHS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 02:18:58 -0500
X-QQ-mid: bizesmtp43t1639293524tv5aum6o
Received: from localhost.localdomain (unknown [182.132.179.213])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sun, 12 Dec 2021 15:18:43 +0800 (CST)
X-QQ-SSF: 01000000002000D0I000B00A0000000
X-QQ-FEAT: 1vYwxPNStGnyvBaKtccJIyIA7HDYdPnUz/WvUZSMcG5FKGQdsA2DBetccSGSr
        dXrA12NnKBsBmVX4ymanOPfGey7Y4rJ4f+te8K4rHyRc69lIODZ7ZctkqwD2B6KcdnjZ0zG
        vQUWNbyjPutRURE6OY50DixKHBtr8TMnSkuHpst9K9/MH5vz0cR46OGEsb/y5AsHt3GOTWf
        vaFdaLVUgNckiJvWvfVEO/rte2mpoqvUWjeHzIcNnClE0wprUWWT3Sb8kBRqsW7uC2N3F+T
        tDfyePh8WyZLXD82uDXHYO03nT3je+L6C+ybMujRiUPFx9oJg8VwF/aocL7jfw6kEZS/ZXy
        3TPT+mLMwDfHrlh502LAiEBdsR0IKIVg76143Yu6Omqp4aHAgA=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     gregkh@linuxfoundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] applicom: unneed to initialise statics to 0
Date:   Sun, 12 Dec 2021 15:18:38 +0800
Message-Id: <20211212071838.304307-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static variables do not need to be initialised to 0, because compilers
will initialise all uninitialised statics to 0. Thus, remove the
unneeded initializations.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/char/applicom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/applicom.c b/drivers/char/applicom.c
index deb85a334c93..36203d3fa6ea 100644
--- a/drivers/char/applicom.c
+++ b/drivers/char/applicom.c
@@ -89,8 +89,8 @@ static struct applicom_board {
 	spinlock_t mutex;
 } apbs[MAX_BOARD];
 
-static unsigned int irq = 0;	/* interrupt number IRQ       */
-static unsigned long mem = 0;	/* physical segment of board  */
+static unsigned int irq;	/* interrupt number IRQ       */
+static unsigned long mem;	/* physical segment of board  */
 
 module_param_hw(irq, uint, irq, 0);
 MODULE_PARM_DESC(irq, "IRQ of the Applicom board");
-- 
2.34.1

