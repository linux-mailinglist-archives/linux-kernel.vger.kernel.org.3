Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575AA54276D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbiFHHCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352854AbiFHGQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 02:16:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14943A0D2F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 22:55:21 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2584rmQH031067;
        Wed, 8 Jun 2022 05:02:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=RhuxxbL2muM1exHrZkvpaR4qmgjQCeQg6dQ6U2WhEgo=;
 b=AyVHTgMnNXLAgWt2rjT/uEoUfvrAlHbQSmgnSBB0u2hnzezw1bOOWkECDgM4KPDXJXjp
 FelFCF2fntvXn81jKZbQ+MyHs107FSw6JXXTAK9I9Myr+pXUtxCCBLKEhhYgtUZrbjcc
 bNX5oNsC8LrhJBC90QmLEc3jNG5TP92/vGmLi5WFCHcjr/O07H1fBz701UmRNhyp0OWV
 4jHZIczTcbKOBjuI1TKdDUQ/YbKBoHk5MhYMUqqtaIzLVnnyG8fvMINyZbUvNopNOUxE
 oBq68KQNh6euarlmoytfzj4az7o9OrQyFmiebqEKUYsCSgCen+oe87V4+81F49FQzoRQ rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gjn55r52q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 05:02:40 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2584sJ7h001142;
        Wed, 8 Jun 2022 05:02:39 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gjn55r51v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 05:02:39 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2584q0SW010256;
        Wed, 8 Jun 2022 05:02:36 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3gfy19cmap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 05:02:36 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25852IGC23331142
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jun 2022 05:02:18 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64D0352054;
        Wed,  8 Jun 2022 05:02:34 +0000 (GMT)
Received: from [9.43.53.124] (unknown [9.43.53.124])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7A81052050;
        Wed,  8 Jun 2022 05:02:27 +0000 (GMT)
Message-ID: <6a2b05db-8e8d-b5e0-6166-f5c41c410c7b@linux.ibm.com>
Date:   Wed, 8 Jun 2022 10:32:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 4/9] mm/demotion: Build demotion targets based on
 explicit memory tiers
Content-Language: en-US
To:     Tim Chen <tim.c.chen@linux.intel.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
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
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
 <20220603134237.131362-5-aneesh.kumar@linux.ibm.com>
 <c4678658cdd04d14ced7d0407da32f5fdec19f95.camel@linux.intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <c4678658cdd04d14ced7d0407da32f5fdec19f95.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UE-Ya6p1P_5TBYb9d9EY-JcuJ91sSLKp
X-Proofpoint-ORIG-GUID: 7y_JG1IqOPaOTmZembLo61EzP8KLXCdE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-08_01,2022-06-07_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206080022
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 4:21 AM, Tim Chen wrote:
> On Fri, 2022-06-03 at 19:12 +0530, Aneesh Kumar K.V wrote:
>>
>> +int next_demotion_node(int node)
>> +{
>> +	struct demotion_nodes *nd;
>> +	int target, nnodes, i;
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
>> +
>> +	nnodes = nodes_weight(nd->preferred);
>> +	if (!nnodes)
>> +		return NUMA_NO_NODE;
>> +
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
>> +	nnodes = get_random_int() % nnodes;
>> +	target = first_node(nd->preferred);
>> +	for (i = 0; i < nnodes; i++)
>> +		target = next_node(target, nd->preferred);
> 
> We can simplify the above 4 lines.
> 
> 	target = node_random(nd->preferred);
> 
> There's still a loop overhead though :(
> 

Will fix in next update.

>> +
>> +	rcu_read_unlock();
>> +
>> +	return target;
>> +}
>> +
>>

-aneesh
