Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB09A4F975B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 15:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbiDHNzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 09:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236556AbiDHNzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:55:41 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAAC1FCED
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 06:53:36 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1649426015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k5tFbU7BShyxeb1PXfEKBF6QTN+g39+2tO6/MCWhE0c=;
        b=uldKYj8wYfWzhPi+3mWtIYdcWHYJvIuyo9pyhadY1DxD+CHAWwh99kvT69HCH0FtdHMz4p
        DmGE/mw8ipjSFz4ig7FL0jCVxU0w9aUAfSVFqjg1kUJ3dZV0pjtDEzH7uRPcdOrpsn1Oi+
        32fBpogOy6U2CABsEBk5k8QuMihJDcM=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/3] mm/hwpoison: put page in already hwpoisoned case with MF_COUNT_INCREASED
Date:   Fri,  8 Apr 2022 22:53:22 +0900
Message-Id: <20220408135323.1559401-3-naoya.horiguchi@linux.dev>
In-Reply-To: <20220408135323.1559401-1-naoya.horiguchi@linux.dev>
References: <20220408135323.1559401-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

In already hwpoisoned case, memory_failure() is supposed to return with
releasing the page refcount taken for error handling. But currently the
refcount is not released when called with MF_COUNT_INCREASED, which
makes page refcount inconsistent.  This should be rare and non-critical,
but it might be inconvenient in testing (unpoison doesn't work).

Suggested-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 2020944398c9..b2e32cdc3823 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1811,6 +1811,8 @@ int memory_failure(unsigned long pfn, int flags)
 		res = -EHWPOISON;
 		if (flags & MF_ACTION_REQUIRED)
 			res = kill_accessing_process(current, pfn, flags);
+		if (flags & MF_COUNT_INCREASED)
+			put_page(p);
 		goto unlock_mutex;
 	}
 
-- 
2.25.1

