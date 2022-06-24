Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE07559572
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 10:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiFXI2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 04:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiFXI2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:28:12 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5361C120
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 01:27:55 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25O7DxX0029813;
        Fri, 24 Jun 2022 08:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HZ9Y6kMEq3gTA+gfWUEeM2x6fpuA+ur7EGjRFNSy54Y=;
 b=bPMHB6eu4+YVYt5kRoBvEe+FRmUoyVtf0Jj8Id4fuaisjI7G8SLtLTcK0u2OD8AnYaW+
 Zo8TNu3AVtuqeu4GidXRoZRD1O66z3i9NLa8CKN02WXQujWDg+NkVo0yN8L3TR4LZTGf
 6XQ02MQzdy4eeSucBb7xFIKuYHeDVfQ/7Aeg/YXOiakXk2SfXzAz3v7WukbHLj/NUNFC
 Dra8qUu0I/GhzRgsyIPdDS/V7iwyLrCqHJs4cfs4eKaS2mDHWaiAq05rrhk7x3N8JRl2
 kqSTVrqtAsESfinx+Gi/N1ZNwzHXbFRqQnhxFwczWHvJKo5tZlM3tvaSx8G+bopGvp7y pA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gw8ps1ngm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 08:27:35 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25O81Q7S018754;
        Fri, 24 Jun 2022 08:27:34 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gw8ps1nfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 08:27:34 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25O8KNgD028223;
        Fri, 24 Jun 2022 08:27:32 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3gvuj7s1gg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 08:27:32 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25O8Qe5J21627190
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 08:26:40 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FB08A405B;
        Fri, 24 Jun 2022 08:27:30 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17E3FA4054;
        Fri, 24 Jun 2022 08:27:30 +0000 (GMT)
Received: from [9.101.4.33] (unknown [9.101.4.33])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 24 Jun 2022 08:27:30 +0000 (GMT)
Message-ID: <145ac982-76fb-14d5-ec44-ed21be1d3f96@linux.ibm.com>
Date:   Fri, 24 Jun 2022 10:27:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/4] watchdog: export watchdog_mutex and
 lockup_detector_reconfigure
Content-Language: fr
To:     Michael Ellerman <mpe@ellerman.id.au>, benh@kernel.crashing.org,
        paulus@samba.org, nathanl@linux.ibm.com, haren@linux.vnet.ibm.com,
        npiggin@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20220614135414.37746-1-ldufour@linux.ibm.com>
 <20220614135414.37746-3-ldufour@linux.ibm.com>
 <871qve6084.fsf@mpe.ellerman.id.au>
From:   Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <871qve6084.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FP09REga5Tq6H8TGtaNXeK2BSkhfoxvY
X-Proofpoint-GUID: SMseGfFHH6MVyzpX7e3M2Ci4kLHjVJwn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-24_05,2022-06-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2206240030
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/2022, 08:31:55, Michael Ellerman wrote:
> Laurent Dufour <ldufour@linux.ibm.com> writes:
>> In some cricunstances it may be interesting to reconfigure the watchdog
>> from inside the kernel.
>>
>> On PowerPC, this may helpful before and after a LPAR migration (LPM) is
>> initiated, because it implies some latencies, watchdog, and especially NMI
>> watchdog is expected to be triggered during this operation. Reconfiguring
>> the watchdog, would prevent it to happen too frequently during LPM.
>>
>> The watchdog_mutex is exported to allow some variable to be changed under
>> its protection and prevent any conflict.
>> The lockup_detector_reconfigure() function is exported and is expected to
>> be called under the protection of watchdog_mutex.
>>
>> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
>> ---
>>  include/linux/nmi.h | 3 +++
>>  kernel/watchdog.c   | 6 +++---
>>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> Is there a maintainer for kernel/watchdog.c ?

Nothing clearly identified AFAICT.

I'll add the commit signers reported by get_maintainer.pl.

> There's Wim & Guenter at linux-watchdog@vger but I think that's only for
> drivers/watchdog?
> 
> Maybe we should Cc that list anyway?

Yes, that's a good idea.

> 
> 
>> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
>> index 750c7f395ca9..84300fb0f90a 100644
>> --- a/include/linux/nmi.h
>> +++ b/include/linux/nmi.h
>> @@ -122,6 +122,9 @@ int watchdog_nmi_probe(void);
>>  int watchdog_nmi_enable(unsigned int cpu);
>>  void watchdog_nmi_disable(unsigned int cpu);
>>  
>> +extern struct mutex watchdog_mutex;
>> +void lockup_detector_reconfigure(void);
> 
> It would be preferable if we didn't export the mutex.
> 
> I think you could arrange that by ...
> 
> Renaming lockup_detector_configure() to __lockup_detector_configure()
> and then adding a new lockup_detector_configure() that is non-static and
> takes the lock around __lockup_detector_configure().

Unfortunately, that will not be enough, because this mutex is also used to
protect wd_watchdog, to ensure it is not changed while another operation is
in progress.

I may try finding another way to protect that value, may be using
WRITE/READ_ONCE(). Indeed, the only requirement is to read a stable value
in watchdog_calc_timeouts().

Thanks,
Laurent.



