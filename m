Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50C24E96DA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239356AbiC1MmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240672AbiC1MmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:42:24 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D045B3F9;
        Mon, 28 Mar 2022 05:40:38 -0700 (PDT)
X-UUID: 7c04888e22d946a2ab98aa302e160b34-20220328
X-UUID: 7c04888e22d946a2ab98aa302e160b34-20220328
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <xiaobing.shi@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 589206584; Mon, 28 Mar 2022 20:40:31 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 28 Mar 2022 20:40:30 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 28 Mar
 2022 20:40:30 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 28 Mar 2022 20:40:29 +0800
From:   Xiaobing shi <xiaobing.shi@mediatek.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Xiaobing shi <xiaobing.shi@mediatek.com>
Subject: [PATCH] remoteproc: avoid array index out of bounds in debugfs file
Date:   Mon, 28 Mar 2022 20:34:13 +0800
Message-ID: <20220328123413.18169-1-xiaobing.shi@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a negative offset of an on-stack array that causes an out of
bounds issue when someone called with a zero 'count' argument to
syswrite().

	buf[count - 1]

We should add an extra check in rproc_coredump_write() to prevent the
access.

Signed-off-by: Xiaobing shi <xiaobing.shi@mediatek.com>
---
 drivers/remoteproc/remoteproc_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
index b5a1e3b697d9..581930483ef8 100644
--- a/drivers/remoteproc/remoteproc_debugfs.c
+++ b/drivers/remoteproc/remoteproc_debugfs.c
@@ -76,7 +76,7 @@ static ssize_t rproc_coredump_write(struct file *filp,
 	int ret, err = 0;
 	char buf[20];
 
-	if (count > sizeof(buf))
+	if (count < 1 || count > sizeof(buf))
 		return -EINVAL;
 
 	ret = copy_from_user(buf, user_buf, count);
-- 
2.18.0

