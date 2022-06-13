Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96EF549A57
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbiFMRsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238684AbiFMRrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:47:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6E514E2C8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 06:29:22 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25DCPhSP007022;
        Mon, 13 Jun 2022 13:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=qYUMEST+bP9k/kJYvw0TZMvwPo1yTFFJ5+kSY3p9rtA=;
 b=Fm+tL3fznS6TsNGSBlMve+XsoiSjZ7IZJWW5owD8Qk4+gTfwMZCuQUnXQTTP6pdsjXbB
 YO1AoMkHz+7EEqg0WsHFhtGeUnfLesWhf81chcuSdLYTIJ8qSkc/FJ5vG60YbITCwje1
 S0VAXtTqL0PNV/BRzZiD07hvf7rF/dr3hELXUvaj+XZx805tlA2m555icMV1BLzMl+6a
 RdcUfRnJIkCmy1yBfgxvBEe01trbYG4xt46U58FSorWShw0xd8QpINleX8kDtlZuvf8v
 9Mt+JnNCd7/WAzhs/TW6v6TtFH89BPSY57Q88r4M7hhZ/L5UoKBdA+k535tC39moLZib nQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gp5819abh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jun 2022 13:28:58 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25DDQdqi023792;
        Mon, 13 Jun 2022 13:28:57 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gp5819aax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jun 2022 13:28:57 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25DDMQUA012698;
        Mon, 13 Jun 2022 13:28:55 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3gmjp9aurh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jun 2022 13:28:55 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25DDSriV21627204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 13:28:53 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10B03A405B;
        Mon, 13 Jun 2022 13:28:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FB30A4054;
        Mon, 13 Jun 2022 13:28:46 +0000 (GMT)
Received: from [9.43.31.74] (unknown [9.43.31.74])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 13 Jun 2022 13:28:45 +0000 (GMT)
Message-ID: <080d64c3-1289-49c4-f4a0-105e5266a6f0@linux.ibm.com>
Date:   Mon, 13 Jun 2022 18:58:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 01/13] mm/demotion: Add support for explicit memory
 tiers
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Ying Huang <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
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
References: <20220610135229.182859-1-aneesh.kumar@linux.ibm.com>
 <20220610135229.182859-2-aneesh.kumar@linux.ibm.com>
 <7e0b41422dbd0976cb43c2f126e9371d5e311e77.camel@intel.com>
 <48096ad7-ce6d-79b7-1edd-7e6652ab2a4d@linux.ibm.com>
 <a88bd25fc77252dee4f895f3a9b2c1f6ebb5169e.camel@intel.com>
 <Yqc4nSEuso+YmPE7@cmpxchg.org>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <Yqc4nSEuso+YmPE7@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7vqlVs_ASNebhc5-mePDxHBzn4AZNUI0
X-Proofpoint-ORIG-GUID: JDNWtd59BKZomjhr8ISgYEAtZb9jgHRO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-13_05,2022-06-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206130059
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/22 6:46 PM, Johannes Weiner wrote:
> On Mon, Jun 13, 2022 at 01:30:08PM +0800, Ying Huang wrote:
>> On Mon, 2022-06-13 at 09:01 +0530, Aneesh Kumar K V wrote:
>>> On 6/13/22 8:52 AM, Ying Huang wrote:
>>>> On Fri, 2022-06-10 at 19:22 +0530, Aneesh Kumar K.V wrote:
>>>>> +config TIERED_MEMORY
>>>>> +	def_bool NUMA
>>>>> +
>>>>
>>>> As Yang pointed out, why not just use CONFIG_NUMA?  I suspect the
>>>> added value of CONIFIG_TIRED_MEMORY.
>>>
>>> I decided to use TIERED_MEMORY to bring more clarity. It should be same
>>> now that we have moved CONFIG_MIGRATION dependencies to runtime. IMHO
>>> having CONFIG_TIERED_MEMORY is better than using CONFIG_NUMA.
>>
>> I don't think CONFIG_TIERED_MEMORY bring no much value.  It's better
>> to use CONFIG_NUMA directly.  But this is just my opinion.
> 
> I agree. As long as it's always built with CONFIG_NUMA, it's simply
> NUMA code. Easy enough to modularize it later if somebody really wants
> this to be configurable separately.

I was comparing,

#ifdef CONFIG_TIERED_MEMORY
struct memory_tier {

vs

#ifdef CONFIG_NUMA
struct memory_tier {

I will switch to CONFIG_NUMA in the next update since you are not 
finding it beneficial.

-aneesh
