Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4A44E552C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 16:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245171AbiCWP02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 11:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245159AbiCWP0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:26:23 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB5874DF4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 08:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648049093; x=1679585093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=2MwBeQeAIpRqth/4cukdHA1X4XJIp/JPCi6+z40HpNo=;
  b=G7wYxE90C/WOUOJ36Jez+ca/tAblgjTELtu6+9B3fNpC9JhVOSkAlqrZ
   cqEYavfxN9nsTN0K9S5lMS5GZj8XsVe8jnjayXDgL8CinD48JDa+FBya8
   kWVRf/b3u0EigDnnOzKkKg1xdA1kK+dwqaXQaDc84SnvVh+YuqJ22ficC
   o=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 23 Mar 2022 08:24:52 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 08:24:52 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 23 Mar 2022 08:24:51 -0700
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 23 Mar 2022 08:24:48 -0700
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <mhocko@suse.com>,
        <minchan@kernel.org>, <surenb@google.com>, <vbabka@suse.cz>,
        <rientjes@google.com>, <nadav.amit@gmail.com>,
        <edgararriaga@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Charan Teja Reddy <quic_charante@quicinc.com>
Subject: [PATCH 2/2] mm: madvise: return exact bytes advised with process_madvise under error
Date:   Wed, 23 Mar 2022 20:54:10 +0530
Message-ID: <0fa1bdb5009e898189f339610b90ecca16f243f4.1648046642.git.quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1648046642.git.quic_charante@quicinc.com>
References: <cover.1648046642.git.quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charan Teja Reddy <quic_charante@quicinc.com>

The commit 5bd009c7c9a9 ("mm: madvise: return correct bytes advised with
process_madvise") fixes the issue to return number of bytes that are
successfully advised before hitting error with iovec elements
processing. But, when the user passed unmapped ranges in iovec, the
syscall ignores these holes and continues processing and returns ENOMEM
in the end, which is same as madvise semantic. This is a problem for
vector processing where user may want to know how many bytes were
exactly processed in a iovec element to make better decissions in the
user space. As in ENOMEM case, we processed all bytes in a iovec element
but still returned error which will confuse the user whether it is
failed or succeeded to advise.

As an example, consider below ranges were passed by the user in struct
iovec: iovec1(ranges: vma1), iovec2(ranges: vma2 -- vma3 -- hole) and
iovec3(ranges: vma4). In the current implementation, it fully advise
iovec1 and iovec2 but just returns number of processed bytes as iovec1
range. Then user may repeat the processing of iovec2, which is already
processed, which then returns with ENOMEM. Then user may want to skip
iovec2 and starts processing from iovec3. Here because of wrong return
processed bytes, iovec2 is processed twice. This problem is solved with
commit 08095d6310a7 ("mm: madvise: skip unmapped vma holes passed to
process_madvise"), where the user now returns iovec1 and iovec2 as
processed and he may restart from iovec3. Some problems with this
patch are that:

1) User may wanted to be notified as unmapped address ranges were
passed by returning ENOMEM[1].

2) It didn't consider the case where there exists partially advised
bytes with other error types too, eg EINVAL. Thus fixing only for ENOMEM
is partially solving the problem[2].

3) Even if no vma is found in the passed iovec range, it is still
considered as processed instead of returning ENOMEM.

These can be fixed by having process_madvise() with its own
semantics[3], different from madvise(), where it will have its own
iterator and returns exact bytes it addressed. Now process_madvise()
stops iterating if it encounters a hole or an invalid vma and returns
the bytes till processed in that iovec element. In the above example, it
first returns the processed bytes as the ranges of iovec1(vma1) and
iovec2(vma2, vma3) so that user can exactly know that hole/invalid vma
exists after vma3 in the passed iovec elements. And thus user can skip
hole/invalid vma in the next retry and starts processing from iovec3.

[1]https://lore.kernel.org/linux-mm/YjmLmBUmROr+hshO@dhcp22.suse.cz/
[2]https://lore.kernel.org/linux-mm/YjFAzuLKWw5eadtf@google.com/
[3]https://lore.kernel.org/linux-mm/YjNgoeg1yOocsjWC@google.com/

Signed-off-by: Charan Teja Reddy <quic_charante@quicinc.com>
---
 mm/madvise.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 87 insertions(+), 3 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 0d8fd17..9169b16 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1381,6 +1381,89 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 	return do_madvise(current->mm, start, len_in, behavior);
 }
 
+/*
+ * TODO: Add documentation for process_madvise()
+ */
+static int do_process_madvise(struct mm_struct *mm, unsigned long start, size_t len_in,
+		int behavior, size_t *partial_bytes_advised)
+{
+	unsigned long end, tmp;
+	struct vm_area_struct *vma, *prev;
+	int error = -EINVAL;
+	size_t len;
+	size_t tmp_bytes_advised = 0;
+	struct blk_plug plug;
+
+	*partial_bytes_advised = 0;
+	/*
+	 * TODO: Move these checks to a common function to be used by both
+	 * madvise() and process_madvise().
+	 */
+	start = untagged_addr(start);
+	if (!PAGE_ALIGNED(start))
+		return error;
+	len = PAGE_ALIGN(len_in);
+
+	/* Check to see whether len was rounded up from small -ve to zero */
+	if (len_in && !len)
+		return error;
+
+	end = start + len;
+	if (end < start)
+		return error;
+
+	error = 0;
+	if (end == start)
+		return error;
+
+	mmap_read_lock(mm);
+
+	vma = find_vma_prev(mm, start, &prev);
+	if (vma && start > vma->vm_start)
+		prev = vma;
+
+	blk_start_plug(&plug);
+	for (;;) {
+		/*
+		 * It it hits a unmapped address range in the [start, end),
+		 * stop processing and return ENOMEM.
+		 */
+		if (!vma || start < vma->vm_start) {
+			error = -ENOMEM;
+			goto out;
+		}
+
+		tmp = vma->vm_end;
+		if (end < tmp)
+			tmp = end;
+
+		error = madvise_vma_behavior(vma, &prev, start, tmp, behavior);
+		if (error)
+			goto out;
+		tmp_bytes_advised += tmp - start;
+		start = tmp;
+		if (prev && start < prev->vm_end)
+			start = prev->vm_end;
+		if (start >= end)
+			goto out;
+		if (prev)
+			vma = prev->vm_next;
+		else
+			vma = find_vma(mm, start);
+	}
+out:
+	/*
+	 * partial_bytes_advised may contain non-zero bytes indicating
+	 * the number of bytes advised before failure. Holds zero incase
+	 * of success.
+	 */
+	*partial_bytes_advised = error ? tmp_bytes_advised : 0;
+	blk_finish_plug(&plug);
+	mmap_read_unlock(mm);
+
+	return error;
+}
+
 SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 		size_t, vlen, int, behavior, unsigned int, flags)
 {
@@ -1391,6 +1474,7 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 	struct task_struct *task;
 	struct mm_struct *mm;
 	size_t total_len;
+	size_t partial_bytes_advised;
 	unsigned int f_flags;
 
 	if (flags != 0) {
@@ -1433,14 +1517,14 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 
 	while (iov_iter_count(&iter)) {
 		iovec = iov_iter_iovec(&iter);
-		ret = do_madvise(mm, (unsigned long)iovec.iov_base,
-					iovec.iov_len, behavior);
+		ret = do_process_madvise(mm, (unsigned long)iovec.iov_base,
+				iovec.iov_len, behavior, &partial_bytes_advised);
 		if (ret < 0)
 			break;
 		iov_iter_advance(&iter, iovec.iov_len);
 	}
 
-	ret = (total_len - iov_iter_count(&iter)) ? : ret;
+	ret = (total_len - iov_iter_count(&iter) + partial_bytes_advised) ? : ret;
 
 release_mm:
 	mmput(mm);
-- 
2.7.4

