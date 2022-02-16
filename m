Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F454B8726
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbiBPLxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:53:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbiBPLxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:53:06 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB751BA327
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:52:50 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 132so1938876pga.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=35RlTAsUx3yejoEebytGRZ97Bh68Tl3UTQMeyrDekNI=;
        b=moRystZEHt66uvzmqSShBkGW+R2V6RH38qwB8xS4uNWWO9+kZx/5LLX6Q70OvVONti
         vslfKpv5q4ggM2+6oYPcXECgDEeMDjLXaqiXEnvyMCkcwWQs9TrQFf0yqliG+xu3h/G7
         i/hpaJyUaAeN0zFzNJDRgtYG4oGSUW5MdPaJbpXYanP90+ohvdiR23D7bLCjoo/gdSAV
         BYB8GOnTlqICbtj6kyQnFfTDwm/9MnySMsLHwOa69XQLlBg6Eo6JwezYXMMjcNiajB5i
         jOTxdvt5LXbumEnI8vA5mahfALOtx9DnYod3Je86BPoFIdqglsjq87OTSdlzYmv1P4Ea
         F8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=35RlTAsUx3yejoEebytGRZ97Bh68Tl3UTQMeyrDekNI=;
        b=PojK9nPGuzwolX26PjVRgWMZZ+hamFJ9pT8dFoMl6D/kpiwAz5eiy9qwWi6oEZpDyE
         SCaSVWKT+u/2aW1Fjq5RWY5anzo5SvCujiD77nMYaJq3KeVzVTRrkyWBaZEOHlAmYZOt
         5MmlBN+fNZD2v3QvKjuz2O29HB09t5n7ITyQRNMr4fmyYIAE5Z0MvvbQiVRYntbKiOcl
         zTn4nVYpRr/MVYmPCRwTh7Wsa/xs3bzINUTa80uwrU6N6LSXQtuFkN2WAv5vXsv1Qlkn
         rIlgUsF0sC2qFcNKdGWv1fo1itqfw/KfHQvu76XqbEB3cvB6hzY/G2vCyLUcZCInQ+Bw
         IrEQ==
X-Gm-Message-State: AOAM530bY8EHU+jjaV3ifGgKm6p8fpxronX1som4kxrEk5QU/jZRVzVN
        1Q3d4emg6kJnpp+Z8GTXsPcOfw==
X-Google-Smtp-Source: ABdhPJwvmMrCkqNlkgisvdhcfgXRCaZkt9on70NqNBs9//l0VrAzUX8Dbh/M/8lvPW2VFtZFdTuf6g==
X-Received: by 2002:a63:5f97:0:b0:372:f7dc:6cf6 with SMTP id t145-20020a635f97000000b00372f7dc6cf6mr1949242pgb.315.1645012369596;
        Wed, 16 Feb 2022 03:52:49 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id m16sm14790221pfc.156.2022.02.16.03.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 03:52:49 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 08/12] mm: memcontrol: introduce memcg_reparent_ops
Date:   Wed, 16 Feb 2022 19:51:28 +0800
Message-Id: <20220216115132.52602-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220216115132.52602-1-songmuchun@bytedance.com>
References: <20220216115132.52602-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the previous patch, we know how to make the lruvec lock safe when LRU
pages are reparented. We should do something like following.

    memcg_reparent_objcgs(memcg)
        1) lock
        // lruvec belongs to memcg and lruvec_parent belongs to parent memcg.
        spin_lock(&lruvec->lru_lock);
        spin_lock(&lruvec_parent->lru_lock);

        2) do reparent
        // Move all the pages from the lruvec list to the parent lruvec list.

        3) unlock
        spin_unlock(&lruvec_parent->lru_lock);
        spin_unlock(&lruvec->lru_lock);

Apart from the page lruvec lock, the deferred split queue lock (THP only)
also needs to do something similar. So we extract the necessary three steps
in the memcg_reparent_objcgs().

    memcg_reparent_objcgs(memcg)
        1) lock
        memcg_reparent_ops->lock(memcg, parent);

        2) reparent
        memcg_reparent_ops->reparent(memcg, reparent);

        3) unlock
        memcg_reparent_ops->unlock(memcg, reparent);

Now there are two different locks (e.g. lruvec lock and deferred split
queue lock) need to use this infrastructure. In the next patch, we will
use those APIs to make those locks safe when the LRU pages reparented.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h |  7 +++++++
 mm/memcontrol.c            | 39 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 6e0f7104f2fa..3c841c155f0d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -346,6 +346,13 @@ struct mem_cgroup {
 	struct mem_cgroup_per_node *nodeinfo[];
 };
 
+struct memcg_reparent_ops {
+	/* Irq is disabled before calling those callbacks. */
+	void (*lock)(struct mem_cgroup *memcg, struct mem_cgroup *parent);
+	void (*unlock)(struct mem_cgroup *memcg, struct mem_cgroup *parent);
+	void (*reparent)(struct mem_cgroup *memcg, struct mem_cgroup *parent);
+};
+
 /*
  * size of first charge trial. "32" comes from vmscan.c's magic value.
  * TODO: maybe necessary to use big numbers in big irons.
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index dd2602149ef3..6a393fe8e589 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -336,6 +336,35 @@ static struct obj_cgroup *obj_cgroup_alloc(void)
 	return objcg;
 }
 
+static const struct memcg_reparent_ops *memcg_reparent_ops[] = {};
+
+static void memcg_reparent_lock(struct mem_cgroup *memcg,
+				struct mem_cgroup *parent)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(memcg_reparent_ops); i++)
+		memcg_reparent_ops[i]->lock(memcg, parent);
+}
+
+static void memcg_reparent_unlock(struct mem_cgroup *memcg,
+				  struct mem_cgroup *parent)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(memcg_reparent_ops); i++)
+		memcg_reparent_ops[i]->unlock(memcg, parent);
+}
+
+static void memcg_do_reparent(struct mem_cgroup *memcg,
+			      struct mem_cgroup *parent)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(memcg_reparent_ops); i++)
+		memcg_reparent_ops[i]->reparent(memcg, parent);
+}
+
 static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
 {
 	struct obj_cgroup *objcg, *iter;
@@ -345,9 +374,11 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
 	if (!parent)
 		parent = root_mem_cgroup;
 
+	local_irq_disable();
+	memcg_reparent_lock(memcg, parent);
 	objcg = rcu_replace_pointer(memcg->objcg, NULL, true);
 
-	spin_lock_irq(&objcg_lock);
+	spin_lock(&objcg_lock);
 
 	/* 1) Ready to reparent active objcg. */
 	list_add(&objcg->list, &memcg->objcg_list);
@@ -357,7 +388,11 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
 	/* 3) Move already reparented objcgs to the parent's list */
 	list_splice(&memcg->objcg_list, &parent->objcg_list);
 
-	spin_unlock_irq(&objcg_lock);
+	spin_unlock(&objcg_lock);
+
+	memcg_do_reparent(memcg, parent);
+	memcg_reparent_unlock(memcg, parent);
+	local_irq_enable();
 
 	percpu_ref_kill(&objcg->refcnt);
 }
-- 
2.11.0

