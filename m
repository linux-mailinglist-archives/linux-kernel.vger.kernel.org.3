Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CF2559B3E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 16:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbiFXOKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbiFXOKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:10:06 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C87562C4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:10:00 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25ODBlUR019365;
        Fri, 24 Jun 2022 14:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=hIACM6BfZZgoZ9/t+CT5affcXAiGhhbM8EZitKpG2cI=;
 b=IcbuAN/yVxqYpjtBzi6O5YOpLcR6cuKqErfGEjfSwM0h9pnMeG2S5ezN+1x46qeGBLWl
 57p7JpeeSOTnyeAaX1VTqcEL1+9wrWz2Qxc9Ghy2WbKEzUaaDcs2b1IFQiswNVk24niY
 xMeThWVaU4yJ4gZw5gJkvCoGP4tm/n3gYAcReUdJvQI9kfPVZWXlcoelV/iTZHoewk0n
 orGaKg79TbEkTSZ5GrUsAW+rdJSJ2Ouy+X9nMGGpnsIrnxgt6b9yy7NBsSfMNPYt7TVq
 0iEzPOmP+hbyFAAUiwJnKdhLm84ksRkCJ84zWQSCXZBvxy14VaFubtD8SaWkwGlYVeqa xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gw9hyrru9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 14:09:40 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25ODSLsb022052;
        Fri, 24 Jun 2022 14:09:40 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gw9hyrrth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 14:09:40 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25OE6CNN016148;
        Fri, 24 Jun 2022 14:09:37 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3gs6b994d8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 14:09:37 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25OE9Z1O18940342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 14:09:35 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FC4CA4057;
        Fri, 24 Jun 2022 14:09:35 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C5E1A4040;
        Fri, 24 Jun 2022 14:09:35 +0000 (GMT)
Received: from [9.101.4.33] (unknown [9.101.4.33])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 24 Jun 2022 14:09:34 +0000 (GMT)
Message-ID: <040a8f52-980f-146c-6811-9a0ce9157f08@linux.ibm.com>
Date:   Fri, 24 Jun 2022 16:09:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v2 4/4] pseries/mobility: Set NMI watchdog factor during
 LPM
Content-Language: fr
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        haren@linux.vnet.ibm.com, npiggin@gmail.com
References: <20220614135414.37746-1-ldufour@linux.ibm.com>
 <20220614135414.37746-5-ldufour@linux.ibm.com> <87sfnvmgql.fsf@linux.ibm.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <87sfnvmgql.fsf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yuO9Fjnte4pDDmNfCbBbDPgSyskw8CeR
X-Proofpoint-ORIG-GUID: ZghCb-F_2QSGKahCJ6XSXNfeCCuz7BnB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-24_07,2022-06-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206240055
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2022, 19:28:34, Nathan Lynch wrote:
> Laurent Dufour <ldufour@linux.ibm.com> writes:
>> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
>> index 179bbd4ae881..4284ceaf9060 100644
>> --- a/arch/powerpc/platforms/pseries/mobility.c
>> +++ b/arch/powerpc/platforms/pseries/mobility.c
>> @@ -48,6 +48,39 @@ struct update_props_workarea {
>>  #define MIGRATION_SCOPE	(1)
>>  #define PRRN_SCOPE -2
>>  
>> +#ifdef CONFIG_PPC_WATCHDOG
>> +static unsigned int lpm_nmi_wd_factor = 200;
>> +
>> +#ifdef CONFIG_SYSCTL
>> +static struct ctl_table lpm_nmi_wd_factor_ctl_table[] = {
>> +	{
>> +		.procname	= "lpm_nmi_watchdog_factor",
> 
> Assuming the basic idea is acceptable, I suggest making the user-visible
> name more generic (e.g. "nmi_watchdog_factor") in case it makes sense to
> apply this to other contexts in the future.

Fair enough, indeed, I was wondering if "lpm" is meaningful.

> 
>> +		.data		= &lpm_nmi_wd_factor,
>> +		.maxlen		= sizeof(int),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_douintvec_minmax,
>> +	},
>> +	{}
>> +};
>> +static struct ctl_table lpm_nmi_wd_factor_sysctl_root[] = {
>> +	{
>> +		.procname       = "kernel",
>> +		.mode           = 0555,
>> +		.child          = lpm_nmi_wd_factor_ctl_table,
>> +	},
>> +	{}
>> +};
>> +
>> +static int __init register_lpm_nmi_wd_factor_sysctl(void)
>> +{
>> +	register_sysctl_table(lpm_nmi_wd_factor_sysctl_root);
>> +
>> +	return 0;
>> +}
>> +device_initcall(register_lpm_nmi_wd_factor_sysctl);
>> +#endif /* CONFIG_SYSCTL */
>> +#endif /* CONFIG_PPC_WATCHDOG */
>> +
>>  static int mobility_rtas_call(int token, char *buf, s32 scope)
>>  {
>>  	int rc;
>> @@ -702,6 +735,7 @@ static int pseries_suspend(u64 handle)
>>  static int pseries_migrate_partition(u64 handle)
>>  {
>>  	int ret;
>> +	unsigned int factor = lpm_nmi_wd_factor;
>>  
>>  	ret = wait_for_vasi_session_suspending(handle);
>>  	if (ret)
>> @@ -709,6 +743,13 @@ static int pseries_migrate_partition(u64 handle)
>>  
>>  	vas_migration_handler(VAS_SUSPEND);
>>  
>> +#ifdef CONFIG_PPC_WATCHDOG
>> +	if (factor) {
>> +		pr_info("Set the NMI watchdog factor to %u%%\n", factor);
>> +		watchdog_nmi_set_lpm_factor(factor);
>> +	}
>> +#endif /* CONFIG_PPC_WATCHDOG */
>> +
>>  	ret = pseries_suspend(handle);
>>  	if (ret == 0) {
>>  		post_mobility_fixup();
>> @@ -716,6 +757,13 @@ static int pseries_migrate_partition(u64 handle)
>>  	} else
>>  		pseries_cancel_migration(handle, ret);
>>  
>> +#ifdef CONFIG_PPC_WATCHDOG
>> +	if (factor) {
>> +		pr_info("Restoring NMI watchdog timer\n");
>> +		watchdog_nmi_set_lpm_factor(0);
>> +	}
>> +#endif /* CONFIG_PPC_WATCHDOG */
>> +
> 
> A couple more suggestions:
> 
> * Move the prints into a single statement in watchdog_nmi_set_lpm_factor().

You're right that sounds a better place.

> 
> * Add no-op versions of watchdog_nmi_set_lpm_factor for
>   !CONFIG_PPC_WATCHDOG so we can minimize the #ifdef here.
>

Furthermore, this breaks compilation when !CONFIG_PPC_WATCHDOG because
lpm_nmi_wd_factor is not defined. I'll rework that part.

> Otherwise this looks fine to me.

Thanks,
Laurent.

