Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4083F4F22C9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 07:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiDEGAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 02:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiDEGAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 02:00:32 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A101C3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 22:58:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ga7We1HDe5t9mlEtukvKV/A9lOxud03BHBEztE9Lo37L5El7ZrK7PKOzAKBs4zBTGNzEP5eGm0MCZGFhFPCjP+7Ii8+66YfnuMOiWfUBhS89RJ0xP0YLrckUFpgPznDPcit18+xzMlsCuaOC1FMC5HhKfoxz6GksNSwRdyK6kGH6nDFonEf7IomKJ/3W7XhJO6aUVoXWiEQ26XFF/VWw0aOFk9Mzmxgr8qGAWetlHpycluSAoM9pR6mk1/JJ1x807BMpphHwqJeAdMgTf5+iTEFh2TbsaczYWYjgV8byVJoQ+gSyDH9T22JJoaPX6R9gSwXLQtbLSDNG3wy/GNpyzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3M0xgwCtrWgavRprcm3PPdF/CrDJUqIwRxbCAZ4RZ8s=;
 b=cjNzDY0ugz/KNiuJ+oCtyZYsMEtZY4EeiZpMHOwGgkpCW2Ma22i+LAeibtQmu7t2vfws+BViF8KalI+KpZVHIQ0aUgoly7e8hp+loxhmpli85pOts8Zw25GRLnHW4Hv8rvISl1SHPZvHyGstce7EL7R+7HmYC2CTs46HbeaW6tPrxXPAhvoJbgW/a2vXuklfGraknMF8bUsiD07in0W5OQyV3pm+uPnPTtNETZBJcsWky/1d87xaxdR41suE7Mx0qFJ2Bb6kt5Ie4JdUj93657K4ZQ8D5rM1JFNy6lwbttceHEPZNDJsmKCGesIs0ipZdvuaN2yQsYb2HrX+UDQAyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3M0xgwCtrWgavRprcm3PPdF/CrDJUqIwRxbCAZ4RZ8s=;
 b=ueWrPIdsiMwdSV7p68itSb7en/k38Oqg273rU6I44xyTGfetyc2wwbIOnhHz8Lo/1IxmevKBVuLgNG7AQgbuktsAaOPdX1DRNBOlQgh+YIelNy1OovFCViqxhWg9jxr8Fp6JdZd1SezJLUiNRp2F4uJv6wLXNx5v4YjDPYmnpps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14)
 by BN6PR12MB1921.namprd12.prod.outlook.com (2603:10b6:404:fe::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 05:58:31 +0000
Received: from BY5PR12MB4289.namprd12.prod.outlook.com
 ([fe80::4843:222b:2955:543f]) by BY5PR12MB4289.namprd12.prod.outlook.com
 ([fe80::4843:222b:2955:543f%7]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 05:58:31 +0000
Message-ID: <c4176dc5-af4d-243d-fce9-d7f45e79246a@amd.com>
Date:   Tue, 5 Apr 2022 11:28:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v0 0/6] x86/AMD: Userspace address tagging
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linux-mm@kvack.org, the arch/x86 maintainers <x86@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, shuah@kernel.org,
        Oleg Nesterov <oleg@redhat.com>, ananth.narayan@amd.com
References: <20220310111545.10852-1-bharata@amd.com>
 <6a5076ad-405e-4e5e-af55-fe2a6b01467d@www.fastmail.com>
 <b0861376-e628-06bd-713e-8837e0dc9d0b@amd.com>
 <db4e00d5-0cec-d50a-7dae-2ca9808bc187@intel.com>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <db4e00d5-0cec-d50a-7dae-2ca9808bc187@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0108.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::23) To BY5PR12MB4289.namprd12.prod.outlook.com
 (2603:10b6:a03:204::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc1177c0-1c11-4c8d-7ea0-08da16c94fd4
X-MS-TrafficTypeDiagnostic: BN6PR12MB1921:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1921B95862C29D266498AC15B0E49@BN6PR12MB1921.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: utDgz5RZJycF47Zyw2DBX8pn6Xe++nCgyHOUwTkz2MvIX260Qg4uquCalxzWqAJXML1joUxLJelG+9AW8CDcCioeYki3G4WKEd9qp31vPhBvrkDEdxwLcfcGfOHOkoqSpiBC/TC532FnRAWhSxvYsm9DO7jticl7QviNPQ0VO1MQeXdOzGOdYv3qnb0xRdnTzXXYef23EZG46V2wz1DYkxvRfIURMAFzqEzDm2460L5Sg8mmSjaycNH0lhfNRlXAk8LU1DvyynDYUjjFJJ/lP/T6jq6QXCc1Cp0bSGuY9y0NFPpql5CoMfJ341+YZidJqX+AZVE7KuKIhWnAdNBOCS2KlvZTPPLVfUuxPkA0pqL6E9hNgpb2dp7/jjv5jNrmXEkZEdmJqXs6VnV5jAHlw7TE9b8P4zjlAhk/Zm3dbg2AklpQ2AQdzXe7vOvRBdh8UaCIBxyUNGCwj+C9tJcj0GObcqmcj6O7bn8F5yWsJKUdUjQ8KrPP83m0oseSs2bkICb7hgzbDibONH/onYEMPevzQiIokXPmXFoBmVjl9n2IKzpwhvZx0M2P0PYtPIi+kudQ6VmxF2mpkIkViFzYB2jAVQFQLj/r6Zwa6iEKVCPIBU3NNmVh/OKKSdbF1eorEVEJ9EQHe39k9kcAOW6p5SxR/Q/y0POawpWM56bEjJPAbperTilcnk/oPgBS8WgDDqF/1nCQ6k1bBvHcKJCY7fkZ5CTkhjUIfCnfDukSb9k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4289.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(6666004)(508600001)(6506007)(26005)(186003)(2616005)(31686004)(53546011)(36756003)(6512007)(6486002)(316002)(5660300002)(8676002)(31696002)(8936002)(110136005)(66556008)(66946007)(54906003)(4326008)(66476007)(86362001)(83380400001)(7416002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MStUSDdIaHExRjJ2SGxocGt0WkVGdk96K0tFemNJSjFtd1ZneE1VWDZIbEhD?=
 =?utf-8?B?Sy9LTmIwWmFEVS82SkVlUGc4UUk2Z3BNWnp6M2xZNW5jMXJFTjRmaGtOSGlh?=
 =?utf-8?B?Z3d0SUFTMVBuRTRQazg5aGZLN3NwSFhPSFVhd1Q5Wm4vb2JDaG5HVlVZRzR4?=
 =?utf-8?B?M3RoSC94dEtTWmVxK1MxVHQwRWQ1RnJNVHJsUk9pZ3ZSbTVmS2RxUVNSUW9L?=
 =?utf-8?B?Y3ppUENzY21MaFJnL1Y3b25LK3RTMHNtUWVxVmlsdUlaU0pMUDd4UDRHems0?=
 =?utf-8?B?WU1tTHZjbWI2czNKS1IzSE0zQ2RKTllJR0MveXVrQmtGejZBdkZoaXd1Ry9F?=
 =?utf-8?B?S2w2aXR6SllXNmNHYUtMRU5MRnRCMzN6bHpFVmNOUzJmNWdWZFBiZCtBV0ps?=
 =?utf-8?B?VFMrbjVQOGFTeDg5bEp1R2N3V3FaLzVpT1NidjBkMGJLcXZ6Njh6elRyRXp4?=
 =?utf-8?B?RCt0cy91elNnT3JJV1JKL2JBblJoV3dIbnVnVnFLODJiZTlHYVMyakZIRTRN?=
 =?utf-8?B?VEFqT0R2RXl1MWJMMFRiYlFBUTNmRjB1dU1HQzJJVjduZlZmaURad3JNTkFI?=
 =?utf-8?B?c2UxbnhtODlVeVM1eG1mbGdXR2g0NWt3eGNza2hPTzJVdTJQcWMwMFdISmlp?=
 =?utf-8?B?clh0cWpIQk8rUmk0NXNrQzh5Z21RMzhJblZQOE1TdU84aDJKSDY2MHUxcmN0?=
 =?utf-8?B?TmZCV1ltUHRuNlpSRWpEYU15UWZYRzFRYzg1Y2dYTmV2Q3dBZmo1eG1ZT05r?=
 =?utf-8?B?bFYvRXViY05mREd2S3BxOGxzWE1SQ3F3S1NEU1loaW45RFA4NHVpYkpuRXRt?=
 =?utf-8?B?MXFRUlBLT3dwTUZNNDhsdkZEY0dUY051elQyMVJWU3NFd2d0V2JWd0o5R2p3?=
 =?utf-8?B?QlBVUy83NHk0SzFRM0JZNVZ4QXowN1RtL1kwbnVuQ3VPNkx5cVdXVGZSamZL?=
 =?utf-8?B?K1pib2gwVnpyU3plREVsVHpMeEZ1MnphVExhUzJsTDlaMWNqbnBSZDdYa1Qz?=
 =?utf-8?B?Mk9OMkQrN3JQYW93a1pvYXhwcFZpNTlmT1p2eHlVemJ2bG5tSnhSSWRuY0NU?=
 =?utf-8?B?eVd6TTg1b3hOVVFRdkpkb09NWmZSajBKVlhVZVVaUVFtN25FbDJabStPTWdN?=
 =?utf-8?B?bkM3WWtJMlE5RkpSMUZHeTZCNFYwMll5blZ2czRqRnIrSmdlR3VsZ1NmU1Ni?=
 =?utf-8?B?NGRkRWVHRjdyL0dUMDZJOTNMVU14bFAxRkJiNUVWSnJjOGxvdjlaMU9Fcm5m?=
 =?utf-8?B?aWNqQUFIQ1BHZFh1R0UvdW0vOG8xZEo5MmVJOXQrckN1MGxpVjlqOFVvQ2RU?=
 =?utf-8?B?b0lFRnJ5VFFUTWxMdXpDdGl3bndCTXFFT0dVT21OdGNNQTh4aVAwd25pSWNL?=
 =?utf-8?B?cmJ3K1cyTTJTcEhOTk9tNklSMWpLQlZWZWoyNk1GbmtiaCtXL3VKNGxFMTha?=
 =?utf-8?B?d1ZNSUlHNjZLeTJ1VC9Sdk00YkpoSlhHQkdFRk1FYmVsN1dwbzdiYmVIdHdW?=
 =?utf-8?B?ZUt1M29uN2VFOWV1UXQyNVI2YlFQTk8zdm5PUTMvZ0lIaG8rUFg2clBDcUM3?=
 =?utf-8?B?UlU0UzRFWG45U1pqWXpVVXlrenY0VnpNQ2FJOVJtb3JnWEl2YW5zWDR4NXpT?=
 =?utf-8?B?YUhlOHkreHBwTXpscllCN2FUWThSUGl3VS85SUhHeUY4bE1kMTFxaUM3MUpS?=
 =?utf-8?B?eVdCS2xSUWlMSGlYakl2ZTdUWUpMazhsek9hM3JPRnJqRlBiQnR3MUhqUGhM?=
 =?utf-8?B?YnBna20vbVh6T0NWVmZTb3Qva1ErUU92MnI1RElVa3gxUllUcmFXL0JLblFM?=
 =?utf-8?B?QW8zYkVodS9QUFhtNlZBNFN4aVFKSVIxZEhNcWhKb1p3NmhXdG16L09DTEUx?=
 =?utf-8?B?cUF3R0JJVGs2VURyOFdwREFVQWJRazFxL0Q3dzIzKzBRZjlYZm4wWUtoNjNn?=
 =?utf-8?B?UkNKY0twTG85ekhFVHp5aDIwYUczMEhRK3QrVHBIM2kvd1BXVytBektXVTE2?=
 =?utf-8?B?b3pob1B4eGdBOUhlYTFuRGtDdFYzWUp5alI4RUV6a0tybUptRlZhUU0yQWo5?=
 =?utf-8?B?Tll1NEc1djk2cUQ4aEM2UVA2Ymp6QkwzbWhRU1RiZE1OWWdFMk5LeVdTOE5B?=
 =?utf-8?B?aUxINjQzNGFVOHkrcmcwWlJ1MUdydXdSdVg3eWFFQjRkaWQxUHd5NnpPMEZv?=
 =?utf-8?B?SUxMZnZaYTdESmliOStyUEVXcUhvVm53T1NQZ05DZGNLS2FTK290U2tPb0pq?=
 =?utf-8?B?TVhRaEtqRnJSV3JpazJqTGdUNzlkak44RFk0L20vUGdGbU0xS2hzcEVxSFJo?=
 =?utf-8?B?Vmp0eTJlV29WU08wOTIwMmVsaVpCQTRPMU5HNzZjMXZHL0JNK0wwdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1177c0-1c11-4c8d-7ea0-08da16c94fd4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4289.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 05:58:31.3815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8LiUzNDUM2gbNBZWx/UV7KCkZLS5KmxgSdeyWsbkvWTcI0GGsUN9/CrxgEq0OnHrhH7aOO0XvoQKJ6sWxQY6uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1921
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/2/2022 12:55 AM, Dave Hansen wrote:
> On 3/23/22 00:48, Bharata B Rao wrote:
>> Ok got that. However can you point to me a few instances in the current
>> kernel code where such assumption of high bit being user/kernel address
>> differentiator exists so that I get some idea of what it takes to
>> audit all such cases?
> 
> Look around for comparisons against TASK_SIZE_MAX.
> arch/x86/lib/putuser.S or something like arch_check_bp_in_kernelspace()
> come to mind.
> 
>> Also wouldn't the problem of high bit be solved by using only the
>> 6 out of 7 available bits in UAI and leaving the 63rd bit alone?
>> The hardware will still ignore the top bit, but this should take
>> care of the requirement of high bit being 0/1 for user/kernel in the
>> x86_64 kernel. Wouldn't that work?
> 
> I don't think so.
> 
> The kernel knows that a dereference of a pointer that looks like a
> kernel address that get kernel data.  Userspace must be kept away from
> things that look like kernel addresses.
> 
> Let's say some app does:
> 
> 	void *ptr = (void *)0xffffffffc038d130;
> 	read(fd, ptr, 1);
> 
> and inside the kernel, that boils down to:
> 
> 	put_user('x', 0xffffffffc038d130);
> 
> Today the kernels knows that 0xffffffffc038d130 is >=TASK_SIZE_MAX, so
> this is obviously naughty userspace trying to write to the kernel.  But,
> it's not obviously wrong if the high bits are ignored.
> 
> Like you said, we could, as a convention, check for the highest bit
> being set and use *that* to indicate a kernel address.  But, the sneaky
> old userspace would just do:
> 
> 	put_user('x', 0x7fffffffc038d130);
> 
> It would pass the "high bit" check since that bit is clear, but it still
> accesses kernel memory because UAI ignores the bit userspace just cleared.
> 
> I think the only way to get around this is to go find every single place
> in the kernel that does a userspace address check and ensure that it
> fully untags the pointer first.

Thanks Dave for the detailed explanation.

We are discussing these aspects with the hardware team to check the best
possible path forward.

Regards,
Bharata.
