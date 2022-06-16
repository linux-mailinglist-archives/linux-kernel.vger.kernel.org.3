Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A0454D97B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 06:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356452AbiFPEvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 00:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349195AbiFPEu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 00:50:58 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249022CC81
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 21:50:58 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25G4HTAg024824;
        Thu, 16 Jun 2022 04:50:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=mamJNC0U/jU3Ok7lpo1pHDh8LmW22sEmyputeCy+QEM=;
 b=cN3eaf1lvqL4/9YcdeNAH1VJ+N1F488NpS/C3f+m5P2kF69sOPcB88DEMM9v8GLtAaxS
 SEv+rWM5ur/LQl1PYPjldN+6oW23nVIV6eO4P5dNneYzhqqSN8NFgpi+w9mg1IY+3gUZ
 hS3uwvk7tsZWbpJXPUqGPxUVVS34YOFbQq+j7NDk7zbLZAQBJ/go//Cy7oRaUs66ZZpf
 MrYWMAwKE0oByeqFjKUVO+vRt/fOI8isLdX+Vsn/nww6URmArglHPeSfd3hr8hCzxQ57
 2soKcYXJuobc0aQ1jepgNvqvyMehVBWBiv9YuMwys2fADRD/0ieWY00uUSfCvZqLEcuz QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gppbskydv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jun 2022 04:50:37 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25G4oas5015891;
        Thu, 16 Jun 2022 04:50:36 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gppbsky8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jun 2022 04:50:35 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25G4agXG012607;
        Thu, 16 Jun 2022 04:47:47 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 3gmjp8w875-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jun 2022 04:47:47 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25G4lnJi25166196
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 04:47:49 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35FEA11C05C;
        Thu, 16 Jun 2022 04:47:45 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D62A11C04A;
        Thu, 16 Jun 2022 04:47:41 +0000 (GMT)
Received: from [9.109.205.170] (unknown [9.109.205.170])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 16 Jun 2022 04:47:41 +0000 (GMT)
Message-ID: <cbfe5abe-155b-ac79-2daa-06d9dd60b55a@linux.ibm.com>
Date:   Thu, 16 Jun 2022 10:17:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 1/9] mm/demotion: Add support for explicit memory tiers
Content-Language: en-US
To:     Wei Xu <weixugc@google.com>, Ying Huang <ying.huang@intel.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>
References: <YqDncfLeEeBaosrY@cmpxchg.org>
 <02ee2c97-3bca-8eb6-97d8-1f8743619453@linux.ibm.com>
 <YqH74WaUzJlb+smt@cmpxchg.org> <20220609152243.00000332@Huawei.com>
 <YqJa4N/VlS4zN4vf@cmpxchg.org> <20220610105708.0000679b@Huawei.com>
 <YqdEEhJFr3SlfvSJ@cmpxchg.org>
 <4297bd21-e984-9d78-2bca-e70c11749a72@linux.ibm.com>
 <Yqdc4DE8gYJ3zesO@cmpxchg.org>
 <42f536af-b17d-b001-7b6b-2c6b928f3ecf@linux.ibm.com>
 <YqjZyP11O0yCMmiO@cmpxchg.org>
 <2b261518bbb5b8466301f8ab978f408141fa6e68.camel@intel.com>
 <CAAPL-u9hjR8sFeUYM46TXPg-Lho6hr0zaLvrGhg9=htRrPtjqw@mail.gmail.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <CAAPL-u9hjR8sFeUYM46TXPg-Lho6hr0zaLvrGhg9=htRrPtjqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: y0ubvEXHPYVM4LKj3n6euztfCvr1A9fm
X-Proofpoint-ORIG-GUID: pgtDHW9V_y_QlXsQnyTg-e-HOnbz5teF
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-16_01,2022-06-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=993
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2206160016
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/22 9:15 AM, Wei Xu wrote:
> On Wed, Jun 15, 2022 at 6:11 PM Ying Huang <ying.huang@intel.com> wrote:
>>
>> On Tue, 2022-06-14 at 14:56 -0400, Johannes Weiner wrote:
>>> On Tue, Jun 14, 2022 at 01:31:37PM +0530, Aneesh Kumar K V wrote:

....

>> As Jonathan Cameron pointed, we may need the memory tier ID to be
>> stable if possible.  I know this isn't a easy task.  At least we can
>> make the default memory tier (CPU local DRAM) ID stable (for example
>> make it always 128)?  That provides an anchor for users to understand.
> 
> One of the motivations of introducing "rank" is to allow memory tier
> ID to be stable, at least for the well-defined tiers such as the
> default memory tier.  The default memory tier can be moved around in
> the tier hierarchy by adjusting its rank position relative to other
> tiers, but its device ID can remain the same, e.g. always 1.
> 

With /sys/devices/system/memtier/default_tier userspace will be able query
the default tier details. Did you get to look at 

https://lore.kernel.org/linux-mm/7b72ccf4-f4ae-cb4e-f411-74d055482026@linux.ibm.com

Any reason why that will not work with all the requirements we had?

-aneesh
