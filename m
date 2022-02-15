Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4564B6477
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 08:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbiBOHiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 02:38:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiBOHiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:38:02 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E822110F981
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 23:37:52 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id b22so16573976qkk.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 23:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F0LAKoVYl1MZjeStkRC8r6GRhivZgElOJcOkTtD3oHM=;
        b=UrKdO7iAVP05Udr/yHw9mtXB74ZzhFVugvZUCBwKtyzUlNBB8LrM73EScng7W54qvp
         U6DGBzIG1kASMH4hmaIuCsz4JjiZTe9ZFwK8Jmh1sg9q9mHVcKjTPj50iNb76kvOykS8
         BKGdl0ojsCoZdGPj9xcsqWMSnFsBZB7VZbtsPy7VxpG9dUSqeASXLC7Y7hC9f3/haIaP
         fUQoII7cuBmp4qt7QufPabSr7qketWiYvApkk1XAmsc63DnlP7Tay04MqrE6bUbeNQm6
         laTV16SwXwP4lX2Nh7Wlk498o3QHtx2PeWJ3Hte5hoNW7MnZQ/qlwxcaPQfF9cm19sRz
         FZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F0LAKoVYl1MZjeStkRC8r6GRhivZgElOJcOkTtD3oHM=;
        b=U8hHvPogTU01X+tKXdwPTIfGrjo6FuieW5qEfJnBYR97+aflwIgFtm7oHUlbkN6uOd
         etwyENIlwKJO+mvr7F6uRB34kaNDO+7Ke6tu/dou2UdQiSWyAOCO4686IWh5IlZLJ0Wz
         vET3gY3cHjU7zAzoR9naf/QiALdV6dHt/LgsF9pLMgaYixypQoPk3uGz7nRsmSR8B1Gq
         HmP47+kyRop9OeDmRXJhRMyY/rcZCvRzF6HhPVaq+scr3tyidNT56LSWjUBYt0jic32m
         MivUG1KiHN8AfWkDdXUYZto19RRhGEMaoPAbhgWbMeYhzToox5lCJQG35G2/JV+yUII9
         /Lzw==
X-Gm-Message-State: AOAM533vCkCnVzEVbO4bTHy5lmgOOXVYYYWD/5PCG0HQFOgmcRyHb6Ks
        JBOWr4XNdHsV+zNJOpJLlaE=
X-Google-Smtp-Source: ABdhPJz0/j8DkupPrdaGaUjXGHFu2oCDBSGC0sqidg2/kdymnXTBSpLoE9Uk1tN/YIAMhuh0cXJnMA==
X-Received: by 2002:a05:620a:12ae:: with SMTP id x14mr1361641qki.610.1644910672135;
        Mon, 14 Feb 2022 23:37:52 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e1sm10644995qtw.71.2022.02.14.23.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 23:37:51 -0800 (PST)
From:   cgel.zte@gmail.com
To:     hughd@google.com, mike.kravetz@oracle.com, kirill@shutemov.name,
        songliubraving@fb.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yang.yang29@zte.com.cn, wang.yong12@zte.com.cn,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] Fix shmem huge page failed to set F_SEAL_WRITE attribute problem
Date:   Tue, 15 Feb 2022 07:37:43 +0000
Message-Id: <20220215073743.1769979-1-cgel.zte@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wangyong <wang.yong12@zte.com.cn>

After enabling tmpfs filesystem to support transparent hugepage with the
following command:
 echo always > /sys/kernel/mm/transparent_hugepage/shmem_enabled
The docker program adds F_SEAL_WRITE through the following command will
prompt EBUSY.
 fcntl(5, F_ADD_SEALS, F_SEAL_WRITE)=-1.

It is found that in memfd_wait_for_pins function, the page_count of
hugepage is 512 and page_mapcount is 0, which does not meet the
conditions:
 page_count(page) - page_mapcount(page) != 1.
But the page is not busy at this time, therefore, the page_order of
hugepage should be taken into account in the calculation.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: wangyong <wang.yong12@zte.com.cn>
---
 mm/memfd.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/mm/memfd.c b/mm/memfd.c
index 9f80f162791a..26d1d390a22a 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -31,6 +31,7 @@
 static void memfd_tag_pins(struct xa_state *xas)
 {
 	struct page *page;
+	int count = 0;
 	unsigned int tagged = 0;
 
 	lru_add_drain();
@@ -39,8 +40,12 @@ static void memfd_tag_pins(struct xa_state *xas)
 	xas_for_each(xas, page, ULONG_MAX) {
 		if (xa_is_value(page))
 			continue;
+
 		page = find_subpage(page, xas->xa_index);
-		if (page_count(page) - page_mapcount(page) > 1)
+		count = page_count(page);
+		if (PageTransCompound(page))
+			count -= (1 << compound_order(compound_head(page))) - 1;
+		if (count - page_mapcount(page) > 1)
 			xas_set_mark(xas, MEMFD_TAG_PINNED);
 
 		if (++tagged % XA_CHECK_SCHED)
@@ -67,11 +72,12 @@ static int memfd_wait_for_pins(struct address_space *mapping)
 {
 	XA_STATE(xas, &mapping->i_pages, 0);
 	struct page *page;
-	int error, scan;
+	int error, scan, count;
 
 	memfd_tag_pins(&xas);
 
 	error = 0;
+	count = 0;
 	for (scan = 0; scan <= LAST_SCAN; scan++) {
 		unsigned int tagged = 0;
 
@@ -89,8 +95,12 @@ static int memfd_wait_for_pins(struct address_space *mapping)
 			bool clear = true;
 			if (xa_is_value(page))
 				continue;
+
 			page = find_subpage(page, xas.xa_index);
-			if (page_count(page) - page_mapcount(page) != 1) {
+			count = page_count(page);
+			if (PageTransCompound(page))
+				count -= (1 << compound_order(compound_head(page))) - 1;
+			if (count - page_mapcount(page) != 1) {
 				/*
 				 * On the last scan, we clean up all those tags
 				 * we inserted; but make a note that we still
-- 
2.15.2


