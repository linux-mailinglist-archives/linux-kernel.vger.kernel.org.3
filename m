Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4965C535D5E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350522AbiE0J13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239711AbiE0J11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:27:27 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A396548
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:27:25 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24R8sArd000532;
        Fri, 27 May 2022 09:27:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=t8EBwpfkFHX1SjfnpHYAe4xm1vCit66Y2YznnJxaBn0=;
 b=lHapQfOkRky3KDgkIM8wqHIWEcIfrdfFjc0pvxHARBbbb8pXxtCjcX/q401WhY4nKNKQ
 i/tUC2C5XE+0K6HT1wzJ4h7vX3Yt/6z4aZPa2SE0Kp5vdD5HN3KbJtlCSgNFHcnJTLIC
 vARywdGWpmGu1qeiXP3qBIAWS9DfhMtjY7h7BsGlpmtlFIxUAYsiyIGhjpckud0Rk7e/
 J9NOenCT8XxLND2sy+oGUuY5+XQfJPleX3qHhTieJqDXZyysqw/vE930t/EhXfHDZjOa
 2Q7zEqHrFW0tU5rFokBnb4dQRJLhHcc8v2CSYjcJxUSIPShpl9pSutrsT6GHdfe3Yce0 Hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gauhtrhwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 09:27:05 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24R9Nn3J016616;
        Fri, 27 May 2022 09:27:05 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gauhtrhw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 09:27:05 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24R9CQtB030765;
        Fri, 27 May 2022 09:27:03 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3g93uwbqkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 09:27:03 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24R9R0C534406864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 09:27:00 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3A8B52051;
        Fri, 27 May 2022 09:27:00 +0000 (GMT)
Received: from [9.43.91.191] (unknown [9.43.91.191])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 702965204F;
        Fri, 27 May 2022 09:26:54 +0000 (GMT)
Message-ID: <68dd0ea6-3a02-2bcc-cb63-ddd633428685@linux.ibm.com>
Date:   Fri, 27 May 2022 14:56:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: RFC: Memory Tiering Kernel Interfaces (v2)
Content-Language: en-US
To:     Wei Xu <weixugc@google.com>
Cc:     Ying Huang <ying.huang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tim C Chen <tim.c.chen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Feng Tang <feng.tang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Brice Goglin <brice.goglin@gmail.com>,
        Hesham Almatary <hesham.almatary@huawei.com>
References: <CAAPL-u-DGLcKRVDnChN9ZhxPkfxQvz9Sb93kVoX_4J2oiJSkUw@mail.gmail.com>
 <20220512160010.00005bc4@Huawei.com>
 <CAAPL-u_diGYEb7+WsgqNBLRix-nRCk2SsDj6p9r8j5JZwOABZQ@mail.gmail.com>
 <6b7c472b50049592cde912f04ca47c696caa2227.camel@intel.com>
 <CAAPL-u-NAJkSXHzQr8OtEEGnnUrsCE9US6c5S5Rv0xutASxv1Q@mail.gmail.com>
 <ad1bc96a86b21b8f46d356f0c0b7449be38b2220.camel@intel.com>
 <CAAPL-u8XzJnrew4vuFq7GgwgjjBff8MwRFGTDmUc9DOwa+q=FA@mail.gmail.com>
 <6ce724e5c67d4f7530457897fa08d0a8ba5dd6d0.camel@intel.com>
 <594046f8-9ab3-786a-fc48-8a61f1238f52@linux.ibm.com>
 <CAAPL-u-3-iOoSK07TE=gUN8a+TsXNNEiFaEArf7+zvTgxDJnRQ@mail.gmail.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <CAAPL-u-3-iOoSK07TE=gUN8a+TsXNNEiFaEArf7+zvTgxDJnRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2vtUL7YAd5vgFIdsUTvphglFbtkVJZcq
X-Proofpoint-ORIG-GUID: azZ6li0dR6Bzw9xJe0xMg2DozblJOo0k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-27_02,2022-05-25_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 spamscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 mlxscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205270042
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/22 10:57 PM, Wei Xu wrote:
> On Wed, May 25, 2022 at 3:01 AM Aneesh Kumar K V
> <aneesh.kumar@linux.ibm.com> wrote:
>>
>> On 5/25/22 2:33 PM, Ying Huang wrote:
>>> On Tue, 2022-05-24 at 22:32 -0700, Wei Xu wrote:
>>>> On Tue, May 24, 2022 at 1:24 AM Ying Huang <ying.huang@intel.com> wrote:
>>>>>
>>>>> On Tue, 2022-05-24 at 00:04 -0700, Wei Xu wrote:
>>>>>> On Thu, May 19, 2022 at 8:06 PM Ying Huang <ying.huang@intel.com> wrote:
>>>>>>>
>>
>> ...
>>
>>>
>>> OK.  Just to confirm.  Does this mean that we will have fixed device ID,
>>> for example,
>>>
>>> GPU                   memtier255
>>> DRAM (with CPU)               memtier0
>>> PMEM                  memtier1
>>>
>>> When we add a new memtier, it can be memtier254, or memter2?  The rank
>>> value will determine the real demotion order.
>>>
>>> I think you may need to send v3 to make sure everyone is at the same
>>> page.
>>>
>>
>> What we have implemented which we will send as RFC shortly is below.
>>
>> cd /sys/dekvaneesh@ubuntu-guest:~$ cd /sys/devices/system/
>> kvaneesh@ubuntu-guest:/sys/devices/system$ pwd
>> /sys/devices/system
>> kvaneesh@ubuntu-guest:/sys/devices/system$ ls
>> clockevents  clocksource  container  cpu  edac  memory  memtier  mpic
>> node  power
>> kvaneesh@ubuntu-guest:/sys/devices/system$ cd memtier/
>> kvaneesh@ubuntu-guest:/sys/devices/system/memtier$ pwd
>> /sys/devices/system/memtier
>> kvaneesh@ubuntu-guest:/sys/devices/system/memtier$ ls
>> default_rank  max_rank  memtier1  power  uevent
>> kvaneesh@ubuntu-guest:/sys/devices/system/memtier$ cat default_rank
>> 1
>> kvaneesh@ubuntu-guest:/sys/devices/system/memtier$ cat max_rank
>> 3
> 
> For flexibility, we don't want max_rank to be interpreted as the
> number of memory tiers.  Also, we want to leave spaces in rank values
> to allow new memtiers to be inserted when needed.  So I'd suggest to
> make max_rank a much larger value (e.g. 255).
> 
>> kvaneesh@ubuntu-guest:/sys/devices/system/memtier$ cd memtier1/
>> kvaneesh@ubuntu-guest:/sys/devices/system/memtier/memtier1$ ls
>> nodelist  power  rank  subsystem  uevent
>> kvaneesh@ubuntu-guest:/sys/devices/system/memtier/memtier1$ cat nodelist
>> 0-3
>> kvaneesh@ubuntu-guest:/sys/devices/system/memtier/memtier1$ cat rank
>> 1
>> kvaneesh@ubuntu-guest:/sys/devices/system/memtier/memtier1$ cd
>> ../../node/node1/
>> kvaneesh@ubuntu-guest:/sys/devices/system/node/node1$ cat memtier
>> 1
>> kvaneesh@ubuntu-guest:/sys/devices/system/node/node1$
>> root@ubuntu-guest:/sys/devices/system/node/node1# echo 0 > memtier
>> root@ubuntu-guest:/sys/devices/system/node/node1# cat memtier
>> 0
>> root@ubuntu-guest:/sys/devices/system/node/node1# cd ../../memtier/
>> root@ubuntu-guest:/sys/devices/system/memtier# ls
>> default_rank  max_rank  memtier0  memtier1  power  uevent
>> root@ubuntu-guest:/sys/devices/system/memtier# cd memtier0/
>> root@ubuntu-guest:/sys/devices/system/memtier/memtier0# cat nodelist
>> 1
>> root@ubuntu-guest:/sys/devices/system/memtier/memtier0# cat rank
>> 0
> 
> It looks like the example here demonstrates the dynamic creation of
> memtier0.  If so, how is the rank of memtier0 determined?  If we want
> to support creating new memtiers at runtime, I think an explicit
> interface that specifies both device ID and rank is preferred to avoid
> implicit dependencies between device IDs and ranks.
> 

Right now to keep it all simpler there is a 1:1 relation ship between 
memory tier and rank value. ie.

memory tier  rank
memtier0     100
memtier1     200
memtier2     300

Currently we are limiting this to max 3 tiers. Hence the above is very 
easy. Once we really get dynamic tier creation, we should be looking at 
creating a new memory tier with highest possible rank value. Once we 
establish the memory tier, we then modify the rank value to a desired 
value. There will be a kernel interface to add a node to a memory tier 
with specific rank value so drivers can do that if required.

I haven't gone to that implementation because i was hoping we could get 
to that later when we really start requiring dynamic tier support.

I will share the patch series we have been working with. I am yet to get 
the documentation added. But then i will not wait for it to be complete 
so that we can get some early testing/feedback.

-aneesh
