Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA5154A7B9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 06:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237666AbiFNECb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 00:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236612AbiFNEC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 00:02:26 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A00B1E0;
        Mon, 13 Jun 2022 21:02:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haEIOSbz2XePDmCI3CMSrQ6xmgoBBquRS7sy9qCit7fVv8NJLFbjRCdFEwCbwr1tmjslpqJGJxbtloZcUH0AGwGwniVE+dHdRyRWhlKIyKrPYPIfXHskc84lcdUKfksKsS0+/qf/Si84YRKJB98RMknz/Li0wYD4q7TV1MbJ5mMPcebnii52FT2y2YwAogzKYxSqJ+5lyNW6DK0AlpJ6JlGlj90rHYDPPhi86LaLeVDoLoXktVcVC0p0wFLgC5GL7czrZF4XE2kiGTkQ+lrO83ZR77wE9AItBTTBhC1JUZQJ1bPVa60WDQODSWnYNeXdIJ8oE3+Ha4RxPzL2RbseqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnSTrjd3Hw2KI8oGk6zKTWHFS+vNIDPbYYof6Kn5Ero=;
 b=XsC3w7XAm06BnwZbl7Kw3tsTw3nZwlB6bSkRQDciDzeu07tU61kMwA8k3OO8SKiEAkdYUQobqC2shcgnX3dQTcGS/rYU2PgtCuOwgiZPL6ro7kwO8tVwTkON5P8tKpifWw5143DnKnZFTgqTabkww0EVJv3SPbNGFAy8gYuk/OgljoYTW1ah09s8AS/s3IN/o8vcDPbJYeGT4TiPk0Bp/rt36rYcU31xXoCd8FOJChD4ZdskL9lH8Wjr5NiWyCI8Oy6TEpsJiJfyYii/+27t5+eMCFxVMC+c/B1xw+GsFn1g7DOXzXJfZ/JH3V9YoYclMjmLKISRqg/Q8ON9z9xgDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnSTrjd3Hw2KI8oGk6zKTWHFS+vNIDPbYYof6Kn5Ero=;
 b=SkbkJxCyZQBwKxfCfhVOua4R3VM4lzvlpsIQDfquDTWgXZPFsWO6EQmqmMGgJHuOsLeeJqw1ZZPDh0C3ijHMGYjEuJSxhjOKOJXDYqYx5QsAy5XEN4kmE9gic2L7ame4KVLPc79l80abfjS8Hm9OqOgxMRdwvcMj1/YTPro1QLY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4990.namprd12.prod.outlook.com (2603:10b6:208:fe::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Tue, 14 Jun
 2022 04:02:22 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3839:4183:6783:b1d1]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3839:4183:6783:b1d1%5]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 04:02:22 +0000
Message-ID: <5c4e116b-c710-9978-a370-853aaf57225d@amd.com>
Date:   Mon, 13 Jun 2022 23:02:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] cpufreq: amd_pstate: fix the highest perf query for new
 AMD processors
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jane Malalane <jane.malalane@citrix.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Cc:     Ray.Huang@amd.com, Jinzhou.Su@amd.com, Li.Meng@amd.com,
        linux-pm@vger.kernel.org
References: <20220614035229.170852-1-Perry.Yuan@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20220614035229.170852-1-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR06CA0044.namprd06.prod.outlook.com
 (2603:10b6:8:54::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18fb4546-36c1-47d8-356f-08da4dbaaed5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4990:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB49905C34C2C066B4AF6AC533E2AA9@MN2PR12MB4990.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 97Lpo/QAr1OQysYGitKmVNi0vlIv3CMEyi859dVsBF+Rc34T0tuokJ76tYqm7rg4EwwhPMhmUoOXLkv2CgtAp2OUg6Dpa2jQ1BkR9MrGS7PS/LWzHECNwrKAKCVUwG+yCzr/fmk63H4Eev8EaIK4JiafWTohB4GWoxEeOsBKlp0X0rcxqiVgsV8rlhWKzFgb34MfRKwTIKTo43AssWbnZpSpaZtZ9vJmBHsNPTgrihkv23Kjsx8G5zyZY5X3fwrZe4iXQ4p3k/3aYp/Yl8zEGA6UWFKIRdbCN97nYaW2U+4YnX6C9fTWTs/pDhLG9+clYdzdO1fes1B2bdGzW6DzwG6V3sTZzg6CyknTMExi1sigwtpRFtXZwfPvsm5vou90S+UsfDSO32WrmmdMXT6F3Zj2m+0NjgS+z8sh6sWqItCxC8+LUQTBgKDX2MTGZogIrc90eKedBKr587JvqYfdCoQhsGbxwPqxssOrhLTgfDueKXsxq8qsmINwsjVgAV1XcbPLd8ESqxGt5NLISa+UT1/X2F2B/mJbeTAd8KTli1vtzoZEkdJyHAKQQNEzs4TKwTOeTz7kFHfvhNBNwLMVXzKIwT1pWHuCet/hmpzDs/Bcp3ZZKODgfi6hLXJO4ozd1nkgtJ7htvrKxwuMtylizRg9BCE2R0PCQLP/4TDLkwjbkEWo87shq16o+kuKaia/KwB3rFmpD0LQNoaCigAmaRnISTgwYG0Uysal/7NTCfj9UKULRpbZrmFNGQbxcu1EhCjtTKZNdtWcWrDaUcdfhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(36756003)(316002)(83380400001)(26005)(31686004)(921005)(2616005)(110136005)(186003)(8936002)(6486002)(44832011)(66556008)(66946007)(7416002)(66476007)(2906002)(5660300002)(508600001)(6506007)(4326008)(8676002)(38100700002)(86362001)(53546011)(6512007)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enBZb0M2cjFCVjR6RWUzOEVkR2NRUVY3UG9PNWJKSTRqRCttWXVkR3orSzYy?=
 =?utf-8?B?WUcxRTczZi8zUUVMYm9EUGcvSUJidU9SRmErcW5MSVNiZEY0UlNSY3E2b3NY?=
 =?utf-8?B?UnlRMlZmNlJVS21BaXF5VmxJMnBHMEtXVW1sTFhHb0RVd3VhK0g1S3FKNXB1?=
 =?utf-8?B?RUJpdFc0M3hvNFJJQlp6Q3VXbG1WS2IvMUNtT3hwcWZlZVpobHdmelYvRjVs?=
 =?utf-8?B?U3Nmdm5EQ0k5dTRyRDRLcHhtQk9KTCtVSnhsQnJZU1lNWWRleklvNFg1dVJz?=
 =?utf-8?B?QmtLZ2lSVnV2ZWtFaU00WG1pQ2UwOW5sa0x1azM1LzFzMjBGdmtRcXRuQlNv?=
 =?utf-8?B?Vm9PcStrRGx5YVUra2xFTjg5SWpQM2czRnNhMTc4YklHdllmTFhSMXdXekQ2?=
 =?utf-8?B?S3FLUnlKekJEL0RicG1nMklReEZqMzkxVjAvdjBGTkVJUmM4ZWRJTGZZN1VS?=
 =?utf-8?B?L1RsN29jYkRsd1FyMEF1cUp3ejVUaTl5ckprMGg5R3A3VWVYblltMVk0YXp0?=
 =?utf-8?B?bVZzdFB4TTFudmdLRGNVZFk5ZzlBR2wvaVJ3SnBWdG56WFhVTjNQSGN5eHpw?=
 =?utf-8?B?bGViY1pnU3J0VjFkVU4wSXMrYTlMUnFLSllta0RXYmNySC9iTlVDZFJTVVNk?=
 =?utf-8?B?WVNqU0ZnUjd5c0RTQXo1VkJkbG5BZzltL2dLMHI3aEYvZ3REMXVzRXozN0Y2?=
 =?utf-8?B?akNwM1ppYzNVOU1EdTdtdFVBK21XMXVablkwWG1ZOFFySjE0dkFuWHJLMWp5?=
 =?utf-8?B?NVdrVHVGbVdvVXRFS01lMTg3MG5XdWc2VDVhVnl2MlFEZFlvSk1OdXkrK2pL?=
 =?utf-8?B?QUtSL3RhczNveHRLVGNqRzkzRDRwRTRHU1FXV1ZMUGRqZVBhcUtlSHdaZmRJ?=
 =?utf-8?B?b29NM1IrZEtEUTdFcThwUTFKejJOUWc3MXp2L1ZKTW51U0t2MUZjR1JlbkZ3?=
 =?utf-8?B?K2FvdzIyemJTd3AwcStGbjNEcjFscEpUK1lHMDR3V3F5V2t3YmNCMTJXOHVq?=
 =?utf-8?B?MnJZRXVsUXJ5azFXNEc5dlByQjdKZFBvYU5TRzZUdDN4anhJd2h1UmlUZkNT?=
 =?utf-8?B?QlFhT21BZXBJNDlQblZlL1huZTB6b0xPTjRrQ0xpVUk0dWhaMGwvUDR2L0lG?=
 =?utf-8?B?MnVoRWxPOTZxdEV5TFhHSVJwNG0zZGp1SjRjNFJpV2tBM2NWUndJZDZPZVdv?=
 =?utf-8?B?MlhYYkFQcFdPeHlqM1lCdktkbkJ2UDRNZVBjb1JuTThBTEdIRXl5TEJCOUF3?=
 =?utf-8?B?R25CR20yenpaNFpWeEk5RlhCU3o1YndwaTl1eERoTGo4VkdoSE5MRnJFVTZp?=
 =?utf-8?B?TWVWa1lHR2dTMjFWajFyOXQyUzVFeUFFY251VHppWVNLSE5tMDgybk5VTkFo?=
 =?utf-8?B?ZjN3SWJ2bmRUem93dmt5TVhHMnRvMlgxZitScUp2UnJCOFJ0ZU5HRUlsWkNT?=
 =?utf-8?B?UG85RVIxSkRUdUNBcVNlYVNVV2JheitzT0x3Y3l1dXpJSDlHQlRmeTlaYkNj?=
 =?utf-8?B?cmtoL3RrTzVzTVJ6a0Vtb1FMdXUxNU90TGlZVE1oTTlCczhVYWdWVmlqQVBu?=
 =?utf-8?B?czkrV1NoTkp3cnh0bWJScWdURVl0cWpQZURkZmFBZENYOW1qRWk2cmpKV2sw?=
 =?utf-8?B?TW5HWlZTTmVPQUpDeE96RzRvRGZqQU94bStGVUhneHRXMllBZHQ5cXUrbnpu?=
 =?utf-8?B?MUxJU1pnZDhxQncvK2ZSenl1VlUvNTFNTFFXampaR21LMlFJQW85RzlsMW9i?=
 =?utf-8?B?RlBKUVNWZ0kveWkvODFKMlVUdFo5UU4vZC83UFUxQnhSWURZZkJpZ1RSalk5?=
 =?utf-8?B?OThjcmlCYVhiY0pPY0g4NkhFYTF2MGhldWNKeEYzZ1lFaDdoYlkrcjNpTEl5?=
 =?utf-8?B?RUlReW5zOURyOTZCZlFmTC9TeE12MFRKRHVlREI3dXVtUzBqb2VRdjdXUU9l?=
 =?utf-8?B?c1YxOEdWVWRWaEQ4UDVTd1VLWTI1cXNHUWFYZHJSa3V4N1RwOVQ0U1o0TEcx?=
 =?utf-8?B?S2lyMmM3M2RPZk1YZFhhSW9RQ1RRanRjYlBnNG0vb01vRDMyM1pjcE1tM0hh?=
 =?utf-8?B?MlZGTVM3Snd2cHpGNXQwUnpUbkNoN1JoY3lZM3FHdHc1ZjlkcWlpSE1SOWUz?=
 =?utf-8?B?LzMycXF2NjFlak1WTmdLWFc4T1pxazVTdE5sZHloVmhydmRTNVJxTWd6T1Rz?=
 =?utf-8?B?d3pkUTFxRG5wM2t1RkduNHVaenFFM2FINUJrb3E0SkxnNmowS1E0ZGRwVWpp?=
 =?utf-8?B?TUhYVWY2djg4dmpMYmRWWW4yOXV1THFyYnpTR2dGb2RpWjlRTm01REQwYXFK?=
 =?utf-8?B?L2t3WmhRdG1aRXlVcW1EY0FhdXVrQ2VjWk43bTl2UVY5TTV1ZkFYQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18fb4546-36c1-47d8-356f-08da4dbaaed5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 04:02:22.0541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RvtPXC/ZAzFAXK/ujd3LuSANVZndu4xLK6Ca++xi8mcFqNgIi5XovY70VBZl07gQ50WHWDTubSXBGS1jJBKNoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4990
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/22 22:52, Perry Yuan wrote:
> In order to get the corrent highest perf for some new AMD processors,
> the amd_get_highest_perf() call will check the CPU model and
> return correct highest perf value.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   arch/x86/kernel/cpu/amd.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 0c0b09796ced..ff2075f26ef4 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -1152,7 +1152,8 @@ u32 amd_get_highest_perf(void)
>   	struct cpuinfo_x86 *c = &boot_cpu_data;
>   
>   	if (c->x86 == 0x17 && ((c->x86_model >= 0x30 && c->x86_model < 0x40) ||
> -			       (c->x86_model >= 0x70 && c->x86_model < 0x80)))
> +			       (c->x86_model >= 0x70 && c->x86_model < 0x80) ||
> +			       (c->x86_model >= 0xa0 && c->x86_model < 0xb0)))
>   		return 166;
>   
>   	if (c->x86 == 0x19 && ((c->x86_model >= 0x20 && c->x86_model < 0x30) ||

