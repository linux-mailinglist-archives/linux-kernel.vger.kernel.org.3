Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94697588FF2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 18:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236984AbiHCQAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 12:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiHCP76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 11:59:58 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF313890;
        Wed,  3 Aug 2022 08:59:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cItAfpAC6lbzEaaz4GlMQB+KokJX4iqX4wQIYZveF4rmOB5q1c2AegoKiKfW+isnsFN/gSLZw8O3YWCFNfaq1oFam1Xv+PUklkAWSdX9KaSL66A7c86ihuFzTYbssjYzLTHKkhu4qPVE8r7pLv4joreqC90+548ckmPUvx9SKhEiGNFt0PVXmE2oRXyAWKLV/1xIyIJ78OIwXpMwcXggXg6GO+KkUQzuLvd6XNo19FEUz72f+nEfkDB1KaHUlb10XJIz+7/pZpN8O4qp+pskaPq9UiQEiXVlfyRpArew0F14sYT9uhdsseBd5JCOGTwLMKQXTx3B8Ph0wgGkcpoiYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GpyKNF0o4wm2GjTEi7Xi9sEHyULX28uNIq6YMRZjOxg=;
 b=Hql87sb8+Y3Zap5C2HNudd2MizYY+PolJiYBTpSj8M25U11daES7g0xfzLkUOv4DH5tzpP/gYp3HOMD6FxGsjt762wiV2qK8uHWII4jSZMUfXUvUbjqrxqgu/hV9No9Qkmsad56B5NyzClGSXnjqZQSxF2xmijeOsJACc+SV7f834sP1DECG+9g72ZVnwcqV4z0g/KKiBjyaxG9hODLfRFad/vSDneA0o1dEoK2oqsq4V8OhG6WtnlTZgOM0j856UlQKPebMES/WRmJfGtKuJF5aQJEhgwzcL5PRwZH83MSQfCjGHQGe/Js/ab/limYdAMPPAsvbd3Sk6533RMsqOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpyKNF0o4wm2GjTEi7Xi9sEHyULX28uNIq6YMRZjOxg=;
 b=X+F+oJIEZycnTspQIHMT0wzQ/viTuVg+KM9BVztATuM21qnIEcf9+6iwFpfX8E936jXU3QEsZ0t+wwK+VDGbMhru4yyiv1++kEMViwgwxMLG2QDpy+MO1kqYSPcSXuBbP3Zpsp8SBhrleLGn1wriDA7Ybn69LT6XHElscsk6HpQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Wed, 3 Aug
 2022 15:59:53 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::9cd6:1681:8b67:cdcd]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::9cd6:1681:8b67:cdcd%3]) with mapi id 15.20.5482.016; Wed, 3 Aug 2022
 15:59:53 +0000
Message-ID: <0c3721ba-b564-733a-16d5-5150d2b7a885@amd.com>
Date:   Wed, 3 Aug 2022 10:59:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2 10/10] Documentation/x86: Update resctrl_ui.rst for new
 features
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     fenghua.yu@intel.com, reinette.chatre@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        eranian@google.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <165938717220.724959.10931629283087443782.stgit@bmoger-ubuntu>
 <165938740360.724959.7059659465268246182.stgit@bmoger-ubuntu>
 <YunwoDwcy7GZoKXA@debian.me>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <YunwoDwcy7GZoKXA@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0054.namprd14.prod.outlook.com
 (2603:10b6:610:56::34) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 117c6905-3bc2-4d9a-2854-08da756933fd
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HMROTjBWAs5SZCcfvFxj/GvsHyzpXVyYuZ44fMQwLGJhzcTIA6kFdEz+UaQVRLUpADFT3VwgExrTEwYUP1rk9e6Zvo+09bGX4EwSaY7GEkIFNYeKgmy26r8nx70j09xHsx/9poFxS9PwoewoMhJBgUil9+Y8Wg9UWd+z7pCNWSqIaODvtYg7r+meB776oItgzFDAOGNpr7CJiEA9MHCQkaMenOyU5YE5zOHr4wrMrQ2BDOVwEWcALxiNgHuL96x6UepqQ4D+MJ2mjtZl/H+s5jrFaG96OwJoT6Jj8bc8zoYIyocqGJEpZtXmUcgPxez8HkS227RCTGXV32jXsQExZQ4FwdIQZe92oM9OxdGQgkY+dZgvDHUM+dnq6ZYR1vrfPmSusc1RH8kCQzBujfNLBMsUcR4A8Jcxa56D/J4KUrgFsSUkKQMQTUUT1M8wYENmgiclfPrK1jkFYPNsUpnwFRX8+/ZfqTvGtDAmtmZp1mRPX3Wndao7P/dGiM4o82avwI+bnUzBeUQnMUN73a70liiLAbnd+85sqYOR1eIFfuolS5pVC9skCE+9Rv1/TC/1SU6Enl03ghaueneJYd9gb5F28xuBnePWCBs/ltDl/MFXbRxGcuENsbRgXSSfuFkVnxQMI7kNljEjtrqmBAYHlDpIljbh9UhQkmV/lpsoZ/8WGWCL+aD3Kvgab2N6mH524AiA53QFZYvSxoJf9Og4XbRm94JM+FqtJRg7MVQyqDcTQ+sJqmuzjWMb15IailpTHTSsRTBakgci7ueLKvZZtb3KyYqY1ncAnP2BWbOo6VN5004m1ewEPrmvkYRwO4rjyoR9or5mjKjdynoX5TQfEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(3450700001)(15650500001)(6506007)(316002)(53546011)(6916009)(2906002)(31696002)(4326008)(66556008)(8676002)(5660300002)(66946007)(7416002)(83380400001)(66476007)(8936002)(30864003)(86362001)(41300700001)(478600001)(38100700002)(36756003)(186003)(6512007)(26005)(2616005)(31686004)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk5MTTRwbjdQbnYvaUNOYk44L2xsWE0zV0ZCa29vZnovdjdvVFRHTi93bFVS?=
 =?utf-8?B?NUMzcG1MRDZ0Q1Z4Vnpkd2JnYVBkOW5jK2tNTEVXQzNsemtrYkVmT2xYQnAz?=
 =?utf-8?B?azhwUjQ1RFVHa21ZZHB0dktsenVxQ0lNUTN1RTk2SUpWZ3F0VUFlZFVBanpz?=
 =?utf-8?B?TTNVSFdhOEgzWWl2b24yRUp4YkVselRxbk5TZWFBVFQrRnNpOVBUWjFDWldj?=
 =?utf-8?B?ZFN0WUg5QWg3NnJMckVwNzFQN00vV1JwYjBreEJHNlJvcW0rb2kzYXRkT1FU?=
 =?utf-8?B?T2NOeFp4dlhaemRpZlBwNnA2WFdTd0RxR1R4ZVRSYS9mclpMZGlYYjlhaWlh?=
 =?utf-8?B?SWlWWTBlbk4xbjZ3OXlsWWZWeFFnaVpuQ0RCUDFOTHQxNm8vanJFVXB0MXBF?=
 =?utf-8?B?Z3JJTTB0MUZIRnVBMkI2NWF4QThLYkl3K2labm5GM2NUcXNOZ2VBQmlHYjI0?=
 =?utf-8?B?Q283Zk1SN01xcHNrRVN3R1F2UFhuYzRuRXdPRjdPYUlyZ2FiRy9TdnV1WTJQ?=
 =?utf-8?B?KzFVNVpndERVNHg3ZDRFbnFFNDBxU3VqL1RuOG1UdzFrUGEzbmwraGxGTTBw?=
 =?utf-8?B?TThnYWVoSXd4RjhsSlhiRStOd0ZDcjF4cTNmcFo3U055Y1Z4dWtGbWE4LzEw?=
 =?utf-8?B?SDJiZG4zc1FzNnBMaVJiRUxraVN0UTF0eUxVQW1hKzV1bGtOTmFuODdhdzVk?=
 =?utf-8?B?MWROdzB1UDZQSlpVY1owZjQ2R1BhSnVTaFZ3RkRkMnRqSzhHK2xNM1lmZGdS?=
 =?utf-8?B?VDg1U0RZczYyRC9nQWRJWUdJdXFXc3J5ZmU1Vjl2TkRYemhuNmxwRWlmc1dN?=
 =?utf-8?B?eGR0VmRFVkxVVEtSK1YvY0NUYXpqd1dRWUtWeURlMHJrQVNBTFVub05OUVNv?=
 =?utf-8?B?MWhPc2hPbS9Oak9hL2dOM1ZDcXBsTSsrUHl1OXlUZDZpSWNnVVdTNjc0N25G?=
 =?utf-8?B?aWZMejQ2YVAzWStyNWQ5OXNvNC9jeGE5WUk4bWpQbC9xNVA3ZnhDc2wyV3JP?=
 =?utf-8?B?TnBQU3VFdFAxblRqWVhlYkNBKzh6Sk0xOFVhem10UStSekpUekF0UHpDNXpE?=
 =?utf-8?B?dEUrY1VnbGRsZUNlNHBUejY1RkRkV1VZc242QXlWSWZYUTdmbnhqN08xc2xB?=
 =?utf-8?B?eHNlK3RPWVkzK0xTNHFkTGtxZ05uY0RCVVhid0RxcWhNUGZGU0dDR2lNNkVn?=
 =?utf-8?B?YUFxb2hlY3NKNjFzSGpZb0d3TUFiWUVPOVJ3c0t3aC9iNUhxVzRZc0tGOVhB?=
 =?utf-8?B?SlRsZUdyZkN6VDBVeVVIV1pCZTdEWHVyTWcrTFI1akZpc2tYSitEaWVkU0Vr?=
 =?utf-8?B?R2tUempTWTFiR3VYcFRINm1XUmp0MTQrd1MwcmJmS3VTb3owbWR0cGozc1VQ?=
 =?utf-8?B?dnU5N2ExNXZxRTNIMlJqcE9lZTJlWDYvVVpDMnpoNGhMaUV4T2FSTGNCMnkw?=
 =?utf-8?B?M1FnM3l2eTltNHA0RHJhQTF6THl5K1d2aERtL2txV2lSelJNbk9WYUVHcG9s?=
 =?utf-8?B?UmVZcFM0NkFSTmRQS0RVRHg5TEtnTSt2dmdmai9scEVJczZTNHZyUm1tSnFK?=
 =?utf-8?B?Q0UyaEdoTlF5Uzk0a3hGV2FmWnRmRWJDMUhwZkdvU3hpMDNlTlkyWlZSdk02?=
 =?utf-8?B?WXQ1UlU4aXVHMU5iVXNOVjAydmRJNmlwa0dIcVhWWFEyMVdPSU1seWw1VTZR?=
 =?utf-8?B?NXhGNjIremRGODRsWkQwSEVkaWhhVi9ZeHBmbHR4RjdGd09WZUpkSElRVENa?=
 =?utf-8?B?Wm5oSzhMRENPTXI2YlY5QjVyQndPVXorb2FkWUZRVTU4VlllK21GdWd0U3p0?=
 =?utf-8?B?VDlVRk9peWwzblp4Q28rd0dWdThYZkZ2TVhzT21vS2FjejkxU1k3aHNxbWRF?=
 =?utf-8?B?cXdqenVVZlh4T2pPSUZUVjhaYTJQZDhaOWNZbXcyNG5FSzlWbHlkRkpUaW0y?=
 =?utf-8?B?TnVhTmpiME5lUThyQnJuamRzaGx0U0U5MHR2T2ZTTS9teXN1RGRlcU9KbEgz?=
 =?utf-8?B?UFVEM000VlBaQWE5OC9uRkxwZEdWb0huV0ozait4RHFPY2U2SUxsTkIxRHlz?=
 =?utf-8?B?NW1yak91VjJWT1c3aHpnUytpQ21XSUs1OHhlaGdQeFlOSWx6RFEzM1pHbXJ0?=
 =?utf-8?Q?r/PI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 117c6905-3bc2-4d9a-2854-08da756933fd
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 15:59:53.2622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHcw6dogTmDH8Unh0WbDGUitDiryTNR9juhvm4uwCYp7KuRSi1UdJC+emROSuM+a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5762
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bagas,

On 8/2/22 22:50, Bagas Sanjaya wrote:
> On Mon, Aug 01, 2022 at 03:56:43PM -0500, Babu Moger wrote:
>> Update the documentation for the new features:
>> 1. Slow Memory Bandwidth allocation.
>>    With this feature, the QOS  enforcement policies can be applied
>>    to the external slow memory connected to the host. QOS enforcement
>>    is accomplished by assigning a Class Of Service (COS) to a processor
>>    and specifying allocations or limits for that COS for each resource
>>    to be allocated.
>>
>> 2. Bandwidth Monitoring Event Configuration (BMEC).
>>    The bandwidth monitoring events mbm_total_bytes and mbm_local_bytes
>>    are set to count all the total and local reads/writes respectively.
>>    With the introduction of slow memory, the two counters are not
>>    enough to count all the different types are memory events. With the
>>    feature BMEC, the users have the option to configure mbm_total_bytes
>>    and mbm_local_bytes to count the specific type of events.
>>
>> Added the instructions to configure with examples.
>>
> Say "Also add configuration instructions with examples" instead.
Sure.
>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  Documentation/x86/resctrl.rst |  123 +++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 123 insertions(+)
>>
>> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
>> index 71a531061e4e..ba6833171c0a 100644
>> --- a/Documentation/x86/resctrl.rst
>> +++ b/Documentation/x86/resctrl.rst
>> @@ -167,6 +167,12 @@ with the following files:
>>  		bytes) at which a previously used LLC_occupancy
>>  		counter can be considered for re-use.
>>  
>> +"mon_configurable":
>> +                Provides the information if the events mbm_total and
>> +                mbm_local are configurable. See the configuration
>> +                details for "mbm_total_config" and "mbm_local_config"
>> +                for more information.
>> +
>>  Finally, in the top level of the "info" directory there is a file
>>  named "last_cmd_status". This is reset with every "command" issued
>>  via the file system (making new directories or writing to any of the
>> @@ -264,6 +270,29 @@ When monitoring is enabled all MON groups will also contain:
>>  	the sum for all tasks in the CTRL_MON group and all tasks in
>>  	MON groups. Please see example section for more details on usage.
>>  
>> +"mbm_total_config":
>> +"mbm_local_config":
>> +        This contains the current event configuration for the events
>> +        mbm_total_bytes and mbm_local_bytes, respectively, when the
>> +        Bandwidth Monitoring Event Configuration (BMEC) feature is supported.
>> +        These files are organized by L3 domains under the subdirectories
>> +        "mon_L3_00" and "mon_L3_01". When BMEC is supported, the events
>> +        mbm_local_bytes and mbm_total_bytes are configurable.
>> +
>> +        Following are the types of events supported.
>> +        Bits    Description
>> +        6       Dirty Victims from the QOS domain to all types of memory
>> +        5       Reads to slow memory in the non-local NUMA domain
>> +        4       Reads to slow memory in the local NUMA domain
>> +        3       Non-temporal writes to non-local NUMA domain
>> +        2       Non-temporal writes to local NUMA domain
>> +        1       Reads to memory in the non-local NUMA domain
>> +        0       Reads to memory in the local NUMA domain
>> +
> Why not use table?

I have not used the table in vim. But pulled your diff. Now it looks like
table.

Hope that works.

>
>> +        By default, the mbm_total_bytes configuration is set to 0x7f to count
>> +        all the event types and the mbm_local_bytes configuration is set to
>> +        0x15 to count all the local memory events.
>> +
>>  Resource allocation rules
>>  -------------------------
>>  
>> @@ -464,6 +493,14 @@ Memory bandwidth domain is L3 cache.
>>  
>>  	MB:<cache_id0>=bw_MBps0;<cache_id1>=bw_MBps1;...
>>  
>> +Slow Memory bandwidth Allocation (when supported)
>> +------------------------------------------
>> +
>> +Slow Memory b/w domain is L3 cache.
>> +::
>> +
>> +	SB:<cache_id0>=bandwidth0;<cache_id1>=bandwidth1;...
>> +
>>  Reading/writing the schemata file
>>  ---------------------------------
>>  Reading the schemata file will show the state of all resources
>> @@ -479,6 +516,44 @@ which you wish to change.  E.g.
>>    L3DATA:0=fffff;1=fffff;2=3c0;3=fffff
>>    L3CODE:0=fffff;1=fffff;2=fffff;3=fffff
>>  
>> +Reading/writing the schemata file (on AMD systems)
>> +---------------------------------------------------------------
>> +Reading the schemata file will show the state of all resources
>> +on all domains. When writing the memory bandwidth allocation you
>> +only need to specify those values in an absolute number expressed
>> +in 1/8 GB/s increments. To allocate bandwidth limit of 2GB, you
>> +need to specify the value 16 (16 * 1/8 = 2).  E.g.
>> +::
>> +
>> +  # cat schemata
>> +    MB:0=2048;1=2048;2=2048;3=2048
>> +    L3:0=ffff;1=ffff;2=ffff;3=ffff
>> +
>> +  # echo "MB:1=16" > schemata
>> +  # cat schemata
>> +    MB:0=2048;1=  16;2=2048;3=2048
>> +    L3:0=ffff;1=ffff;2=ffff;3=ffff
>> +
>> +Reading/writing the schemata file (on AMD systems) with slow memory
>> +---------------------------------------------------------------
>> +Reading the schemata file will show the state of all resources
>> +on all domains. When writing the memory bandwidth allocation you
>> +only need to specify those values in an absolute number expressed
>> +in 1/8 GB/s increments. To allocate bandwidth limit of 8GB, you
>> +need to specify the value 64 (64 * 1/8 = 8).  E.g.
>> +::
>> +
>> +  # cat schemata
>> +    SB:0=2048;1=2048;2=2048;3=2048
>> +    MB:0=2048;1=2048;2=2048;3=2048
>> +    L3:0=ffff;1=ffff;2=ffff;3=ffff
>> +
>> +  # echo "SB:1=64" > schemata
>> +  # cat schemata
>> +    SB:0=2048;1=  64;2=2048;3=2048
>> +    MB:0=2048;1=2048;2=2048;3=2048
>> +    L3:0=ffff;1=ffff;2=ffff;3=ffff
>> +
>>  Cache Pseudo-Locking
>>  ====================
>>  CAT enables a user to specify the amount of cache space that an
>> @@ -1210,6 +1285,54 @@ View the llc occupancy snapshot::
>>    # cat /sys/fs/resctrl/p1/mon_data/mon_L3_00/llc_occupancy
>>    11234000
>>  
>> +Example 5 (Configure and Monitor specific event types)
>> +-------------------------------------------------
>> +
>> +A single socket system which has real time tasks running on cores 0-4
>> +and non real time tasks on other CPUs. We want to monitor the memory
>> +bandwidth allocation for specific events.
>> +::
>> +
>> +  # mount -t resctrl resctrl /sys/fs/resctrl
>> +  # cd /sys/fs/resctrl
>> +  # mkdir p1
>> +
>> +Move the CPUs 0-4 over to p1::
>> +
>> +  # echo 0xf > p1/cpus
>> +
>> +View the current mbm_local_bytes::
>> +
>> +  # cat /sys/fs/resctrl/p1/mon_data/mon_L3_00/mbm_local_bytes
>> +  112501
>> +
>> +Change the mbm_local_bytes to count mon-temporal writes to both local
>> +and non-local NUMA domain. Refer to event supported bitmap under
>> +mbm_local_config::
>> +
>> +  # echo 0xc > /sys/fs/resctrl/p1/mon_data/mon_L3_00/mbm_local_config
>> +
>> +View the updated mbm_local_bytes::
>> +
>> +  # cat /sys/fs/resctrl/p1/mon_data/mon_L3_00/mbm_local_bytes
>> +  12601
>> +
>> +Similar experiment on mbm_total_bytes. First view the current mbm_total_bytes::
>> +
>> +  # cat /sys/fs/resctrl/p1/mon_data/mon_L3_00/mbm_total_bytes
>> +  1532501
>> +
>> +Change the mbm_total_bytes to count only reads to slow memory on both local
>> +and non-local NUMA domain. Refer to event supported bitmap under
>> +mbm_total_config::
>> +
>> +  # echo 0x30 > /sys/fs/resctrl/p1/mon_data/mon_L3_00/mbm_total_config
>> +
>> +View the updated mbm_total_bytes::
>> +
>> +  # cat /sys/fs/resctrl/p1/mon_data/mon_L3_00/mbm_total_bytes
>> +  104562
>> +
>>  Intel RDT Errata
>>  ================
>>  
>>
>>
> When building this documentation, I get new warnings:
Is there a command I can use to build? That would be helpful next time.
>
> Documentation/x86/resctrl.rst:275: WARNING: Unexpected indentation.
> Documentation/x86/resctrl.rst:497: WARNING: Title underline too short.
>
> Slow Memory bandwidth Allocation (when supported)
> ------------------------------------------
> Documentation/x86/resctrl.rst:497: WARNING: Title underline too short.
>
> Slow Memory bandwidth Allocation (when supported)
> ------------------------------------------
> Documentation/x86/resctrl.rst:538: WARNING: Title underline too short.
>
> Reading/writing the schemata file (on AMD systems) with slow memory
> ---------------------------------------------------------------
> Documentation/x86/resctrl.rst:538: WARNING: Title underline too short.
>
> Reading/writing the schemata file (on AMD systems) with slow memory
> ---------------------------------------------------------------
> Documentation/x86/resctrl.rst:1289: WARNING: Title underline too short.
>
> Example 5 (Configure and Monitor specific event types)
> -------------------------------------------------
> Documentation/x86/resctrl.rst:1289: WARNING: Title underline too short.
>
> Example 5 (Configure and Monitor specific event types)
> -------------------------------------------------
>
> I have to apply the fixup:
>
> ---- >8 ----
>
> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
> index ba6833171c0a39..886cb9bd7a181c 100644
> --- a/Documentation/x86/resctrl.rst
> +++ b/Documentation/x86/resctrl.rst
> @@ -270,8 +270,7 @@ When monitoring is enabled all MON groups will also contain:
>  	the sum for all tasks in the CTRL_MON group and all tasks in
>  	MON groups. Please see example section for more details on usage.
>  
> -"mbm_total_config":
> -"mbm_local_config":
> +"mbm_total_config", "mbm_local_config":
>          This contains the current event configuration for the events
>          mbm_total_bytes and mbm_local_bytes, respectively, when the
>          Bandwidth Monitoring Event Configuration (BMEC) feature is supported.
> @@ -279,8 +278,11 @@ When monitoring is enabled all MON groups will also contain:
>          "mon_L3_00" and "mon_L3_01". When BMEC is supported, the events
>          mbm_local_bytes and mbm_total_bytes are configurable.
>  
> -        Following are the types of events supported.
> +        Following are the types of events supported:
> +
> +        ====    ========================================================
>          Bits    Description
> +        ====    ========================================================
>          6       Dirty Victims from the QOS domain to all types of memory
>          5       Reads to slow memory in the non-local NUMA domain
>          4       Reads to slow memory in the local NUMA domain
> @@ -288,6 +290,7 @@ When monitoring is enabled all MON groups will also contain:
>          2       Non-temporal writes to local NUMA domain
>          1       Reads to memory in the non-local NUMA domain
>          0       Reads to memory in the local NUMA domain
> +        ====    ========================================================
>  
>          By default, the mbm_total_bytes configuration is set to 0x7f to count
>          all the event types and the mbm_local_bytes configuration is set to
> @@ -494,7 +497,7 @@ Memory bandwidth domain is L3 cache.
>  	MB:<cache_id0>=bw_MBps0;<cache_id1>=bw_MBps1;...
>  
>  Slow Memory bandwidth Allocation (when supported)
> -------------------------------------------
> +-------------------------------------------------
>  
>  Slow Memory b/w domain is L3 cache.
>  ::
> @@ -517,7 +520,7 @@ which you wish to change.  E.g.
>    L3CODE:0=fffff;1=fffff;2=fffff;3=fffff
>  
>  Reading/writing the schemata file (on AMD systems)
> ----------------------------------------------------------------
> +--------------------------------------------------
>  Reading the schemata file will show the state of all resources
>  on all domains. When writing the memory bandwidth allocation you
>  only need to specify those values in an absolute number expressed
> @@ -535,7 +538,7 @@ need to specify the value 16 (16 * 1/8 = 2).  E.g.
>      L3:0=ffff;1=ffff;2=ffff;3=ffff
>  
>  Reading/writing the schemata file (on AMD systems) with slow memory
> ----------------------------------------------------------------
> +-------------------------------------------------------------------
>  Reading the schemata file will show the state of all resources
>  on all domains. When writing the memory bandwidth allocation you
>  only need to specify those values in an absolute number expressed
> @@ -1286,7 +1289,7 @@ View the llc occupancy snapshot::
>    11234000
>  
>  Example 5 (Configure and Monitor specific event types)
> --------------------------------------------------
> +------------------------------------------------------
>  
>  A single socket system which has real time tasks running on cores 0-4
>  and non real time tasks on other CPUs. We want to monitor the memory
>
> Thanks.
>
I have pulled your diff now. Thank you

-- 
Thanks
Babu Moger

