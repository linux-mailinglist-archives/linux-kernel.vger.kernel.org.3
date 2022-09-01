Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905FC5A9E2F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbiIARh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbiIARgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:36:21 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EF64D251
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:36:12 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-335420c7bfeso234911327b3.16
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=OeaHSvnl3LkKr4l31U2Volg5xaVk+RMFLZSi6dgjePI=;
        b=YWMUacgHyaw45xClfelut3B8D4opaNKe1Jn1EvQGqzRnq9IAzY1SbxxDOw3yyYq+BA
         clLIFH+vCJyTvZqkcuk+nPAAVvk+cIcjjJaBgcqIDZI820XVBHBVS4HV09O0+jx02gz/
         GF82/kOz5NOA2SL5LGwa69qRF4uUvf5PcNaP24Dp6cprq2xiDwA1y9+n/C6LME/0C0u+
         LXVRqnwXAQFfakRcmYHnZMbYxKQr/xy2mJHdmdiugDAKPQMxfZlI1xF8c8WSAaPgs+Sf
         8cODiZAHBJrDioo32O0YL9A9GYzXrzP7oLTKiCYFarAedegbhpTrR5084qGw0ahgqNnD
         Ah8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=OeaHSvnl3LkKr4l31U2Volg5xaVk+RMFLZSi6dgjePI=;
        b=SrCdPFex/VHfsUMQ/QjiBxqSCEze6iFsHcsIa3uzDYNXl1nDgRo5EyeIFkpyboG+Zp
         tGd3nWyy1DnSQRV4Qez5MbOk2zVcKHE/SvbqcBeDc1Unb9IQFsGwXBWzg/HcmoeB3GCD
         8eIGCF9SGtKWKH6GMXgusvR2q9jgYGgS8PlUQVLcLuF2PeqE8okeuv6tFB9Jt5c0p3Yq
         DhnUXRx20TwsmL9heHE5k3DSNrH2kgKHOwOyC1RKgW1pl1XN1EHwm2dBSo3GG0ItjVEU
         KyY2agRZFrw5zWW4OsZBSfrtj69HMTaCktYpnUy3Bgx9Xhuad/G3U7taO1huYJHmclxw
         YB3Q==
X-Gm-Message-State: ACgBeo3mbndfTgfv/kj8fGMsc/hmjNM0R6XL+6bDciLWEVyt4pnMtMhi
        94SXN+a95MmKJFCyfeSCKgBKS2EN4TI=
X-Google-Smtp-Source: AA6agR5WRy5fZ7FOeYwPAz+MoQjsxloN5BfCZpV2SaYdV4girws1lZ0WYC4kcT46D4arwsdXcJqkq+Ln5bw=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:1bfc:e7ee:6530:4449])
 (user=surenb job=sendgmr) by 2002:a25:6744:0:b0:696:52a9:2d84 with SMTP id
 b65-20020a256744000000b0069652a92d84mr20473184ybc.256.1662053771488; Thu, 01
 Sep 2022 10:36:11 -0700 (PDT)
Date:   Thu,  1 Sep 2022 10:35:07 -0700
In-Reply-To: <20220901173516.702122-1-surenb@google.com>
Mime-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901173516.702122-20-surenb@google.com>
Subject: [RFC PATCH RESEND 19/28] mm: disallow do_swap_page to handle page
 faults under VMA lock
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        surenb@google.com, kernel-team@android.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
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

Due to the possibility of do_swap_page dropping mmap_lock, abort fault
handling under VMA lock and retry holding mmap_lock. This can be handled
more gracefully in the future.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/memory.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 9ac9944e8c62..29d2f49f922a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3738,6 +3738,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	vm_fault_t ret = 0;
 	void *shadow = NULL;
 
+	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
+		ret = VM_FAULT_RETRY;
+		goto out;
+	}
+
 	if (!pte_unmap_same(vmf))
 		goto out;
 
-- 
2.37.2.789.g6183377224-goog

