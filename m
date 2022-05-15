Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B1C527501
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 04:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbiEOCfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 22:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbiEOCfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 22:35:17 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD226BF44
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 19:35:15 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id h128-20020a636c86000000b003c574b3422aso5673542pgc.12
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 19:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EUwJph95+QtgVEYpOk4h8MUmP3EN23IIGoIBGE07ovI=;
        b=PDZGlc0QzpODkc7dmkDeYxiYCZPbcORZBrrzUTn6k3D3SZY7PbQm0ZXd2IW+sOUcbS
         Xo/fMyFUqZ1MfPE7KjvD1HFOoKFRkYUHKAVvf1VIFlKP8N7bWGPWYWNRzEnXgpO2PIDH
         808VikSXzNhMH2ZaMUaHgFvbK6M6E+3CmGXWQ/tFRAUGdnThnx5OCM8tB0SDrpb5/K4M
         x0t6mUWNAKdmuRFlk6RTn9mfd5kqItz7GI+N7IBtsJPOKuErr9wiCmXd9ZHUnDVq8d/+
         QwUnKS3979H8Oq+Ejg40FwzfS7cnE1rESwD7zLfGGgUTKx3KVKQ81Nou3l0sEKcUR/hP
         jJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EUwJph95+QtgVEYpOk4h8MUmP3EN23IIGoIBGE07ovI=;
        b=PWBTH1N0RrLr29p0oJLp2qgVfyu3URx790RDcILwonWtPB8UqQHo8rn7OwyFYn31bO
         Cizjhgw53wIla79cTjp6+nulnPIMM4urn5Oh+8BZpVCaK1d3N4/kvn2vy9EATuXBoRnf
         j/RGbPKLww1+nrOCUT3rjKZzW6ptrVN4ahrRc1fPohjPd/gbpS8JP31p2WcYiag/dpRb
         m4mwkgcbvXUDnwq8FNapMXREO8+eXcqKeVmY1CZrPHnJ9rVr4nVdADv1KY3CMB0qhT7h
         GWXIRu4uZhMc39CBVfkb9Mj8s7rj/BduzUpUuPon2X+c4rNhMotWDUGaljELF1g5PgwT
         OHJQ==
X-Gm-Message-State: AOAM5325CirmbZgdRq8SxF7vu5gLj794B3Jaa4g2SmFvTNFHnBS1v9Su
        vcehf9t5MM/PO+e1MeLQ+AslahGE3sp/wKD/
X-Google-Smtp-Source: ABdhPJxpZk5O5QDsqL4It6DfSPP6K34f7RSXPFA0LdFKnqShsjpeMiKJiB90w0mBU56w5Imn8xwExWVTVLuT8NEI
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:903:2348:b0:15f:2b4a:29c2 with SMTP
 id c8-20020a170903234800b0015f2b4a29c2mr11740589plh.37.1652582115174; Sat, 14
 May 2022 19:35:15 -0700 (PDT)
Date:   Sun, 15 May 2022 02:34:59 +0000
In-Reply-To: <20220515023504.1823463-1-yosryahmed@google.com>
Message-Id: <20220515023504.1823463-3-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220515023504.1823463-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [RFC PATCH bpf-next v2 2/7] cgroup: bpf: flush bpf stats on rstat flush
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Stanislav Fomichev <sdf@google.com>,
        David Rientjes <rientjes@google.com>,
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

When an rstat flush is ongoing for a cgroup, also flush bpf stats by
running any attached rstat flush programs.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/bpf-rstat.h |  6 ++++++
 kernel/bpf/rstat.c        | 21 +++++++++++++++++++++
 kernel/cgroup/rstat.c     |  2 ++
 3 files changed, 29 insertions(+)

diff --git a/include/linux/bpf-rstat.h b/include/linux/bpf-rstat.h
index 23cad23b5fc2..55e000fe0f47 100644
--- a/include/linux/bpf-rstat.h
+++ b/include/linux/bpf-rstat.h
@@ -12,6 +12,8 @@
 int bpf_rstat_link_attach(const union bpf_attr *attr,
 				 struct bpf_prog *prog);
 
+void bpf_rstat_flush(struct cgroup *cgrp, int cpu);
+
 #else /* defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_CGROUPS) */
 
 static inline int bpf_rstat_link_attach(const union bpf_attr *attr,
@@ -20,6 +22,10 @@ static inline int bpf_rstat_link_attach(const union bpf_attr *attr,
 	return -ENOTSUPP;
 }
 
+static inline void bpf_rstat_flush(struct cgroup *cgrp, int cpu)
+{
+}
+
 #endif /* defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_CGROUPS) */
 
 #endif  /* _BPF_RSTAT */
diff --git a/kernel/bpf/rstat.c b/kernel/bpf/rstat.c
index 5f529002d4b9..e96bc080f4b9 100644
--- a/kernel/bpf/rstat.c
+++ b/kernel/bpf/rstat.c
@@ -164,3 +164,24 @@ int bpf_rstat_link_attach(const union bpf_attr *attr,
 
 	return bpf_link_settle(&link_primer);
 }
+
+void bpf_rstat_flush(struct cgroup *cgrp, int cpu)
+{
+	struct bpf_rstat_flusher *flusher;
+	struct bpf_rstat_flush_ctx ctx = {
+		.cgrp = cgrp,
+		.parent = cgroup_parent(cgrp),
+		.cpu = cpu,
+	};
+
+	rcu_read_lock();
+	migrate_disable();
+	spin_lock(&bpf_rstat_flushers_lock);
+
+	list_for_each_entry(flusher, &bpf_rstat_flushers, list)
+		(void) bpf_prog_run(flusher->prog, &ctx);
+
+	spin_unlock(&bpf_rstat_flushers_lock);
+	migrate_enable();
+	rcu_read_unlock();
+}
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 24b5c2ab5598..0285d496e807 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -2,6 +2,7 @@
 #include "cgroup-internal.h"
 
 #include <linux/sched/cputime.h>
+#include <linux/bpf-rstat.h>
 
 static DEFINE_SPINLOCK(cgroup_rstat_lock);
 static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
@@ -168,6 +169,7 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp, bool may_sleep)
 			struct cgroup_subsys_state *css;
 
 			cgroup_base_stat_flush(pos, cpu);
+			bpf_rstat_flush(pos, cpu);
 
 			rcu_read_lock();
 			list_for_each_entry_rcu(css, &pos->rstat_css_list,
-- 
2.36.0.550.gb090851708-goog

