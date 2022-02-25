Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4184C522E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 00:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239749AbiBYXop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 18:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239578AbiBYXoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 18:44:32 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8FD1A3615
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 15:43:58 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d726bd83a2so45882517b3.20
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 15:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CSyFxfUZpUzPLuCXdgJGZClgw+3AJRlfu/i2BCEdHwc=;
        b=WeGdlmUqXHjVbARfDifYeaq/dMDQCvyVTPwaPTxPW4KG8eTZQDll26EEGndOpSiHKE
         O2oyDy8pB8fJFLNeMvX+/y3ET9UeDjH3dyk8YZnyif9DxqF40ioemsVYcnVfVmwlljlZ
         TI1yWSmE3ArYWQEuNs8XIqXbRgNntoqP8ZQc8cTYFn+rXTN9mKIAGs+ODtdY2/7/dpF1
         Mlx2LIVyU+OWV8LptNe5GGrjvcRVEqgm+i9y4DmgSkq3eGyIdnTmcWSA6dmVKtf1Bow+
         wCwfJyzUhGMPRZmVKFgs/mCIVO36zfE1LI32FpabZPaXDSuiHPNgUPnHVdWzjEAMKIL5
         zhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CSyFxfUZpUzPLuCXdgJGZClgw+3AJRlfu/i2BCEdHwc=;
        b=kKvs+IZyCUShJNfwjkEcIW90Ppx/i18axEes3Z4gJYwHzYvrzqoatpeiUehvmoM5TX
         7NUvSTwJM9JYMovtnE95g263omXLvIW87EXg1wuxEVow/GWk6Ik2pKFqlwEgjmgQv4WC
         bEG6fVkuFEVFjFgbh0wkiKMXV3V4AIDoQQhX8Cf9hc5IYtVJuwPNGLZHAKEbER4At10r
         2ywpBPxGPEfIWTBQka9lc21RjkESh7yS/6oK2pNcMB1bp01dA418qiEr5PE9Rt7qkd8h
         9MuIaGgd4/T5pYzv1NW67PKDljs6Db3PKgMDeMgJH7v9torc67/hBZpeAa9adewpTN3R
         v3/Q==
X-Gm-Message-State: AOAM531OCFYQ8+rZlxWLwKS1npbUGVxU3taK9AohHzE6eF9fzchfg7p+
        i5WWSLSQ5LyXJlQzFSAplbrSMxWap+Y=
X-Google-Smtp-Source: ABdhPJyRV+FC7RXrcuAS+KiM2C2hXhTqFOLuXMoFojAkUbWorNMJ49eKnvj8E76UedfW3Xoi/Qwx2zKOnLU=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:378d:645d:49ad:4f8b])
 (user=haoluo job=sendgmr) by 2002:a25:25c8:0:b0:622:82ce:ec7a with SMTP id
 l191-20020a2525c8000000b0062282ceec7amr9568082ybl.66.1645832638179; Fri, 25
 Feb 2022 15:43:58 -0800 (PST)
Date:   Fri, 25 Feb 2022 15:43:36 -0800
In-Reply-To: <20220225234339.2386398-1-haoluo@google.com>
Message-Id: <20220225234339.2386398-7-haoluo@google.com>
Mime-Version: 1.0
References: <20220225234339.2386398-1-haoluo@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH bpf-next v1 6/9] libbpf: Add sleepable tp_btf
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, joshdon@google.com, sdf@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the previous patches, we have introduced sleepable tracepoints in the
kernel and listed a couple of cgroup tracepoints as sleepable. This
patch introduces a sleepable version of tp_btf. Sleepable tp_btf progs
can only attach to sleepable tracepoints.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 tools/lib/bpf/libbpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 776b8e034d62..910682357390 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8619,6 +8619,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("fentry/",		TRACING, BPF_TRACE_FENTRY, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("fmod_ret/",		TRACING, BPF_MODIFY_RETURN, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("fexit/",		TRACING, BPF_TRACE_FEXIT, SEC_ATTACH_BTF, attach_trace),
+	SEC_DEF("tp_btf.s/",            TRACING, BPF_TRACE_RAW_TP, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("fentry.s/",		TRACING, BPF_TRACE_FENTRY, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("fmod_ret.s/",		TRACING, BPF_MODIFY_RETURN, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("fexit.s/",		TRACING, BPF_TRACE_FEXIT, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
-- 
2.35.1.574.g5d30c73bfb-goog

