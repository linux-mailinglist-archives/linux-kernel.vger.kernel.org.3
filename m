Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0EF85A561E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiH2V0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiH2V0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:26:17 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8385AC7E
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:25:56 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id y9-20020a17090322c900b00174c881abaeso2531249plg.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=nWFFKiz2JrcFJbZNC6h3WaeWKSGRlWYuGKA4mg+JUNY=;
        b=PCjrqm9NhycPwB3kYWPhGmirug2EAINieO21R1tkNllFgsambVeodQV2SWE+SPKnLk
         B35opb3MQlODsxNphVo3gt2yyCr1QpWXQKLcx1/vKzcN/4STqp6cRFJdHuKeBk+NsfTT
         tDOTylgaSdZ5nEY1ymyrW4L9evpwJBVsw8WgcZFUheAteEM8kYWXWY1xc4VUjrsXgS7n
         TvpEAgLiNbXgMlGNPVj+MFOM++dtX+BoFzGnROjLhFZB70sHOrsgtuWSCJIJNO8R1S+2
         S3QUIvJ5IyCicdMqNDVbeJ892T5I6yDVEmvFVjdkZe2DnjLJIY2H8E2Qt303ElEJo4Tc
         HSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=nWFFKiz2JrcFJbZNC6h3WaeWKSGRlWYuGKA4mg+JUNY=;
        b=c14P+UMmU6epo/yay91QTvQ/VSrvIdMQsuGha5IlMmVsY1Q4GVwe21/mqXW9XrqoA0
         cDnvBKKNwdpZArBZJmXgVQ6fK4SQTS1IpFU5kEfKNxfqt4d8qLpG/l+h87olxxktTYh1
         xmm454LVNbonaz6qZCrJMXSH+dO/F8KbJ65frBtEo3+w96AEh0Vf7hidoDkpdlTC2asA
         atJoe5ixaFJVmknKWRRHUzpAtp5Qarct7GsfN/gg1BIrBznsXlJGKIZaC6b4RcJ3kBVL
         hqs10K0oeRbxqQ9ViYMj2tcc88rw1uZvU8u7QhNB8J2EexQhaX6KfY/qVceMKPg+YE6q
         dZ6g==
X-Gm-Message-State: ACgBeo2MROoQ6Bui0mEpsjBAYI3rqw8C61/775K41bpFp9iyvVn/vxi7
        uqBPTR47EXujXh2EL+/3qdA7beyoOeI=
X-Google-Smtp-Source: AA6agR4dglPLGzQSnoqHwxEZwo0Lk0EwUGiOTYsdKQuDkqIVlV54iwLYmhw7nxi8GDICS/TsbTVUTOyC/V4=
X-Received: from surenb-spec.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e30])
 (user=surenb job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with SMTP id
 t9-20020a17090a024900b001e0a8a33c6cmr21107pje.0.1661808353487; Mon, 29 Aug
 2022 14:25:53 -0700 (PDT)
Date:   Mon, 29 Aug 2022 21:25:13 +0000
In-Reply-To: <20220829212531.3184856-1-surenb@google.com>
Mime-Version: 1.0
References: <20220829212531.3184856-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829212531.3184856-11-surenb@google.com>
Subject: [RFC PATCH 10/28] mm/mmap: mark VMAs as locked in vma_adjust
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, riel@surriel.com,
        luto@kernel.org, songliubraving@fb.com, peterx@redhat.com,
        david@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        rientjes@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, surenb@google.com, kernel-team@android.com,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vma_adjust modifies a VMA and possibly its neighbors. Mark them as locked
before making the modifications.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index f89c9b058105..ed58cf0689b2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -710,6 +710,10 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	long adjust_next = 0;
 	int remove_next = 0;
 
+	vma_mark_locked(vma);
+	if (next)
+		vma_mark_locked(next);
+
 	if (next && !insert) {
 		struct vm_area_struct *exporter = NULL, *importer = NULL;
 
@@ -754,8 +758,11 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 			 * If next doesn't have anon_vma, import from vma after
 			 * next, if the vma overlaps with it.
 			 */
-			if (remove_next == 2 && !next->anon_vma)
+			if (remove_next == 2 && !next->anon_vma) {
 				exporter = next->vm_next;
+				if (exporter)
+					vma_mark_locked(exporter);
+			}
 
 		} else if (end > next->vm_start) {
 			/*
@@ -931,6 +938,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 			 * "vma->vm_next" gap must be updated.
 			 */
 			next = vma->vm_next;
+			if (next)
+				vma_mark_locked(next);
 		} else {
 			/*
 			 * For the scope of the comment "next" and
-- 
2.37.2.672.g94769d06f0-goog

