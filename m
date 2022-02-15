Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDB84B6308
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 06:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbiBOFqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 00:46:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiBOFqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:46:17 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631D077A8E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:46:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJ5FFr7UcxBAs2OQF9uHcomIN5xReB5Wh9HdacjIfxcSSAWF+RjAvoOBvXePGc7RTgPXcldKPU34VsjGQDSXEHbef7cg9+idAM6JaPxFR/Bhf4WR1/8Ib+OAzNWr2BCT1MAFJt/sIYuX9gyY7JcCuYHJP2yQ+6R5F1hIujcV4kFec28l+orVbOTGzX/EbEP3XJcn2wq9WIw8Q0MuoyW0F9VOzl/471FnDTx6IIHCePt1e8SV3KPbJDSykRP3BR5+WdXstnAtqQiGFSCHJA/2b9Jn331/y8Pr8NFb40rMqFai4/vv/ULUJsiI94emMtL//i3HDwKLA7xkzhM68rwdHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXEV1RHpfVoM4n+frBsDN+FosRYf1a9MWcZY+1U4rh0=;
 b=oC7X7EOk436nvHJX4e6OecV6Vd50hp1HjkBZi3+7FxwtGrwpH53she9Pc+axY7tGGH8Eo/I/ufS/bUyBfYtEADjUddCU72DDWUo4WXKHDXu6ZY3BjNZcds03K1LOBeZldqsAPyKOt6ohQZ+bXFhLzHOspSVZwTkT/m5CzbuwA5iAG3PZHkUxq8+/z8axb2dVNZz7jNsXN8pGvU57xspQm5GX66b56sdburCGwVsWfTFVABrstaWUDbDX3bpOerIO5+1Uwjfnk25Fd9BxRhJIweonuTEHgU3MYdz1ruGKJ6STwSE5Hmnsc23hCJjpV576vrwQQIkpfcEtPkML099XGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXEV1RHpfVoM4n+frBsDN+FosRYf1a9MWcZY+1U4rh0=;
 b=p1ZcrmWApQVcgMY0kpYONLTkgYg65YIAwxImkfYY8zvWSScsLlyZSwdQMhg6T6+Yc7cLlAYhlLDN34Wo+0znJeKBjayHxEoGduj9Zg/z9D3pMI5mxN+FNUCnH1SaUU3SniLQ0BTLEpk1eIhGSrGoS6QVJL9+TDVK3Rf0GTpVM/va/u8sAvB4aV8ArzAq6Bka3/EcDmrXPoDqpGRKmU9GLSUHoH51P5ivnfXEOkDkpkHNAcF4yBr07rl4y+c8gAfhGwbv1yWAqDVychrDHRec+0H34U7duxtIdT9wSD1a3Kaxzgwd/s+2cUgmeVumjxyqpdQ5JqK/7o7PZq8B7LS3xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 05:46:02 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::1528:82a2:aa0:7aa6]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::1528:82a2:aa0:7aa6%6]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 05:46:02 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     akpm@linux-foundation.org, jhubbard@nvidia.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ziy@nvidia.com
Subject: Re: [PATCH] mm/pages_alloc.c: Don't create ZONE_MOVABLE beyond the
 end of a node
Date:   Tue, 15 Feb 2022 16:16:28 +1100
References: <20220215025831.2113067-1-apopple@nvidia.com>
 <7b752e06-f345-cbb2-d05c-57e5fc5d8e5a@arm.com>
User-agent: mu4e 1.6.9; emacs 27.1
In-reply-to: <7b752e06-f345-cbb2-d05c-57e5fc5d8e5a@arm.com>
Message-ID: <87bkz8d6nc.fsf@nvdebian.thelocal>
Content-Type: multipart/mixed; boundary="=-=-="
X-ClientProxiedBy: BY3PR10CA0024.namprd10.prod.outlook.com
 (2603:10b6:a03:255::29) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 504d9b14-48c5-46dc-b962-08d9f046734c
X-MS-TrafficTypeDiagnostic: SA0PR12MB4461:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4461AD342355CE5ECD317F24DF349@SA0PR12MB4461.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m+WNKRICcDRPeXXmj3NFrRSfq9N1ME9H7sKUbvTobA7Lv758wMLwI6N0ic+JOO66RwauAddLDdzo2uXburJm6gm0kzaVaUdW55dTzWNJ+xSdwnur6NBkaBEpgOdXZY5okcRyap+Wjs5EV1uXY+TMiSHVhEVO4yJLR2WKZoG4fXP6/YwTVertGVVHOPK3UG5EBC0Z0dIlaAcE8fY/ePAey6nia0ureu4l2fDOLIIQKMq5cRx4yV1yuFGOtX07LR1Y7HeMMQJrGjnpgfBX6sTq9EZi9OsOomlstbs9Q/nxU/drTyPZb4AEYLQ0jYEUY/wdCxP6KfJG40Kul3ATtQhjPd+L1rH3X0Mfxuv3ttBUqFSvxXoLj2wlsXtLN5g3z+bmILlFNpK0TbCH4i5TKy879Q88Wz8y7hAgnwVtt/EGiXc3Y2mebXzZvO4Qpauc5fHW2qCMoOdAPEexF5mq6LrAeATPTirm5yuWtXUY5pRoi3mO98DgYTMPUI5ZZTIGtNXXu3Sw31nWm1WF00kje4YhuKfKPGIRH4NX4dv9Kz5hhJuUdfq8M71nQhTbpY95FEOaEgso7JaSyLPJuIIXleTS0dglKGLKlL6vZ8ZogCmPEIGevl624psubcgEMK3RSg5YYMtM1+F/ZZMGdqPqly+azw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(38100700002)(83380400001)(2906002)(186003)(8936002)(5660300002)(6486002)(44144004)(6506007)(66946007)(107886003)(66476007)(26005)(9686003)(6512007)(66556008)(8676002)(53546011)(508600001)(316002)(86362001)(6916009)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T7LwP2zCznkjM9YMEc1au/TMO7sZjl9oa1VQpb6S4ZS9ASVspkJhnYKBY3P/?=
 =?us-ascii?Q?CRO+glZ3sLdY4coP2r7LoL9v72c3wN0l6suPwaWdRipJKBIkH+GnA0Y1DjZL?=
 =?us-ascii?Q?aIKjaWJFKd/F9eMBPohb+TD0vGcuck0Pj3hHMUV4Q3xWzVqKiQ8xYEvM+54g?=
 =?us-ascii?Q?Yuie6FhULNohSSQGYpSbuo4kPjEfrEi9mtY9axtT7qtdsNBuPD35sfbKXCKZ?=
 =?us-ascii?Q?OwY1/jjV5OLpEA0Zrj/B0F/UIgCjUkxQCTYOQ7uY2ChhXReEis76Fyh/jTxJ?=
 =?us-ascii?Q?pY7Lov2/TN63ibuxmDUdwTef6A0kR72W3yJkDtVHTJYyNdL4zogKnClgdPlN?=
 =?us-ascii?Q?/QDE6RsNbszfLkVzJVBQiizhFoV2SnfGesYeFb+WjFWcoQGab5vu8SEB3mRV?=
 =?us-ascii?Q?65RpZhEWDUAffZAiErvFtLFfBkHLxK2dGoluc23D+UmjeCeV8ReIW+WqFyeo?=
 =?us-ascii?Q?YGhfMhyr5NQdhhfjmjPMeK+ets81GNQUiUAF2lxNoW839wKykRZKXRPCZZdG?=
 =?us-ascii?Q?JFkskcN7GH5QSa1bHLlExw/83JS/SDzmKcjqBTT9FyeY6zyYElHm542pKqF2?=
 =?us-ascii?Q?8rfdhtxuRzKWZILdMB8LTyltU6bUc3HupAZbO6788fKQsfnRWmcbziWjnoC/?=
 =?us-ascii?Q?HQJ5iC8NpJZp6a6VcUIkvnkz1Es1AWLIA+I57V1/IJgPR0oEA7R1TfPnaXGD?=
 =?us-ascii?Q?QO7hF+SMOw0Z5KuErIFprqLyjYND15aeHK0yFrn0BvAjv+Y7w5aXB30Mv9Xn?=
 =?us-ascii?Q?/D/0c6UecXnVqPknU2JhUZ+nm83vXplarUpiZyTsZqGHT3GPhoMHs6y655Ap?=
 =?us-ascii?Q?NY9+TWglYBhoQivNT1JuW0N89C5gRHDhSYnYfvRo8nrgTpCkE7vSP+5uFef1?=
 =?us-ascii?Q?aH40lk7V5dRkhGwL+n+uw0XtmvXiokIG7qZG+YV2DEG6TyktRHX4mwRU9MVI?=
 =?us-ascii?Q?LntTIMhq6JkCPH8daWmn83mQbZ845iaHQKR2UdwbYyfe7dlN/c5H1VHZu8Z9?=
 =?us-ascii?Q?9lWV5Z8LWkyxj+njRleHSEKPZizJAc2gEEJzKr0ocgOt3nN7wMNehuxEvYzs?=
 =?us-ascii?Q?3+MLyJMupuRWKH9PyfZQi/bc/AvJUN1PdXBLTarvBj5fRX0mGe2G8qiYn5Dx?=
 =?us-ascii?Q?2P3VqIlPh7hr2W8yYP8LywJhbfYN17NtzSCBTDKxB6cJm6hq22jDBS1nGBRl?=
 =?us-ascii?Q?0hLC7DYNFF3JKl8Dfnsl8oDJfOTCnXVECZKvvZcwtbj4FkZHZhhiVzT1Sq2x?=
 =?us-ascii?Q?/ZsV6lCHxWkyYPj8bzTu+7++xklAHTM8QDxHE+kOGlcBb/8i5md2w2uCalgk?=
 =?us-ascii?Q?XvfRc4EXuY5/WFyI5f0GHee0txTqy6gR8FHH+QgmuWJi6bODIfCs6WNBxk6G?=
 =?us-ascii?Q?u0LzB88gZYi6mc9Yzwq2VuG4qwLVW6tW5o5SbL1lF4rlvAdiVmnIdUjG0oCK?=
 =?us-ascii?Q?WFHCaQMluWnztCqB+ImWaF95IekHQyew33oW6bwRJQtNhuDZ1LgnKyF3zf3B?=
 =?us-ascii?Q?FBMY2wGqQWFk2TRqOLO48Knw0nBeskoFZytXX0WZIZcmR8tBfDI4wVWepmbR?=
 =?us-ascii?Q?1icOJ/muzH3mf5RfvC23ysxKsXOhcpSMZESMJ8t9X0wdbSHQ5G8fgkYKvUUY?=
 =?us-ascii?Q?yGT7mSAKM5lrwq6fUoCJ9oM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 504d9b14-48c5-46dc-b962-08d9f046734c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 05:46:02.5233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +QxQ97kQCan1dxGJeIWBbabaX/aqRQgacQbIKzULfP4HzzMn2TSpRfykIZ7OGBsJwxgQGKGFEBT4+M/rQPi/2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4461
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Disposition: inline

Anshuman Khandual <anshuman.khandual@arm.com> writes:

> Hi Alistair,
>
> On 2/15/22 8:28 AM, Alistair Popple wrote:
>> ZONE_MOVABLE uses the remaining memory in each node. It's starting pfn
>> is also aligned to MAX_ORDER_NR_PAGES. It is possible for the remaining
>> memory in a node to be less than MAX_ORDER_NR_PAGES, meaning there is
>> not enough room for ZONE_MOVABLE on that node.
>
> How plausible is this scenario on normal systems ?

Probably not very. I happened to run into this on my development/test x86 VM
which has 8GB and was booted with `numa=fake=4 kernelcore=60%` but in theory I
guess any system that has a node with less than MAX_ORDER_NR_PAGES left over for
ZONE_MOVABLE may be susceptible.

This was the RAM map:

[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ffddfff] usable
[    0.000000] BIOS-e820: [mem 0x000000007ffde000-0x000000007fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000b0000000-0x00000000bfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000027fffffff] usable

[...]

[    0.065897] Early memory node ranges
[    0.065898]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.065900]   node   0: [mem 0x0000000000100000-0x000000007ffddfff]
[    0.065902]   node   1: [mem 0x0000000100000000-0x000000017fffffff]
[    0.065904]   node   2: [mem 0x0000000180000000-0x00000001ffffffff]
[    0.065906]   node   3: [mem 0x0000000200000000-0x000000027fffffff]

Note the reserved range from 0x000000007ffde000 to 0x000000007fffffff resulting
in node-0 ending at 0x000000007ffddfff.

> Should not the node always contain MAX_ORDER_NR_PAGES aligned pages ? Also all
> zones which get created from that node should also be MAX_ORDER_NR_PAGES
> aligned ?

I'm not sure why that would be case given page size and MAX_ORDER_NR_PAGES can
be set via a kernel configuration parameter. Obviously it wasn't the case here
or this situation would not arise. That said I don't know this code well, and
this was where I decided to stop shaving this yak so it's possible there is an
even deeper underlying issue.

Either way I don't *think* the fix should introduce any problems as it shouldn't
do anything unless you were going to hit this issue anyway (which took sometime
to track down as the cause wasn't obvious).

> I am just curious how a node could end up being like this.

- Anshuman

--=-=-=--
