Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE2B57B624
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbiGTMKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbiGTMKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:10:11 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C3A2602;
        Wed, 20 Jul 2022 05:10:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YicfMXxO7aZawkuhKaF59kiL/R4K8BgHMcNLkUXgx5TBB4T6BRycTsIS+MOmddUMBAkpnrNejJemkUiPJio8oAhbN7HdCTMP0bghx/Pbv7LsrtInRpXBV0P4Qv1wfwYFQ/cCndS7myNNrKXhu+x5PV1+NF4u2SZl23ekUCaz+Bl+OXnMLsN7KxNaZVDrIdOi7KN8MoH6Bl/fgDeCdxuw2/7Q+qfo9Vz4aVMlz15ih0/k2phte/GZk/geRyIG5IL+Uq4BcClqbTrmPMIRJgzWzVanY+gd6mBMzUV0k1v2aywdWkZLIyvOAjw1DHc3QID4+TofwmS1X19N1sGZ4cYjUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESc88OKTPKF3slXWZbfTK1l7GcZDpUbxhsdfBa02Vww=;
 b=AXezUCsbfwBuv3p43GhpAD+8WgX0+jjm8bq3Lj33SYcpX/ByPUFnozKiz1eHhuKj3ZJBwzW7msUeqBK1RUDsV6ySCfgN/4S8g+qt4L68smE8zQaDe6cWcYpHcV9Na2OBdfN2QUKOTVIk1iGu4U/aqAYkQJWDrMrABiKhtE+gDLil7L0R2wF5EEvgjm/NVaOi4LttVMwaQt47ZW0xS5ie/7FWz1RIb4Lcez4fhlBqhDJU48WCYJ16RZtOw6RCgTVhudLcesek+FJ7ExlVieWJiUlL3fz5onhQUL6+5kUVAyJaj2H1kg/E34tBxro2Acs92E96+xztabJwH2raJiTz/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESc88OKTPKF3slXWZbfTK1l7GcZDpUbxhsdfBa02Vww=;
 b=jvHAWAJXAfqyMlR8Hr/yNq3U8iZwCOjDbzbvctUx7mT4tScLbXS3qNYMx3AQdxybT/tFizQ4wHQDVKdVhi3gZ/A3ewcQ91khvSKi4mrWTnBEA6aU/Ldscla7fownimAKapPFmjwasaz5QnbgPFLyX2MZBt8lE9uuae0Au7tiDyY=
Received: from BN9P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::35)
 by DM5PR12MB1322.namprd12.prod.outlook.com (2603:10b6:3:70::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Wed, 20 Jul
 2022 12:10:06 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::28) by BN9P221CA0018.outlook.office365.com
 (2603:10b6:408:10a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25 via Frontend
 Transport; Wed, 20 Jul 2022 12:10:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Wed, 20 Jul 2022 12:10:05 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 20 Jul
 2022 07:09:31 -0500
Message-ID: <259a1808-934b-359c-a95f-50d654a48816@amd.com>
Date:   Wed, 20 Jul 2022 14:09:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/4] dt-bindings: misc: tmr-inject: Add device-tree
 binding for TMR Inject
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Appana Durga Kedareswara rao" <appana.durga.kedareswara.rao@amd.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <michal.simek@xilinx.com>, <derek.kiernan@xilinx.com>,
        <dragan.cvetic@xilinx.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC:     <appanad@amd.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        <git@xilinx.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
References: <20220720060016.1646317-1-appana.durga.kedareswara.rao@amd.com>
 <20220720060016.1646317-4-appana.durga.kedareswara.rao@amd.com>
 <77e8433f-6cb8-eb32-63d5-414a92d3b874@linaro.org>
 <f45fccec-4496-19af-0e14-bd626e14c7bd@amd.com>
 <bc99e06b-1aa5-441e-c86f-0fbfb0945d0c@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <bc99e06b-1aa5-441e-c86f-0fbfb0945d0c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 016a472a-25ce-4021-8e67-08da6a48c8b7
X-MS-TrafficTypeDiagnostic: DM5PR12MB1322:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: na46bwCsOToYUsvwYNe60pK0uPThEu550RBxGCGYRXw8gGvi2IxQe+Dj8YUezLg2hj1z+G0ravilyYW6qGQjmq1t/zcWoXODpPeUgI0C7Ka0yvW5hBcAt6N19pLO9V9QBWPR7tX0MmT223dvLeUCTsI4wORisGhQ9BrKqXNSsfgPgXmX41JP+FRtrlP/YUyPH3lbNVhMNiS+DELl0yPaZ2elf/8sMGsFpI3wEag8lJrzG7hLZthIh4pZ7ugGShj2xdygFzKj1vTKVzIa1BNomlZSZDCW0WQI56qE+ediWNerL6iiSNCjrjqnE2dAS99Dv1Kfd5zfH7XNlYt4sVowfbY5iTzecCik6sT5dVNdCYzZ+x1RuGWo8SclR3Z4u1GJgwZ4WXp8iXMFESUG2oF/UyIrAXKTQFOBrcv+gRG6oZAAJJbuK3uvareM5z8/g9VCPQ2PzFLgpkXI7f2p4wmV9UOPHqX0xxOyNnENPwc/VOcOH8AIE5873q54urmq2mdtLqkMcG4yZXE/sywwlCpGN+B3U+IH93RPUJSO4bf0UniksmyIj3rW9k0iNY53KlDkD1E0kZcicICAQ9NmN6DLWW9M+tICH4os6GnkeCAhk1wAEzr8cYHSRSLar/Tm3LpHAmcuKSukcN2gOs8jY7twpvtZITURPS80e0I7wMs0LWZYUIGHwsSqJM+kqyHLY6jVrN7INd7e1pKXTKvOhVRm7xERQXrg3FZ5sWqYBTEaOWZzEUQGV81ax0PdiTZorUSpQ0wiq+WhOdcU5M5w14lJU1qjLGkkTyrJGWSHSXb5DSijjTT6ToVBfOP2ypPtwOYxNX0+uYC3KMW7UGRYFz0JKaSFUk4WCMbkNMVJGmO2+nkl4bynDbAEHZ9DVdXQEBxH
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(376002)(39860400002)(40470700004)(46966006)(36840700001)(4326008)(86362001)(8936002)(8676002)(31696002)(70206006)(5660300002)(40460700003)(70586007)(316002)(356005)(53546011)(16576012)(82740400003)(54906003)(36756003)(31686004)(44832011)(26005)(107886003)(186003)(426003)(110136005)(2616005)(41300700001)(81166007)(36860700001)(478600001)(82310400005)(16526019)(336012)(83380400001)(2906002)(40480700001)(47076005)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 12:10:05.8696
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 016a472a-25ce-4021-8e67-08da6a48c8b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1322
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/22 11:35, Krzysztof Kozlowski wrote:
> On 20/07/2022 10:26, Michal Simek wrote:
>>
>>
>> On 7/20/22 08:15, Krzysztof Kozlowski wrote:
>>> On 20/07/2022 08:00, Appana Durga Kedareswara rao wrote:
>>>> From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
>>>>
>>>> The Triple Modular Redundancy(TMR) Inject core provides functional fault
>>>> injection by changing selected MicroBlaze instructions, which provides the
>>>> possibility to verify that the TMR subsystem error detection and fault
>>>> recovery logic is working properly.
>>>>
>>>> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
>>>> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
>>>
>>> Keep only one SoB.
>>
>> nit: First of all it is from xilinx.com that's why xilinx.com should be the first.
>>
>> Just for my understanding about guidance here.
>> Code was developed by Xilinx before acquisition with AMD. And because it was
>> picked from vendor tree origin xilinx.com was there to keep origin author there.
>> And upstreaming is done by new company. I can't see nothing wrong on keeping
>> both emails there but that's why my opinion. Definitely not a problem to remove
>> one of them but wanted to make sure that we do it properly for all our submissions.
> 
> It's the same person. No need for two SoBs from the same person. Since
> AMD acquired Xilinx, it holds all copyrights thus @amd.com person does
> not have to include previous SoB. He/She/They has the permission from
> employer to submit it. The second SoB is just redundant - brings no
> actual information. Otherwise please tell me which piece of DCO the
> additional SoB adds/solves (comparing to single SoB - @amd.com)?

ok. It means enough to choose one now. I am aware about some IT issues in 
progress that's why that patches can come from xilinx.com or amd.com for some 
time time.
Kedar: please just choose one.


> Similarly when you change jobs while resending your patch - you do not
> add new SoB but just keep SoB from @previous-company.com.

IMHO That would be more questionable when you create changes in origin series 
and new employer pays you to do the work.

If it is 3rd party company picking series where upstreaming is not finished you 
will expect that 3rd party will add their sob lines there too.

Thanks,
Michal
