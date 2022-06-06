Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200EF53E05B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 06:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiFFD4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 23:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiFFD4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 23:56:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B76939F8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 20:56:39 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2560t3gD022925;
        Mon, 6 Jun 2022 03:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=LNZ16JhiClGNVbYDU8JRvuJpOJP0oXn6X9Kdc1uvhHY=;
 b=rXRjyPJPhkXMqtF1cYgvez4PHbuLALiVoi9RgKqJ+D8MGOhRtEbjbtQtkVDx5w1RW5p7
 Oa6w/7QTCq6w0XYJtf+zyK8D6ACJzHZYV2LA5nmrJZvcXKnlAhO48shRU9jrb1zBQovI
 OMIsmPEn4AQ00PaePXmC8JWLeuZ/F1TO38zQnUPowTYUaFDYNEMnRNpm1xTMPXxroYla
 5ndgomvEWq4ym42AaI5x3SEvSoYsVE1KfL957fCapjoK1/p0YDmyLNa4fXNhERhomhFA
 GrAN6j5byDtH8x9DJO1+PdVv4m72OxYTFTUMoScUFaoGL8iMyjID97A1okiwCr00yV+U AQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ggh1mqadw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 03:52:18 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2563kaBN010725;
        Mon, 6 Jun 2022 03:52:18 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ggh1mqadr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 03:52:18 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2563q4Cl013988;
        Mon, 6 Jun 2022 03:52:16 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3gfy199sf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 03:52:16 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2563q12C22741460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Jun 2022 03:52:01 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5EE95204F;
        Mon,  6 Jun 2022 03:52:13 +0000 (GMT)
Received: from [9.43.83.177] (unknown [9.43.83.177])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7427552050;
        Mon,  6 Jun 2022 03:52:08 +0000 (GMT)
Message-ID: <f9a26536-05f6-5d12-5c61-cdd35ab33a40@linux.ibm.com>
Date:   Mon, 6 Jun 2022 09:22:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 9/9] mm/demotion: Update node_is_toptier to work with
 memory tiers
Content-Language: en-US
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
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
 <20220603134237.131362-10-aneesh.kumar@linux.ibm.com>
 <6e94b7e2a6192e4cacba1db3676b5b5cf9b98eac.camel@intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <6e94b7e2a6192e4cacba1db3676b5b5cf9b98eac.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: X3-_qMczAxV5TgWtu1rpmVhxJlL2UEyG
X-Proofpoint-GUID: PtGlp6zCAP_3QPE6GyeBFe6h2rGOTaXg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-06_01,2022-06-03_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=907
 malwarescore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 adultscore=0 mlxscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060018
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/22 8:41 AM, Ying Huang wrote:
> On Fri, 2022-06-03 at 19:12 +0530, Aneesh Kumar K.V wrote:
>> With memory tiers support we can have memory on NUMA nodes
>> in the top tier from which we want to avoid promotion tracking NUMA
>> faults. Update node_is_toptier to work with memory tiers. To
>> avoid taking locks, a nodemask is maintained for all demotion
>> targets. All NUMA nodes are by default top tier nodes and as
>> we add new lower memory tiers NUMA nodes get added to the
>> demotion targets thereby moving them out of the top tier.
> 
> Check the usage of node_is_toptier(),
> 
> - migrate_misplaced_page()
>    node_is_toptier() is used to check whether migration is a promotion.
> We can avoid to use it.  Just compare the rank of the nodes.
> 
> - change_pte_range() and change_huge_pmd()
>    node_is_toptier() is used to avoid scanning fast memory (DRAM) pages
> for promotion.  So I think we should change the name to node_is_fast()
> as follows,
> 
> static inline bool node_is_fast(int node)
> {
> 	return NODE_DATA(node)->mt_rank >= MEMORY_RANK_DRAM;
> }
> 

But that gives special meaning to MEMORY_RANK_DRAM. As detailed in other 
patches, absolute value of rank doesn't carry any meaning. It is only
the relative value w.r.t other memory tiers that decide whether it is 
fast or not. Agreed by default memory tiers get built with 
MEMORY_RANK_DRAM. But userspace can change the rank value of 'memtier1' 
Hence to determine a node is consisting of fast memory is essentially 
figuring out whether node is the top most tier in memory hierarchy and 
not just the memory tier rank value is >= MEMORY_RANK_DRAM?

-aneesh
