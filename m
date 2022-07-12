Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AC45715CB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 11:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbiGLJcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 05:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiGLJcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 05:32:47 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638639CE2A;
        Tue, 12 Jul 2022 02:32:46 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26C9KNZw025228;
        Tue, 12 Jul 2022 09:32:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=XmYWgqj83kAvB7IYUnhipJfwQjztOHV9qvaI/YFkkY0=;
 b=gt3X6DN66wQJrOMyWURllhnXWSgsm5Ypt2IbGMKX7+lt+2lOoOV3dJNhTbzOUxuRLZc+
 OCpWyL3wnyJ6bnLccMZ/BpdxtNrbj8EhFjaa6yipHBKrlHneXwnLMSg8J46aElvrDjmL
 Nb0eDM70kd5Rzasw7LokEQop6RtGUDbEShl5sni2XNu+YZehS4+eDy7RAOxuqLt3JF+O
 Zr5Y61ryXG85P18MJnRA5bgE4ILr9/yIJTeHat/mZ/mI1Ioxm3Z7mMMiVZFsixnAQ6Vu
 F6AF2X2A7IFRG7S2bM/MEN3FeOLBQ7smMUOd97YDdTiP7SgUgF7shG0C8qyJeM0b+4fZ Zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h968587j6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 09:32:13 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26C9UERH010094;
        Tue, 12 Jul 2022 09:32:13 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h968587hm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 09:32:12 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26C9LcFx028652;
        Tue, 12 Jul 2022 09:32:11 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3h8rrn0vgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 09:32:10 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26C9WJtR21627376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 09:32:19 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA88CAE053;
        Tue, 12 Jul 2022 09:32:08 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37780AE04D;
        Tue, 12 Jul 2022 09:32:08 +0000 (GMT)
Received: from [9.101.4.33] (unknown [9.101.4.33])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Jul 2022 09:32:08 +0000 (GMT)
Message-ID: <121217bb-6a34-8ccb-9819-f82806d6f47c@linux.ibm.com>
Date:   Tue, 12 Jul 2022 11:32:07 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.1
Subject: Re: [PATCH v3 0/4] Extending NMI watchdog during LPM
To:     Nicholas Piggin <npiggin@gmail.com>, benh@kernel.crashing.org,
        haren@linux.vnet.ibm.com, linux@roeck-us.net, mpe@ellerman.id.au,
        nathanl@linux.ibm.com, paulus@samba.org, wim@linux-watchdog.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-watchdog@vger.kernel.org
References: <20220627135347.32624-1-ldufour@linux.ibm.com>
 <1657587920.49l4tue93d.astroid@bobo.none>
Content-Language: fr
From:   Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <1657587920.49l4tue93d.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: H2EY74HLAyxlLZ-8G_Yo9JC33dcKT-Oa
X-Proofpoint-ORIG-GUID: HIBY0d4mShO-WnF9wdGQfwRvbloRSyo3
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_05,2022-07-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 clxscore=1011 mlxscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120034
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 12/07/2022 à 03:21, Nicholas Piggin a écrit :
> Excerpts from Laurent Dufour's message of June 27, 2022 11:53 pm:
>> When a partition is transferred, once it arrives at the destination node,
>> the partition is active but much of its memory must be transferred from the
>> start node.
>>
>> It depends on the activity in the partition, but the more CPU the partition
>> has, the more memory to be transferred is likely to be. This causes latency
>> when accessing pages that need to be transferred, and often, for large
>> partitions, it triggers the NMI watchdog.
> 
> Importantly, it can require page in of code that runs with irqs 
> disabled, which is unlike a guest normally runs under PowerVM
> (but it can under KVM) which is why we enabled the watchdog under
> PowerVM but not KVM. So, okay it makes sense to mak an exception
> for this case.

On PowerVM, irqs disabled code may trigger multiple page in of data, which
is generating latencies too. Furthermore, the hypervisor is currently not
prioritizing page in operation based on the faulting CPU state. So the
kernel may have to wait for user page in operations to last.

> Thanks,
> Nick
> 
>> The NMI watchdog causes the CPU stack to dump where it appears to be
>> stuck. In this case, it does not bring much information since it can happen
>> during any memory access of the kernel.
>>
>> In addition, the NMI interrupt mechanism is not secure and can generate a
>> dump system in the event that the interruption is taken while MSR[RI]=0.
>>
>> Depending on the LPAR size and load, it may be interesting to extend the
>> NMI watchdog timer during the LPM.
>>
>> That's configurable through sysctl with the new introduced variable
>> (specific to powerpc) nmi_watchdog_factor. This value represents the
>> percentage added to watchdog_tresh to set the NMI watchdog timeout during a
>> LPM.
>>
>> Changes in v3:
>>  - don't export watchdog_mutex
>>  - fix a comment in mobilty.c, wait_for_vasi_session_completed()
>>  - fix a build issue when !CONFIG_PPC_WATCHDOG
>>  - rework some printk and rename the sysctl variable.
>>
>> v2:
>> https://lore.kernel.org/all/20220614135414.37746-1-ldufour@linux.ibm.com/
>>
>> Laurent Dufour (4):
>>   powerpc/mobility: wait for memory transfer to complete
>>   watchdog: export lockup_detector_reconfigure
>>   powerpc/watchdog: introduce a NMI watchdog's factor
>>   pseries/mobility: set NMI watchdog factor during LPM
>>
>>  Documentation/admin-guide/sysctl/kernel.rst | 12 +++
>>  arch/powerpc/include/asm/nmi.h              |  2 +
>>  arch/powerpc/kernel/watchdog.c              | 21 ++++-
>>  arch/powerpc/platforms/pseries/mobility.c   | 85 ++++++++++++++++++++-
>>  include/linux/nmi.h                         |  2 +
>>  kernel/watchdog.c                           | 21 +++--
>>  6 files changed, 135 insertions(+), 8 deletions(-)
>>
>> -- 
>> 2.36.1
>>
>>

