Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170AC591358
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 17:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238938AbiHLP4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 11:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236950AbiHLP4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 11:56:45 -0400
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5168286C
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 08:56:38 -0700 (PDT)
X-QQ-mid: bizesmtp81t1660319721to8p1aae
Received: from wuhui-virtual-machine.localdoma ( [202.96.137.248])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 12 Aug 2022 23:55:17 +0800 (CST)
X-QQ-SSF: 01400000008000E0T000B00A0000000
X-QQ-FEAT: aS1VR9oWQxAmlADKtpV2wOHmKlmcLW19uIwehpoDcX88P84y/qeOCpxS0DRLc
        RDeu/ypi+zQOa6Wq2sGPHwub6eMXV8zFtDrkme+vM+ZmUpQHmnvkGEwUKoG9A73iQmkiUVL
        D6o03uwYJJEq9kaAtqYuku0MnthhmbSyBXnL9tZ39uCoXrXO4fyEd/O3NkfYxgSBuFvI4NZ
        1EjxybZ583XV93EFk2HKohNM9TbsgQ5F2nbPm+3TiOtgEmiUQ5DMxRC2onpSi8EPb1xL39x
        noEMg9b2bPUm3jzBF4kG8HtMvKOsvg7IIv0d1N+Xlve/mWVRitwmIumwVA32pVHFkmSwdqq
        Iq0lVbPWNXzH0eLsVoulP32ejvwBx7dasQfjitrsYTaoFv4p5Wq3hWZQX8eVg==
X-QQ-GoodBg: 2
From:   Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
To:     akpm@linux-foundation.org
Cc:     zhaochongxi2019@email.szu.edu.cn, yejiajian2018@email.szu.edu.cn,
        linux-kernel@vger.kernel.org, yuhongf@szu.edu.cn,
        Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
Subject: [PATCH] tools/vm/page_owner_sort: fix -f option
Date:   Fri, 12 Aug 2022 23:55:15 +0800
Message-Id: <20220812155515.30846-1-caoyixuan2019@email.szu.edu.cn>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The -f option is to filter out the information of blocks whose memory
has not been released, I noticed some blocks should not be filtered out.

Commit <9cc7e96aa846> ("mm/page_owner: record timestamp and pid")
records the allocation timestamp (ts_nsec) of all pages.

Commit <866b48526217> ("mm/page_owner: record the timestamp of all pages
during free") records the free timestamp (free_ts_nsec) of all pages.
When the page is allocated for the first time, the initial value of
free_ts_nsec is 0, and the corresponding time will be obtained when
the page is released. But during reallocation the free_ts_nsec will
not reset to 0 again. In particular, when page migration occurs,
these two timestamps will be the same.

Now page_owner_sort removes all text blocks whose free_ts_nsec is not 0
when using -f option. However, this way can only select pages allocated
for the first time. If a freed page is reallocated, free_ts_nsec will
be less than ts_nsec; if page migration occurs, the two timestamps will
be equal. These cases should be considered as pages are not released.

So I fix the function is_need() to keep text blocks that meet the above
two conditions when using -f option.

Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
---
 tools/vm/page_owner_sort.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/vm/page_owner_sort.c b/tools/vm/page_owner_sort.c
index ec2e67c85b84..ce860ab94162 100644
--- a/tools/vm/page_owner_sort.c
+++ b/tools/vm/page_owner_sort.c
@@ -470,7 +470,12 @@ static bool match_str_list(const char *str, char **list, int list_size)
 
 static bool is_need(char *buf)
 {
-	if ((filter & FILTER_UNRELEASE) && get_free_ts_nsec(buf) != 0)
+	__u64 ts_nsec, free_ts_nsec;
+
+	ts_nsec = get_ts_nsec(buf);
+	free_ts_nsec = get_free_ts_nsec(buf);
+
+	if ((filter & FILTER_UNRELEASE) && free_ts_nsec != 0 && ts_nsec < free_ts_nsec)
 		return false;
 	if ((filter & FILTER_PID) && !match_num_list(get_pid(buf), fc.pids, fc.pids_size))
 		return false;
-- 
2.17.1

