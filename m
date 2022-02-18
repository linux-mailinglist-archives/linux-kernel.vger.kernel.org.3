Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6172A4BB033
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 04:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbiBRDWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 22:22:41 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiBRDWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 22:22:40 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB353BBDA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 19:22:24 -0800 (PST)
Received: from kwepemi100011.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K0H5Q3z23z9sjk;
        Fri, 18 Feb 2022 11:20:42 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 kwepemi100011.china.huawei.com (7.221.188.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Feb 2022 11:22:21 +0800
Received: from linux_suse_sp4_work.huawei.com (10.67.133.232) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Feb 2022 11:22:21 +0800
From:   Liao Hua <liaohua4@huawei.com>
To:     <david.oberhollenzer@sigma-star.at>, <richard@nod.at>,
        <yangds.fnst@cn.fujitsu.com>, <david@sigma-star.at>,
        <daniel.wagner@siemens.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <wangfangpeng1@huawei.com>, <liaohua4@huawei.com>
Subject: [PATCH mtd-utils] nor-utils: fix memory leak
Date:   Fri, 18 Feb 2022 11:22:19 +0800
Message-ID: <20220218032219.97114-1-liaohua4@huawei.com>
X-Mailer: git-send-email 2.12.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.133.232]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: liaohua <liaohua4@huawei.com>

This patch replace "free(rfd.sector_map)" with "free(rfd.header)"
to fix memory leak.

Signed-off-by: liaohua <liaohua4@huawei.com>
---
 nor-utils/rfddump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nor-utils/rfddump.c b/nor-utils/rfddump.c
index 01ab4c2..78ec443 100644
--- a/nor-utils/rfddump.c
+++ b/nor-utils/rfddump.c
@@ -256,7 +256,7 @@ int main(int argc, char *argv[])
 	if (!rfd.sector_map) {
 		perror(PROGRAM_NAME);
 		close(fd);
-		free(rfd.sector_map);
+		free(rfd.header);
 		return 2;
 	}
 
-- 
2.12.3

