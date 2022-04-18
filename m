Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BD1504EDB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 12:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237707AbiDRK3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 06:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbiDRK3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 06:29:09 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0871413EBC;
        Mon, 18 Apr 2022 03:26:30 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 18 Apr
 2022 18:26:29 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Mon, 18 Apr
 2022 18:26:27 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Steve French <sfrench@samba.org>
CC:     Haowen Bai <baihaowen@meizu.com>, <linux-cifs@vger.kernel.org>,
        <samba-technical@lists.samba.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] cifs: Use kzalloc instead of kmalloc/memset
Date:   Mon, 18 Apr 2022 18:26:26 +0800
Message-ID: <1650277586-31431-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kzalloc rather than duplicating its implementation, which
makes code simple and easy to understand.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 fs/cifs/transport.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index d9d1c353bafc..c667e6ddfe2f 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -464,13 +464,12 @@ smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 		return -EIO;
 	}
 
-	tr_hdr = kmalloc(sizeof(*tr_hdr), GFP_NOFS);
+	tr_hdr = kzalloc(sizeof(*tr_hdr), GFP_NOFS);
 	if (!tr_hdr)
 		return -ENOMEM;
 
 	memset(&cur_rqst[0], 0, sizeof(cur_rqst));
 	memset(&iov, 0, sizeof(iov));
-	memset(tr_hdr, 0, sizeof(*tr_hdr));
 
 	iov.iov_base = tr_hdr;
 	iov.iov_len = sizeof(*tr_hdr);
-- 
2.7.4

