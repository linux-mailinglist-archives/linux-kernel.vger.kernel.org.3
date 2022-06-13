Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3CB5497E6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236533AbiFMQfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 12:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244371AbiFMQep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 12:34:45 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E223D46141
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 07:23:40 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25DDtNxM020577;
        Mon, 13 Jun 2022 14:23:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=KSx5EN7o9Db5WN+FNVkIxbtaI4ppCzlB5T3plRq5fcM=;
 b=ReN6AAiZEGfERTluqOfPq//mrfxAAVYQPWO9DbdjTv9f7tJGQWkYglM9LNVzc9IgPTo7
 PP5LWMrIp8PSs6tMVcxB6iynCg4CU2gN4LZbObwIpg57Xnx5CEfLHyyHjGMRjO22qaBE
 gCTyOj19VcTfkLnIRFIzTpbdfgRO+0YkTrK90+wcRFkIF0MCTquF5jHVzDrM82hnPqLY
 eAPxk8C59W4xKmBQkMILPkRFL2vY21oN5RjXzChAXdOBmYmiVxslBohM+9+kcGKn0md5
 cH6WeznrgdrGP9kWBC/XCE5WqUD1UaI59xiNjd5QPJMoiKsBYPgFS9S8WX60gLIaw1YC Bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gn4c9s702-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jun 2022 14:23:18 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25DDtWxX023985;
        Mon, 13 Jun 2022 14:23:17 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gn4c9s6xw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jun 2022 14:23:17 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25DEKaYF027989;
        Mon, 13 Jun 2022 14:23:14 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3gmjp9axbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jun 2022 14:23:14 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25DENF2221430750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 14:23:15 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F049DA405F;
        Mon, 13 Jun 2022 14:23:11 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C0C8A405B;
        Mon, 13 Jun 2022 14:23:05 +0000 (GMT)
Received: from [9.43.31.74] (unknown [9.43.31.74])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 13 Jun 2022 14:23:05 +0000 (GMT)
Message-ID: <4297bd21-e984-9d78-2bca-e70c11749a72@linux.ibm.com>
Date:   Mon, 13 Jun 2022 19:53:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 1/9] mm/demotion: Add support for explicit memory tiers
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
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
References: <20220603134237.131362-2-aneesh.kumar@linux.ibm.com>
 <YqCuE87gCcrnAiXG@cmpxchg.org> <YqDGYjgjcS5OoS3P@cmpxchg.org>
 <a4af7598-7bd3-0e70-a434-b1237ca403d6@linux.ibm.com>
 <YqDncfLeEeBaosrY@cmpxchg.org>
 <02ee2c97-3bca-8eb6-97d8-1f8743619453@linux.ibm.com>
 <YqH74WaUzJlb+smt@cmpxchg.org> <20220609152243.00000332@Huawei.com>
 <YqJa4N/VlS4zN4vf@cmpxchg.org> <20220610105708.0000679b@Huawei.com>
 <YqdEEhJFr3SlfvSJ@cmpxchg.org>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <YqdEEhJFr3SlfvSJ@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KaKBm1vH7dsTp6c7uSo-wBq2VCVXRLkG
X-Proofpoint-ORIG-GUID: g4mFP2TOUU9Fk2O5Ore_l5Gza6me581L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-13_06,2022-06-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2206130063
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/22 7:35 PM, Johannes Weiner wrote:
> On Fri, Jun 10, 2022 at 10:57:08AM +0100, Jonathan Cameron wrote:
>>

....

>> I'm not sure completely read only is flexible enough (though mostly RO is fine)
>> as we keep sketching out cases where any attempt to do things automatically
>> does the wrong thing and where we need to add an extra tier to get
>> everything to work.  Short of having a lot of tiers I'm not sure how
>> we could have the default work well.  Maybe a lot of "tiers" is fine
>> though perhaps we need to rename them if going this way and then they
>> don't really work as current concept of tier.
>>
>> Imagine a system with subtle difference between different memories such
>> as 10% latency increase for same bandwidth.  To get an advantage from
>> demoting to such a tier will require really stable usage and long
>> run times. Whilst you could design a demotion scheme that takes that
>> into account, I think we are a long way from that today.
> 
> Good point: there can be a clear hardware difference, but it's a
> policy choice whether the MM should treat them as one or two tiers.
> 
> What do you think of a per-driver/per-device (overridable) distance
> number, combined with a configurable distance cutoff for what
> constitutes separate tiers. E.g. cutoff=20 means two devices with
> distances of 10 and 20 respectively would be in the same tier, devices
> with 10 and 100 would be in separate ones. The kernel then generates
> and populates the tiers based on distances and grouping cutoff, and
> populates the memtier directory tree and nodemasks in sysfs.
> 

Right now core/generic code doesn't get involved in building tiers. It 
just defines three tiers where drivers could place the respective 
devices they manage. The above suggestion would imply we are moving 
quite a lot of policy decision logic into the generic code?.

At some point, we will have to depend on more attributes other than 
distance(may be HMAT?) and each driver should have the flexibility to 
place the device it is managing in a specific tier? By then we may 
decide to support more than 3 static tiers which the core kernel 
currently does.

If the kernel still can't make the right decision, userspace could 
rearrange them in any order using rank values. Without something like 
rank, if userspace needs to fix things up,  it gets hard with device
hotplugging. ie, the userspace policy could be that any new PMEM tier 
device that is hotplugged, park it with a very low-rank value and hence 
lowest in demotion order by default. (echo 10 > 
/sys/devices/system/memtier/memtier2/rank) . After that userspace could 
selectively move the new devices to the correct memory tier?


> It could be simple tier0, tier1, tier2 numbering again, but the
> numbers now would mean something to the user. A rank tunable is no
> longer necessary.
> 
> I think even the nodemasks in the memtier tree could be read-only
> then, since corrections should only be necessary when either the
> device distance is wrong or the tier grouping cutoff.
> 
> Can you think of scenarios where that scheme would fall apart?

-aneesh
