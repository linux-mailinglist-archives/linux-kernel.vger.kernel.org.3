Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664945A154D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 17:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240377AbiHYPMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 11:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiHYPMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 11:12:02 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5E6A8978;
        Thu, 25 Aug 2022 08:11:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIZEuRpUsQ6uWrjc4I0kqZwaYHZjX0vXWgiTe1UbtVh1SDG0t6lOtvfrPizeygKXvJ5L4myIsbcNqh38L2oqh9mhEdELxZY/0LuXuDL9NnfEZDGgqwcCM7n2sPeSEPB79wWgLXkRAs/XZtfs8LXcyT9MATckHv7N9gunUmyN1wSoUNtAsv9CcrrlhO3kCjR0Da2vJpHhLZtfIcR3fRyxP3OMmYXNGSrynkW3oP6IHooPb1IJMDd9QY4RoPngzZHfYgtUwEkBHYqtw2yXwWTZaKRIBWP4sMLKz9g2kSiz88qrCmZ72C+gHwvUuzblUenXjLJGmp0nr/2myn1vvcpd4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wseQfJTUsdgaQraVbpuFQUR6REnr+KDXznt0NfzSob4=;
 b=ACC+UX8/Y6gv5cODrNdXPbTizdYPV6gqDmv6Z0hlFbgEgo9+m9jd6KoaFVEU9LKOfqyspaNrQ2ijlsBb6N78uQbM3PJ+4RaL3nJXM4yhtHRMHjSp+gs6kkCsM2C7/TSRo1+yX6gv1A2EHRnwFmpVAhjqGJDbUicM0QKVn9M2DNsb/D6057Q5mB67zBI9poxIe7WfeJg9+SLC2UKwet8XZMf5HuCgvPofVGlLeyLtIb+Q0KB52J3wVMwLMZjEyETF22LjOLCNFcXhyOTym5TkqsEql7sbtQ7bJiqwefciJ7RgFamBYzdZvZWblgPHuR27uSlwHIN95wGhyklBdcE9qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wseQfJTUsdgaQraVbpuFQUR6REnr+KDXznt0NfzSob4=;
 b=SKCvp4/yJRzb4A8G8yuZd/8GBkGLiZfISGDZQYP0q/O4gYNM+lA2DDnDM5xr+Ik4YkXrbcMwBA9O/1Z39nMlzth4CUq5Iq8cmQ4q1zNxNyX6nS7HVlxYUHyvnmTocD2lpwnAtgT/OqcywEqM4T7v7MKR0Q5THrHO34fQxPyg93k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH2PR12MB5003.namprd12.prod.outlook.com (2603:10b6:610:68::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 15:11:56 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::88f:a211:8c98:a973]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::88f:a211:8c98:a973%7]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 15:11:56 +0000
Message-ID: <5d650c6c-2f17-6013-f63f-49a182961494@amd.com>
Date:   Thu, 25 Aug 2022 10:11:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v3 06/10] x86/resctrl: Introduce mon_configurable to
 detect Bandwidth Monitoring Event Configuration
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     eranian@google.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, bagasdotme@gmail.com
References: <166117559756.6695.16047463526634290701.stgit@bmoger-ubuntu>
 <166117582698.6695.3458866624522799072.stgit@bmoger-ubuntu>
 <575bf1d7-8780-8c54-851c-e9849d1815f8@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <575bf1d7-8780-8c54-851c-e9849d1815f8@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:208:256::18) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 098a430f-f3e5-4907-6902-08da86ac266a
X-MS-TrafficTypeDiagnostic: CH2PR12MB5003:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5uv6NN4i0eXGW/oQH4xjxjwKNNetxvARl/2YnczSzZxpK3ejyhPRQDSxZpIFwwu8tLZ9gGW+asJJ4lGBks8IzgnaRRu0iRie4yYLF6ZYBYGuISNix51Qb+DTgiPdO3v5AWI1/pIk5NdDhJFoj11iqp0weFPLU4IWC3B1xDYzK5KR4xyVJ5fEZTOHNgw5UBYcVw1EEXFyDLQ6ykAL91WahN8NO7M5m0RwQmBUHQnU8hc4UuEVw4TNT2n/WXkVrsH8gp3ROXOGbkQ7QEJO4fCV+8orsbP566toEyCLNTz1gMTUYyUIKiuveaeyGns//w6RQzS6gw8j/9AGJ5f4BZPqqt0GKgR8kifOCwD+qHQTdWCDdMFaPg6xyzvk5+ysJw9jZl0Vp4UVeP8iedRzYQGLY8m2kQOvVSIQBzu7Jt5Vo+JEWKlAaFtig6Zy6lHQeJ55GDWHNU9v6vDmOcypkUgU75WIZXaqHECMWd4KPWa2R5fGLuPiDgkxH5bCydbB68p6YhMy3OI/oKBOYhVG5wSvIK3u61YdBJ1N5vRkqFTtNyapZ2IqC5FSS6klIaefvEHMOLvFRTr3+RMvBkP+e/gPyb/p4d4INbkP+ITjyP2xL580r4lBSPp+0L4HDkEKra6d/aSwagQDI2EQ3QFwwdPQj3QgH73EOyAVbl4VAZpoOBqItbLof7Y08MiwbmjVCFEmY8GOOhcmrRZeIyDx7orlUydiYTI0uDh+iJcDnPz18A+Y8W59sof01qpGs76fMgLYUutx8FaTYFSglyPwtNjRbZQ3B4T+hmA/HCzBWEYlB7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(83380400001)(31686004)(26005)(6666004)(6512007)(316002)(41300700001)(6506007)(478600001)(6486002)(38100700002)(8676002)(66476007)(66556008)(5660300002)(66946007)(7416002)(36756003)(4326008)(3450700001)(2616005)(186003)(53546011)(86362001)(31696002)(8936002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVFVeGt4WlllRFBJcUFnL3laeXY4Z1JMSHlxbnEwSkl0LzI4WDF3Tjc1K3Zs?=
 =?utf-8?B?eE1vQXlmWjUzQVBqN3JwTWpxUDNRa29hQXZ5d0RraHNpQkR4TVVmakxpZDRi?=
 =?utf-8?B?TENYQ3ZEclBVbjZTbmNpZWQvTmY0RU4zbjhLa0xRenUvNmE4S0pxbzRzZmNi?=
 =?utf-8?B?enhveXgxUHJTME41cmZLK1B5SG1JNEtPQ0tMNGhOVnFYMWVtaXJJQS82Q3NB?=
 =?utf-8?B?TGdQdXZuRXZ3V0Y1UENZemtFZHFqMTdaTU5VMzhsQVAxQ0s3M2c4amp2TVdn?=
 =?utf-8?B?ekgxbHg5Sm90bHJMOEdRd2hLSDgrOXpib3YwT1RULzNLSm5zdDZSK0s3L3I5?=
 =?utf-8?B?QjVGZjk1OHQ1TkZvMnlYNmthSVhITkZMdnpZdm04ZWRlYy9sd2xmZzlyNlVi?=
 =?utf-8?B?a3VIbjk1SVZiTE9FQ2pMM2RNVkQrVldwWnNoQVc2cnRGb2h5VjRCbW4yUDBU?=
 =?utf-8?B?d2F6TUI3ZTdEWmdQSk9XajlkWXlQWllzSjJoSjgyNmFDWW5GK1dJcVVCN2Zt?=
 =?utf-8?B?bkg2MFhld0RGSWh4amNHSER5K1E1a2ZXbE5iWTF3TE5UeHIwTXBuVEhDZEdl?=
 =?utf-8?B?MWFhNk9PT25JemFHSlkyVTlDN1BRa3ZhNkxEaE01MW5MVE4zczl6aHVnaCtX?=
 =?utf-8?B?ajk1MG1KZlVSbGRZWm05cms5Mkl6R1Ria2NBYzI5dHowZFRBam9aNjlQT1Mz?=
 =?utf-8?B?cUU1M3p6Y29HcEk0N1A2dTA1OW1BN0I0YTZheWV5Z1Voc2JXUHZPWnlUajZn?=
 =?utf-8?B?UlArMWsrWDRKT1RTTU1vTzRqMkxSNHRoNXVzbmRiYW5hdjhKeFZLeTdsNUFV?=
 =?utf-8?B?Q0w0ZGFDcE5KdlMxeXZjTzlFdm56dGFwM3Z6ejE5YVFvRjE2WEd3VVVjQTlF?=
 =?utf-8?B?ZkljRHNvWHpaMFU3c0tjakRhNmlBcVpncmtOTXlycFd4SjBNSWkyNzRhZHUr?=
 =?utf-8?B?UWJNNFNBaElwOENEeXkyVXd3Mm9VeGlmNm9QL2cvZ21kczBhY3NBdVAySEtj?=
 =?utf-8?B?dkhEeGo4Y2NWc0UrWWRpcitEVGY4aVpMTENoT3ZKT0JqbHIrUk01UzdhVFEv?=
 =?utf-8?B?bExQcGFSVmhFR3pDWFRVaHFKbHdhVWFYMWNZTVZmVlMvQ29UdWx0L0wzQWox?=
 =?utf-8?B?QVFhZGdIZGQ1VHNiY3JiNVNENXc4SmlBZSt6ZXlLMllWT0labU5lQTNhYjY2?=
 =?utf-8?B?V3UxNlcyZzVIdmh5V1FTdFFzYzl5Mk55eXcvRDNaOFYwdDNydmVJVTZHZHFO?=
 =?utf-8?B?dWg2UW1ZZWNEUjNXcEo5OFcweGNUM1FWVDh4cDI1Y0ZmYWw3N256UUJwWmNU?=
 =?utf-8?B?ZFR6OFI0aHI0ajNTZThzVm15YVhjWkFPS1lMdVc4MW5jcGtTTXNJV1dpL0ZI?=
 =?utf-8?B?dXlTSG5ETzdWNFdFVFBVRWVZTU4xNDN0TVpxMTJXcVUwc1ZQQkF2cUNXYk55?=
 =?utf-8?B?em5JeERmQ0pML0Q3UWhJajZOWDRVOG1wNlBHeDlGbzZiWUZLT0VKNTgwL1hq?=
 =?utf-8?B?NHNEZ2VQWjdLTjRLK0Z4eE5tOVRqRjBQU3JqaVNrK2lncVNKYlMrMEFaTFVr?=
 =?utf-8?B?N3lLeUxKaGdoZ0t4ZzNHNGM4dlBDbUVGTVFwcytxbXZnOFpTMmtyQnY1RERI?=
 =?utf-8?B?aXJFSk9BMXRWQVBVSVE4ajNlWEFvaWNWTXY0VExEUGo4ZGloTUY2ZXhjQ2FX?=
 =?utf-8?B?cGhQa0J0dkJSOTBNR1Rxb0M5b1V3R3REU3FxUkgvd1lWWnN6T0J3KzFPNk92?=
 =?utf-8?B?M0wxd3N4YStrTStyMTgxZS84UHNmUnhYOGcwZWtLY1c5ZzFzNUlLT2g0clZm?=
 =?utf-8?B?REpmMnZXeTNLRGwxVW13cGxNRkp5VzhISXE2ekVHRXlBZmZTZHlwcTNtZHJF?=
 =?utf-8?B?K3FiWWsxQ1ZtZWNsTllrS1N0NjF0YUVnMkFQc24zaE5yeUxyTU9HYnIwS2xH?=
 =?utf-8?B?TEtrMEhrcUx0WlgxR0k2MzVFazZ5WjRwRXJOdDJNUUhpa2xuWGRqaVhGRjBL?=
 =?utf-8?B?emFtOUtwQTdnZktOSS9RRGF1TTdGV2FCWmZ3aitwaFVQRTNyeHVLYkRRSGdD?=
 =?utf-8?B?OUxSSmk1d1JRZWdScjRkZkZ1WS9hQWZQV1ZzTk9SZ0JwUlV2cXo4RmUxR3cv?=
 =?utf-8?Q?fnUk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 098a430f-f3e5-4907-6902-08da86ac266a
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 15:11:56.5400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZx2c/PKNEjQcVilnfZnFX3OS2M8tBEKbBryqvHIDVxbiWjD+77CxEM/srhcULkT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5003
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 8/24/22 16:15, Reinette Chatre wrote:
> Hi Babu,
>
> On 8/22/2022 6:43 AM, Babu Moger wrote:
>> Newer AMD processors support the new feature Bandwidth Monitoring Event
>> Configuration (BMEC). The events mbm_total_bytes and mbm_local_bytes
>> are configurable when this feature is present.
>>
>> Set mon_configurable if the feature is available.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Reviewed-by: Ingo Molnar <mingo@kernel.org>
>> ---
>>  arch/x86/kernel/cpu/resctrl/monitor.c  |   14 ++++++++++++++
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   17 +++++++++++++++++
>>  include/linux/resctrl.h                |    1 +
>>  3 files changed, 32 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index eaf25a234ff5..b9de417dac1c 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -682,6 +682,16 @@ static void l3_mon_evt_init(struct rdt_resource *r)
>>  		list_add_tail(&mbm_local_event.list, &r->evt_list);
>>  }
>>  
>> +
>> +void __rdt_get_mon_l3_config_amd(struct rdt_resource *r)
>> +{
>> +	/*
>> +	 * Check if CPU supports the Bandwidth Monitoring Event Configuration
>> +	 */
>> +	if (boot_cpu_has(X86_FEATURE_BMEC))
>> +		r->mon_configurable = true;
>> +}
> Could this rather use rdt_cpu_has() with the added support for disabling
> the feature via kernel parameter?

Yes, That is possible. We could do that.


>
>
>> +
>>  int rdt_get_mon_l3_config(struct rdt_resource *r)
>>  {
>>  	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
>> @@ -714,6 +724,10 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
>>  	if (ret)
>>  		return ret;
>>  
>> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
>> +		__rdt_get_mon_l3_config_amd(r);
>> +
>> +
> Why is this vendor check needed? Is X86_FEATURE_BMEC not sufficient?
Yes. I can remove the vendor check.
>
>>  	l3_mon_evt_init(r);
>>  
>>  	r->mon_capable = true;
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index fc5286067201..855483b297a8 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -995,6 +995,16 @@ static int rdt_num_rmids_show(struct kernfs_open_file *of,
>>  	return 0;
>>  }
>>  
>> +static int rdt_mon_configurable_show(struct kernfs_open_file *of,
>> +				     struct seq_file *seq, void *v)
>> +{
>> +	struct rdt_resource *r = of->kn->parent->priv;
>> +
>> +	seq_printf(seq, "%d\n", r->mon_configurable);
> Why is this file needed? It seems that the next patches also introduce
> files in support of this new feature that will make the actual configuration
> data accessible - those files are only created if this feature is supported.
> Would those files not be sufficient for user space to learn about the feature
> support?

This is part of /sys/fs/resctrl/info/L3_MON# directory which basically has
the information about all the monitoring features. As this is one of the
mon features, I have added it there. Also, this can be used from the
utility(like pqos or rdtset) to check if the configuring the monitor is
supported without looking at individual files. It makes things easier.

Thanks

Babu


> Reinette

-- 
Thanks
Babu Moger

