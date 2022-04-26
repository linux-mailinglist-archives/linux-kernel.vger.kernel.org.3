Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5024C50F165
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237134AbiDZGrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiDZGq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:46:57 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602FD12C8D9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:43:47 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 17so20687345lji.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=K2d011P8KfcYwwiHkCEUfdA6HfAgaJe5w6mALwX0ubY=;
        b=ucopxF9WfhVVHWRqZ21ScpWY3F6vUeftNTSf7toMamrheU0OxvUcaaprhBe62s1n6f
         BqKhFXXKeG3P27w76cKmJ8S58bNyKrj9iB9MutS65aXrnRUDQMPgtk78QOqLaxKTJVgg
         jCElShjmCrninAIOEh0HkazA1QytgiAb3/ylLwDsMCfpHdwPWpdK0wu0EU0WuHnGAX7b
         VzyQpskFimFQ/P20V1oMC+fOFshJ0YgCRkk9wO4Pom6O40sGavzvkSe9J3DVn4mNIHZY
         IODiJtXsb8FzKtweUwAVQcyz7029ke5hIhdXaVinNFcaRH2JaEm9psZ2+oq9F+Momo7a
         kwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=K2d011P8KfcYwwiHkCEUfdA6HfAgaJe5w6mALwX0ubY=;
        b=1u+2ExeV/wy0erdgity68oj5wIbZbqcf9D9wwy0aAASjeNu4YOuGeSOKH85vsgx+xl
         deCMojfmR+4fwvaTd6kGGv39dQqSPTE2gHiYO7FNSlyqlaj3E3jXQ2yM2/MaJLd3LvrS
         LH84rSCL/729jf2ZQfjyPgniBvLvvC++16Cl9zwRb0/m/Uqs5JCWRPo+7IbBbiyeO0kY
         kwIzhJwBaW3Sve9xdTCRkBpLbYDDsHh7gUgLfCMCBAkLD1Y3Jkt8WQAWKHCsBQTxKRK5
         7h86xAV5jMitHLGQCFlwe9upybE6gDdlkIfwpXUxfghNjH6AGzH+qlIIDp58z9asbbh5
         QXIw==
X-Gm-Message-State: AOAM533Luue3EtBl7gqAKu/CaDXKP8ci15x4ZargLtB/Y7oCTDqeu/zA
        1dbpXQ2yiH7JMoPX1JI8TMy9Vg==
X-Google-Smtp-Source: ABdhPJznIC2XojKpJb8/wZGwLoRVgWv80lsRGUWtGqO/JnjNZLgQaaSAeJcnhhe6K6hFnk0cPct93Q==
X-Received: by 2002:a2e:a235:0:b0:24f:1209:fcbf with SMTP id i21-20020a2ea235000000b0024f1209fcbfmr5265271ljm.313.1650955425082;
        Mon, 25 Apr 2022 23:43:45 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id t9-20020a2e5349000000b00247e931bd67sm1402338ljd.9.2022.04.25.23.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 23:43:44 -0700 (PDT)
Message-ID: <33085523-a8b9-1bf6-2726-f456f59015ef@openvz.org>
Date:   Tue, 26 Apr 2022 09:43:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH memcg v4] net: set proper memcg for net_init hooks allocations
To:     Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     kernel@openvz.org, Florian Westphal <fw@strlen.de>,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        cgroups@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <YmdeCqi6wmgiSiWh@carbon>
Content-Language: en-US
In-Reply-To: <YmdeCqi6wmgiSiWh@carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__register_pernet_operations() executes init hook of registered
pernet_operation structure in all existing net namespaces.

Typically, these hooks are called by a process associated with
the specified net namespace, and all __GFP_ACCOUNT marked
allocation are accounted for corresponding container/memcg.

However __register_pernet_operations() calls the hooks in the same
context, and as a result all marked allocations are accounted
to one memcg for all processed net namespaces.

This patch adjusts active memcg for each net namespace and helps
to account memory allocated inside ops_init() into the proper memcg.

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
v4: get_mem_cgroup_from_kmem() renamed to get_mem_cgroup_from_obj(),
    get_net_memcg() replaced by mem_cgroup_or_root(), suggested by Roman.

v3: put_net_memcg() replaced by an alreay existing mem_cgroup_put()
    It checks memcg before accessing it, this is required for
    __register_pernet_operations() called before memcg initialization.
    Additionally fixed leading whitespaces in non-memcg_kmem version
    of mem_cgroup_from_obj().

v2: introduced get/put_net_memcg(),
    new functions are moved under CONFIG_MEMCG_KMEM
    to fix compilation issues reported by Intel's kernel test robot

v1: introduced get_mem_cgroup_from_kmem(), which takes the refcount
    for the found memcg, suggested by Shakeel
---
 include/linux/memcontrol.h | 27 ++++++++++++++++++++++++++-
 net/core/net_namespace.c   |  7 +++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0abbd685703b..6dd4ed7d3b6f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1714,6 +1714,22 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
 
 struct mem_cgroup *mem_cgroup_from_obj(void *p);
 
+static inline struct mem_cgroup *get_mem_cgroup_from_obj(void *p)
+{
+	struct mem_cgroup *memcg;
+
+	rcu_read_lock();
+	do {
+		memcg = mem_cgroup_from_obj(p);
+	} while (memcg && !css_tryget(&memcg->css));
+	rcu_read_unlock();
+	return memcg;
+}
+
+static inline struct mem_cgroup *mem_cgroup_or_root(struct mem_cgroup *memcg)
+{
+	return memcg ? memcg : root_mem_cgroup;
+}
 #else
 static inline bool mem_cgroup_kmem_disabled(void)
 {
@@ -1763,9 +1779,18 @@ static inline void memcg_put_cache_ids(void)
 
 static inline struct mem_cgroup *mem_cgroup_from_obj(void *p)
 {
-       return NULL;
+	return NULL;
 }
 
+static inline struct mem_cgroup *get_mem_cgroup_from_obj(void *p)
+{
+	return NULL;
+}
+
+static inline struct mem_cgroup *mem_cgroup_or_root(struct mem_cgroup *memcg)
+{
+	return NULL;
+}
 #endif /* CONFIG_MEMCG_KMEM */
 
 #endif /* _LINUX_MEMCONTROL_H */
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index a5b5bb99c644..240f3db77dec 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -26,6 +26,7 @@
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
 
+#include <linux/sched/mm.h>
 /*
  *	Our network namespace constructor/destructor lists
  */
@@ -1147,7 +1148,13 @@ static int __register_pernet_operations(struct list_head *list,
 		 * setup_net() and cleanup_net() are not possible.
 		 */
 		for_each_net(net) {
+			struct mem_cgroup *old, *memcg;
+
+			memcg = mem_cgroup_or_root(get_mem_cgroup_from_obj(net));
+			old = set_active_memcg(memcg);
 			error = ops_init(ops, net);
+			set_active_memcg(old);
+			mem_cgroup_put(memcg);
 			if (error)
 				goto out_undo;
 			list_add_tail(&net->exit_list, &net_exit_list);
-- 
2.31.1

