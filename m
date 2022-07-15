Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295FB575C44
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 09:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiGOHW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 03:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiGOHWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:22:22 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B8B7437B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 00:22:21 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26F6hoCb004034;
        Fri, 15 Jul 2022 07:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=+czgEbTszIZgJ23+VtNlz6CBVsIjEr9wjSrV/qdWzo0=;
 b=Gqav5gnHE6Od5rGJYBBw9AwT2oIRHxMX+ePRfYm/WMIyaaegoYMx3p9r2wkSFNHcVSiW
 XLvgzvAwwSS7x5EeJLEES91slKiGqVJ70SeeXS4iSew6GDT5xg0E/6nYpha9FtJ66pOw
 9V3EEcoWetBrOrocK9lYx59LPx7mw5kCm6eSlimpq7IphqTDm62zFOJTfvvnEHqKj2NA
 qUzpnPPrl5JQDA18xY1DyQj7A1XztoYK9Wihu/DjZlp0DMEKAYKo8J4zk2Yk7XksJRTj
 pXF2ZiEYCduldSxO08sI1Hg5dJNVIahFH1609bzLEZ5DFuPHXEuwHLVwL/i76uhHCAYA Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hb37jgq8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 07:22:01 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26F78ckI004509;
        Fri, 15 Jul 2022 07:22:01 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hb37jgq8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 07:22:01 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26F7JwNq028579;
        Fri, 15 Jul 2022 07:22:00 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04wdc.us.ibm.com with ESMTP id 3h71a9ygpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 07:22:00 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26F7LxrY50463120
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 07:21:59 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6CFB28059;
        Fri, 15 Jul 2022 07:21:59 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A4E628060;
        Fri, 15 Jul 2022 07:21:54 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.84.38])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 15 Jul 2022 07:21:54 +0000 (GMT)
X-Mailer: emacs 29.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com
Subject: Re: [PATCH v9 5/8] mm/demotion: Build demotion targets based on
 explicit memory tiers
In-Reply-To: <87cze6apeo.fsf@nvdebian.thelocal>
References: <20220714045351.434957-1-aneesh.kumar@linux.ibm.com>
 <20220714045351.434957-6-aneesh.kumar@linux.ibm.com>
 <87cze6apeo.fsf@nvdebian.thelocal>
Date:   Fri, 15 Jul 2022 12:51:51 +0530
Message-ID: <87zghau9gw.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tE9xHqtNZlpqTx1u4k4IPXjuYeofyL7q
X-Proofpoint-ORIG-GUID: qvo2Y_mnWp8zdFdenqJ_expB0aU2f8_l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_02,2022-07-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=919 adultscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207150029
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair Popple <apopple@nvidia.com> writes:
....

> + */
>> +static void establish_migration_targets(void)
>> +{
>> +	struct memory_tier *memtier;
>> +	struct demotion_nodes *nd;
>> +	int target = NUMA_NO_NODE, node;
>> +	int distance, best_distance;
>> +	nodemask_t used;
>> +
>> +	if (!node_demotion || !IS_ENABLED(CONFIG_MIGRATION))
>
> Does it make sense to include the memory tiering/demotion code if
> CONFIG_MIGRATION isn't enabled? From what I can tell none of the
> information established here is used if CONFIG_MIGRATION isn't enabled,
> so it would be better to remove the IS_ENABLED checks and not include
> the code at all.

We use the same function/codepath for updating top_tier details. We
would want to get node_is_toptier() to work even with CONFIG_MIGRATION
disabled? 

>
>> +		return;
>> +
>> +	disable_all_migrate_targets();
>> +
>> +	for_each_node_state(node, N_MEMORY) {
>> +		best_distance = -1;
>> +		nd = &node_demotion[node];
>> +
>> +		memtier = __node_get_memory_tier(node);
>> +		if (!memtier || list_is_last(&memtier->list, &memory_tiers))
>> +			continue;
>> +		/*
>> +		 * Get the next memtier to find the  demotion node list.
>> +		 */
>> +		memtier = list_next_entry(memtier, list);
>> +
>> +		/*
>> +		 * find_next_best_node, use 'used' nodemask as a skip list.
>> +		 * Add all memory nodes except the selected memory tier
>> +		 * nodelist to skip list so that we find the best node from the
>> +		 * memtier nodelist.
>> +		 */
>> +		nodes_andnot(used, node_states[N_MEMORY], memtier->nodelist);
>> +
>> +		/*
>> +		 * Find all the nodes in the memory tier node list of same best distance.
>> +		 * add them to the preferred mask. We randomly select between nodes
>> +		 * in the preferred mask when allocating pages during demotion.
>> +		 */
>> +		do {
>> +			target = find_next_best_node(node, &used);
>> +			if (target == NUMA_NO_NODE)
>> +				break;
>> +
>> +			distance = node_distance(node, target);
>> +			if (distance == best_distance || best_distance == -1) {
>> +				best_distance = distance;
>> +				node_set(target, nd->preferred);
>> +			} else {
>> +				break;
>> +			}
>> +		} while (1);
>> +	}
>> +}
>> +

.....

-aneesh
