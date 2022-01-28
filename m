Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A624149FA80
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348857AbiA1NTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:19:23 -0500
Received: from server.lespinasse.org ([63.205.204.226]:54401 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245035AbiA1NTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:19:08 -0500
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-52-ed;
 t=1643375406; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=Y2k4uPVeoJirwL08p+/VJjxEhsePEHeg9Wr+pPi/UaM=;
 b=WVJsEvoRqkBk1wBf/PQvT+xODXvkJZ2W/KdNjDE+io9o82HbpdsxP3huXOEqePeoiipqa
 4ZiZYFmKjNnl0n6DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-52-rsa; t=1643375406; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=Y2k4uPVeoJirwL08p+/VJjxEhsePEHeg9Wr+pPi/UaM=;
 b=vSQ8s0/J8zRmO0ii8kp4Dal6J6g7+90+5Tg8FB0H2IdHKfFKMNcbY4uu/b23/wp85T5aM
 pOnoLkegyz82Ymv86cgI3Mob1ZWkjQNPdDjPdfSgstcziSsUGjmhsQLiAN4Oq3KjFDqih0C
 akrA6ZElzAceI7GfqcA/Hx3uB4xgwNGlh4eo+ViqOgSTp0ckD0tcvXWGE2eciaPmXCP7mpw
 cGEv2SmbXGevETiQwcjSC3/R20Z7R6KHdPlCkgiUFqy7JfGWasujKkQIZwyeKPSD4jS+ymv
 FfkyfV9r8+INSo2NieNZfKcM0gOcwiJ1e5tDXPb88krQfhDssX28SUscD+QA==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id DAEF516094C;
        Fri, 28 Jan 2022 05:10:06 -0800 (PST)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id C5D6220328; Fri, 28 Jan 2022 05:10:06 -0800 (PST)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-team@fb.com, Laurent Dufour <ldufour@linux.ibm.com>,
        Jerome Glisse <jglisse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [PATCH v2 02/35] mmap locking API: mmap_lock_is_contended returns a bool
Date:   Fri, 28 Jan 2022 05:09:33 -0800
Message-Id: <20220128131006.67712-3-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220128131006.67712-1-michel@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change mmap_lock_is_contended to return a bool value, rather than an
int which the callers are then supposed to interpret as a bool. This
is to ensure consistency with other mmap lock API functions (such as
the trylock functions).

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 include/linux/mmap_lock.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 96e113e23d04..db9785e11274 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -162,9 +162,9 @@ static inline void mmap_assert_write_locked(struct mm_struct *mm)
 	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
 }
 
-static inline int mmap_lock_is_contended(struct mm_struct *mm)
+static inline bool mmap_lock_is_contended(struct mm_struct *mm)
 {
-	return rwsem_is_contended(&mm->mmap_lock);
+	return rwsem_is_contended(&mm->mmap_lock) != 0;
 }
 
 #endif /* _LINUX_MMAP_LOCK_H */
-- 
2.20.1

