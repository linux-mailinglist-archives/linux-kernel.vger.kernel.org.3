Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9F7584C81
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbiG2HWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbiG2HWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:22:43 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4EB7D784
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:22:43 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26T7DOA4037697;
        Fri, 29 Jul 2022 07:22:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=DBM5ySA5g0r2dZVDe9Jwxay5z+uFtZLDHYvlpDeRg/Q=;
 b=r/ZS29FLP/JGCEO5L1tQs7Ac+nCxbUned4WyKqVHy3b/xv+Y/qLIJDRWfi/8ShltFqVv
 qgTl3Iz4Kg4C4812GTQE2SmEUZwe1BgEV+5bv1mU+i/Ur3CYKNdp6BYLLSlh4ULgCvGL
 QBoD2qDVPTMHqMTXJdUy+5wN6QB5orciOpJ3tAARJltnMb/+rrW4SloRFetTQpNOsKX6
 S5Yaq8CNs5eF0h4w2AWeDPl1iWw13cFVnNyrP90AjzmPH7lvRcZhtxfcTtYBtvwk0cO2
 HjzoCaBJzlri9C2UZ/CnsJYboDIgWw2MBqQs74dXrJ8y42Q/u3d2Sq88BMiA4MGYHmSG vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hmaydr90u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 07:22:24 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26T7GFeU012876;
        Fri, 29 Jul 2022 07:22:23 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hmaydr90j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 07:22:23 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26T7Jrnp015895;
        Fri, 29 Jul 2022 07:22:22 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 3hhfpj9ssp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 07:22:22 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26T7ML7V43647244
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 07:22:21 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B5EDBE053;
        Fri, 29 Jul 2022 07:22:21 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1F97BE04F;
        Fri, 29 Jul 2022 07:22:15 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.86.244])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 29 Jul 2022 07:22:15 +0000 (GMT)
X-Mailer: emacs 29.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com
Subject: Re: [PATCH v11 5/8] mm/demotion: Build demotion targets based on
 explicit memory tiers
In-Reply-To: <87wnbwl92w.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20220728190436.858458-1-aneesh.kumar@linux.ibm.com>
 <20220728190436.858458-6-aneesh.kumar@linux.ibm.com>
 <87wnbwl92w.fsf@yhuang6-desk2.ccr.corp.intel.com>
Date:   Fri, 29 Jul 2022 12:52:13 +0530
Message-ID: <878rocs7ru.fsf@linux.ibm.com>
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KySSwqCNwEFSknFiAkUe-GNaF_tB5zpE
X-Proofpoint-ORIG-GUID: 3pSJE4HUNA2SUiCpfZHrZ5uJlvdE6lwe
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207290028
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Huang, Ying" <ying.huang@intel.com> writes:

> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> + */

....

>> +int next_demotion_node(int node)
>> +{
>> +	struct demotion_nodes *nd;
>> +	int target;
>> +
>> +	if (!node_demotion)
>> +		return NUMA_NO_NODE;
>> +
>> +	nd = &node_demotion[node];
>> +
>> +	/*
>> +	 * node_demotion[] is updated without excluding this
>> +	 * function from running.
>> +	 *
>> +	 * Make sure to use RCU over entire code blocks if
>> +	 * node_demotion[] reads need to be consistent.
>> +	 */
>> +	rcu_read_lock();
>> +	/*
>> +	 * If there are multiple target nodes, just select one
>> +	 * target node randomly.
>> +	 *
>> +	 * In addition, we can also use round-robin to select
>> +	 * target node, but we should introduce another variable
>> +	 * for node_demotion[] to record last selected target node,
>> +	 * that may cause cache ping-pong due to the changing of
>> +	 * last target node. Or introducing per-cpu data to avoid
>> +	 * caching issue, which seems more complicated. So selecting
>> +	 * target node randomly seems better until now.
>> +	 */
>> +	target = node_random(&nd->preferred);
>
> Don't find code to optimize node_random() for weight == 1 case, forget
> to do that?

I guess you suggested to do that as the patch for node_random or did I
got the review feedback wrong?

https://lore.kernel.org/linux-mm/87y1wdn30p.fsf@yhuang6-desk2.ccr.corp.intel.com

The change for node_random will be patch outside this series.

-aneesh
