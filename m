Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B2457B977
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbiGTPWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiGTPWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:22:22 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1595A2EF;
        Wed, 20 Jul 2022 08:22:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErjJaRjpGSvUhj/Khq1ne8PMbXogimHG2BfdB14/L3n0MwR63Kb5A52yUBkvyY5LrmigXNb/doTvSfb2is7+SoPbv4VLy4maaxc3zAnSSUsdvNpg+ah/gS4kFryVjIoBcfNVTGDxz0tnKH+BeZ/wiMVMDGjYSizHQSmdsQzcA3+XY6yu84gaZ/QwekoJORd344o6RZHfSPsCqIJjqLof1CeKXtiBFa/M2MpqMJirsfM2vlptltjtsGBSFT1FmNcO7sdxJAu8q8pk1aL1pbSJ3tIUACsgH/sQRq7lsGTF/jGIfwIcyt3pSlIvbwOkT8cL4pyvGgobZLcNB3zR76RwrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqcMFr1jCSEMstv3OyvsERAu7f/lcpHLHDSDkQ1ApFE=;
 b=ofTxydvaMj8R8l+lW7+WWOp11h1wA52HKcbG21b7pRnn5v5Kte0obtP5nBxr1NJQUD6YuhZfk3B+Q1Fgxo0caTsnm5gMO/SMMYN3zIDSaC46AU/KaqV1cg1i/HteCfxLl57MVnlNkT60zlYY47AqOhzYuLXtxkfSx7ZOQ6DhaYt7VInxJUY/8ZhAIuxdSWQjjYAuWtafQJjf+bfb9SPNNhPlyWoy7tVjmUypp/VaSQYRY7zVMgr/kE6k0zTCPNJ5w0vfmrGiq9EadkLF3v1tOXMsByW8BBk/U+OCL4CHZetJWJD/NXvvGfOAv/yJ3jHEM+q+V4dxc1V8XiK1jlcDdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqcMFr1jCSEMstv3OyvsERAu7f/lcpHLHDSDkQ1ApFE=;
 b=WpwXnsiN79IeAOtsPsoHus6alOqCD2Obw42tCFXLlCnduFRUZSQ99jxViIiLK8eEnuGHIdQocHwkJ4BqEr0IcRLqw4sUr9/q39HlyVRYctcn6Ma3DjeE2N4Od8mbG7IftGqQ3Zs/KEnYlUbNU7cpG91sRGUOFw5uGQr56l6EKyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BN9PR12MB5305.namprd12.prod.outlook.com (2603:10b6:408:102::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Wed, 20 Jul
 2022 15:22:18 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%6]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 15:22:18 +0000
Message-ID: <352edf44-5983-403f-b8f8-5dfbd92ea32d@amd.com>
Date:   Wed, 20 Jul 2022 10:22:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 1/2] suspend: extend S2Idle ops by new notify handler
Content-Language: en-US
To:     Grzegorz Jaszczyk <jaz@semihalf.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmytro Maluka <dmy@semihalf.com>,
        Sean Christopherson <seanjc@google.com>,
        Dominik Behr <dbehr@google.com>, upstream@semihalf.com,
        Zide Chen <zide.chen@intel.corp-partner.google.com>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sachi King <nakato@nakato.io>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:HIBERNATION (aka Software Suspend, aka swsusp)" 
        <linux-pm@vger.kernel.org>
References: <20220707125329.378277-1-jaz@semihalf.com>
 <20220707125329.378277-2-jaz@semihalf.com>
 <CAJZ5v0gdCN3P52ko44LQMqWJvDArHxZ7p4aSiQamML7aG_kRAA@mail.gmail.com>
 <CAH76GKO9sxnuLM--x6sg7m3bC_NgvLA94N6jHA-+5gW741-ByQ@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAH76GKO9sxnuLM--x6sg7m3bC_NgvLA94N6jHA-+5gW741-ByQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0057.namprd14.prod.outlook.com
 (2603:10b6:610:56::37) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbba6f2b-0c3f-4606-648c-08da6a63a259
X-MS-TrafficTypeDiagnostic: BN9PR12MB5305:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hYHJV2EqD5yo+2NVnasNljmCiA8wTXKBLW2Lm5BpObJ+qED1avfIDcjMBp/naCV8pjEZAy1i/9pkGixJ6yf+yBv9i6ZXhnJ1I1SyZwwDXZEV+dikWUD2Tvc252/uSPInD2Z/N10wV416PuyhKv/KFR/qhW1EsLO8kPdE3mBekKBLIKLtND/7w6ZNOLt/4f8qNBJeEoER8KHyPjdSXxIMSmUepA2az1b/QusJAF/YhDct1BqfTiTnfsgerpDOdAiIekBkg6PJSKLh+XyQYLIWtW/Ka7ZjUA4LGvyfgdBEVwSUPjjvGQAPoKIXEkHYTbTq0l0bvDkBh2sVKPpUVGXiQNr5QYu9LISM4lwoCYb5wI+Brc7eXNn3i6PS6cQN9PUjC2MhPv6qvWmgImCc756sY5j8457MP5U1AQvRWnnBojJ3xuiLkiL7QYWY6xpwbE3bO0QoTwmfkLglEFz8hlsiyfNz7KDat5jYpnnal2M0DhhBlXmwxUIidUp7DBLJcbba37rIBRpj7X2soc0wJOtLJtu9/SZRs/hHnnM3ME/gx5sYPZOkBDGBtcdXp1rfZiXuBqkkNSPljCXu3eYe0CS2YpoFsOVtz1udGr2ddVEbiTl8B9vK3ngtQRrMsS7oSrrTgNQO71TeXRF+n+q1eqnxwTHTjcBJFPXMFqHj/noZxM2bZKsCCb8GApUvI9e1lbxhijAuswGNMbCQMRUkFKjeIDrokDKH9UMqJXPQh8WbhlDXHSp7AY7WrJJcrQOxRUUSUbT8TSOjvJUAlY3kFNk/m5KXgMBz9bge/JcNYzDwgOedwNgRizhTQVKZlngYyKrV90Nj6ii14ATSdm3+WxPsaFhUpV0EK/53KFMqPbX6MA/5lEt0MGb6weTQf10wujP+9xLGF6bpJLUkEAFrEtsjag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(478600001)(6486002)(966005)(186003)(86362001)(66476007)(26005)(2906002)(6506007)(36756003)(8676002)(110136005)(316002)(41300700001)(45080400002)(6666004)(31696002)(54906003)(31686004)(66946007)(4326008)(83380400001)(66556008)(2616005)(6512007)(7416002)(8936002)(5660300002)(15650500001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXlVMGd5dXlvV21EVU9kalk2TWRpSDFRYTRTd1kyODZ3ME9rQ3dzRThqcURp?=
 =?utf-8?B?aDV5QXZpVGswVHYxdjJyNmhSTTJiWG01Z0RWQmR2M1J4RTVGUjRrQ1hmZ0dj?=
 =?utf-8?B?MHRreXQreThwaFhuQndxYkJLRzBxQ0ZoRXpnTkE5cGQyVTlQSldTLzVFK245?=
 =?utf-8?B?OXd3NGFwR2hqc0w3b0RpRng4SUJocXZadmZORWdZemx2V0c1T2RPZHhGb09D?=
 =?utf-8?B?Q1JMWjRKdEhtbi9DckovMUxnZ3QyalFONUljTmhpWkhONjRMZVNYMlRHT3lq?=
 =?utf-8?B?eUxVWUhkdXZnM3JSTXhqb3ZuNWlqU0d0S3ZKYW96RWY4RmxTYnNMd1YwUEhI?=
 =?utf-8?B?RktUYjlvQW5wczQwREk5WkRncDJNY1Y0TnlISlY1R3VvekxFU3l6cHhTQ3JF?=
 =?utf-8?B?NnFYeXkyMFlZcWlqSForNHg2Si9pd1F6Z3BEazkxU3hPb0NJa2VsMHpHekxz?=
 =?utf-8?B?Q2RIUG9OVmovRnpvMTNFcTNEblZYRitqMlBaT0pMMnE0blNrUWcrMURxZ2Rs?=
 =?utf-8?B?eUhDSXdwZ1dDNWd4WGR0RzNEZ0dnZjZtdENiTHRCMitoZHAzcTE0M3JJMUJF?=
 =?utf-8?B?am1TUVFjQmdUeEZNQi9QNjQvS2U5Qk1OMUJ2Tjc5NUFWelFWRk9VZHYxc21v?=
 =?utf-8?B?TkNvRUZYUlA1b3hnVVR0ek1aL2pPRGlnZWppQXZpUllsclB0WWM3ZnFTQk1p?=
 =?utf-8?B?enJoV3JCTG0rY1J5UWdmbGc2NDkyUXhXQ01wSnNaSyt6eGZRZEErem1MNzd1?=
 =?utf-8?B?RzNldG1XNDdnMjRTU0dhZnk0d2ZVTXVQc1VDOGtMUEtRNzFYU2thNFRBdlNk?=
 =?utf-8?B?N0RuMXRSQnZMdXdZVlNpRUtya2dab2haVTRnTUV3dmhCZDIwd3QwaGZEQ3B0?=
 =?utf-8?B?ZkFaeUZYRFF1aVdZVGhmSzJrdWVCQnc3TGw3MDZzZzJFdFdoUFNqSVkzMzJM?=
 =?utf-8?B?YXBXdVRlOU42czkvSEpjcUdVTXNaOUFLQVNxS0JLTEdOOHhlMEtkM0JIMlh0?=
 =?utf-8?B?RW5ub3VrdWxuVDhtMFV4YmdwTlppTm5WY083ZzB2c1IrQTVVQW1KQldwRmwy?=
 =?utf-8?B?YllEa0p3T0lwOFlPR1VCWmFNNEFSMUlUYTRnSEZmWGZPZnk0QWdaVS9qRFZa?=
 =?utf-8?B?S2pXT1M3RDNZbXRmV0t2MTRZeEdXVUx4RHNYZ0N2dExHc2dsbW91azhzNyt3?=
 =?utf-8?B?b2U3MVd5N2doZHNZTGJvNjF3a1hUSStlWTljcCtVZHhRbFVqWGNacjlCSEFW?=
 =?utf-8?B?UzllOTduRVlCTjZSUlRWWEY0ZmoxMHhXcmovanNzenR2UG1hdTkrNjFWeU04?=
 =?utf-8?B?NUQrVkJNRVRrRXNEVzRuVWFoVFpVZVdpNmRDMks1VHVlazJyaGcxeE9wbnJP?=
 =?utf-8?B?RkJEbGRUb0tUb0N0U2hpRWJCSXJtSmlWbHN2d2FwMFloTjFCSUZMbkQxUk1i?=
 =?utf-8?B?L2k3WFJ1d1M1ZGpJNldlOEZEaWpRdGRPYmV5WTRUbnIvRzRyVlpCZmRtOC9u?=
 =?utf-8?B?ZCt1ZnVUSDF5ZlRobm9PMHZ2cGNqVzhJOUdDcWNVVTdZVzFBcUY5QWJZMzl1?=
 =?utf-8?B?Wk9JanhHVytleTZDSGlNU1RFc2hwYkxrUWo2ajRaR3BsV1MwRDJTdFhSWkdD?=
 =?utf-8?B?d1ZIUGszVndpTkRmZmxpaHprUnZrMkUwcHFNNmJ6UUpjUHRYVTY3VkNvbWM4?=
 =?utf-8?B?bHNaYjVtYlo5RjhVanpoQ25GTDJqMENBbk54NFU1Nk5WTTk1c0dMaytTSmVx?=
 =?utf-8?B?SnZ2QWUyZ1pEd3JiNFFudG8yOXBkN3cyTkNSbis3MXMrdlRLMC9Na1ZMaHNu?=
 =?utf-8?B?VjVYay9SYXVkSlYrZG5aaXQ0dW5Bai9lcDBDZm1DQWFZQWkyak9CVXU1aU0y?=
 =?utf-8?B?TUh3bEpnVW1mWVI5R1NoSjRZNmZCMEJEWmovMTF2YytDSzJpUk1oMzU0eGd0?=
 =?utf-8?B?NDZFdzNXUWxDQUhOcExYRzhObENwQk1KVmQ3WFppZ0NHTlJha3dlM3lMU1Ax?=
 =?utf-8?B?UXV5NmlNMU5zZS8rdFJyOFhxa2p6MlE5MHhCNU5qQXlkN2VuOHdwNGhYYjVK?=
 =?utf-8?B?c2RXY2MyNEFlcXpOOEdRdnE1dHdoTWwrdUhaTXFPV0dZUHdyUzVaUFdHeVho?=
 =?utf-8?Q?ygljFS7gH7njJ6lJDoGEuh2jJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbba6f2b-0c3f-4606-648c-08da6a63a259
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 15:22:18.5982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vb0OzfTbo5p7Pi3g6afqUv0NEx7sjrdJI+RCDds8QSSODEvuK7q2nrRSRAe+9fxAiPrAGR5ME1+ebji7xbf8+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5305
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> It looks like you want suspend-to-idle to behave like S3 and it won't.
> 
> In a way, yes, we compensate for the lack of something like PM1_CNT to
> trap on for detecting that the guest is suspending.
> We could instead force the guest to use S3 but IMO it is undesirable,
> since it generally does make a difference which suspend mode is used
> in the guest, s2idle or S3, e.g some drivers check which suspend type
> is used and based on that behaves differently during suspend. One of
> the example is:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv5.18.12%2Fsource%2Fdrivers%2Fgpu%2Fdrm%2Famd%2Famdgpu%2Famdgpu_drv.c%23L2323&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7C7bdd972291324d03847e08da6a51ff4f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637939197694682503%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=5M1sn3iRybQzSFi3ojQ4YTJuW41DlgJNl5sxbWEvLBQ%3D&amp;reserved=0
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv5.18.12%2Fsource%2Fdrivers%2Fgpu%2Fdrm%2Famd%2Famdgpu%2Famdgpu_acpi.c%23L1069&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7C7bdd972291324d03847e08da6a51ff4f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637939197694682503%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=fIrLmZAgpIRPYO4to4uYUoBSEWXmz1lr%2BTnR14kAfvM%3D&amp;reserved=0
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv5.18.12%2Fsource%2Fdrivers%2Fgpu%2Fdrm%2Famd%2Famdgpu%2Famdgpu_gfx.c%23L583&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7C7bdd972291324d03847e08da6a51ff4f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637939197694682503%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=SNsbmpV4HrgA%2Bkff4JzRodNDzKvwM5tnkGDvrKO44dc%3D&amp;reserved=0
> 

Actually I recently was suggesting a change to add this detection to 
another driver to set a policy and Rafael pushed back.  He's actively 
removing it from other places in the kernel.

For amdgpu stuff you pointed above, are you wanting to pass through the 
PCIe GPU device to a guest and then suspend that guest? Or is this just 
illustrative?

For a dGPU I would expect it works, but I don't think passing an APU's 
GPU PCIe endpoint would functionally work (there were bugs reported on 
this I recall).

That code path you point out only has special handling for APU when 
headed to S0ix and that's because the GPU driver happens to be where the 
control point is for some common silicon functions.  If the bug I 
mentioned about PCIe passthrough of the APU GPU endpoint to the guest is 
fixed and the guest needs to do s0ix when the host doesn't we're going 
to have other breakage to worry about because of that common silicon 
functionality I mentioned.
