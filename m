Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846B554A833
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 06:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbiFNEgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 00:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiFNEgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 00:36:16 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D58A2E6BB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 21:36:15 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id a10so7455058pju.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 21:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ajU2JKBBSSrp0S5lhDPG058tqKeZBFJb0LEOJsnhgqE=;
        b=vJQo2n6BSwWuglebOG3yrGi72g3v8zO9xmkNzssq+aV4KOs8zg+NgNezh2HCdamdSE
         0CihdbGc9IufBkOSqbntOh/567FMMZB1TyT3e2MR9eTQS7VXIx32NAWb5cbo7uZk20/f
         pMvlYBxWICZ8ym1c/YAXjzv8VaNeBID+yrIeH17PQk1TzrPic81geaFlnGzL/EWjEF6t
         LgKXZx+P8PkXGsM+t8Ru3/wGr3ZaPgWV/hzapIK4Iw1X+S23fdiWeBAwf46xW7IXctxf
         kWqZFFWZL9+iE+TvcP/ULgxCryIG7h9UehP5aQI2VJarK8IN6LhhR2nFKa+jqAwFcDLh
         fY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ajU2JKBBSSrp0S5lhDPG058tqKeZBFJb0LEOJsnhgqE=;
        b=ENKOQlm+4REXNFRLX9hH6Ew/b22bprpZPD2ar2cW4rfCxXL10fn4KF2mCYyzTYab+9
         6msF4qgqmKtRbeRhkuBiwcyAYp8QtlMqAjPkGxaDi1fL7msuqKxpNA5zGVCQ0NuAVU4j
         0/dOJDlq5PtTXOM5Z9o18bIXtXJoTU8/Qip5htMyLy9D1azHJEY8ll9u7DTLUKru0zNh
         pLgMC/8LroSKF/4r5hn4cd88j8RqH5C40e5zCGIqJZ3NyO58iYbzBfknelY6MbYR6PXp
         9P8jfY5cMA7TUefOx9HjBGh9Q0DFfs4EV3kC3c6bhkogmArXKxWl8/XEC7FVFGJkAl5r
         sRrg==
X-Gm-Message-State: AJIora9O6qPUZyMQrVhCn+kbfkMmdsNPaAml2rZ0UCyqxlT4vFY+2jH3
        JkcgzMp9mWH3y+2AfjMqFK91QdaBGpnEy6lj
X-Google-Smtp-Source: AGRyM1vFA1HcMbNLf45HPEWAlxQMUPIqHnxVbUm2xPe6/RAnOg1R4/b7PXltR54zt+IuHgq5nmU2bQ==
X-Received: by 2002:a17:902:cf0c:b0:15b:63a4:9f47 with SMTP id i12-20020a170902cf0c00b0015b63a49f47mr2528770plg.1.1655181374892;
        Mon, 13 Jun 2022 21:36:14 -0700 (PDT)
Received: from always-T480.www.tendawifi.com ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id t16-20020a63b250000000b00401a7b4f137sm6469120pgo.41.2022.06.13.21.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 21:36:14 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
        linmiaohe@huawei.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v4 1/2] mm/memory-failure: introduce "hwpoisoned-pages" entry
Date:   Tue, 14 Jun 2022 12:38:29 +0800
Message-Id: <20220614043830.99607-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220614043830.99607-1-pizhenwei@bytedance.com>
References: <20220614043830.99607-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new debug entry to show the number of hwpoisoned pages. And
use module_get/module_put to manager this kernel module, don't allow
to remove this module unless hwpoisoned-pages is zero.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 Documentation/vm/hwpoison.rst |  4 ++++
 mm/hwpoison-inject.c          | 19 ++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/vm/hwpoison.rst b/Documentation/vm/hwpoison.rst
index c742de1769d1..c832a8b192d4 100644
--- a/Documentation/vm/hwpoison.rst
+++ b/Documentation/vm/hwpoison.rst
@@ -155,6 +155,10 @@ Testing
 	flag bits are defined in include/linux/kernel-page-flags.h and
 	documented in Documentation/admin-guide/mm/pagemap.rst
 
+  hwpoisoned-pages
+	The number of hwpoisoned pages. The hwpoison kernel module can not be
+	removed unless this count is zero.
+
 * Architecture specific MCE injector
 
   x86 has mce-inject, mce-test
diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
index 5c0cddd81505..9e522ecedeef 100644
--- a/mm/hwpoison-inject.c
+++ b/mm/hwpoison-inject.c
@@ -10,6 +10,7 @@
 #include "internal.h"
 
 static struct dentry *hwpoison_dir;
+static atomic_t hwpoisoned_pages;
 
 static int hwpoison_inject(void *data, u64 val)
 {
@@ -49,15 +50,28 @@ static int hwpoison_inject(void *data, u64 val)
 inject:
 	pr_info("Injecting memory failure at pfn %#lx\n", pfn);
 	err = memory_failure(pfn, 0);
+	if (!err) {
+		WARN_ON(!try_module_get(THIS_MODULE));
+		atomic_inc(&hwpoisoned_pages);
+	}
+
 	return (err == -EOPNOTSUPP) ? 0 : err;
 }
 
 static int hwpoison_unpoison(void *data, u64 val)
 {
+	int ret;
+
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	return unpoison_memory(val);
+	ret = unpoison_memory(val);
+	if (!ret) {
+		atomic_dec(&hwpoisoned_pages);
+		module_put(THIS_MODULE);
+	}
+
+	return ret;
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(hwpoison_fops, NULL, hwpoison_inject, "%lli\n");
@@ -99,6 +113,9 @@ static int pfn_inject_init(void)
 	debugfs_create_u64("corrupt-filter-flags-value", 0600, hwpoison_dir,
 			   &hwpoison_filter_flags_value);
 
+	debugfs_create_atomic_t("hwpoisoned-pages", 0400, hwpoison_dir,
+			   &hwpoisoned_pages);
+
 #ifdef CONFIG_MEMCG
 	debugfs_create_u64("corrupt-filter-memcg", 0600, hwpoison_dir,
 			   &hwpoison_filter_memcg);
-- 
2.20.1

