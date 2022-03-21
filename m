Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDE34E2DB8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350995AbiCUQT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbiCUQTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:19:52 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3943C4BC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:18:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayqwIl6nSHXOMZhEL9vdSZktKz8mFo2+19KqwFwFd3TNBovl1pP5vxxD/D8ZJxdZmfcoS6bwIYYMiTz0BY9mjSMnRpFnje0+0w9Vzcsmh+P/xUFrHlJklzy8X25tiFoWfFC51x86nHuWrwP5RS51KQ35dq7fJZuvQw9/kllCpv13FhAEuZUTHNvclsxmkrOpG3qtWBjtpWtpXIyVtHlOCZOQs1SzvpWIDaUWrZlfKs5bnC8nU8pR34f6beuWzuyKtQ8ezMizXNE1ekyMfT7nYRVZ8k0in+gnZMVyTIYzmoS6NHZ0eH9Xkf8Fuuq/Y9gLn7NsFj3EN/sHkt6oNpMbmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2uZSglVJLsG0bqxkB1ZS6kABztZQy/xln7/IudkhFo=;
 b=IbFb+AuhSf7GILo+dHMCeYa9hUJ5wsAuvFV7/m8J/mGirH/jByuXzVF4+kHhGrSnnwT58nvIuT52pi+E9aS5ZaZBmpbi+8LYBkSKMk9YbmBYtYB6d37tl1QmMKTiwEljQ92+zpt2/LGOfPnsE6MWYjCf3Cco6nMG0xx8VugBK8bZ/3usD0nrrOjzke3+Tpvn+a4ciItE6jSMG6JaavYhTdw2GTMzghwZe1f6LRipsAdL/1qEd3Mssit+Z+lqILdXIGQtt/vwEFCp0QZiM0UkcQx+n13iVndVY5iSWWurzZNGu8CGj5Gby9uNO3PbGB2BAzzUUiOYUJs5KcX4mP1EDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2uZSglVJLsG0bqxkB1ZS6kABztZQy/xln7/IudkhFo=;
 b=hJtAzghXra6sZ0OKW8bnBZfLBZNSUjlgaFzNCfktXWbSbWfWYqLFxvfKM/SfzIx462aM1io82xsnigvb9px2I3SwcUDhrQc55XzPK4nhPQuSx5ix7JwpKr9L6GCr2K89Wh11zMDTrqsJlUszxEtQkuy6dnqyfgP8eVcGNl0lneKmKX5OWlA5gxm86QQYJunGn4YX8j8FSdTixunoenIQTjKyzzaBFmk2jmR6TWG8ppUyTtX+AmX1FJoYZB4L1apWGK9xNOded64kJwHf95gWIachB+Wf1SMooCORniC/K4TQcEDJSF3luTW0QkVbLKK1KOgCSo8WkIYuq5792GcBXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB3978.namprd12.prod.outlook.com (2603:10b6:5:1c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Mon, 21 Mar
 2022 16:18:24 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 16:18:24 +0000
Date:   Mon, 21 Mar 2022 13:18:23 -0300
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
Message-ID: <20220321161823.GZ11336@nvidia.com>
References: <20220315104741.63071-1-david@redhat.com>
 <20220315104741.63071-14-david@redhat.com>
 <20220318233035.GA11336@nvidia.com>
 <de543fbc-0051-120b-c91a-74cf4dd6156b@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de543fbc-0051-120b-c91a-74cf4dd6156b@redhat.com>
X-ClientProxiedBy: MN2PR16CA0012.namprd16.prod.outlook.com
 (2603:10b6:208:134::25) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18f1f3df-1ba3-4d50-2496-08da0b566caf
X-MS-TrafficTypeDiagnostic: DM6PR12MB3978:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3978AC19FFE3CEE2891D38FEC2169@DM6PR12MB3978.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ZXHdFnU5aGDk3TS0KG8wkieWDu6PxjX/dBLWNLB/gs6IY50aNV67vTHCarPaKHLG/aosCpIidpK8Jwsq/TjhnL4Dry4Bm5flevMGiBgli5VCT8+3Zbrdk6iNreccFte2l3fQRM1f3Kh4+PLPMFX0s+ynJVnAOHpOwFgn6ueuXsFPnLES3uur2Y1Ig6HjSkaB4+7XuOSCu9yVnaUNc6Gf72PaMmc+e7UOeqQk3nFJs5g99EknhvNicpk2aq8p3UXNBb5ZtastiwH5NjGHBz3spOsRGkhvH86CMlvS+wt5KViFJKWBk0eAq4ZC2ObbQyyDlH4tn8wJw+yy6nzB7OiUabH5hmkpftv1v69JW25mlnR8tJXqtvutNK/hk+CfHsG9T2knQFFqazU4m3MTaFYB1p6WOdJMO98SUgnChqpht7MEGkGkXTqKnpvIFp0UKLtX2BQY8Q6Elveo4gso6f2jvz9p6Q0LdwvoqDZ2t2wY1Fg8KMiQAaPk+1CBkD9vnCtmcldQ+1+EVyo1X3RF1qs/mqnx6hNDMjQI6bd0KdFC5DpYHv/K37YMg3chDlEJI/Inpe1CGNGkPH6BzbSDy97x/tl4aH2hqcikaSvCOWrcPrlU8fUguCrN88lSLfE+teaaPMTPviS8QSyx6XNG/XBZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(36756003)(6506007)(6916009)(54906003)(38100700002)(508600001)(4326008)(6512007)(2616005)(8676002)(66476007)(66946007)(66556008)(6486002)(2906002)(7416002)(5660300002)(186003)(26005)(33656002)(8936002)(86362001)(53546011)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4l79/j/nSkD8DQeQ4iFzPVj6bEmdhMNzBfG+TQpXAhEalhjEs91djWLkWFGf?=
 =?us-ascii?Q?pSq6gpiDse6cspdU3n/+rm3ZiHIFxs3mdGk0EwHpF95V6W55Eemrj0wrYCV4?=
 =?us-ascii?Q?n0XWgzpgCezbx0IpZBEr3gPuo8XXSXIoOMj+ybf1+8ipRwMfRFXUbCI/p7Jz?=
 =?us-ascii?Q?IrhRcTL+P2zc6UCQ4Od/MBCcLQYQDJB2QtLFo4PHfqUNpwkL3xdpiOZERetM?=
 =?us-ascii?Q?iZvf96pdS070TBwc5p/f/n57wQ9s9VHokQr/12E85Jf6gw6i1OMHfgFOGzDV?=
 =?us-ascii?Q?cYj03Ah6Otcb2jzjD9OK7lGDYeJx3IzKFIMPMI8qqej3A+7oMN8jRbu8C3AZ?=
 =?us-ascii?Q?G56bzv10DUOJqrYVQ/g/kqfbxD+g8ksKIVQuBg3/LPVaLOe8tUoQKzRG18wG?=
 =?us-ascii?Q?WKOMKHBo36HutT4262QbQPoNuRd3OyrlkVHtxvGy4p3ORpFaiNNiip+z4TJC?=
 =?us-ascii?Q?+lXvkV/yu0tMtAvkvkV4lTkelCvUFT7rOov3+9uDtSPXV4+lPJF3uJ2FzKKk?=
 =?us-ascii?Q?5hh2DUsb9Hozy8nkX/9u9K1/+u8WzEP5QZr4FUc9+PIYhtaThvhNzFIGe8qc?=
 =?us-ascii?Q?dfror8mdhwknquRi4EngmaA5w/v9visRB13d78MthY+K8oAtOapRo55+hfdb?=
 =?us-ascii?Q?Edz0T8RXIleDT/YXPU9FTd5LZ6fDpBPG+dhKL6//GlBNtRQeJwpM8ZqNiCCK?=
 =?us-ascii?Q?auCXfxhwsTwx5sCCdI/Z6JGoudjuusMOqkRLpp0fTsVvwkMDQpeOzGWgOmvN?=
 =?us-ascii?Q?J3SAQTBY/3P2ZY5Dew8EnoiMjXxaoG961j4b0L/e0+L+y9gZvW/cjIJmIm3r?=
 =?us-ascii?Q?tIcSUCd7C6b1fTCrpDY8VjobQUJLXw/sVYj8k4kBJ9nfXf96ZiCdutrFyXQ6?=
 =?us-ascii?Q?uXEnWxj06hNaWojBWRGeU5rjOyyLmwjRD4KUOSytVljssj11VbG3znmSzxiH?=
 =?us-ascii?Q?a/mrrazQiAvwBNRnwPCaxoM+HILcF3AIfk6wpAKwFGEIOgd4/y45nFShFedk?=
 =?us-ascii?Q?bvR3TGBUc4QVZ9OK3fsQn3jt+xxJ57NunbZx9uGIDL0d4U/Gts9Glc/13+Xv?=
 =?us-ascii?Q?7eGiBNr0zUwqfn+WBLPDqSznWf8IEFTAcS29woFU0NBqC7T7hQ9WqmQd6+9b?=
 =?us-ascii?Q?lNEm/gcJZPRdyOVc9VdPjK+cigUeYKY694D6GmRpflowwbMzHAjYG+rM20gt?=
 =?us-ascii?Q?sod0hRJxiRbg0xiMWpthYZ7OXAJPz/UnLTtHrMX5zZsc/BFz8oZUG0bwe7No?=
 =?us-ascii?Q?IPxzjjHonKoIuwRPJrl2KpsT8pyz2YSNIqSkMLBuK/+Dus+fotRyqG6hlyGh?=
 =?us-ascii?Q?uq0HUb4SNi80KnMRR+FkRZJWh3qW80ZfkXE+pfA+Y0VbEK4PHeadcXL7KAwF?=
 =?us-ascii?Q?UR5JVqwMMmNrJ/mmCZE6wTFdUHVF8tJ4nRBx8msXIQIqr4xuKW4WjLaH9g7C?=
 =?us-ascii?Q?AlMq1nMspMh5plOdpJeEqEBWc4fe8aNK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f1f3df-1ba3-4d50-2496-08da0b566caf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 16:18:24.6731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X+yWLspmEAFWeMzcof1l0zy13d99QX5Wq+ampRim69Papxwlglgu+nfA2/MApPiz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3978
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 05:15:06PM +0100, David Hildenbrand wrote:
> On 19.03.22 00:30, Jason Gunthorpe wrote:
> > On Tue, Mar 15, 2022 at 11:47:39AM +0100, David Hildenbrand wrote:
> >> Whenever GUP currently ends up taking a R/O pin on an anonymous page that
> >> might be shared -- mapped R/O and !PageAnonExclusive() -- any write fault
> >> on the page table entry will end up replacing the mapped anonymous page
> >> due to COW, resulting in the GUP pin no longer being consistent with the
> >> page actually mapped into the page table.
> >>
> >> The possible ways to deal with this situation are:
> >>  (1) Ignore and pin -- what we do right now.
> >>  (2) Fail to pin -- which would be rather surprising to callers and
> >>      could break user space.
> >>  (3) Trigger unsharing and pin the now exclusive page -- reliable R/O
> >>      pins.
> >>
> >> We want to implement 3) because it provides the clearest semantics and
> >> allows for checking in unpin_user_pages() and friends for possible BUGs:
> >> when trying to unpin a page that's no longer exclusive, clearly
> >> something went very wrong and might result in memory corruptions that
> >> might be hard to debug. So we better have a nice way to spot such
> >> issues.
> >>
> >> To implement 3), we need a way for GUP to trigger unsharing:
> >> FAULT_FLAG_UNSHARE. FAULT_FLAG_UNSHARE is only applicable to R/O mapped
> >> anonymous pages and resembles COW logic during a write fault. However, in
> >> contrast to a write fault, GUP-triggered unsharing will, for example, still
> >> maintain the write protection.
> > 
> > Given the way this series has developed you might want to call this
> > FAULT_FLAG_MAKE_ANON_EXCLUSIVE
> > 
> > Which strikes me as more directly connected to what it is trying to
> > do.
> 
> I thought about something similar along those lines, and I think it
> would apply even when extending that mechanism to anything !anon inside
> a MAP_PRIVATE mapping.
> 
> The whole
> 
> const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;

I think the extra words are worthwhile, share makes me think about
MAP_SHARED as we don't really use shared anywhere else FWICT..

Jason
