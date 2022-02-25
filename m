Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286484C5231
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 00:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239704AbiBYXow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 18:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239540AbiBYXoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 18:44:34 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD731B755F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 15:44:01 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id i6-20020a255406000000b006241e97e420so4963555ybb.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 15:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=p4juH2rEFqz2fRb0q0EOdUgi0xcehQjhls9oJX8T4Ro=;
        b=Xih7N6C6oWH75MqvjSdcB5rlpKfs8fpSY2hs91oDFWZdSoraz3WAhCnm6FRYONgPev
         UI+qioAt0hPDvIh8XuqBrXDNUb6U4WgiJHojKbt1wBjEVLKol0Bmno7jX9SuVh3jnBYp
         Tmg8Hn2FVymogh6B0K1aCrwZteoMTbwCtIyLP5HMft7/k6PBiVaDBNofejnldDu0f0ng
         Jg8ENvWPshI9CqMg+5UCyI74YPmB5rpgQq78dq7e7gZPi6mzpLl/hpj979WiHsoarytX
         hWBOmkVTOxeuSu4nNhnBQNpeQsYgTQKIBfEm3Fy08XDlfL7PiVhvwjOk212C3F9vsH4P
         y2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=p4juH2rEFqz2fRb0q0EOdUgi0xcehQjhls9oJX8T4Ro=;
        b=29sYXrQ/p45ickD/A/pTvzeityNlguahQ5Jb5cCdjb7Km1TXPe00tcY6J2jAFnYskk
         9E4CZbrHx8FizDkMcge2U2as1R3Q9pe2rzRrXtGyN5VVGLiRZDg+8QaRTPP5PRmyWSJt
         3oSJL+Ul3lsr8nvsi7rcwuUwY3GDH9DHJBCbtob+yNyGleZR2Tpb3EcqkqENj2YTj0b9
         jRkoMtvadEQ8bBTJC0jVxXx7/H3E/wuzNeauTwPmz4CUERzgPHCNoctQyMdi3nbpQi9L
         vsMPYSU1KkdDBmZAyuZxecajHWpP50fL6XLX/ZqmTsp5az30B9ZNGmjY19w2rB2aiyNX
         FQhg==
X-Gm-Message-State: AOAM532RBBWctmC7VYWHRUbwKYDKfqhJ/HP+WWFcMJvWgjPl8Vs0Q9zZ
        tNcSq5s17Eu1EEz+CGKUuc4T6KKg9jU=
X-Google-Smtp-Source: ABdhPJyzBgcYPBrOnA3Nrku4K+C/BiAAZJWhHak8FL2CwleJ8t+gqeTBvZDmuziEcaIN1FWvBiftzXM/sOE=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:378d:645d:49ad:4f8b])
 (user=haoluo job=sendgmr) by 2002:a25:6b4d:0:b0:624:7295:42ee with SMTP id
 o13-20020a256b4d000000b00624729542eemr9575122ybm.290.1645832640625; Fri, 25
 Feb 2022 15:44:00 -0800 (PST)
Date:   Fri, 25 Feb 2022 15:43:37 -0800
In-Reply-To: <20220225234339.2386398-1-haoluo@google.com>
Message-Id: <20220225234339.2386398-8-haoluo@google.com>
Mime-Version: 1.0
References: <20220225234339.2386398-1-haoluo@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH bpf-next v1 7/9] bpf: Lift permission check in __sys_bpf when
 called from kernel.
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

After we introduced sleepable tracing programs, we now have an
interesting problem. There are now three execution paths that can
reach bpf_sys_bpf:

 1. called from bpf syscall.
 2. called from kernel context (e.g. kernel modules).
 3. called from bpf programs.

Ideally, capability check in bpf_sys_bpf is necessary for the first two
scenarios. But it may not be necessary for the third case.

The use case of sleepable tracepoints is to allow root user to deploy
bpf progs which run when a certain kernel tracepoints are triggered.
An example use case is to monitor cgroup creation and perform bpf
operations whenever a cgroup is created. These operations include
pinning an iter to export the cgroup's state. Using sleepable tracing
is preferred because it eliminates the need of a userspace daemon to
monitor cgroup changes.

However, in this use case, the current task who triggers the tracepoint
may be unprivileged and the permission check in __sys_bpf will thus
prevent it from making bpf syscalls. Therefore the tracing progs
deployed by root can not be used by non-root users.

A solution to this problem is to lift the permission check if the caller
of bpf_sys_bpf comes from either kernel context or bpf programs.

An alternative of lifting this permission check would be introducing an
'unpriv' version of bpf_sys_bpf, which doesn't check the current task's
capability. If the owner of the tracing prog wants it to be exclusively
used by root users, they can use the 'priv' version of bpf_sys_bpf; if
the owner wants it to be usable for non-root users, they can use the
'unpriv' version.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 kernel/bpf/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0a12f52fe8a9..3bf88002ee56 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4613,7 +4613,7 @@ static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
 	union bpf_attr attr;
 	int err;
 
-	if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
+	if (sysctl_unprivileged_bpf_disabled && !bpf_capable() && !uattr.is_kernel)
 		return -EPERM;
 
 	err = bpf_check_uarg_tail_zero(uattr, sizeof(attr), size);
-- 
2.35.1.574.g5d30c73bfb-goog

