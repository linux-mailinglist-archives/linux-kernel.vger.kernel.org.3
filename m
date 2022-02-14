Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3766F4B5D39
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbiBNVte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:49:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiBNVtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:49:32 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B9619414D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:49:23 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id b35so15624429qkp.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HduNWSXwHF2qMp2tKTU9szIHjs3c1KQrYw+jf8BZZPM=;
        b=215dMlHoklWFE+75szJr/Y820Jgsu6uYnJPnIt2MoQCGOJqW3qsQAALF4vXlV9bVTf
         oaY8xA66Iez3WRkyPgpYJ3sJx9jd6pDLsWo5K6Iofc1NmBq5OSY4k07jmhOfFpT9SM6p
         /9JaJyDct5CGz4+UyIutmyUdQFUDTMH4jFG/WLfxmBUQRnsdSk8hw5YKSyeGHnHIkEUH
         3Rzw8AHUCnbs7Wi+ORDMhd1492oL8mFwaYTPkjLGBF1qRd+vM4lIINt6AGmoCT8JQVxw
         MR3RWrJXhYYwa/QgmZ2012SBgF6iPaTdSiOwNh5JC9a+J4bDdec2LxCpQ7Pitsj9HTYN
         qvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HduNWSXwHF2qMp2tKTU9szIHjs3c1KQrYw+jf8BZZPM=;
        b=1q6aYdtOTeu+wOQkPjvLS2i+lt6YtNuOEAsnKX8YGFV2H7RYbb/uI5y2pHgzrwTgYe
         n77Kdm4fqSWFJ+R+4RX+/WFrYRVoWSJAOnBFeNQjCN9kCKrL+TzYEEizY1qrr01fOS7O
         yacQGo57ddi/Oaqop8RDBw8jdU1KeHGgMuZ9z6vrEUAHHUZ9Sx2CTEkoKJgDVIV+dbZN
         3eD9XMnPhWwfRZbim19HxvBXLkBTbua4+V0kLdAGDaqja3X3/hm/IZ1ThcLBZxt3TM/e
         priIyTsTJ1fcmbhxEIj998gktk+JtqyviFHKEjwdIIJIK9qJVEvF1LNnL+BEPQclmCOe
         eLAA==
X-Gm-Message-State: AOAM531NgeqD9yBYOY+lZw7u3fyvilBrbi1HbiBUp4PwoI1hjTkzp9Wu
        YNUTNHsDFOCJTfkpl+J1r97urA==
X-Google-Smtp-Source: ABdhPJyiRZjNZ7NyCD66Td1gEAAhNJr5fwSQTasB43SkAUHLAcSMqVyxeErZVQxtBTjDHLDXHSpppw==
X-Received: by 2002:a05:620a:128c:: with SMTP id w12mr560649qki.464.1644875362346;
        Mon, 14 Feb 2022 13:49:22 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id 5sm18474167qtp.81.2022.02.14.13.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 13:49:22 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, CGEL <cgel.zte@gmail.com>,
        Minchan Kim <minchan@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH] mm: page_io: fix psi memory pressure error on cold swapins
Date:   Mon, 14 Feb 2022 16:49:21 -0500
Message-Id: <20220214214921.419687-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.34.1
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

Once upon a time, all swapins counted toward memory pressure[1]. Then
Joonsoo introduced workingset detection for anonymous pages and we
gained the ability to distinguish hot from cold swapins[2][3]. But we
failed to update swap_readpage() accordingly, and now we account
partial memory pressure in the swapin path of cold memory.

Not for all situations - which adds more inconsistency: paths using
the conventional submit_bio() and lock_page() route will not see much
pressure - unless storage itself is heavily congested and the bio
submissions stall. ZRAM and ZSWAP do most of the work directly from
swap_readpage() and will see all swapins reflected as pressure.

Restore consistency by making all swapin stall accounting conditional
on the page actually being part of the workingset.

[1] commit 937790699be9 ("mm/page_io.c: annotate refault stalls from swap_readpage")
[2] commit aae466b0052e ("mm/swap: implement workingset detection for anonymous LRU")
[3] commit cad8320b4b39 ("mm/swap: don't SetPageWorkingset unconditionally during swapin")

Reported-by: CGEL <cgel.zte@gmail.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Minchan Kim <minchan@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Yu Zhao <yuzhao@google.com>
---
 mm/page_io.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 61c792f916fa..f6296ee25014 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -359,6 +359,7 @@ int swap_readpage(struct page *page, bool synchronous)
 	struct bio *bio;
 	int ret = 0;
 	struct swap_info_struct *sis = page_swap_info(page);
+	bool workingset = PageWorkingset(page);
 	unsigned long pflags;
 
 	VM_BUG_ON_PAGE(!PageSwapCache(page) && !synchronous, page);
@@ -370,7 +371,8 @@ int swap_readpage(struct page *page, bool synchronous)
 	 * or the submitting cgroup IO-throttled, submission can be a
 	 * significant part of overall IO time.
 	 */
-	psi_memstall_enter(&pflags);
+	if (workingset)
+		psi_memstall_enter(&pflags);
 	delayacct_swapin_start();
 
 	if (frontswap_load(page) == 0) {
@@ -431,7 +433,8 @@ int swap_readpage(struct page *page, bool synchronous)
 	bio_put(bio);
 
 out:
-	psi_memstall_leave(&pflags);
+	if (workingset)
+		psi_memstall_leave(&pflags);
 	delayacct_swapin_end();
 	return ret;
 }
-- 
2.34.1

