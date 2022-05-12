Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C977C524169
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 02:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349595AbiELAMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 20:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349567AbiELAMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 20:12:13 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8477B8B0A6
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 17:12:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lo77ZurOzYyqNvj+dZ0xUCi2P0QC0Q6qGboGo0ai/puQrYjuKty/cEF/3vLh3dihx6EhD/Z1SZYobmDNxqTDSsMo+dhNhcR6MMax0dZUY0HQMjhYnX5I0XzhJkNeYuS+QzSQT/8RJe423SmbJRf5ZAD1d1wwqWeSV+M2k/3JGig64ue7Eazk9f6qxfPRhQa/Jj2EFF1VRCpmAFyJaAXE9YbQMccQN9vXeXD6/gWs7nWbyJ81f2JKJchOzmYkp36Z4CEC8Gzkqh+krR+otJMylpRfsBLY9oj8cnl2bLP+yA1Jk8NINZMKw+s6hZ1aQJImyMm5VPqcaQKKknTiU6xnIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9EPmJAF56iXuQK+NU6U/YMGgx38jyWLO0vx82yTXUQ=;
 b=gvKiDHPNqPfhyLtXT1VJtnZdgCrhDopQT+//drHZEqf7QSHP6LM4dii3vJQRFuJPwQeRAAawxthBc0H9R8zIBotHwkcwqNU8T1wQPxOfNOGr+p2U/vOFN00KM990StdSaRQSYDwtzKIU0OeCQEJUKHtWIXSButh7D5rsOQ0YcRtkYScALx3KBmXc/0jZb0RC+yFlqfanSsvlRzF/gCwEtknykyDkv0itbOvcfYUgmNs4gA7OzNdif52TFAiUibQpuUSgo7NmLREnlJnkfK3z8J6ErcUKw7KjDdD/y/ajOEBDTz4ECoJFdz+UCkYgd5zbZ24pclvcARVQJy8fmvkieQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9EPmJAF56iXuQK+NU6U/YMGgx38jyWLO0vx82yTXUQ=;
 b=Tbdt1bWB8yuTE5gjwTmaS4+jLtxqxGWbpP6DdnDzw8zinBEPugfZq6UTvfsdoAWyWNlge5ELM9QoMEgdPyxr8MKtxC7WxUxbS3mBVuai6mUTug/cvRKJJm8yn0ZBsIbd04PUdDhpijnMRRXL8PTsqlUNId3QBV86892k3TYCWnbOofXvk16P9JTtamHBNcz8cez++BdR1RYS5G2eSB8dxuko9rjlRGhznCsTthvrMYI4Pj903j9gPMJZs+hLLTLF6xq48okmecgl3uHN7k0nE2COt5N75YiNcAEOxiX8uJfQ1RHOfDenmU+2bK+Zez8lLip6WJUoDCsBv9rLRZR+0w==
Received: from MW2PR16CA0016.namprd16.prod.outlook.com (2603:10b6:907::29) by
 BN6PR12MB1299.namprd12.prod.outlook.com (2603:10b6:404:1d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.23; Thu, 12 May 2022 00:12:04 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::85) by MW2PR16CA0016.outlook.office365.com
 (2603:10b6:907::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Thu, 12 May 2022 00:12:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 00:12:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 12 May
 2022 00:12:03 +0000
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 11 May
 2022 17:12:02 -0700
Message-ID: <0d90390c-3624-4f93-f8bd-fb29e92237d3@nvidia.com>
Date:   Wed, 11 May 2022 17:12:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Content-Language: en-US
From:   John Hubbard <jhubbard@nvidia.com>
To:     <paulmck@kernel.org>
CC:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        "David Hildenbrand" <david@redhat.com>
References: <Ynr10y6pkH6WwbQo@google.com>
 <bb6e76f1-2cbc-893d-c8ab-3ecd3fcae2a5@nvidia.com>
 <Ynr+wTCQpyh8+vOD@google.com>
 <2ffa7670-04ea-bb28-28f8-93a9b9eea7e8@nvidia.com>
 <YnwupNzDNv7IbjRQ@google.com>
 <54b5d177-f2f4-cef2-3a68-cd3b0b276f86@nvidia.com>
 <Ynw6mauQuNhrOAHy@google.com>
 <f7bcda22-8ffe-67be-36bc-fcde58d8884a@nvidia.com>
 <YnxCCPZUfgQNXSg6@google.com>
 <8f083802-7ab0-15ec-b37d-bc9471eea0b1@nvidia.com>
 <20220511234534.GG1790663@paulmck-ThinkPad-P17-Gen-1>
 <ea64b36c-ecc1-74db-dd2e-909e7e507ef8@nvidia.com>
In-Reply-To: <ea64b36c-ecc1-74db-dd2e-909e7e507ef8@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 112bcf44-221e-4f2f-be13-08da33ac0b20
X-MS-TrafficTypeDiagnostic: BN6PR12MB1299:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1299706C65381B1BF97BFC27A8CB9@BN6PR12MB1299.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BMztztGtnmPWXsr5DS9GnKky0SIfvifWC52XNfPeA0R/xs/4fTn39C8XvdutKL4XVp22WASdtXONUXy8ZZ7i1Y1InxLJtl5m7doQe8RCcMbJ6MbAIJODn53wEuJKcjdpMmPIW20lqgO/TX0BYfhjIwbDd3Ot4Wdn3jtXKkRdGlzdfsGwfr4y/wceer9Rb+AcVeDgfWJM+fxEk5aNIsF4M9P+QTlhA1xXuP/NSig+J/RQ6TzCPtvKwSSGXb+JM/wwSHSEWfyLsUf6toRkcgbVZsaFP+1MKFKyCplfnueFN27EaIFEYXtKoP/xmaAffyGFrCXNaidRabKOzLEiD737FCbSYjFdmM9ZNOUKHWH73fZ4sUmSa3lnZ5LIm3wgUjeAu+ESLRQ3s4Gy1znybPC1YFtbY4VeIMw91wU3P07jOSTQPy5T3zyne2T3m0t/Wr+Iu50f325fs4DBp86nroRNHFjUJvC9F6eDdxNevHuFvh/0Bf2Kgq7LtRBsRCfQ3Sh5AhC3lnsbNsFGTp22kNwlo/KWqmbuul54hgefxuTKqaq6h4XW9svuBVkXz8SVPHVpawn79je33yxzhXUlmHXHurgiW9lLp35HXvpTCnf9duqX7K0X0y6phLIgpBVXQV4ZMlyDcAFKAGw2jG3o08gED+kIWvfWJSoAyRcIzAt9ht/SoaLmuckIyqhl/80hA0nCMB7Kpn2jzJHvlxeRmK3dyhYgdl0tBNm2W4PMu8SFC7Kch7uxCtG5j4HajyzAXN3UjI0ni1GXjPdSN39ZxALCwR0wI/huMTQlWHUcoeApHEfm5O0VP+zpAdkl8GlrPsqJqy4NXG7I4b8ZZEKmLMUyUg==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(70586007)(70206006)(6916009)(8676002)(54906003)(316002)(16576012)(86362001)(31696002)(8936002)(2616005)(4326008)(356005)(6666004)(53546011)(26005)(81166007)(508600001)(40460700003)(966005)(36860700001)(336012)(47076005)(426003)(36756003)(31686004)(83380400001)(186003)(82310400005)(16526019)(5660300002)(2906002)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 00:12:03.9183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 112bcf44-221e-4f2f-be13-08da33ac0b20
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1299
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/22 16:57, John Hubbard wrote:
> On 5/11/22 16:45, Paul E. McKenney wrote:
>>>
>>> Well no, because the "&" operation is a single operation on the CPU, and
>>> isn't going to get split up like that.
>>
>> Chiming in a bit late...
> 
> Much appreciated!
> 
>>
>> The usual way that this sort of thing causes trouble is if there is a
>> single store instruction that changes the value from MIGRATE_ISOLATE
>> to MIGRATE_CMA, and if the compiler decides to fetch twice, AND twice,
> 
> Doing an AND twice for "x & constant" this definitely blows my mind. Is
> nothing sacred? :)
> 
>> and then combine the results.  This could give a zero outcome where the
>> underlying variable never had the value zero.
>>
>> Is this sort of thing low probability?
>>
>> Definitely.
>>
>> Isn't this sort of thing prohibited?
>>
>> Definitely not.
>>
>> So what you have will likely work for at least a while longer, but it
>> is not guaranteed and it forces you to think a lot harder about what
>> the current implementations of the compiler can and cannot do to you.
>>
>> The following LWN article goes through some of the possible optimizations
>> (vandalisms?) in this area: https://lwn.net/Articles/793253/
>>
> 
> hmm, I don't think we hit any of those  cases, do we? Because here, the 
> "write" side is via a non-inline function that I just don't believe the 
> compiler is allowed to call twice. Or is it?
> 
> Minchan's earlier summary:
> 
> CPU 0                         CPU1
> 
> 
>                                set_pageblock_migratetype(MIGRATE_ISOLATE)
> 
> if (get_pageblock_migrate(page) & MIGRATE_CMA)
> 
>                                set_pageblock_migratetype(MIGRATE_CMA)
> 
> if (get_pageblock_migrate(page) & MIGRATE_ISOLATE)
> 
> ...where set_pageblock_migratetype() is not inline.
> 
> thanks,

Let me try to say this more clearly: I don't think that the following
__READ_ONCE() statement can actually help anything, given that
get_pageblock_migratetype() is non-inlined:

+	int __mt = get_pageblock_migratetype(page);
+	int mt = __READ_ONCE(__mt);
+
+	if (mt & (MIGRATE_CMA | MIGRATE_ISOLATE))
+		return false;


Am I missing anything here?


thanks,
-- 
John Hubbard
NVIDIA
