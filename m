Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A658D57D854
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 04:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbiGVCNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 22:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiGVCNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:13:19 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B80D974A6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 19:13:18 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id pg9-20020a17090b1e0900b001f076f7d15eso3608854pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 19:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8eRj9fMxXF9DI7dFEv6N0YjYMeiPhUl4vAONmVgAO28=;
        b=eur06Mq9kngpS3Qvjvz223Zcfqh8cL4QJn1vB2gx/yYrWEeT+nDHrlNwWPUmtc2fsC
         WKmfoOkNWVW2MqD6n+pewDybeNl7L8lDtPI8CL+DTe7eCNA8kW6XytrY10h1TPzVSY3H
         8zd9aZX6OZS/c6SIDZ0jQD/rtHS5YJCakj33j23tSt+PpEz/hx5SpYEu3jqqNg4KozUE
         jhDUj5rKDiKazAfMpj+H/KPbggidtMW1hRzARCI7NNrVd5T8HOmBF/y8GjeresFU0Q7W
         npC/1KKV9DjiO7FRRQATlhCOL3mR60JFVSWVzYtz/24p0u0i+1EobLITIoACYXkhtmC0
         CErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8eRj9fMxXF9DI7dFEv6N0YjYMeiPhUl4vAONmVgAO28=;
        b=Ct0f8sEBTBVlMOmyi5nrjM02Ds1mPtyqXZmtrxoMLt7hRBwxps9obrWrbfFZ8bB73c
         8FUipJYVO2ZJHQA4Ahbo9e26u2EBlruc2Gd+vh/nAFEJBefmTDPpk8gcIGGdzK7/QnKe
         k9hS1JkbsRvCWxlX+P3U2+eRTZRtiVhlBXpXIjHsebmbRV+Px02AWfUeVq4sMr67Ep1O
         QAPWpnzxyi8K2wO5jqaNCTHcp+QuSvu9O+VldLB/tDEGSHlORCwlOFSNl9i/cUcrozNe
         aa7KZwJbVQYc5mimU1kmH3iu3j2Xrtc7d2Q+4DoSHl4RqnlbjwJf8wc2LYHWaJ/nMeCH
         Aytg==
X-Gm-Message-State: AJIora/BDFCbdl8DYEpf6c3DotWzfomSXbP9fh6dp34Qq2f074iqz5iK
        KvM1yyA7NsyihxzeJtzCwGXF89TWkRXMyLkN
X-Google-Smtp-Source: AGRyM1uW/hpG471gFnWfhqykAOBM2PxntklXAEuVs5vWHo0v4iZ+U9Wq6bNMYhzxZPnUYeFraSTtJT2ss7zsDtn6
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:148d:b0:52b:946:67d2 with SMTP
 id v13-20020a056a00148d00b0052b094667d2mr1343737pfu.31.1658455997982; Thu, 21
 Jul 2022 19:13:17 -0700 (PDT)
Date:   Fri, 22 Jul 2022 02:13:06 +0000
In-Reply-To: <20220722021313.3150035-1-yosryahmed@google.com>
Message-Id: <20220722021313.3150035-2-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220722021313.3150035-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH bpf-next v4 1/8] btf: Add a new kfunc set which allows to mark
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index 1bfed7fa0428..6e7517573d9e 100644
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
index 5869f03bcb6e..2040e440f347 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6178,7 +6178,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 	struct bpf_verifier_log *log = &env->log;
 	u32 i, nargs, ref_id, ref_obj_id = 0;
 	bool is_kfunc = btf_is_kernel(btf);
-	bool rel = false, kptr_get = false;
+	bool rel = false, kptr_get = false, sleepable = false;
 	const char *func_name, *ref_tname;
 	const struct btf_type *t, *ref_t;
 	const struct btf_param *args;
@@ -6209,11 +6209,13 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
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
@@ -6411,6 +6413,13 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
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
2.37.1.359.gd136c6c3e2-goog

