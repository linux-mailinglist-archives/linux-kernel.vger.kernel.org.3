Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698E94DE483
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 00:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241519AbiCRXcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 19:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbiCRXcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 19:32:01 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBD030A8B5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 16:30:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mm5y9I1uDirc7PQeqoRPsRqQGkr+WxbFBarhKBP14V7oG4FU42K55G7jSlGzJWrCQBz3jmIuYmZBp6Fcwnbj1FUy1IuEJXIx8k5zaod8vVTSLL6OLKCg+B4vmPxIWmBAKswmQhT5Q8/ztwvlu/nON/E12yx574Oc7ZZcXLRyks6XpIviBbfuetaX2ll3bBZzuqyz+nQ/mKzmRKlrxGDuwqpoB+X1PELFkfo8KbMBDDT8Lw4GSr7mSzL327Ss5LEfSdBz0ZOrAk3kSz/ada9dv3AtFPorX0dicP8HwbZGhJ8FTsJzZMTtjx6v5l43SvTp3xQ1XmMvwYZyBV8U/xTxqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/WCB5RvjtRqB+QmEaofINesX5cFaJn5ReJPvBKqEG8=;
 b=jvmIl5DzbFFNhfIG4qyQqgcnRLmM+w4nO5vZ+dq9iDnqTYXQyS+1Tuz05spBPw5XCjwOFvGaD2la7jDxVGLHkL3P9nBwwvWGDINklqqS476xy/SqbUwdmFyaDQ+yt5lVTO429KCMycdmqhsRokOjbugsU9zIUCfscXJOX+2nBS92LHqnR/VCl2Q6637QgGm3BoIFF0w3/rssh53tDlmlLH0dErIFAjZUJ5bRJCQ/PNP37bmpBIvBv2UBKxRctjmrtfb4gwiWeAg2dBVRy4iL/RhWDTMC4D9Td6hT4S5zbywiyCpzFwFugGXRqIIXB2SwV8CzC4XG2OwmeTSzGyvTIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/WCB5RvjtRqB+QmEaofINesX5cFaJn5ReJPvBKqEG8=;
 b=NacEL2n1MeRJpV1ak6Ol7GQjDTyecfGM7o392ANWVKgG4I3ow+hGLWDdyjF+n51zWcUIQdpKyqrCys2PbiEFYtCXLVhSrvQcP4Ngaou+r85aJRGvowdJ7yMpevko6VHdtgw6ay5Rz4PztIkqRsUFmwGlv1gdffmuQCpKGI3Cf+93cbp5OICt1vhF3+soeNvH/Om5s2r9nLAZogn7NOCSoge5wbc8JQqFn9qmZrQYrduobbXaLxlUtl+X74wvandC3m3weoU+/ZgloQbTsSKLZBJSjb6unXOPe2T0YDEGk0wzN6obb61VioNJ/xBKNrx2L7JBvsEQeVwstUQfY7YqVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Fri, 18 Mar
 2022 23:30:37 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 23:30:37 +0000
Date:   Fri, 18 Mar 2022 20:30:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH v2 13/15] mm: support GUP-triggered unsharing of
 anonymous pages
Message-ID: <20220318233035.GA11336@nvidia.com>
References: <20220315104741.63071-1-david@redhat.com>
 <20220315104741.63071-14-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315104741.63071-14-david@redhat.com>
X-ClientProxiedBy: BLAPR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:208:32b::16) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d08d2bb-ad47-43f1-0540-08da09374e1e
X-MS-TrafficTypeDiagnostic: BYAPR12MB3479:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3479EF581358C0F441662F46C2139@BYAPR12MB3479.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qUMmlZmrtT+r/77ELamS4fP6ui/cuSiY5vy9HG0adv4dxpcgWz9hD5VMEUcdEYnpGmQkIGZS3IJwIp1X8ORONeL1FD98iZzLTP0CH5W7/gUeCKz7iDKWVpUDO34P3c3KA60j+Ig+0hNKwsyQq3+riw4rH0cuPpGL7dfr2mpBdFox8blL/tNpW3/pQw2T4PsR0EFIgXTgBxTkLTS+VuioTbA5icih9mhJAOxki/N03XQpQm+GOSoPGkiSyP7+kgwOURkl4FvUIPug8p6pYYbZTO3BMUwMXkUwJMil+O/3Wu9rMIpnZMBUD02hLEC2OUE+pfu4hmehXTgw1/KUWakKO7aEkNWT3JSnSmXBeMPmCtw3a4+laN1+zeXRxPVNcqKPSXaV4pRK1fFnkYPEeoUHkdASS9MGAmyr6LAjWXK12bcTUTypp8BcmlTfeQtP1CeqRuNVZKeEROsaV4phKOtd5pj5Y/q5SvIojXnTO8mZGJ1xIBHQGHatAE8ONAllenf+MqBOCXNnClrNnW975x2Srti8JtVNaNd1WewIWqzz6AXDQd1A+FBV4BIBWEJhA3vNhhcdgWohggZwQZSvM+HHuTQj8/QbOQnHnpz1tbh/dtlXfxrMXzQEA0Eh7lZvVB3ozS2VMtsubmtt8lIM+dWVKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(8676002)(86362001)(5660300002)(38100700002)(4326008)(66556008)(6512007)(54906003)(6916009)(66946007)(316002)(2906002)(508600001)(8936002)(1076003)(26005)(186003)(2616005)(7416002)(6506007)(6486002)(33656002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oHbbC/1m2JAlug6wYIsjNYUgdBdirMmNF5aw3rxybCo+xQAQLWLnR9T7vAdd?=
 =?us-ascii?Q?ffLHvaFJVlN/2OWiEkSpVg/3pAvijFOHGUsL3OebqpEu6TMg+to9IfbuTSDv?=
 =?us-ascii?Q?IYe+ExDLNArsRJn9p/42aW+1JyCVUdO817MEwkpPH+ax1+BDZu/AJno8zibs?=
 =?us-ascii?Q?kcRs1+/QBzs5Q8bM1OmVRQ36ef2a6WGtNrdvNzNu6dlz+0JHtgCCZDHuQCey?=
 =?us-ascii?Q?YXf1TIAYdaLg2OpUZLmQ1KvmfWCD2mQ2pgstvr3D435WOZT7JUV3QnE/b+fE?=
 =?us-ascii?Q?C2nCHjUXCfHqK4RPzwjhSAQelCdbrCnA1esvkPOuLpyECXVdIu/vjPsCyeWS?=
 =?us-ascii?Q?nY+6FoX9MR75oz0gDrrBAb8UI6qt/pvREI8vQDy2KZ5Jr1wJvViHJ5LTDcP1?=
 =?us-ascii?Q?vx6z0L2OT7OeWR8oooZx5K41IU7tCpdnCPiFSoEQFmln0TJCIwcQ9iVBUxEK?=
 =?us-ascii?Q?rNNfkonyNPsN1wl7Jm3FwnS08E0yJ412qgDsdwX+tZgDL1K8iqEC6PGD+LBx?=
 =?us-ascii?Q?YmvAz03PIJWYEVGNqUbV4cZfg19iLFuiNFUlYruoqpFvqeblYAZK+nHqLBLO?=
 =?us-ascii?Q?0uNknfwW4Rnx/4+ERHO6I5QtzF9O2+nav9w3b1LId2eaqQJzI3XbhFt/pWXh?=
 =?us-ascii?Q?Ufm81xOnlXgHxHVxTc7Bkeu7NG7Gg0NAWySbUZA6Nm/Xp5J9W61zRH0i7y24?=
 =?us-ascii?Q?vY5Knbj9xj0XZ5G1/7R42W7k1XRKlUdavrNda0TtaVY913R87Nps5JjyM2V+?=
 =?us-ascii?Q?O+XMy1vpZ0pfjqCr/3d/K9p991TUBUWzCbPBKZc7qHQcWn7Y5tt1qbnzVLKW?=
 =?us-ascii?Q?qsj+mNhBafvBpM+nK8ZQoDHjuivwzSLnyvAI3CvYHZXJP90GeE4+QzfzkOFp?=
 =?us-ascii?Q?l70/vKCNlcANoFBD00I8EFmUC5YbBObDOlEpSbwQfrkwIOZesl8XlQax9rqa?=
 =?us-ascii?Q?ryO5lkJ9xBWea2hgJUe4ejizLPU7Tb929bmACogNljrhIIXJ0yignLKQiCjb?=
 =?us-ascii?Q?+yuDZY0U3gxCR6FXoqmjDY7XzU6Ydhh52tcaRYPMbNe/PvIIGsRRWPlg3u4p?=
 =?us-ascii?Q?3kyO+jiNCqKYo5U6t2R5TGL1C6ny3mKboqLd8tE7GNvqz+Jh891/wVRTlUXX?=
 =?us-ascii?Q?bKR0wHCGA1ly+x/Sm2WT7+4V54sXcT6OlRNpO5qDGIrVhRY24R8kIazp/L5u?=
 =?us-ascii?Q?8EK4cWwr3kkZK628qS37wMvIxjnZNFO38R8Xe60eD5Ztwo3GkKlhKGwvo7Xb?=
 =?us-ascii?Q?bv0ERW8kpgu3/aX3Zet6mvMdP/RRHsWgH8N/K1l0aazPZk6+IdhXAyAIwPi6?=
 =?us-ascii?Q?5B5ZPa0m1s9Z+rumsJ2QAGjMQmpb580HzFsZsMOLK05FRD3jFrglhNXRQcYz?=
 =?us-ascii?Q?hvbrsjNkaHRQ/xvwRuRcyVygG0dzhOw/MPICNFZRwtB1ab519k82e/WJlj5X?=
 =?us-ascii?Q?PyUzyNzsD1QFfkgaV92p64hxrxYSDIKk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d08d2bb-ad47-43f1-0540-08da09374e1e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 23:30:37.0279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/87JDeun022Y+l7KNqJo2mZD4g4TYDQhzSsRJo3sZ8yH6u/uBjGmen8hXWzsV9u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3479
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 11:47:39AM +0100, David Hildenbrand wrote:
> Whenever GUP currently ends up taking a R/O pin on an anonymous page that
> might be shared -- mapped R/O and !PageAnonExclusive() -- any write fault
> on the page table entry will end up replacing the mapped anonymous page
> due to COW, resulting in the GUP pin no longer being consistent with the
> page actually mapped into the page table.
> 
> The possible ways to deal with this situation are:
>  (1) Ignore and pin -- what we do right now.
>  (2) Fail to pin -- which would be rather surprising to callers and
>      could break user space.
>  (3) Trigger unsharing and pin the now exclusive page -- reliable R/O
>      pins.
> 
> We want to implement 3) because it provides the clearest semantics and
> allows for checking in unpin_user_pages() and friends for possible BUGs:
> when trying to unpin a page that's no longer exclusive, clearly
> something went very wrong and might result in memory corruptions that
> might be hard to debug. So we better have a nice way to spot such
> issues.
> 
> To implement 3), we need a way for GUP to trigger unsharing:
> FAULT_FLAG_UNSHARE. FAULT_FLAG_UNSHARE is only applicable to R/O mapped
> anonymous pages and resembles COW logic during a write fault. However, in
> contrast to a write fault, GUP-triggered unsharing will, for example, still
> maintain the write protection.

Given the way this series has developed you might want to call this
FAULT_FLAG_MAKE_ANON_EXCLUSIVE

Which strikes me as more directly connected to what it is trying to
do.

Jason
