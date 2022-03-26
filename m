Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA204E7E7C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 02:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiCZBzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 21:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiCZBzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 21:55:16 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB5B972C2;
        Fri, 25 Mar 2022 18:53:41 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KQMPs3W3KzCrDl;
        Sat, 26 Mar 2022 09:51:29 +0800 (CST)
Received: from localhost.localdomain (10.175.103.91) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 26 Mar 2022 09:53:38 +0800
From:   Wei Li <liwei391@huawei.com>
To:     Peter Kaestle <peter@piie.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
CC:     <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rui.xiang@huawei.com>
Subject: [PATCH] platform/x86: acerhdf: Cleanup str_starts_with()
Date:   Sat, 26 Mar 2022 10:02:49 +0800
Message-ID: <20220326020249.3266561-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since there is already a generic function strstarts() that check if a
string starts with a given prefix, cleanup str_starts_with().

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 drivers/platform/x86/acerhdf.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 6b8b3ab8db48..3c589437b41e 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -584,21 +584,6 @@ static struct platform_driver acerhdf_driver = {
 	.remove = acerhdf_remove,
 };
 
-/* checks if str begins with start */
-static int str_starts_with(const char *str, const char *start)
-{
-	unsigned long str_len = 0, start_len = 0;
-
-	str_len = strlen(str);
-	start_len = strlen(start);
-
-	if (str_len >= start_len &&
-			!strncmp(str, start, start_len))
-		return 1;
-
-	return 0;
-}
-
 /* check hardware */
 static int __init acerhdf_check_hardware(void)
 {
@@ -651,9 +636,9 @@ static int __init acerhdf_check_hardware(void)
 		 * check if actual hardware BIOS vendor, product and version
 		 * IDs start with the strings of BIOS table entry
 		 */
-		if (str_starts_with(vendor, bt->vendor) &&
-				str_starts_with(product, bt->product) &&
-				str_starts_with(version, bt->version)) {
+		if (strstarts(vendor, bt->vendor) &&
+				strstarts(product, bt->product) &&
+				strstarts(version, bt->version)) {
 			found = 1;
 			break;
 		}
-- 
2.25.1

