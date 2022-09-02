Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659D15AA75E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 07:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbiIBFq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 01:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbiIBFqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 01:46:42 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1858B72A9
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 22:46:41 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2825KMdM009797;
        Fri, 2 Sep 2022 05:46:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=2kGDg9Dp2d0zhgJm9E003gVW+w2o3XLxDKCY1K/fko8=;
 b=HUJCxGSyMMAm7xwGx/rR+ONmhWP/0Domr5Uvr/oGfKe8MZSQelT+VZigPiC/jRplUGOY
 5A6DRTgal2IY+8mD8QpaHDjRlGm+aNI6BM78u6u/j4xKKWLCvS950wa2MALHRtpMIzPc
 GXmlACDy0fTeOb82fDxJIx4rY42IUauccaobAw+vRV4D9Vsak/uRSAnytZLQnOPuMdfw
 icYNMqZX9jP6mw6xs5tRxncBo06EZqp7NbMnfSk7aFoGAl+UtKrFZtc7ZyRSlNgUshdK
 7C/fekSjSXUi6968KC5AU+G2XRHHWDbGB3hr7j7zKTX3DRJ0CzmOdHbZO9BkF6+Ztz4u dw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jbbkm8skm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 05:46:26 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2825Svwt007914;
        Fri, 2 Sep 2022 05:46:25 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jbbkm8sjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 05:46:25 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2825a4qe026113;
        Fri, 2 Sep 2022 05:46:23 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 3j8hkacfdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 05:46:23 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2825kKZb39191008
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Sep 2022 05:46:21 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2CE44C04A;
        Fri,  2 Sep 2022 05:46:20 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 800C04C046;
        Fri,  2 Sep 2022 05:46:15 +0000 (GMT)
Received: from [9.43.64.219] (unknown [9.43.64.219])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  2 Sep 2022 05:46:15 +0000 (GMT)
Message-ID: <698120ce-d4df-3d13-dea9-a8f5c298783c@linux.ibm.com>
Date:   Fri, 2 Sep 2022 11:16:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 updated] mm/demotion: Expose memory tier details via
 sysfs
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Wei Xu <weixugc@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        jvgediya.oss@gmail.com, Bharata B Rao <bharata@amd.com>,
        Greg Thelen <gthelen@google.com>
References: <20220830081736.119281-1-aneesh.kumar@linux.ibm.com>
 <87tu5rzigc.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ad19e105-9290-922d-59e6-e6813a30f5f0@linux.ibm.com>
 <87pmgezkhp.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAAPL-u8MEs04DkHy6kaS788VjdYZZjAYOgzMnioOzDXbc0ZhhQ@mail.gmail.com>
 <d91beb53-e940-e02a-f9ca-3326bf914da7@linux.ibm.com>
 <87fshaz63h.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <87fshaz63h.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fMk2BmpsOaAYWWmk2fjHWEPQEsq66UsJ
X-Proofpoint-GUID: LTE2Qlv-iimLSGIL2cJnepsrskMFwPQr
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_12,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209020024
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/22 11:10 AM, Huang, Ying wrote:
> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
> 
>> On 9/2/22 10:39 AM, Wei Xu wrote:
>>> On Thu, Sep 1, 2022 at 5:33 PM Huang, Ying <ying.huang@intel.com> wrote:
>>>>
>>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>>>
>>>>> On 9/1/22 12:31 PM, Huang, Ying wrote:
>>>>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>>>>>
>>>>>>> This patch adds /sys/devices/virtual/memory_tiering/ where all memory tier
>>>>>>> related details can be found. All allocated memory tiers will be listed
>>>>>>> there as /sys/devices/virtual/memory_tiering/memory_tierN/
>>>>>>>
>>>>>>> The nodes which are part of a specific memory tier can be listed via
>>>>>>> /sys/devices/virtual/memory_tiering/memory_tierN/nodes
>>>>>>
>>>>>> I think "memory_tier" is a better subsystem/bus name than
>>>>>> memory_tiering.  Because we have a set of memory_tierN devices inside.
>>>>>> "memory_tier" sounds more natural.  I know this is subjective, just my
>>>>>> preference.
>>>>>>
>>
>>
>> I missed replying to this earlier. I will keep memory_tiering as subsystem name in v4 
>> because we would want it to a susbsystem where all memory tiering related details can be found
>> including memory type in the future. This is as per discussion 
>>
>> https://lore.kernel.org/linux-mm/CAAPL-u9TKbHGztAF=r-io3gkX7gorUunS2UfstudCWuihrA=0g@mail.gmail.com
> 
> I don't think that it's a good idea to mix 2 types of devices in one
> subsystem (bus).  If my understanding were correct, that breaks the
> driver core convention.
> 

All these are virtual devices .I am not sure i follow what you mean by 2 types of devices.
memory_tiering is a subsystem that represents all the details w.r.t memory tiering. It shows
details of memory tiers and can possibly contain details of different memory types .

-aneesh

