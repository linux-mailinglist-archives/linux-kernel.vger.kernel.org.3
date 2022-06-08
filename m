Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E545432BE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241583AbiFHOie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241590AbiFHOi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:38:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560E7126995
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:38:26 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 258EMsV3027454;
        Wed, 8 Jun 2022 14:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=ZMKwn4IfXk/xSoSNJD4/4k0SViRUcY39a8AbWihJKX8=;
 b=MyEVXb9qJI4iut5BMxqfe53nvHkFMwjJR8MFCjUQ1UJkquBblxUV5Yg+6RDsQbnR7hKi
 IwCWRRJE0mZ4nsSFMjrqF8T1YIKrwRawoIH0wp35j/hKoH97WgAZA151QYMmsJmJv9xd
 kXuAYs1M2jE6nXLB5UFEAxlvx0Q3mLkNI0MPLm/dKQexQnTBWnXGbiTE7/nFc/FYjpry
 jm4q+IHtrkzDxYScsMjE1r17PZSOHAttdQZpDJh/SoO+v0W228sPBtObFlhsWo/og3Se
 YCDHEKmK6F24vIUtSfVL4E/nVSochnubtCkQlOGx/hhjEmFQ69Mo7GA+Jtl1m8R74e5r aA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gjwfxgau5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 14:38:09 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 258ETehf029140;
        Wed, 8 Jun 2022 14:38:08 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gjwfxgat1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 14:38:08 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 258EZNUY021845;
        Wed, 8 Jun 2022 14:38:07 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma02dal.us.ibm.com with ESMTP id 3gfy1atqhp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 14:38:07 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 258Ec6qj32244158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jun 2022 14:38:06 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00DC7136053;
        Wed,  8 Jun 2022 14:38:06 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14067136051;
        Wed,  8 Jun 2022 14:37:56 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.53.124])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  8 Jun 2022 14:37:55 +0000 (GMT)
X-Mailer: emacs 29.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v5 9/9] mm/demotion: Update node_is_toptier to work with
 memory tiers
In-Reply-To: <cc9566421dedf10b5b7149d093992797540c31e2.camel@intel.com>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
 <20220603134237.131362-10-aneesh.kumar@linux.ibm.com>
 <6e94b7e2a6192e4cacba1db3676b5b5cf9b98eac.camel@intel.com>
 <f9a26536-05f6-5d12-5c61-cdd35ab33a40@linux.ibm.com>
 <11f94e0c50f17f4a6a2f974cb69a1ae72853e2be.camel@intel.com>
 <d2513be5-be87-2957-a0d4-1d99b9e83114@linux.ibm.com>
 <db0200f4467c072470d8ed7e272132bfeb146ac2.camel@intel.com>
 <232817e0-24fd-e022-6c92-c260f7f01f8a@linux.ibm.com>
 <cc9566421dedf10b5b7149d093992797540c31e2.camel@intel.com>
Date:   Wed, 08 Jun 2022 20:07:52 +0530
Message-ID: <87sfoffcfz.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nxKGW2Y8ZCvklxKAXuhfj7ReGDo-XPB-
X-Proofpoint-GUID: 06kLKTxoYsanhfyFWI4mqXmS6aYFoW1X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-08_05,2022-06-07_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 phishscore=0 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206080063
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ying Huang <ying.huang@intel.com> writes:

....

> > >=20
>> > > is this good (not tested)?
>> > > /*
>> > > =C2=A0=C2=A0=C2=A0* build the allowed promotion mask. Promotion is a=
llowed
>> > > =C2=A0=C2=A0=C2=A0* from higher memory tier to lower memory tier onl=
y if
>> > > =C2=A0=C2=A0=C2=A0* lower memory tier doesn't include compute. We wa=
nt to
>> > > =C2=A0=C2=A0=C2=A0* skip promotion from a memory tier, if any node w=
hich is
>> > > =C2=A0=C2=A0=C2=A0* part of that memory tier have CPUs. Once we dete=
ct such
>> > > =C2=A0=C2=A0=C2=A0* a memory tier, we consider that tier as top tier=
 from
>> > > =C2=A0=C2=A0=C2=A0* which promotion is not allowed.
>> > > =C2=A0=C2=A0=C2=A0*/
>> > > list_for_each_entry_reverse(memtier, &memory_tiers, list) {
>> > > 	nodes_and(allowed, node_state[N_CPU], memtier->nodelist);
>> > > 	if (nodes_empty(allowed))
>> > > 		nodes_or(promotion_mask, promotion_mask, allowed);
>> > > 	else
>> > > 		break;
>> > > }
>> > >=20
>> > > and then
>> > >=20
>> > > static inline bool node_is_toptier(int node)
>> > > {
>> > >=20
>> > > 	return !node_isset(node, promotion_mask);
>> > > }
>> > >=20
>> >=20
>> > This should work.  But it appears unnatural.  So, I don't think we
>> > should avoid to add more and more node masks to mitigate the design
>> > decision that we cannot access memory tier information directly.  All
>> > these becomes simple and natural, if we can access memory tier
>> > information directly.
>> >=20
>>=20
>> how do you derive whether node is toptier details if we have memtier=20
>> details in pgdat?
>
> pgdat -> memory tier -> rank
>
> Then we can compare this rank with the fast memory rank.  The fast
> memory rank can be calculated dynamically at appropriate places.

This is what I am testing now. We still need to closely audit that lock
free access to the NODE_DATA()->memtier. For v6 I will keep this as a
separate patch and once we all agree that it is safe, I will fold it
back.

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index a388a806b61a..3e733de1a8a0 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -17,7 +17,6 @@
 #define MAX_MEMORY_TIERS  (MAX_STATIC_MEMORY_TIERS + 2)
=20
 extern bool numa_demotion_enabled;
-extern nodemask_t promotion_mask;
 int node_create_and_set_memory_tier(int node, int tier);
 int next_demotion_node(int node);
 int node_set_memory_tier(int node, int tier);
@@ -25,15 +24,7 @@ int node_get_memory_tier_id(int node);
 int node_reset_memory_tier(int node, int tier);
 void node_remove_from_memory_tier(int node);
 void node_get_allowed_targets(int node, nodemask_t *targets);
-
-/*
- * By default all nodes are top tiper. As we create new memory tiers
- * we below top tiers we add them to NON_TOP_TIER state.
- */
-static inline bool node_is_toptier(int node)
-{
-	return !node_isset(node, promotion_mask);
-}
+bool node_is_toptier(int node);
=20
 #else
 #define numa_demotion_enabled	false
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index aab70355d64f..c4fcfd2b9980 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -928,6 +928,9 @@ typedef struct pglist_data {
 	/* Per-node vmstats */
 	struct per_cpu_nodestat __percpu *per_cpu_nodestats;
 	atomic_long_t		vm_stat[NR_VM_NODE_STAT_ITEMS];
+#ifdef CONFIG_TIERED_MEMORY
+	struct memory_tier *memtier;
+#endif
 } pg_data_t;
=20
 #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 29a038bb38b0..31ef0fab5f19 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -7,6 +7,7 @@
 #include <linux/random.h>
 #include <linux/memory.h>
 #include <linux/idr.h>
+#include <linux/rcupdate.h>
=20
 #include "internal.h"
=20
@@ -26,7 +27,7 @@ struct demotion_nodes {
 static void establish_migration_targets(void);
 static DEFINE_MUTEX(memory_tier_lock);
 static LIST_HEAD(memory_tiers);
-nodemask_t promotion_mask;
+static int top_tier_rank;
 /*
  * node_demotion[] examples:
  *
@@ -135,7 +136,7 @@ static void memory_tier_device_release(struct device *d=
ev)
 	if (tier->dev.id >=3D MAX_STATIC_MEMORY_TIERS)
 		ida_free(&memtier_dev_id, tier->dev.id);
=20
-	kfree(tier);
+	kfree_rcu(tier);
 }
=20
 /*
@@ -233,6 +234,70 @@ static struct memory_tier *__get_memory_tier_from_id(i=
nt id)
 	return NULL;
 }
=20
+/*
+ * Called with memory_tier_lock. Hence the device references cannot
+ * be dropped during this function.
+ */
+static void memtier_node_clear(int node, struct memory_tier *memtier)
+{
+	pg_data_t *pgdat;
+
+	pgdat =3D NODE_DATA(node);
+	if (!pgdat)
+		return;
+
+	rcu_assign_pointer(pgdat->memtier, NULL);
+	/*
+	 * Make sure read side see the NULL value before we clear the node
+	 * from the nodelist.
+	 */
+	synchronize_rcu();
+	node_clear(node, memtier->nodelist);
+}
+
+static void memtier_node_set(int node, struct memory_tier *memtier)
+{
+	pg_data_t *pgdat;
+
+	pgdat =3D NODE_DATA(node);
+	if (!pgdat)
+		return;
+	/*
+	 * Make sure we mark the memtier NULL before we assign the new memory tier
+	 * to the NUMA node. This make sure that anybody looking at NODE_DATA
+	 * finds a NULL memtier or the one which is still valid.
+	 */
+	rcu_assign_pointer(pgdat->memtier, NULL);
+	synchronize_rcu();
+	node_set(node, memtier->nodelist);
+	rcu_assign_pointer(pgdat->memtier, memtier);
+}
+
+bool node_is_toptier(int node)
+{
+	bool toptier;
+	pg_data_t *pgdat;
+	struct memory_tier *memtier;
+
+	pgdat =3D NODE_DATA(node);
+	if (!pgdat)
+		return false;
+
+	rcu_read_lock();
+	memtier =3D rcu_dereference(pgdat->memtier);
+	if (!memtier) {
+		toptier =3D true;
+		goto out;
+	}
+	if (memtier->rank >=3D top_tier_rank)
+		toptier =3D true;
+	else
+		toptier =3D false;
+out:
+	rcu_read_unlock();
+	return toptier;
+}
+
 static int __node_create_and_set_memory_tier(int node, int tier)
 {
 	int ret =3D 0;
@@ -253,7 +318,7 @@ static int __node_create_and_set_memory_tier(int node, =
int tier)
 			goto out;
 		}
 	}
-	node_set(node, memtier->nodelist);
+	memtier_node_set(node, memtier);
 out:
 	return ret;
 }
@@ -275,12 +340,12 @@ int node_create_and_set_memory_tier(int node, int tie=
r)
 	if (current_tier->dev.id =3D=3D tier)
 		goto out;
=20
-	node_clear(node, current_tier->nodelist);
+	memtier_node_clear(node, current_tier);
=20
 	ret =3D __node_create_and_set_memory_tier(node, tier);
 	if (ret) {
 		/* reset it back to older tier */
-		node_set(node, current_tier->nodelist);
+		memtier_node_set(node, current_tier);
 		goto out;
 	}
=20
@@ -305,7 +370,7 @@ static int __node_set_memory_tier(int node, int tier)
 		ret =3D -EINVAL;
 		goto out;
 	}
-	node_set(node, memtier->nodelist);
+	memtier_node_set(node, memtier);
 out:
 	return ret;
 }
@@ -374,12 +439,12 @@ int node_reset_memory_tier(int node, int tier)
 	if (current_tier->dev.id =3D=3D tier)
 		goto out;
=20
-	node_clear(node, current_tier->nodelist);
+	memtier_node_clear(node, current_tier);
=20
 	ret =3D __node_set_memory_tier(node, tier);
 	if (ret) {
 		/* reset it back to older tier */
-		node_set(node, current_tier->nodelist);
+		memtier_node_set(node, current_tier);
 		goto out;
 	}
=20
@@ -407,7 +472,7 @@ void node_remove_from_memory_tier(int node)
 	 * empty then unregister it to make it invisible
 	 * in sysfs.
 	 */
-	node_clear(node, memtier->nodelist);
+	memtier_node_clear(node, memtier);
 	if (nodes_empty(memtier->nodelist))
 		unregister_memory_tier(memtier);
=20
@@ -570,15 +635,13 @@ static void establish_migration_targets(void)
 	 * a memory tier, we consider that tier as top tiper from
 	 * which promotion is not allowed.
 	 */
-	promotion_mask =3D NODE_MASK_NONE;
 	list_for_each_entry_reverse(memtier, &memory_tiers, list) {
 		nodes_and(allowed, node_states[N_CPU], memtier->nodelist);
-		if (nodes_empty(allowed))
-			nodes_or(promotion_mask, promotion_mask, memtier->nodelist);
-		else
+		if (!nodes_empty(allowed)) {
+			top_tier_rank =3D memtier->rank;
 			break;
+		}
 	}
-
 	pr_emerg("top tier rank is %d\n", top_tier_rank);
 	allowed =3D NODE_MASK_NONE;
 	/*
@@ -748,7 +811,7 @@ static const struct attribute_group *memory_tier_attr_g=
roups[] =3D {
=20
 static int __init memory_tier_init(void)
 {
-	int ret;
+	int ret, node;
 	struct memory_tier *memtier;
=20
 	ret =3D subsys_system_register(&memory_tier_subsys, memory_tier_attr_grou=
ps);
@@ -766,7 +829,13 @@ static int __init memory_tier_init(void)
 		panic("%s() failed to register memory tier: %d\n", __func__, ret);
=20
 	/* CPU only nodes are not part of memory tiers. */
-	memtier->nodelist =3D node_states[N_MEMORY];
+	for_each_node_state(node, N_MEMORY) {
+		/*
+		 * Should be safe to do this early in the boot.
+		 */
+		NODE_DATA(node)->memtier =3D memtier;
+		node_set(node, memtier->nodelist);
+	}
 	migrate_on_reclaim_init();
=20
 	return 0;
