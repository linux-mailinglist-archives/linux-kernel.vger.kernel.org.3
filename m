Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A875055B5E7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 06:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbiF0DzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 23:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiF0DzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 23:55:06 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0692ADD
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 20:55:04 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25R0gNTu016384;
        Mon, 27 Jun 2022 03:54:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=NRWM3XMUrJSyZ/O2Lv5qvKn+WRCWKqtUnVe9+AEAUK0=;
 b=Ls+7abnOsxXGfICtVubAdvkagqqNv6Fwn8TzMbBQi8sgAYsqCwOWlelECtuvIxgSMJ7Z
 qsCfZ8zgL/nZQ9nLOYbMxkM+uKo5Z/nuXFq1oKzuy3PBsFbbzuobzhtr1cX6CNX1t64B
 Xy/M4ViFCVxZgLi3HXAZnW84M5XqVVarpPB4M++pVEPn/GFNP0+Buh72FZBy7V/qf1Tv
 ay6iBmUZTdQVRdGkCainoW0L7C7PkhDq+TtD+MWXWdG8IkA/VuOrC+hMEyt8q+m/Q/64
 XzBo+aC4YIU9iIL7SBy/yLRbDRNVyrxJ023bkG3upPgLccEKpTBvhvQVzAu6tuZCiW1h 5g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gxydc58mr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 03:54:45 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25R3sjNM005540;
        Mon, 27 Jun 2022 03:54:45 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gxydc58mf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 03:54:45 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25R3nsmL018207;
        Mon, 27 Jun 2022 03:54:44 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma03dal.us.ibm.com with ESMTP id 3gwt09hjxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 03:54:44 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25R3shVp31916300
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jun 2022 03:54:43 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2736F7805C;
        Mon, 27 Jun 2022 03:54:43 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A47E7805E;
        Mon, 27 Jun 2022 03:54:37 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.47.235])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 27 Jun 2022 03:54:36 +0000 (GMT)
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
        Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: Re: [PATCH v7 09/12] mm/demotion: Demote pages according to
 allocation fallback order
In-Reply-To: <87czf06q1i.fsf@nvdebian.thelocal>
References: <20220622082513.467538-1-aneesh.kumar@linux.ibm.com>
 <20220622082513.467538-10-aneesh.kumar@linux.ibm.com>
 <87czf06q1i.fsf@nvdebian.thelocal>
Date:   Mon, 27 Jun 2022 09:24:31 +0530
Message-ID: <87czeuzrpk.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6hRI6CVkYr_Tgp8cz7nNMGCc0zFZDku2
X-Proofpoint-ORIG-GUID: WUbop9QQPp0OOpTTXeet1s8juEFuissD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-27_02,2022-06-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=972
 impostorscore=0 mlxscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206270014
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair Popple <apopple@nvidia.com> writes:

> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>
>> From: Jagdish Gediya <jvgediya@linux.ibm.com>
>
> [...]
>
>> -static struct page *alloc_demote_page(struct page *page, unsigned long node)
>> +static struct page *alloc_demote_page(struct page *page, unsigned long private)
>>  {
>> -	struct migration_target_control mtc = {
>> -		/*
>> -		 * Allocate from 'node', or fail quickly and quietly.
>> -		 * When this happens, 'page' will likely just be discarded
>> -		 * instead of migrated.
>> -		 */
>> -		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
>> -			    __GFP_THISNODE  | __GFP_NOWARN |
>> -			    __GFP_NOMEMALLOC | GFP_NOWAIT,
>> -		.nid = node
>> -	};
>> +	struct page *target_page;
>> +	nodemask_t *allowed_mask;
>> +	struct migration_target_control *mtc;
>> +
>> +	mtc = (struct migration_target_control *)private;
>> +
>> +	allowed_mask = mtc->nmask;
>> +	/*
>> +	 * make sure we allocate from the target node first also trying to
>> +	 * reclaim pages from the target node via kswapd if we are low on
>> +	 * free memory on target node. If we don't do this and if we have low
>> +	 * free memory on the target memtier, we would start allocating pages
>> +	 * from higher memory tiers without even forcing a demotion of cold
>> +	 * pages from the target memtier. This can result in the kernel placing
>> +	 * hotpages in higher memory tiers.
>> +	 */
>> +	mtc->nmask = NULL;
>> +	mtc->gfp_mask |= __GFP_THISNODE;
>> +	target_page = alloc_migration_target(page, (unsigned long)&mtc);
>
> I finally managed to get a system setup to start testing some of this
> out. However it quickly crashed due to the bad pointer in the above call
> - you need mtc not &mtc here.

I remember fixing that during earlier testing. I guess I missed to copy
the change from test to my development. Thanks for testing this. I have
now also tested the complete series with the above-suggested changes and did
make sure we are indeed doing demotion by looking at
/proc/vmstat:pgdemote_kswapd/pgdemote_direct 

>
>> +	if (target_page)
>> +		return target_page;
>> +
>> +	mtc->gfp_mask &= ~__GFP_THISNODE;
>> +	mtc->nmask = allowed_mask;
>>
>>  	return alloc_migration_target(page, (unsigned long)&mtc);
>
> And here.
>

I will fold this changes in and send a v8 after waiting for review
feedback from others.

-aneesh
