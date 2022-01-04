Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7002D483DD7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 09:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbiADILJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 03:11:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:20640 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234073AbiADIKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 03:10:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641283854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YmRKjJYYnr2jeX5kW8bAyoIlm+DRH3mC592LzQxJkXE=;
        b=f9v0z0lm8yEwpfWln55xXGAR1ufSKPlve61SJF0T7hlTZamzJkV8OZbVjcVhwK7tUAjn9l
        nGcuMVHpEt+mQdf6CJL5PfBHV8qwCWKf04bd19MI+UL0kNgux3+VbZVBvLX5kInPN+PoBR
        9AiucxoXqiAyn9L0Ssw2LwbAsT6i82M=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-FK_KlmOBN1epuya1C1l1RA-1; Tue, 04 Jan 2022 03:10:53 -0500
X-MC-Unique: FK_KlmOBN1epuya1C1l1RA-1
Received: by mail-ed1-f70.google.com with SMTP id x19-20020a05640226d300b003f8b80f5729so23374712edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 00:10:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YmRKjJYYnr2jeX5kW8bAyoIlm+DRH3mC592LzQxJkXE=;
        b=0P4u9dyMP7d9tQotjx3rdCt4tgpNy4ahLueqCnzx1oSdh5kutjy6Ky3bPGf9qRAZzY
         HvP+elbb318k95467eHf6IWrC90d9erWx0Lsx5EdEb7GY2wdT5y8+LabAfRAs8rcbI2b
         26AP5Ss1q23/BfW+qql4Al57qA1lj+1vdoEapGZse008WYdqc/+b9gMrF9yDhOpvZLaN
         Fsxe66nxNUkwtjuMejE65CJmToAM0SSksaADtcmMsu97gDnJrm0X3kBTmYRJ5ZKU9FNK
         ERmiFxEOgY4BCQGTyFAbDcXg8EjftlHJtq53wUtO46gk4ii9sp6Gx0t+jYg82KO30j60
         0OTw==
X-Gm-Message-State: AOAM5321pqa+/6QpSqn9VYW9DAFEAvQ/4g/hxyAt/A3/ywK8HrkLvlOA
        pKqjnx2JbTQtyp5b0POZv0/QT8fPO9ZRv+TT0GpccG/vxMLNjaxIdvZMPxC7Kp0i8CjmSyu18Cm
        K8pSwlorUrIZYZtLW95sTBUbY
X-Received: by 2002:a17:906:c147:: with SMTP id dp7mr37784170ejc.173.1641283851760;
        Tue, 04 Jan 2022 00:10:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwrJiWwHVZWR9cEMfNpKPhzTTeCzxB6S/iuRTpAQN/EOTKmHH18Ismc6bCp+pYKntGFgT+Z6Q==
X-Received: by 2002:a17:906:c147:: with SMTP id dp7mr37784148ejc.173.1641283851527;
        Tue, 04 Jan 2022 00:10:51 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id c3sm14400378edr.33.2022.01.04.00.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 00:10:51 -0800 (PST)
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
Subject: [PATCH 11/13] libbpf: Add bpf_program__attach_kprobe_opts for multi kprobes
Date:   Tue,  4 Jan 2022 09:09:41 +0100
Message-Id: <20220104080943.113249-12-jolsa@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220104080943.113249-1-jolsa@kernel.org>
References: <20220104080943.113249-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  SEC("raw_kprobe/bpf_fentry_test*")

to attach program to all bpf_fentry_test* functions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c | 124 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 123 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 25512b4dbc8c..0061ab02fc5a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10000,6 +10000,125 @@ static int perf_event_kprobe_open_legacy(const char *probe_name, bool retprobe,
 	return pfd;
 }
 
+struct kprobe_resolve_raw_kprobe {
+	const char *name;
+	__u64 *addrs;
+	__u32 alloc;
+	__u32 cnt;
+};
+
+static bool glob_matches(const char *glob, const char *s)
+{
+	int n = strlen(glob);
+
+	if (n == 1 && glob[0] == '*')
+		return true;
+
+	if (glob[0] == '*' && glob[n - 1] == '*') {
+		const char *subs;
+		/* substring match */
+
+		/* this is hacky, but we don't want to allocate
+		 * for no good reason
+		 */
+		((char *)glob)[n - 1] = '\0';
+		subs = strstr(s, glob + 1);
+		((char *)glob)[n - 1] = '*';
+
+		return subs != NULL;
+	} else if (glob[0] == '*') {
+		size_t nn = strlen(s);
+		/* suffix match */
+
+		/* too short for a given suffix */
+		if (nn < n - 1)
+			return false;
+		return strcmp(s + nn - (n - 1), glob + 1) == 0;
+	} else if (glob[n - 1] == '*') {
+		/* prefix match */
+		return strncmp(s, glob, n - 1) == 0;
+	} else {
+		/* exact match */
+		return strcmp(glob, s) == 0;
+	}
+}
+
+static int
+kprobe_resolve_raw_kprobe_cb(void *arg, unsigned long long sym_addr,
+			     char sym_type, const char *sym_name)
+{
+	struct kprobe_resolve_raw_kprobe *res = arg;
+	__u64 *p;
+
+	if (!glob_matches(res->name, sym_name))
+		return 0;
+
+	if (res->cnt == res->alloc) {
+		res->alloc = max((__u32) 16, res->alloc * 3 / 2);
+		p = libbpf_reallocarray(res->addrs, res->alloc, sizeof(__u32));
+		if (!p)
+			return -ENOMEM;
+		res->addrs = p;
+	}
+	res->addrs[res->cnt++] = sym_addr;
+	return 0;
+}
+
+static struct bpf_link *
+attach_raw_kprobe_opts(const struct bpf_program *prog,
+		       const char *func_name,
+		       const struct bpf_kprobe_opts *kopts)
+{
+	DECLARE_LIBBPF_OPTS(bpf_link_create_opts, opts);
+	struct kprobe_resolve_raw_kprobe res = {
+		.name = func_name,
+	};
+	struct bpf_link *link = NULL;
+	char errmsg[STRERR_BUFSIZE];
+	int err, link_fd, prog_fd;
+	__u64 bpf_cookie;
+	bool retprobe;
+
+	err = libbpf__kallsyms_parse(&res, kprobe_resolve_raw_kprobe_cb);
+	if (err)
+		goto error;
+	if (!res.cnt) {
+		err = -ENOENT;
+		goto error;
+	}
+
+	retprobe = OPTS_GET(kopts, retprobe, false);
+	bpf_cookie = OPTS_GET(kopts, bpf_cookie, 0);
+
+	opts.kprobe.addrs = (__u64) res.addrs;
+	opts.kprobe.cnt = res.cnt;
+	opts.kprobe.bpf_cookie = bpf_cookie;
+	opts.flags = retprobe ? BPF_F_KPROBE_RETURN : 0;
+
+	link = calloc(1, sizeof(*link));
+	if (!link)
+		return libbpf_err_ptr(-ENOMEM);
+	link->detach = &bpf_link__detach_fd;
+
+	prog_fd = bpf_program__fd(prog);
+	link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_RAW_KPROBE, &opts);
+	if (link_fd < 0) {
+		err = -errno;
+		pr_warn("prog '%s': failed to attach to %s: %s\n",
+			prog->name, res.name,
+			libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+		goto error;
+	}
+	link->fd = link_fd;
+	free(res.addrs);
+	return link;
+
+error:
+	free(link);
+	free(res.addrs);
+	return libbpf_err_ptr(err);
+}
+
 struct bpf_link *
 bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 				const char *func_name,
@@ -10016,6 +10135,9 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 	if (!OPTS_VALID(opts, bpf_kprobe_opts))
 		return libbpf_err_ptr(-EINVAL);
 
+	if (strchr(func_name, '*'))
+		return attach_raw_kprobe_opts(prog, func_name, opts);
+
 	retprobe = OPTS_GET(opts, retprobe, false);
 	offset = OPTS_GET(opts, offset, 0);
 	pe_opts.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
@@ -10096,7 +10218,7 @@ static struct bpf_link *attach_kprobe(const struct bpf_program *prog, long cooki
 	else
 		func_name = prog->sec_name + sizeof("kprobe/") - 1;
 
-	n = sscanf(func_name, "%m[a-zA-Z0-9_.]+%li", &func, &offset);
+	n = sscanf(func_name, "%m[a-zA-Z0-9_.*]+%li", &func, &offset);
 	if (n < 1) {
 		err = -EINVAL;
 		pr_warn("kprobe name is invalid: %s\n", func_name);
-- 
2.33.1

