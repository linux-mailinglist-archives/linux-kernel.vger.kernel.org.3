Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EA0533A5F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 12:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiEYKBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 06:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiEYKBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 06:01:48 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80D1D123
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 03:01:47 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24P7wN9D014216;
        Wed, 25 May 2022 10:01:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=dm0uug5+uIiWqkn2DHSPXXlXd6rP5odE+jprPPDCXBU=;
 b=k2O3Q4br7uo7/+OoiXgrDG2uFpR3d8bBFkIl0ntwMzL+TB/oPnAzwC3mQ+J9ITHnBNdz
 jnuZItvNZa3hEa6bX5H1/GZPZPJ08T7OASyDgrydkC/639STxixD07rUKIC5mlDS7H/Y
 pTHH0s3P6CZ6mIAXlcMaD45IP4q0MNv+AxcyQlCKHz7GtoUj+AVjQBKu5e19H1fBNau7
 BSqg8uDUH9fI0xMA5KmahYsB907sbJFt2Js2N9Z/GbKctAJ1zYVGN83dpwmTE8mGRqYZ
 Nw2zRjUR/v4PlTBm8PmPZX3tOnCWA3j8QoImawvBwPnT38OMBBghVl7KZxSpQoDrkzrS pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g9ghca7f3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 May 2022 10:01:27 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24P9uVcx004025;
        Wed, 25 May 2022 10:01:26 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g9ghca7dw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 May 2022 10:01:26 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24P9wPbe000458;
        Wed, 25 May 2022 10:01:23 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3g93uw8xs0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 May 2022 10:01:23 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24PA0U2Y33358316
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 May 2022 10:00:30 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64C6B4C046;
        Wed, 25 May 2022 10:01:21 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC5924C04A;
        Wed, 25 May 2022 10:01:14 +0000 (GMT)
Received: from [9.43.37.143] (unknown [9.43.37.143])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 25 May 2022 10:01:14 +0000 (GMT)
Message-ID: <594046f8-9ab3-786a-fc48-8a61f1238f52@linux.ibm.com>
Date:   Wed, 25 May 2022 15:31:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: RFC: Memory Tiering Kernel Interfaces (v2)
Content-Language: en-US
To:     Ying Huang <ying.huang@intel.com>, Wei Xu <weixugc@google.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
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
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <6ce724e5c67d4f7530457897fa08d0a8ba5dd6d0.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rSGB9dYJ_Jo1Db1hvrQGY9yC-pgX5EIF
X-Proofpoint-GUID: 8cH7lq-A0U5FtmGo3wXCsVa7n35s9y52
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-25_03,2022-05-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205250046
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/22 2:33 PM, Ying Huang wrote:
> On Tue, 2022-05-24 at 22:32 -0700, Wei Xu wrote:
>> On Tue, May 24, 2022 at 1:24 AM Ying Huang <ying.huang@intel.com> wrote:
>>>
>>> On Tue, 2022-05-24 at 00:04 -0700, Wei Xu wrote:
>>>> On Thu, May 19, 2022 at 8:06 PM Ying Huang <ying.huang@intel.com> wrote:
>>>>>

...

> 
> OK.  Just to confirm.  Does this mean that we will have fixed device ID,
> for example,
> 
> GPU			memtier255
> DRAM (with CPU)		memtier0
> PMEM			memtier1
> 
> When we add a new memtier, it can be memtier254, or memter2?  The rank
> value will determine the real demotion order.
> 
> I think you may need to send v3 to make sure everyone is at the same
> page.
> 

What we have implemented which we will send as RFC shortly is below.

cd /sys/dekvaneesh@ubuntu-guest:~$ cd /sys/devices/system/
kvaneesh@ubuntu-guest:/sys/devices/system$ pwd
/sys/devices/system
kvaneesh@ubuntu-guest:/sys/devices/system$ ls
clockevents  clocksource  container  cpu  edac  memory  memtier  mpic 
node  power
kvaneesh@ubuntu-guest:/sys/devices/system$ cd memtier/
kvaneesh@ubuntu-guest:/sys/devices/system/memtier$ pwd
/sys/devices/system/memtier
kvaneesh@ubuntu-guest:/sys/devices/system/memtier$ ls
default_rank  max_rank  memtier1  power  uevent
kvaneesh@ubuntu-guest:/sys/devices/system/memtier$ cat default_rank
1
kvaneesh@ubuntu-guest:/sys/devices/system/memtier$ cat max_rank
3
kvaneesh@ubuntu-guest:/sys/devices/system/memtier$ cd memtier1/
kvaneesh@ubuntu-guest:/sys/devices/system/memtier/memtier1$ ls
nodelist  power  rank  subsystem  uevent
kvaneesh@ubuntu-guest:/sys/devices/system/memtier/memtier1$ cat nodelist
0-3
kvaneesh@ubuntu-guest:/sys/devices/system/memtier/memtier1$ cat rank
1
kvaneesh@ubuntu-guest:/sys/devices/system/memtier/memtier1$ cd 
../../node/node1/
kvaneesh@ubuntu-guest:/sys/devices/system/node/node1$ cat memtier
1
kvaneesh@ubuntu-guest:/sys/devices/system/node/node1$
root@ubuntu-guest:/sys/devices/system/node/node1# echo 0 > memtier
root@ubuntu-guest:/sys/devices/system/node/node1# cat memtier
0
root@ubuntu-guest:/sys/devices/system/node/node1# cd ../../memtier/
root@ubuntu-guest:/sys/devices/system/memtier# ls
default_rank  max_rank  memtier0  memtier1  power  uevent
root@ubuntu-guest:/sys/devices/system/memtier# cd memtier0/
root@ubuntu-guest:/sys/devices/system/memtier/memtier0# cat nodelist
1
root@ubuntu-guest:/sys/devices/system/memtier/memtier0# cat rank
0
root@ubuntu-guest:/sys/devices/system/memtier/memtier0# echo 4 > rank
bash: rank: Permission denied
root@ubuntu-guest:/sys/devices/system/memtier/memtier0#
