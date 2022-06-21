Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6CC552CFC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 10:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348266AbiFUI27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 04:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348290AbiFUI22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 04:28:28 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57923FD2E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 01:28:27 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25L7q61h029987;
        Tue, 21 Jun 2022 08:28:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=cqcomHDjPnfOqjVnU/f6TqQB1rpo3bhz5KUCGCRMf44=;
 b=q0tGtJJYJ32pzdkPSCfV14tBJbjFeWFL7Ni+UUx17aaYVxogbzR5oszyotqOoDSgXuh1
 DcntNkv1zPMGeHQBsuOpW9EWK0xwhwb6df5W0G4GWI2kfb/KxbHkkB7TGgOmFSBt9o6y
 EzsVus/hLB4vhwQXLPzWlJvwhOE//Cp2OeQIIiJUZpf+t8zuo8L0hTk1AiZWb1653ETZ
 yIrVarlpyR4K8hf4Y6ivf/Vc295h4/3fShFPYHk9Qg1GAZbsKSm6hRTDDuLycYYK0Q7f
 yFCGgb3jrpdEFn+PaTa5kyOtXxiD6AkIBaQCrPGBtmLiBxLmTPeY3UB6wINkFvLkd5mq fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gu9yp0vev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jun 2022 08:28:06 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25L8OlX9017752;
        Tue, 21 Jun 2022 08:28:05 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gu9yp0vcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jun 2022 08:28:05 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25L8Ln57023003;
        Tue, 21 Jun 2022 08:28:02 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3gs6b93nrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jun 2022 08:28:02 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25L8S5hH25297158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 08:28:05 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46128AE045;
        Tue, 21 Jun 2022 08:28:00 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2453FAE053;
        Tue, 21 Jun 2022 08:27:54 +0000 (GMT)
Received: from [9.43.38.129] (unknown [9.43.38.129])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Jun 2022 08:27:53 +0000 (GMT)
Message-ID: <b7e68fac-a8cf-fc3a-f064-4d150412b5fa@linux.ibm.com>
Date:   Tue, 21 Jun 2022 13:57:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 1/9] mm/demotion: Add support for explicit memory tiers
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim C Chen <tim.c.chen@intel.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
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
 <YqdEEhJFr3SlfvSJ@cmpxchg.org> <20220614174539.00004145@Huawei.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <20220614174539.00004145@Huawei.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Y93dljRNC91snUAKyp79bGp8YbKq0Z28
X-Proofpoint-GUID: KRoiiyMvV__nJrzwylXs-vUtApip1MHN
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-21_03,2022-06-17_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210035
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/22 10:15 PM, Jonathan Cameron wrote:
> 

...

>>
>> It could be simple tier0, tier1, tier2 numbering again, but the
>> numbers now would mean something to the user. A rank tunable is no
>> longer necessary.
> 
> This feels like it might make tier assignments a bit less stable
> and hence run into question of how to hook up accounting. Not my
> area of expertise though, but it was put forward as one of the reasons
> we didn't want hotplug to potentially end up shuffling other tiers
> around.  The desire was for a 'stable' entity.  Can avoid that with
> 'space' between them but then we sort of still have rank, just in a
> form that makes updating it messy (need to create a new tier to do
> it).
> 
>>

How about we do what is proposed here 

https://lore.kernel.org/linux-mm/7b72ccf4-f4ae-cb4e-f411-74d055482026@linux.ibm.com

The cgroup accounting patch posted here https://lore.kernel.org/linux-mm/cover.1655242024.git.tim.c.chen@linux.intel.com

looks at top tier accounting per cgroup and I am not sure what tier ID stability is expected
for top tier accounting. 

-aneesh
