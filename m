Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07FE54CD34
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352734AbiFOPku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbiFOPks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:40:48 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA75338BC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:40:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eU1ZRac8VeW8WGm28Ivsj4vHD1xZV/qAEKf1fQMAMRF5hRN8RSGx8qsuZ8rFBkgjFjKZ+V6fKfcVyaZuVr862dxpu2/NLIZnk0H0LBC2aCma9LrBkIkEl/yvnWJrWDlRvraPBJAZaz9mLcxWmKVvfIXD17cgN3/Y3eERRxNM99+f2DQVZkkXZ3r83cpzGxSXvsQYQ43zJQfW8l3YsUDjCjBR+ci9PUOizy+dldFBpfqm2aU8orTi8MxshJthh9mHzAHhI70AXIOk6y0AV29GEK6yz2dEp6xF9Ek6odnJYjnl4O7kQKyABrCN8Q/FF4JO4sI0dwUNnqcin4EUzxdmmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J47cnYrqTtlN+w2CVfxXCyyzg3OqyjFfRcWBC9fQ2RU=;
 b=gqKjicMCgAdhnt59F6ca4PjX55NczFTyRXks66bl5VWQiS4surghlJ40AuKYSvdvu8lZXrQTo+O8Q56P/TcqUtVlRWHgAlcBsor1mIiG4qbUvsKPWYZg4aDIgbgvRUpGYQnL+2Lt1enSrRWe1qXOS97sngxlhOfYNKaymNjiSTjYhcDN4mtnB58NfhRSfi5HCgjncVfpVruy3Dg7vNqF0XuoXe7tFDEZZhQPe80pjhSMCLTgoPLSn0+gUgLvrfZ9YbW0IzA98RFAMYy+JAObwLDILncWwRf4bDv9MbWx4rsaU0syTPr5DNU2rpDL4Z7kUsyzC92n/HN4iWAdjn1EdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J47cnYrqTtlN+w2CVfxXCyyzg3OqyjFfRcWBC9fQ2RU=;
 b=oQnytG4BUOsGgmWETDe/uHLLquLFN30mQHDqLR4I4a+qZGdohGXjBQUoIY7ZOReiWkcmmUB72vSSWwk8xD+CMrsDLJRNlhlDNDWLBoZUDeOx6aP3Lx+AsebZTAFhRv97RZ7xco8zY7Aem1o+vk82NLTmjpWgWnsPA7F3/nvjXC9OPNDPJG/ThxYDKFNC4KZOKAVhPLX/Qm531xCi4xi6ovXfJgQ3bW2lTvLRtc84NhssTi36Sv+78wE/H4PTFlWmIMPgQVwm92gQTGngNo0xjqHVBiZS4nmYRslPAzWfpPOMU8BrPNxTTx2oO9GHrN+EVbJ+g3F16vI1PiVwop7atg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by MWHPR12MB1549.namprd12.prod.outlook.com (2603:10b6:301:10::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Wed, 15 Jun
 2022 15:40:44 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::b991:fe0d:8981:90bd]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::b991:fe0d:8981:90bd%9]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 15:40:42 +0000
Date:   Wed, 15 Jun 2022 12:40:40 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will@kernel.org>,
        Joao Martins <joao.m.martins@oracle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCHES 1/2] iommu: Add RCU-protected page free support
Message-ID: <20220615154040.GA4927@nvidia.com>
References: <20220609070811.902868-1-baolu.lu@linux.intel.com>
 <20220609124934.GZ1343366@nvidia.com>
 <bbada5b7-737f-03dd-7d42-2ebad442a2bb@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbada5b7-737f-03dd-7d42-2ebad442a2bb@linux.intel.com>
X-ClientProxiedBy: MWHPR11CA0015.namprd11.prod.outlook.com
 (2603:10b6:301:1::25) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 822dd8f9-4709-4a4e-a8e4-08da4ee567f2
X-MS-TrafficTypeDiagnostic: MWHPR12MB1549:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB15499E861017BDFB7B31AEF7C2AD9@MWHPR12MB1549.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Unbyos5XhBzoayb15Fmc7XNtVzNXJXwxQYPkU2zAmi25wgEQgl1q12gri4+4AmJz7kYGgnUQj0yGIfiB0vyKtqxOtsggoaYLQzAEDm6KXK5dbWDVsg8Wv+Oue1/9eWb7jcysEaMLGQqOsFPH8elwwHYNl0rKKVY2h8RjHqsBfhiyzZbnOu7zsRYu2v8JPaC9/bfLNPp2BWWznhTeirwr17jb9meIYDm8lgaTfXQyj7Xbk2RjTqgCz2d9HzL+EhK+T69BwQq22pHVOdGTDZ5zfjagymcmXW7XVuZAHzu9XMjl0HyinNFDpUxdTmjgeyHJH7r7clwuYVz49yD1SRubslOXzbuj/ZQytSsRz5vCvRMcFmh/bXHr38eKNHpmG9G3ZQU+KtN2l/Xx8yU8J7vFeJvTc7bMUN3zus5EfJ8I8hTt1aty50EIbO5TcXrppmBFrym2QgPrnGUkKgv7f/4MJcQJR2sSfkgGYfDRM5lvXAn0qz+sdPlRXboo3WfVPXgDwIMxEKx1o20CjqT8Lrr8AqukBFxZt9PeBMQYl49Ze4wPBdLqpr8+SjWVZ5mUMzmicyPypK6eG1pwi9xOvuVwrOxckq894M0wl/aBS2b/vvfZKZ8PdcK5dnIR32ynrJ41UbJ5k/eSBpA/Vz87KoFlEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(6512007)(53546011)(8936002)(36756003)(38100700002)(186003)(7416002)(1076003)(6506007)(26005)(33656002)(2616005)(6916009)(316002)(4744005)(2906002)(66946007)(86362001)(66556008)(4326008)(8676002)(5660300002)(6486002)(508600001)(54906003)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IFXLDkxKoDhL8b2ahMdQybYLuQQAAhx5R9f4NilC9CGlaS2Pt5yZlC9ReEmd?=
 =?us-ascii?Q?X8/x4BWl57yM8KctTAbZep1IiKZxqTPoHCVFCFmN2KC4GsjtLZqpqp7lo0aC?=
 =?us-ascii?Q?4yAG+V1vdQ04lG9Piog7lPU9FUyLEzximBWDEHA90B8OOcriezrPffqf+fjG?=
 =?us-ascii?Q?3TwtvJgThDImNpZ39ZWOV2hfbu88yk1o4AHr8u1cW3hD63kM6xGqRoE146kP?=
 =?us-ascii?Q?Vb7zPGaZG0g9zfcUeyl7qJY7tNtagtFZLh5xgK8GHa7L6SPatxQKntQzvVre?=
 =?us-ascii?Q?DW210Q5sfbnPGztO6OXem9cyDHjuoH0ljDY73oDSuOJ72oxMU1ZmYhLIglrv?=
 =?us-ascii?Q?rg1ypCMLAVaM1N9n7jmeKv5xdG2XUkhGrsKy705g4TOE21YR31/eV/SZTxvj?=
 =?us-ascii?Q?RdNicURbjEEV4AVvUVAMRVIih5HyT4It35vHRdxp4clcJlQvkykA3BdMd+nW?=
 =?us-ascii?Q?IYeHn9zV91tbOVYA2IU7tGukPDPFXaawen6cqZFPjDwELrD5ZZZG6H56guXe?=
 =?us-ascii?Q?f8C6wT8tYetI1H6ucmCQvIk1tl5u+tfa7mW6paSbGHBRo/358IEBME8Kqfr2?=
 =?us-ascii?Q?j+PqV3dh7oLXSdMdvB6i3Le+2TWu5Rnnd/M1gprKwewovVVYcA+1q1+Q2KNa?=
 =?us-ascii?Q?8IqoXlCfnqe+ecQqU604/FesryzOzaZ0SGjbKsxTrHFWOoqGmjLh6TBZWrt8?=
 =?us-ascii?Q?6oC9XyJ/Ja55rlyynoLtojh+W88I6ieBjPx9MCoZuBJkAaQ+cZRIXrnyt0pt?=
 =?us-ascii?Q?NOVCmhclOfKm0cx0RqjhUDhKYPsxF94DQXfjTAqosqcLYsXHoCoE4AeWse9c?=
 =?us-ascii?Q?SLW0QF8DSn4e00uK3d2YuLDZ4qcGpYRBVTjzsRc6IjJLGC52ef+LbOVNXz5N?=
 =?us-ascii?Q?ZL1goijtUozl9AXGLfuPgJxxpWBpPnunLLNaS3Pk0cGDeMMFRfS80vx0wej4?=
 =?us-ascii?Q?3Wrrvjf+zhDXAqLc71k2Exb7uJxVz1vhnOK08osyvWq8Lk/ngNEOBrmFrTCw?=
 =?us-ascii?Q?NiIFPewIF3Lml0w8CkAsb/HKmINfCmP3CGicNjgDImnW2pVUnJTeIP4a6Y45?=
 =?us-ascii?Q?5tEYjRzwQShF8jQLSSyglN4QihelbtJf8zG0PrtNH4/jrC+u6yewkpKhRiXG?=
 =?us-ascii?Q?wo15E9pG2pqPS68bYsN8lj4uNtaPaAHZG52aH1V66YccsbMyADC4ttf5GkkD?=
 =?us-ascii?Q?Apf7yXQB0UTHMOd+luuns8AXBnhSAVxS39ilHuGcHHjUcleL2FaUbNPk2f7v?=
 =?us-ascii?Q?lAHLHWmF6EZbQm8bLbzKhPxi46yLkI7jX6f2hwjDGondQWidDMWSTkemGfbp?=
 =?us-ascii?Q?g8Qa3EO9/Ya+LOEmy/8WdNwtCwUzK/vpID1go+D65yWpck5ZUgC6DlBVX9mF?=
 =?us-ascii?Q?fSl+63WBiTX5/bEavY3Vm+2OADk7kNp/GTPC07KconryEac1/bJQEyYZgT1a?=
 =?us-ascii?Q?aZ844QT+eXPVgKrC1+liSomNQNb1aJtR2y+eds2BKL3Q7it2oq7Jcp09i58S?=
 =?us-ascii?Q?X6ZDQssiSD1wNheB39mjYZS66lE1LqYbPTzf6g446eXrCltXGoWAXvIrXBFJ?=
 =?us-ascii?Q?/qhUAuvNggSXo2DTNM4O4JZ6VzKVOU3Laio56TMnEQF/LUlS2d1DED8JFY+c?=
 =?us-ascii?Q?EiwFVuWJzPJHZ2PuiqCh8pjNRR5ayveTbbV6KQCpmH6bm9PA36iJl+8HuD10?=
 =?us-ascii?Q?ZzmmQwXjzTd90Zxigyx5d0iyDaSh36sDpyY8U3IW3FRQQhLNznUSw3t+xUaG?=
 =?us-ascii?Q?+/Xy5iwhOQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 822dd8f9-4709-4a4e-a8e4-08da4ee567f2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 15:40:42.6498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQog0rVwAVGxLc97QcGgXwyWzuXEkNfMgHvQyz+uda+oHsCI5f6E7vNBgNgs8Cqd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1549
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 01:37:20PM +0800, Baolu Lu wrote:
> On 2022/6/9 20:49, Jason Gunthorpe wrote:
> > > +void iommu_free_pgtbl_pages(struct iommu_domain *domain,
> > > +			    struct list_head *pages)
> > > +{
> > > +	struct page *page, *next;
> > > +
> > > +	if (!domain->concurrent_traversal) {
> > > +		put_pages_list(pages);
> > > +		return;
> > > +	}
> > > +
> > > +	list_for_each_entry_safe(page, next, pages, lru) {
> > > +		list_del(&page->lru);
> > > +		call_rcu(&page->rcu_head, pgtble_page_free_rcu);
> > > +	}
> > It seems OK, but I wonder if there is benifit to using
> > put_pages_list() from the rcu callback
> 
> The price is that we need to allocate a "struct list_head" and free it
> in the rcu callback as well. Currently the list_head is sitting in the
> stack.

You'd have to use a different struct page layout so that the list_head
was in the struct page and didn't overlap with the rcu_head

Jason
