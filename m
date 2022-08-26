Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CE15A2E21
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344397AbiHZSSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343808AbiHZSRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:17:55 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55236DF0A3;
        Fri, 26 Aug 2022 11:17:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JL1eU8efEG27J4xqNrbPLeopYTjzpNVrKSpqtkd+0tK8Nqu+723YKPerkYf6cQyjLaZppLv/nBZj8Fk0p6w6O+yA1ttnu+JviKSXKv2Do67kavnobji9A1Jw36NGrDGbT09mFsWXNBZ2rul7bm9hY02LJtbmtjMB4IAcAq3vtQM3hN9rL06ntwYaLiG7Z4PFwh8ZNu3VyZVPZmfdhbZgF/8wYH5cMItSSbjpvl0sF5K+qvBz9GeghdO5SOxEd0xcfz36OSgLysO3GmuCY0+vP8hLmLCcK/0bOayIjLQ1TlyxiI1WEX1p4a2OIKcjwM29YeNONsv0JqPmBp+yPmEjWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31gYkKJzvf6IqGk2ywbZsey6RvPtajAQB7O33UghUkg=;
 b=nPh5MNw5XErggtRaKlkafgBAUVMkBgRiheoBdtGTmVatEOGXC2Ad5HmK0d0mxJUCNyiGQTMBJBBDHeFyKQxx1F4i9Eb/ScCgVuDlf6+aj6kfzSnSPi5T2q3ccSAX6AJ4UuH+rujzfrXVZWYhB3cocGA4BNrQyD6CRwwAaHVhsN4VYnbwrO4FONanX3m0cYpS5wWSr7tVtcJr05YI7yOuKQRz9soxS9DB1KvRsEx3TZ/9OcfY8fzkMrL53265qyKXAXCeVDy4tCAJhTBHaRpL9dj3JfA6RtwC/iir3+Yqv8CKkkK6ZJ29pn0aS8hmNB2ifJeW3fvt9jFmTL/oM8Q0Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31gYkKJzvf6IqGk2ywbZsey6RvPtajAQB7O33UghUkg=;
 b=VrnRNOGg1j5A3uTlAG+vTZc5Lss4CB9wVNaYbs3Lo0KNPZx4JF9ytKFuzKZF3wgSVbEj58rVUHYKNaDuijjLc5XVBmuzlAa1bx4GRr4tO/BIySOmaLHbNmRM2IixjnOlKc3TRI6zXS0R8UO4bMjHXLhnewFvxLhCMbZ1Z8KQfb0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM5PR12MB1449.namprd12.prod.outlook.com (2603:10b6:4:10::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Fri, 26 Aug
 2022 18:17:51 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::88f:a211:8c98:a973]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::88f:a211:8c98:a973%7]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 18:17:51 +0000
Message-ID: <a1e2103a-63cf-f69d-b656-ef4702921523@amd.com>
Date:   Fri, 26 Aug 2022 13:17:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v3 09/10] x86/resctrl: Add sysfs interface to write the
 event configuration
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     eranian@google.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, bagasdotme@gmail.com
References: <166117559756.6695.16047463526634290701.stgit@bmoger-ubuntu>
 <166117586910.6695.3670808098195387542.stgit@bmoger-ubuntu>
 <eca1657e-3dbf-d46c-fecf-f8888a25a878@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <eca1657e-3dbf-d46c-fecf-f8888a25a878@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0428.namprd03.prod.outlook.com
 (2603:10b6:610:10e::23) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2d2dc32-d9dd-456f-53ee-08da878f49ce
X-MS-TrafficTypeDiagnostic: DM5PR12MB1449:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jKcf/CegTeVy4G7ULKIVfEOsOZQGz3IYYWrMXmsYvQw1m9lGMbkKSdADU/tBibwtdzPkjGwJr5pSaiFyO4Qc2Yazgg4L31L+hxIxtVcGvYD9UAU5lWLi2+1+5tpqXV1Se+jpkXv2bGlS0ixpbB/oLwPLKjllfn0Du3Zvd9lhQhaVXPxpqK0hqDOiY5KFwppgyAfmnYY6uXMJmxFxCpzlpzp2rID0CED/50uWAFzZ2yJNyvYvG54mYxzAYNO5xLIrmu7fMtIzLgbS5red9QfJ0ATUa4OQirK8f1h3X2KlahAO4RCq8/feHCV52vS+6vxH9RMxFzU2d5t1aAectTYPKIfUHuiz2d/RK1bi5qjLppD7wE06zb+Qoagx+MA927mFR+6rblUj97RxC5VeIpoKEbnyCjZqv3M5e6wOHWzjXcj90B0Wc2xrY5sTbB9mQ4IANZZuD9tVK9ENNcGVfsjRzRDVbeIbkzJ6Y9yoquQchUcxc1L33IMXuMEtmUYWGWUnkd81wZVrHBPnDC0+qqpgtsDGZtXBjhwi5PuKZZY7K6jt3JOE0bTlixEHrsmYSICjGlmBLSRMkPEBIc0xo1EDV02sAgeJmOODg8x1nBydNDBmNFpzff5shVe4yPANCFBTo4RMCwcsfcdaHEEfGEWfIBfHBY+94mfYP4Qf2o4qUJ6PH7Je91sktIhmRsdmCyf9k2o1s/8cWJB5ojnDPfza2OK9jS6umCNERci/G3tm5bKlghYPScR8v95yj9677o2dgVO85SJVl5+zlakpW+/thdmskx3rez5J6IrBYeEC7Js=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(2616005)(86362001)(53546011)(186003)(6506007)(5660300002)(8936002)(26005)(31696002)(36756003)(7416002)(478600001)(41300700001)(31686004)(6512007)(6486002)(6666004)(83380400001)(66946007)(4326008)(8676002)(3450700001)(2906002)(66556008)(66476007)(38100700002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlJOamZ5NjBGTUlRNEozR1hlZ3ZWSWxBRFNTWlRKOGgxWXhlNk51QVJMLzls?=
 =?utf-8?B?aVFkQWpld2dEUk5Walp3K2s2WUZlNDZzWDFwdklCYkx1NDBqUnRaclNHVE9H?=
 =?utf-8?B?d2J6azkwYlE0SDQ1Tm5UUVBDWHFmaTdMRFhWQWxRTHdOek1mL3h3RkVkOVh5?=
 =?utf-8?B?S3ZzS0hyNzQ0aGNPNG5mK0dlajY1U0RoWUlweE96VHp4TVE4ZkFRZ1E5dkNH?=
 =?utf-8?B?cytWYkRDb3k2c2lrUWFBckxSSEJSNjQzOWVSNVNOS0h0aDdab1pybS9XTEVp?=
 =?utf-8?B?YVdjS3ZWWGNFQWxEWWxNMWJpOEF3bTJySjhSYXluOE1IMDM5ZnRtSmptOVhC?=
 =?utf-8?B?dUJkNmhhSWpqSXZpa09ndmM2Y2ZlTTdGMjF0a3o2SWtWaEo3WUs1YndDOEd5?=
 =?utf-8?B?NEFuNVdTeDFtN2VyNkNKYUkxanRPR3E3ZVhiZHdnK29FRm82NnBFazRNNWpG?=
 =?utf-8?B?TzNFTjc2eEkwMlNmd2lxM1NWQ3pYQUZzMUw5WmNBTmlhNWM2aWRBdnNkcWJ1?=
 =?utf-8?B?dlAweGFkMWFCZGJuWHlWZVNTdG9qL0JxVDljRmRXSmZ0MDZ5OEgzWE9YdmNU?=
 =?utf-8?B?TXllanVOQk5jeC9xYVRiVE1ONDNOTHRnTlNPSTBLdGZoZndjeEFKSXdWa0dq?=
 =?utf-8?B?Sm4vSzhWMG5vMXRiVEdOWGVnMWdTdGRENktTWFc0TS8xS3dUMkd0Z1pJSHVp?=
 =?utf-8?B?WnI5YldsV2ZnTm1EZVl1VkViazJUUTFMY1RtYkVCSmgreFFLYmR0ZnBnZ1dn?=
 =?utf-8?B?N3lQUys4amZDMDA4eEZXaTJIeUZ0UEFTSkdUTll6ejFSd2QyRXRNNEdVelFt?=
 =?utf-8?B?WUZ1dy9EalowQzlacWhDVW9ZOVB6a3dDK0tlZnpSeHlJcEY3Ukx1TkJNa2ZU?=
 =?utf-8?B?WFhaOTFsQ1dXUllEK3JnaDJncWdzYkFpSndGazZqazNJd3JLaVk3VnFjOTlQ?=
 =?utf-8?B?MFA5c1pyK3Z0QXZkT1dZeUJqcTRQVzl1dHdMaUFPblZETXJQRGtwWGpacVpr?=
 =?utf-8?B?b3hONFluM3IwRHU3ZnBUejhvNFlxa3NCOWxVL3hldDJNTGNxOFg5Nit0b09t?=
 =?utf-8?B?UVRieWJZYnQ5WjI1ejdRY205Qzc1NCtWTUZZOWJ4SjZnd3V0Z2hGemJnazVs?=
 =?utf-8?B?MTFCb2JIbmxmNFBWY21EZE9ZZHNpSUpxaE1VU09BK2RmdThRVjFkeENtZ044?=
 =?utf-8?B?aXAvb2lyWWtPcFBSc0xZbHhBUk42R1o0WjNlUS83a25nZlZjaGxGandLbzI5?=
 =?utf-8?B?KzRUYjkxVEFmSjB4ajJJNzZ2K1VtWEl0amY0L09WMStsRnZRdGoya2pLeFkz?=
 =?utf-8?B?Z0J5ZEhMRWg1SThBMnBKMDhUbmdZRHRHcG94di9RREx5dENQTkJaNUhqTGVJ?=
 =?utf-8?B?LzhFSlhlNUpyM0tJSmhwU1dHOTVkeHNjVzExSnVCb0VvbHhmQll1UUp2YXRX?=
 =?utf-8?B?c08zZkxvaXdKeVkyYzVYY00zTlNpdllQOVhzWXRKZVdJTXNHbGNsRHg3Nmo5?=
 =?utf-8?B?SWRoanVqVUk5cW96TXJLZSsybXdwSXVZMWpoRmU2MWZoQXV4aHRYUnN0THpv?=
 =?utf-8?B?WkpWeis0L292Mk1MU2pyWmMyd0duR3JJdEVEazZhRlNuWTVzdGNKNDVySzkz?=
 =?utf-8?B?Z1IrR1BoS1FMRVdwU1gxcWFtZzJaSHU3SzQ1blpKOGZ5bERoKytidGM4cTRp?=
 =?utf-8?B?d2N1LzcvNHBHVzZMa1lqN2NHZFVHWVNmZFQ0dXFvYTFLdit0MG9nN2FFMlR2?=
 =?utf-8?B?WEZwWnQ3dGx2WUUvbVZqT1NzOFVZNEFJTVZkSm9rNG1KMHRUazVaQUg4ckY4?=
 =?utf-8?B?eCtPcVlxVTF0VU0xdjVvSEwrYm5RckhyLytZTXZQZE1KMzc2NGZXb2dobjFq?=
 =?utf-8?B?cWxrbHBzcHRlZHlCay84UCt3d3dTZzA5VzdHWDJFWUpVbzF0ZlNad3JyU2dO?=
 =?utf-8?B?WkFLSHhSUm1XNU5BYm1wdms1cHVlQWt4d2EycGZoemtnZ2J2SXd1Ym5TZU5T?=
 =?utf-8?B?UThCQjV2YWJ2UCtWZTNEMFJwM3VGUk9TYXdZUUJYc24xa0l5TFdiY3VEbk95?=
 =?utf-8?B?b1hxQmZ1MStINE5BR0tRVUVhZ1FzY2tCRXRoajRoaUNNZFhmZ1hZaGhnUE5B?=
 =?utf-8?Q?NJ2M=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d2dc32-d9dd-456f-53ee-08da878f49ce
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 18:17:51.6240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +LENF3U9C5N0zXiOYK1+s1pgk5Jkz9xunHp8w0hE3LqeNI7cKBo0tY1oT0cXNc2w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1449
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/24/22 16:16, Reinette Chatre wrote:
> Hi Babu,
>
> On 8/22/2022 6:44 AM, Babu Moger wrote:
>> Add the sysfs interface to write the event configuration for the
>> MBM configurable events. The event configuration can be changed by
>> writing to the sysfs file for that specific event.
>>
>> Following are the types of events supported.
>> ==================================================================
>> Bits    Description
>> 6       Dirty Victims from the QOS domain to all types of memory
>> 5       Reads to slow memory in the non-local NUMA domain
>> 4       Reads to slow memory in the local NUMA domain
>> 3       Non-temporal writes to non-local NUMA domain
>> 2       Non-temporal writes to local NUMA domain
>> 1       Reads to memory in the non-local NUMA domain
>> 0       Reads to memory in the local NUMA domain
>>
>> By default the mbm_total_bytes configuration is set to 0x7f to count
>> all the types of events and mbm_local_bytes configuration is set to
>> 0x15 to count all the local memory events.
>>
>> For example:
>> To change the mbm_total_bytes to count all the reads, run the command.
>> $echo  0x33 > /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_config
>>
>> To change the mbm_local_bytes to count all the slow memory reads, run
>> the command.
>> $echo  0x30 > /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_config
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Reviewed-by: Ingo Molnar <mingo@kernel.org>
>> ---
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  109 ++++++++++++++++++++++++++++++++
>>  1 file changed, 109 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index e1847d49fa15..83c8780726ff 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -323,9 +323,118 @@ int rdtgroup_mondata_config_show(struct seq_file *m, void *arg)
>>  	return ret;
>>  }
>>  
>> +/*
>> + * This is called via IPI to read the CQM/MBM counters
>> + * in a domain.
>> + */
>> +void mon_event_config_write(void *info)
>> +{
>> +	union mon_data_bits *md = info;
>> +	u32 evtid = md->u.evtid;
>> +	u32 msr_index;
>> +
>> +	switch (evtid) {
>> +	case QOS_L3_MBM_TOTAL_EVENT_ID:
>> +		msr_index = 0;
>> +		break;
>> +	case QOS_L3_MBM_LOCAL_EVENT_ID:
>> +		msr_index = 1;
>> +		break;
>> +	default:
>> +		return; /* Not expected to come here */
> Please no inline comments.
Ok sure.
>
>> +	}
>> +
>> +	wrmsr(MSR_IA32_EVT_CFG_BASE + msr_index, md->u.mon_config, 0);
>> +}
>> +
>> +ssize_t  rdtgroup_mondata_config_write(struct kernfs_open_file *of,
>> +				       char *buf, size_t nbytes, loff_t off)
>> +{
>> +	struct rdt_hw_resource *hw_res;
>> +	struct rdtgroup *rdtgrp;
>> +	struct rdt_resource *r;
>> +	unsigned int mon_config;
>> +	cpumask_var_t cpu_mask;
>> +	union mon_data_bits md;
>> +	struct rdt_domain *d;
>> +	u32 resid, domid;
>> +	int ret = 0, cpu;
>> +
>> +	ret = kstrtouint(buf, 0, &mon_config);
>> +	if (ret)
>> +		return ret;
>> +
>> +	rdt_last_cmd_clear();
>> +
>> +	/* mon_config cannot be more than the supported set of events */
>> +	if (mon_config > GENMASK(6, 0)) {
> Could this "GENMASK()" be given a name and be moved closer to where
> the bits are defined in internal.h? This will be easier to read and if any
> new bits are added it would hopefully be noticed more easily to get
> an update also.
Ok. Sure..
>
>> +		rdt_last_cmd_puts("Invalid event configuration\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	cpus_read_lock();
>> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>> +	if (!rdtgrp) {
>> +		return -ENOENT;
>> +		goto e_unlock;
>> +	}
>> +
>> +	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL)) {
>> +		ret = -ENOMEM;
>> +		goto e_unlock;
>> +	}
>> +
>> +
>> +	md.priv = of->kn->priv;
>> +	resid = md.u.rid;
>> +	domid = md.u.domid;
>> +
>> +	hw_res = &rdt_resources_all[resid];
>> +	r = &hw_res->r_resctrl;
>> +	d = rdt_find_domain(r, domid, NULL);
>> +	if (IS_ERR_OR_NULL(d)) {
>> +		ret = -ENOENT;
>> +		goto e_cpumask;
>> +	}
>> +
>> +	md.u.mon_config = mon_config & 0xFF;
> Same question as previous patch. I do not see this internal
> value used in the code, is storing it necessary?

Storing is not necessary.  As I commented before we need mon_config  as
part of mon_data_bits structure because, it need to be passed to
mon_event_config_read and rdtgroup_mondata_config_write.

In these functions we need evtid and also config value (mon_config).

>
>> +
>> +	/* Pick all the CPUs in the domain instance */
>> +	for_each_cpu(cpu, &d->cpu_mask)
>> +		cpumask_set_cpu(cpu, cpu_mask);
>> +
>> +	cpu = get_cpu();
>> +	/* Update MSR_IA32_EVT_CFG_BASE MSR on this cpu if it's in cpu_mask */
> Please always use caps for CPU.
Sure
>
>> +	if (cpumask_test_cpu(cpu, cpu_mask))
>> +		mon_event_config_write(&md);
>> +
>> +	/* Update MSR_IA32_EVT_CFG_BASE MSR on all other cpus in cpu_mask */
>> +	smp_call_function_many(cpu_mask, mon_event_config_write, &md, 1);
>> +	put_cpu();
> I do not think we need to propagate this pattern more in the resctrl code.
> How about on_each_cpu_mask()? 
Yea. We can do that. It probably better to replace all the current
smp_call_function_many in resctrl code.
>
>> +
>> +	/*
>> +	 * When an Event Configuration is changed, the bandwidth counters
>> +	 * for all RMIDs and Events will be cleared, and the U-bit for every
>> +	 * RMID will be set on the next read to any BwEvent for every RMID.
>> +	 * Clear the mbm_local and mbm_total counts for all the RMIDs.
>> +	 */
>> +	memset(d->mbm_local, 0, sizeof(struct mbm_state) * r->num_rmid);
>> +	memset(d->mbm_total, 0, sizeof(struct mbm_state) * r->num_rmid);
> Could you please check if this is sufficient? Note how "mon_event_read()"
> is called with "first = true" right after the mon sysfs files are created to
> clear the state _and_ initialize the state to set the "prev" MSRs correctly.

I see that it is set

m->prev_bw_msr = m->prev_msr = tval;

With above code we are setting

m->prev_bw_msr = m->prev_msr = 0;

I cannot think of any problems this could cause. Please let me know if you
see a problem.

Thanks

Babu Moger

>
>
>> +
>> +e_cpumask:
>> +	free_cpumask_var(cpu_mask);
>> +
>> +e_unlock:
>> +	rdtgroup_kn_unlock(of->kn);
>> +	cpus_read_unlock();
>> +
>> +	return ret ?: nbytes;
>> +}
>> +
>>  static const struct kernfs_ops kf_mondata_config_ops = {
>>  	.atomic_write_len       = PAGE_SIZE,
>>  	.seq_show               = rdtgroup_mondata_config_show,
>> +	.write                  = rdtgroup_mondata_config_write,
>>  };
>>  
>>  static bool is_cpu_list(struct kernfs_open_file *of)
>>
>>
> Reinette

-- 
Thanks
Babu Moger

