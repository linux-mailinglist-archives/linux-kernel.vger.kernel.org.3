Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024595A112E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241327AbiHYMyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240377AbiHYMyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:54:35 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579AFA721B
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:54:33 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PC1d6j006678;
        Thu, 25 Aug 2022 12:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=JXJTeAFLjGbTPB31TrngTzP3pz50Nkwyj8KzO+dTnrQ=;
 b=HagTHqtLj9Y+lOI+ok+RaGCpDfTtDgZy8oGRto72ELnlxpJ8OeIcKF3gJW05HZx6I4/z
 Tqn4B9Wk6O2pXj2UvuseUVg2bXJviuyZalzb02m7FkPSMxhbfu3TThTGHYtt8JMeW4I4
 GABXXc1MFZ4RLryKsqwZ/36JpIgKBgstJBs5hpeyjTRvkOSG1o2CKZ+Kg1uwdFyUzlun
 MDj5NeHfpCIB0sCT3L4bAU3if8tNpmJaUeB3kliO2EXn/LAhWMwYiSt6HBZF1ew8hJAo
 kWcPEf5kdKHncTJzd2y3ulbcLQ1oPFQZziLy2ZHlOG2dpAepEWdwfCbfZyOwEDLlk07t cQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j68qpsp2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 12:54:12 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27PCJUX6022043;
        Thu, 25 Aug 2022 12:54:11 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j68qpsp1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 12:54:11 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27PCpuVb014764;
        Thu, 25 Aug 2022 12:54:08 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 3j2q89cqdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 12:54:08 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27PCs6gb34013444
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 12:54:06 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D46C4C052;
        Thu, 25 Aug 2022 12:54:06 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92F204C040;
        Thu, 25 Aug 2022 12:54:00 +0000 (GMT)
Received: from [9.43.112.25] (unknown [9.43.112.25])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 25 Aug 2022 12:54:00 +0000 (GMT)
Message-ID: <5b0d911b-4cc2-f1ae-b33b-79aca6e3124c@linux.ibm.com>
Date:   Thu, 25 Aug 2022 18:23:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] mm/demotion: Fix kernel error with memory hotplug
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
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
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com,
        Bharata B Rao <bharata@amd.com>
References: <20220825092019.379069-1-aneesh.kumar@linux.ibm.com>
 <0602b3b4-214f-94b1-61fe-2b2528ff529b@redhat.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <0602b3b4-214f-94b1-61fe-2b2528ff529b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rDUA-6ZSQwxEYfwlhEU1XH5m_kPgFM1N
X-Proofpoint-GUID: lCg1CErdjr_YCsJx5Xzfwd0ilFSFmZgg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_05,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208250049
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/22 5:46 PM, David Hildenbrand wrote:
> On 25.08.22 11:20, Aneesh Kumar K.V wrote:
>> On memory hot unplug, the kernel removes the node memory type
>> from the associated memory tier. Use list_del_init instead of
>> list del such that the same memory type can be added back
>> to a memory tier on hotplug.
>>
>> Without this, we get the below warning and return error on
>> adding memory type to a new memory tier.
>>
>> [   33.596095] ------------[ cut here ]------------
>> [   33.596099] WARNING: CPU: 3 PID: 667 at mm/memory-tiers.c:115 set_node_memory_tier+0xd6/0x2e0
>> [   33.596109] Modules linked in: kmem
>>
>> ...
>>
>> [   33.596126] RIP: 0010:set_node_memory_tier+0xd6/0x2e0
>>
>> ....
>> [   33.596196]  memtier_hotplug_callback+0x48/0x68
>> [   33.596204]  blocking_notifier_call_chain+0x80/0xc0
>> [   33.596211]  online_pages+0x25e/0x280
>> [   33.596218]  memory_block_change_state+0x176/0x1f0
>> [   33.596225]  memory_subsys_online+0x37/0x40
>> [   33.596230]  online_store+0x9b/0x130
>> [   33.596236]  kernfs_fop_write_iter+0x128/0x1b0
>> [   33.596242]  vfs_write+0x24b/0x2c0
>> [   33.596249]  ksys_write+0x74/0xe0
>> [   33.596254]  do_syscall_64+0x43/0x90
>> [   33.596259]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>> Fixes: mm/demotion: Add hotplug callbacks to handle new numa node onlined
> 
> Do we have a proper 12-digit commit id as well?
> 
> Do we have to cc stable?
> 

That patch is not yet merged upstream. It is in mm-unstable. I guess Andrew can fold the change
into the original patch?

-aneesh
