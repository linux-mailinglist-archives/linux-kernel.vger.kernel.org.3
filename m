Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A8B483DDD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 09:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbiADILa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 03:11:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27995 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234149AbiADILI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 03:11:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641283867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n1Sn68YOpfQdWqtYtUrgCV+sac3UqaI1SOKuBByB+TA=;
        b=ifQyikBVw4X8yU49j0b2BVUZ7C7SIUHx2P5aeqLEyFpKc0n1pot3QuwfJlMRjOUpJvQNLC
        DEM2yE+7ln7bJi3g4OHxakt2yw4JSYwY3rzyNCSz6NWweXnH6IpWQ6smSzkxyQ+xvSTZcs
        BahRS/5TjFYSw3DfZbBhpUQ4xGXeaEI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-470-ymtHuzebP3eu9PSjtI_JRQ-1; Tue, 04 Jan 2022 03:11:05 -0500
X-MC-Unique: ymtHuzebP3eu9PSjtI_JRQ-1
Received: by mail-ed1-f69.google.com with SMTP id v18-20020a056402349200b003f8d3b7ee8dso21273605edc.23
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 00:11:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n1Sn68YOpfQdWqtYtUrgCV+sac3UqaI1SOKuBByB+TA=;
        b=CnpNVAgi6g22zwRAvxShc4NQaTA/I5um74FNp+ORcvANPnFD6i7lpl1mP3FF6qWUaP
         v4Kqu2X05zlJ5In8+XIROfpLZGCm2L5gJC7atUCMtjC71DtPmnD5BkjsayqLflgUZrkv
         4OIYAatV4Y7/AQ5o7uJitduS3sAybvtUjU6IoHXCeV+RdY+URedeeOfaeiYdU7iVBN9f
         RNjnLUwJ3w3UshBSF5XLRcx68HUhs/DYGLw7jEnVh96CeyvueLqJH48Am78d+BJdZzRZ
         3f88P3yUjudq2NYYcVJTOzFxPV3To/+KqCSOOrxiMK0abF8acMPrCd4i1sa1xIf3kmz4
         6XyA==
X-Gm-Message-State: AOAM530SIm8Pv4M1aa63qztCYpiuH119iqrgMQIHVDh9RsHWyFL+3DaK
        6iOVsj8DnLOS/dRzAzjF3AWkl8MzJJ5Laf+frzeV4s+LQAYexwtR35cYzNoEbBzE9Un9Ls3Nr8k
        +lzfrU6y6MM0xcAQCod7WAptl
X-Received: by 2002:a17:907:3fa0:: with SMTP id hr32mr40732552ejc.196.1641283864068;
        Tue, 04 Jan 2022 00:11:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxY0vOWIbWrowC6YTp97SbKilX2ZYMN/pSg5z78CfP/qlYGdHEk+p7bdrBYems4kOONH6Q1LQ==
X-Received: by 2002:a17:907:3fa0:: with SMTP id hr32mr40732544ejc.196.1641283863934;
        Tue, 04 Jan 2022 00:11:03 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id v8sm14318341edt.10.2022.01.04.00.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 00:11:03 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 13/13] selftest/bpf: Add bpf_cookie test for raw_k[ret]probe
Date:   Tue,  4 Jan 2022 09:09:43 +0100
Message-Id: <20220104080943.113249-14-jolsa@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220104080943.113249-1-jolsa@kernel.org>
References: <20220104080943.113249-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding bpf_cookie test for raw_k[ret]probes.

Using the bpf_link_create interface directly and single
trampoline program to trigger the bpf_fentry_test1
execution.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/bpf_cookie.c     | 42 +++++++++++++++++++
 .../selftests/bpf/progs/test_bpf_cookie.c     | 24 ++++++++++-
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
index 5eea3c3a40fe..aee01dd3a823 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -57,6 +57,46 @@ static void kprobe_subtest(struct test_bpf_cookie *skel)
 	bpf_link__destroy(retlink2);
 }
 
+static void rawkprobe_subtest(struct test_bpf_cookie *skel)
+{
+	DECLARE_LIBBPF_OPTS(bpf_link_create_opts, opts);
+	int err, prog_fd, link1_fd = -1, link2_fd = -1;
+	__u32 duration = 0, retval;
+	__u64 addr;
+
+	kallsyms_find("bpf_fentry_test1", &addr);
+
+	opts.kprobe.addrs = (__u64) &addr;
+	opts.kprobe.cnt = 1;
+	opts.kprobe.bpf_cookie = 0x1;
+	prog_fd = bpf_program__fd(skel->progs.handle_raw_kprobe);
+
+	link1_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_RAW_KPROBE, &opts);
+	if (!ASSERT_GE(link1_fd, 0, "link1_fd"))
+		return;
+
+	opts.flags = BPF_F_KPROBE_RETURN;
+	opts.kprobe.bpf_cookie = 0x2;
+	prog_fd = bpf_program__fd(skel->progs.handle_raw_kretprobe);
+
+	link2_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_RAW_KPROBE, &opts);
+	if (!ASSERT_GE(link2_fd, 0, "link2_fd"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.raw_trigger);
+	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
+				NULL, NULL, &retval, &duration);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(retval, 0, "test_run");
+
+	ASSERT_EQ(skel->bss->raw_kprobe_res, 0x1, "raw_kprobe_res");
+	ASSERT_EQ(skel->bss->raw_kretprobe_res, 0x2, "raw_kretprobe_res");
+
+cleanup:
+	close(link1_fd);
+	close(link2_fd);
+}
+
 static void uprobe_subtest(struct test_bpf_cookie *skel)
 {
 	DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, opts);
@@ -243,6 +283,8 @@ void test_bpf_cookie(void)
 
 	if (test__start_subtest("kprobe"))
 		kprobe_subtest(skel);
+	if (test__start_subtest("rawkprobe"))
+		rawkprobe_subtest(skel);
 	if (test__start_subtest("uprobe"))
 		uprobe_subtest(skel);
 	if (test__start_subtest("tracepoint"))
diff --git a/tools/testing/selftests/bpf/progs/test_bpf_cookie.c b/tools/testing/selftests/bpf/progs/test_bpf_cookie.c
index 2d3a7710e2ce..409f87464b1f 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_cookie.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_cookie.c
@@ -8,8 +8,9 @@
 int my_tid;
 
 int kprobe_res;
-int kprobe_multi_res;
 int kretprobe_res;
+int raw_kprobe_res;
+int raw_kretprobe_res;
 int uprobe_res;
 int uretprobe_res;
 int tp_res;
@@ -37,6 +38,27 @@ int handle_kretprobe(struct pt_regs *ctx)
 	return 0;
 }
 
+SEC("kprobe/bpf_fentry_test1")
+int handle_raw_kprobe(struct pt_regs *ctx)
+{
+	update(ctx, &raw_kprobe_res);
+	return 0;
+}
+
+SEC("kretprobe/bpf_fentry_test1")
+int handle_raw_kretprobe(struct pt_regs *ctx)
+{
+	update(ctx, &raw_kretprobe_res);
+	return 0;
+}
+
+/* just to trigger bpf_fentry_test1 through tracing test_run */
+SEC("fentry/bpf_modify_return_test")
+int BPF_PROG(raw_trigger)
+{
+	return 0;
+}
+
 SEC("uprobe/trigger_func")
 int handle_uprobe(struct pt_regs *ctx)
 {
-- 
2.33.1

