Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA93587C4D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 14:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbiHBMVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 08:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236738AbiHBMVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 08:21:13 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2171D286E1
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 05:21:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cyeh+/Ffjf3lVhinLwBUoFSM39yQ6u+Fc8XQbQDC/ifQTN7CI3X8J6HY7YXT+J4Qqn79kcQSyu7m/zN4TX5PbS7BCYm4g8+VoiuiWdDC2OsrzN0WW0/YDaeSPTZrETU/wr9IApx2DHjqaRawtSv0UvF2liPvKrkRdi7hx0sWBZtPoeKBt77s7u9zTArVuiytz5dfTy4zopK60GgJn1YiMt36qjzqibf+wfmieu6KtWb2ShcX5C+bcZyTU4Y6QGT1Jc1rFtke+GQYJVWlVSTeQPaapAWr5fdNlsk/x2m6dHVJSFJhphnbzkqgCFQm7R0HnDT/Wzao2NROknMtQ8FyIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8Wf7igpZ6BRS/f7j4wLh+6TR10YEMwoWG/kdfE/JsQ=;
 b=dySUHvGub/3cdlUZDs2samxEho4LSOOjuMdOoKm0wv1CmB5EwGPkifMRKsGWPsMhMQUqPup1ZsVW+hIDPwKn0+jsJ1loHw9rcr9uDQCQqmABglcfiofNtSnZlUPkGbjyBCd4hClgqoDA5cE/gkgIpcmzqI61X1JnrDyBVO7iNrhszlW7hsfgZLVWS5F+TtqaPsEkEFxAtJbz83t62zh9y3WzZzytBS4jyULBLPNoPhAA0a4XLcIltBn6kVVCHK19YmvwADazkzCGG4vfRufT+BxXo2i/RoKJyYAVWOukNAStiLDp6ZRpSW4qWmJq/R9y5ElF2ZqkP8x+3jL+R7oBqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8Wf7igpZ6BRS/f7j4wLh+6TR10YEMwoWG/kdfE/JsQ=;
 b=IToLk9zu1zI8dyamyYFrpA8gJYyyO0RAeA4BWErjAEUL8xzs+1eQfnZSDdnihhjKHz7PsF3bGS6ayK8GdhtO27hFF2B3SSYEa4OYrhyfA5eS7usBF90rCbpZDUdvIJLeTjc8D3e1AXKiimGns/6ja5nlgd6II0gcM8Lmp2Ygo80mWxQfUhlFge3DZLPKAgCB9KHTvXFch7faaxbL0UiI2ajnxJAtJw2F5KR5sBRJ0wZyGjVjy77v6JwzPc1zN7G0L5slHk5p9S3r0lFi3LqWUUj5uyMTbz4e9TP94W9xlve7PbhPvzCZ/7MiylF5xVifMwNFvXyzHjxcYyCvZ5IyFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BYAPR12MB2885.namprd12.prod.outlook.com (2603:10b6:a03:13d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Tue, 2 Aug
 2022 12:21:09 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58%8]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 12:21:08 +0000
Date:   Tue, 2 Aug 2022 09:21:08 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     akpm@linux-foundation.org, minchan@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jhubbard@nvidia.com,
        pasha.tatashin@soleen.com
Subject: Re: [PATCH] mm/gup.c: Simplify and fix
 check_and_migrate_movable_pages() return codes
Message-ID: <YukWtNwRvOPh6jmM@nvidia.com>
References: <20220729024645.764366-1-apopple@nvidia.com>
 <YuQ4mJqjIUncf7iF@nvidia.com>
 <87wnbsd6yp.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnbsd6yp.fsf@nvdebian.thelocal>
X-ClientProxiedBy: BLAPR03CA0039.namprd03.prod.outlook.com
 (2603:10b6:208:32d::14) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc983db9-e1a5-4759-d451-08da74817adf
X-MS-TrafficTypeDiagnostic: BYAPR12MB2885:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +cx1X5sqd8bEQnGn/Yfvgni5a10TevlWLtM0ghkKO5lQk7ksUN6oKQ727FJJ8jMBmO6T57jjZdPupl9wYY3kVib30vmPZkjH+BJI2c5XXGoCNWcXZM2AAEJUwjd3jqzI6ai/m2xh7HIMpDMUKF2QyVPhCECkxq/Eye8YiL8UVfokiuPqS/fvbk9zBQ6btEmxdxEC0oC4pTw3tOJD+D6bhBqMHP8VoEggjRLSmrIWuyxoMCfP7yObivG73p5rFkv5i8dk2q8GXNCqTuDTKZNk6/V2PjHV8pDNhQMDnqSusNFpYzNOu99b+Q2a1xsz4w/csB4J2ChYxuwwuWrYRaO1vHWRxo8lCmoWjrfKxYfQViWdEzUJNWhIQc/j+w5TAU1dlEApCIzTOCAwEPHKDzDiJnvgQJsIUctdeO6/X36e6EcR3dKWujPx97+Csx/WusE9D24Iflv1an9NBS6cevSSRQKU55djErU5BbLPmrqnjKEV2bnvV/Fbcd8CcPahkLFe+tVJ4A73LUinDB/Bk4G4WBlUyidclEtf4W7gE+PEwgZgIOQn+W1bRT6USnc3auTk9xq6LUojfzdUH2JuRMWEN3Y54zLK2qG4yH7d+EKOvcFKe41UtlDjAVaaIrD7ZEj7Qwd9KtCNjGLulOjMhhaaGsayHEds0yWU3Wi+htN9kNfr2YQw3HRG1gYcgI1Kwjtu+4F7RGtcvJUIuwzZLo4C4vYR1b658hSO0nKBIOR+yO4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(6506007)(26005)(6512007)(6486002)(186003)(41300700001)(36756003)(6636002)(37006003)(316002)(66556008)(66476007)(4326008)(8676002)(6862004)(8936002)(2906002)(86362001)(5660300002)(2616005)(478600001)(83380400001)(66946007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aGJ8REsERv0+AmTduBPjswp50Z+UszLQBv0AyntSSGIhtpLaMZ7e8BMXRSyp?=
 =?us-ascii?Q?4P2gbdUmul2eV4F0QOXpuESxssworio31ycBWITaB8seIno0m7kiVT9Sil1t?=
 =?us-ascii?Q?ONvxoDbdwydxlSDKS6Mwgzwt7iyou3vgyQ19Oq+57lEmyhpDY6o9jc3nHvxf?=
 =?us-ascii?Q?hXXHIzLtZintU7tGe4nTkN4g4Gax/qRRmaLnfTQE+B5SI9p/aQldOWXb1COq?=
 =?us-ascii?Q?PfVAhGxzA5/TGD8j0df7mh0TmnLqetO11qTzr/eGXCNzxNaDmPbzrtwcI9x8?=
 =?us-ascii?Q?V9btUD/Hd4WE6NM1pH1YUpc6oxo/c0rEokMWrerT2GlWCDQkYQABObwJo/K1?=
 =?us-ascii?Q?gLSsDy4qo/UGBYWIhAQC6JhdvxeJ/0bBBrdcd3OgHXNHKhRcqkKxJuR9RVcN?=
 =?us-ascii?Q?D9+ALJBCYMKaAfP1EZEuef5nVKQSJ2MqmKoQl8KxH7vu5SD4n6j0MtuZ4Vi/?=
 =?us-ascii?Q?Ool7fbbDvJYCDKjNzfgyUSKC3IyR3hvrJGz3ZhOWUy6A6vzUT99Zpn3rek5g?=
 =?us-ascii?Q?PEgHPH/a5dNpeJsoFE9mSqu/hZglFQNOaMFNUC0R7mkLzQgCyQng/onV77zM?=
 =?us-ascii?Q?dEStmVta+5cLgy7HfMjTKZ4f7iHcIYTq/Jg834VhvyoUbY6pR2G53FTYhEBx?=
 =?us-ascii?Q?FRoDroN0DOrTr3DLMnoWN7cG3P2AG/s3BoAjfialQBK4fhdZKW9Rte0LjFY2?=
 =?us-ascii?Q?tjBB0IbOf+hYL5wveu3Ec0zZlWDKMgAMClIDZG7NYiYq1sQxnmpE9rGMIuvv?=
 =?us-ascii?Q?4POXosTHBGKs/lkUAgs8TYk6uS7tyyn+88wXH+Xg6Ixe7lJtjEb6bAz1Vh25?=
 =?us-ascii?Q?cevsD+97efPnCr+qYFf9es1+tecGdsGWs/xiEpBA2xFPfARpxMSov2AIlQ2A?=
 =?us-ascii?Q?3AKDWci12/hbHdH7Zsqaiq01/GKNksR4ZHti5xwG0Pvsq4SqNRR50HGqnHgT?=
 =?us-ascii?Q?3wFkgbGGg0muCLm6vxnoTjNyqm/WDgoNI7H0IrZurZANIrPuSzD9YTuJJN5l?=
 =?us-ascii?Q?wf9s9twlgxtUcjN4zXpeDRWjjRWLAnv7plg51z3CPA4vz/4PZiuSQlxyZKnZ?=
 =?us-ascii?Q?rnHmHLDVw3mABKIp3q83+dsv2JAZcthm5Ru1x2qtvH+i2m4XTlS+yI3jW1Ha?=
 =?us-ascii?Q?cG8A5vtesHj6TYg7K94nBXCsbOtE5gDOQA/cu79D41QuFWYR35rGg9idGibE?=
 =?us-ascii?Q?BNdiBWPtimJuj/If+D9M1bqU3wU1G5vaAfFnCauOEnC0oxTamlqMVdnchqw4?=
 =?us-ascii?Q?rmYHTuJtYaehZPYRqXeYnn1tqKoTe31yrZBr1cI5fstJTP4L7qp9F3y7oA1v?=
 =?us-ascii?Q?X7EJmqDWSy02BO4dyNBdtcoWa4ahY2j+nxWvrZekZE6XZCAupq1DR4sIwvxF?=
 =?us-ascii?Q?vbfEIIbUXxRDoUn/yBS3FlPxkNek/s9o1LETlJAysjHzC6ijm+oDzCuYnKFB?=
 =?us-ascii?Q?fuuLVHvbaTIYfi6YWFosQ4sfZBjVwODsPOx/uZlzW+5QzQPJaCchZemGx+TW?=
 =?us-ascii?Q?ArFb5tBp20TrgSwLjS5VT34CY2ixh35DymDO7oavX0YZqqBm0wD68Lz4UtZr?=
 =?us-ascii?Q?em/ThSlhI0gQFgMgy8Eb2wP+y8eZJOdHSw8aI2Bx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc983db9-e1a5-4759-d451-08da74817adf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 12:21:08.8844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWLZCn4Vu6LOiU8PkyNNyqXvoP9l673hknon/H3hAPW3aGvBN47TSwOsC/pJg7jR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2885
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 12:18:53PM +1000, Alistair Popple wrote:

> > AFAICT there is no reason to 'continue' in most of these paths since
> > we intend to return to userspace with an error anyhow? Why try to
> > isolate more pages?
> 
> The main reason would be if callers want to retry the operation. AFAIK
> isolate_folio_lru() can have transient failures, so if callers want to
> retry it makes sense to isolate and migrate as many pages as possible
> rather than one page at a time as subsequent retries may find different
> pages that can't be isolated.

Except we don't try to do the migrate, we just isolate and then
unisolate and return failure.

> Actually I should have called this out more clearly - the previous
> behaviour on isolation failure was to retry indefinitely which is what
> lead to looping in the kernel. This patch turns isolation failure into
> an error and doesn't retry. I wonder though if we need to maintain a
> retry count similar to what migrate_pages() does if there are unexpected
> page refs?

This makes more sense, exporting this mess to the caller and hoping
they retry (they won't) doesn't make sense..

Jason
