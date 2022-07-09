Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCAB56C573
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 02:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiGIAE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 20:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiGIAEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 20:04:51 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CA491CD7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 17:04:49 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id o21-20020a17090aac1500b001ef977190efso1951317pjq.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 17:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Q9FL6WxsRkjxyh1yae/tVcFdnxYyUSpDQ2F41fjmbF0=;
        b=jUf7c6YoaaMSoKC3BzGDRElpUL1MBXHu3HTb8RdVhRCb9f/DnJoiC27UnqjXk14m1j
         xF7v2kw5Cz/bksp7MeouwdKTi8UkpOmRc/cA63UZIx9TllIDKOdpntym4huATJVKYqn4
         jZlNKh/X2D5woBeHtNXySysNlP1TXkXH7jDkoKE4zbNeeBqk0Cl1bG1X9Ym3K+O6922n
         N9I7HCRQXgbGzPhOFD/mlfV8zr+Sjelb03+XNmOuOE8qi9/6SxPY0ekAoUW5oT1DEZRb
         2XaW7xzSPNKyvjceTCKRZX8NwBd7EKXFkqYf486Zt8eZxCmhBFlTJpVm90EduvckS8xT
         ZJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Q9FL6WxsRkjxyh1yae/tVcFdnxYyUSpDQ2F41fjmbF0=;
        b=vMvbMD1L7mD4Gtfo70CePw3NOL6ISz8UcvREhuyaKb1VZMBs9vDK+SNjCLUvWZfwhP
         xBCWveRnpghMRD0xeabb2y3KN8GJhR1U3zaXNYjl9mkn0DzVO0LRq40Up72zEXJIRVme
         WGSiqi0yaee0WfBR94HaaQGOwknOLAlqcjvE+LVEdLKKsYEengiOroxIYKWbiFwnppaG
         ALYYof8gWs98gICuA4VXBJhGPyICIiXxb59HESl8vxh1esr6LiXX8GEsHuG5hjZQMOiD
         TEyBJKT29kNcoD2093hRgRlaEqwp1N2yvn2NO8wK9XQbpMv36jDsX2DZvKEiG7k3fIj8
         sL0Q==
X-Gm-Message-State: AJIora8FswF4V0fu47oEEU+7fFJZAppa739amrtvNVBLEy4TsJzLD7cN
        d91eSyOvhTWjK4X6rpHGMYa1Pk/fGdiTOGdo
X-Google-Smtp-Source: AGRyM1sWk0mGUAU/7Wo/VmrO6Ivkt/2e9FqsEbhx2jqXbUDrC8HfzNTeSufABPaMdycMFie1eI3qhmIY5BLiHxBj
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:902:ba90:b0:16a:2863:fb85 with SMTP
 id k16-20020a170902ba9000b0016a2863fb85mr6176642pls.15.1657325089270; Fri, 08
 Jul 2022 17:04:49 -0700 (PDT)
Date:   Sat,  9 Jul 2022 00:04:32 +0000
In-Reply-To: <20220709000439.243271-1-yosryahmed@google.com>
Message-Id: <20220709000439.243271-2-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220709000439.243271-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH bpf-next v3 1/8] btf: Add a new kfunc set which allows to mark
 a function to be sleepable
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, cgroups@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
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

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

This allows to declare a kfunc as sleepable and prevents its use in
a non sleepable program.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/btf.h |  2 ++
 kernel/bpf/btf.c    | 13 +++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 1bfed7fa04287..6e7517573d9e4 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -18,6 +18,7 @@ enum btf_kfunc_type {
 	BTF_KFUNC_TYPE_RELEASE,
 	BTF_KFUNC_TYPE_RET_NULL,
 	BTF_KFUNC_TYPE_KPTR_ACQUIRE,
+	BTF_KFUNC_TYPE_SLEEPABLE,
 	BTF_KFUNC_TYPE_MAX,
 };
 
@@ -37,6 +38,7 @@ struct btf_kfunc_id_set {
 			struct btf_id_set *release_set;
 			struct btf_id_set *ret_null_set;
 			struct btf_id_set *kptr_acquire_set;
+			struct btf_id_set *sleepable_set;
 		};
 		struct btf_id_set *sets[BTF_KFUNC_TYPE_MAX];
 	};
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4f2408a4df08b..2a4b4e50b6fb7 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6172,7 +6172,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 	struct bpf_verifier_log *log = &env->log;
 	u32 i, nargs, ref_id, ref_obj_id = 0;
 	bool is_kfunc = btf_is_kernel(btf);
-	bool rel = false, kptr_get = false;
+	bool rel = false, kptr_get = false, sleepable = false;
 	const char *func_name, *ref_tname;
 	const struct btf_type *t, *ref_t;
 	const struct btf_param *args;
@@ -6203,11 +6203,13 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 	}
 
 	if (is_kfunc) {
-		/* Only kfunc can be release func */
+		/* Only kfunc can be release, kptr acquire, or sleepable func */
 		rel = btf_kfunc_id_set_contains(btf, resolve_prog_type(env->prog),
 						BTF_KFUNC_TYPE_RELEASE, func_id);
 		kptr_get = btf_kfunc_id_set_contains(btf, resolve_prog_type(env->prog),
 						     BTF_KFUNC_TYPE_KPTR_ACQUIRE, func_id);
+		sleepable = btf_kfunc_id_set_contains(btf, resolve_prog_type(env->prog),
+						      BTF_KFUNC_TYPE_SLEEPABLE, func_id);
 	}
 
 	/* check that BTF function arguments match actual types that the
@@ -6405,6 +6407,13 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 			func_name);
 		return -EINVAL;
 	}
+
+	if (sleepable && !env->prog->aux->sleepable) {
+		bpf_log(log, "kernel function %s is sleepable but the program is not\n",
+			func_name);
+		return -EINVAL;
+	}
+
 	/* returns argument register number > 0 in case of reference release kfunc */
 	return rel ? ref_regno : 0;
 }
-- 
2.37.0.rc0.161.g10f37bed90-goog

