Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8504B2E0D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 20:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353014AbiBKTyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 14:54:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240210AbiBKTyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 14:54:07 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2075.outbound.protection.outlook.com [40.107.102.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FEE317
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:54:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvPEJ5jzrNdwLoDzbUiLkPis5ZEzpb/h02IKrCeu78PkPCE1uwdRTHGmnR5A1VYrnnMz56A8wteNNEwlIgrEQumQeQ3tV1yeTRbGvBTtdS2ytIVYdPWD0su3+ntncn9KkH/NdMbLBrdwLVII51DUDDHHtcJHMLz6RYXb8yL8/P6c1QiszYZGAle0yMIEHZp9sS9xxnZTRSWUb09qFIMLjOw67X1AbHNACwyxqUymo7qY7GEwt5da/wImyUsxLWF6PaR7XTB+G8qpqB71Kh/6h7umh2rlK9yK8TtDE9JZe40lBubqLCSK0bWHbB1P2PjAsAFhYcGLmiae9ChuYroPfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIG0S3BNIPdLsJl5VJRCcBuL2vSdnw0B+sBdtoynzwM=;
 b=Evu+eewNPnFPl3TW9SrWedNOK2YCtLZoye3KaxM+qA1ddAab6SJqtSyU6BW9udnS9yqgADu4v+psvPjJYxXcw2u/4cbbfqcCynVMFfjKFyITuydXDg3g3rOeJxPYxlbIvi31JECPFDsm9D5KCxuigRmvEMiT7vMl8Blik1YDmoKItQQzO1rQH7h68qWxvY5GgwyGcZVibj4C3E4ENA9zAPfBSMWPIlQqSHz+gBSXshjsKYS6hiUDobN0w4bjT6dSp/ALTubbUREOQWXO6r/5sMO+Y5eMCTmeLGEDxo9lOJ8mJvnm578yHog7D6HhTuPtp0Dg7MhQworArRo5oPUpZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIG0S3BNIPdLsJl5VJRCcBuL2vSdnw0B+sBdtoynzwM=;
 b=3h4W3iR+nszWHTvwJRhwNde6wmJIulOp9l7MPPNMe43+PDOKIIITyIeqX2Mra6oW8F4b28o2pm3Rjx1UPeaXHnliGGWYAjVt2XqzvYNbdKkhQ3DR6XutaqvF0qAxeFMTrXL+ohl/Rtpv3HdpjvI4wyxhyv+aAkhWWOmLEvx6OCk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by MN2PR12MB3695.namprd12.prod.outlook.com (2603:10b6:208:15a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Fri, 11 Feb
 2022 19:54:03 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f%4]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 19:54:03 +0000
Message-ID: <d705b64d-2866-e2bf-2323-dfe0cfe73da8@amd.com>
Date:   Fri, 11 Feb 2022 13:54:01 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 2/2] x86/cpu: clear SME/SEV/SEV_ES features when not in
 use
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, hughsient@gmail.com,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>
References: <20220211053652.64655-1-mario.limonciello@amd.com>
 <20220211053652.64655-2-mario.limonciello@amd.com>
 <4035f596-651c-c167-372b-ffb8ce1a0ac7@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <4035f596-651c-c167-372b-ffb8ce1a0ac7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0324.namprd03.prod.outlook.com
 (2603:10b6:610:118::18) To BL1PR12MB5157.namprd12.prod.outlook.com
 (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4330902a-ef70-4ad7-b746-08d9ed98414a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3695:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB36953CBA82D0C8CF17119011E2309@MN2PR12MB3695.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3DEMjYBV4ZSOP4pCkzTKOUR2qVJRiu+Jv5svd6uNcDJMHQ+DEDHyRKI8SRSSJu+j2nn+/usjkJygR2jL+wBCOza6cfnl/fr/S5BvzZJyO2VvOaBCNmZu5L5svElfUZHQmZEPDxxhx7dTZ2/By2U8YOUXkrI+ZQsyKUg6pEGmwnvNKUscpOz9SCReJ95C6h8SJWEf9MqU/41iIDkduNxG4Fyv6oFM3zJS8M0MrETK0rKICbNqKLj+ly4wBek4y8wsHfjVgIDYsmcagBE7npbkmZNS+R4M/6WeeNYHh9o+jczO4wc/6aWl+lr7HvCAVnjEOhavhW7h4rYeH+RwDlq0C5RSkoWN4YyyUkzPa4qie3zmgFJwxMWdXsX3677M13olnXzr22FmgsVFNncdv38Jty/dEhq1qKNcLPzBM65XQTCcQehJE1b4XXGRpDygbytCzE4rj4jSHVOx+T4WHI3uqpU25uP2dZrRPOKkCCAtK6/XPe3AGMpFkUwOwQuyi4HNI57nQVjAjNRKqpBIAYdCf0Mo01iTfLpUU/3O8hiN2ja8h40C9c0dzrk0hj/0E9RjMCDMJGpa8RBPtlj+8lXkNC4G+97sUsEjPqt0N9Ri463QnU36XxFkEsVh94QHshxrJh/BC3CSvblygS2K1EVZE8T1zwaQkEwhuWxAQ/zF6XZEE4/ED0nDTlMK2fexXJ6AHSnic8O9ubdfYQCAv9nagVas3zus/1fCgxh9H9jnYiUE/jS8MKiN9xRTPtOQ23Hw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(36756003)(508600001)(6486002)(5660300002)(31686004)(2906002)(8676002)(66476007)(186003)(26005)(66556008)(4326008)(66946007)(54906003)(110136005)(8936002)(316002)(6512007)(2616005)(38100700002)(86362001)(53546011)(31696002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUJjcDI4VzRmNXFOeTl3VWwrYzF4dUxObW9SUGFwVjgyZ09PeldlYSt3bFYx?=
 =?utf-8?B?NmtwKytHMjdVSm5LbUZpbHQ0aVp2WFk3OVhtVEdFajF1d2xGZTI1UEhVaTNF?=
 =?utf-8?B?cDhhUmhtWEpaZEJOWXNUOVIyZGhUWXZjTWNzZkRObG1nbGt1dDZEVG8reGR4?=
 =?utf-8?B?blpNR3NaNmlzNUl0NmZ5WnJ3K2FWVjFCOXgvSXdqMnlMWDVIWjhJSVdmRFkz?=
 =?utf-8?B?Z1BySmR5YW42aENNODJXU1VsNFBQWnFLWmVqQlFncjZoQTAydUhBbXpIdTQy?=
 =?utf-8?B?Si9jMVVrRHFXMndzN3VLelJVa0lWdDN3WC9zdFZmZ3RKUWNzUGwxaHVEU0VI?=
 =?utf-8?B?L3c0d2crT0hyUCtibnNSOFpyK2NnanVFdlg4ejJlWW1YNWt4V1JOOUI3WGRG?=
 =?utf-8?B?S1hKcTRuRG5icThNMDgyb25Fc3JQZjFMRVJDOHNWYmhBbytuOGg2UGtGRTcy?=
 =?utf-8?B?UFlPWWhvWHEyY3E5SkVHeWdRYUY3Ui9RdTd0UDZoak10N1h1eFNJeHJYbTIw?=
 =?utf-8?B?N1FHc0d3Tkp1MVlEYzVRbThCZThEUHZ5em5mQlROWFVZUXVveFpqaFVLNmlo?=
 =?utf-8?B?TVV2T05Ud3ZyQ1M0NlpqM0JNNGJBM3lMY2Z5WUYwSlRxa21EakdET0xMRmNK?=
 =?utf-8?B?blBkODhkU0FQNmlKcFN2K3Erb2Z0NlJqK1NCcG4rVmRaRDhXVk1XMk5UcVdi?=
 =?utf-8?B?c1k2ZUlldXZXMG1YZENocFV4dDdWQ0M2emQwQ0laN0Nlblc4ZnllUENSMTRX?=
 =?utf-8?B?U29RK3ZzOWhzRS80OWJuOXVWdk0ydVFyeWgrSXQvUW1ndFh0Q004d3c2UzF2?=
 =?utf-8?B?WXlZTWtNcFIwRHd4bndyWGFZNnBPQmZnWXdZSHBmdmlDYVoyT0NtbGF2ZGtt?=
 =?utf-8?B?OUJMNU1sOTh2cnZMZEpQc0JLczFmYnhHOHhvNG9YMWNyMVU0TFpXMWpnUUR0?=
 =?utf-8?B?V1VHOWZKeE11aUEyakxLOTN4YXdibGtpTWlUUGtRMmxONEt6UjE0UUtmdWNo?=
 =?utf-8?B?V0hkcUIzTHc3eEhGQkQ4OFlSRGJCZXU2d2tpdEFBQVpxVzVncHlUbE9lNFQ0?=
 =?utf-8?B?MHlnSm9Gajk5SlFEOGMxcWI5a2pKa2tPOUw5QTZuTlFvU3UwV3lDK2xMbTRa?=
 =?utf-8?B?eFh1TmhRUnp4N2MyQTEwSVIzSFJteUVSTHloeDB0ZDI1bTBxOE1kaWRvaTBm?=
 =?utf-8?B?aUJYQ1ZFc24yTThkTGpNaWgyVkQzMnFheEdNVW82TlFHc3IwdUN5TUJXZmg4?=
 =?utf-8?B?NXRwY01CTGVlVkN4NWlOSHM0SEdSMlVlS0FDS0xxcTdvbTVOTUZ5L3VISmJw?=
 =?utf-8?B?aWxnRmE3WTZZVm1yQk5uR0NyV050elRETklZOWRZaGNWTVovM3BkQ042UDd6?=
 =?utf-8?B?YnFNQWczc29rMDlVZjdWTHBwbWFHZU1qdkhJUjV3NWJXOEd1ckxiUTF5L0ZF?=
 =?utf-8?B?QUY3NDFBMjJMRDl2MDgvZG4vYU93ck16VFZDRjRhZEJHOFJoMjlvREJhM2J2?=
 =?utf-8?B?ZlM0YUdRazdwTHVseitzT2xSaWNHenhmTGtTcVVSMVhWQnJBZ3Jkc1UrU2VJ?=
 =?utf-8?B?R2RMUXhlb0Jnc1c1U0Q2MWF3WThLOVFyVkgvYnlRenViWXZPTjZFUUY0eHB2?=
 =?utf-8?B?bmtUcTZKL2VidWFEeEI4eHNyZkV6d0JkS3UzcDdlVVNzRjlJNFNxNndYdGJk?=
 =?utf-8?B?MnIzd3pTRW10RGRrVlh3emRWVXhwTk1hZE5lZGZpeE83N0VLK1Nubk00bGZ3?=
 =?utf-8?B?THJoaWNBTnBPckNoNzd5WnR1VWNBSmxvb1Q1UXNTZ3huWUpOUWs5b29xRWND?=
 =?utf-8?B?eUpJQWJVUEtoTEVmcE4zMEdyby9HQmUxSWltdVhpa2NSRkREQjBKbDRRcUd0?=
 =?utf-8?B?RzVWSlI0bFBBTnFFUFZJQUVhYWZRUmt0OGtTSEJwTVhTM0Nrd1NKTi81WURS?=
 =?utf-8?B?MHVyK29SemtnYVhmQ3dONFpyZkV1d3o3YnE0cVdERllaclZadVV3Y2t4UExC?=
 =?utf-8?B?SE5NQWh2T2g3OGVGM0J6b3NLdC9rM0VLdWFsMkc0QXBhOW94Wk9qRjBsYmRr?=
 =?utf-8?B?MFpXdzZwcDlGYjVtRng5SkNPL1Y4WmRRWW44UHlWM2pZc0NVSlZKbk56ak0x?=
 =?utf-8?B?UnAvZENmeWNpQUg3RmE1NjFEWXgrTlUyUFpxc1d1b2pnU09Qb1h5dG8wZ2hP?=
 =?utf-8?Q?yqm2Yt5QEescukDfiJcN30Y=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4330902a-ef70-4ad7-b746-08d9ed98414a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 19:54:03.7113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kebpkf2Hm8Eb+pgQLgU2a30f1y15lmTdVq56TANs+m4nhY3EvV5xdZJg4WIl+HvP9kuELjmiEEO5tDeVergJXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3695
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/2022 08:46, Tom Lendacky wrote:
> +Brijesh (please copy him, too, on all SEV related things)
> 
> On 2/10/22 23:36, Mario Limonciello wrote:
>> Currently SME/SEV/SEV_ES features are reflective of whether the CPU
>> supports the features but not whether they have been activated by the
>> kernel.
>>
>> Change this around to clear the features if the kernel is not using
>> them so userspace can determine if they are available and in use
>> from `/proc/cpuinfo`.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   arch/x86/kernel/cpu/amd.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
>> index 4edb6f0f628c..4a7d4801fa0b 100644
>> --- a/arch/x86/kernel/cpu/amd.c
>> +++ b/arch/x86/kernel/cpu/amd.c
>> @@ -611,12 +611,20 @@ static void early_detect_mem_encrypt(struct 
>> cpuinfo_x86 *c)
>>           if (!(msr & MSR_K7_HWCR_SMMLOCK))
>>               goto clear_sev;
>> +        if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT))
>> +            goto clear_all;
>> +        if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>> +            goto clear_sev;
>> +        if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
>> +            goto clear_sev_es;
>> +
> 
> A host/hypervisor will never see GUEST related attributes return true, 
> you need to verify all uses of X86_FEATURE_SEV* in the kernel. I see two 
> files where this change will break SEV hypervisor support:
> 

Maybe it's best then to just check for/clear the SME feature at this 
time and let Brijesh handle plumbing the applicable removals/additions 
for SEV/SEV_ES separately.

> - arch/x86/kvm/svm/sev.c / sev_hardware_setup()
> - drivers/crypto/ccp/sev-dev.c / sev_dev_init()
> 
> I imagine that some of this has to be re-thought a bit. The current SEV 
> and SEV-ES feature attributes are intended for hypervsior side usage.  
> For example, MSR MSR_K7_HWCR_SMMLOCK, which is likely never going to be 
> provided to a guest, needs to be checked to be certain that an SEV guest 
> can be launched, even though SEV is advertised in CPUID.
> 
> Once in the guest, it is the cc_platform_has() support that determines 
> feature support and not X86_FEATURE_SEV*
> 
> Thanks,
> Tom
> 
>>           return;
>>   clear_all:
>>           setup_clear_cpu_cap(X86_FEATURE_SME);
>>   clear_sev:
>>           setup_clear_cpu_cap(X86_FEATURE_SEV);
>> +clear_sev_es:
>>           setup_clear_cpu_cap(X86_FEATURE_SEV_ES);
>>       }
>>   }

