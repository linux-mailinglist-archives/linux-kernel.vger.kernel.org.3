Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A351054DB65
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359081AbiFPHSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiFPHSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:18:44 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A0127CEE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 00:18:42 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y6so713181pfr.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 00:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H4e9BGem7ntj4V48ddkv1TwUkGsnWTwYSvEuYsGDj/I=;
        b=Ehq9jgzew7PWTXR9YaEfZ9s+8qzfq0q6/KDWpjuwe8CHu+WXBgLM8q9uEa9BmJQaJw
         efsK1Q9kSgh5r945wL5VUIPaFwMxjTe6b+Er59+M1dWg3QYSjGxj7VbFElegDtibZZQi
         CusXFQdZwsEeYTVQzn5bb6oC1+Gx881xCcre+PfPZ7eDSyMV3DaFcDnfVzpAfMkbORmP
         f+Mo7ue6VhEnUaF8MXNI39Ngze7awldglBludFUiLGbmV66Zx1EcAI4lsoApYzR8p5Pv
         vG4+bTF7qHUVPvIDCiRaYfs2QHBJ2/Ek8mOHvJoZiXzYabkeVxPIraOhzdwh6hnWBa1Q
         bwog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H4e9BGem7ntj4V48ddkv1TwUkGsnWTwYSvEuYsGDj/I=;
        b=n37V34y+h5HjSAoqAZgBsZCYP654+Iq3j4yDoLEnglnOyM1gzUlT2tg7h88f+Tg7BD
         GXda/JPIXZzrQgnNcgaEgd9nJtdQGNsYbdxo0ixQ0DmKU71qGfUhz0H8Ekrw8o9n9ncl
         pvgqCdX/BciBkKohnxhxS/ua2KHspOF+nNd+pk9mDEh14hVHcsKhGshjLmh5Zmhs5rrl
         vQDoMg+TrnONwAXQOdqKcnGWe4v6bTutL46YX0XEA/FnCic4/7s8Q45Pf1pRol7S26a+
         PRO3POa8yD0Vqpud1peN0O+cM+CbaXmwQfqZEa2796J3QB6ArG82SNWauMPN+SaPtM4O
         vlbw==
X-Gm-Message-State: AJIora/F0npXaUvnLiNCBj8k9RZNwiiENsmkPKOMEkHYbn2VDUy8xmfp
        YTjFX9dl1eD2grOCeqYEFeRbMg==
X-Google-Smtp-Source: AGRyM1uGkeuH9vhZrHTAk6OaypOOLp50WqGolbTqY7lTNmgffQwoydUdSedot5VJ0KkDdEO1KO9jnA==
X-Received: by 2002:a63:ed46:0:b0:3fe:2b89:cbf6 with SMTP id m6-20020a63ed46000000b003fe2b89cbf6mr3201720pgk.112.1655363922321;
        Thu, 16 Jun 2022 00:18:42 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id y3-20020a170902d64300b001674d61c1c6sm859170plh.272.2022.06.16.00.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 00:18:41 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, songmuchun@bytedance.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: hugetlb: rework hugetlb cmdline parsing
Date:   Thu, 16 Jun 2022 15:18:27 +0800
Message-Id: <20220616071827.3480-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I often get lost in the logic interleaved between numerous global
variables for parsing cmdline.  It is not easy to be maintained.
This patch aims to rework cmdline parsing to simlify the code and
make the code more readable.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/hugetlb.h |   1 -
 mm/hugetlb.c            | 499 ++++++++++++++++++++----------------------------
 2 files changed, 206 insertions(+), 294 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 642a39016f9a..aab2ef3a054d 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -636,7 +636,6 @@ struct hstate {
 	unsigned long nr_overcommit_huge_pages;
 	struct list_head hugepage_activelist;
 	struct list_head hugepage_freelists[MAX_NUMNODES];
-	unsigned int max_huge_pages_node[MAX_NUMNODES];
 	unsigned int nr_huge_pages_node[MAX_NUMNODES];
 	unsigned int free_huge_pages_node[MAX_NUMNODES];
 	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 98492733cc64..0d3c1ae58107 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -37,6 +37,7 @@
 #include <asm/page.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
+#include <asm/setup.h>
 
 #include <linux/io.h>
 #include <linux/hugetlb.h>
@@ -47,7 +48,7 @@
 #include "hugetlb_vmemmap.h"
 
 int hugetlb_max_hstate __read_mostly;
-unsigned int default_hstate_idx;
+unsigned int default_hstate_idx = HUGE_MAX_HSTATE;
 struct hstate hstates[HUGE_MAX_HSTATE];
 
 #ifdef CONFIG_CMA
@@ -68,13 +69,6 @@ static unsigned long hugetlb_cma_size __initdata;
 
 __initdata LIST_HEAD(huge_boot_pages);
 
-/* for command line parsing */
-static struct hstate * __initdata parsed_hstate;
-static unsigned long __initdata default_hstate_max_huge_pages;
-static bool __initdata parsed_valid_hugepagesz = true;
-static bool __initdata parsed_default_hugepagesz;
-static unsigned int default_hugepages_in_node[MAX_NUMNODES] __initdata;
-
 /*
  * Protects updates to hugepage_freelists, hugepage_activelist, nr_huge_pages,
  * free_huge_pages, and surplus_huge_pages.
@@ -3026,6 +3020,146 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
 	return 1;
 }
 
+struct hugetlb_one_arg {
+	unsigned long hugepagesz;
+	unsigned long hugepages;
+	unsigned long hugepages_node[MAX_NUMNODES];
+};
+
+struct hugetlb_args {
+	unsigned int		nr_arg;
+	struct hugetlb_one_arg	args[HUGE_MAX_HSTATE];
+};
+
+static struct hugetlb_args hugetlb_args __initdata;
+
+static unsigned long __init hugetlb_parse_hugepagesz(const char *param,
+						     const char *val)
+{
+	unsigned long size;
+
+	size = memparse(val, NULL);
+	if (!arch_hugetlb_valid_size(size)) {
+		pr_err("HugeTLB: %s=%s is unsupported\n", param, val);
+		return 0;
+	}
+	hugetlb_add_hstate(ilog2(size) - PAGE_SHIFT);
+	return size;
+}
+
+static int __init hugetlb_process_arg(char *param, char *val,
+				      const char *unused, void *priv)
+{
+	struct hugetlb_args *args = priv;
+	struct hugetlb_one_arg *arg = &args->args[args->nr_arg];
+
+	if (!val)
+		return 0;
+
+	if (!strcmp(param, "hugepagesz")) {
+		unsigned long size = hugetlb_parse_hugepagesz(param, val);
+
+		/*
+		 * "ULONG_MAX" means the next parameter "hugepages" should be
+		 * ignored.
+		 */
+		size = size ? : ULONG_MAX;
+
+		/* Lookup "hugepagesz" whether if we have specified before. */
+		if (size != ULONG_MAX) {
+			int i;
+
+			for (i = 0; i < args->nr_arg; i++) {
+				if (args->args[i].hugepagesz == size ||
+				    (!args->args[i].hugepagesz && size == HPAGE_SIZE)) {
+					pr_warn("HugeTLB: %s=%s is ignored\n", param, val);
+					size = ULONG_MAX;
+					break;
+				}
+			}
+		}
+		arg->hugepagesz = size;
+	} else if (!strcmp(param, "default_hugepagesz")) {
+		unsigned long size = hugetlb_parse_hugepagesz(param, val);
+
+		if (size == 0)
+			return 0;
+
+		if (default_hstate_idx != HUGE_MAX_HSTATE) {
+			pr_err("HugeTLB: %s=%s is ignored\n", param, val);
+		} else {
+			default_hstate_idx = hstate_index(size_to_hstate(size));
+
+			/*
+			 * Update ->hugepagesz if the first "hugepages" is
+			 * followed by "default_hugepagesz".
+			 */
+			if (args->args[0].hugepagesz == 0)
+				args->args[0].hugepagesz = size;
+		}
+	} else if (!strcmp(param, "hugepages")) {
+		int node;
+		const char *p = val;
+
+		/*
+		 * There are two cases which need to be ignored.
+		 *
+		 * 1) The previous "hugepagesz" is invalid.
+		 * 2) Lack of "hugepagesz" which matches with "hugepages" except
+		 *    the first "hugepages".
+		 */
+		if (arg->hugepagesz == ULONG_MAX ||
+		    (arg->hugepagesz == 0 && args->nr_arg != 0)) {
+			pr_warn("HugeTLB: %s=%s is ignored\n", param, val);
+			return 0;
+		}
+
+		while (*p) {
+			int count = 0;
+			unsigned long tmp;
+
+			if (sscanf(p, "%lu%n", &tmp, &count) != 1)
+				goto invalid;
+
+			/* Parameter is node format */
+			if (p[count] == ':') {
+				if (!hugetlb_node_alloc_supported()) {
+					pr_warn("HugeTLB: architecture can't support node specific alloc, ignoring!\n");
+					return 0;
+				}
+				if (tmp >= MAX_NUMNODES || !node_online(tmp))
+					goto invalid;
+				node = array_index_nospec(tmp, MAX_NUMNODES);
+				p += count + 1;
+				/* Parse hugepages */
+				if (sscanf(p, "%lu%n", &tmp, &count) != 1)
+					goto invalid;
+				arg->hugepages_node[node] = tmp;
+				arg->hugepages += tmp;
+				/* Go to parse next node*/
+				if (p[count] == ',')
+					p += count + 1;
+				else
+					break;
+			} else {
+				if (p != val)
+					goto invalid;
+				arg->hugepages = tmp;
+				break;
+			}
+		}
+		args->nr_arg++;
+		return 0;
+invalid:
+		for_each_node(node)
+			arg->hugepages_node[node] = 0;
+		arg->hugepages = 0;
+		pr_warn("HugeTLB: %s=%s is ignored\n", param, val);
+	}
+
+	return 0;
+}
+
 /*
  * Put bootmem huge pages into the standard lists after mem_map is up.
  * Note: This only applies to gigantic (order > MAX_ORDER) pages.
@@ -3058,12 +3192,13 @@ static void __init gather_bootmem_prealloc(void)
 		cond_resched();
 	}
 }
-static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
+static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid,
+						      struct hugetlb_one_arg *arg)
 {
 	unsigned long i;
 	char buf[32];
 
-	for (i = 0; i < h->max_huge_pages_node[nid]; ++i) {
+	for (i = 0; i < arg->hugepages_node[nid]; ++i) {
 		if (hstate_is_gigantic(h)) {
 			if (!alloc_bootmem_huge_page(h, nid))
 				break;
@@ -3079,32 +3214,33 @@ static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
 		}
 		cond_resched();
 	}
-	if (i == h->max_huge_pages_node[nid])
+	h->max_huge_pages += i;
+	if (i == arg->hugepages_node[nid])
 		return;
 
 	string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
-	pr_warn("HugeTLB: allocating %u of page size %s failed node%d.  Only allocated %lu hugepages.\n",
-		h->max_huge_pages_node[nid], buf, nid, i);
-	h->max_huge_pages -= (h->max_huge_pages_node[nid] - i);
-	h->max_huge_pages_node[nid] = i;
+	pr_warn("HugeTLB: allocating %lu of page size %s failed node%d.  Only allocated %lu hugepages.\n",
+		arg->hugepages_node[nid], buf, nid, i);
 }
 
-static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
+static void __init hugetlb_hstate_alloc_pages(struct hstate *h,
+					      struct hugetlb_one_arg *arg)
 {
 	unsigned long i;
-	nodemask_t *node_alloc_noretry;
+	nodemask_t node_alloc_noretry = NODE_MASK_NONE;
 	bool node_specific_alloc = false;
 
 	/* skip gigantic hugepages allocation if hugetlb_cma enabled */
 	if (hstate_is_gigantic(h) && hugetlb_cma_size) {
+		h->max_huge_pages = arg->hugepages;
 		pr_warn_once("HugeTLB: hugetlb_cma is enabled, skip boot time allocation\n");
 		return;
 	}
 
 	/* do node specific alloc */
 	for_each_online_node(i) {
-		if (h->max_huge_pages_node[i] > 0) {
-			hugetlb_hstate_alloc_pages_onenode(h, i);
+		if (arg->hugepages_node[i] > 0) {
+			hugetlb_hstate_alloc_pages_onenode(h, i, arg);
 			node_specific_alloc = true;
 		}
 	}
@@ -3112,55 +3248,75 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 	if (node_specific_alloc)
 		return;
 
-	/* below will do all node balanced alloc */
-	if (!hstate_is_gigantic(h)) {
-		/*
-		 * Bit mask controlling how hard we retry per-node allocations.
-		 * Ignore errors as lower level routines can deal with
-		 * node_alloc_noretry == NULL.  If this kmalloc fails at boot
-		 * time, we are likely in bigger trouble.
-		 */
-		node_alloc_noretry = kmalloc(sizeof(*node_alloc_noretry),
-						GFP_KERNEL);
-	} else {
-		/* allocations done at boot time */
-		node_alloc_noretry = NULL;
-	}
-
-	/* bit mask controlling how hard we retry per-node allocations */
-	if (node_alloc_noretry)
-		nodes_clear(*node_alloc_noretry);
-
-	for (i = 0; i < h->max_huge_pages; ++i) {
+	for (i = 0; i < arg->hugepages; ++i) {
 		if (hstate_is_gigantic(h)) {
 			if (!alloc_bootmem_huge_page(h, NUMA_NO_NODE))
 				break;
 		} else if (!alloc_pool_huge_page(h,
 					 &node_states[N_MEMORY],
-					 node_alloc_noretry))
+					 &node_alloc_noretry))
 			break;
 		cond_resched();
 	}
-	if (i < h->max_huge_pages) {
+	h->max_huge_pages = i;
+	if (i < arg->hugepages) {
 		char buf[32];
 
 		string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
 		pr_warn("HugeTLB: allocating %lu of page size %s failed.  Only allocated %lu hugepages.\n",
-			h->max_huge_pages, buf, i);
-		h->max_huge_pages = i;
+			arg->hugepages, buf, i);
+	}
+}
+
+static void __init hugetlb_prealloc(bool gigantic)
+{
+	int i;
+
+	for (i = 0; i < hugetlb_args.nr_arg; i++) {
+		struct hstate *h;
+		struct hugetlb_one_arg *arg;
+
+		arg = &hugetlb_args.args[i];
+		if (arg->hugepagesz == 0) {
+			arg->hugepagesz = HPAGE_SIZE;
+			default_hstate_idx = hstate_index(size_to_hstate(HPAGE_SIZE));
+		}
+		h = size_to_hstate(arg->hugepagesz);
+		if (hstate_is_gigantic(h) == gigantic)
+			hugetlb_hstate_alloc_pages(h, arg);
 	}
-	kfree(node_alloc_noretry);
 }
 
+static int __init hugetlb_cmdline_parse(char *s)
+{
+	static bool parsed __initdata;
+	static char cmdline[COMMAND_LINE_SIZE] __initdata;
+
+	if (!hugepages_supported() || parsed)
+		return 1;
+	/*
+	 * Make sure HPAGE_SIZE (HUGETLB_PAGE_ORDER) hstate exists.  Some
+	 * architectures depend on setup being done here.
+	 */
+	hugetlb_add_hstate(HUGETLB_PAGE_ORDER);
+
+	strscpy(cmdline, boot_command_line, COMMAND_LINE_SIZE);
+	parse_args("HugeTLB options", cmdline, NULL, 0, 0, 0, &hugetlb_args,
+		   hugetlb_process_arg);
+	hugetlb_prealloc(true);
+	parsed = true;
+
+	return 1;
+}
+__setup_param("hugepages", hugepages, hugetlb_cmdline_parse, 0);
+__setup_param("hugepagesz", hugepagesz, hugetlb_cmdline_parse, 0);
+__setup_param("default_hugepagesz", default_hugepagesz, hugetlb_cmdline_parse, 0);
+
 static void __init hugetlb_init_hstates(void)
 {
 	struct hstate *h, *h2;
 
 	for_each_hstate(h) {
-		/* oversize hugepages were init'ed in early boot */
-		if (!hstate_is_gigantic(h))
-			hugetlb_hstate_alloc_pages(h);
-
 		/*
 		 * Set demote order for each hstate.  Note that
 		 * h->demote_order is initially 0.
@@ -4027,48 +4183,11 @@ static int __init hugetlb_init(void)
 	BUILD_BUG_ON(sizeof_field(struct page, private) * BITS_PER_BYTE <
 			__NR_HPAGEFLAGS);
 
-	if (!hugepages_supported()) {
-		if (hugetlb_max_hstate || default_hstate_max_huge_pages)
-			pr_warn("HugeTLB: huge pages not supported, ignoring associated command-line parameters\n");
+	if (!hugepages_supported())
 		return 0;
-	}
-
-	/*
-	 * Make sure HPAGE_SIZE (HUGETLB_PAGE_ORDER) hstate exists.  Some
-	 * architectures depend on setup being done here.
-	 */
-	hugetlb_add_hstate(HUGETLB_PAGE_ORDER);
-	if (!parsed_default_hugepagesz) {
-		/*
-		 * If we did not parse a default huge page size, set
-		 * default_hstate_idx to HPAGE_SIZE hstate. And, if the
-		 * number of huge pages for this default size was implicitly
-		 * specified, set that here as well.
-		 * Note that the implicit setting will overwrite an explicit
-		 * setting.  A warning will be printed in this case.
-		 */
-		default_hstate_idx = hstate_index(size_to_hstate(HPAGE_SIZE));
-		if (default_hstate_max_huge_pages) {
-			if (default_hstate.max_huge_pages) {
-				char buf[32];
-
-				string_get_size(huge_page_size(&default_hstate),
-					1, STRING_UNITS_2, buf, 32);
-				pr_warn("HugeTLB: Ignoring hugepages=%lu associated with %s page size\n",
-					default_hstate.max_huge_pages, buf);
-				pr_warn("HugeTLB: Using hugepages=%lu for number of default huge pages\n",
-					default_hstate_max_huge_pages);
-			}
-			default_hstate.max_huge_pages =
-				default_hstate_max_huge_pages;
-
-			for_each_online_node(i)
-				default_hstate.max_huge_pages_node[i] =
-					default_hugepages_in_node[i];
-		}
-	}
 
 	hugetlb_cma_check();
+	hugetlb_prealloc(false);
 	hugetlb_init_hstates();
 	gather_bootmem_prealloc();
 	report_hugepages();
@@ -4121,8 +4240,6 @@ void __init hugetlb_add_hstate(unsigned int order)
 	snprintf(h->name, HSTATE_NAME_LEN, "hugepages-%lukB",
 					huge_page_size(h)/1024);
 	hugetlb_vmemmap_init(h);
-
-	parsed_hstate = h;
 }
 
 bool __init __weak hugetlb_node_alloc_supported(void)
@@ -4130,210 +4247,6 @@ bool __init __weak hugetlb_node_alloc_supported(void)
 	return true;
 }
 
-static void __init hugepages_clear_pages_in_node(void)
-{
-	if (!hugetlb_max_hstate) {
-		default_hstate_max_huge_pages = 0;
-		memset(default_hugepages_in_node, 0,
-			MAX_NUMNODES * sizeof(unsigned int));
-	} else {
-		parsed_hstate->max_huge_pages = 0;
-		memset(parsed_hstate->max_huge_pages_node, 0,
-			MAX_NUMNODES * sizeof(unsigned int));
-	}
-}
-
-/*
- * hugepages command line processing
- * hugepages normally follows a valid hugepagsz or default_hugepagsz
- * specification.  If not, ignore the hugepages value.  hugepages can also
- * be the first huge page command line  option in which case it implicitly
- * specifies the number of huge pages for the default size.
- */
-static int __init hugepages_setup(char *s)
-{
-	unsigned long *mhp;
-	static unsigned long *last_mhp;
-	int node = NUMA_NO_NODE;
-	int count;
-	unsigned long tmp;
-	char *p = s;
-
-	if (!parsed_valid_hugepagesz) {
-		pr_warn("HugeTLB: hugepages=%s does not follow a valid hugepagesz, ignoring\n", s);
-		parsed_valid_hugepagesz = true;
-		return 1;
-	}
-
-	/*
-	 * !hugetlb_max_hstate means we haven't parsed a hugepagesz= parameter
-	 * yet, so this hugepages= parameter goes to the "default hstate".
-	 * Otherwise, it goes with the previously parsed hugepagesz or
-	 * default_hugepagesz.
-	 */
-	else if (!hugetlb_max_hstate)
-		mhp = &default_hstate_max_huge_pages;
-	else
-		mhp = &parsed_hstate->max_huge_pages;
-
-	if (mhp == last_mhp) {
-		pr_warn("HugeTLB: hugepages= specified twice without interleaving hugepagesz=, ignoring hugepages=%s\n", s);
-		return 1;
-	}
-
-	while (*p) {
-		count = 0;
-		if (sscanf(p, "%lu%n", &tmp, &count) != 1)
-			goto invalid;
-		/* Parameter is node format */
-		if (p[count] == ':') {
-			if (!hugetlb_node_alloc_supported()) {
-				pr_warn("HugeTLB: architecture can't support node specific alloc, ignoring!\n");
-				return 1;
-			}
-			if (tmp >= MAX_NUMNODES || !node_online(tmp))
-				goto invalid;
-			node = array_index_nospec(tmp, MAX_NUMNODES);
-			p += count + 1;
-			/* Parse hugepages */
-			if (sscanf(p, "%lu%n", &tmp, &count) != 1)
-				goto invalid;
-			if (!hugetlb_max_hstate)
-				default_hugepages_in_node[node] = tmp;
-			else
-				parsed_hstate->max_huge_pages_node[node] = tmp;
-			*mhp += tmp;
-			/* Go to parse next node*/
-			if (p[count] == ',')
-				p += count + 1;
-			else
-				break;
-		} else {
-			if (p != s)
-				goto invalid;
-			*mhp = tmp;
-			break;
-		}
-	}
-
-	/*
-	 * Global state is always initialized later in hugetlb_init.
-	 * But we need to allocate gigantic hstates here early to still
-	 * use the bootmem allocator.
-	 */
-	if (hugetlb_max_hstate && hstate_is_gigantic(parsed_hstate))
-		hugetlb_hstate_alloc_pages(parsed_hstate);
-
-	last_mhp = mhp;
-
-	return 1;
-
-invalid:
-	pr_warn("HugeTLB: Invalid hugepages parameter %s\n", p);
-	hugepages_clear_pages_in_node();
-	return 1;
-}
-__setup("hugepages=", hugepages_setup);
-
-/*
- * hugepagesz command line processing
- * A specific huge page size can only be specified once with hugepagesz.
- * hugepagesz is followed by hugepages on the command line.  The global
- * variable 'parsed_valid_hugepagesz' is used to determine if prior
- * hugepagesz argument was valid.
- */
-static int __init hugepagesz_setup(char *s)
-{
-	unsigned long size;
-	struct hstate *h;
-
-	parsed_valid_hugepagesz = false;
-	size = (unsigned long)memparse(s, NULL);
-
-	if (!arch_hugetlb_valid_size(size)) {
-		pr_err("HugeTLB: unsupported hugepagesz=%s\n", s);
-		return 1;
-	}
-
-	h = size_to_hstate(size);
-	if (h) {
-		/*
-		 * hstate for this size already exists.  This is normally
-		 * an error, but is allowed if the existing hstate is the
-		 * default hstate.  More specifically, it is only allowed if
-		 * the number of huge pages for the default hstate was not
-		 * previously specified.
-		 */
-		if (!parsed_default_hugepagesz ||  h != &default_hstate ||
-		    default_hstate.max_huge_pages) {
-			pr_warn("HugeTLB: hugepagesz=%s specified twice, ignoring\n", s);
-			return 1;
-		}
-
-		/*
-		 * No need to call hugetlb_add_hstate() as hstate already
-		 * exists.  But, do set parsed_hstate so that a following
-		 * hugepages= parameter will be applied to this hstate.
-		 */
-		parsed_hstate = h;
-		parsed_valid_hugepagesz = true;
-		return 1;
-	}
-
-	hugetlb_add_hstate(ilog2(size) - PAGE_SHIFT);
-	parsed_valid_hugepagesz = true;
-	return 1;
-}
-__setup("hugepagesz=", hugepagesz_setup);
-
-/*
- * default_hugepagesz command line input
- * Only one instance of default_hugepagesz allowed on command line.
- */
-static int __init default_hugepagesz_setup(char *s)
-{
-	unsigned long size;
-	int i;
-
-	parsed_valid_hugepagesz = false;
-	if (parsed_default_hugepagesz) {
-		pr_err("HugeTLB: default_hugepagesz previously specified, ignoring %s\n", s);
-		return 1;
-	}
-
-	size = (unsigned long)memparse(s, NULL);
-
-	if (!arch_hugetlb_valid_size(size)) {
-		pr_err("HugeTLB: unsupported default_hugepagesz=%s\n", s);
-		return 1;
-	}
-
-	hugetlb_add_hstate(ilog2(size) - PAGE_SHIFT);
-	parsed_valid_hugepagesz = true;
-	parsed_default_hugepagesz = true;
-	default_hstate_idx = hstate_index(size_to_hstate(size));
-
-	/*
-	 * The number of default huge pages (for this size) could have been
-	 * specified as the first hugetlb parameter: hugepages=X.  If so,
-	 * then default_hstate_max_huge_pages is set.  If the default huge
-	 * page size is gigantic (>= MAX_ORDER), then the pages must be
-	 * allocated here from bootmem allocator.
-	 */
-	if (default_hstate_max_huge_pages) {
-		default_hstate.max_huge_pages = default_hstate_max_huge_pages;
-		for_each_online_node(i)
-			default_hstate.max_huge_pages_node[i] =
-				default_hugepages_in_node[i];
-		if (hstate_is_gigantic(&default_hstate))
-			hugetlb_hstate_alloc_pages(&default_hstate);
-		default_hstate_max_huge_pages = 0;
-	}
-
-	return 1;
-}
-__setup("default_hugepagesz=", default_hugepagesz_setup);
-
 static unsigned int allowed_mems_nr(struct hstate *h)
 {
 	int node;
-- 
2.11.0

