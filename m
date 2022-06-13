Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BD0547E2E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 05:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbiFMDgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 23:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiFMDgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 23:36:33 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89691EEDF
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 20:36:29 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25D0R3Xd008359;
        Mon, 13 Jun 2022 03:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=mOoDWGB7EydBPF9Ik+XPm1A9YOjZdUII4wrBuyoU644=;
 b=L40rKrm6TLgoBA5MA1Dr0typbeVq3VSAPWbPSWwO3f/ZGJj/B8AgXteOgdzDvXFW5z89
 1IM6Fm9QDTPZ1Ff2mmom1f3qs/H3HGJL1GmuJNrgA44Oog4AQHN31/J28GYGIp2VjWN7
 jsudGKRMHEhM8fYkQrCAfroBcuSWha/0E3lC+Iz/YnQ/LRAWhrMm+ig6dAnAwNJJTg3z
 lB0DKN/+uJeiFJ+UThyiNgOfyK43HQfBTO4AkG0t6k6ddJgQQi91eaV8ridgipnuqcax
 WrHXhhelbMrSqKkTP4nrGLhz3daJlD0y/5Vh2xBHfTsObW8r3yIUXD/7DYW/Qhj3PyBx 1A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gn4btfdjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jun 2022 03:36:13 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25D3SLNc008981;
        Mon, 13 Jun 2022 03:36:13 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gn4btfdja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jun 2022 03:36:12 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25D3YWnm018607;
        Mon, 13 Jun 2022 03:36:10 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3gmjp9a2m5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jun 2022 03:36:10 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25D3a8vD21954816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 03:36:08 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A5DFA4054;
        Mon, 13 Jun 2022 03:36:08 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23162A405B;
        Mon, 13 Jun 2022 03:36:02 +0000 (GMT)
Received: from [9.43.31.74] (unknown [9.43.31.74])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 13 Jun 2022 03:36:01 +0000 (GMT)
Message-ID: <9da3c6ef-ba0d-6229-2188-0956222b04f1@linux.ibm.com>
Date:   Mon, 13 Jun 2022 09:05:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 03/13] mm/demotion: Return error on write to
 numa_demotion sysfs
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
References: <20220610135229.182859-1-aneesh.kumar@linux.ibm.com>
 <20220610135229.182859-4-aneesh.kumar@linux.ibm.com>
 <7ed1f9f544937b5c82ab380a4977e5ae22a98c43.camel@intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <7ed1f9f544937b5c82ab380a4977e5ae22a98c43.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VfU3si42Rok7hZ8iK0YsK1WAmg2EyfB-
X-Proofpoint-GUID: -D-BGNBb1htv25Zi-4DVWOSLJFfyQFcY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-13_01,2022-06-09_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206130014
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/22 8:56 AM, Ying Huang wrote:
> On Fri, 2022-06-10 at 19:22 +0530, Aneesh Kumar K.V wrote:
>> With CONFIG_MIGRATION disabled return EINVAL on write.
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>   mm/memory-tiers.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
>> index 9c6b40d7e0bf..c3123a457d90 100644
>> --- a/mm/memory-tiers.c
>> +++ b/mm/memory-tiers.c
>> @@ -105,6 +105,9 @@ static ssize_t numa_demotion_enabled_store(struct kobject *kobj,
>>   {
>>   	ssize_t ret;
>>   
>>
>> +	if (!IS_ENABLED(CONFIG_MIGRATION))
>> +		return -EINVAL;
>> +
> 
> How about enclose numa_demotion_enabled_xxx related code with CONFIG_MIGRATION?
> 

IIUC there is a desire to use IS_ENABLED() in the kernel instead of 
#ifdef since that helps in more compile time checks. Because there are 
no dead codes during compile now with IS_ENABLED().

W.r.t leaving the sysfs file visible even when CONFIG_MIGRATION is 
disabled, I was thinking it gives better visibility into numa_demotion 
status. I could switch to hide numa_demotion file if that is desirable.

>>   	ret = kstrtobool(buf, &numa_demotion_enabled);
>>   	if (ret)
>>   		return ret;
> 

-aneesh
