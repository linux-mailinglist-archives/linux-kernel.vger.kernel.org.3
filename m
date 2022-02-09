Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E531E4AE880
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 05:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238599AbiBIENN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 23:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346327AbiBIDYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:24:51 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5613BC061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 19:24:51 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1644377089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wwHcbxrOHrRRK1eLG2ydA2gjIvZ2G33A6MF/fNq7IHI=;
        b=OuYsvPjrakvUXrUovg0bf2xYB0781sp1nsDn0DwRBd7iRVNbDWr+oiszMswQPBPoRNjlW0
        nTUkYW9R7qSM5C2et/dimH+WA/kWizfGxjMxUOpTT25dwjcU+8ZTNKvvf/P60/daM18DBA
        se73pu549DSBpEV1t8rj4p6uA6k8yO8=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     cai.huoqing@linux.dev
Cc:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ocxl: Make use of the helper macro LIST_HEAD()
Date:   Wed,  9 Feb 2022 11:24:21 +0800
Message-Id: <20220209032421.37725-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,TO_EQ_FM_DIRECT_MX,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace "struct list_head head = LIST_HEAD_INIT(head)" with
"LIST_HEAD(head)" to simplify the code.

Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
 drivers/misc/ocxl/link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
index ab039c115381..9670d02c927f 100644
--- a/drivers/misc/ocxl/link.c
+++ b/drivers/misc/ocxl/link.c
@@ -94,7 +94,7 @@ struct ocxl_link {
 	struct spa *spa;
 	void *platform_data;
 };
-static struct list_head links_list = LIST_HEAD_INIT(links_list);
+static LIST_HEAD(links_list);
 static DEFINE_MUTEX(links_list_lock);
 
 enum xsl_response {
-- 
2.25.1

