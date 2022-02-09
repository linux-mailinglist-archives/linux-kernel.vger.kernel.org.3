Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39254AF0F8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbiBIMIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbiBIMEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:04:52 -0500
X-Greylist: delayed 1121 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 03:32:37 PST
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA3DDF28A7F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 03:32:37 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Jtxxt2gk5zdZWL;
        Wed,  9 Feb 2022 19:10:42 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 9 Feb
 2022 19:13:53 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <rafael@kernel.org>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <linux-pm@vger.kernel.org>
CC:     <tytso@mit.edu>, <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next] PM:hibernate:fix miss close 'hib_resume_bdev' in load_image_and_restore
Date:   Wed, 9 Feb 2022 19:29:51 +0800
Message-ID: <20220209112951.3073370-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As 'swsusp_check' open 'hib_resume_bdev', if call 'create_basic_memory_bitmaps'
failed, we need to close 'hib_resume_bdev' in 'load_image_and_restore' function.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 kernel/power/hibernate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index e6af502c2fd7..49d1df0218cb 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -689,8 +689,10 @@ static int load_image_and_restore(void)
 
 	lock_device_hotplug();
 	error = create_basic_memory_bitmaps();
-	if (error)
+	if (error) {
+		swsusp_close(FMODE_READ | FMODE_EXCL);
 		goto Unlock;
+	}
 
 	error = swsusp_read(&flags);
 	swsusp_close(FMODE_READ | FMODE_EXCL);
-- 
2.31.1

