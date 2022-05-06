Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F5251D697
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 13:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391296AbiEFL1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 07:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239272AbiEFL1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 07:27:42 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFA85469C
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 04:23:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9qcu5Ier7zBSBCr9RpND5OuuXBU6kWk5XHqsgG0kFQmVYMxh9bQHihYoWMpbrLSPsDuO0/x8VAS2gMTpQi36W7/FvcF/LEQZpya8Fg6vA8mOoZfpq/+1GE/GqqNOwrH3P81ddskbNtM80606dYAb+ryaTL3OoaNfAKgsHzdXxe2m3CDn3rhBdvdKxyHtjyxj8yPKviOozfQtB60bg3Zmt4P2/2x+d3YBPkDQZ5fhcb9vIChy8sQJ+v3BbweLeFqxtVTx/Qpql8JF24qvX3+Nara8/dIJLdNZ5wWotU/BsXWgNk6xnc9YwaOnfPwx3FbwwjxdulBGde1KsYyjZ7HHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbFdMfPVbmJcDzUM4cmux31W6nEtGqgj0rSjriU1OGM=;
 b=C/kxEKsAiEt1zmPAt8rfxmJWe8RVbKQ2wYjBEm12EIUilaxhz8OZtNRNmRTVYADV8u0WEuczeH+80PmOeDjSZVw3WTRmHh6cNNSKoZUYF6ggArZGh8tNEMa/BxdPfCvF380jl1il5keakbs6+6GGpIAmekYw7XmTbwiRXSoED1cclrrGpvAusndloNLLL3T1JEU53/XFJEUmqbJ1L1Qp01G09AiUVH4gayT1krEd7rkVUOv+43KRvLv4PBN4K26oo3YbkuaA3CXZLF1eQYvXedOIXhGz/XCIbtModx4j/KuGYQq6xN0B/S5xQKkWmqCD0O9yMM95+A3Cbdp2R7GKcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbFdMfPVbmJcDzUM4cmux31W6nEtGqgj0rSjriU1OGM=;
 b=hEwJ8s1dc8za+TTXf6vlqyBd6yj/WPJigQ+Jeow2HKjFM/kDWmtNAes7an9LCSqhbbDrW+N8+qVDDWTdT2RnZROhY7Apizlg6TIRB9F50c5Bp8a4y209/8UQQQajZ827z/lz3qBeW19bsxgUM5Bh8s2wlCITZc/J3rVF+uluusA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3368.namprd12.prod.outlook.com (2603:10b6:a03:dc::20)
 by DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Fri, 6 May
 2022 11:23:54 +0000
Received: from BYAPR12MB3368.namprd12.prod.outlook.com
 ([fe80::1c22:8110:ebf0:f38d]) by BYAPR12MB3368.namprd12.prod.outlook.com
 ([fe80::1c22:8110:ebf0:f38d%7]) with mapi id 15.20.5186.028; Fri, 6 May 2022
 11:23:54 +0000
Message-ID: <965cacad-474e-aa72-d5a7-fda8f2dc20bc@amd.com>
Date:   Fri, 6 May 2022 16:53:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/3] x86: Use HALT in default_idle when idle=nomwait
 cmdline arg is passed
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org
Cc:     Lewis.Carroll@amd.com, Mario.Limonciello@amd.com,
        gautham.shenoy@amd.com, Ananth.Narayan@amd.com, bharata@amd.com,
        len.brown@intel.com, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org, chang.seok.bae@intel.com,
        keescook@chromium.org, metze@samba.org, zhengqi.arch@bytedance.com,
        mark.rutland@arm.com, puwen@hygon.cn, rafael.j.wysocki@intel.com,
        andrew.cooper3@citrix.com, jing2.liu@intel.com,
        jmattson@google.com, pawan.kumar.gupta@linux.intel.com
References: <20220505104856.452311-1-wyes.karny@amd.com>
 <20220505104856.452311-2-wyes.karny@amd.com>
 <12ce24d3-9b46-5c2e-c5c7-c690cb3ca81a@intel.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <12ce24d3-9b46-5c2e-c5c7-c690cb3ca81a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::9) To BYAPR12MB3368.namprd12.prod.outlook.com
 (2603:10b6:a03:dc::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c64ecaf4-9dea-4fa1-15a7-08da2f52e74a
X-MS-TrafficTypeDiagnostic: DM4PR12MB6374:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB6374612279F99D32BE802A6384C59@DM4PR12MB6374.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KA+XN/MsdDYcEarVsV5oDnGVSBsPVmgJr5JGwZHoLpIBmJrFIiHXCxujEWQZq1uLMnmObLv62GbJw+cMq/2iBL+xtTvsSwQ7ahAGK4pVvIuwEPD3XBVVJ537mVVEx81zvp6NN18ZDNv6TMx/11augNVzNvqhSd+TF/AMlXdY2vz5egfR2+r9FmTKJ14VY7Xq/MX+Kqwg3ieAUSqBPkJ5I1TBuPr1dOcvEtvcUcCDRX42KHQFL4RRoCYDPLKEDziVGxDMXtiEl8Zp/H/sHEgIvVhkgAJvY9BSxvjKJGDfoZnCIlELZX+a9ElAkm6qXXO7c/RchV5GEr69fOKPEf7uK+D2CHAhmHo3paWmKujQoH1SxmQgPw2LLyxvYZbsZ7g+w49DTUZEYQHjrf2yvgrZWyDrR/A7JLMikrJMi3OHvGBwJLlgreptOSp77uXkryq981p1jOFzsVGXk1cfKpypakkRKWsJj+fL+eynl6UL1UE3BGnjlpSAXn/KB7NDSkc/iDOJu5xTpEuAS8VIr2iKpy1KcRkuROLz2plNYiY3m3UnLZhDMqQRcj96Ov/ZE/hOS7V3PWQi+I58XOXRvayNEHJqLfAsESBomqbUJ3Syv5wcs/6IpUDlmVGPGz1StQ4Q0b2NRRf2SECFlSpI6A8gSkq7xqegpTcEbwq7uUWRxGPL3VCH9kYZ+usU1/cXtuHmypPpFahWG0/DN3duntnDzHvvq5XQJI8hcw/A8OeRSHg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3368.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(6506007)(53546011)(2616005)(36756003)(26005)(6512007)(6666004)(86362001)(31696002)(38100700002)(6486002)(8936002)(4744005)(44832011)(508600001)(7416002)(5660300002)(316002)(66946007)(66556008)(2906002)(66476007)(4326008)(8676002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1RRNE5ORXd5SGNKQ0xQeEZpeHhOZmtEamo5NnV2VGlPc1JaMVRSem1VMG1B?=
 =?utf-8?B?RzVrUFJvUDNxNUFYcEFXa3lxa0hhdU9ibEplY282T0MxVjBDbHBnZG9IWGVl?=
 =?utf-8?B?ZjQ3Y0RVRVBIWFNsV241SDJvckJicUZOYzd6RnIwWnpzdlEwZmVSR2hYMU9x?=
 =?utf-8?B?M1VXSmc2MzVHTXRjZHNvU2FhSXRSMHQ4ZGJwYVZ1aGh2RjFwVlJhQ004Q2xp?=
 =?utf-8?B?NmxpU2N0Um5QOXZaa0JYU1o3TGlLS3FSL2NRTnR2SWNzUjRjVnhWUjB3WmlD?=
 =?utf-8?B?TW4yV3JGU3UwN0RSTkY3TGxHUnlCT0R6eG1Sa21hMFBqcmtoVWVGcjI4eFJw?=
 =?utf-8?B?cFhqdkk0aEFaa3hpOFB0SmdWd1hvcy9BUUZEMS9tOXI5NFdKK1hqM056MFNQ?=
 =?utf-8?B?dWRLWDl3UVRrZ3ZZbE9yNmFuc2ROV2JXVUN6KzI2aDI4aFNnUHh6Mi9xeXIy?=
 =?utf-8?B?ak5TSE9oUERsbzVxUEJDdkNVWXcxeXY3cXlRWEpZRVRZOUw4TER3Z0FGYmZv?=
 =?utf-8?B?RXFRekdEcHBVV1BoWkh3QjJ4Rm9PeXRNcmJnbnFFNEx4WTE5a214WW92VHhM?=
 =?utf-8?B?RkRXVTlTWm0vTUtPT2ZoS2dNMDYwTUg5bDFVQldRbHRLb01WZ1FDUHFpeUVo?=
 =?utf-8?B?SHJ6NkFZMCt4RXJqdzNFaVpLWkw1eURESjZJN2VEbTlRVHJKVVZWdUEvZWNw?=
 =?utf-8?B?NjR2eXNwV1NjUzU2NXZ6OXJLUisvU3BZMjJrZHdraHhaZlQ0VEt0OVBoaVd4?=
 =?utf-8?B?TWN2b2hENXRmamFvbzJsbmJ3TjJlZ3JnSXkyc0ZFTHE5SWtBdXhBMi9EaHhs?=
 =?utf-8?B?RHl2d0xaemVpTTZPSC9udjRoZG1mSjRIVlZtcU9YNFNZeXlHZFhOZ3NtNjN4?=
 =?utf-8?B?cW1oRUZkSGdqUHpDMDVJS3NGeFFxb1dFcnp0SFU0QXRRZ3NqQU9mOWl6aEww?=
 =?utf-8?B?T0oybE9JMGI5LzArM1ZKNS83WFYydlhJZ2JCaEE1SE5kb3pzeWZPS2h5V2lU?=
 =?utf-8?B?SnJ1VUVjanQwZmRrTE5sSE81aGM3MnI1cFBrU21GYjhCVUFQTFRya2RCU2Yx?=
 =?utf-8?B?VllMME02OVdQTVM0b3F0S0JEVFdZR01sSWYyUHpNWFVDZ1BJZ0I4WFNWK0da?=
 =?utf-8?B?OWNLWFVEOXFTQnR5bjFPbVJTcWc4ZitMSjdYRVZFQ1lKdXZXYUcvV2pPUGU4?=
 =?utf-8?B?U0c2dmNRdFAyUlhQNG1vZlU2UXhQYmRSeVU0K2hFWDNVQzFTV21VbUpqWXRy?=
 =?utf-8?B?NXRVWlQ4Wk9WRmgvUit4L0RPSGpPQWZMNHdLZStEMDV0SnVwdVdvYlR3NHV0?=
 =?utf-8?B?QXVKTlZMK1E4UHZMcHlydGEzaVpsTllqVFRKTHF2aE1WMklDMVpIQ1pkZkFN?=
 =?utf-8?B?MWhjVGNOS0taMzA5KzdSaStvRUliY0VTUTBUNnlXU1NtWVhCWStNd0NuWjY5?=
 =?utf-8?B?dVNSY1dzNmJMTm9FdEx3NXRmenAzYlVST2lzcHI0RmNleHU0Z3BDWDNhOVNY?=
 =?utf-8?B?RGRKWXdtc2VwbVA5TTlPU0lrMU5zTkhzV0NLazREeDh1L3F4a2wzMG5pMm9L?=
 =?utf-8?B?VU14a0dYZjlqQStSakg3V1RVV0RoVlhHb0o1eXNHOTUrSWpndkdvdHJIZC9Z?=
 =?utf-8?B?LzR5REI0N1JRQlNrdXRDUVE1dmVySWZSeDNwSUVLMVFIUVNrNE91Vk94SFZp?=
 =?utf-8?B?bllpRjNhdHgrc2hzbk4xdi9BVmoyY0JkS1VNbEJWei91aVBJWit2SGltb0dX?=
 =?utf-8?B?VENPVFNtbVZYaHFHR24wRnMwMVBYQTNTOTJ0VW1WemluMjRpYVNTNzN6NnpY?=
 =?utf-8?B?VEdkMHRBVFR2eGQrbWZHUVFsaDFWSmNTZVl5bEh1WEJxUnlMeVNacmdkc2hj?=
 =?utf-8?B?eXF4VmVlVldQZUl5VmhiNmNGU0VDbUxFTk1JYWpvVHlKakhUVjRHMWlWdVFH?=
 =?utf-8?B?L3UwbGF0TW1SQzk1SjRkZnlTZVdNY3hsckFMMDRoL21xdytnd3hBb1RFM2pm?=
 =?utf-8?B?ZmVEUmdvZE82emJFM040QktOSmcrNkJ1UkNkZzEyUTBkV1FNTWRvRmtiaU85?=
 =?utf-8?B?a2x0NnlvVEFlSFBiS2Q1RlRZSkUwSTFEdExua0poUlozaUVVK3FRYXN5VGp0?=
 =?utf-8?B?cTNhblZTaDN1bi9xdTMrcTJXeXF1dExrZU5LSHFtSzVOaFBLK2NNR0p6RWUy?=
 =?utf-8?B?RnNPU2Z1clNFZnZVK2xUelRBWTg2Y21JU1hHYmZIdlNOTW5mWmMvMGdoNlZS?=
 =?utf-8?B?THdlcG1NYmFmMzZFZlUveHRGcEdXSW1OV0lrNXJSYmptd1M3bjRoRzk0TDZq?=
 =?utf-8?B?TmtxL1BOcVdlWHpBQlJMZ2dEU3B0dHdQMnpUc2Z6WkNBbUtpL1ZQdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c64ecaf4-9dea-4fa1-15a7-08da2f52e74a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 11:23:54.5405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GDMMjq1T9iJNp5U3jvrrwcPxyXmd39ZkazUvD2qUQXZY3WhNiCN0voWkbOuiWPUKHrG1fTlGZ6/bWq6ALKaj+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6374
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/2022 10:43 PM, Dave Hansen wrote:
> On 5/5/22 03:48, Wyes Karny wrote:
>> When kernel is booted with idle=nomwait avoid selecting MWAIT
>> as the  default idle state.
>>
>> If the user boots the kernel with idle=nomwait, it is a clear
>> indication that they do not prefer the use of mwait as the default
>> idle state.  However, the current code does not take this into
>> consideration while selecting the default idle state on x86.
>>
>> This patch fixes it by checking for the idle=nomwait boot option in
>> prefer_mwait_c1_over_halt().
> 
> There are a couple of places in the existing documentation that talk
> about idle=nomwait.  Could you please fix those up to make it clear that
> the option is no longer specific to intel_idle?  We don't need a rewrite
> or anything, just some small tweaks in the language.

Sure, will do. Thanks!
