Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F220C4E9F83
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 21:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245475AbiC1TJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 15:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245471AbiC1TJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 15:09:26 -0400
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110BB6663F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 12:07:44 -0700 (PDT)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id YuiNnPo90uvBOYuiNnOEXl; Mon, 28 Mar 2022 21:07:43 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 28 Mar 2022 21:07:43 +0200
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-ia64@vger.kernel.org
Subject: [PATCH 2/2] ia64: topology: Slightly simplify code
Date:   Mon, 28 Mar 2022 21:07:42 +0200
Message-Id: <bdb0d6ebe90f080e2c9749506a622f22299da412.1648494330.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <452b20c160a20754022407acefd2abb170f43d14.1648494330.git.christophe.jaillet@wanadoo.fr>
References: <452b20c160a20754022407acefd2abb170f43d14.1648494330.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_cache_sysfs_exit() already clears '&all_cpu_cache_info[cpu].kobj'. So
there is no need to do it twice.

Remove the redundant memset() and slightly simplify code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is provided as-is and is not even compile tested. I don't have the
cross-building toolchain for that.
---
 arch/ia64/kernel/topology.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/ia64/kernel/topology.c b/arch/ia64/kernel/topology.c
index 6adb84f05cbb..df58df614873 100644
--- a/arch/ia64/kernel/topology.c
+++ b/arch/ia64/kernel/topology.c
@@ -387,12 +387,8 @@ static int cache_remove_dev(unsigned int cpu)
 	for (i = 0; i < all_cpu_cache_info[cpu].num_cache_leaves; i++)
 		kobject_put(&(LEAF_KOBJECT_PTR(cpu,i)->kobj));
 
-	if (all_cpu_cache_info[cpu].kobj.parent) {
+	if (all_cpu_cache_info[cpu].kobj.parent)
 		kobject_put(&all_cpu_cache_info[cpu].kobj);
-		memset(&all_cpu_cache_info[cpu].kobj,
-			0,
-			sizeof(struct kobject));
-	}
 
 	cpu_cache_sysfs_exit(cpu);
 
-- 
2.32.0

