Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE054B2833
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350229AbiBKOrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:47:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbiBKOrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:47:02 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0040B0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 06:47:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGg11wpdwB5o3Ma3+Y/ncQNN/JUnk8uSvf7slYDgokVYbzokDjmLMtFLElKrUZEOXLFS7E0tIbykzTDwthcZ6CFIv5ZrCx/z90E2MLR1DStk3jB7Mz7mSHaBjNXwEZ2DQTGF5f7Hsl2cwgNxiYtEpqQeEdfrU1rHt05hwlZtBfahyy0uIB1U3fT+fJaIWBGD6v5uvxolw+ruU7ugcpy300smfkZvA+UPsOjeScpwS5IBtkVAvnwKY9ql4qTt6a7DxqLTj2iVme/GVKmPObKHDOmSLckTk4L+xRe5xU8in4Spk7BRU78x48xxLdM80o9c2TLb94YJdxZ3hyCWrNxOQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfBkLSmp54bHN1knSdCPxBcMGPkcZjjeIZ1a9duFuqM=;
 b=K2ahmD4mc8b/unxiCT+4QoXi0wXPaY8adXuU8Ug/cgtJ2lRm01x9X/D6/1vtqOS4SY2feSZt905iWKjccNb8UdtWEeo23QjiUNQYF+rEPR3vO2Nmi7PzmFwoRDTMztvrgZfJgF0PYqjjlmDucbUP/SMrzNpKi+fGQOLcmbpVNcpTdsOkiu7H7uwIBJxVW0UZWzgV1M1JZM4lF4AGwOSFuY4FS0YY7v+ZxyAury+vY4neyJo/g8MDhV04eOMtSD/SE6BqXGg9+G0UJ/2zeECuDxcNC8/ZfXkSw1Kq59iPvQKIQt2y42JT2aQoqBW9KpIJFAZlstWqMQJx3K3AphRwKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfBkLSmp54bHN1knSdCPxBcMGPkcZjjeIZ1a9duFuqM=;
 b=FE/Uwwlh4r5CDtIvEoKG5Br5aW3/7N+3cOJJVUln2IAY2Q/Hkhwnx72aqqRfciBY2zX0Un6/YVfmCmWU/stTHvt4pBGOIO4TPZ/tyVJr5i20QtUCHK4ifCYkda0M+rls5ZUY2s9iDeamAEYehUil/6ci3pXgBRJg7w773OtENic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BN6PR12MB1393.namprd12.prod.outlook.com (2603:10b6:404:18::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 14:46:59 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ccd7:e520:c726:d0b]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ccd7:e520:c726:d0b%7]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 14:46:58 +0000
Message-ID: <4035f596-651c-c167-372b-ffb8ce1a0ac7@amd.com>
Date:   Fri, 11 Feb 2022 08:46:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, hughsient@gmail.com,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>
References: <20220211053652.64655-1-mario.limonciello@amd.com>
 <20220211053652.64655-2-mario.limonciello@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 2/2] x86/cpu: clear SME/SEV/SEV_ES features when not in
 use
In-Reply-To: <20220211053652.64655-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:806:20::18) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0722fd90-a3b7-4702-0b28-08d9ed6d5b00
X-MS-TrafficTypeDiagnostic: BN6PR12MB1393:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB13934A524510336CD11A74D3EC309@BN6PR12MB1393.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w5GSp80YK1up/Pdlys0NJ0Q1tEvHbFm6RTyix1Mm5PsC8N3YNWJeOne+NoaD5eXGTjbORRsea4hedSJdgZJLtm8xO926Ep8t/dfW3ooDDX62iYxD/y5+M+2xW/+mGqFbP7e2Ada0GXOh/vzzb/VfS6Ts95yNmxQJGawVYvHTPvRtNPjanRAMwH9H22GOocPaYUpTbuAWWR4gQxjMZm+7bsHVxLlBTPhhEt5EyDWlw2eaamu0NKiVRP8TxRIKO9kYECi98uGzpBG+ixqjKEmkhWefvK37MK/7vGDGJzRJQQAAUkzlsCkoko+/SXd4F0BjHONliw+yFzTJ6M1ROGtSo7CobMNm/h8F/M+fQ0k6NDBb12DUPmypJdZmhsEfMj/c9WltiPE6kNosQR4staY21TV4R7P/hL+XRdZoi9H3YwAj+EwOa8W1rLgJdBIDKgkg0uvv5fCC5L7GroSPhU7WYGd/CJi4lH/uDk0a8qOXN+VP3UCw4QsqcmwDRLpWoNLGOrDZfJrO5f06aVNahBZwY5zUz3R7RO2t7882L9UE+tQaxyGMWpa3knGrjau7mX/MGRpUsc1CVqczaSI/DQpJcXtNKNJ65Tv3+Tz2X+hnQqWTbPF55+roBEBDRWDNuewhxgkOpf+hLatbV0J48BzTEWm6a11iaVxaWWLTbx+kbo1XhYME59ik1Ghdye+KWwqMIFuyPKrc+HiqSjDL1RWa9oZ2xFQMYqTBFrgdMXBx1lw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(38100700002)(31696002)(8936002)(5660300002)(31686004)(316002)(54906003)(110136005)(508600001)(6486002)(4326008)(66476007)(66556008)(8676002)(6512007)(36756003)(186003)(26005)(66946007)(83380400001)(6506007)(2616005)(53546011)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmFNTmE0dEFUZ2pJWTg3dDMvc05weWFNZ0hhWUFmQVdqZUc1Tmw2WmdObG1X?=
 =?utf-8?B?TFBoUkpFMXF6dWkra2NHbnM2TXdBUmtCREpRUlRQNVRLcytIYXkwNkZrcHZz?=
 =?utf-8?B?ajZpZWo2Z2xjQTFTTUM5eXI0djFSNmxjMEMrWXZ5Y2QyMS82eUxKRW9yc0cx?=
 =?utf-8?B?T0Z2dCsybkpYclR2MWRjeGdNc0JSTWVvaFpZZUUyaWNzaHptWkVsQU5Jbmk5?=
 =?utf-8?B?UlpkcnBMbHdaWTFUYzZvWE52VVdSaWlrSGxCY3ZDdnl1VFQxdzVLWE1JWHl1?=
 =?utf-8?B?VjFsalJoT00zVnVJM3Z3Vlp6QWc2YmlHTGJIbjJvTWZtakVaYWRPM0lVcC85?=
 =?utf-8?B?Umh5SFZ2V0NueEdIRHI2aTZhbzhRS1RhZnRWUXZQeFVWWm9UTkk2TUgvc2x3?=
 =?utf-8?B?QWN5V2s5SWdYYklKRHYrbGVQR3VseXhybDJ6MmN2YmZMeEgxZEdISDZmdXJB?=
 =?utf-8?B?ZUM5b0dTcEs5WHFKQlFrREpMZFNDR3g4VFA4cm9ITDdwRFZjUzRmcDFsbStn?=
 =?utf-8?B?WUQ5a0xpQTZ4Uk51Q2VPemlSUzI5NDZVOGw2aUQ1cEc5UGU3WUpBOUlqZ0JZ?=
 =?utf-8?B?ODh1UVduSE5GNkpkaGlVQjgydEdJeXZJZ2R2TWxUdE0zMzIyR1MyQ2hNblhz?=
 =?utf-8?B?MmszaHNPczNGcWttQkE3aGlpR0RnbDJGVWVjdEREb0pTcHRRK1VXdGRSdk9O?=
 =?utf-8?B?T2ZJYzFMaGpmTUQyQklQdXI0Q3gyeWxOMzhUQ0ExVnpmNVM5U21OQXFUTG5M?=
 =?utf-8?B?WnNzSmNEZ3ViQ3Baa1RVcmxoV1E5b2o0blFjWTNQYzdpVk9BczdDWnpxRlB4?=
 =?utf-8?B?OFN5dkl3alg2U25lZWxNZmdkMGQwd3E2Y1d4MHgwcnVqUjhKbGpoSGFQU3NF?=
 =?utf-8?B?cjJ0cmdqWmVaN290TUozYklqcmZMaTBVYVk1aGgwY3VnRWN0L3p1SlhkWmsy?=
 =?utf-8?B?MjBjWjk0VFZQQnJDOVBhOFRKVTdQNllVZzBDNjhwbVh3emZoRFh1Zm55VzNZ?=
 =?utf-8?B?eVY3WEZyVzB2RHBTZWhCRm1YL0IrYkFvYXlSc05hUmlsR1ZtTkZ5N2dXN0Jl?=
 =?utf-8?B?cnZsd1RkY3h5VitWOGE0UzdWOUtDNHlldHAyeDBCaUoxS0tjcUlBcFR5Vmtu?=
 =?utf-8?B?LzlqbFhZT1JKVktmcWFibzVLWWFGUDQ1RytLbnJ4VHRqTW5LRUpYeVQ3UDhx?=
 =?utf-8?B?cHFLTU16MFBrTkwwNU1XdVdOcE5veWxIMjdRM2Z2WndDZEVldzdPQWtOc3Vh?=
 =?utf-8?B?WEoxOHhmdy9PK3VsQWxOUFBDL0NwRGdsTmZHZVBwc2s3SFdSM0ZSRGNsaUl5?=
 =?utf-8?B?U29WMVpOdmh5VHp5THc3Z3kwUUZHUitEWHJDODRZbmNoR2Qwc0NteC9LZVlq?=
 =?utf-8?B?VnZUc2ZML2JLL203TzAxQ2RUZ2Nodk1CMVFCY1M2SmNYOFFKRzNabzRKTE0r?=
 =?utf-8?B?bnVmUGxnK21mNy9OaVltNkZZdG1CQU04ZmxaOW1hK3V4dng2bWZqOG1rd0U4?=
 =?utf-8?B?RVRmWDZTNDViVEpuME1wWW5ySllYeEdCKzZOa3NJRWdCWWVqWERnTUdLOU8v?=
 =?utf-8?B?U2E5MUNvc2ttUGpwUlNJVStlSWhNNkZRVVRyb01lY0JDbURReVlnQTh2cklQ?=
 =?utf-8?B?bEUrL2QrdktRaG5GRjNubGYxdjdhNVBZYVRzcGNiQnZlOVpIMEZRdUhINGNs?=
 =?utf-8?B?aFdnSVpCNXJmWm1KQ2JldGVrVTdIdjJRRFVORjhyZ1l0U01YeXhLemZTSE9K?=
 =?utf-8?B?MW5nNUtZOEdzZ2RndGplMmhGbkVLM2dQWGlTNmltRnhpZWJUSTYrdWRWSEtU?=
 =?utf-8?B?VldONnNDeEdyQW1IcVNMZkFURmxWTWF6TmZkN21QbmFmVEZ1LzVqdTUrOVNU?=
 =?utf-8?B?bmlHY3FpM3UrK0xLVVE0aWFtMmVWSEJJWGkxWlVIUEtEQWQvblp0aWlIRDVv?=
 =?utf-8?B?SVJMUjF0YkZVUTFOWmNZT2JHSytSYTlwbzhFenY4NyswKzN0OGN6RTR5d3JI?=
 =?utf-8?B?QzdsVmxDUEV0U2JoU2kyMnQ1YkowREppSzlpK1JnOTdURnRqd2p2d0FtbVJi?=
 =?utf-8?B?M1BNNVBCMDBSdVhHbWhPWnB2Tk5mc3dGbTlrM2xNMWFHWWxZL0FZTlN1WVcr?=
 =?utf-8?B?U0Y2Qm5OSWlmbmdjUlYvdDdMRmxKdEN2aWV0dmhzZ0JrNUUydkhja0d0bGxD?=
 =?utf-8?Q?m1e2PyrXa0osWwSNsVrC0nU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0722fd90-a3b7-4702-0b28-08d9ed6d5b00
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 14:46:58.6083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wbhiCGp+8dI1nJGqh1iA4Vgd6VJUuG6TwrCr0SPGtNcKw5fHACS7CxlSipYhz5GGvBrxIr6R7TAe4mMQjRXF4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1393
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Brijesh (please copy him, too, on all SEV related things)

On 2/10/22 23:36, Mario Limonciello wrote:
> Currently SME/SEV/SEV_ES features are reflective of whether the CPU
> supports the features but not whether they have been activated by the
> kernel.
> 
> Change this around to clear the features if the kernel is not using
> them so userspace can determine if they are available and in use
> from `/proc/cpuinfo`.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   arch/x86/kernel/cpu/amd.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 4edb6f0f628c..4a7d4801fa0b 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -611,12 +611,20 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
>   		if (!(msr & MSR_K7_HWCR_SMMLOCK))
>   			goto clear_sev;
>   
> +		if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> +			goto clear_all;
> +		if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> +			goto clear_sev;
> +		if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
> +			goto clear_sev_es;
> +

A host/hypervisor will never see GUEST related attributes return true, you 
need to verify all uses of X86_FEATURE_SEV* in the kernel. I see two files 
where this change will break SEV hypervisor support:

- arch/x86/kvm/svm/sev.c / sev_hardware_setup()
- drivers/crypto/ccp/sev-dev.c / sev_dev_init()

I imagine that some of this has to be re-thought a bit. The current SEV 
and SEV-ES feature attributes are intended for hypervsior side usage.  For 
example, MSR MSR_K7_HWCR_SMMLOCK, which is likely never going to be 
provided to a guest, needs to be checked to be certain that an SEV guest 
can be launched, even though SEV is advertised in CPUID.

Once in the guest, it is the cc_platform_has() support that determines 
feature support and not X86_FEATURE_SEV*

Thanks,
Tom

>   		return;
>   
>   clear_all:
>   		setup_clear_cpu_cap(X86_FEATURE_SME);
>   clear_sev:
>   		setup_clear_cpu_cap(X86_FEATURE_SEV);
> +clear_sev_es:
>   		setup_clear_cpu_cap(X86_FEATURE_SEV_ES);
>   	}
>   }
