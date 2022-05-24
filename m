Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0266153216C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 05:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbiEXCzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbiEXCy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:54:57 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804A2719E8
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 19:54:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsZnycwkb466/pdIM2SiWNYtulEi33KUEkw4aece9Ej1kcANvfKHMtFItYGZVKCnb0FetBIf9teLddizKlRgJcBCiDcWCjhToGIDvofWHfTyb4O7fXWnwUYjJ31dGKp9pYGcq/Y9R4qhgnJh8lmPMCT2SYEm5KvM6q0HoUeQvQyCImoIXr5PXfvd8fDnvEPOMDdOwQQhC1co36+bELQjEmSP9rIMZ0nmJ62OoVJwhD3swF167KRDic4wKpW6RASByfvTJKf+nQaxTCfVvbwgcdBX2Id569CNeFvqzpHGFooFAst/bNCMpioHNmJFFT+rSZmkbGEy9fLFcHFt1mMsNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruo/Uf2OxRQFJDCR/VOw85TD3DsMqXrli8pKXhbkT4o=;
 b=aTK6+b6aBloon8yNmFqA886CSvsIAZGeuPhV1IYi6d8fu42D0//FHXPOAVW4CShkztyrre9DdSlV6AQFxIGHrvGE5KeKBdRAUA9RQ4aOlhkh6Ea0C+b+zruGUUkaiioXlnhRysPvpYiZQBQI6q2JdNTxj0Pvq/IzAPLDcup9dAw8XnNqkQOaad4MbZZbfqpHaZzubxmZfEZYh+f9Y70SCkfPSfSoRNeNMk8gZW6zJgwSlaxVLervG8dg4VRfaJ06yvC61ZDPdTL5hYyr42icVbtcr3LjMHcptGsCZDxCgEhLb/yMWTbTft6tEFa5CpxxnZZVit0POCtMhvagHH9kng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruo/Uf2OxRQFJDCR/VOw85TD3DsMqXrli8pKXhbkT4o=;
 b=OixjFdiy/GkVusfHoZWgC7B+fzEg65+7/HdtbZhcjauK1PXy33K/FOEqyYE258qE8kja6Qhz5TdBk1S3mtJU0SJBHEwB5nvDXei83p4dcI/lNT+GbQZCxK8qAJADNeUTHXDDqwoVe+taRC48DKrqvoNhUkN9RAcX82R7iODixEJHwB0yXAnwVDZeRQxL4C/3M1yfSyfsO52uNenr6jv7o/+LpTVdSgPmWDCoo43Clf946BRYISgcCiLwAFB9WHr36eo4zJt5D2XoRdt8/4vmfW1Fb87COX4HgdjdF/4kYAbpT+XrVoTQDqqeyikqlA4HEup5OHxYDBFZICmAeJEjHA==
Received: from DM5PR06CA0074.namprd06.prod.outlook.com (2603:10b6:3:4::12) by
 BN6PR12MB1330.namprd12.prod.outlook.com (2603:10b6:404:1e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Tue, 24 May 2022 02:54:53 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::62) by DM5PR06CA0074.outlook.office365.com
 (2603:10b6:3:4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.18 via Frontend
 Transport; Tue, 24 May 2022 02:54:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5273.14 via Frontend Transport; Tue, 24 May 2022 02:54:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 24 May
 2022 02:54:53 +0000
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 23 May
 2022 19:54:49 -0700
Message-ID: <bcb95d6b-4507-8836-cf17-7c3cd179a3da@nvidia.com>
Date:   Mon, 23 May 2022 19:55:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        "David Hildenbrand" <david@redhat.com>
References: <f7ff4186-e629-a5da-3f4d-ec629b0c8dd9@nvidia.com>
 <20220512004949.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnxczoehQJ+x6m9Y@google.com>
 <0accce46-fac6-cdfb-db7f-d08396bf9d35@nvidia.com>
 <aafc0954-80df-dceb-03f2-2caea29cbbda@nvidia.com>
 <YnyCqwY4DxcZ/NjM@google.com> <20220517140049.GF63055@ziepe.ca>
 <ef901bdb-6117-bad4-2f26-c80df270b86e@nvidia.com>
 <20220517192825.GM63055@ziepe.ca>
 <b6eef200-43d1-7913-21ed-176b05fcb4fe@nvidia.com>
 <You3Q/VFaCoS0mC8@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <You3Q/VFaCoS0mC8@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73185555-5813-4bf4-96c7-08da3d30c74a
X-MS-TrafficTypeDiagnostic: BN6PR12MB1330:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1330E5CD92B44C80FD60063CA8D79@BN6PR12MB1330.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NMC5QG1qe5ssgUD+4MCCl1aMN6m8W4dZujI3pbARX60Rj7qTRWrfd+kRpvsIffIq79ZozLDqixhi+tFT+0nPubngyLSeGfpw/L7zrngvP2wHk3H4oYvNo7BsEXq9PhjiYAnENUUr54/qEvlaDj3HHvLQA4N/27Y5lTozk6Sxj1N6U/oJJEmuzIXwbCFHeRvW4inlUNxw7iUoKwIj30i5W9c+HEJW5mALGzjRgG0jp1hoziSgPcgE6N/sA/5hkTYk9/6WPPqO1+ZCOSdbIOPW+ivuEwegC5Z7dBT9VQZHfQL4exkquUnGOAZ28b0PDp0e+ZuPqCJ/OfPYdfU5RaqQKGcvWxSbXgSpShqkhWNNjhRfzlnwEXvu7XkErtlhSjj0fipubZVhjjAVu9brJw5M3nqqM7DgfLg0/xhcJj3MuEa+qLYT/4BcirF+tASLH8O3e9VOz3EocEEZNgz3c8yOpaGxf8ZD7d634qDBrxg2HiUIGFGdJEOiYHS2sWsFfxHdl7abS0k+BbX0tTL88w/xhDFOtltxbPvBKPtR3jXey+Y8z9l2xmpUciMab21pjhO2DUSZJ+gC2krkBsEF8mN16EcrhLsjqXGYMltUw53Ts6U4ED7n6lYaCNCFQy2/1Y5Vuu6tr6SjWrK5OcDl4EDpqJMexkyTq1VoSubF4e25IHYPMDWwgSH6xw2V+oBIHpDsCIm9B5jEd5fN4+URVkl7bjgJWEj4wz3YboYvNQ5HnZXP9mJ+TCfjNB8HBqQuHgUK
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(4326008)(16576012)(5660300002)(82310400005)(2906002)(8936002)(26005)(53546011)(54906003)(36756003)(6666004)(316002)(70206006)(31686004)(8676002)(70586007)(508600001)(36860700001)(86362001)(6916009)(47076005)(336012)(16526019)(2616005)(426003)(186003)(40460700003)(83380400001)(31696002)(81166007)(356005)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 02:54:53.6531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73185555-5813-4bf4-96c7-08da3d30c74a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1330
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/22 09:33, Minchan Kim wrote:
...
>> So then:
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 0e42038382c1..b404f87e2682 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -482,7 +482,12 @@ unsigned long __get_pfnblock_flags_mask(const struct page *page,
>>          word_bitidx = bitidx / BITS_PER_LONG;
>>          bitidx &= (BITS_PER_LONG-1);
>>
>> -       word = bitmap[word_bitidx];
>> +       /*
>> +        * This races, without locks, with set_pageblock_migratetype(). Ensure
>                                                   
>                                               set_pfnblock_flags_mask would be better?
>                            
>> +        * a consistent (non-tearing) read of the memory array, so that results,
> 
> Thanks for proceeding and suggestion, John.
> 
> IIUC, the load tearing wouldn't be an issue since [1] fixed the issue.

Did it? [1] fixed something, but I'm not sure we can claim that that
code is now safe against tearing in all possible cases, especially given
the recent discussion here. Specifically, having this code do a read,
then follow that up with calculations, seems correct. Anything else is
sketchy...

> 
> The concern in our dicussion was aggressive compiler(e.g., LTO) or code refactoring
> to make the code inline in *future* could potentially cause forcing refetching(i.e.,
> re-read) tie bitmap[word_bitidx].
> 
> If so, shouldn't the comment be the one you helped before?

Well, maybe updated to something like this?

/*
  * This races, without locks, with set_pageblock_migratetype(). Ensure
  * a consistent (non-tearing) read of the memory array, so that results,
  * even though racy, are not corrupted--even if this function is
  * refactored and/or inlined.
  */



thanks,
-- 
John Hubbard
NVIDIA
