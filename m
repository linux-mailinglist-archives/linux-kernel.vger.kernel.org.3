Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE635066CE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349887AbiDSIWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245094AbiDSIWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:22:11 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0112AC4A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:19:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAPyJod9G7VwK9mTUyX5RxR3PIBrbIlND7rxbPRzMuXTL4OAQNNF6TI2eXeVlfvqvmngipQZXrMWlhBkj+O2Daa/E8Qern8KmXr3M8cLn0iLQI42U0/zQCxZoSjqdASsJb7yE3AOQZwi5weM/gPa75AsGvWvRPrCH9DFsSUBuWW3s6AgjEbZuB7Pa3wdiHQXcSajWTTsjNayRo5pt9zT3jFXHtNrtp+TtVxDQSihcB9YLq700+QZ0g893v62NhBReXpqQOsnjnlXM3cmRSDGGfgHN4OFlJ0ZftnRvxqmpPNyxipBsQ9GqFngGIbWlibBIQaTbxGenZxLwqrVHn3Pww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBJp9doRcmh/XO776tYS+etOqARcZCoJzfsNAz5BDO4=;
 b=Vwa6yzfLLAchM1hA61pWFucXBD75fPjag4EnCrMCtw6FL6fbhEGpJcfeL8oxHQ81ZtzHtUBLNcxwhgxmh017EPfs6nsxzEO0ehNinYeN8dXWIXiccVX5s1hYR/31jIIqqFPIfajQ32LURqmeXUGUZvcIwQZDp8nYbgvZBzQiMJo0LcZbgiM1eF6syVb8GIVzEf9XUwlGH19J4Hi/HH60BgBE1zVNRh3bsO0XRaqBJH6expKeT7/uaWIYUML7HXuQvdvMXXJSZyQFSrp7V+4zKpQWloBUGZTK8RXO0JoqI+C9NoJZA9IzgFTQDWstRcH08c11j3K+H3zeJqRbWABoHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBJp9doRcmh/XO776tYS+etOqARcZCoJzfsNAz5BDO4=;
 b=dPbAhGM/tXa8XiNsH8c3N5nj8ufTLct+0N8QDnt6Ht0H50oUk6JDgtIR9gQSPxNOUrZI7Kxbo2xyN3NNwST/qLoVqbznDJKuBp0/vPsUkmwSUTWjxRO/2y+QxiO/Dqtaqfn+Xx/++H6T4D2vxoFqVUpWl94KKjZvEOCHiz6um9Bf3ROIg5QQcqDP7fD4AyvkszCjIxq+N/eDZRYe81qwv8Qbcxi6UKWlV8ao6/BC11kCY8GP0cjiD9oJS1/crYk0XqcRLIztezt0VoqrBxHwf+ysXa7LFfQMuSGQAsdEv7k7RyE9s81qfuj/0CFIYntfnhBD7/6TdSdIANehy8AQnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Tue, 19 Apr
 2022 08:19:28 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18%6]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 08:19:28 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        willy@infradead.org, vbabka@suse.cz, dhowells@redhat.com,
        neilb@suse.de, surenb@google.com, minchan@kernel.org,
        peterx@redhat.com, sfr@canb.auug.org.au, rcampbell@nvidia.com,
        naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/swapfile: unuse_pte can map random data if swap
 read fails
Date:   Tue, 19 Apr 2022 18:08:38 +1000
References: <20220416030549.60559-1-linmiaohe@huawei.com>
 <87tuapk9n7.fsf@nvdebian.thelocal>
 <5a78dd68-343d-ac57-a698-2cfead8ee366@huawei.com>
 <72cfde7a-61d7-980c-4653-94ae83eb4257@redhat.com>
User-agent: mu4e 1.6.9; emacs 27.1
In-reply-to: <72cfde7a-61d7-980c-4653-94ae83eb4257@redhat.com>
Message-ID: <87pmldjxiq.fsf@nvdebian.thelocal>
Content-Type: multipart/mixed; boundary="=-=-="
X-ClientProxiedBy: SJ0PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::26) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 116f47e2-14b5-45a1-9c80-08da21dd5253
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2869FE4ACE2D4D85D0DB9672DFF29@BYAPR12MB2869.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2TXXp/Cm1+865oDnvqHedlaFUgmC9wAcNsDh3pEJhJwJIvroSDUeYSHqj1Y34dTBvsPP07sVvep0j4UN06MxG5fnqi7GUOOQOrroMUAt+LADQexuQep0k+t0GLVTIndknPZ85oNiL1TmoPGlqE35NOsYUP3LqnMjrawwENF2JxI4AOT12qUyhcPpPxbCL9b8m2LKirZExFAdNjvZCLkf6NKfZVb2rNwpSq6NPmPgecDO95NMiWtxS/4X6WzU/BRqOKQxWuXrV28d/JxBXAiSYrtL0+TsB6QQClN4OOo4ehfXFCHHiyEBOPbXogwuNTANmOvUbt564Fr5hcf/7xztymQwrkSz0RI3t71l/XtnrhnnIdse2nvsa/GF9vrwWkzlyUrrDFgegS/8OXk2NpfehuoHKWKm8bMzBtTTrGUjfM4clKa0gvTrCetgzywxnOUC3ja7pgr8dSeMO9L4N3yVVW2HNUjxvpKgKF3iejQ02b7kFyDsdCJgY0ECpSk8x20sMRd+/tyRHWi6h+2IZVMDWFwWWs/CIab0UXYAxTUu7JHHtKIp9sHHHB54UN2MQJ1lMekeCaiYXBzDZIecGxbXDT/LuXGyhO3x1YSnaW9qcbYJvXFvVL/1lxi/46FtX5u0hL1PCuRQlD0adi0xU66w1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(6666004)(44144004)(8676002)(66946007)(66476007)(6506007)(66556008)(7416002)(8936002)(5660300002)(316002)(6916009)(38100700002)(186003)(83380400001)(6486002)(53546011)(86362001)(4326008)(26005)(6512007)(9686003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KQ7yDg0tG/QdsfXq6/I+ZLhr1s6rFOY4gxiuVkBRG1vTipf0sQCQ8zWw/Joj?=
 =?us-ascii?Q?hmUmyv3bBsgfzOLKt2Jm6ubPt9cA63F3s0iJt/YwkxuQ1AdPsSjFwLrv2Gyy?=
 =?us-ascii?Q?6ES2g3ykO8NBSeHMmYuINBJ/OsJB5rvSUDCcM9WULGGyIPwnRvEjc5yXEDrc?=
 =?us-ascii?Q?gCK6bQEBadh90JLD0f+ID4bFgdGudp/THRfgKZ8PW0YFrbrBqGx/KYL3K/9l?=
 =?us-ascii?Q?3mKo6/NxDDF49YVg4p0HYnf5xZvid7eK/E4KEDxeTrRi1Btr+sTVc0Y+XjYi?=
 =?us-ascii?Q?QEZM6GFZPKYtHZ8RE5/u0E/WvK/3mPvkc06mD2zAAbkLL9imGSTGRiDrqO8N?=
 =?us-ascii?Q?ZPm50Ryz05zMQikTgB2Bx7XXO8fP8Ip4V/Eg3Jbij13zxsBKjt+mOz3ddnwK?=
 =?us-ascii?Q?XqtKwlL0wwywFcstU7GXC5GEoDAxp5E1ikGL/BjDyuwct3baUoYY0RsyCuJS?=
 =?us-ascii?Q?mHTmVMcNWf5x9yiG7ETorX7JPN5q3t15RslXPKrA43TEoicP8ym5ger6jOYy?=
 =?us-ascii?Q?rzl/fAxGfltiiR3ztHUhxAsu5vXhNSvhMaWuPfldAIFFnsSRbkUcJr9NqDQU?=
 =?us-ascii?Q?lKtjNYnRsiDdHqomkfJUGrExZ23Z0kXQwlT3ZHfmxOsaWpjk/D5Bi34pCovN?=
 =?us-ascii?Q?FHXMdl20xhCuL0lURDPwkeKdXyjlPY2X4s1DYRzRPkMjWkoiLXF4WjmYlSeb?=
 =?us-ascii?Q?aLJcMp4GYLE9bNAM87IBVbCQNsEC6W7wOHkmD61il5QLMDLVduNao/Q3TUf4?=
 =?us-ascii?Q?4bcP4veNCuRQJ3XsorIvWqvRcUGkm/IDDMr6Qs7ZYAA2dEGCUBaiRyRhwCVm?=
 =?us-ascii?Q?JmrosnaiJZl1y+km7QIaCfppS4Dj0aCL4c02y/vAkHAcSbTlTRDWcUXkiU7O?=
 =?us-ascii?Q?JhIJCDa2BLAotWX/kkIvaFsisxacni/vA/6Vm2PBetMBaB4SIrZB+CJIIh0c?=
 =?us-ascii?Q?2kA+Cg7gTN+u3zw6U03Z2HADPIwVtf2Bp+GdNAykOa2Cqir1d4nwhgid8RJJ?=
 =?us-ascii?Q?1Enr616Ef19Bc5jv3oQ7Q2G3Ljb4PaLKEnizSNkkputDPy9lYQiV+ijhOD0e?=
 =?us-ascii?Q?uwQPjSJ2Tw9Y4kLYNx9qWykiRl89KEDPkGjgHmOHa+8IPvh6X/rXWnGX921m?=
 =?us-ascii?Q?yaDSXleO+1EgA3HvkSUIoTMnaeadaW6kUrQ+AyuVQtFkcwB7Wd69wN0HLoYf?=
 =?us-ascii?Q?16qsBflr2gYu5R4g7FBf88Ed7SLNSow3rj3RvYmznQLHzvLUVPHrG8ID4Stk?=
 =?us-ascii?Q?m02DUO50sezmgofZ6qRQYELcWnRnttUahwqcXU6dnKHMuOmgc66ZUN7xmZyi?=
 =?us-ascii?Q?Pr+bFGnTfczhrH/6Usew/Y2mM2iHZXz+QUDO5xr+b3t3zBre3wIuFqkiCQs0?=
 =?us-ascii?Q?EqBJO8yFEOolCe6Lx5cwgVUCWyiysXQ1UotnUOtIgSzZUSA+I8fMoG0/8nOv?=
 =?us-ascii?Q?p9qx6mJoPnZKF+pZTlWyXtBCFrenJ3Q3vSCZCHSNiGc3irfjg0aPaKNh7bJj?=
 =?us-ascii?Q?nWNpIJz/Z/sSgwt/7ekoSeNUUeo7FFrI03tL2fQGG0dW/4kyKnncWkF12r4b?=
 =?us-ascii?Q?897s8VwJfc1Rk/cczJkMXDJbJSU1xxhOCGgChEt+QQIVUKvmVLGYuAQFyWFS?=
 =?us-ascii?Q?vkQ4s1nrmbTB27luApAKNBXS6bJER3KJr7hNulpppultU7blpdGGsRwqndgq?=
 =?us-ascii?Q?NXW9K830p+Ak0hqQb08xkMkMGcvYaFPqHp4emMneGQ+AGWGuNe6UfLnRkm+J?=
 =?us-ascii?Q?0fAW9fkjAQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 116f47e2-14b5-45a1-9c80-08da21dd5253
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 08:19:28.0452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wkc/0+uB/FTzyH3VtguG37shyjRpZ6acgf7RLrNLiBBdFFz1aVB/iLvCW2pVJz3ljqVGGpsnaBrC0Lru9Yelaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2869
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
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

David Hildenbrand <david@redhat.com> writes:

> On 19.04.22 09:29, Miaohe Lin wrote:
>> On 2022/4/19 11:51, Alistair Popple wrote:
>>> Miaohe Lin <linmiaohe@huawei.com> writes:
>>>
>>>> There is a bug in unuse_pte(): when swap page happens to be unreadable,
>>>> page filled with random data is mapped into user address space. In case
>>>> of error, a special swap entry indicating swap read fails is set to the
>>>> page table. So the swapcache page can be freed and the user won't end up
>>>> with a permanently mounted swap because a sector is bad. And if the page
>>>> is accessed later, the user process will be killed so that corrupted data
>>>> is never consumed. On the other hand, if the page is never accessed, the
>>>> user won't even notice it.
>>>
>>> Hi Miaohe,
>>>> It seems we're not actually using the pfn that gets stored in the special swap
>>> entry here. Is my understanding correct? If so I think it would be better to use
>>
>> Yes, you're right. The pfn is not used now. What we need here is a special swap entry
>> to do the right things. I think we can change to store some debugging information instead
>> of pfn if needed in the future.
>>
>>> the new PTE markers Peter introduced[1] rather than adding another swap entry
>>> type.
>>
>> IIUC, we should not reuse that swap entry here. From definition:
>>
>> PTE markers
>> `========='
>> ...
>> PTE marker is a new type of swap entry that is ony applicable to file
>> backed memories like shmem and hugetlbfs.  It's used to persist some
>> pte-level information even if the original present ptes in pgtable are
>> zapped.
>>
>> It's designed for file backed memories while swapin error entry is for anonymous
>> memories. And there has some differences in processing. So it's not a good idea
>> to reuse pte markers. Or am I miss something?
>
> I tend to agree. As raised in my other reply, maybe we can simply reuse
> hwpoison entries and update the documentation of them accordingly.

Unless I've missed something I don't think PTE markers should be restricted
solely to file backed memory. It's true that the only user of them at the moment
is UFFD-WP for file backed memory, but PTE markers are just a special swap entry
same as what is added here.

That said I don't think there has been any attempt to make PTE markers work for
anything other than UFFD-WP because it was unclear if there ever would be
another user.

But I agree re-using hwpoison entries is probably a better fit if possible.

- Alistair

--=-=-=--
