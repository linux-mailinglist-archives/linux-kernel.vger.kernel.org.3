Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359985A6C89
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiH3Spr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiH3Spq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:45:46 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031BB63F11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:45:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSiQkPXJDuZNO+EBck5ennpMwK+iZvSae4V9P3s4lXosyP9xGNSS13/SY+i0r/9dPyXDezstK4FmhXfSePRN+jO4yr5yAze/ek9TvZCRQyD7O4J8/qzPm7gCD8ANMSoLjP4fscmIsEkXmC+zYSMAx3g+yl7zhqFWCXREwie7NrfE5lfTnrXSmLWi4U9V7tIXkYL00UujHWdTXMKd42db72MaVZOEs4jHsg6eiUPV+GBCErfq04+2c2J1uhvS3eo5muUNpmXTLyWufyThncwmfVP/ajzGZA/SABl45fDqRasAVy8pUSu8ESeBSW7LzmbdVVIl+FVkhAFv6igJmoLClw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axqLozOc9FhoUkiBNpYX3BcKVtvlIqFzimKWa2ylR6Q=;
 b=F8Wuf/BcSBXIAj+kl1LJTC34Jx4YZclwodKE1Ap8+b9oxdjFJydXgux+yrLHIBttf6nsR6Gfshky1IY5aGkRoFkkLQRLDlTvRbh9I1iY8V/B6Rr+IRqgABgPSIgFIsSOn1KOstqwS4IHTdyHLV49FPk/FS8z5te5QBil+SzCy8TMMr7/oK0ql1+l66brcEv8+6nP6NEAwIB3hJA8HbHVcesvlPfsEeC6z6g617o7uRaCSqs352/qj1xkS31lFt9SdamNlnaeRYwz+2RCAWNjXcLRJ/HDucJs61YI9ByXhOqacg1+dRXNUXxd7i0XdW0QekSsLRZ0ajxvfGFqafnHwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axqLozOc9FhoUkiBNpYX3BcKVtvlIqFzimKWa2ylR6Q=;
 b=gdsbQDcquh8GhUpcGbl8BlvFTWy/aQgP5WK4rOwyK3c/CCGMvfmxm2L0Ioo5Bl0J+Vaa/nS2SauBl/kj2WfxcPDOP5ByfwOC3Wd88r/m+Ah/1zXNbXkdISpiyhQhHTfjxpt6KeduPl44aQvc35Pd0E4Sq1sqEfxsZOaq5jEG+Mu6cIwMsYVBuCwR38VdfDIcPrJ2rsb8xWjEWbKrKJTAW0FcTER7AIu99rymYpNbNQsGqZEEkOYmqqb2XrzUUu4C0FZAeSaKaxqbXwsCDICb4wtYlNg/vC81nRh6hGHqQk7nWadFswf8x8RHWJ/DCqhay6poAHvutUDjQlDevIWImg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MW4PR12MB7215.namprd12.prod.outlook.com (2603:10b6:303:228::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 18:45:43 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 18:45:43 +0000
Date:   Tue, 30 Aug 2022 15:45:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        John Hubbard <jhubbard@nvidia.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v1 2/3] mm/gup: use gup_can_follow_protnone() also in
 GUP-fast
Message-ID: <Yw5a1paQJ9MNdgmW@nvidia.com>
References: <20220825164659.89824-1-david@redhat.com>
 <20220825164659.89824-3-david@redhat.com>
 <1892f6de-fd22-0e8b-3ff6-4c8641e1c68e@redhat.com>
 <2e20c90d-4d1f-dd83-aa63-9d8d17021263@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e20c90d-4d1f-dd83-aa63-9d8d17021263@redhat.com>
X-ClientProxiedBy: BLAPR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:208:335::6) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 958e5fc8-7ae8-4617-1aa5-08da8ab7d7ed
X-MS-TrafficTypeDiagnostic: MW4PR12MB7215:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 93S+rV+45oa7Z5+G8nuyy6eRQ1UoTmzWfE8JXyVNR/475ZGdJ8joDM+zZTnbwgiOtmtK7Vye6SYD6ciyG6hm5KRE9PVJ3pZKfU4cPGR1g0DEcRo/TW9uLnCO6BnhpFNIe3B3Pe97rslIyyWizZ7AzkUCF8Jpq1SE2rHzgu208bxkX2upDA1GgueYqLfgzUqgKrHVTmxobbvRJ8c2/u3GmUkSDMYxmOIMGIOQv51yZnqJVOpymuGnpb7RTTwNpEl2anDyElpJyV4CLmo/mz6NDe0Ou4KC2gclRjZGi0EjwPjOqgdFRdEpY3tlzS0EFYUZesoS0XBiWZ7USCW10ONFMtLEUV5iNpg1MR441v6/zQLYR2QeoknwE5vyNlffKTJyHwAoo8Yf3a410yfOVpXSYQHsmfd+rGhv8SmlzPkLU4JIBMcXVU6VjYBEq6LElbyaTmathHf3mgy3cDbPR4VxTx/ScdlBzzJFAg4uxjKgd70dUSBCCB6WQe8SeZBruJ6sIiLRNFy8ik20X/8AKyqRTSb6sa42mEmRdvEBJYjUNetHOCRC/YLEfv/ViHWnrWGmfk7nVpLV/h1J/ao8SHmtbcEBawnRe47yAqxvA3Pbflx+jUHXBaxOtQLq24L0ZoCOE0pPEi0/r24ldXh5QXziv/oe9BteG3fwS509vT/jgx05TXwWxv7RZhiw77FCr5Z4ohynNG5xGZ5vubg7/2yPlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(4326008)(186003)(2616005)(6506007)(6916009)(38100700002)(316002)(36756003)(2906002)(83380400001)(6512007)(26005)(8936002)(86362001)(54906003)(478600001)(41300700001)(5660300002)(6486002)(66946007)(8676002)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RPn4FZrNryjYqp2gLRJfN/lkk/EwUx32r/ysw/gP/wxTahHN9M6GoOFbyEvZ?=
 =?us-ascii?Q?A1dM8pG9nngPIVvj6K5Kpe99d5axkHB0KNlurLd8zIyHGZevkP60uo+c456Q?=
 =?us-ascii?Q?Mtl+4GdQVKvraY3j4oWZ7/c84yuohPh7L6iTNos2CTAqYrsfzVoDBBb+7WL8?=
 =?us-ascii?Q?7tpOZZPYXf3lopA/9l7cZwzDeRd5+ZSlOaT2XLLm0+sF4njFXKC7R9tlGYP0?=
 =?us-ascii?Q?nQWCGaufIuzGWNh9IaJKG6rmS6aH2ZCGf+AIDGN7gIdj2XfKQ2xwOrSBdfQg?=
 =?us-ascii?Q?q+xOzb7kDE/uekB60VNku4Hm4t3QXJR2yUQ5d0qRmBiXZBKaosaUMAE9TQzH?=
 =?us-ascii?Q?pmuI0biZhBx4E5OpjnjO00g+o1VWG4vh6bdJgb+9Z1oQqfIRL0A7hbZY8S89?=
 =?us-ascii?Q?pP7aTfeGQA0584KEnURCCd+BVo6ik+uSf2tqRb1ixC2YZvps7ckwvD6gyq+N?=
 =?us-ascii?Q?RQKKMtCPT9BSmngpybaxiqPHx/w7AVSygivuhsRxh7wSMwZPFn3q3iwirL7I?=
 =?us-ascii?Q?9N5In8sJbYqk8eRNWR/Z6pd0m9+O0EEpdbLpfQPzAUQ8K8N/k3XgyGF4yzPb?=
 =?us-ascii?Q?nTMnTj5CJKoNrdV0ewZTuiMnfothv/uAVGMV7RyHPB6Nt26qwi1gArKR+QFf?=
 =?us-ascii?Q?+TiWAvyArWRA5RTlkyPv7WWjARW+WUqnpWU72h2/JrNhZD62ANyH0eFSGeKb?=
 =?us-ascii?Q?80g8fOmRPoMg11nVjgR4kbtK3+UnKBUCK7u+bVpdE7TELHG5IYSG56MAkIOo?=
 =?us-ascii?Q?MdPoEP+arVJrUc+JqjqMgSbZTGk5t72K6N1cwQw/tDcnXH+JEuutG/cPPtmj?=
 =?us-ascii?Q?CtYJHmgByHqR3r5iN06dREj/sX/EdjL9+G8o2X0OlZh0k2y28krCZmUT+j0D?=
 =?us-ascii?Q?4y/oLoIz1YhUd+0t2XHbkb6eTYLn2JDw9+sJedgqhpaelYBZfhhxzyAociCN?=
 =?us-ascii?Q?p2YLHepwSQzF6cpby9SQ6csElQAEBlotpusLp26lPmwf2iRg5NAVjpnpCwwR?=
 =?us-ascii?Q?eZY5sgxe3iWHfpYrVFw087xZfr4lOKctKIxylsqjT5+0kjB3AQ+Abm9tLl6d?=
 =?us-ascii?Q?n/ksXVi0T2xhLEPVPsy0H+1zXUF2XOigTpjSdvA2oWcTBUCYhcGItJPo9/gC?=
 =?us-ascii?Q?Fk1oxxsTydKC0zXfQwYSoxgjxw+2Mca7mphiOwXHKynOVfdPdWJm5rGS2BKQ?=
 =?us-ascii?Q?Gv2RiRvcNK0pY7/sinvZfyowD886+PWF8ymsfhEw/W6rGt57MxKoHGU5/0xV?=
 =?us-ascii?Q?zg+oQEvmLctcADBsALj/lZ+2wkya0ihJeynYqXMM3SvfUqfa12WPoMx1jzkZ?=
 =?us-ascii?Q?pmlr5Tjq4+M3J7WdraHjAJEjKbTgAKHT4E2rAo68qaEX3Yp0GRX9vMicPD/s?=
 =?us-ascii?Q?eA0xX+PIqmacDiIFMdDWHsXWuJSzlGh7BTm4SRS/WVIIU66nCGVDAHqoYVY9?=
 =?us-ascii?Q?2KnpGBqGyFrJMQUabg76fKNQvDhhxt+yFL/cfjrm/HPDqe1AZQFbaUdzVVKg?=
 =?us-ascii?Q?F06xFoSntKJAFFQk6auq3Qwn9Jkf778hK8dFV7N4Dlo35rzXqqW40RigmqvY?=
 =?us-ascii?Q?b31yg8pQzPAWzkmONROLYeWyTCJVm7pGD+CquVL2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 958e5fc8-7ae8-4617-1aa5-08da8ab7d7ed
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 18:45:43.4041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Zf4Tlk+uisEMVPaDXlE+WaD6bJmKqYwITgd64fvQmbKX8LpsKdvQuuRR7N/ZubS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7215
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 08:23:52PM +0200, David Hildenbrand wrote:
> ... and looking into the details of TLB flush and GUP-fast interaction
> nowadays, that case is no longer relevant. A TLB flush is no longer
> sufficient to stop concurrent GUP-fast ever since we introduced generic
> RCU GUP-fast.

Yes, we've had RCU GUP fast for a while, and it is more widely used
now, IIRC.

It has been a bit, but if I remember, GUP fast in RCU mode worked on a
few principles:

 - The PTE page must not be freed without RCU
 - The PTE page content must be convertable to a struct page using the
   usual rules (eg PTE Special)
 - That struct page refcount may go from 0->1 inside the RCU
 - In the case the refcount goes from 0->1 there must be sufficient
   barriers such that GUP fast observing the refcount of 1 will also
   observe the PTE entry has changed. ie before the refcount is
   dropped in the zap it has to clear the PTE entry, the refcount
   decr has to be a 'release' and the refcount incr in gup fast has be
   to be an 'acquire'.
 - The rest of the system must tolerate speculative refcount
   increments from GUP on any random page

The basic idea being that if GUP fast obtains a valid reference on a
page *and* the PTE entry has not changed then everything is fine.

The tricks with TLB invalidation are just a "poor mans" RCU, and
arguably these days aren't really needed since I think we could make
everything use real RCU always without penalty if we really wanted.

Today we can create a unique 'struct pagetable_page' as Matthew has
been doing in other places that guarentees a rcu_head is always
available for every page used in a page table. Using that we could
drop the code in the TLB flusher that allocates memory for the
rcu_head and hopes for the best. (Or even is the common struct page
rcu_head already guarenteed to exist for pagetable pages now a days?)

IMHO that is the main reason we still have the non-RCU mode at all..

Jason
