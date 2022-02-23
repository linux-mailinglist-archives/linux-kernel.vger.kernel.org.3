Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF38B4C0E32
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 09:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238938AbiBWI0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 03:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238936AbiBWIZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 03:25:58 -0500
Received: from spam.unicloud.com (mx.gosinoic.com [220.194.70.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3CB66F9D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 00:25:31 -0800 (PST)
Received: from eage.unicloud.com ([220.194.70.35])
        by spam.unicloud.com with ESMTP id 21N8N1w0031342;
        Wed, 23 Feb 2022 16:23:01 +0800 (GMT-8)
        (envelope-from luofei@unicloud.com)
Received: from localhost.localdomain (10.10.1.7) by zgys-ex-mb09.Unicloud.com
 (10.10.0.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2375.17; Wed, 23
 Feb 2022 16:23:01 +0800
From:   luofei <luofei@unicloud.com>
To:     <naoya.horiguchi@nec.com>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        luofei <luofei@unicloud.com>
Subject: [PATCH v5 2/2] mm/hwpoison: Add in-use hugepage hwpoison filter judgement
Date:   Wed, 23 Feb 2022 03:22:54 -0500
Message-ID: <20220223082254.2769757-1-luofei@unicloud.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.10.1.7]
X-ClientProxiedBy: zgys-ex-mb11.Unicloud.com (10.10.0.28) To
 zgys-ex-mb09.Unicloud.com (10.10.0.24)
X-DNSRBL: 
X-MAIL: spam.unicloud.com 21N8N1w0031342
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After successfully obtaining the reference count of the huge
page, it is still necessary to call hwpoison_filter() to make a
filter judgement, otherwise the filter hugepage will be unmaped
and the related process may be killed.

Signed-off-by: luofei <luofei@unicloud.com>
---
 mm/memory-failure.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 7e16d31df0f3..bad659092176 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1547,6 +1547,14 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 	lock_page(head);
 	page_flags = head->flags;
 
+	if (hwpoison_filter(p)) {
+		if (TestClearPageHWPoison(head))
+			num_poisoned_pages_dec();
+		put_page(p);
+		res = -EOPNOTSUPP;
+		goto out;
+	}
+
 	/*
 	 * TODO: hwpoison for pud-sized hugetlb doesn't work right now, so
 	 * simply disable it. In order to make it work properly, we need
-- 
2.27.0

