Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FFB592AC9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 10:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240586AbiHOHdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiHOHdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:33:21 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BAA183AD
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:33:20 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gj1so6315778pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=cKbaTTFL2IC8He8O8jud48JZ4f+oP72hz9bddVAZhgk=;
        b=kTytc0xv5Fr3mYRJ2r1UtrYF8SSwlNsxLirYL1oPuslZgJULKU4nXNp3v4peq5MNZR
         dU1wmbW/g2jE4TMIdO9tK9LecaSJ5/H/a/UhdPi45kHihLmepbwz0LWm3DZgbPWqZntT
         YaYNjPFeZ6TEANS1v4Eb7/ujfw6oRBfOuFlHvpZO1FDav9BsZxaCgw5cM17TyQstSVWk
         1NtVq2SPMiiRD3+iVYyt/2UmfsHslPrvXbnwYvbRRqiVWvCRbcibcV35ATUcnHBM/fgb
         QQCdxjzRFoWIliaFHSaEOqzbm3JrA4hZHDhQAwRkfe2ncSms70ePlbLWvrXDaLhJnaVi
         S/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=cKbaTTFL2IC8He8O8jud48JZ4f+oP72hz9bddVAZhgk=;
        b=c/CxFiFj5z4By7XLIevt4PZ5l0cvZCP2ny7s7j+EWtvNcz5Sj33TZz0vfScMeKKtd5
         B/esC9+1v27xMi0nc2XcGymz0BR3CLnSqJuwzZ/AoJOf5ZbrsQdAkG0NZX1clVGJpZu8
         5zhHuSMj+n9VjMdONecLrG0w5tWrkT/YaEQbo/jIf0Q8sCAATQV92lqItZ2df7kqqwLc
         valtStnClIIeAebIVce1L2lvqxIFPR2xiAsGfy7Z5NLMMdsjOW9BNiAsZ2GQ4TZCREjY
         zg/WWGZClMk0zaJp3NuvQ8rX6GWFXqbH7gpzGSLwLYmIm9NypeVGlox607RjLJCWDBZ3
         W1vw==
X-Gm-Message-State: ACgBeo33ZLq22zxK3nWeXvtq8e6LHlPmIT5GokvuQzUZp9wEytLbRpvG
        d47DomEqDxr2xwGuLnaG42U=
X-Google-Smtp-Source: AA6agR6Qq9TPjqwFTh+pRvFKiRSSih2opS5+KjoOgU9ST1XfxSIASlvyd5EyhD6z/SoxgenWWJhFeQ==
X-Received: by 2002:a17:90a:fb4b:b0:1f3:1cbb:8912 with SMTP id iq11-20020a17090afb4b00b001f31cbb8912mr26605895pjb.239.1660548799830;
        Mon, 15 Aug 2022 00:33:19 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w6-20020a1709029a8600b0016a33177d3csm6396537plp.160.2022.08.15.00.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 00:33:19 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     akpm@linux-foundation.org, iamjoonsoo.kim@lge.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        CGEL ZTE <cgel.zte@gmail.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        wangyong <wang.yong12@zte.com.cn>
Subject: [PATCH v2 2/2] mm/page_io: count submission time as thrashing delay for delayacct
Date:   Mon, 15 Aug 2022 07:28:37 +0000
Message-Id: <20220815072835.74876-1-yang.yang29@zte.com.cn>
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

From: Yang Yang <yang.yang29@zte.com.cn>

Once upon a time, we only support accounting thrashing of page cache.
Then Joonsoo introduced workingset detection for anonymous pages and
we gained the ability to account thrashing of them[1].

Likes PSI, we count submission time as thrashing delay because when
the device is congested, or the submitting cgroup IO-throttled,
submission can be a significant part of overall IO time.

This patch is based on "delayacct: support re-entrance detection of
thrashing accounting".

[1] commit aae466b0052e ("mm/swap: implement workingset detection for anonymous LRU")

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
Reviewed-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Reviewed-by: wangyong <wang.yong12@zte.com.cn>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
Change for v2:
 - use bool in_thrashing instead of unsigned long dflags
---
 mm/page_io.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 68318134dc92..653a2adcfdd9 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -453,18 +453,21 @@ int swap_readpage(struct page *page, bool synchronous,
 	struct swap_info_struct *sis = page_swap_info(page);
 	bool workingset = PageWorkingset(page);
 	unsigned long pflags;
+	bool in_thrashing;
 
 	VM_BUG_ON_PAGE(!PageSwapCache(page) && !synchronous, page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(PageUptodate(page), page);
 
 	/*
-	 * Count submission time as memory stall. When the device is congested,
-	 * or the submitting cgroup IO-throttled, submission can be a
-	 * significant part of overall IO time.
+	 * Count submission time as memory stall and delay. When the device
+	 * is congested, or the submitting cgroup IO-throttled, submission
+	 * can be a significant part of overall IO time.
 	 */
-	if (workingset)
+	if (workingset) {
+		delayacct_thrashing_start(&in_thrashing);
 		psi_memstall_enter(&pflags);
+	}
 	delayacct_swapin_start();
 
 	if (frontswap_load(page) == 0) {
@@ -513,8 +516,10 @@ int swap_readpage(struct page *page, bool synchronous,
 	bio_put(bio);
 
 out:
-	if (workingset)
+	if (workingset) {
+		delayacct_thrashing_end(&in_thrashing);
 		psi_memstall_leave(&pflags);
+	}
 	delayacct_swapin_end();
 	return ret;
 }
-- 
2.25.1

