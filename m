Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2BF4C205E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 01:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245127AbiBXAGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 19:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245121AbiBXAGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 19:06:06 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04085E75F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 16:05:36 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a12-20020a056902056c00b0061dc0f2a94aso294942ybt.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 16:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=iT2nwSp2MDELC5D0BfQ9M2lshxJNXqqajiXX8H+mgdY=;
        b=kn+bLvQlifPhevSSRCAMPEsDbXAbo11L/fJnHiILGz3s/JmAEsBglIaLuY4Oanwudq
         gl+XEjYU/xmrN6sxvU8aQyKNSRRTgyqkoKJjuwPLiYQAL158Y7sDWPvuIrbDnEMu1/4e
         I2QbZW9Zmqd5OzDUhaNVsM57vtVWTELwjqlNT06PFABsBk3UoF1IeouVa0iBUAE9+o6L
         61Qt9Aukr+KvAVLr9MfJhk6nVJlycej+oUiOcgUM+sqpLfmJQHxmEhGUR5zL9i+g3UXB
         4JWau7fkz8hWBmZrkW3Hp6oJJJdxcRTf/wtyz+LHSgnP4cSN4dA6WS4ZNntl4y7dhONB
         QmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=iT2nwSp2MDELC5D0BfQ9M2lshxJNXqqajiXX8H+mgdY=;
        b=ZNpI29fLcpoqUHFfgMmRqzuwXdZpkoOjoVeqTkvZCS0S/foQpmqxO29mb7s0RW1kLx
         6zRgNd+DJWrhg6x8XdoJS53ELqhcz+0qVbXtp1cVVmjWEPtM1arpP4/r6BRhfVDUSoxE
         w+VC2FoqVSZggioVJ/CR1H2ReSz0nzz2JjDFn0hUAGGnqplqJXmL5KnRW54UsBglc7wN
         4wJbeucNxjMN8Y/4xHwQNn5EJ6FFCCNQBIJzkLcW1nIf20J4uhudpqJMsqKdvWe2jT6w
         FJDQ1piXfw2M00h+KNndrX4x+pyAin6rCXxHUHGgnLK7UmxSyowYnm/aWglHA+UR0YRc
         P2eQ==
X-Gm-Message-State: AOAM53105thiRdt9xYQAIQgGUQFNcLoGsrHbgqw8IyPrW4MVjAitoWCY
        ycryOU9Z63Ko2xAS6rtaaAp849szonw=
X-Google-Smtp-Source: ABdhPJxdsDLpj6UxKJPqhApcmMBk/+l3I/GwRbZoZ621WAWKapei6nkWK9pglXhSefYe8aCJdUpfO0t6lSQ=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:9479:7f16:e9b8:14e4])
 (user=haoluo job=sendgmr) by 2002:a25:b226:0:b0:624:5e7a:56b with SMTP id
 i38-20020a25b226000000b006245e7a056bmr174872ybj.61.1645661136096; Wed, 23 Feb
 2022 16:05:36 -0800 (PST)
Date:   Wed, 23 Feb 2022 16:05:31 -0800
Message-Id: <20220224000531.1265030-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH bpf-next v2] bpf: Cache the last valid build_id.
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Blake Jones <blakejones@google.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hao Luo <haoluo@google.com>,
        Greg Thelen <gthelen@google.com>
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

For binaries that are statically linked, consecutive stack frames are
likely to be in the same VMA and therefore have the same build id.
As an optimization for this case, we can cache the previous frame's
VMA, if the new frame has the same VMA as the previous one, reuse the
previous one's build id. We are holding the MM locks as reader across
the entire loop, so we don't need to worry about VMA going away.

Tested through "stacktrace_build_id" and "stacktrace_build_id_nmi" in
test_progs.

Suggested-by: Greg Thelen <gthelen@google.com>
Signed-off-by: Hao Luo <haoluo@google.com>
---
 kernel/bpf/stackmap.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 22c8ae94e4c1..38bdfcd06f55 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -132,7 +132,8 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 	int i;
 	struct mmap_unlock_irq_work *work = NULL;
 	bool irq_work_busy = bpf_mmap_unlock_get_irq_work(&work);
-	struct vm_area_struct *vma;
+	struct vm_area_struct *vma, *prev_vma = NULL;
+	const char *prev_build_id;
 
 	/* If the irq_work is in use, fall back to report ips. Same
 	 * fallback is used for kernel stack (!user) on a stackmap with
@@ -150,6 +151,12 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 	}
 
 	for (i = 0; i < trace_nr; i++) {
+		if (range_in_vma(prev_vma, ips[i], ips[i])) {
+			vma = prev_vma;
+			memcpy(id_offs[i].build_id, prev_build_id,
+			       BUILD_ID_SIZE_MAX);
+			goto build_id_valid;
+		}
 		vma = find_vma(current->mm, ips[i]);
 		if (!vma || build_id_parse(vma, id_offs[i].build_id, NULL)) {
 			/* per entry fall back to ips */
@@ -158,9 +165,12 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 			memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX);
 			continue;
 		}
+build_id_valid:
 		id_offs[i].offset = (vma->vm_pgoff << PAGE_SHIFT) + ips[i]
 			- vma->vm_start;
 		id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
+		prev_vma = vma;
+		prev_build_id = id_offs[i].build_id;
 	}
 	bpf_mmap_unlock_mm(work, current->mm);
 }
-- 
2.35.1.473.g83b2b277ed-goog

