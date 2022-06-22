Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35575554BB3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356359AbiFVNrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353254AbiFVNrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:47:47 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478AC338A7;
        Wed, 22 Jun 2022 06:47:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4374f2ranSoIn8NdkedUzg+56YX+/XVJsfXbZ1q1+WeeRYBqV0UT2irMQkAcqMdzlQnOhHuLavN52+VWBcZSlzFKHK84tGc37yScxKIQodASa8qHdHJtVdolUSBozO19+bsWNlbrtPa/eZYrCWr9fxLYHv4cNEFrdx+DWHpRGZq8evMmPjI1Ww1OCV0uNQm0DUb8fgCXycAM/A77WoW0sUsRhwfUYBlGPaVTlRVzHOm6kY2OUgv2uCvAcfUAMAfIx9mnSGWCy2ezeC4H2n5s+uU+Y2N49Na8o/eFAw30bTY022noEQ7urHXGw+nAItNG6G56XGMxFAW2PvFcXhR+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73C/pHcBUMK2H40ACJ1VSbE5HSn5QQ6H0/KyJfeZtp8=;
 b=oVkgvnwRm8ebLQSYJJ1Wg5YXz+zdZoqVpXAihfhnQ/20V+AG55OCaDUW7OzYwoAojem7K5K/oolKUeNvAOifLPZbSXRvD55w7lZPpdhvoQC3PZx84Wd9RSHzsfkieBhpwBDLPGVYFIXMQn0VC/vUch3MIRscqTKzJhItnJym1tvg6ZypIQe07QsplImLpAq9/2g5NWlp+JfmjyWnKH36QebT0xqFnz3lfIYfm+FrX2s5mDqmWZ+qwdZnvMrT9s82ziHkMYKEygna15u5MyWzFjCpxgjWjJF8peY1skgIl2By+KyA1CD4+/45c75NpPoP5F2BDcUiF1292euRoG0I4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73C/pHcBUMK2H40ACJ1VSbE5HSn5QQ6H0/KyJfeZtp8=;
 b=jUWvBeyaZhnDWCdFNxHJQp0lcikZD1bh9uPtpDydmRXhYRgoMIhzrFGP3iwmZHtSHxflxWk3BSwYJTAnZKIZ0ErUaPYb9+1ifRXxVDXt27Bjc0e5uhGCpgpwJ4O2dQHpSsWEKak2r7Jq/n1Jb5rA2hpNzV0vcy/EJvK5BUCMM+73HhE19ne0kZ0IE3di57AXUTry+v7uFTrSgiC/8GO3eEc4Vc+/mTv5IjMBSQ1vzBobL93zntzZ1MPlsvBviYJ7rgF6Ex49F1T9LWOQHG1NfHN/bnRPxWzfp8kQMT/2gd6JuU7VWVyOOIsfYZhvT0R1uEb2pf6jmRkxu/u5UANc1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.18; Wed, 22 Jun 2022 13:47:42 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::190c:967c:2b86:24a8]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::190c:967c:2b86:24a8%4]) with mapi id 15.20.5373.015; Wed, 22 Jun 2022
 13:47:42 +0000
Message-ID: <55623c12-dda3-613f-5bc9-80b3b6fec5f9@nvidia.com>
Date:   Wed, 22 Jun 2022 14:47:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 5/8] OPP: Allow multiple clocks for a device
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <cover.1654849214.git.viresh.kumar@linaro.org>
 <8b29fa207024dc295639f9ba52c28e45782e3baa.1654849214.git.viresh.kumar@linaro.org>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <8b29fa207024dc295639f9ba52c28e45782e3baa.1654849214.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0097.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::13) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b64ed3d-8bbc-4c3a-446d-08da5455c752
X-MS-TrafficTypeDiagnostic: DM6PR12MB2939:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2939B5BA5D32AC484BBE03F4D9B29@DM6PR12MB2939.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p9we7HHXFmHaDlKXVdQZIQHtrPnC7A/Q8d/DNALsck7Fo0+fht7I37PiaaCyVWfAdm0nDu0fW+NMRE6W5yFsImP2q4HVotc56tML2dbuZIKTKFsJiZgqzA33IPXg92UXbJcoCOi5xpqHy0S5+ByPPAWH1WfBPOGOAddkcF3EzliK8zYJWUts8K5E7fYY1Ukdc2moyLSkzNp4AqBfmAGAS0HebelTNVZckupUj/Vo4aHE0AGliYEWpUrqS2yoKuHpIWm+7xfiue7BL5ib3K1HgF+3XoWMDAwPuUJ9ZW0YBxcjOmXGFFgZMmsBUxrIycl6pGyw6Msl7sC7PMBSJnAsJA5n77p2XGxXWam0Iu2lG4nnpSVPtq4R5j3zo10Z5FpSlEbR3Q48mHxnZCpGjefSOE4yWfx9NrpSvZ2uerpBwiZo22PrLBzeGRnCqXHLsHd34IrjyEQ8xCedqASPu2tj4Uv42HyZIk8SPJDQ4AhxmIbN9qokPRTZv9ZkB6i35MWYzO9lPT+Ln8L56cUS3fFEIXmEwlF4910UVE2TNcQ0e7gTCwPLd8X5DLcHHOMlgAB2K91lHr9LC/r4JI51fdgYW9sRs3bYNF+JQtNlGa02IDjVOc7UcFKLGzq+iqpRrCmUH/KF9K3CjJdlDNc4Jp8Dm8aFrdP9fSNWpvd/sLfTU7lP1I8SMvR885lDUqhVwKMLa1jcL1B/yTvO3w0ixlkxnH9kHg3iCRYX5tRsSXGYff2OfBACIc3yKI7Mmto3+A1UsmUdpK1L1mKo1v17JUNhE38m9KrXPSTrBcapnnpn6Fc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(54906003)(110136005)(2906002)(66946007)(186003)(8936002)(6506007)(26005)(36756003)(83380400001)(66476007)(7416002)(66556008)(38100700002)(4326008)(6486002)(2616005)(316002)(45080400002)(8676002)(6512007)(55236004)(5660300002)(31696002)(6666004)(86362001)(53546011)(41300700001)(478600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zitkb3lqSkxYWUVvWlBWNnpvMkJDTUFFdlZxMFl4MGptY3NhY3pVRWlwelEy?=
 =?utf-8?B?cUNXMUwycG9yMVFnWmM5QkQxejZwV1FVUnE5TFFPN3VXeldEOWllVFBubjlw?=
 =?utf-8?B?VnpuVVkyRUxvMEdxUFhKZmlncldtNUN2UVdvdExIWjJWdFdPS1k4d3p1V2tP?=
 =?utf-8?B?M3NjTFN0TjQ0M3JlYk1VREwzUTZrdld2TksxUDZ5dUo0L3N5NE9BNXZsQmx0?=
 =?utf-8?B?RSsxcWt2eVhRZlRUNEtWcGNpaHNmcXNscG5LNUtCQ2dwTCtnNWtrS3FQT3Z2?=
 =?utf-8?B?Qkszd0E4UzEzZG9PTE5MZjBkZjNBWVAyaVMxN0txU0lUazczd0xPbVpGaDVj?=
 =?utf-8?B?ckk0RWZXZ0JuQm05bGxLM3V0TlJtUVJqUkV5QkhwZ1hUMVkzdElPWXBIbWxQ?=
 =?utf-8?B?b1JjV1pOTDRJVlB6WEtTVjl2WHRWdTVrMUdBME43UWM1L1VWN3picXB6akZa?=
 =?utf-8?B?SUs1UHJLV1RKRzMyWjRTN1hhdzlqczhSRkFGYmhPOGJXeThKYlJaTDRxcWt5?=
 =?utf-8?B?MWNDekZXREN3SlY1eVhCeXJ0T0xrRHp4Z1V2dVNGeEY3SVBnZHdtTDBnazRU?=
 =?utf-8?B?UU1ra0Z2UFRPclpnRHlESWVoVEV5WFFBci9tenlJcTNyOS9pNVhxUVRkUUl1?=
 =?utf-8?B?M2p6ZnBHRmpwZHRldEhCckx4OHBWZ3VJSXFMbkwvbXpiek5oamFBUXZzT1hi?=
 =?utf-8?B?QUpvRlNISUorL0t1cWdvRWtvY0NRaUY3dS82MjEwNXFPeE5taG0zY0JvVW5Y?=
 =?utf-8?B?aGo3WVBhdjV3Q2xYbTBuZlVQaENmL2tkbldFV040VjJXN2NwSnNCTnVkNUdz?=
 =?utf-8?B?bVhsVzVWbGl1QU5mTUMxQ21VV2hoZlpaRU13RzVSc0hxVFFuSS9WYUhzK3px?=
 =?utf-8?B?ai8xajVRS3hNNlREcVc4elpHVnpXSDB2eUh3M0J1OHlCVld6VVpDdEtZV0lU?=
 =?utf-8?B?UURIQktqNDNQeXRZNkU2dWFrcWd5UUdnSStEelNvTDAwQ1RvZFA4K0hzWXow?=
 =?utf-8?B?TCtaMXB6dDhCSFY1NjMzN0daVmRQUFlwb2ZzdWdQNEFyVmFtZnpkZlpYS3lk?=
 =?utf-8?B?MDZUSW5TRStwdWxpVUVMbEFVZTlURHN1MnMzWDRwemZpNmd3NEpzSXE3Rjg1?=
 =?utf-8?B?UnVVc010andvelZRaUhjT0toellTWW42aGZnaUY4S01XSTEwdXppcW5NNVdT?=
 =?utf-8?B?alpsMjZXUHVqZmkvVlRIbVZsVi9YUDVyZytTcXY3TngrQy80TnRhSys4eHIy?=
 =?utf-8?B?OXQ3OW9IdDhhOXRnY2gyVUxnTDhjZy9UNzVLMjJnWGZ4KzVRNTI3MnIwWEVz?=
 =?utf-8?B?RHhVRWcxdDZVbnRGSkh1YVFKczRlSW8vemYvTGRrQlB0NUdCY1dvTHViMEY3?=
 =?utf-8?B?dmkxTHA0MjhuQldxQm5Kc0R0enNnMk1nRkJ6WlVSZittSmlrR2Q2MWdCUGUx?=
 =?utf-8?B?blVVdEdWeFV2UzQ0RE1qM1JodVN1N2tibkxpbkF5RStpYjQ0U1pjTkhUSEdu?=
 =?utf-8?B?UFBPRVJYTjdUZW9KamZGVDRDRXc3amtNd1ByYnNiTG11Q251NmpSelNsUHBK?=
 =?utf-8?B?OWpUVXRZcTBHTXNDeHg1SGJpR1RZeUZESUdBSDFURExnNlVSQ0x5ZFM0NVQy?=
 =?utf-8?B?cWxyL3RDNGk5cDhEazZ5ZlNYSWNSUmxjcFY1VXlDL29TaVp3eGJNaG15UVhv?=
 =?utf-8?B?aHlKczRKWWoxY3BreUtmS2NHajBIZVZuWGlRK0NDVG9hT2RMNDMvVDBaUy9j?=
 =?utf-8?B?Nk9Oa3kwVUNGeVl1Umh4dmRNVWk1MFdiWDhSWGhuSjBtcUxMcWk2eElCS3FZ?=
 =?utf-8?B?Z2N1ZGZ6dWh5bVJQWDk2aUtOSEFiWGZIWDlMS09iaXZSdGZhNGUrbmtXekQ0?=
 =?utf-8?B?S2FTR2RKS2JaY2g2eTA1R3ZNbmxhdzZEaGI0Ym85Z1ZKTDhtaFVOYlpzd3dE?=
 =?utf-8?B?ZXZhdVR4bEVjSkVHQU8xTUo0elFRZHVMQWpzSE1nMGhteUp6YXpsR0REYTNL?=
 =?utf-8?B?ZVNPSUpaTXBZaUQya1lVNVVRaDFnWlJrOHF0N2c4TTJ2cUEvNnhISmhDdkFq?=
 =?utf-8?B?UjJ2NzVRNzRnbnFReFhlakRDZzdGWEZycDg2Nm1SS0dUNHRtV1JsaFlqT21U?=
 =?utf-8?B?MHhkeFVibGYyeXV2cFd2cE1VWnhmQlB2YTVzbkNiS0d2cERrejE3R01scWhv?=
 =?utf-8?B?dXVGZEMzd1BzY3F2RkhEa1pXYXg4SHNrKzZpVGFHMmpYZDVjM2E3VlB0MWln?=
 =?utf-8?B?bEpUK1I1dCtvdjZIbFhxMjl4NDRad1F5U2VoUmxVcXMxUDdTaEQzNkExSXl4?=
 =?utf-8?B?RFc3RmhwZ0s4akJyNTVTRU53TkErdUJBUDQwMVlTa20wSFFlZ01WZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b64ed3d-8bbc-4c3a-446d-08da5455c752
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 13:47:42.3275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8BzibnDo6GwS+fkFa6COq7GgByl39A/KN3YlHddTCLWOcPaQFbo4PrvRzxg7Mjtrxfd0HyGQux0trJaM2Px5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2939
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/06/2022 09:20, Viresh Kumar wrote:
> This patch adds support to allow multiple clocks for a device.
> 
> The design is pretty much similar to how this is done for regulators,
> and platforms can supply their own version of the config_clks() callback
> if they have multiple clocks for their device. The core manages the
> calls via opp_table->config_clks() eventually.
> 
> We have kept both "clk" and "clks" fields in the OPP table structure and
> the reason is provided as a comment in _opp_set_clknames(). The same
> isn't done for "rates" though and we use rates[0] at most of the places
> now.
> 
> Co-developed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/opp/core.c     | 165 ++++++++++++++++++++++++++++-------------
>   drivers/opp/debugfs.c  |  27 ++++++-
>   drivers/opp/of.c       |  67 +++++++++++++----
>   drivers/opp/opp.h      |  16 ++--
>   include/linux/pm_opp.h |   7 +-
>   5 files changed, 208 insertions(+), 74 deletions(-)


I am seeing the following panic on -next and bisect is point to
this commit ...

[    2.145604] 8<--- cut here ---
[    2.145615] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[    2.145625] [00000000] *pgd=00000000
[    2.145647] Internal error: Oops: 80000005 [#1] PREEMPT SMP ARM
[    2.145660] Modules linked in:
[    2.145671] CPU: 1 PID: 35 Comm: kworker/u8:1 Not tainted 5.19.0-rc3-next-20220622-gf739bc2a47f6 #1
[    2.145688] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[    2.145697] Workqueue: events_unbound deferred_probe_work_func
[    2.145740] PC is at 0x0
[    2.145750] LR is at _set_opp+0x194/0x380
[    2.145779] pc : [<00000000>]    lr : [<c086b578>]    psr: 20000013
[    2.145789] sp : f08f1c80  ip : c152cb40  fp : c264c040
[    2.145798] r10: 00000000  r9 : c152cb40  r8 : c16f3010
[    2.145806] r7 : c264c034  r6 : 00000000  r5 : c265d800  r4 : c264c000
[    2.145815] r3 : 00000000  r2 : c265d800  r1 : c264c000  r0 : c16f3010
[    2.145825] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[    2.145840] Control: 10c5387d  Table: 8000404a  DAC: 00000051
[    2.145847] Register r0 information: slab kmalloc-1k start c16f3000 pointer offset 16 size 1024
[    2.145883] Register r1 information: slab kmalloc-256 start c264c000 pointer offset 0 size 256
[    2.145914] Register r2 information: slab kmalloc-128 start c265d800 pointer offset 0 size 128
[    2.145942] Register r3 information: NULL pointer
[    2.145955] Register r4 information: slab kmalloc-256 start c264c000 pointer offset 0 size 256
[    2.145983] Register r5 information: slab kmalloc-128 start c265d800 pointer offset 0 size 128
[    2.146012] Register r6 information: NULL pointer
[    2.146023] Register r7 information: slab kmalloc-256 start c264c000 pointer offset 52 size 256
[    2.146052] Register r8 information: slab kmalloc-1k start c16f3000 pointer offset 16 size 1024
[    2.146081] Register r9 information: slab task_struct start c152cb40 pointer offset 0
[    2.146105] Register r10 information: NULL pointer
[    2.146116] Register r11 information: slab kmalloc-256 start c264c000 pointer offset 64 size 256
[    2.146146] Register r12 information: slab task_struct start c152cb40 pointer offset 0
[    2.348527] Process kworker/u8:1 (pid: 35, stack limit = 0x(ptrval))
[    2.354896] Stack: (0xf08f1c80 to 0xf08f2000)
[    2.359273] 1c80: 00000001 c0868db0 00000000 7a13d783 c152cb40 c264c000 c16f3010 c265d800
[    2.367471] 1ca0: c2661c40 00000001 c2661c40 00000001 c2661c40 c086b8e8 00000000 7a13d783
[    2.375666] 1cc0: c12ea5a0 c265d800 000f4240 c058cfcc ef7dddec 000f4240 00000000 c2661e88
[    2.383861] 1ce0: 000f4240 000f4240 c2661e98 c068d238 00000000 c2665e00 000f4240 000f4240
[    2.392056] 1d00: c2666258 00000000 c2666000 00000001 c2661c40 c068d15c 00000000 c2666000
[    2.400253] 1d20: c16fd140 00000000 c16fd140 00000000 00000000 c16b78b8 c16b5e00 c068d2d8
[    2.408450] 1d40: c16b7810 c26661d8 c2666000 c068ed98 c2663d00 c2663d00 00000000 c086914c
[    2.416647] 1d60: c2663d00 c16b7810 c068ebec c16b7894 00000004 c0174868 00000000 c16b78b8
[    2.424843] 1d80: c16b5e00 c0684630 c16b7810 c068ebec 00000000 00000004 c0174868 c152cb40
[    2.433041] 1da0: c16b78b8 c0684794 c16b7810 c068ebec 00000000 c068506c 00000a00 c265e040
[    2.441237] 1dc0: c0f5bdd4 00000004 00000000 7a13d783 00000000 c16b7810 c16b7894 00000004
[    2.449434] 1de0: 60000013 00000000 c265e10c c265e154 00000000 c06854c4 c265e040 c16b7800
[    2.457629] 1e00: c16b7810 c152cb40 00000000 c05e42b0 00000001 00000000 ffffffff 00000000
[    2.465824] 1e20: c16b7810 ff8067a4 01000000 7a13d783 c16b7810 c16b7810 00000000 c12f7700
[    2.474020] 1e40: 00000000 00000001 c1367c20 c140f00d c1405800 c067a668 c16b7810 00000000
[    2.482214] 1e60: c12f7700 c0678280 c16b7810 c12f7700 c16b7810 00000017 00000001 c06784e4
[    2.490411] 1e80: c13b6754 f08f1ee4 c16b7810 c0678574 c12f7700 f08f1ee4 c16b7810 c152cb40
[    2.498609] 1ea0: 00000001 c06788bc 00000000 f08f1ee4 c0678834 c067675c c1367c20 c14b4e70
[    2.506804] 1ec0: c1ea60b8 7a13d783 c16b7810 c16b7810 c152cb40 c16b7854 c12fa050 c067810c
[    2.515001] 1ee0: c1400000 c16b7810 00000001 7a13d783 c16b7810 c16b7810 c12fa2f0 c12fa050
[    2.523197] 1f00: 00000000 c0677410 c16b7810 c12fa038 c12fa038 c06778d0 c12fa06c c176a180
[    2.531394] 1f20: c1405800 c140f000 00000000 c013dd2c c152cb40 c1405800 c1203d40 c176a180
[    2.539592] 1f40: c1405800 c140581c c1203d40 c176a198 00000088 c1367177 c1405800 c013e2a4
[    2.547790] 1f60: c0f07434 00000000 f08f1f7c c176f7c0 c152cb40 c013e064 c176a180 c176f640
[    2.555984] 1f80: f0831eb4 00000000 00000000 c01459b4 c176f7c0 c01458ac 00000000 00000000
[    2.564180] 1fa0: 00000000 00000000 00000000 c01001a8 00000000 00000000 00000000 00000000
[    2.572373] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    2.580569] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[    2.588768]  _set_opp from dev_pm_opp_set_opp+0x38/0x78
[    2.594038]  dev_pm_opp_set_opp from tegra_pmc_core_pd_set_performance_state+0x44/0xb0
[    2.602010]  tegra_pmc_core_pd_set_performance_state from _genpd_set_performance_state+0x180/0x1d0
[    2.611018]  _genpd_set_performance_state from _genpd_set_performance_state+0xa4/0x1d0
[    2.618972]  _genpd_set_performance_state from genpd_set_performance_state+0x50/0x7c
[    2.626752]  genpd_set_performance_state from genpd_runtime_resume+0x1ac/0x25c
[    2.634016]  genpd_runtime_resume from __rpm_callback+0x38/0x14c
[    2.640073]  __rpm_callback from rpm_callback+0x50/0x54
[    2.645335]  rpm_callback from rpm_resume+0x394/0x7a0
[    2.650424]  rpm_resume from __pm_runtime_resume+0x4c/0x64
[    2.655947]  __pm_runtime_resume from host1x_probe+0x29c/0x654
[    2.661824]  host1x_probe from platform_probe+0x5c/0xb8
[    2.667080]  platform_probe from really_probe+0xc8/0x2a8
[    2.672433]  really_probe from __driver_probe_device+0x84/0xe4
[    2.678308]  __driver_probe_device from driver_probe_device+0x30/0xd0
[    2.684789]  driver_probe_device from __device_attach_driver+0x88/0xb4
[    2.691350]  __device_attach_driver from bus_for_each_drv+0x54/0xb4
[    2.697647]  bus_for_each_drv from __device_attach+0xf0/0x194
[    2.703430]  __device_attach from bus_probe_device+0x84/0x8c
[    2.709129]  bus_probe_device from deferred_probe_work_func+0x7c/0xa8
[    2.715608]  deferred_probe_work_func from process_one_work+0x214/0x54c
[    2.722269]  process_one_work from worker_thread+0x240/0x508
[    2.727960]  worker_thread from kthread+0x108/0x124
[    2.732872]  kthread from ret_from_fork+0x14/0x2c
[    2.737602] Exception stack(0xf08f1fb0 to 0xf08f1ff8)
[    2.742669] 1fa0:                                     00000000 00000000 00000000 00000000
[    2.750865] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    2.759061] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    2.765690] Code: bad PC value
[    2.768990] ---[ end trace 0000000000000000 ]---


Let me know if you have any thoughts.

Cheers
Jon

-- 
nvpublic
