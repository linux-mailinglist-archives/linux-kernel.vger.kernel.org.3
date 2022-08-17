Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CB3596A87
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 09:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbiHQHmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 03:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbiHQHmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 03:42:46 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D727578BE6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:42:43 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x19so17994184lfq.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc;
        bh=dmDwM4+5OvZV1GauuBzntIwBDo1honI/YS/wDc4oSBE=;
        b=a5aSBa9AQwHIl1KmNPaIctFcEkY+RhjpxaR1vWV+B4mc/ObP9jkbWDuOSHowh/tZEj
         zgv+2U/0Y0Bft3GytyPJgOnE19/xAx8aOi4hBXY6R0sVIwpgYsPFWVDBQqmfk+JVReUn
         4rWql28PFB/2X8mpBt3EU62xCuZReJfGxcqXHXXBVqZr+EZjTmtsyJuV/e46yW6aEhW7
         b/aRf+tEU7/3etbk3z7BwOp2oWsOc6e5b4atMR07Wvt17vqpiUM1P4HASRGDSUKZarfn
         /ObwYyZ173c/LaEC8I1XK4CYJHG2nPnZvFm6shFi+v6gQHoT7Dip4+ylQPHtO/ftrre0
         DDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=dmDwM4+5OvZV1GauuBzntIwBDo1honI/YS/wDc4oSBE=;
        b=Ned/tzXSRSe07FsKTiol4CYZmykgoRwG2LQEyFH47Fhw1M0vxAWj//CWB8pJwYHd0u
         LuPv0aoFQ59UUapyj+PILzUkbyAUYPqhxnfSsgX9exwcJeJGZCin3ovNZRZUqBtAfZAD
         quHYXpJaZIo4/vZ354jIp2l7MIgEmbNhAmEBRqwyChixp89hIi4BBXloMFxhkk6mI1KG
         S90uG69kQuL2E0maArFqPz7161XLMOdQKI+SoOrt2mKzNtKo5JQDjs9a+7PiRuz/xU7R
         3N/ibTJ2pWafFdq70DWFsx0SD2kJsdMduY/b6vYm0TnG5V6OZVqq+L/qY+VYZl8cPxoe
         2M5g==
X-Gm-Message-State: ACgBeo2tUCiolW53kFU3HOKegzm+Du+i+fIn5BHKbzkPuPiJ8JczT+DU
        7SWx9t5yhcPg5SiqGbo0Q9hEcg==
X-Google-Smtp-Source: AA6agR7pt31+Hzthr0ID/0HpvkbNf5zk9EbolykTiUriJX+mMXf9jNF0Jgl95gEzeQQ3Unq353KcyQ==
X-Received: by 2002:a05:6512:4009:b0:491:bdd9:eab1 with SMTP id br9-20020a056512400900b00491bdd9eab1mr6499296lfb.372.1660722162243;
        Wed, 17 Aug 2022 00:42:42 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.143])
        by smtp.gmail.com with ESMTPSA id p5-20020a05651238c500b0048a9e18ae67sm1605059lft.84.2022.08.17.00.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 00:42:41 -0700 (PDT)
Message-ID: <45a04b75-d61b-4c7a-7169-c971995a6049@openvz.org>
Date:   Wed, 17 Aug 2022 10:42:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Vasily Averin <vvs@openvz.org>
Subject: [RFC PATCH] memcg: adjust memcg for new cgroup allocations
To:     Roman Gushchin <roman.gushchin@linux.dev>, mkoutny@suse.com,
        tj@kernel.org
Cc:     gregkh@linuxfoundation.org, hannes@cmpxchg.org, kernel@openvz.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com, shakeelb@google.com,
        songmuchun@bytedance.com, viro@zeniv.linux.org.uk
References: <62188f37-f816-08e9-cdd5-8df23131746d@openvz.org>
Content-Language: en-US
In-Reply-To: <62188f37-f816-08e9-cdd5-8df23131746d@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is first of patches announced here:
https://lore.kernel.org/all/62188f37-f816-08e9-cdd5-8df23131746d@openvz.org/
---
Usually accounted allocations use memory cgroup of current process.
In case of cgroup this looks incorrect: memory cgroup can be created
both from the host and from inside container.  At the same time
it is intuitively expected that these both operations should lead
to the same result.
This issue was addressed by Roman Gushchin in commit 3e38e0aaca9e
"mm: memcg: charge memcg percpu memory to the parent cgroup",
He adjusted memcg for allocations called inside mem_cgroup_css_alloc.

However, now we want to enable accounting for some other cgroup-related
resources called from cgroup_mkdir. We would like to guarantee that
all new accounted allocation will be charged to the same memory cgroup.

This patch moves memcg adjustment from mem_cgroup_css_alloc() to its
callers: cgroup_mkdir() and cgroup_apply_control(). In own turn this
requires to create new proxy function mem_cgroup_from_cgroup().

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
 include/linux/memcontrol.h | 18 ++++++++++++++++++
 kernel/cgroup/cgroup.c     | 22 ++++++++++++++++------
 mm/memcontrol.c            |  4 +---
 3 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 4d31ce55b1c0..342426d1edbf 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1813,6 +1813,19 @@ static inline struct mem_cgroup *mem_cgroup_or_root(struct mem_cgroup *memcg)
 {
 	return memcg ? memcg : root_mem_cgroup;
 }
+
+static inline struct mem_cgroup *mem_cgroup_from_cgroup(struct cgroup *cgroup)
+{
+	struct cgroup_subsys_state *css;
+	struct mem_cgroup *memcg = NULL;
+
+	css = cgroup_get_e_css(cgroup, &memory_cgrp_subsys);
+
+	if (css)
+		memcg = container_of(css, struct mem_cgroup, css);
+
+	return mem_cgroup_or_root(memcg);
+}
 #else
 static inline bool mem_cgroup_kmem_disabled(void)
 {
@@ -1878,6 +1891,11 @@ static inline struct mem_cgroup *mem_cgroup_or_root(struct mem_cgroup *memcg)
 {
 	return NULL;
 }
+
+static inline struct mem_cgroup *mem_cgroup_from_cgroup(struct cgroup *cgroup)
+{
+	return NULL;
+}
 #endif /* CONFIG_MEMCG_KMEM */
 
 #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index ffaccd6373f1..544d93a8878f 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3247,13 +3247,16 @@ static void cgroup_apply_control_disable(struct cgroup *cgrp)
  */
 static int cgroup_apply_control(struct cgroup *cgrp)
 {
+	struct mem_cgroup *memcg, *old_memcg;
 	int ret;
 
 	cgroup_propagate_control(cgrp);
 
+	memcg = mem_cgroup_from_cgroup(cgrp);
+	old_memcg = set_active_memcg(memcg);
 	ret = cgroup_apply_control_enable(cgrp);
 	if (ret)
-		return ret;
+		goto out_memcg;
 
 	/*
 	 * At this point, cgroup_e_css_by_mask() results reflect the new csses
@@ -3261,10 +3264,11 @@ static int cgroup_apply_control(struct cgroup *cgrp)
 	 * css associations of all tasks in the subtree.
 	 */
 	ret = cgroup_update_dfl_csses(cgrp);
-	if (ret)
-		return ret;
 
-	return 0;
+out_memcg:
+	set_active_memcg(old_memcg);
+	mem_cgroup_put(memcg);
+	return ret;
 }
 
 /**
@@ -5532,6 +5536,7 @@ static bool cgroup_check_hierarchy_limits(struct cgroup *parent)
 int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
 {
 	struct cgroup *parent, *cgrp;
+	struct mem_cgroup *memcg, *old_memcg;
 	int ret;
 
 	/* do not accept '\n' to prevent making /proc/<pid>/cgroup unparsable */
@@ -5547,10 +5552,12 @@ int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
 		goto out_unlock;
 	}
 
+	memcg = mem_cgroup_from_cgroup(parent);
+	old_memcg = set_active_memcg(memcg);
 	cgrp = cgroup_create(parent, name, mode);
 	if (IS_ERR(cgrp)) {
 		ret = PTR_ERR(cgrp);
-		goto out_unlock;
+		goto out_memcg;
 	}
 
 	/*
@@ -5577,10 +5584,13 @@ int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
 	kernfs_activate(cgrp->kn);
 
 	ret = 0;
-	goto out_unlock;
+	goto out_memcg;
 
 out_destroy:
 	cgroup_destroy_locked(cgrp);
+out_memcg:
+	set_active_memcg(old_memcg);
+	mem_cgroup_put(memcg);
 out_unlock:
 	cgroup_kn_unlock(parent_kn);
 	return ret;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b69979c9ced5..e170c64e66e2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5239,11 +5239,9 @@ static struct cgroup_subsys_state * __ref
 mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 {
 	struct mem_cgroup *parent = mem_cgroup_from_css(parent_css);
-	struct mem_cgroup *memcg, *old_memcg;
+	struct mem_cgroup *memcg;
 
-	old_memcg = set_active_memcg(parent);
 	memcg = mem_cgroup_alloc();
-	set_active_memcg(old_memcg);
 	if (IS_ERR(memcg))
 		return ERR_CAST(memcg);
 
-- 
2.34.1

