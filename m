Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2BB5734C2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235821AbiGMK5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiGMK46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:56:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C768BFF5B3;
        Wed, 13 Jul 2022 03:56:56 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DApDnf002349;
        Wed, 13 Jul 2022 10:56:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=vBKz24vsY24wRxgj8ZLIKAAwqiimXAeKjx6naAU6jvI=;
 b=Vmwv5ifg/AGy4KQSihoiH7BDEL+DYfSC5AgjmPE5oGYqLeFBWZ5NoBw2deQFC0vvFGyj
 bdnVA4FisUEhDFpC0zxvYGln+36pYFWbUyVCNHm0d4m4Qg/ZFeH0yIdLkOTH33A0cMIS
 Q7/K8+WWle01LXpUfh2OwASiLZNwS9BN2FOqoOBwudccEhEZW0O5MKmB24C4aS4c4Ouk
 bL5cVQ59V0mFCrVtje3aU6XgVkWoVHEaH6xKOZyiVjvCNSpJoN2x9Jmz+hzk0PzTgYXu
 q/UIVnlCUMK6MUNFcCcHLJb9t0avAF7UqtK480gyHkZjNc8E62EBkdtUgqIwXszX+v9f +w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h9vneg29s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 10:56:27 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26DAtTZ0026656;
        Wed, 13 Jul 2022 10:56:27 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h9vneg294-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 10:56:26 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26DAqBCg024794;
        Wed, 13 Jul 2022 10:56:24 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3h99s78ys2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 10:56:24 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26DAuMCn15991270
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 10:56:22 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53DAFAE04D;
        Wed, 13 Jul 2022 10:56:22 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD5E2AE045;
        Wed, 13 Jul 2022 10:56:21 +0000 (GMT)
Received: from [9.145.2.121] (unknown [9.145.2.121])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Jul 2022 10:56:21 +0000 (GMT)
Message-ID: <d78f65a7-67bb-b5f3-007b-fca5a9f98a69@linux.ibm.com>
Date:   Wed, 13 Jul 2022 12:56:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.1
Subject: Re: [PATCH v4 4/4] pseries/mobility: set NMI watchdog factor during
 LPM
Content-Language: fr
To:     Randy Dunlap <rdunlap@infradead.org>, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu,
        wim@linux-watchdog.org, linux@roeck-us.net, nathanl@linux.ibm.com
Cc:     haren@linux.vnet.ibm.com, hch@infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-watchdog@vger.kernel.org
References: <20220712143202.23144-1-ldufour@linux.ibm.com>
 <20220712143202.23144-5-ldufour@linux.ibm.com>
 <a646b2e9-e7a7-3d52-413e-4e2b8c48e383@infradead.org>
From:   Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <a646b2e9-e7a7-3d52-413e-4e2b8c48e383@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: A9dxdZgGAg81nFs8xBByt43Gc7N6zqAz
X-Proofpoint-ORIG-GUID: EbrQsNumQJtaBYZCcd5TFFSi_vcfX3sm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_14,2022-07-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 clxscore=1011 bulkscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207130043
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 12/07/2022 à 18:25, Randy Dunlap a écrit :
> Hi--
> 
> On 7/12/22 07:32, Laurent Dufour wrote:
>> During a LPM, while the memory transfer is in progress on the arrival side,
>> some latencies is generated when accessing not yet transferred pages on the
> 
>                  are
> 
>> arrival side. Thus, the NMI watchdog may be triggered too frequently, which
>> increases the risk to hit a NMI interrupt in a bad place in the kernel,
> 
>                             an NMI
> 
>> leading to a kernel panic.
>>
>> Disabling the Hard Lockup Watchdog until the memory transfer could be a too
>> strong work around, some users would want this timeout to be eventually
>> triggered if the system is hanging even during LPM.
>>
>> Introduce a new sysctl variable nmi_watchdog_factor. It allows to apply
>> a factor to the NMI watchdog timeout during a LPM. Just before the CPU are
> 
>                                               an LPM.            the CPU is
> 
>> stopped for the switchover sequence, the NMI watchdog timer is set to
>>  watchdog_tresh + factor%
> 
>    watchdog_thresh
> 
>>
>> A value of 0 has no effect. The default value is 200, meaning that the NMI
>> watchdog is set to 30s during LPM (based on a 10s watchdog_tresh value).
> 
>                                                     watchdog_thresh
> 
>> Once the memory transfer is achieved, the factor is reset to 0.
>>
>> Setting this value to a high number is like disabling the NMI watchdog
>> during a LPM.
> 
>          an LPM.
> 
>>
>> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
>> ---
>>  Documentation/admin-guide/sysctl/kernel.rst | 12 ++++++
>>  arch/powerpc/platforms/pseries/mobility.c   | 43 +++++++++++++++++++++
>>  2 files changed, 55 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
>> index ddccd1077462..0bb0b7f27e96 100644
>> --- a/Documentation/admin-guide/sysctl/kernel.rst
>> +++ b/Documentation/admin-guide/sysctl/kernel.rst
>> @@ -592,6 +592,18 @@ to the guest kernel command line (see
>>  Documentation/admin-guide/kernel-parameters.rst).
>>  
> 
> This entire block should be in kernel-parameters.txt, not .rst,
> and it should be formatted like everything else in the .txt file.

Thanks for reviewing this patch.

I'll apply your requests in the next version.

However, regarding the change in kernel-parameters.txt, I'm confused. The
newly introduced parameter is only exposed through sysctl. Not as a kernel
boot option. In that case, should it be mentioned in kernel-parameters.txt?

Documentation/process/4.Coding.rst says:
The file :ref:`Documentation/admin-guide/kernel-parameters.rst
<kernelparameters>` describes all of the kernel's boot-time parameters.
Any patch which adds new parameters should add the appropriate entries to
this file.

And Documentation/process/submit-checklist.rst says:
16) All new kernel boot parameters are documented in
    ``Documentation/admin-guide/kernel-parameters.rst``.

What are the rules about editing .txt or .rst files?

>>  
>> +nmi_watchdog_factor (PPC only)
>> +==================================
>> +
>> +Factor apply to to the NMI watchdog timeout (only when ``nmi_watchdog`` is
> 
>    Factor to apply to the NMI
> 
>> +set to 1). This factor represents the percentage added to
>> +``watchdog_thresh`` when calculating the NMI watchdog timeout during a
> 
>                                                                  during an
> 
>> +LPM. The soft lockup timeout is not impacted.
>> +
>> +A value of 0 means no change. The default value is 200 meaning the NMI
>> +watchdog is set to 30s (based on ``watchdog_thresh`` equal to 10).
>> +
>> +
>>  numa_balancing
>>  ==============
>>  
> 
> 

