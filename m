Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7879581BF9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 00:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiGZWJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 18:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiGZWJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 18:09:34 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA43C357F8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 15:09:33 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31e89d6bea7so118695347b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 15:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=61ygh8X7OQQWmmobWyLHSxPrOS1I/DRVXUaMo8TVVqI=;
        b=gqHT0I163ggdkBpzgekg1P3z1Owbv0KgTUlCBNz6KTUPjUVzEdgWV/78MN7KEJFvAS
         u9mJA1+KTwKXz77J7ct+7SaLrsrmc5dfV++JY+ccBSXog/u2AaPWhX81vEXSeS4ET1Xx
         fywi68p20oM9tVx8oXHty5YZb/f3QFk46Wo8XHZYEK4EsQDZICnkXEJZEcne12OLURNa
         weaRnuPpahTuDYvUJ/oEWVadZmyU5GkfPp97wiamLVknZWcYOz1u5C1d3OudRN9je7qq
         /wEFwfYtsR5qtrkz19P1Vbun8MshuGYNATcqb9r+4tOOz1ef0oyqQLziDdImctFPXVyF
         2vKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=61ygh8X7OQQWmmobWyLHSxPrOS1I/DRVXUaMo8TVVqI=;
        b=G1rOJMK5tbpJbzX6Y/jVoKrclAAzGfJXM7iq35TBZt0euQxeE+LzawmKrUbdovTNwL
         vOP3eIk/j+On4TCcyQbiiZk496fIPmGOehHrldBnE/AhVmRXj2UfZYa0DPANL+n5WUe7
         FIIsg+QTc4pGl0ZPSMQkQsMGFivMfTwehiPlOpOnwXYq2OAXWpAVUnfsUvVfyOzBXrjn
         a34Gf1dpVnMZc4yseY5o1basKUQsQ/EOTCg0/ql68ALwtiLNpPWlbvdhNMGqazT13Bd/
         pQIpTifBg32koyIVnAt1PPcztfTQJ0Q+hxc1MwCW3sVZfapeEcT11GIlsy9YHFIz3mbf
         Lj6A==
X-Gm-Message-State: AJIora97DTS9MalP9iKEtWUOz8944QraFP0JYJqkrbENDrR2oZB4VsSc
        ZFNTkwS10gEkknv/yisj/nelbxSa4zyz
X-Google-Smtp-Source: AGRyM1tnePqm3Dn8R4WJBqDYeFadFCYz69lsbiCMtw+mCfRf1FbWN2PvCm2fn7EpRTb5fa0x2HF9e6LdpnZR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:256:6b1d:50b:fa5a])
 (user=irogers job=sendgmr) by 2002:a81:8d08:0:b0:317:a4cd:d65d with SMTP id
 d8-20020a818d08000000b00317a4cdd65dmr16308668ywg.329.1658873373047; Tue, 26
 Jul 2022 15:09:33 -0700 (PDT)
Date:   Tue, 26 Jul 2022 15:09:21 -0700
Message-Id: <20220726220921.2567761-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH] perf bpf: Remove undefined behavior from bpf_perf_object__next
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
        Christy Lee <christylee@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bpf_perf_object__next folded the last element in the list test with the
empty list test. However, this meant that offsets were computed against
null and that a struct list_head was compared against a struct
bpf_perf_object. Working around this with clang's undefined behavior
sanitizer required -fno-sanitize=null and -fno-sanitize=object-size.

Remove the undefined behavior by using the regular Linux list APIs and
handling the starting case separately from the end testing case. Looking
at uses like bpf_perf_object__for_each, as the constant NULL or non-NULL
argument can be constant propagated the code is no less efficient.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-loader.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index f8ad581ea247..cdd6463a5b68 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -63,20 +63,16 @@ static struct hashmap *bpf_map_hash;
 static struct bpf_perf_object *
 bpf_perf_object__next(struct bpf_perf_object *prev)
 {
-	struct bpf_perf_object *next;
-
-	if (!prev)
-		next = list_first_entry(&bpf_objects_list,
-					struct bpf_perf_object,
-					list);
-	else
-		next = list_next_entry(prev, list);
+	if (!prev) {
+		if (list_empty(&bpf_objects_list))
+			return NULL;
 
-	/* Empty list is noticed here so don't need checking on entry. */
-	if (&next->list == &bpf_objects_list)
+		return list_first_entry(&bpf_objects_list, struct bpf_perf_object, list);
+	}
+	if (list_is_last(&prev->list, &bpf_objects_list))
 		return NULL;
 
-	return next;
+	return list_next_entry(prev, list);
 }
 
 #define bpf_perf_object__for_each(perf_obj, tmp)	\
-- 
2.37.1.359.gd136c6c3e2-goog

