Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB30590085
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbiHKPoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236481AbiHKPnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:43:41 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1AC9F196
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:38:08 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 14A535FD05;
        Thu, 11 Aug 2022 18:38:06 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1660232286;
        bh=A3K4ViyKorIBmbrqaPTPKHLFa5vS3HsOnKdz/6fJLUw=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=CjfUu6Mk1eOrgCOGEJXFiabeAfvs9yI04vID5EUtRBLVtn12/Tc1GhJgo+8hwgZNA
         S307IjqsKalvRqjSLYykiOcApED8RUj8XniHQb5/z5O3TBsyORSIi2e0NCqT76DKmF
         G2KJb8rXHRwnfIgF4rIdk9Az/kXMCTDNIwLUD2d1ro8sGK6w7/SXAl+nF+i1tB0+sn
         wf3xeTcmNDNWU1fcj6S35CWLQoje4NysqJsb/CYntr67eik5gOgn+V61nc5Gn2fKDT
         AYcPRkKa5PcbZrpL5/RzeK9VuDp8MZCd+d2DtPNZnzPOCfP2rv6+1LKG3RHza4w6KJ
         yp87fQkE6dMww==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Thu, 11 Aug 2022 18:38:06 +0300 (MSK)
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <minchan@kernel.org>, <senozhatsky@chromium.org>,
        <ngupta@vflare.org>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v1 1/2] zsmalloc: zs_object_copy: add clarifying comment
Date:   Thu, 11 Aug 2022 18:37:54 +0300
Message-ID: <20220811153755.16102-2-avromanov@sberdevices.ru>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220811153755.16102-1-avromanov@sberdevices.ru>
References: <20220811153755.16102-1-avromanov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/11 13:20:00 #20096813
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not obvious why kunmap_atomic(d_addr) call is needed.

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
---
 mm/zsmalloc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 5d5fc04385b8..5efa8c592193 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1564,6 +1564,12 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
 		d_off += size;
 		d_size -= size;
 
+		/* Calling kunmap_atomic(d_addr) is necessary. kunmap_atomic() calls
+		 * must occurs in reverse order of calls to kmap_atomic().
+		 * So, to call kunmap_atomic(s_addr) we should first call kunmap_atomic(d_addr).
+		 * For more details see:
+		 * https://lore.kernel.org/linux-mm/5512421D.4000603@samsung.com/
+		 */
 		if (s_off >= PAGE_SIZE) {
 			kunmap_atomic(d_addr);
 			kunmap_atomic(s_addr);
-- 
2.30.1

