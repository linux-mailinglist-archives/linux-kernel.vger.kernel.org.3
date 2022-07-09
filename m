Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64C956C5D3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 03:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiGIBxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 21:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiGIBxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 21:53:03 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AA07358F;
        Fri,  8 Jul 2022 18:53:02 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LftS91yVWzFq06;
        Sat,  9 Jul 2022 09:52:09 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 9 Jul 2022 09:53:00 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 9 Jul 2022 09:52:59 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <pc@us.ibm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [RFC v3 05/17] tools lib: Add list_last_entry_or_null
Date:   Sat, 9 Jul 2022 09:50:21 +0800
Message-ID: <20220709015033.38326-6-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20220709015033.38326-1-yangjihong1@huawei.com>
References: <20220709015033.38326-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add list_last_entry_or_null to get the last element from a list,
returns NULL if the list is empty.

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/include/linux/list.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/include/linux/list.h b/tools/include/linux/list.h
index b2fc48d5478c..a4dfb6a7cc6a 100644
--- a/tools/include/linux/list.h
+++ b/tools/include/linux/list.h
@@ -384,6 +384,17 @@ static inline void list_splice_tail_init(struct list_head *list,
 #define list_first_entry_or_null(ptr, type, member) \
 	(!list_empty(ptr) ? list_first_entry(ptr, type, member) : NULL)
 
+/**
+ * list_last_entry_or_null - get the last element from a list
+ * @ptr:       the list head to take the element from.
+ * @type:      the type of the struct this is embedded in.
+ * @member:    the name of the list_head within the struct.
+ *
+ * Note that if the list is empty, it returns NULL.
+ */
+#define list_last_entry_or_null(ptr, type, member) \
+	(!list_empty(ptr) ? list_last_entry(ptr, type, member) : NULL)
+
 /**
  * list_next_entry - get the next element in list
  * @pos:	the type * to cursor
-- 
2.30.GIT

