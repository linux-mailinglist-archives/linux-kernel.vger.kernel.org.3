Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486CB5A70E6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 00:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiH3Wj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 18:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiH3Wj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 18:39:26 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABEF6EF0E
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 15:39:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLIqzTO2Oy5McKIQb4sFPB69xhmkbA4G3wlNwZKsT0g8jAMUcQWcKJX1nH8EF9Suer/0ZiOWoqc+h/Ik4izWxWL6Q35YrCykcie7rGBCdSrVuY3DuFTN5BbhACkeFzp+RoJOhTHYsYB5LvuoaFyvgdbbolPhuqv7YNetv00E3/m6Sxi66pS34DGRnS7o6cZx58xm3RI8X3+Hao2S8MvFBnSJdPVLnniuRirQQmZXwFP75GldkEz04+duYlSh5OqY7mPsXk/AO450+rBOa24KjsbUAQbh9AEwGJ+abFRsPqZy5KnX5cgFiI8NpyqYawc4dR7ieogp6ENQZjS1PYXXew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23JZQn8rU1aHeHqhTRNt+/moekb7Jv5dwTqWdgkF1DI=;
 b=NpLZuSIA9m8Cm1FBpaczBn9uBMCvdqBlnxTvjojv+dGHDBR5bpQyhvY7/KQXrGSct53tkCPqKR6Ku7GYRj2TpiPF8p3nryr7YAznWa1JLUaNI/Kb7krVYXL9l3GYxzxR26EKTN4GZccPKF4UTkRiIUU5nNS1i/k/FjJQ5K8nP3e4Z8Xx6wjKR9TPWbDuCyCJMV7tsSDUrgvhbri+zQTeiJo18v+PQgNjVP0ukdT4Xf2eDwXGBkher9PqcEfTgL9dRXkgzCiSFOMXoEA2vAPyb/K+/RKUqRrVRP+uVYsxSc2s2sPOW1K7LSW+ZqLJKh6QuTSxd6KW9BtdYmUoFP3PMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23JZQn8rU1aHeHqhTRNt+/moekb7Jv5dwTqWdgkF1DI=;
 b=IQhADT/vAnrLy6lTQ0iGusimHbbQed9u6NzyJF0Knn9zugSGjV5d60M2WXrv/W01pnRGIXhhC4a0W80932u7rMu4S31NWguJuFUE8tvG53kbJZq7JbZIlRg2d9fISYGh8dbiI1RYwYF9RC7zlYQXatxIT6yLjgL5sFZw6GFF+0QpGw/biuTeB5yRMX3XzCj5p2DO8eZaaQlGDZZzpJPeu+99MH+EYwMMZkogTT2Alr8RimuhhasQkPWn9VznsXp6vblaZ8cY1SYQ23VLmGgTcfyTK06pf/ikutoohbNi6dkYGjDo7IybgZESFZs+WrX1TKKsIhcApdNta+TPA5SQvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by PH8PR12MB6889.namprd12.prod.outlook.com (2603:10b6:510:1c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 22:39:24 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 22:39:24 +0000
Date:   Tue, 30 Aug 2022 19:39:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v1 2/3] mm/gup: use gup_can_follow_protnone() also in
 GUP-fast
Message-ID: <Yw6RmxslqPrK22H4@nvidia.com>
References: <20220825164659.89824-1-david@redhat.com>
 <20220825164659.89824-3-david@redhat.com>
 <1892f6de-fd22-0e8b-3ff6-4c8641e1c68e@redhat.com>
 <2e20c90d-4d1f-dd83-aa63-9d8d17021263@redhat.com>
 <Yw5a1paQJ9MNdgmW@nvidia.com>
 <9ce3aaaa-71a6-5a81-16a3-36e6763feb91@redhat.com>
 <Yw5rwIUPm49XtqOB@nvidia.com>
 <391bcb8c-faaa-905b-4dae-b674828a6a37@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <391bcb8c-faaa-905b-4dae-b674828a6a37@nvidia.com>
X-ClientProxiedBy: BL0PR0102CA0008.prod.exchangelabs.com
 (2603:10b6:207:18::21) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa41cc26-7bbf-4bee-d2a2-08da8ad87cf7
X-MS-TrafficTypeDiagnostic: PH8PR12MB6889:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CpjtC/AzpKd0YX2+3Pi0iS7DwTABu65yia247rx+rupN7j3Oc54UBIwMLq2uDgP2T5xZYAquyYxdGuassPxNb/v1HZ8+NZQnHDbenadX1pYcreQgm/kVypVube1d0AD5nlR5taWgjRcNqDBjgak6MGcD/OFuWBe6BmP/BJcGUI2cg3i2rndMfXkcwzO/uP6cJnX2qX6P48QW31CCqm9vXPx9uhejb15JASxlYsTwEXK/hhb3K9TJd2lygLUWVel0nbD3rdlm6f47TPQvl+x6RqK5/RRMZAfaNQ1EEStbt9w1e5QbU7TrsN1EfH9H9AXWxli5/GnmjO/GlQo1vCw/mVWCHnW8Qe9k41aKy9tsm8McQGvPkxzG3cmH7PpQodA5VB8ew99nP4X9vSgah4ZTEvcbrrAZnB8gabDoi6KZplHaWkOTsMBnAN8Ld6eotQgAIlkoMQ31sX93t7Yul4dxuSHfDHaERrBtGIg3iao2aJhIw9vb4H3ANwVJRYDZUyf/HXwlRouH/ZYHVUdDZkHatzKH533LZdpXYVdFTxHP2KetEtdJgzlHe03AwoKFHh6rfYRJ8HdGvKT2A0NuB+eX9DpduyaTEQ3D2fEtDD8xfXcE+BwaAskr3lMJfPHXGkqy9wgcpUJ2pp9Dc4JuGsSLVI5lM9n3g0w7F5pTPboGYNCzI7GIAEEDLeRj6oEx0C+bC4ShGTItzZJZLpMDKBWz+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(4744005)(86362001)(8936002)(6862004)(5660300002)(186003)(2616005)(6506007)(6512007)(66946007)(2906002)(26005)(38100700002)(6636002)(37006003)(54906003)(41300700001)(316002)(36756003)(66556008)(478600001)(8676002)(4326008)(66476007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i/1BLOT8FnS2Nz05LHt2ab/7vNJspFwP1KAoIh1tsigfCkzVWMJKxbNXMHl1?=
 =?us-ascii?Q?9h5NEyUKcIa5+aHV/10qe+fvhMWOzqDe8ym3804WxRJzBHrnKRYMV4fyL7Kt?=
 =?us-ascii?Q?h9YJp0WBc3C72PJsNJX7/obFvMsdHPZPTCRZZ3nApyd4qsSAUdcp2GFKk31o?=
 =?us-ascii?Q?xdCuN8YXNCcQdZ/Xu+W2irdTu/TVfNBGixBvAbn5zouzMYKmO/uOJbUJSLt9?=
 =?us-ascii?Q?uYQYPxjVLZ0G/x+5k4x7g6lsbrKOn7sbkJ9EjYkmHC3zWevcjKWndevg9Ptd?=
 =?us-ascii?Q?FNVXexSHPw9mkPBiHXm7dicwRaNXA8xExPC6dvDQTuSPH473LGxU+tlcobAe?=
 =?us-ascii?Q?klK6G9CH63w/fDzn2HI2sD8fKUa6ueo5eLV1i7zBPqF71kLeNriJLcn9LTH0?=
 =?us-ascii?Q?KBAEXyIkwP5hhXBixXVvgdnPESC7+ErjwWWKbFp1VvtcXN01armONJzYijVw?=
 =?us-ascii?Q?JOFIvviC2lW8IIwfpC3p81X+pL/MGkR4Td9vPFGFEPiyFb/YR/JY+srOlmsD?=
 =?us-ascii?Q?fVf57lG+ruq1VOayKo11POaSTJUOvwiFosSzv23sg8/42EHoUl0nuaZp1Bl2?=
 =?us-ascii?Q?RMcKqpmvaxOsFyxFHZhGMGIc8ZCmGB/5OoRKpoV+ZUjpWwlAgoaypdMcEwUF?=
 =?us-ascii?Q?dZNKOeDBpfw0eLdFql8gAShxBw74MHSbUKPmZCWL3+PUdbCG1ICruHZCKWVz?=
 =?us-ascii?Q?s48EkmaiCkjjmiF2tlnb8K/c/Q74esaZj6hbTXvI+BUQuyUachokYIHk/jHZ?=
 =?us-ascii?Q?bYdSN1E8oyOmsHDn7e5y+D6uZK+uM2gbmOsthy+SzEnf6g4UmQzymv25TlmU?=
 =?us-ascii?Q?w9IwR63ECGnUv+fbObix4fLdrZML3XujOXtKlpSZdDjxphqhvDQekg/Skd07?=
 =?us-ascii?Q?UKXK/TazKI6lnt2TGNREaZ7HeJV8rjiJhqtvqKsftBWdmdmGHpvwysFegtU5?=
 =?us-ascii?Q?Zqe+W5TTONY4NG9GB+p3Y8BdtOWCm+7pvL/eqqUxjvy1SryILB3T61S6Om0C?=
 =?us-ascii?Q?dKe5o4oQhL41b3jH3GTWMGR3buUU+sBZqv7oDampqq0NRRJTUuv+/ELGIhhn?=
 =?us-ascii?Q?denrGm+/W2QBe0EgCCEAxq+755Phd7REswVQy1vGJUy0Zmlg6qTSuMet9WsU?=
 =?us-ascii?Q?C06UQLbDYkCqv0F7niZNAOY5rxXLRh5jKtfX1bTvdUQPzI7pLNLY7+pesx0b?=
 =?us-ascii?Q?ymPm+5IG3Cgrf5wHPd0Ksqwkwuu9B0MbN385+zxVQM0kTbqkzbI8D6FqRxSI?=
 =?us-ascii?Q?LlpR5EdG7Vv5XNM+SsV6KOPBENyAkiwTEEjHfYp3/OngZdKmTQqHYQldaqXz?=
 =?us-ascii?Q?9TQ0inkB67WOUqsdAjv/qFspuhN/tKBhQUj0YyyM932YX+A6JmFbzzMG4/z4?=
 =?us-ascii?Q?KivadWxhCvZH7fwFRdLnT/eR51q6AT9E4bIqy2fIIYwz9l9MEI8sSGj7swah?=
 =?us-ascii?Q?1/ZTqFgaQOsS3Y0j/i6EhT+u3S4gwStD7dIhPrDI+e/b3k50WW7PZD5onqYx?=
 =?us-ascii?Q?CFyJfDEO/VsFF78QV/4oYPa50OuFLrqNh7ExX6axygNEcuIdPfus0h547LIT?=
 =?us-ascii?Q?SNySRHfKratajMIRBkrYglNJ9oLY1WOYPUVqk0t8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa41cc26-7bbf-4bee-d2a2-08da8ad87cf7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 22:39:24.1781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CW2EZKwOffpbGEEbRWpGWzGaKAP70P/HbCrpoSzYwJUC4Oyc49B3G4B+EGL74K9r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6889
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 01:12:53PM -0700, John Hubbard wrote:

> As long as we continue to sort-of-accidentally use atomic_add_unless(),
> which returns a value, instead of atomic_add(), which does not. :)

I should say I didn't have time to carefully check what put_page was
doing, but IIRC it is an atomic_dec_return to decide if it should free
the page.

The conditional is pretty much inherent to the model, because 0 is
special it always has to be checked. Not so accidental

But you might make the case that these could be the relaxed versions
of the atomic...

> Likewise on the put_page() side: we are depending on the somewhat 
> accidental (from the perspective of memory barriers) use of 
> atomics that return values.
> 
> Maybe it would be good to add a little note at each site, to that
> effect?

It would be fantastic if things that are required to be
acquire/releases are documented as acquire/release :)

It is incredibly subtle stuff and all carefully inlined for maximum
performance.

Jason
