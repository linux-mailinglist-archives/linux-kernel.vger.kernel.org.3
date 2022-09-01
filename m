Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CD75A9CC1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbiIAQMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbiIAQMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:12:41 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5131E5F11B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:12:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bj7sD2jj5lxKczLibmXGClaW8nMYONaoIHy8EpqZDtQocWpJTHA0PCLMnMnBmbo98G3sfHHMgyQtApn/q4dnkNN9c8jTLdqPZs568o90VOMNAfJ0RNPho6EcgX/dVmmtQkrqyNbabYeN9diqg5KPu2HOZFDITxaQrZoTm+Ag5gYeJdheJcMIvdPy+Lku2iYI15gYbjC7i88RBZUpZmnSKn61YXP6s4Veh6CdGLPUc7mXfUr4x2CuvJ4jTl8QqtgwnVuIpOO2B+fUqbYaJ7syCJEp4PoYZj1BaYr8MBJw6do5Nr5PMVbag7eiccD+71ONJm3BCa83rtlj+Y2FzJx/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isp4kMHbDFVMPlzaXPnqg7e7eggzAKIZoaGlc0geB8k=;
 b=U0wAXhp/pMJLV7smDqhD92y7+d//IMQcOiuyk7bcgCUA9e5hlMTUMRTGx8m+Ymvpw0GWvl1atMMWBextPFNqekelftyTDIT9zEBK+NDqHuCjdYP1fNViWuVx1rE720CtyHCnTxJPnBzCfqP/cn8ObV7T/PId8R5azdRTnxOYsDME/JLS3aictpqHqFp4WKIqkUym2kS9vD2L22swNu23mUfUYM3lNC8xY7vGsWRYom0SE9ciky0zLgpxGxpbgpncFNJOvSKBDrBEt9wJ8Vhg4fd/XVDVg/+5Vq0NWydvM12uGR9BLmwxCLbt59Egjuq+qUHywxhsPp4tH6P1eU7L3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isp4kMHbDFVMPlzaXPnqg7e7eggzAKIZoaGlc0geB8k=;
 b=m4Da4TnGXEQJDw4JHtP+iODmZaS0cJimk3Occut+ZKK5L1uj0cAGzeaiY5hnn0b4mx2a8L8DzFoBxNsPNkHBVOEkaM+l3ZNthol+hWZCE2bVg5gLJCD06l8CSRS84YDOD4Bjq1WYWGwK4o1VTVZ4DW4zuBZ95uE/VId1P/w8z6b40vvjdIOickP2Koy6Xxmn5ngAhj9FJqWj9y23M8GUZMGgiTWm+b8cKWkjhVDjQh1l5FUp5adV8WAZs8RLBZICDJC685ARhsb0wy5UBXpMp7rOIgXwILOHJVarDv6T3RnSnwNBOaoM3HKqniuC7eoHFmxN6+2A8soC7d1nqQAUqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SA0PR12MB4573.namprd12.prod.outlook.com (2603:10b6:806:9c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Thu, 1 Sep
 2022 16:12:37 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5588.012; Thu, 1 Sep 2022
 16:12:37 +0000
Date:   Thu, 1 Sep 2022 13:12:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Sasha Levin <sasha.levin@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jerome Marchand <jmarchan@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH v1] mm/gup: adjust stale comment for RCU GUP-fast
Message-ID: <YxDZ86XW3hPcJtPX@nvidia.com>
References: <20220901072119.37588-1-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901072119.37588-1-david@redhat.com>
X-ClientProxiedBy: BLAPR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:208:335::13) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f0e5e35-bb6a-4f36-dcc4-08da8c34c970
X-MS-TrafficTypeDiagnostic: SA0PR12MB4573:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fJTySVWnu8zowj1NIP/eEUPfnmvgORvzfdeyzBQSbLVUbyfD7NjYB2L8isbAeXkOLMpxbk3NKiaetBM1NCZKh1CULQ2Gq/xvQ7OiXSkqibFWWr96d5Np8fNdBJz5kJNzFOWfcjWzsbfgXlm+MuSqWlwZNBspURFHWKmE9UWqDT4DkbPLh8WQBqfiEQw+m1tk3+PnK1ggPXqDS9oiyzNYHGcYjwIOO1mME8bM4Qa4AcMAXmFWl685VX4xJz/R+PsoRG1OanWVmcEouSAy5bv5rPMSFpFzMOLqfKcy9bZ9Vzb96VtSzux18YTF+xYwcQYJswbiZCHPapQgO2mkpYuxpKvdAl6FgzVMI+O6nw7yUHGGIDc1APvfUyJk9H+hL8WpQazY7P3ouFy6jhOZ4S3pnrF6UplzhAqhrFI8+RBJA/pWCdcsBanaU4ztfIv9+QWDzXii1wMs8ywoJ8d/R12RqeDG7rbN88k6eZvZhspLSbEpVFWRppNNPJaTTfVX1SrO4YIWnxJ8gDm+ztVMiFU/yhqbPzEXrTF0q0hgZaHRXiVMV+FmwS2QHBCaBFvBVGvBJR5tkB3AIT7bx8Zvh1yelr1VNY6RSnhA5woppg2PgqHLFcSgtws9Ahce3IKfzqsOrxj5AT+XR0d/lVSvlRMaKkoQ09kUQw8c1nSPFJMAtH2cLapWuLITk+LT8Uleb5vrTCvSxFgVQPZp2JgK07QqQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(38100700002)(4326008)(66556008)(86362001)(8676002)(66946007)(7416002)(41300700001)(6486002)(54906003)(8936002)(5660300002)(478600001)(316002)(6916009)(2616005)(2906002)(186003)(26005)(6512007)(6506007)(66476007)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RhA4bmni8Jn4iAlYNDOVHxNlB9TBaabF32aUQHdi2LO5reGDg3w8EbvXt0WS?=
 =?us-ascii?Q?bDOgSQ/auquX1beSo4lOSykVP1MTPkEkmSe9taauzBQdWi0ZuWi2v9Z6+BNw?=
 =?us-ascii?Q?EBG5nvLPAb9WEihSbAvaaIxj5r80Q+7ok94ZhAriJ0dFcpMAWaD9L58fMyfY?=
 =?us-ascii?Q?V3Cj0zA6k1yx97SnASuohUGLvm6fKVN3d5G/X6UrJX0nWipH61L2zqWxVTq4?=
 =?us-ascii?Q?LO0ScYTIC47AcJ0ju+dgsn2LO3lkGTm5wHEB3OS2C23ObublR/1EsdVcagG/?=
 =?us-ascii?Q?Q+OpTbktEKGM2GhzenDmBJjjMkqiZhzwczArQkVno8LRq/8mR/sPkWuHpVdN?=
 =?us-ascii?Q?rs9MlpUD6aW+CyR95ZHYhekVNvWYTlf3+tMy6X+Q+5o6ntj5287y4CRIfGfg?=
 =?us-ascii?Q?Eih7c9+M2SlEN2EEklEIYoLDBPiReIGnChC5RH8srw55Ka20HaIH1u/8tUyl?=
 =?us-ascii?Q?TUmZqkZpPL7yh+ISRihmdPzyOj2h4pop6PQe7Ek3ruJmmlVhrlCAgdg55dSn?=
 =?us-ascii?Q?7+VWakI9gf3szs6yNpH51Cx5Xh5dT0H9YHhBwsSIuOePAsktStlfO7hGMi6v?=
 =?us-ascii?Q?APhGbqy8E640y0HrPpTOS8msVZo7egz192PYVZ28e9pohacPhpaa6rZhx/CV?=
 =?us-ascii?Q?hUO/qM8g76/l6BI9SWJiQRuW17qzpMXJUIEeCIhZAn7dfUgK7a8A0qrO/iEy?=
 =?us-ascii?Q?aP5eIfLSNmY80V0M1pvD9JzpMF4BnJ/O6S0GGHQzRs9r0herTzqqNyzPcE7s?=
 =?us-ascii?Q?Fv8KfxXX/s2ULBAjpi7/sr/ZNP7b0iQE4jl7xf7k6VzfAYpuSgfCzub9hzd+?=
 =?us-ascii?Q?zV0GCCU7vSt6YrXoL+9qLiF5HfH6NHiBOt/E5yYUjjFMGQNz59gDZziXZ0lv?=
 =?us-ascii?Q?euXoFMwjmbX/zuH/0PBbpNz3lR15Gq33CVgBC6F5f7otCsEsejcH3zpuI56F?=
 =?us-ascii?Q?/5KSie+z0kxNSXRXjhjSREWOoIlCdJ7U6DSwDxH5LtUeFA/75xusHD45pLND?=
 =?us-ascii?Q?F8QMI+AiPp6oyEyExPcPCgDjbKh4idlB/cRL2qdq01EV3E1Rb87AXYaIHrLw?=
 =?us-ascii?Q?32aAbszYbVAvNhhnvwPWFGOIbylbvj1bAxcphEBtEXVJsHX9X9D9PNDsVQno?=
 =?us-ascii?Q?WfCszSXPFbms2OCl6DoMEDAdEQ4J12SlT6Keax4Msqr5QdcM0XhG+O9Fhl00?=
 =?us-ascii?Q?WZHFyHRs0n69PBISd6Sxd3X9CSo6wTRgvTtIpjmXCr1Wj7CDAkwEYXXpyfTu?=
 =?us-ascii?Q?phRNNdJTFHOklX6GK/1VGRLvz/Q2VaW5soMwSGxHJ2zYFnN8ctPRnELrblpX?=
 =?us-ascii?Q?2VSI/DeIhxbiUEyU5lN4v5wuGdyKSFdSyXgbvwz0Q8m92x4scN+SnY9Grrgm?=
 =?us-ascii?Q?pkQk85Uhhvu8hIRSwAE/bOUk9tFPt+A7G8Y3cJFzs1Lsbv70JZxi2dHG9gJ+?=
 =?us-ascii?Q?5lpi/+ES81+fQpoCv1FRHCB/MnVOnxIYnx9rnhJbURZNz9zANRF7OQ0mzJBA?=
 =?us-ascii?Q?wROR4FeYd8JU1pWlCU2Ws+xuCYFus/RNRXNhakuYu+kgguMG0DrUSdvi2W6s?=
 =?us-ascii?Q?W8zOwIoKk62DKBQ8yWYBQkoud8z4FWOrAGTWu5X1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0e5e35-bb6a-4f36-dcc4-08da8c34c970
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 16:12:37.5119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eVIzhl/4jKzdNjStRRY2zNsC4YXg6lvoDttuoschK1Ppem/dSyw2eO1d5TLIvDrr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4573
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 09:21:19AM +0200, David Hildenbrand wrote:
> commit 4b471e8898c3 ("mm, thp: remove infrastructure for handling splitting
> PMDs") didn't remove all details about the THP split requirements for
> RCU GUP-fast.
> 
> IPI broeadcasts on THP split are no longer required.
> 
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Sasha Levin <sasha.levin@oracle.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Jerome Marchand <jmarchan@redhat.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/gup.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

The comment a bit above seems to need touching to:

 * protected from page table pages being freed from under it, and should
 * block any THP splits.

What is the current situation for THP splits anyhow? Is there are
comment in the fast pmd code explaining it?

But this seems OK too

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
