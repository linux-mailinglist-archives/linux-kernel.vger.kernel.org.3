Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C98D536C69
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 12:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355816AbiE1KuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 06:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbiE1Kt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 06:49:59 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F415113D66
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 03:49:57 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L9JLF5Zd1z1JC5R;
        Sat, 28 May 2022 18:48:21 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 28 May 2022 18:49:56 +0800
Received: from huawei.com (10.175.112.125) by dggpemm500018.china.huawei.com
 (7.185.36.111) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 28 May
 2022 18:49:55 +0800
From:   Yue Zou <zouyue3@huawei.com>
To:     <sfr@canb.auug.org.au>, <akpm@linux-foundation.org>,
        <mhiramat@kernel.org>, <rostedt@goodmis.org>,
        <ahalaney@redhat.com>, <vbabka@suse.cz>, <Jason@zx2c4.com>,
        <mark-pk.tsai@mediatek.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] smp: Move stub from main.c into smp.h
Date:   Sat, 28 May 2022 11:11:22 +0000
Message-ID: <20220528111122.1888581-1-zouyue3@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500018.china.huawei.com (7.185.36.111)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the stubs in init/main.c for !CONFIG_SMP to smp.h
since these definitions for CONFIG_SMP are in smp.h already.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yue Zou <zouyue3@huawei.com>
---
 include/linux/smp.h | 4 ++++
 init/main.c         | 5 -----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index a80ab58ae3f1..bc42f6f8415a 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -183,6 +183,10 @@ static inline int get_boot_cpu_id(void)
 
 #else /* !SMP */
 
+static const unsigned int setup_max_cpus = NR_CPUS;
+static inline void setup_nr_cpu_ids(void) { }
+static inline void smp_prepare_cpus(unsigned int maxcpus) { }
+
 static inline void smp_send_stop(void) { }
 
 /*
diff --git a/init/main.c b/init/main.c
index 0f452ae3b20f..3c432b28c78f 100644
--- a/init/main.c
+++ b/init/main.c
@@ -602,11 +602,6 @@ static int __init rdinit_setup(char *str)
 }
 __setup("rdinit=", rdinit_setup);
 
-#ifndef CONFIG_SMP
-static const unsigned int setup_max_cpus = NR_CPUS;
-static inline void setup_nr_cpu_ids(void) { }
-static inline void smp_prepare_cpus(unsigned int maxcpus) { }
-#endif
 
 /*
  * We need to store the untouched command line for future reference.
-- 
2.25.1

