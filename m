Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71BA52141E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240445AbiEJLt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiEJLtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:49:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E01250E8A
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:45:23 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24A9rflE020277;
        Tue, 10 May 2022 11:44:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=ReniqVyCnhJn7wI9OZvI2+w7Me/H8Qb7gm1e+jK9Hlo=;
 b=Kmx3bh/+xyjstY2E8FGwTU/p4WO9QDy5vvpqJhTl1eRlKUJ8GvBrjUi1YdyzoH3UziBs
 b8U13IQilJ3KEl3A9wsQdpeusz+1gqxsUArSAwoJ0wPqd9LpYUgVDPQ4O0cRHCO5WiIQ
 RbR75SWQwCx5TdyxX0329nxntt1Vkeu6/Y9Qm2Z5b8YAP8785U/FxE8u72zvxuY/GFuv
 wb5a1SVc6/iwhL3YMlWj5zzKWeKhOtjAn1VYswxSgLkXQzpPwdQbKuHQ8wTOPDGqnCus
 ptLUrmhxcbk3aB/JnTmst6+wEF0WU6cyovZ9MlEI6gi1EgBWnUtcbisM1L8vioFVVpXb zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fyntr21ah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 11:44:34 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24ABaG86024772;
        Tue, 10 May 2022 11:44:33 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fyntr21a8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 11:44:33 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24ABd2YG021735;
        Tue, 10 May 2022 11:44:32 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01wdc.us.ibm.com with ESMTP id 3fwgd94p4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 11:44:32 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24ABiVMI43123122
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 11:44:32 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D62B311206F;
        Tue, 10 May 2022 11:44:31 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E46E611206E;
        Tue, 10 May 2022 11:44:25 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.24.223])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 10 May 2022 11:44:25 +0000 (GMT)
X-Mailer: emacs 29.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Wei Xu <weixugc@google.com>,
        Hesham Almatary <hesham.almatary@huawei.com>
Cc:     Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces
In-Reply-To: <CAAPL-u-2njgxtfSsRe8LM14W-k982hEObg6y+rYWmK-G=X4f9g@mail.gmail.com>
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
 <CAHbLzkq1YXXLMiREpGnzhJjPssu4WpSsnkTmrLJ=hAEhZVUr9w@mail.gmail.com>
 <CAAPL-u-r2Pc_MaHQmKKNH_icAa_fH1COWb5qSPpr8xffREQ_cQ@mail.gmail.com>
 <CAHbLzkrit3SDQUWPQ_RtTO_xFqxoqR9LpY=72afERapUgkjxZg@mail.gmail.com>
 <1642ab64-7957-e1e6-71c5-ceab9c23bf41@huawei.com>
 <CAAPL-u-2njgxtfSsRe8LM14W-k982hEObg6y+rYWmK-G=X4f9g@mail.gmail.com>
Date:   Tue, 10 May 2022 17:14:23 +0530
Message-ID: <87czglhaso.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bek01YQ49-3UB6_ZnGUq1pS4eIW5Itxc
X-Proofpoint-GUID: AcUw790ebGa3rwHCy75kjNo1vItqIsot
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_01,2022-05-10_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0 phishscore=0
 impostorscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2205100052
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Xu <weixugc@google.com> writes:

> On Mon, May 9, 2022 at 7:32 AM Hesham Almatary
> <hesham.almatary@huawei.com> wrote:
>>

....

> > nearest lower tier before demoting to lower lower tiers.
>> There might still be simple cases/topologies where we might want to "skip"
>> the very next lower tier. For example, assume we have a 3 tiered memory
>> system as follows:
>>
>> node 0 has a CPU and DDR memory in tier 0, node 1 has GPU and DDR memory
>> in tier 0,
>> node 2 has NVMM memory in tier 1, node 3 has some sort of bigger memory
>> (could be a bigger DDR or something) in tier 2. The distances are as
>> follows:
>>
>> --------------          --------------
>> |   Node 0   |          |   Node 1   |
>> |  -------   |          |  -------   |
>> | |  DDR  |  |          | |  DDR  |  |
>> |  -------   |          |  -------   |
>> |            |          |            |
>> --------------          --------------
>>         | 20               | 120    |
>>         v                  v        |
>> ----------------------------       |
>> | Node 2     PMEM          |       | 100
>> ----------------------------       |
>>         | 100                       |
>>         v                           v
>> --------------------------------------
>> | Node 3    Large mem                |
>> --------------------------------------
>>
>> node distances:
>> node   0    1    2    3
>>     0  10   20   20  120
>>     1  20   10  120  100
>>     2  20  120   10  100
>>     3  120 100  100   10
>>
>> /sys/devices/system/node/memory_tiers
>> 0-1
>> 2
>> 3
>>
>> N_TOPTIER_MEMORY: 0-1
>>
>>
>> In this case, we want to be able to "skip" the demotion path from Node 1
>> to Node 2,
>>
>> and make demotion go directely to Node 3 as it is closer, distance wise.
>> How can
>>
>> we accommodate this scenario (or at least not rule it out as future
>> work) with the current RFC?
>
> This is an interesting example.  I think one way to support this is to
> allow all the lower tier nodes to be the demotion targets of a node in
> the higher tier.  We can then use the allocation fallback order to
> select the best demotion target.
>
> For this example, we will have the demotion targets of each node as:
>
> node 0: allowed=2-3, order (based on allocation fallback order): 2, 3
> node 1: allowed=2-3, order (based on allocation fallback order): 3, 2
> node 2: allowed = 3, order (based on allocation fallback order): 3
> node 3: allowed = empty
>
> What do you think?
>

Can we simplify this further with

tier 0 - > empty (no HBM/GPU)
tier 1 ->  Node0, Node1
tier 2 ->  Node2, Node3

Hence

 node 0: allowed=2-3, order (based on allocation fallback order): 2, 3
 node 1: allowed=2-3, order (based on allocation fallback order): 3, 2
 node 2: allowed = empty
 node 3: allowed = empty

-aneesh
