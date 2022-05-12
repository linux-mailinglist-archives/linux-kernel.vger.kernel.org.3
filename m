Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C767524264
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 04:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238995AbiELCSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 22:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237173AbiELCSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 22:18:32 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F79522EF
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 19:18:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vsuli8HsRRSkxINRhzLzasGS838f9LZSdPKJCiD1iQAlWWR2do7Zgcu0cD+StP/zHVy98Eu0hry7q82gggjl3n6Qn1Jqp2lmmqvT1FGXuBs5idWIoimScVwj/woyfZCgN9pVsdhxzueq/rdmI7dh8fdM1Ypibe8ROou1JKZlQ7hNUD31bGL16cQUu29PfZpw+OqY3M300AtQA53fv3yh202XmRvymaS9dPwP1U/s1gpstVGi8pXT6SuE4M+yn0bCnX6zeZ6hlScLptIOW21fjHfTHiOwZXNVaIDKZ1C3GRtlfmahRJePoKX8NdBfi0PT9qFIfdMx7q+S3iEzlORxWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mtlkk+qDPndgD1zxu1kNECUuIbt0l9Wi3NPTjGwZo2Y=;
 b=mF/o0OHCQts3gvcUl3TdJLWSLCciKTgBsgv3AJSJww39GLg3s3LlpxWOFBVmZIxdhqY4RrLfuQMuPEb2rtAVCs6hveakHfUrZY6vwRBwKER/fgSoVLrdYK+OFtC2cTbOxtukLKKaLUCZ2QtQf2fk59N06/4WTGJWjlQ54IhGJwpLk9YSWSUtlwMGUlEiMeJiJ+GCc+Tl7hKxXXmvaptDk+ZGZiPZ6FzLhNeTixZ0cKOjNLseO9pIhAUdZTRYSM9rWH4GatOJUwCfkI9MJRAKl6v9E0rwvZqdovQtzhQeKYxtSqwDC3YgUu7Jz86p18PtmaGazf2HtZevG/ClzZRUow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mtlkk+qDPndgD1zxu1kNECUuIbt0l9Wi3NPTjGwZo2Y=;
 b=FMHSa4PjWQSjef6k9IMTHS+uSTeehMdbhwCwVh0t/1Y3ZrZk9Kc3YnIrnf/JUR7WBWPLcI8SuUc+bc0o/prNuy3dRYg1feVkXutP5XngDhC4q/V2z+kuymoQTallu8Hfc6Xont3wxeCKDS+UxpBYpnm4M/+LCgiyuVdQChYgY5T/ZHuqOdduGLQLEk70tl+eH3VA/Sc6+GTAwj+ZPDJ3E7f87pXosJvhGSB27uN/0Ecq+ts4ZsgnHYFSYb+pVopRaWGm9u+nUvzw0xcAaYKfpwcl2og7iKdO4J+mxeHnoMsYqe07WA/I2O3b5IklFR/gyZIOF1Ozxt+gY2RtL3GhwQ==
Received: from DM6PR02CA0154.namprd02.prod.outlook.com (2603:10b6:5:332::21)
 by BL0PR12MB2465.namprd12.prod.outlook.com (2603:10b6:207:45::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Thu, 12 May
 2022 02:18:28 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::c6) by DM6PR02CA0154.outlook.office365.com
 (2603:10b6:5:332::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Thu, 12 May 2022 02:18:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 02:18:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 12 May
 2022 02:18:27 +0000
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 11 May
 2022 19:18:26 -0700
Message-ID: <aafc0954-80df-dceb-03f2-2caea29cbbda@nvidia.com>
Date:   Wed, 11 May 2022 19:18:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Content-Language: en-US
From:   John Hubbard <jhubbard@nvidia.com>
To:     Minchan Kim <minchan@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        "David Hildenbrand" <david@redhat.com>
References: <f7bcda22-8ffe-67be-36bc-fcde58d8884a@nvidia.com>
 <YnxCCPZUfgQNXSg6@google.com>
 <8f083802-7ab0-15ec-b37d-bc9471eea0b1@nvidia.com>
 <20220511234534.GG1790663@paulmck-ThinkPad-P17-Gen-1>
 <ea64b36c-ecc1-74db-dd2e-909e7e507ef8@nvidia.com>
 <0d90390c-3624-4f93-f8bd-fb29e92237d3@nvidia.com>
 <20220512002207.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnxUTxnCJ6EsmjEi@google.com>
 <f7ff4186-e629-a5da-3f4d-ec629b0c8dd9@nvidia.com>
 <20220512004949.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnxczoehQJ+x6m9Y@google.com>
 <0accce46-fac6-cdfb-db7f-d08396bf9d35@nvidia.com>
In-Reply-To: <0accce46-fac6-cdfb-db7f-d08396bf9d35@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 646e9b34-88e3-4b67-6c14-08da33bdb390
X-MS-TrafficTypeDiagnostic: BL0PR12MB2465:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB24656000174C2FF583521259A8CB9@BL0PR12MB2465.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n2I0+Psq4MtxURfbtKEXaps5TPYIcZNYFFPKHJ76Du5ujRmmdgcJnNASPx5mOjzstB/t65k/ApWVUFPCWp78Ad29As7ZRxk4a780Q/dBCfnv/8dmlUM0ERIOM9/NwfjyaSalIFI8FNZcZ0SEayLUwTaBU8Z60JIQlkO62gGoti4ErDsrRII2bHs7ghh1qzDRwDp52wC4lU3JwWjDmOSofqIxyxIT7lqfA0TS1RzlPkjObTgeWZjEWjcaEGrbTE1yyTjJygo8wVNwpaALzvJRcABNXUfF2iJa37Bgk/DFZpAmvJ1YhuCQVo6zFDQyenxLOEL7t9lFDnejT1VP5hjAv7bRIOK5/iIzquOYn1YV0TqqadjyTGa8ysKOShT52SfNsB9weCxhiyh87wU6KST62L7s4Hi6xMTjIuubM0MQHa+x/k756kPuT9VgNT1ZjwlLK85UTSxOMPSSioD2G1hG27pd3v23r39wrIYwkDJ3GDk2YrGEX0u3EOcz8i8Gkrs3CyJ1oo4CLVKDobDSCZm6H7xHesVEVXX69AeMXffCHOtqx+MSYLBdRXJoNDddw/k4TA25AKj5aein3w3DKwwqPFtW/VnSa3G6RgkSu4SXc3A1Dj7twkI3opKC4m/AQeZtAgXXdADnXECutNALQUxkKQZdF+OI319mgqYlfIKhcLoeuBXnbUitgv3HTD93jp7vmsOIQKol8tjxf/4AOPbIQ7PHHFfv4sX8X5vy2EplFcAbW83zsO4aWDRfzSCEuqJE
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(4326008)(36860700001)(8676002)(2616005)(31696002)(5660300002)(86362001)(26005)(2906002)(53546011)(81166007)(6666004)(356005)(83380400001)(508600001)(16576012)(8936002)(316002)(47076005)(36756003)(16526019)(186003)(31686004)(70586007)(70206006)(82310400005)(110136005)(426003)(54906003)(336012)(40460700003)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 02:18:27.9674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 646e9b34-88e3-4b67-6c14-08da33bdb390
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2465
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

On 5/11/22 18:08, John Hubbard wrote:
> On 5/11/22 18:03, Minchan Kim wrote:
>>>
>>> Or there might be some code path that really hates a READ_ONCE() in
>>> that place.
>>
>> My worry about chaning __get_pfnblock_flags_mask is it's called
>> multiple hot places in mm codes so I didn't want to add overhead
>> to them.
> 
> ...unless it really does generate the same code as is already there,
> right? Let me check that real quick.
> 

It does change the generated code slightly. I don't know if this will
affect performance here or not. But just for completeness, here you go:

free_one_page() originally has this (just showing the changed parts):

     mov    0x8(%rdx,%rax,8),%rbx
     and    $0x3f,%ecx
     shr    %cl,%rbx
     and    $0x7,


And after applying this diff:

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0e42038382c1..df1f8e9a294f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -482,7 +482,7 @@ unsigned long __get_pfnblock_flags_mask(const struct 
page *page,
         word_bitidx = bitidx / BITS_PER_LONG;
         bitidx &= (BITS_PER_LONG-1);

-       word = bitmap[word_bitidx];
+       word = READ_ONCE(bitmap[word_bitidx]);
         return (word >> bitidx) & mask;
  }


...it now does an extra memory dereference:

     lea    0x8(%rdx,%rax,8),%rax
     and    $0x3f,%ecx
     mov    (%rax),%rbx
     shr    %cl,%rbx
     and    $0x7,%ebx


thanks,
-- 
John Hubbard
NVIDIA
