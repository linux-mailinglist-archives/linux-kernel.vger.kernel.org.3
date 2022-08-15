Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A14592F0F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 14:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241694AbiHOMjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 08:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241406AbiHOMjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 08:39:44 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE1E23BC3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 05:39:43 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 1FEA15FD09;
        Mon, 15 Aug 2022 15:39:41 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1660567181;
        bh=h3xSKGi14GTF8G5k/6CCFwywk/Utp7TIH930LpgqkZA=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=rReJv9mzVG4WmTOUOqB8Jl6WVci032YIB1/4Pyw4YQVEn078p+fF78MI0fCp/AAPa
         OvY6t+h1j0gfXLGFH+L5tD+pWysbgfNDih6NRyRAJhS5qK7UO09Y5gFgpA4TIYyvy4
         3inrQ0tOuWF2EE4yUjt72TOBbhtoaBbxaN5yA9Ef1iJcjPAlZ1LqVIOzXJD0jnC3ta
         aASXd0n11qOgZnYHKvA89J+eMOlcSHeWxt+aALmIhO0EguOfKfyLGFDFiJ5DSK6t59
         OfvBC5QTnoqS//ZyDhzrOn4c2yvuCsAX6NQaI2e2Nqg2Pg3ctWA4T07Vezv36av0z8
         J6b6SRb4ltdhw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Mon, 15 Aug 2022 15:39:41 +0300 (MSK)
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <minchan@kernel.org>, <senozhatsky@chromium.org>,
        <ngupta@vflare.org>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v2 1/2] zsmalloc: zs_object_copy: add clarifying comment
Date:   Mon, 15 Aug 2022 15:39:29 +0300
Message-ID: <20220815123930.37736-2-avromanov@sberdevices.ru>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220815123930.37736-1-avromanov@sberdevices.ru>
References: <20220815123930.37736-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/15 08:42:00 #20120161
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
---
 mm/zsmalloc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 5d5fc04385b8..df381ba891ea 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1564,6 +1564,12 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
 		d_off += size;
 		d_size -= size;
 
+		/* Calling kunmap_atomic(d_addr) is necessary. kunmap_atomic()
+ 		 * calls must occurs in reverse order of calls to kmap_atomic.
+		 * So, to call kunmap_atomic(s_addr) we should first call 
+		 * kunmap_atomic(d_addr). For more details see:
+		 * Documentation/mm/highmem
+		 */
 		if (s_off >= PAGE_SIZE) {
 			kunmap_atomic(d_addr);
 			kunmap_atomic(s_addr);
-- 
2.30.1

