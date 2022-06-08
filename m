Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3D1542A40
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbiFHJDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbiFHJB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:01:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2973B168D1E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:21:30 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2587CP4I031377;
        Wed, 8 Jun 2022 08:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=IU+fKq91VoViJ1WRbcC3vvh3KJYWrI3EWyFa97WpR94=;
 b=hVZdLVPI7prFKOy8hYuz3mnkKtO3FT7Z2IBhPmx6/AO2BUngQueMTY0Fy8U94YvJ7+gM
 tJdGapaiBHpO9loarZbYpbVn411KLW4PhmLg3v0ZQAgh66lPgZ1jB7FWa1Y2vN05n+SY
 Bj732ZPgk50asCW/LhkPw3jqoGFsXPrxGK9rMhkm4Tn00bDBsVbNtUirNhORax5Q8OS7
 TZZopCQRHNb/IBj1XAghuWFq5jU0EGVKLTKwx9ZK5LaLdoe/QCk6fn3zaGZVI3n08Gwn
 x17AEXowYCWvHtiGQVjmVOoKBQ7KOjltErNUy38osCRN78bzEi9qI2OpEcaQOHmZNiov cQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gjq5w99c3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 08:21:03 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2587DRPD004028;
        Wed, 8 Jun 2022 08:21:02 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gjq5w99bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 08:21:02 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2588K6qf020023;
        Wed, 8 Jun 2022 08:20:59 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3gfy19cuxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 08:20:59 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2588Kv0m48169230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jun 2022 08:20:57 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 873FD5204E;
        Wed,  8 Jun 2022 08:20:57 +0000 (GMT)
Received: from [9.43.53.124] (unknown [9.43.53.124])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D147D5204F;
        Wed,  8 Jun 2022 08:20:51 +0000 (GMT)
Message-ID: <81956d2e-0bfe-78ba-5ad0-f6c388c2190e@linux.ibm.com>
Date:   Wed, 8 Jun 2022 13:50:50 +0530
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
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <a0a70b517bf1da920dca6082afa3fbc6aba77a67.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TFWKE6aCFd2VbH2mCXRQZzW2WF7AeNNg
X-Proofpoint-ORIG-GUID: oLucu96w3ZMNzVrmKu4x3xyZ8_PoQHMc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-08_02,2022-06-07_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206080035
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 12:29 PM, Ying Huang wrote:
> On Fri, 2022-06-03 at 19:12 +0530, Aneesh Kumar K.V wrote:
>> This patch adds the special string "none" as a supported memtier value
>> that we can use to remove a specific node from being using as demotion target.
>>
>> For ex:
>> :/sys/devices/system/node/node1# cat memtier
>> 1
>> :/sys/devices/system/node/node1# cat ../../memtier/memtier1/nodelist
>> 1-3
>> :/sys/devices/system/node/node1# echo none > memtier
>> :/sys/devices/system/node/node1#
>> :/sys/devices/system/node/node1# cat memtier
>> :/sys/devices/system/node/node1# cat ../../memtier/memtier1/nodelist
>> 2-3
>> :/sys/devices/system/node/node1#
> 
> Do you have a practical use case for this?  What kind of memory node
> needs to be removed from memory tiers demotion/promotion?
> 

This came up in our internal discussion. It was mentioned that there is 
a need to skip some slow memory nodes from participating in demotion.

-aneesh
