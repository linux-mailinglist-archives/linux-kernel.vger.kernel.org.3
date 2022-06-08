Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A88542AD1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbiFHJL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbiFHJJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:09:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B941E174C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:30:17 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25888tkT020221;
        Wed, 8 Jun 2022 08:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=k1WUGW+CseZlM/U5ZMobrezW0q2F7JrtYtGLV3YwYwA=;
 b=sMR4OpwTRdYzinHf0Bw/59hZP2+PbYSYmc+FgORSWuqrsMScOPYXLRYjRwoO3cZIxKrs
 AlvQhYZMnvdM1wzHyS7LlRZEolm1lfd8Fx4FfxnyBuxq8bxWT7g6SQczNVbifnmHGrYG
 4geqQI7PAVtLVwE6FUipl4BmBbUElhcm5CKNf8WYC21VZ/GmsN9LMsAfJhK89TfozcuE
 FmpAKmWCOkylM4CGZkhG9XK9+TfD0qlNuwcUd8393bRJ7nbKnvXd5Pdyize4lBJbU18i
 ZS2yZ2z58hlY478htcXFLvjnnh00pjIgKXb4pebcEwrkV1RmjBdL29cOm6yecgURJz/J zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gjr0mrd6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 08:30:06 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2588H2Lt027133;
        Wed, 8 Jun 2022 08:30:05 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gjr0mrd5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 08:30:05 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2588K1MV025197;
        Wed, 8 Jun 2022 08:30:03 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3gfy19cvkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 08:30:02 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2588TiSP24051968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jun 2022 08:29:44 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBCCB5204F;
        Wed,  8 Jun 2022 08:30:00 +0000 (GMT)
Received: from [9.43.53.124] (unknown [9.43.53.124])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id CC71C52052;
        Wed,  8 Jun 2022 08:29:55 +0000 (GMT)
Message-ID: <d695354e-4e7c-e0cd-603b-b585d80d5caa@linux.ibm.com>
Date:   Wed, 8 Jun 2022 13:59:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 6/9] mm/demotion: Add support for removing node from
 demotion memory tiers
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
 <20220603134237.131362-7-aneesh.kumar@linux.ibm.com>
 <a0a70b517bf1da920dca6082afa3fbc6aba77a67.camel@intel.com>
 <81956d2e-0bfe-78ba-5ad0-f6c388c2190e@linux.ibm.com>
 <06d04b6588b43ca010ec78ce0dee8127193f5562.camel@intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <06d04b6588b43ca010ec78ce0dee8127193f5562.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7hKwEvUMAfuKYHmBV0IBsxOrhjtCNuim
X-Proofpoint-ORIG-GUID: MY-XTz4ioShJcwhoDoswPNOzgtlkNjsz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-08_02,2022-06-07_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206080035
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 1:53 PM, Ying Huang wrote:
> On Wed, 2022-06-08 at 13:50 +0530, Aneesh Kumar K V wrote:
>> On 6/8/22 12:29 PM, Ying Huang wrote:
>>> On Fri, 2022-06-03 at 19:12 +0530, Aneesh Kumar K.V wrote:
>>>> This patch adds the special string "none" as a supported memtier value
>>>> that we can use to remove a specific node from being using as demotion target.
>>>>
>>>> For ex:
>>>> :/sys/devices/system/node/node1# cat memtier
>>>> 1
>>>> :/sys/devices/system/node/node1# cat ../../memtier/memtier1/nodelist
>>>> 1-3
>>>> :/sys/devices/system/node/node1# echo none > memtier
>>>> :/sys/devices/system/node/node1#
>>>> :/sys/devices/system/node/node1# cat memtier
>>>> :/sys/devices/system/node/node1# cat ../../memtier/memtier1/nodelist
>>>> 2-3
>>>> :/sys/devices/system/node/node1#
>>>
>>> Do you have a practical use case for this?  What kind of memory node
>>> needs to be removed from memory tiers demotion/promotion?
>>>
>>
>> This came up in our internal discussion. It was mentioned that there is
>> a need to skip some slow memory nodes from participating in demotion.
> 
> Again, can you provide a practical use case?  Why we shouldn't demote
> cold pages to these slow memory nodes?  How do we use these slow memory
> node?  These slow memory node is slower than disk?
> 

This was discussed in the context of memory borrowed from remote machine 
(aka OpenCAPI memory). In such case, we would have a memory only NUMA 
node which we want to avoid using for demotion.

-aneesh

