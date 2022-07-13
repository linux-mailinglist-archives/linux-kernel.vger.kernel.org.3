Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE665738B3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbiGMOXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiGMOXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:23:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E7632EC3;
        Wed, 13 Jul 2022 07:23:20 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DDDQ4d005014;
        Wed, 13 Jul 2022 14:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Heo0uLNDfOaFW8OcuQM/pabI+QakNuds5f6WntEJKOE=;
 b=R5t16WcyQA3oQwpcUYRt0LQTwIPMZtwjTFwSN78lP95TyPL0mjZVZAuS4Ede6eYFWWzz
 QPB3SrkIlT/TJTm4qQRTuz9coGD5LRKzbe2at3erhXxykJqWLQqRZ1eiC5Xr8YVKRgIs
 3hnIOc86oDWqxanPsGgBV/HF+QPTsCYaz46QKpiHjP9pCAvVyguOXcNYHv9wT62R7KSd
 Nuoxd2X30atOfFn8ZOQFbbaHt3l/iSqd4COzzxHZEmfUkPDxPT4r7rRqglK2oYjEW0RP
 EjmDkDeizLCYxiBsac9oGjpNuvUP/VfUznlV5HWwzExwbuP+q65MWyA+x2bYYVdxEs9J DA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h9w6acn7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 14:22:54 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26DEMsi1014224;
        Wed, 13 Jul 2022 14:22:54 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h9w6acn6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 14:22:54 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26DELkxL018854;
        Wed, 13 Jul 2022 14:22:51 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3h8rrn2py5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 14:22:51 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26DEMnBm19792306
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 14:22:49 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C5F7AE04D;
        Wed, 13 Jul 2022 14:22:49 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCC5AAE045;
        Wed, 13 Jul 2022 14:22:48 +0000 (GMT)
Received: from [9.145.2.121] (unknown [9.145.2.121])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Jul 2022 14:22:48 +0000 (GMT)
Message-ID: <c14bb788-f5ab-2233-93bd-702983982d80@linux.ibm.com>
Date:   Wed, 13 Jul 2022 16:22:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.1
Subject: Re: [PATCH v3 4/4] pseries/mobility: set NMI watchdog factor during
 LPM
Content-Language: fr
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     Nicholas Piggin <npiggin@gmail.com>, nathanl@linux.ibm.com
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        paulus@samba.org, linux@roeck-us.net, wim@linux-watchdog.org,
        linuxppc-dev@lists.ozlabs.org, haren@linux.vnet.ibm.com
References: <20220627135347.32624-1-ldufour@linux.ibm.com>
 <20220627135347.32624-5-ldufour@linux.ibm.com>
 <1657590189.b3s2aqv3sj.astroid@bobo.none>
 <91d24dcb-c7b6-b0d2-2522-c8177b80094d@linux.ibm.com>
In-Reply-To: <91d24dcb-c7b6-b0d2-2522-c8177b80094d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: g_KImgFJpySzZBFEX4vx4ME1Adxu0fYj
X-Proofpoint-ORIG-GUID: HGQgRuxRIqY95VflTpVa7PBfUNIq7TnG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-13_03,2022-07-13_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207130055
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 12/07/2022 à 11:47, Laurent Dufour a écrit :
> Le 12/07/2022 à 03:46, Nicholas Piggin a écrit :
>> Excerpts from Laurent Dufour's message of June 27, 2022 11:53 pm:
>>> During a LPM, while the memory transfer is in progress on the arrival side,
>>> some latencies is generated when accessing not yet transferred pages on the
>>> arrival side. Thus, the NMI watchdog may be triggered too frequently, which
>>> increases the risk to hit a NMI interrupt in a bad place in the kernel,
>>> leading to a kernel panic.
>>>
>>> Disabling the Hard Lockup Watchdog until the memory transfer could be a too
>>> strong work around, some users would want this timeout to be eventually
>>> triggered if the system is hanging even during LPM.
>>>
>>> Introduce a new sysctl variable nmi_watchdog_factor. It allows to apply
>>> a factor to the NMI watchdog timeout during a LPM. Just before the CPU are
>>> stopped for the switchover sequence, the NMI watchdog timer is set to
>>>  watchdog_tresh + factor%
>>>
>>> A value of 0 has no effect. The default value is 200, meaning that the NMI
>>> watchdog is set to 30s during LPM (based on a 10s watchdog_tresh value).
>>> Once the memory transfer is achieved, the factor is reset to 0.
>>>
>>> Setting this value to a high number is like disabling the NMI watchdog
>>> during a LPM.
>>>
>>> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
>>> ---
>>>  Documentation/admin-guide/sysctl/kernel.rst | 12 ++++++
>>>  arch/powerpc/platforms/pseries/mobility.c   | 43 +++++++++++++++++++++
>>>  2 files changed, 55 insertions(+)
>>>
>>> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
>>> index ddccd1077462..0bb0b7f27e96 100644
>>> --- a/Documentation/admin-guide/sysctl/kernel.rst
>>> +++ b/Documentation/admin-guide/sysctl/kernel.rst
>>> @@ -592,6 +592,18 @@ to the guest kernel command line (see
>>>  Documentation/admin-guide/kernel-parameters.rst).
>>>  
>>>  
>>> +nmi_watchdog_factor (PPC only)
>>> +==================================
>>> +
>>> +Factor apply to to the NMI watchdog timeout (only when ``nmi_watchdog`` is
>>> +set to 1). This factor represents the percentage added to
>>> +``watchdog_thresh`` when calculating the NMI watchdog timeout during a
>>> +LPM. The soft lockup timeout is not impacted.
>>
>> Could "LPM" or "mobility" be a bit more prominent in the parameter name
>> and documentation? Something else might want to add a factor as well,
>> one day.
> 
> In the V2 version, Nathan suggested "making the user-visible
> name more generic (e.g. "nmi_watchdog_factor") in case it makes sense to
> apply this to other contexts in the future."
> 
> So I made the change to a more generic name. I think this is a good option
> since the documentation is explicit about the LPM particular case.
> If in the future this factor needs to apply during an other operation that
> name will be generic enough.
> 
> Do you agree ?

Nick and I discussed that.
Nick prefers to have LPM in the tunable names, and thinks we can add a new
tunable if a separate user came up which required it.

We agree that 'nmi_wd_lpm_factor' is a good name.
I'll send a v5 updating that name.

>>
>> Otherwise the code looks okay.
>>
>> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>>
>>> +
>>> +A value of 0 means no change. The default value is 200 meaning the NMI
>>> +watchdog is set to 30s (based on ``watchdog_thresh`` equal to 10).
>>> +
>>> +
>>>  numa_balancing
>>>  ==============
>>>  
>>> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
>>> index 907a779074d6..649155faafc2 100644
>>> --- a/arch/powerpc/platforms/pseries/mobility.c
>>> +++ b/arch/powerpc/platforms/pseries/mobility.c
>>> @@ -48,6 +48,39 @@ struct update_props_workarea {
>>>  #define MIGRATION_SCOPE	(1)
>>>  #define PRRN_SCOPE -2
>>>  
>>> +#ifdef CONFIG_PPC_WATCHDOG
>>> +static unsigned int nmi_wd_factor = 200;
>>> +
>>> +#ifdef CONFIG_SYSCTL
>>> +static struct ctl_table nmi_wd_factor_ctl_table[] = {
>>> +	{
>>> +		.procname	= "nmi_watchdog_factor",
>>> +		.data		= &nmi_wd_factor,
>>> +		.maxlen		= sizeof(int),
>>> +		.mode		= 0644,
>>> +		.proc_handler	= proc_douintvec_minmax,
>>> +	},
>>> +	{}
>>> +};
>>> +static struct ctl_table nmi_wd_factor_sysctl_root[] = {
>>> +	{
>>> +		.procname       = "kernel",
>>> +		.mode           = 0555,
>>> +		.child          = nmi_wd_factor_ctl_table,
>>> +	},
>>> +	{}
>>> +};
>>> +
>>> +static int __init register_nmi_wd_factor_sysctl(void)
>>> +{
>>> +	register_sysctl_table(nmi_wd_factor_sysctl_root);
>>> +
>>> +	return 0;
>>> +}
>>> +device_initcall(register_nmi_wd_factor_sysctl);
>>> +#endif /* CONFIG_SYSCTL */
>>> +#endif /* CONFIG_PPC_WATCHDOG */
>>> +
>>>  static int mobility_rtas_call(int token, char *buf, s32 scope)
>>>  {
>>>  	int rc;
>>> @@ -702,13 +735,20 @@ static int pseries_suspend(u64 handle)
>>>  static int pseries_migrate_partition(u64 handle)
>>>  {
>>>  	int ret;
>>> +	unsigned int factor = 0;
>>>  
>>> +#ifdef CONFIG_PPC_WATCHDOG
>>> +	factor = nmi_wd_factor;
>>> +#endif
>>>  	ret = wait_for_vasi_session_suspending(handle);
>>>  	if (ret)
>>>  		return ret;
>>>  
>>>  	vas_migration_handler(VAS_SUSPEND);
>>>  
>>> +	if (factor)
>>> +		watchdog_nmi_set_lpm_factor(factor);
>>> +
>>>  	ret = pseries_suspend(handle);
>>>  	if (ret == 0) {
>>>  		post_mobility_fixup();
>>> @@ -716,6 +756,9 @@ static int pseries_migrate_partition(u64 handle)
>>>  	} else
>>>  		pseries_cancel_migration(handle, ret);
>>>  
>>> +	if (factor)
>>> +		watchdog_nmi_set_lpm_factor(0);
>>> +
>>>  	vas_migration_handler(VAS_RESUME);
>>>  
>>>  	return ret;
>>> -- 
>>> 2.36.1
>>>
>>>
> 

