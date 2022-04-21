Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5385098CD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385681AbiDUHW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385726AbiDUHWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:22:47 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7802199
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:19:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDMc0zNFuJgXVN7CIM8ui3Y5sPMkPpxMz/qVsPpV3VqvKkCdWHSo8io+ta//3KesaEJq+0x9N2WJsLkPtOr0MZi+3go/BlUSdWIS8fkqiFfmjaT/FGiUGXeOSn5Ae6P8EIZnQpyVKCGlxV61u19ou8wgmvNjT8TiAy3fBjuNSFhLGYcnDerG8VvVkZ6YzhxYPjnxMNqbYIjnUCvhceR67pQj0gKVUriN7JC5TSWXw6CoMNGwPVcoL5VI5RDmFPOVrWf1mvy5fMM3DvlT40XUF/Kw6m22kq4+iC5Z+uqvJPGYHDtUSO25bEH8QmelMgyFLwlz7h13mp8OPeYnokjH1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNgmkw6BvvILz7S4OO/i0ala9FenQs1eMcE7y/R+p6w=;
 b=V1c8bkNAFgNagRI3/EP3YEkn1zPaVSWtbYQBB12ioOMjs3AqQsMSJ1NGnDwe2FZR/jzA95eQAr+eZ3L4ayZ5jlAlHVA2eOq2jNww+7BqDbCJuNf2TWvYL5yrRbtqOsfN641A6uxqbcs8pOQBtkIMx45VWB315TnMyV7JiOWMYdzrbpH86iSgGVA8CfyaNZDQ8/Ub6chXzWgwsjziIrhFOA4ErNxRLjZT6w5ca9N6BPiM2fG6p7sUuD2cJyazGSsb0mUvDtQqxGYg8o32Ho5/YkCTzj/5xuxCWKYYjoqA/zL7aNNsI4YL+F8yvME6YvDjPLih3DKaViTbyzJph583qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNgmkw6BvvILz7S4OO/i0ala9FenQs1eMcE7y/R+p6w=;
 b=rtDNK+L0u5KprNHkyvgBPa9pfcsWpwk8cu9SAcJDYgVtHgNPU+oTz/iFPn2XBIeM3TMZ7cvdWekqrt7Du3VQCwO5oM4TRfTHMhky8oB8G7vdgH8Y+2fBVGnwwB+cvodI2bABFdtrErc2o901EzIeyyrT1oV/fbJlDLEYdTIjeYP3CjQzTqDYXqA7K/PhOQl3/qR/k4GcQxucNeXPcATxkdQqwYwRlw6lW+vZ25axxb+QrNBi6afyhrJuWrjJlQy49Vl/KCB4dwQQg0Ftyy0lviLw5D+L3StqUoui5aEWJU0qPSSfczUp1pYYSFMj5VGlU6YdR3cTxeJ18IvUCCLyjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM6PR12MB4912.namprd12.prod.outlook.com (2603:10b6:5:20b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 07:19:56 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2d17:b68a:e101:4c18%6]) with mapi id 15.20.5164.026; Thu, 21 Apr 2022
 07:19:56 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        christian.koenig@amd.com, jhubbard@nvidia.com,
        rcampbell@nvidia.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2] mm/mmu_notifier.c: Fix race in
 mmu_interval_notifier_remove()
Date:   Thu, 21 Apr 2022 17:06:52 +1000
References: <20220420043734.476348-1-apopple@nvidia.com>
 <20220420151142.f60307e749033a24ef0c68d5@linux-foundation.org>
 <87ee1rxrn1.fsf@nvdebian.thelocal>
 <20220420163516.ab713a22af375788a541f045@linux-foundation.org>
User-agent: mu4e 1.6.9; emacs 27.1
In-reply-to: <20220420163516.ab713a22af375788a541f045@linux-foundation.org>
Message-ID: <87bkwuykbr.fsf@nvdebian.thelocal>
Content-Type: multipart/mixed; boundary="=-=-="
X-ClientProxiedBy: SJ0P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::22) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06b5af26-9e9e-4310-0954-08da23675650
X-MS-TrafficTypeDiagnostic: DM6PR12MB4912:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB49122494675BF93D61D77CBCDFF49@DM6PR12MB4912.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QXCAVSdsW+0MG4CJMS2IOUh5kJlBtLU1jdYV2Sz5A069WmTEpKRSuQ+9Swl/8LCh9TPCTC4e8VO9+8F7u44/+PHVObmI4t1oMX6xF+HMHIaonH03aclh8wgmVmGDSt79v8kGoiy5aeiQ/x/FmCJYA8w1HU8pdXU99wskTrB1hyeiPe8K4Xb+KHMZvGgT/i4XZm3F84kuLcUpk7HH3U8zlLcBiYxO/hsBkOl+lNELCrDhjg75mUJfNpD3thvf3fINv8DQ0eOma2c8RC/HaHBHXn1NwaWWOyWi4eugfNtKfDKZ/Nz7uKvD5Lgsgxj4JYO8NrD6Lj+FNz390MGaohE/NWMH7lVk7accCqi/oW3ItRMRDrsWHovQj3RWWZYf699Wzd+R4n+ec5ql82DVjSbhR3vB2xlOYfMSz8XThw1II18zWGbLdOJKcxTFjcOlElhET8UxcYqe2F+I1obc8UNbu9q3m9xX3mGCua9jJNz9N1ySrawkcinysd9HmqnWMeEG17wkrp+87DpCqR1sVMEwDZs4dM1RXMkUCDjsfqPYKbbEEZW0fQ312MaQH/k+3jU7vCtc4knK/YckgJlST9o9DR0W1ee90YnGNErJNKZk8lFsiUW91p7sqw7cZ6W/0oQR1ZzTdGg/pWFn64hnvKo4oA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(83380400001)(508600001)(5660300002)(316002)(38100700002)(6486002)(44144004)(6666004)(6512007)(9686003)(26005)(6916009)(2906002)(107886003)(8936002)(66556008)(66476007)(186003)(66946007)(4326008)(8676002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e25cyG/NS7ti8lvYgyn19XUaLMeFzG0gg0PKhy5fG7VM0QzkmQVtiju2gH5z?=
 =?us-ascii?Q?YLWxJvqpU2efyzhcpA8rBV/CVIO5aUXQW4t32l7URTrINMONEDEYIM9bbXhZ?=
 =?us-ascii?Q?SkIBJsPtpudc1oEkPFCNO5nrALgE4+ZdKXAVoX3SL0WeJJYWTtTilyZZusbA?=
 =?us-ascii?Q?NPxPBXE3sWleP0N8IeaAQ8Ib4jogRl91+oZVl7HqX5B5aoQaH4YgmU3eQ1fv?=
 =?us-ascii?Q?l7+wi1hWdpBq4pNgX03dOGZpv1fV14bXzrmkVuzmd6X59OzDYRngDeSXQsoI?=
 =?us-ascii?Q?NIZy1cvzDIE40RoJcXaUx+RTBNEUHKXiekJJJ/56NDJDa6f1MAdkTPCNfSJT?=
 =?us-ascii?Q?iViTmtCBtYPesWoIxHbu4EHCQJPQQXKpU4vaFz0hhQjdr5stclloM6wOwuUD?=
 =?us-ascii?Q?vuyDkh3/vSkpDX/r9WVCep6Gj41+6zTzWVz8WIXbEsoqLDcZvuUR6C+zIGXy?=
 =?us-ascii?Q?/HVM80q2iTJMR9H3osWV7OhOTeSKGRyN0VoiYlg3jAhlN+vrc2SDnUgC8mro?=
 =?us-ascii?Q?mNCmCD+qFNlmPQg1ng1W11PCruiE67OFEqL1Sg7movcYPBqc6T7K4ERN9EyG?=
 =?us-ascii?Q?cjbIUbherIb5PszUrH0aVOfiIUl82PnDerYzYhEvoNc9aDmwjRgiqsZ0AG5+?=
 =?us-ascii?Q?lEFrMHyrNzxA3o50TtDO0yAz0UC9luSZlQrX1Up7TVZl5A8dulCf2tzNCl2h?=
 =?us-ascii?Q?pVWzywjrlEJn3C2W36d1mauT7DKGcPS0mpEQUJCxiHBQv0hPE9qnr9vngGRX?=
 =?us-ascii?Q?W5yr2svbQfLUsfy0lH/RUaixxYXpLBAUe9PVAwxPmbA8XxctmV697ExR9LPU?=
 =?us-ascii?Q?y0E4lYp+5rk8YGxaDDnHbVRYO2ZDszVYv062/XETlIzSq0VA5kp87FxWQsC3?=
 =?us-ascii?Q?JBTBBAKiFoeJ4OJSdLsKQrK6SIHZcZHJ1FtQhJDUjpNIAQYtJW7hRTY6RqHQ?=
 =?us-ascii?Q?rx8cHoQDUnLl5D0wn+mpbZBnBABPS9dkvbPDEj00KZ9qPOqWEr9haGAI5TmT?=
 =?us-ascii?Q?hvEqB5SA0IjzJOuNYLc+tGxO22xo/rpx/0BVwhqZAivg/tz/9bgfF4Uqnd8L?=
 =?us-ascii?Q?Of4YZC1ykQq4Ea0HlPfcU89x1sRFCYxp1ASZB35XPROErJYO2qLbFea3e+nM?=
 =?us-ascii?Q?Vwm9C+Cu0wJibwcZo9soPhi2MI6MNTmvW+oWUT59yaOV4psfAcOamqLUpKTh?=
 =?us-ascii?Q?L6v4Y6NZ5j/GlUAMecpiZOxvinmNt1MwYsV/tUgBzfoMoERQJ0/DhslK7wYd?=
 =?us-ascii?Q?HzjJlUxVNU+0iz7nEQORK64gktf1h4yl13WMQoH5pMwfVGVbQiVdJrwx4CSE?=
 =?us-ascii?Q?RvsDcAl56YKLvWsT817XodV0x2sFzn0OkMioUcpxr4tv5vcrAZANsW21CA15?=
 =?us-ascii?Q?KeMySynV2RfOsCeIy2akqJCDlkE5jNVFSN4lq4Ym0DVLjdf4K4dISzIAYitN?=
 =?us-ascii?Q?YYXsGpF8lFy0T0pIbWsxd9m4sJDmy7oGbZ4kUEgm9OrAjPZxv7ZLJRRMeHXr?=
 =?us-ascii?Q?qHi1ooY646yKdXDvKt0hhXQWl49hlWINdN5/6zQMp+syspwUB7tSar6SZ5iJ?=
 =?us-ascii?Q?WM5vzGljmDgvgiY6t2tq/KU8iNX8PrTx4PrlqzTOQvU1FkI1GpzehA7AmvlE?=
 =?us-ascii?Q?QB5YD/IP53QGiBh/KDpaej0L1xnaQbATa7Cb67Iwu7tbbL66ZUo1KkNKO/i5?=
 =?us-ascii?Q?PEzFqL4sHXfacLSWiboXpfE7ghTPbqh980J/BfeWi2dHSYdR9QWw/x3Ge14b?=
 =?us-ascii?Q?lf1O3zLOlQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b5af26-9e9e-4310-0954-08da23675650
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 07:19:56.5379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOQNSD3El42gHP1kYMOowlxbg8IhIGUpA+f09H0busB0SK2DNHdgJ3T2Q/QRMuLumevgvQJTYcZKKQgL2TtDnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4912
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Disposition: inline

Andrew Morton <akpm@linux-foundation.org> writes:

> On Thu, 21 Apr 2022 09:21:06 +1000 Alistair Popple <apopple@nvidia.com> wrote:
>
>> >> As the wait_event() condition is true it will return immediately. This
>> >> can lead to use-after-free type errors if the caller frees the data
>> >> structure containing the interval notifier subscription while it is
>> >> still on a deferred list. Fix this by taking the appropriate lock when
>> >> reading invalidate_seq to ensure proper synchronisation.
>> >>
>> >> ...
>> >>
>> >> Fixes: 99cb252f5e68 ("mm/mmu_notifier: add an interval tree notifier")
>> >
>> > Do you think fix this should be backported into older kernels?
>>
>> Yes, I forgot to cc stable sorry.
>
> So we have actually seen these use-after-free errors?

I observed them whilst running stress testing during some development. You do
have to be pretty unlucky, but it lead to the usual problems of use-after-free
(memory corruption, kernel crash, difficult to diagnose WARN_ON, etc) so I think
it's worth backporting.

> Some description of the end-user visible impact is always helpful when
> deciding which trees need a patch.
>
>> Do you want me to resend with
>> 'Cc: stable@vger.kernel.org'?
>
> Thanks, I added that.

Thanks.

--=-=-=--
