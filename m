Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A4A589B29
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 13:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiHDLlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 07:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239293AbiHDLlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 07:41:02 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2075.outbound.protection.outlook.com [40.107.96.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571EE101FF
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 04:41:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXScp7dTzv5pMzR4am6N5oq1RTYUggAyF4w/xDEX1cuYwW/UkBJx/d5fByGHARVdBSPWDePEwYGmyEC9TJ2MV6zAPoSWK/f5pmYKSz6yTy8PofWixEcipNc1KIBQsjH9TUHU7spdR6eECRMfMSsZqQQrZdDhVVRTNmiM0DzVvM/92jiTMaKdV0XUqaTEQFxlrSP97lkmtKHUIKVHDNqvmP2nFHHoVQwKszHf6hpP3/CyciPIify+9WlcwmCeuBGphd11Xo+ygLf1EAdq4MoWORYx+gJLXWRS4eyAwN9p7krnnkDlfky7C2cEEz8dYd31evbo//NoyEoAm1WkzFpWVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POPxQc8hyXYcnTWND4FODxbY8dNSmSEe60csPrGGRBQ=;
 b=fQLKAOwWnCK6ECJEUYsHxm8k0C6kxTuemXpMxh2XI/+LqzDrBZWt+3LIGVJyQgl1KO2GZ4bUkIufVuf/Ce7o3mosLqL4YZ9V0B11aELs8DeG22Yikqnw24KeqGzc9l0pHhBuQutTw2do/O2yI6MCu9Kf0watZYj6VcJdB5DlKqEA9N3o1h7JlUs5zCYl1L4aJKZAr8wGe0NV673aTXcggWfg8YuHVd8q7xCfC0LZtENQcNSihA3Qoqg7c/IuvuxtPY3CdcvMRudgZ8WRk3bMtljPlO7nNTIvLoAf7bIbj5cadb6SdIHVucDMYerScIjrotfYI7+NTBHIlgNjeFCRBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POPxQc8hyXYcnTWND4FODxbY8dNSmSEe60csPrGGRBQ=;
 b=SMn2lfHgBEXSs8rYd2JpF7pVjLxWl2qi5AlydPjs06jsJwGmdYKeZ7LIB5uK239knMYYbT3CaJaDtgeCtzLDcfE6n0gzqFzZYNot4h8Icmfrel76RacTl4+2DN7SKa3g1Ruhsta+bMOarTwqEdOYe9hN4TgEvJGxCGTpLjeN9WIttohj0uqV/UTtXvhyISWULqyzssYN4RFMB23c+hEbehwP5+OAL45bwYIgf8W8odM6JHvUluv+378dvg6HfhsXGxDwHT/KaWOVVAgLhddu5MvASOJ6YwZsCnO79S6XioR0NgphLaPyakezBe6GYG4pKdEceizG0sohdAv9vQIylw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB5546.namprd12.prod.outlook.com (2603:10b6:610:63::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 11:40:59 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::1a7:7daa:9230:1372]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::1a7:7daa:9230:1372%7]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 11:40:59 +0000
Date:   Thu, 4 Aug 2022 08:40:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH] mm/gup.c: Refactor check_and_migrate_movable_pages()
Message-ID: <YuuwSoZpRI9kKtLF@nvidia.com>
References: <20220804032241.859891-1-apopple@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804032241.859891-1-apopple@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0425.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::10) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15bbf5c0-d6c6-4a60-0e58-08da760e33aa
X-MS-TrafficTypeDiagnostic: CH2PR12MB5546:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pKqfbC2RtirQKSdptV3LWuviVXGV6l9WvzuIsxUlBt+9mBgKuVe+v0c/WZ8Kfd94H/XiKIh2I+CoJuTuLOBGC6T2asSoT+xAZNHNooc/AQSSXYIHOOFA7Z50d4ycjpu7sTqLMkm7/BSNxGRKtrft1HDyNoeun0HKfPDpHmp5hWhwgnJ0j/NXq3UpLX4gK78nqA9JoL2G9hYB584kC7t3nI7npiELVuouFrEJxKO4CnU2pYQ3Md45R7qWPLGIyNCxImJ9tgGX68W5dMylcJDB6xA4COfQLTdlg+q5dNx8mq7ii3J44beCZ5q6fzq509TzClPbTs7eb0XKh//4toXJZYkDnXY9pSEgn7VAJsYRCBdjtnyI0J7VRBf56nb4/Zk+MySc9LOls7W43JqkHjZFSiJMuwYTPqwPYR5Gmxwyt9KHKLWIhHga1CA7KAjs5ja//q0xEG2oflN8TaDG4lI6mKtMkcJgWelh872MODOHk8E+EdD+cwz/J4PhKM3UbHk4i2I7bPqJqmxLPrn580rAUQrtVg8muWeDu95MmBm8BpHnvNhLnw5NZg9omKuK0BfItOZQCEEJaxMue4y1ThQky24URkmR/ToqrpTxDOR1Cd69yDrLRb25RNGPwaF9Ms8NoV/a8CW67anCEPapSayhq5ew1yeJ/rXyo+8nK5f+zNHchC7OG5OGa8Ru988hd6DQ+fg4KBBZVKKNos3+1sB6xY3vh7w0nl3gt0JkwDtRtK8COyhKGxPrtAYdMtguzQj1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(41300700001)(5660300002)(7416002)(26005)(6512007)(2616005)(2906002)(6506007)(83380400001)(107886003)(186003)(36756003)(66946007)(66556008)(6636002)(4326008)(66476007)(86362001)(316002)(37006003)(54906003)(478600001)(6486002)(38100700002)(6862004)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G+x7HqoDsWnIU4RqHV6sp//iE/Klpj/lx2RGPdQ/YG7KQ+XJxZaGVjl++w15?=
 =?us-ascii?Q?QGbBednm6635ZZcEbKlBAxebKAa3ESDoB874zEx6PQcIa7VSBpNj8LIK/dr+?=
 =?us-ascii?Q?Vt2umvUuRKoM8XPe0rO9hbpV/7GU8bZpA/Ks5zshJ3sjv97C7I2x5/MfYsgo?=
 =?us-ascii?Q?P4U/czbUHnlfTomt4opHtxr8jDVRM3PvqXUFUZbbA0woljGKwtXLr8CILkLO?=
 =?us-ascii?Q?+QPSPYnf4vWoIFRV7iY2Bu5I79wENddS+6Vjr9x//rABfLEBV2k4RtlotcOW?=
 =?us-ascii?Q?EW6zzYTXF7e9/EBBHITFx72u/ceTgmB1W0pVrPTcI8bB6qbcmnaN1nikBLb2?=
 =?us-ascii?Q?DBCOC4FTaJrHKkaFD1yDVBrCjxNFjwYwQR4F7mratUFGq3b7HlHNm3komcdu?=
 =?us-ascii?Q?GQ3veITj4qcZ8IxEcyQpLwOB9JwF2DODF6q22P9VoSYtlCmGJ5p9Sosp7VDc?=
 =?us-ascii?Q?iSR1ZwXCn3LOMPyOYGzXEbwtVsYkTLORgMyCZn+uDEddCRaXbp62djaGpF3W?=
 =?us-ascii?Q?h66L+AQOkrMXaF4kZOFoW6gVNSCjwTA4foHokgGpdEXnput1WiVirYMmJUGA?=
 =?us-ascii?Q?mWcN5ALipJV2jtAhLDcVW9u3LqaAygWKKQJIb/wwlJwmHzXfapozYyEXbxOR?=
 =?us-ascii?Q?hn3Ex3DFqoRGiwOS9fHovNW7qXvPkEHjpTgCFL8hiXxxUzsacO17HF/p7kXs?=
 =?us-ascii?Q?6XTlRd+I4Wq4RfZ1hUdhoHtazU7X/+ClKGjYgm8wYb8mJSDtgZ4pXdccVjqC?=
 =?us-ascii?Q?Japb4+OXG06ulTOaiR7n44VFGwUX7gwz5untWL2ayUPQWmKsjRqQ8JqIs0Xn?=
 =?us-ascii?Q?pUv969S+TYMbTRm+yOoChrpwRac7EYWfpRPQwxK7vXG355luqkPuKpElkSI0?=
 =?us-ascii?Q?GU/lrilVSDwAmxb9AVHFJIjr1rjDphQvwZUswBlMF2MA6st+wmsBB7/a1Emb?=
 =?us-ascii?Q?cY3oY8ikxGPVv4cO1f+AwhFrWq+lFo8hvaKhf3+YUGii/54yIjfgsSMmM3EE?=
 =?us-ascii?Q?k8hMZAt3Gfs7d1ODw1qAZ6feQhbGxbHmGL7KGU9WpUoQMHsNvI/Eq/ojDil5?=
 =?us-ascii?Q?d6AR6nO1DLhEkQqaxisHIb72hYoZdNQyqR/NZuGEqd9TTBeCgb854H4zn+zr?=
 =?us-ascii?Q?VY3EOYotPOJbiGlVI4eihdjUh7LhmeEKmKL0n4vEE5LHHttjZdcdcL/YMJMb?=
 =?us-ascii?Q?+j1r8kQOxK/tARxPOtiSuoGYQ08m/QPBZQILONnmfXWQnQewSiQSaicBI0lg?=
 =?us-ascii?Q?uSy/svj3Y0iIYUpxzpqvJTGb5TPNaKrYXASUF65tjr0X6aOPPzQOXS9aZ1O4?=
 =?us-ascii?Q?WKGq1YfnA+l/BpAjwzK+nWbxKm7moL8aQVa8I0y+hTUygtQPBp34Q8dkXAiz?=
 =?us-ascii?Q?NyT9n2CPu0XyaIuOYjVbTeIm9ZKBmhq/6+Tks2ApLommEteMbphn8zeVOqCi?=
 =?us-ascii?Q?kJ930VQArzqqeadGq8zHw8rg8+xH9QwFENd2saKgrUDJRayG1Wsj1NkTN07J?=
 =?us-ascii?Q?C9Q/AAWTnLf612kBcEtSIchVHeHg/8BsQnJn9DZg+DlJ9cxuFCfda6VxtCm9?=
 =?us-ascii?Q?FySfm/a7jsRkQ9TfwoP5DDNAfUPb8QcXGbkvm3yF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15bbf5c0-d6c6-4a60-0e58-08da760e33aa
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 11:40:59.5842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aByL8nNQDLc59rulcxEvpuq9UYaEirKXL6kjeCO3AOWwVlb+LI6mry225bij/r1V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5546
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 01:22:41PM +1000, Alistair Popple wrote:
> When pinning pages with FOLL_LONGTERM check_and_migrate_movable_pages()
> is called to migrate pages out of zones which should not contain any
> longterm pinned pages.
> 
> When migration succeeds all pages will have been unpinned so pinning
> needs to be retried. Migration can also fail, in which case the pages
> will also have been unpinned but the operation should not be retried. If
> all pages are in the correct zone nothing will be unpinned and no retry
> is required.
> 
> The logic in check_and_migrate_movable_pages() tracks unnecessary state
> and the return codes for each case are difficult to follow. Refactor the
> code to clean this up. No behaviour change is intended.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Cc: "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>
> Cc: Chaitanya Kulkarni <kch@nvidia.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> 
> ---
> 
> Originally posted as "mm/gup.c: Simplify and fix
> check_and_migrate_movable_pages() return codes"[1].
> 
> Changes from that version:
> 
>  - Restore the original isolation failure behaviour and don't fail the
>    pup. Instead retry indefinitely.
>  - Unpin all pages on retry or failure rather than just failure.
> 
> Jason - I dropped your Reviewed-by. I had to remove the changes to make
> error handling follow convention as we need to always unpin the pages.
> We also need the list_empty() checks because we may or may not have
> pages in the list if we found coherent pages. So there isn't much I
> could see to simplify, but let me know if you spot some.

I don't quite understand this, if the point is to loop on the LRU
indefinately, why not just code that? Why do we need to go around the
big loop?

Jason
