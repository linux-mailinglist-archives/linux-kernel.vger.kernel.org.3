Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAE5471F9C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 04:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhLMDeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 22:34:31 -0500
Received: from mailgw.kylinos.cn ([123.150.8.42]:30185 "EHLO nksmu.kylinos.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229483AbhLMDeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 22:34:31 -0500
X-UUID: e77c67eaf0714a71a228f6e6dd43b641-20211213
X-UUID: e77c67eaf0714a71a228f6e6dd43b641-20211213
X-User: zhangyue1@kylinos.cn
Received: from localhost.localdomain [(172.17.127.2)] by nksmu.kylinos.cn
        (envelope-from <zhangyue1@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1495543062; Mon, 13 Dec 2021 11:42:38 +0800
From:   zhangyue <zhangyue1@kylinos.cn>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: fix array may be out of bound
Date:   Mon, 13 Dec 2021 11:34:19 +0800
Message-Id: <20211213033419.70458-1-zhangyue1@kylinos.cn>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this function, the param 'idx' may be
equal to 'DW_WDT_NUM_TOPS'.
At this time, the array 'dw_wdt->timeouts'
may be out of bound

Signed-off-by: zhangyue <zhangyue1@kylinos.cn>
---
 drivers/watchdog/dw_wdt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index cd578843277e..15fb1895c085 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -155,6 +155,9 @@ static unsigned int dw_wdt_get_min_timeout(struct dw_wdt *dw_wdt)
 			break;
 	}
 
+	if (idx == DW_WDT_NUM_TOPS)
+		return 1;
+
 	return dw_wdt->timeouts[idx].sec;
 }
 
-- 
2.30.0

