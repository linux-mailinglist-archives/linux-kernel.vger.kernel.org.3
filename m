Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DBB547F3D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 07:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbiFMFto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 01:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237003AbiFMFtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 01:49:11 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5222607
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 22:48:54 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25D5FFCP037328;
        Mon, 13 Jun 2022 05:48:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=39W8RlxrwOaMEwVU56Gyx8hQG96IHYffjy4iH+NWIu0=;
 b=SMwwAo03iKeK4AspDY0tD6v0/sAxBa6MhFqY6B8cIr2WZlZHcafizwad0IuyD18YdijX
 lGCj7zAP84o8uP6QiPMOMJAZCJYLBCS1OLqYSbiFl18JfTteSjb4bXpECsP+w7rEq9/X
 UhErmOe34zc9s6ezhwB7ocv+kzCKINJnj8C58sLTR+sGhdeN2ZAw9snEP9rkX0bumRPZ
 VXm/OwKLzj/Yz3AqEI9WDmc7HxS9bA0F97TRre3EOo8pZWoDVlJyk3CuzF1oTDSIQEcd
 6tr4Hrklb2/z788pEsiLyYExM1Iry/eU8sMWRbBWT2uW9zT1LsfB/MKErR7tC5p+Fgah cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gn53qgk6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jun 2022 05:48:37 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25D5jU1c016687;
        Mon, 13 Jun 2022 05:48:36 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gn53qgk6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jun 2022 05:48:36 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25D5ablv013329;
        Mon, 13 Jun 2022 05:48:34 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3gmjaja7ey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jun 2022 05:48:34 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25D5mWnx17564066
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 05:48:32 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 044EBA405F;
        Mon, 13 Jun 2022 05:48:32 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9BA6A405C;
        Mon, 13 Jun 2022 05:48:25 +0000 (GMT)
Received: from [9.43.31.74] (unknown [9.43.31.74])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 13 Jun 2022 05:48:25 +0000 (GMT)
Message-ID: <e1e25713-3c06-5f31-e98f-20faa28d4ef9@linux.ibm.com>
Date:   Mon, 13 Jun 2022 11:18:23 +0530
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
 <9da3c6ef-ba0d-6229-2188-0956222b04f1@linux.ibm.com>
 <33b42a802a07721c639db99ed208ed43f743bb37.camel@intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <33b42a802a07721c639db99ed208ed43f743bb37.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jgh2KiALuHqjNDHhb_MdO_XDgKx05fcS
X-Proofpoint-ORIG-GUID: gHN1GEzleRD5iJChut3EoOhIQu4ngYnv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-13_02,2022-06-09_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206130026
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/22 11:03 AM, Ying Huang wrote:
> On Mon, 2022-06-13 at 09:05 +0530, Aneesh Kumar K V wrote:
>> On 6/13/22 8:56 AM, Ying Huang wrote:
>>> On Fri, 2022-06-10 at 19:22 +0530, Aneesh Kumar K.V wrote:
>>>> With CONFIG_MIGRATION disabled return EINVAL on write.
>>>>
>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>> ---
>>>>    mm/memory-tiers.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
>>>> index 9c6b40d7e0bf..c3123a457d90 100644
>>>> --- a/mm/memory-tiers.c
>>>> +++ b/mm/memory-tiers.c
>>>> @@ -105,6 +105,9 @@ static ssize_t numa_demotion_enabled_store(struct kobject *kobj,
>>>>    {
>>>>    	ssize_t ret;
>>>>    
>>>>
>>>>
>>>> +	if (!IS_ENABLED(CONFIG_MIGRATION))
>>>> +		return -EINVAL;
>>>> +
>>>
>>> How about enclose numa_demotion_enabled_xxx related code with CONFIG_MIGRATION?
>>>
>>
>> IIUC there is a desire to use IS_ENABLED() in the kernel instead of
>> #ifdef since that helps in more compile time checks. Because there are
>> no dead codes during compile now with IS_ENABLED().
> 
> IS_ENABLED() is used to reduce usage of "#ifdef" in ".c" file,
> especially inside a function.  We have good build test coverage with
> 0Day now.
> 
> To avoid code size inflate, it's better to use #ifdef CONFIG_MIGRATION.
> 

For a diff like below I am finding IS_ENABLED better.

size memory-tiers.o.isenabled memory-tiers.o
    text    data     bss     dec     hex filename
    4776     989       5    5770    168a memory-tiers.o.isenabled
    5257     990       5    6252    186c memory-tiers.o


modified   mm/memory-tiers.c
@@ -710,12 +710,11 @@ static int __meminit 
migrate_on_reclaim_callback(struct notifier_block *self,

  static void __init migrate_on_reclaim_init(void)
  {
-
-	if (IS_ENABLED(CONFIG_MIGRATION)) {
+#ifdef CONFIG_MIGRATION
  		node_demotion = kcalloc(MAX_NUMNODES, sizeof(struct demotion_nodes),
  					GFP_KERNEL);
  		WARN_ON(!node_demotion);
-	}
+#endif
  	hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
  }

@@ -844,14 +843,19 @@ static ssize_t numa_demotion_enabled_show(struct 
kobject *kobj,
  			  numa_demotion_enabled ? "true" : "false");
  }

+#ifdef CONFIG_MIGRATION
  static ssize_t numa_demotion_enabled_store(struct kobject *kobj,
  					   struct kobj_attribute *attr,
  					   const char *buf, size_t count)
  {
-	ssize_t ret;
-
-	if (!IS_ENABLED(CONFIG_MIGRATION))
-		return -EINVAL;
+	return -EINVAL;
+}
+#else
+static ssize_t numa_demotion_enabled_store(struct kobject *kobj,
+					   struct kobj_attribute *attr,
+					   const char *buf, size_t count)
+{
+		ssize_t ret;

  	ret = kstrtobool(buf, &numa_demotion_enabled);
  	if (ret)
@@ -859,6 +863,7 @@ static ssize_t numa_demotion_enabled_store(struct 
kobject *kobj,

  	return count;
  }
+#endif

  static struct kobj_attribute numa_demotion_enabled_attr =
  	__ATTR(demotion_enabled, 0644, numa_demotion_enabled_show,

I also find that #ifdef config not easier to the eyes. If there is a 
large code that we can end up #ifdef out, then it might be worth it. 
IIUC, we might want to keep the establish_migration target to find 
top_tier rank and lower_tier mask. Once we do that only thing that we 
could comment out is the node_demotion sysfs creation and I was 
considering to keep that even if migration is disabled with a write to 
the file returning EINVAL. I could switch that if you strongly feel that 
we should hide node_demotion sysfs file.

-aneesh
