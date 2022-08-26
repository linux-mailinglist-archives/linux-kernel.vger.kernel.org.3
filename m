Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52ABD5A2BFF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 18:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243897AbiHZQIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 12:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244755AbiHZQID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 12:08:03 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8290D4F70;
        Fri, 26 Aug 2022 09:08:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmuCVf3b8VuvkmwljDwhSdeX/99qzduqMzm2Z0QLtCuTAuo/rvQIroyU0myD83tLZMmDg9FvuaOIpgxoQWPW1GeNRRrxS2dm2fkwkmqqfVYORNAmReAhojB02FewQ0Y6InjAdz2E2nbVa3GJjzAUjn8sX92ggtQ5D20+Ff5WyMH3Nx/fnKA9iyxB3m72roP9h9McDLIhsclyH5m09iG6CS3CcPeiEA1I5l9MNY9I9kQBf780E5lCiYCY3EBeibpoG5n6shH4gmJsnvYzuw3qfkOZD7SB62xvlY8s+M+7urG3Jhj3gftZ3wA9eLRPbUh7McmQQDW06aa+ejE3c+B0Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbBQq2gCdGQk1D7zzjv1dO6Bsp2df0wGkDPwPwIwxiM=;
 b=ATWdBFDnLx65MOw/6tneyyTy+HOmAyuqDgSRHjJ7+Nw8LSl08CDpEdq8nuB2qZ6+c7+ZApoZgzlEI72xYb+E7+Nia5rUS/OK9RYHBuQyAwsWcKCBjHmt1/B9h7H1AS04ru9OzHh3XFRMZzmsT1xpFb6CmEeD6xdSebYdhpOO4mxQqz77/qC6hqKgdtlggiZ3H1X7J99LrSPHCZ9DUVH4jn/3zDU96zRyB1hQ3cgLyTs7y43vP3tOvkiH4idtluOKobweIG1fDtw/J5sFeVNCP+864YsOe3CpYodXjgjj8KnmRJs7T86/0vi6qq2s5cglnFwc4+cXSP1CVxs8i7cSrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbBQq2gCdGQk1D7zzjv1dO6Bsp2df0wGkDPwPwIwxiM=;
 b=zEYf33yWsF38VF5fIhOV0FcVrLdGTMYZorPMO71jNYXRgbtwA6nIeQPuw+d+nAoK66Wo0Cx3Hy1aS3AYovVeFpqJ6j29hwEpJ/dAfBeDNplXcrd4i89qZyPLsymyj4nq8EDMJIhK3CviUPRJ//HbJV8X2OuUjULbH067UDSoh6Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BN6PR1201MB0035.namprd12.prod.outlook.com (2603:10b6:405:4d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Fri, 26 Aug
 2022 16:07:59 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::88f:a211:8c98:a973]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::88f:a211:8c98:a973%7]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 16:07:58 +0000
Message-ID: <3a306901-4e3c-f11a-f947-9afaa4431b36@amd.com>
Date:   Fri, 26 Aug 2022 11:07:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v3 07/10] x86/resctrl: Add sysfs interface files to
 read/write event configuration
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     eranian@google.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, bagasdotme@gmail.com
References: <166117559756.6695.16047463526634290701.stgit@bmoger-ubuntu>
 <166117583337.6695.3477964609702763678.stgit@bmoger-ubuntu>
 <c5777707-746e-edab-2ce2-3405ff55be56@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <c5777707-746e-edab-2ce2-3405ff55be56@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:610:38::19) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e43ea05a-de2b-4e43-647e-08da877d24ef
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0035:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8kQvGRf7NISNCOo0kbvVizqXV8oqZxeAo0vRoFb1EmGKo+eCcBIPPjoIq1ZjdsBPuWWy58zEADPtE+7wmp/f72J95QsIY3J8ZkQnlva869JkK+UbOKKOQCAzhIpvrGPywXmCa91tL2sebT2pzgeTFcnJsIAyah5W5p8dRrCb3CJ0/JwU8Nf31Ss+vEJDR4fRc66XZBEP83lCQWYm2yg9yO+tm/ltJWtilOyyYneDHsETyjHSUI5wYdcGhyzlZxbrgeJAtJDwmjrxuctPHQTVzyG5draQFSvCgIM7AbUFPUr3otUIPp0Tj3KvVR+oC8AdwlrTMBmJxgeCggCWCC8OOG6XP1ymengey/ri81apUrVtoGDVbpvmrSuhA6sd5xBm7oYIC8ca6hCsrRH2NJ+Uey3aBErclsNygPhzhzG9O75MX7s9VucMQ9XpsMKBrBg8hETWizgHwGBkUKKB2qKHS+tLBM9U9fm6xou0Mxlm/EEpAZd5EUUBNJQDhgCFfNAKlut5gyorQCj84xHayhvy8N1/N4i42rBdP54BEM6PB7mrc06jKyboFrn8SrZaK5S5PGGgeopiW6VlErfrb4y3h/syF+orWanyKV1KWKBD4h50HQb5EAAhT6Gq0cbNihXnjypKyOdM/HRoiYFOtCUk5oZKXjPFhpi/uuuhomX1ZZbaSa+SV0KvuEjlHo27y2Q1l1BwzfnvLIgfD5CwwF1Qp6h1hZ0+sKfB/XQeMBcmPr1+9oH9DHFJewMq4DKDPOYxAeRcUdUStb/o5vO5e44bof+NU9hXBh2J00EDX2qmVKc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(31686004)(478600001)(186003)(2616005)(6486002)(5660300002)(4326008)(316002)(66946007)(66556008)(66476007)(8676002)(2906002)(3450700001)(36756003)(38100700002)(8936002)(7416002)(41300700001)(26005)(6666004)(6512007)(6506007)(53546011)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkUvUU0xTGhnOHBVL0NQNHQva1BVYWpSeWR2NlNWMDhMSzJyZkJ4Zk5zMzdx?=
 =?utf-8?B?SWp0MFZ5a0ZJcTVBamdwc0JiNWZrYWpIZ2VBOXpxZTFBaXE1UXQ0TG1oQjRs?=
 =?utf-8?B?VmdaZVdqMXdBeTFIeTd0RXlKM0lpdlZIZkp0YUhHemVMV1BQU1JhQ2RaNWR6?=
 =?utf-8?B?RDM4eHJ0WVVkcW9hOVhTYURqM2RjeCtTd3J2c2JPWkRtRXdmOTl4a2Q1cndO?=
 =?utf-8?B?SVVrZ2xqOWxCV0treXpzeFJmRGZhOU9LTk9TOEVpYjA2Z3VUamQ3cHM4K2Zy?=
 =?utf-8?B?N09Fbklwa0xGb0F5a1V0M055eUNScGo0bEFFWm96R05rcVhmMi9DYm0walo5?=
 =?utf-8?B?QTIrUjJsc2lka0ZFUnhLaG1sQURxZlE5VHNkMjdZWW9Ubi9yUlpyZmhucjcy?=
 =?utf-8?B?Q1VJbXZsbkFoTGtaam5EU1R2bkFvNHNHMmtiMm50d1NGbVBPbXBHREVnWE9E?=
 =?utf-8?B?VGpZNWsxT2VXeCtJNDhjdFdFeittSTZ1Rm85dE9qQ1pCOE9rZnlVMzJ2RVJw?=
 =?utf-8?B?OVlJV1lGemw0MTlpU2pyemoyUURlbVNvWnBUL09xMEowWUlyYzVwSkR0OHZO?=
 =?utf-8?B?Q3lzaUh6cTAyZ2xTWkFwV0taQUdrVXR3Zk5kSWoyN3VVdExnNkI5ZEtIZDcr?=
 =?utf-8?B?cklyU1YzT3RUQVc3VmlsQy9rZ3VnaVVxWmdHYWZ2MGdiOFk2UENWRHBicHRi?=
 =?utf-8?B?RzNlNmF5V1FSbHVFUW5MUjhIbGRIWFJFTzJHL3NYckZSYjEyZlJzOCtDSlly?=
 =?utf-8?B?TUJHcExNQnp0VjZwdTd6MGNhL1doUGFZUWVyWFpwQTFRZjVIeDZQbkZtdjc2?=
 =?utf-8?B?UkUvbFMzS1cxYTJRTytsMC9SandVNWs1SjBUWXBwSXplUm13YTFWNWc3YXNK?=
 =?utf-8?B?ZGFhSTQ2d1lpY0ZZcmF4SXdqdGNxYlhaYVowZnJFT0FBOWJxRXFpNk9EZUlN?=
 =?utf-8?B?R2V3UU51ODZmb2VXUndWOU5JM25NN1lldkhoZTFlMmVHZWRhZ2Y2d1g0YnlM?=
 =?utf-8?B?TkZZUlR0Y0RCTnAydVRPdGhhS0MwbHpvWEtDUmRMREtWQzh4TzZLOTFRQ05H?=
 =?utf-8?B?dm96UTRsMXJ0WXcyQWtPWU1DQWRlNXdMTldPMnBkMXIxY3pXM29EdVpqV3c3?=
 =?utf-8?B?VlUybXZJbWRLZUNsVEc2aFcxdTExcVVNWkd1RkFGSXI3WW9jS3hrQ2NyUTIr?=
 =?utf-8?B?ekhNWGo0eUNwQkV3VmJSWU1RTlhlTFpWanpTaFZJbExzcUJWbnBmRE8ybTJv?=
 =?utf-8?B?bk9Cd1hmVHRxMktkT1ZGWGNZMGV5dGhmUmZJVGVmMXptQ3VjVVVmZ2NOWEtr?=
 =?utf-8?B?azhlUzFvK0E1eWtteGFFOXRkNnl0RFJPcjJoMFhFYUNKMHplekR0U2Qwa0Q4?=
 =?utf-8?B?UlN5QWZ5WDRhdjEyeUUvWHFlY28vMEVhbzlHMzZIMEpZdmhneEdMTFlYaUM4?=
 =?utf-8?B?NGVTOVhEbnJ3MUdtMDVleGNkT1hHeWMvN0VsRmxRQVhNcTBZUmhPd1pjZ3ha?=
 =?utf-8?B?RERnZjRHM0xCQkJsK2lZS1U4U2trTlE5eXZ6WjNJZTBlOTM0YlJMRVpUdE9C?=
 =?utf-8?B?aFlhZjV4aHgwUzNnbjBEY1BMYThoZmM5OWsySWVuY1NCKzNXUXQvN0Rmd3Fs?=
 =?utf-8?B?Nk9jb1g2YlpBdGp3TkFEZmpSTGttMlZPV2lGdjBDT3htcGJaUG5YY0dJOFY2?=
 =?utf-8?B?M2tmQ2x5NmMvNElJL2JHTmN6ckgvTVpwek5jUkZLZmVPcU1Famc3NGxYanFp?=
 =?utf-8?B?VFJvSTVpcGVpczJVajhDZDJJMzNIekZFaG1YdFFnZmUzR01pNGR0M3luQjRL?=
 =?utf-8?B?YS8wMWQ3L2VmdDFTUUZHeTlMOUs3eUt3SUxTUUV6M1ZYVm1PdmdZTDRob3NC?=
 =?utf-8?B?aExVaFJ2NkpqM2QxdklsVjUvTnVVWUtNZWpCYlNrUzBMVERJaDZxYUpyNGQ2?=
 =?utf-8?B?ZCtUTHhaQU5FVVZsTFBpQzNEdzFPVHZUVzJjVUJua2E2ejJFWm5xMVlmSXZG?=
 =?utf-8?B?L0lrY0IzYVhtbkh6eXhORWdjWUNQeVoyRXhKdlJrbHpCZW04dm9hTldQd2du?=
 =?utf-8?B?dHppZCtvcVdIdTV2YWxndjlrczVHeXVXRGY0aGJnSUZ2TURzZUJ0emlhMUty?=
 =?utf-8?Q?izZk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e43ea05a-de2b-4e43-647e-08da877d24ef
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 16:07:58.8239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3O+jnqGHcdtIUmjiVAi6fGrjREiCZjHDId8u6t6Y2LIOqH8XpNCVBRwRynNFepi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0035
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
>> Add two new sysfs files to read/write the event configuration if
>> the feature Bandwidth Monitoring Event Configuration (BMEC) is
>> supported. The file mbm_local_config is for the configuration
>> of the event mbm_local_bytes and the file mbm_total_config is
>> for the configuration of mbm_total_bytes.
>>
>> $ls /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local*
>> /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>> /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_config
>>
>> $ls /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total*
>> /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>> /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_config
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Reviewed-by: Ingo Molnar <mingo@kernel.org>
>> ---
>>  arch/x86/kernel/cpu/resctrl/internal.h |    3 +++
>>  arch/x86/kernel/cpu/resctrl/monitor.c  |    2 ++
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   32 ++++++++++++++++++++++++++++++++
>>  3 files changed, 37 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index c049a274383c..fc725f5e9024 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -72,11 +72,13 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
>>   * struct mon_evt - Entry in the event list of a resource
>>   * @evtid:		event id
>>   * @name:		name of the event
>> + * @config:	current configuration
>>   * @list:		entry in &rdt_resource->evt_list
>>   */
>>  struct mon_evt {
>>  	u32			evtid;
>>  	char			*name;
>> +	char			*config;
>>  	struct list_head	list;
>>  };
>>  
>> @@ -95,6 +97,7 @@ union mon_data_bits {
>>  		unsigned int rid	: 10;
>>  		unsigned int evtid	: 8;
>>  		unsigned int domid	: 14;
>> +		unsigned int mon_config : 32;
>>  	} u;
>>  };
>>  
> This does not seem to be used in this patch.


I will move it next patch if required.

>
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index b9de417dac1c..3f900241dbab 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -656,11 +656,13 @@ static struct mon_evt llc_occupancy_event = {
>>  static struct mon_evt mbm_total_event = {
>>  	.name		= "mbm_total_bytes",
>>  	.evtid		= QOS_L3_MBM_TOTAL_EVENT_ID,
>> +	.config 	= "mbm_total_config",
>>  };
>>  
>>  static struct mon_evt mbm_local_event = {
>>  	.name		= "mbm_local_bytes",
>>  	.evtid		= QOS_L3_MBM_LOCAL_EVENT_ID,
>> +	.config 	= "mbm_local_config",
>>  };
>>  
>>  /*
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 855483b297a8..30d2182d4fda 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -254,6 +254,10 @@ static const struct kernfs_ops kf_mondata_ops = {
>>  	.seq_show		= rdtgroup_mondata_show,
>>  };
>>  
>> +static const struct kernfs_ops kf_mondata_config_ops = {
>> +	.atomic_write_len       = PAGE_SIZE,
>> +};
>> +
>>  static bool is_cpu_list(struct kernfs_open_file *of)
>>  {
>>  	struct rftype *rft = of->kn->priv;
>> @@ -2534,6 +2538,25 @@ void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r, unsigned int dom_id)
>>  	}
>>  }
>>  
>> +static int mon_config_addfile(struct kernfs_node *parent_kn, const char *name,
>> +			      void *priv)
>> +{
>> +	struct kernfs_node *kn;
>> +	int ret = 0;
>> +
>> +	kn = __kernfs_create_file(parent_kn, name, 0644,
>> +			GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, 0,
>> +			&kf_mondata_config_ops, priv, NULL, NULL);
>> +	if (IS_ERR(kn))
>> +		return PTR_ERR(kn);
>> +
>> +	ret = rdtgroup_kn_set_ugid(kn);
>> +	if (ret)
>> +		kernfs_remove(kn);
>> +
>> +	return ret;
>> +}
>> +
>>  static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
>>  				struct rdt_domain *d,
>>  				struct rdt_resource *r, struct rdtgroup *prgrp)
>> @@ -2568,6 +2591,15 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
>>  		if (ret)
>>  			goto out_destroy;
>>  
>> +		/* Create the sysfs event configuration files */
>> +		if (r->mon_configurable &&
>> +		    (mevt->evtid == QOS_L3_MBM_TOTAL_EVENT_ID ||
>> +		     mevt->evtid == QOS_L3_MBM_LOCAL_EVENT_ID)) {
>> +			ret = mon_config_addfile(kn, mevt->config, priv.priv);
>> +			if (ret)
>> +				goto out_destroy;
>> +		}
>> +
> This seems complex to have event features embedded in the code in this way. Could
> the events not be configured during system enumeration? For example, instead
> of hardcoding the config like above to always set:
>
>   static struct mon_evt mbm_local_event = {
>   	.name		= "mbm_local_bytes",
>   	.evtid		= QOS_L3_MBM_LOCAL_EVENT_ID,
>  +	.config 	= "mbm_local_config",
>
>
> What if instead this information is dynamically set in rdt_get_mon_l3_config()? To
> make things simpler struct mon_evt could get a new member "configurable" and the
> events that actually support configuration will have this set only
> if system has X86_FEATURE_BMEC (struct rdt_resource->configurable then
> becomes unnecessary?). Being configurable thus becomes an event property, not
> a resource property. The "config" member introduced here could then be "config_name".
>
> I think doing so will also make this file creation simpler with a single 
> mon_config_addfile() (possibly with more parameters) used to add both files to
> avoid the code duplication introduced by mon_config_addfile() above.
>
> What do you think?

Yes. We could do that. Something like this.

struct mon_evt {
        u32                     evtid;
        char                    *name;

+      bool                     configurable;

         char                    *config;
        struct list_head        list;
};

Set the configurable if  the  system has X86_FEATURE_BMEC feature in
rdt_get_mon_l3_config.

Create both files  mbm_local_bytes and  mbm_local_config in mon_addfile.

Change the mon_addfile to pass mon_evt structure, so it have all
information to create both the files.

Then we can remove  rdt_resource->configurable. 

Does that make sense?

Thanks

Babu Moger

