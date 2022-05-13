Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFB75259AA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 04:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376534AbiEMCVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 22:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376515AbiEMCVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 22:21:41 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA557356D
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 19:21:40 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KzslD33NRzGpXd;
        Fri, 13 May 2022 10:18:48 +0800 (CST)
Received: from dggpemm500015.china.huawei.com (7.185.36.181) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 10:21:38 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500015.china.huawei.com
 (7.185.36.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 13 May
 2022 10:21:37 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <bobo.shaobowang@huawei.com>, <cj.chengjian@huawei.com>,
        <linux-kernel@vger.kernel.org>, <liwei391@huawei.com>,
        <mhiramat@kernel.org>, <rostedt@goodmis.org>, <acme@redhat.com>,
        <yuehaibing@huawei.com>
Subject: [PATCH 2/2] libtraceevent: fix free NULL pointer in parse_arg_add()
Date:   Fri, 13 May 2022 10:33:08 +0800
Message-ID: <20220513023308.2400381-3-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513023308.2400381-1-bobo.shaobowang@huawei.com>
References: <20220513023308.2400381-1-bobo.shaobowang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500015.china.huawei.com (7.185.36.181)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Should not call free if parg->format is NULL.

Fixes: e7a90882b05b ("tools lib traceevent: Optimize pretty_print() function")
Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 tools/lib/traceevent/event-parse.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 69e4d5229362..b1a07db54457 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -5461,9 +5461,11 @@ static int parse_arg_add(struct tep_print_parse **parse, char *format,
 	return 0;
 error:
 	if (parg) {
-		free(parg->format);
+		if (parg->format)
+			free(parg->format);
 		free(parg);
 	}
+
 	return -1;
 }
 
-- 
2.25.1

