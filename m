Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A1554ABA7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239971AbiFNIVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239485AbiFNIVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:21:00 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4265C4162E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:21:00 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25E7Ij3b030525;
        Tue, 14 Jun 2022 08:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=qTrp6OuVbFP3b7xAYjf36MdUfJUAg0uIvG0iuirysVI=;
 b=c87JSW8qP0LwRN10Pagc4wucOuZ9Bv8eEaPBqqdY8bQyCeIhDqwUrXUv+EDGSDVjYttc
 fJ1kQvTrz5xI+ryO5IJXmyihfnna3toVuUknq6GhLfVj+gKn7XfcU80a68kIITWUsrp+
 7OBFfWPrFxMMhxtguUoM6WMhM+BS0ffIF/GrLq7vIg4JMdhYZ/oiUfFXW2GVDOaPESk3
 YuC1AM9s1sO2fXDlwWib9dq3xJEB7/FwwH/PTQ3JI2yz09wADvcWluXZAFzuj9Hhrp6F
 fAXl374G6t6GDR33yQUL85y4sDDP1w6NE9ZTRx1KgxxBsveiUtk2IRPzLT6alYtsQXDG 2g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gpeevguct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jun 2022 08:20:41 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25E74L8W007148;
        Tue, 14 Jun 2022 08:20:41 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gpeevgucb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jun 2022 08:20:40 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25E85b9K029328;
        Tue, 14 Jun 2022 08:20:39 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04dal.us.ibm.com with ESMTP id 3gmjp9yt0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jun 2022 08:20:39 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25E8KcZf30081484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 08:20:38 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AFC406E04E;
        Tue, 14 Jun 2022 08:20:38 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2ACC6E050;
        Tue, 14 Jun 2022 08:20:31 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.109.205.170])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 14 Jun 2022 08:20:31 +0000 (GMT)
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
        David Rientjes <rientjes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v6 01/13] mm/demotion: Add support for explicit memory
 tiers
In-Reply-To: <a88bd25fc77252dee4f895f3a9b2c1f6ebb5169e.camel@intel.com>
References: <20220610135229.182859-1-aneesh.kumar@linux.ibm.com>
 <20220610135229.182859-2-aneesh.kumar@linux.ibm.com>
 <7e0b41422dbd0976cb43c2f126e9371d5e311e77.camel@intel.com>
 <48096ad7-ce6d-79b7-1edd-7e6652ab2a4d@linux.ibm.com>
 <a88bd25fc77252dee4f895f3a9b2c1f6ebb5169e.camel@intel.com>
Date:   Tue, 14 Jun 2022 13:50:29 +0530
Message-ID: <87a6afmzaq.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2r_V_1Sppn-0lRNX18zqqvY7z7VXMkng
X-Proofpoint-GUID: Z7Q89z1L4betmndehZi70-Oztd11A9oP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-14_02,2022-06-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=908 mlxscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206140031
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
> 
>> All those functions are called with memory_tier_lock_held. Infact all 
>> list operations requires that lock held. What details do you suggest we 
>> document? I can add extra comment to the mutex itself? Adding locking 
>> details to all the functions will be duplicating the same details at 
>> multiple places?
>
> memory_tier_lock isn't held to call register_memory_tier() in this
> patch.  That will cause confusion.

will this help to explain this better
modified   mm/memory-tiers.c
@@ -151,6 +151,11 @@ static void insert_memory_tier(struct memory_tier *memtier)
 	struct list_head *ent;
 	struct memory_tier *tmp_memtier;
 
+	if (IS_ENABLED(CONFIG_DEBUG_VM) && !mutex_is_locked(&memory_tier_lock)) {
+		WARN_ON_ONCE(1);
+		return;
+	}
+
 	list_for_each(ent, &memory_tiers) {
 		tmp_memtier = list_entry(ent, struct memory_tier, list);
 		if (tmp_memtier->rank < memtier->rank) {
@@ -811,8 +816,12 @@ static int __init memory_tier_init(void)
 
 	/*
 	 * Register only default memory tier to hide all empty
-	 * memory tier from sysfs.
+	 * memory tier from sysfs. Since this is early during
+	 * boot, we could avoid holding memtory_tier_lock. But
+	 * keep it simple by holding locks. We can add lock
+	 * held debug checks in other functions.
 	 */
+	mutex_lock(&memory_tier_lock);
 	memtier = register_memory_tier(DEFAULT_MEMORY_TIER,
 				       get_rank_from_tier(DEFAULT_MEMORY_TIER));
 
@@ -828,6 +837,7 @@ static int __init memory_tier_init(void)
 		NODE_DATA(node)->memtier = memtier;
 		node_set(node, memtier->nodelist);
 	}
+	mutex_unlock(&memory_tier_lock);
 	migrate_on_reclaim_init();
 
 	return 0;

-aneesh
