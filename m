Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA3A5A8E3E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 08:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbiIAGZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 02:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbiIAGZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 02:25:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4430B32EF8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 23:25:17 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28166KZL006068;
        Thu, 1 Sep 2022 06:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=QQhCb+FskmjfqMLGykfJhvDY+A7IPLRr+13M5HvxOgs=;
 b=Htb8quhdnDGbqIWUfHELpGZxxgu1sEaqYfr46FAtY8xeNZE6K43RHZFct69e37NK5xW0
 gUv4+L7GpPVphcJJ/OBUjzFGuHlz68FEIHJkVFPW3yd6KO3IIajqg42vZjCcIaiTxo0e
 MWhfOQxz9REJerFJJE/osBrGkzldTsBHkjB7KwrH+UM84BpuLKz8G9UC1fUsfEb7+4F4
 vCXM9wVgiYqLRHabJ7vT+3K+9s88a/94nNLd7he3ZQWdvsxDDYyBv54STZAzlBNg1TUN
 1Nvy/1NWHctDmfW/39lLhCA9YOc/aigsyIIlM1oChymt4qmo02fdHegfMTYaE4VsNYDh ZA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jaq660k56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 06:24:53 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28166x7O009721;
        Thu, 1 Sep 2022 06:24:53 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jaq660k4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 06:24:53 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2816LpR9010778;
        Thu, 1 Sep 2022 06:24:51 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3j7aw968um-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 06:24:51 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2816OmQs40108362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Sep 2022 06:24:49 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF4AE4C040;
        Thu,  1 Sep 2022 06:24:48 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18E214C046;
        Thu,  1 Sep 2022 06:24:44 +0000 (GMT)
Received: from [9.43.54.15] (unknown [9.43.54.15])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  1 Sep 2022 06:24:43 +0000 (GMT)
Message-ID: <c484fb58-6bc2-1103-a95d-1587232f56ba@linux.ibm.com>
Date:   Thu, 1 Sep 2022 11:54:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH mm-unstable] mm/demotion: Assign correct memory type for
 multiple dax devices with the same node affinity
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Yang Shi <shy828301@gmail.com>,
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
References: <20220826100224.542312-1-aneesh.kumar@linux.ibm.com>
 <87a67j1uyk.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <87a67j1uyk.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FRb_FSmd90YHyCtg5qXfIeO1w_Rb5Vto
X-Proofpoint-ORIG-GUID: ry5pEToQ3QWddUNlKrXvMEnPQHl_4ERG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_03,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010025
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/22 11:45 AM, Huang, Ying wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> 
>> With multiple dax devices having the same node affinity, the kernel wrongly assigned
>> default_dram memory type to some devices after the memory hotplug operation. Fix this by
>> not clearing node_memory_types on the dax device remove.
> 
> Sorry for late reply.
> 
> Just for confirmation.  There are multiple dax devices in one NUMA node?
> 
> If you can show the bug reproducing steps, that will make it even easier
> to understand.
> 

NUMA nodes are assigned per region and you can have multiple devdax namespace with same NUMA node affinity. 

dax0.1 and dax0.2 are examples. To recreate you can follow the below steps


root@ubuntu-guest:/sys/devices/system/node/node3# ls
compact  cpumap    meminfo   memory34  memory36  memory38  memory41  memory43  memory45  memory47  memory50  memory52  memory54  numastat   uevent
cpulist  distance  memory33  memory35  memory37  memory39  memory42  memory44  memory46  memory49  memory51  memory53  memory55  subsystem  vmstat
root@ubuntu-guest:/sys/devices/system/node/node3#
root@ubuntu-guest:/sys/devices/system/node/node3# for mem in memory*; do echo 0 > $mem/online; done
root@ubuntu-guest:/sys/devices/system/node/node3# cd /sys/bus/dax/drivers
root@ubuntu-guest:/sys/bus/dax/drivers# echo dax0.0  > kmem/unbind
root@ubuntu-guest:/sys/bus/dax/drivers# cd /sys/devices/system/node/node3/
root@ubuntu-guest:/sys/devices/system/node/node3# ls
compact  cpumap    meminfo   memory42  memory44  memory46  memory49  memory51  memory53  memory55  subsystem  vmstat
cpulist  distance  memory41  memory43  memory45  memory47  memory50  memory52  memory54  numastat  uevent
root@ubuntu-guest:/sys/devices/system/node/node3# for mem in memory*; do echo 1 > $mem/online; done


-aneesh

