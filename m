Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADC8524064
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 00:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348881AbiEKWsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 18:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbiEKWsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 18:48:43 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BE65B891
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:48:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8Xk9gIcOP+T2GMoICZJRYQ0qONdrHTil5sHQD+tcKlwMShCqtKrgBXcoAUeUDWPhbG6tH1gvMNebQWrjGTywavUGOXG1Wsm8MqHD384TKdSur/gb1kMC93N2Iqm6Lce4sfYD3gZKc+0ua3tM0Em0RwN6CVj2ybQnid7vyAtICYZxiqI8zwnkMX5EmQZwL7XbpC6DF6qM2Slrp68LbDTg1AIxlcZoWEW7HI7Iryn+Lvl8Gf4axM4NlqZgFt6ugwcx1fCb8NgudneVao4R9ID015LBs167RQjYLQ/NnnE+Sbr+7VzBT68z3Yi+kXb7iifZFv0yvUxrow6NyPK3EIesQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9WZSN/t4dDlb1Y/mG8XSSIubWT9jnrdKPZ5XAIcKpY=;
 b=Tj4bqq2SRT+b0plR0BJRxLHXPZ7txMNCli4/T/5ps/jMi03JeYG1xA0sk/OMjqXu97LXyilUE1ZRWz7r/BYbsF4+nF28nJRaez0uN1Z9IYcC7/YBnJxMvu7Ak1J+C84G4LP1815H6mPpquk0BlFDMBypcXk7KLTTFVNrj2KvYhG4X3GVY2A9w3LlqRQFYuS+nYSn193Bw1acD72dNHIUELAePXCi+9Qs44/eMwiOzFlEKd2asmyWwpuVnFZH78EeXlTrlONZcV7vKNoYPPTEp7bbwFTv1DV7vLqv3aQrBFFJCaIgto4IwuEs2wy/NvWqdE4pgW0Kj0OTR0Q9IyqfTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9WZSN/t4dDlb1Y/mG8XSSIubWT9jnrdKPZ5XAIcKpY=;
 b=bV4VwQmu/M4IV+arPEnI7gRACKIu0/FSCvzvcJ6eMMIn64mHREU1y03XVhtOcGDz2xpgnlbwL9l1nVzt+YznzSoX7dwj3TvsaIyQyIL8J/MrLVlPxojKJftrPi0qf0Eh5Uy2MVQIB3f92vfGkniNJiJEH1sU1RmZovNCZmK9St56swPhFj/NV9NguoxpKtskaMbYaiE/gy0THZGMVCNDyyF4RmccsdNk0PJZ43DJ5mR6HJbgPN8z/VaWwG0V/HjhcJwDay+sWD8GwIkfohjOmxiLK/pITavR0RoY7jIy49fD81Yl7zED8r0w3BoBERNcNMdlm7FD/v67MrjfZLW6eQ==
Received: from MW4PR03CA0332.namprd03.prod.outlook.com (2603:10b6:303:dc::7)
 by BY5PR12MB4211.namprd12.prod.outlook.com (2603:10b6:a03:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 22:48:37 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::83) by MW4PR03CA0332.outlook.office365.com
 (2603:10b6:303:dc::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Wed, 11 May 2022 22:48:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 22:48:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 11 May
 2022 22:48:36 +0000
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 11 May
 2022 15:48:36 -0700
Message-ID: <f7bcda22-8ffe-67be-36bc-fcde58d8884a@nvidia.com>
Date:   Wed, 11 May 2022 15:49:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
References: <20220510211743.95831-1-minchan@kernel.org>
 <857d21da-5de2-fa3e-b1ce-41cc1cfb0191@nvidia.com>
 <Ynr10y6pkH6WwbQo@google.com>
 <bb6e76f1-2cbc-893d-c8ab-3ecd3fcae2a5@nvidia.com>
 <Ynr+wTCQpyh8+vOD@google.com>
 <2ffa7670-04ea-bb28-28f8-93a9b9eea7e8@nvidia.com>
 <YnwupNzDNv7IbjRQ@google.com>
 <54b5d177-f2f4-cef2-3a68-cd3b0b276f86@nvidia.com>
 <Ynw6mauQuNhrOAHy@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Ynw6mauQuNhrOAHy@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adf4596c-c6a4-4a23-dac9-08da33a062f8
X-MS-TrafficTypeDiagnostic: BY5PR12MB4211:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB421129B69FF47515C83FE75EA8C89@BY5PR12MB4211.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sW/Zdsm6yhXcWRVCzKV8kmrSggfDX4XJzqUHAV2Sf27ulFJtRKlW297lSheEr4WYWQ89obDapz+hwMu/tztbOebF9axLt2pHNbuhfiK9i8zEcALPcam76qNsZng/ENR4j4QGM1KRyTjuGC0o0oWWVeRhGrxwiDgh55Y5yJdweVXWLULHzg6KMFkLj/t65JE1IPM7Da4uXz+MXgZ63fvv1t1l3bSnAQH6KGtuDVPN8l8SCBL3YfQitrE1GzhfG3b1wb58xaxjEsfVXM2syVK8L5l1x2YcmLlFg2vebtlTAvOoEva77eqW6W5yjUZkWfOueAzcevIDgQUqC2DhjR3FPVqZ0DG5c0Yl0VMC41AB6aRYbLXb03sEtCawjnoewh2PMY9U/lfGDxTflQwnRLwr/+iETd+ewnUA1cLuDZvkR0rAMh08wdMQQyoJ6cCuHXeHBudyURdcLYSWN9I2qlAaY7lUDgnrkngo8demNDhaQFDBS9eSwLqscxzt4jC4fgz7mBZNj6KdnmlNghio+6l77XRHHUxjuKgPSC9a/r5PPuZkOSkzpWJDSsNned0UGkawx8utl7JWaToVrJEn6O0Qh10UdrEySIKDnY5ZRi6PptoYOzL4XDiGklsTQu6UfWzypn8TWIfKEUrIZJodYbA3qBTCXM8nI+cdbiFD0qX9ZtHDsDWF6BsRu1xpR2XCIuDRfHc25c2fXdxjxUyvMPQPwn2wWSJV2SwMK7G+LwfUKzQdd44dWw8h5MMfcYiGx8Md
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36860700001)(31696002)(2906002)(86362001)(36756003)(6916009)(26005)(70586007)(40460700003)(53546011)(82310400005)(2616005)(316002)(54906003)(31686004)(16576012)(47076005)(336012)(426003)(16526019)(186003)(4326008)(8676002)(70206006)(6666004)(81166007)(356005)(508600001)(5660300002)(8936002)(83380400001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 22:48:37.3512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adf4596c-c6a4-4a23-dac9-08da33a062f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4211
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/22 15:37, Minchan Kim wrote:
>> Yes. But one thing that is still unanswered, that I think you can
>> answer, is: even if the compiler *did* re-read the mt variable, what
>> problems could that cause? I claim "no problems", because there is
>> no combination of 0, _CMA, _ISOLATE, _CMA|ISOLATE that will cause
>> problems here.
> 
> What scenario I am concerning with __READ_ONCE so compiler
> inlining get_pageblock_migratetype two times are
> 
>          CPU 0                                                       CPU 1
>                                                                  alloc_contig_range
> is_pinnable_page                                                start_isolate_page_range
>                                                                    set_pageblock_migratetype(MIGRATE_ISOLATE)
>     if (get_pageeblock_migratetype(page) == MIGRATE_CMA)
>         so it's false
>                                                                  undo:
>                                                                    set_pageblock_migratetype(MIGRATE_CMA)
>       
>     if (get_pageeblock_migratetype(page) == MIGRATE_ISOLATE)
>         so it's false
> 
> In the end, CMA memory would be pinned by CPU 0 process
> so CMA allocation keep failed until the process release the
> refcount.
> 

OK, so the code checks the wrong item each time. But the code really
only needs to know "is either _CMA or _ISOLATE set?". And so you
can just sidestep the entire question by writing it like this:

int mt = get_pageblock_migratetype(page);

if (mt & (MIGRATE_ISOLATE | MIGRATE_CMA))
	return false;


...yes?

thanks,
-- 
John Hubbard
NVIDIA
