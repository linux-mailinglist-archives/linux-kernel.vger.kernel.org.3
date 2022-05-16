Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC290527BE3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 04:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239372AbiEPCZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 22:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbiEPCZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 22:25:17 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9854D22B3C
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 19:25:11 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ev18so2499623pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 19:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WfneCJ7ubjXm5v0nJIFpBjx951ZQW+Ht588NQ+ae43Y=;
        b=ieA2QnR1LlaeKK4Ml2MD2KPgnJh0CR+kVbWD2XLdXNcZpYWwZsg7yaicyIs7Fh/lwS
         68ZXWiD6HQqanAgfqoWYmCrFDgVx8cFjeJj3z6QSsJPfhpYh8xrdpe7p0jn++NZdJbO8
         j7hq+XlHeP04YToORz4E3cquojfidJY7BD+4xvs4/y6P7Z2OiN4G/vv8jsuYRhKFu3FE
         XlvTdFrrE1BaFMAsUCDoj1ZhrMk2yCod30SFtci3oFufHmMjgNz/MEv8ik1rIt2emCJV
         gdGv6diKd3f8ZlGTuezTJWEUvQyrcnmHbs+MFz/cz/HbPiXCUD7lxVQdCl2kInCQqvRA
         cbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WfneCJ7ubjXm5v0nJIFpBjx951ZQW+Ht588NQ+ae43Y=;
        b=CiqNpxhVh1OxZSp8EIrSgBH62weH2foUBMl5XlwVvcZZ9oOlQJ1kp9lK6jO7XmQGsu
         0TDX2BzNnU2PPsIptxpJjPBxeAYbQagLb+rqZoZjmzR9nrqKsHCgMU25P94K/MfT3wsc
         lgNpNzGx3S1HqSdgo4ARADx2FT7K8Cx3YYw8EdChtf3lcYRje7+KWni+V9/srGxjKVvh
         zbslZjf8g/yKuXWKiQDQShuyIGVKzpWoZlZbNqDemDcAsG3zf9Qd3e1eksyvqHx2vATH
         aCeIuWCV9eSFn2JSX/El+vup5PKPO8SJfYRpY4MANd64w6SyZS3K3wDe5aaZUHJl0OzW
         ZV7w==
X-Gm-Message-State: AOAM533purx4lL6TkibFirjiHe+4ZBGpWGhXW5VpFEkFbjKgYw2++z4z
        OVldmsEZWOtf8l6EZBGFOLNWXw==
X-Google-Smtp-Source: ABdhPJx861tOUkl71zH5U9XehMVj6VQ9T4Q7NrI1B/1Gjhsr/+Az8f5dudSh1SGp6PlfGvit69j6Pw==
X-Received: by 2002:a17:90b:4c0a:b0:1dc:e81a:f0c with SMTP id na10-20020a17090b4c0a00b001dce81a0f0cmr17311851pjb.2.1652667910767;
        Sun, 15 May 2022 19:25:10 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id q2-20020a170902edc200b0016173113c50sm1454013plk.92.2022.05.15.19.25.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 May 2022 19:25:10 -0700 (PDT)
From:   Feng zhou <zhoufeng.zf@bytedance.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, jolsa@kernel.org, davemarchevsky@fb.com,
        joannekoong@fb.com, geliang.tang@suse.com
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com, wangdongdong.6@bytedance.com,
        cong.wang@bytedance.com, zhouchengming@bytedance.com,
        zhoufeng.zf@bytedance.com, yosryahmed@google.com
Subject: [PATCH bpf-next] selftests/bpf: fix some bugs in map_lookup_percpu_elem testcase
Date:   Mon, 16 May 2022 10:24:53 +0800
Message-Id: <20220516022453.68420-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Feng Zhou <zhoufeng.zf@bytedance.com>

comments from Andrii Nakryiko, details in here:
https://lore.kernel.org/lkml/20220511093854.411-1-zhoufeng.zf@bytedance.com/T/

use /* */ instead of //
use libbpf_num_possible_cpus() instead of sysconf(_SC_NPROCESSORS_ONLN)
use 8 bytes for value size
fix memory leak
use ASSERT_EQ instead of ASSERT_OK
add bpf_loop to fetch values on each possible CPU

Fixes: ed7c13776e20c74486b0939a3c1de984c5efb6aa ("selftests/bpf: add test case for bpf_map_lookup_percpu_elem")
Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
 .../bpf/prog_tests/map_lookup_percpu_elem.c   | 49 +++++++++------
 .../bpf/progs/test_map_lookup_percpu_elem.c   | 61 ++++++++++++-------
 2 files changed, 70 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/map_lookup_percpu_elem.c b/tools/testing/selftests/bpf/prog_tests/map_lookup_percpu_elem.c
index 58b24c2112b0..89ca170f1c25 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_lookup_percpu_elem.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_lookup_percpu_elem.c
@@ -1,30 +1,39 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2022 Bytedance
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2022 Bytedance */
 
 #include <test_progs.h>
 
 #include "test_map_lookup_percpu_elem.skel.h"
 
-#define TEST_VALUE  1
-
 void test_map_lookup_percpu_elem(void)
 {
 	struct test_map_lookup_percpu_elem *skel;
-	int key = 0, ret;
-	int nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
-	int *buf;
+	__u64 key = 0, sum;
+	int ret, i;
+	int nr_cpus = libbpf_num_possible_cpus();
+	__u64 *buf;
 
-	buf = (int *)malloc(nr_cpus*sizeof(int));
+	buf = (__u64 *)malloc(nr_cpus*sizeof(__u64));
 	if (!ASSERT_OK_PTR(buf, "malloc"))
 		return;
-	memset(buf, 0, nr_cpus*sizeof(int));
-	buf[0] = TEST_VALUE;
 
-	skel = test_map_lookup_percpu_elem__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "test_map_lookup_percpu_elem__open_and_load"))
-		return;
+	for (i=0; i<nr_cpus; i++)
+		buf[i] = i;
+	sum = (nr_cpus-1)*nr_cpus/2;
+
+	skel = test_map_lookup_percpu_elem__open();
+	if (!ASSERT_OK_PTR(skel, "test_map_lookup_percpu_elem__open"))
+		goto exit;
+
+	skel->rodata->nr_cpus = nr_cpus;
+
+	ret = test_map_lookup_percpu_elem__load(skel);
+	if (!ASSERT_OK(ret, "test_map_lookup_percpu_elem__load"))
+		goto cleanup;
+
 	ret = test_map_lookup_percpu_elem__attach(skel);
-	ASSERT_OK(ret, "test_map_lookup_percpu_elem__attach");
+	if (!ASSERT_OK(ret, "test_map_lookup_percpu_elem__attach"))
+		goto cleanup;
 
 	ret = bpf_map_update_elem(bpf_map__fd(skel->maps.percpu_array_map), &key, buf, 0);
 	ASSERT_OK(ret, "percpu_array_map update");
@@ -37,10 +46,14 @@ void test_map_lookup_percpu_elem(void)
 
 	syscall(__NR_getuid);
 
-	ret = skel->bss->percpu_array_elem_val == TEST_VALUE &&
-	      skel->bss->percpu_hash_elem_val == TEST_VALUE &&
-	      skel->bss->percpu_lru_hash_elem_val == TEST_VALUE;
-	ASSERT_OK(!ret, "bpf_map_lookup_percpu_elem success");
+	test_map_lookup_percpu_elem__detach(skel);
+
+	ASSERT_EQ(skel->bss->percpu_array_elem_sum, sum, "percpu_array lookup percpu elem");
+	ASSERT_EQ(skel->bss->percpu_hash_elem_sum, sum, "percpu_hash lookup percpu elem");
+	ASSERT_EQ(skel->bss->percpu_lru_hash_elem_sum, sum, "percpu_lru_hash lookup percpu elem");
 
+cleanup:
 	test_map_lookup_percpu_elem__destroy(skel);
+exit:
+	free(buf);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_map_lookup_percpu_elem.c b/tools/testing/selftests/bpf/progs/test_map_lookup_percpu_elem.c
index 5d4ef86cbf48..75479180571f 100644
--- a/tools/testing/selftests/bpf/progs/test_map_lookup_percpu_elem.c
+++ b/tools/testing/selftests/bpf/progs/test_map_lookup_percpu_elem.c
@@ -1,52 +1,69 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2022 Bytedance
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2022 Bytedance */
 
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 
-int percpu_array_elem_val = 0;
-int percpu_hash_elem_val = 0;
-int percpu_lru_hash_elem_val = 0;
+__u64 percpu_array_elem_sum = 0;
+__u64 percpu_hash_elem_sum = 0;
+__u64 percpu_lru_hash_elem_sum = 0;
+const volatile int nr_cpus;
 
 struct {
 	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
 	__uint(max_entries, 1);
 	__type(key, __u32);
-	__type(value, __u32);
+	__type(value, __u64);
 } percpu_array_map SEC(".maps");
 
 struct {
 	__uint(type, BPF_MAP_TYPE_PERCPU_HASH);
 	__uint(max_entries, 1);
-	__type(key, __u32);
-	__type(value, __u32);
+	__type(key, __u64);
+	__type(value, __u64);
 } percpu_hash_map SEC(".maps");
 
 struct {
 	__uint(type, BPF_MAP_TYPE_LRU_PERCPU_HASH);
 	__uint(max_entries, 1);
-	__type(key, __u32);
-	__type(value, __u32);
+	__type(key, __u64);
+	__type(value, __u64);
 } percpu_lru_hash_map SEC(".maps");
 
+struct read_percpu_elem_ctx {
+	void *map;
+	__u64 sum;
+};
+
+static int read_percpu_elem_callback(__u32 index, struct read_percpu_elem_ctx *ctx)
+{
+	__u64 key = 0;
+	__u64 *value;
+	value = bpf_map_lookup_percpu_elem(ctx->map, &key, index);
+	if (value)
+		ctx->sum += *value;
+	return 0;
+}
+
 SEC("tp/syscalls/sys_enter_getuid")
 int sysenter_getuid(const void *ctx)
 {
-	__u32 key = 0;
-	__u32 cpu = 0;
-	__u32 *value;
+	struct read_percpu_elem_ctx map_ctx;
 
-	value = bpf_map_lookup_percpu_elem(&percpu_array_map, &key, cpu);
-	if (value)
-		percpu_array_elem_val = *value;
+	map_ctx.map = &percpu_array_map;
+	map_ctx.sum = 0;
+	bpf_loop(nr_cpus, read_percpu_elem_callback, &map_ctx, 0);
+	percpu_array_elem_sum = map_ctx.sum;
 
-	value = bpf_map_lookup_percpu_elem(&percpu_hash_map, &key, cpu);
-	if (value)
-		percpu_hash_elem_val = *value;
+	map_ctx.map = &percpu_hash_map;
+	map_ctx.sum = 0;
+	bpf_loop(nr_cpus, read_percpu_elem_callback, &map_ctx, 0);
+	percpu_hash_elem_sum = map_ctx.sum;
 
-	value = bpf_map_lookup_percpu_elem(&percpu_lru_hash_map, &key, cpu);
-	if (value)
-		percpu_lru_hash_elem_val = *value;
+	map_ctx.map = &percpu_lru_hash_map;
+	map_ctx.sum = 0;
+	bpf_loop(nr_cpus, read_percpu_elem_callback, &map_ctx, 0);
+	percpu_lru_hash_elem_sum = map_ctx.sum;
 
 	return 0;
 }
-- 
2.20.1

