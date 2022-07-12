Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E3257160E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 11:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiGLJr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 05:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiGLJrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 05:47:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26133A43AF;
        Tue, 12 Jul 2022 02:47:54 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26C9Llim004045;
        Tue, 12 Jul 2022 09:47:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=IBp666Al1yErZhbHI0qPXer0GCek9TEtlvmtmhbeUjU=;
 b=P0FfqkC39sCCy24s410Jpx95Zao0+1doWjF5mImJpHs4nNzqtovNDI172vBpoAhBv72B
 bRb2QMLU41yhleQnA0eo9o2xLjcY4doy7WSKsiybZR20+2FzJOI1ASifLfB+w7Ogj84H
 mFIBDfbS0BHrvDXNGcA8vOVtbXz2wMalE0txclmXCIYr+dznMRwMOCUrqzZXYbYuoixw
 i5tm8TXoeQQWfr/Z4cGfsCaJvBeHwy8jYbtex/9G5nxppf6lq+r+fa+geFmtNSGnEBCb
 WCJeEZHvvImItIqPmetNZzcRvQElntyxvesjxI+R7u5jSCc+LXciCVnTpyvGhNLhICPc jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h968s8h6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 09:47:21 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26C9bJNk005741;
        Tue, 12 Jul 2022 09:47:20 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h968s8h6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 09:47:20 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26C9Lg8e017242;
        Tue, 12 Jul 2022 09:47:18 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3h71a8jyev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 09:47:18 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26C9jlPb18809328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 09:45:47 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F692AE051;
        Tue, 12 Jul 2022 09:47:16 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEB1EAE04D;
        Tue, 12 Jul 2022 09:47:15 +0000 (GMT)
Received: from [9.101.4.33] (unknown [9.101.4.33])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Jul 2022 09:47:15 +0000 (GMT)
Message-ID: <91d24dcb-c7b6-b0d2-2522-c8177b80094d@linux.ibm.com>
Date:   Tue, 12 Jul 2022 11:47:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.1
Subject: Re: [PATCH v3 4/4] pseries/mobility: set NMI watchdog factor during
 LPM
Content-Language: fr
To:     Nicholas Piggin <npiggin@gmail.com>, nathanl@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux@roeck-us.net,
        haren@linux.vnet.ibm.com, benh@kernel.crashing.org,
        linuxppc-dev@lists.ozlabs.org, linux-watchdog@vger.kernel.org,
        mpe@ellerman.id.au, paulus@samba.org, wim@linux-watchdog.org
References: <20220627135347.32624-1-ldufour@linux.ibm.com>
 <20220627135347.32624-5-ldufour@linux.ibm.com>
 <1657590189.b3s2aqv3sj.astroid@bobo.none>
From:   Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <1657590189.b3s2aqv3sj.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bih01pDpn9eUqPM6t_PgQsG1pP2Axqxk
X-Proofpoint-ORIG-GUID: uN4-m8-8_YISOpX0T5C7sCtIaZFv_AgQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_05,2022-07-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120035
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 12/07/2022 à 03:46, Nicholas Piggin a écrit :
> Excerpts from Laurent Dufour's message of June 27, 2022 11:53 pm:
>> During a LPM, while the memory transfer is in progress on the arrival side,
>> some latencies is generated when accessing not yet transferred pages on the
>> arrival side. Thus, the NMI watchdog may be triggered too frequently, which
>> increases the risk to hit a NMI interrupt in a bad place in the kernel,
>> leading to a kernel panic.
>>
>> Disabling the Hard Lockup Watchdog until the memory transfer could be a too
>> strong work around, some users would want this timeout to be eventually
>> triggered if the system is hanging even during LPM.
>>
>> Introduce a new sysctl variable nmi_watchdog_factor. It allows to apply
>> a factor to the NMI watchdog timeout during a LPM. Just before the CPU are
>> stopped for the switchover sequence, the NMI watchdog timer is set to
>>  watchdog_tresh + factor%
>>
>> A value of 0 has no effect. The default value is 200, meaning that the NMI
>> watchdog is set to 30s during LPM (based on a 10s watchdog_tresh value).
>> Once the memory transfer is achieved, the factor is reset to 0.
>>
>> Setting this value to a high number is like disabling the NMI watchdog
>> during a LPM.
>>
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
>>  
>> +nmi_watchdog_factor (PPC only)
>> +==================================
>> +
>> +Factor apply to to the NMI watchdog timeout (only when ``nmi_watchdog`` is
>> +set to 1). This factor represents the percentage added to
>> +``watchdog_thresh`` when calculating the NMI watchdog timeout during a
>> +LPM. The soft lockup timeout is not impacted.
> 
> Could "LPM" or "mobility" be a bit more prominent in the parameter name
> and documentation? Something else might want to add a factor as well,
> one day.

In the V2 version, Nathan suggested "making the user-visible
name more generic (e.g. "nmi_watchdog_factor") in case it makes sense to
apply this to other contexts in the future."

So I made the change to a more generic name. I think this is a good option
since the documentation is explicit about the LPM particular case.
If in the future this factor needs to apply during an other operation that
name will be generic enough.

Do you agree ?

> 
> Otherwise the code looks okay.
> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> 
>> +
>> +A value of 0 means no change. The default value is 200 meaning the NMI
>> +watchdog is set to 30s (based on ``watchdog_thresh`` equal to 10).
>> +
>> +
>>  numa_balancing
>>  ==============
>>  
>> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
>> index 907a779074d6..649155faafc2 100644
>> --- a/arch/powerpc/platforms/pseries/mobility.c
>> +++ b/arch/powerpc/platforms/pseries/mobility.c
>> @@ -48,6 +48,39 @@ struct update_props_workarea {
>>  #define MIGRATION_SCOPE	(1)
>>  #define PRRN_SCOPE -2
>>  
>> +#ifdef CONFIG_PPC_WATCHDOG
>> +static unsigned int nmi_wd_factor = 200;
>> +
>> +#ifdef CONFIG_SYSCTL
>> +static struct ctl_table nmi_wd_factor_ctl_table[] = {
>> +	{
>> +		.procname	= "nmi_watchdog_factor",
>> +		.data		= &nmi_wd_factor,
>> +		.maxlen		= sizeof(int),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_douintvec_minmax,
>> +	},
>> +	{}
>> +};
>> +static struct ctl_table nmi_wd_factor_sysctl_root[] = {
>> +	{
>> +		.procname       = "kernel",
>> +		.mode           = 0555,
>> +		.child          = nmi_wd_factor_ctl_table,
>> +	},
>> +	{}
>> +};
>> +
>> +static int __init register_nmi_wd_factor_sysctl(void)
>> +{
>> +	register_sysctl_table(nmi_wd_factor_sysctl_root);
>> +
>> +	return 0;
>> +}
>> +device_initcall(register_nmi_wd_factor_sysctl);
>> +#endif /* CONFIG_SYSCTL */
>> +#endif /* CONFIG_PPC_WATCHDOG */
>> +
>>  static int mobility_rtas_call(int token, char *buf, s32 scope)
>>  {
>>  	int rc;
>> @@ -702,13 +735,20 @@ static int pseries_suspend(u64 handle)
>>  static int pseries_migrate_partition(u64 handle)
>>  {
>>  	int ret;
>> +	unsigned int factor = 0;
>>  
>> +#ifdef CONFIG_PPC_WATCHDOG
>> +	factor = nmi_wd_factor;
>> +#endif
>>  	ret = wait_for_vasi_session_suspending(handle);
>>  	if (ret)
>>  		return ret;
>>  
>>  	vas_migration_handler(VAS_SUSPEND);
>>  
>> +	if (factor)
>> +		watchdog_nmi_set_lpm_factor(factor);
>> +
>>  	ret = pseries_suspend(handle);
>>  	if (ret == 0) {
>>  		post_mobility_fixup();
>> @@ -716,6 +756,9 @@ static int pseries_migrate_partition(u64 handle)
>>  	} else
>>  		pseries_cancel_migration(handle, ret);
>>  
>> +	if (factor)
>> +		watchdog_nmi_set_lpm_factor(0);
>> +
>>  	vas_migration_handler(VAS_RESUME);
>>  
>>  	return ret;
>> -- 
>> 2.36.1
>>
>>

