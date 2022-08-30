Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818E05A6DEF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbiH3T57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiH3T55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:57:57 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A6974CF9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 12:57:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5TE7pJ/rZXwRARqihmfHP/W8PDP3PGwkPCQoat8d1wBZgaVoPK1RdEtayBRuq4YFQQzEQnU4RH+pfWWRSYURWu/ZApOI0+lWG6fVzwteidKfXW/K9uu5iSA9uVckNrQHH71avcKJoVV4/R6FHd9n3PyapyFaOYWaLeifD4mwnDedjZ3ZRmDxz3oRMhyR1jac/7/AJmpWhs6ehCmroHBUt9yWjjzPkVfbvSkzeqqvDGsBdO0KRjb6qFGuigE3ZV306vGShR1c/sPIlKU6pjAcrVKdqO4D/OW8WhAkv7DEKw11gOSDH6DG2bojnSEcT9gLRA9vy4oURjAioVR2SF1tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgcVYBuC2EZjbGoozOv/dBD/pzC94WQpXbDG2Blsevw=;
 b=MFq5xt4frpwZKkIqGbFEvVkmCKHNeRwZcAqasyad7sbpOniukW/dlUDDM+xYkQr2Kl/Y5MwuqEX/XFg+iJrD9WiBPWTFkUEwevuQjsd3apRYisQZfnDdh98vvRgyiq9rSL/VM9Qhv3nJcxfs3RXjDI9gWKoMyxR7WO6zGhNIEXtaD0t4g2yidCP3O4PD343jIYghWtqEAgRY4VNEcQM8l+K1xGZGfVz6ZZrIL12+vR955i4NYQxVMe21Kn+TAQmFvw3VlR+laUI/yUDVolxu6TfhDK+DapPTCuc+IMnYXmQaDpgK+H1UUQQ2P4rETw3mV62A5dybQp8UDuiKMr439Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgcVYBuC2EZjbGoozOv/dBD/pzC94WQpXbDG2Blsevw=;
 b=V4Txrwag+42BhT7CwbB7vzOBWBHs2PjoMYGCSThvG0BVRh22VrpuBhZtoZXFzJUW+9rPeg1OpeosEj7imyTLQYWOUwh7Mc4+tjy2m+LVfT5p1zVg49qa28ZGn2duGgCJGPM8DjXYK7DyaRrDbDP+zb2yNj5WUrQWsdoazJQaiAWPtKWcvAeQvXTFsXjhomNIbB4E90mbP8G3cSOGnokDoUV3hAkl0YKZR4bHXBidU+WHoVCC0V5FRuhH/Dq5Zc7m9PKiY2nV3keKtXJ1QkTB4yF/tnV18aoMsE6iLVj4NUXuuUH7evXF6YXiBKRXsFm3wmKU/hsn3+97akcEpg4xdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DS7PR12MB5840.namprd12.prod.outlook.com (2603:10b6:8:7b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 30 Aug
 2022 19:57:53 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 19:57:53 +0000
Date:   Tue, 30 Aug 2022 16:57:52 -0300
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
Message-ID: <Yw5rwIUPm49XtqOB@nvidia.com>
References: <20220825164659.89824-1-david@redhat.com>
 <20220825164659.89824-3-david@redhat.com>
 <1892f6de-fd22-0e8b-3ff6-4c8641e1c68e@redhat.com>
 <2e20c90d-4d1f-dd83-aa63-9d8d17021263@redhat.com>
 <Yw5a1paQJ9MNdgmW@nvidia.com>
 <9ce3aaaa-71a6-5a81-16a3-36e6763feb91@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ce3aaaa-71a6-5a81-16a3-36e6763feb91@redhat.com>
X-ClientProxiedBy: BLAPR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:208:32b::15) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8666dcd3-259e-4613-fd85-08da8ac1ece9
X-MS-TrafficTypeDiagnostic: DS7PR12MB5840:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UkfxkgtyyDCNMoPJ0AYYTuQw2G3fxRwEwcLFxe+TmIbt3/bVGoY66C54Cwz7xJlPi+KnaEQC2hQZE+D6i1tV5wMSeHvByvRT1R+YJ99wVR6TQ1NNtDu/JRx9mPtW8XhJrLDNKvB091kwgOwbgt7XrDM/Ud3ET96d2NHxnETIv9CY3Z+MzaFJ5uAjsl5UwYGVlL84zEghvKEzkBEdgBgma18qfnl49T2snbWi4cf8JLJLSfjrsTbm6FnfyL5kRdLqmNSJ20UlMdGQmlxQ8VqAOzpb7RqcvRydnf+S7YsRRVpx+pCxKs2Ihgra4vmjrVjOMZHcsUuEuv83KGrKI5GTqykQJHudTgZCKrLSt4vYvD8Ne4biPsz8+n4k70BYEioflMDi/Fd/MkAj/k3d/jY5SK9es9fv4rAZh0b8vWBw74NYnd58+tK1E6g+yHImN7LyNo2MjGNRK+yVBkerHLtfEUZUEmFDyXE1QXP2IeSGen7AS+8I5srVUscPk4V4NWU7f91jJPpVKHuwEjGG49R+oV3KSx8jtWqgZtJV/nsAfndZrgFsDvTwRoX9Z42bw4W7s2KQiDQBTXDVleGiljeRhFolGuWhCq8/KcKSuVnC+e90x5ix8w3J55GWzNClIDqrw1BukKMHqcueNvbQ0S6nQVejy2IfdsnTpYUUKQLke39wnza/yjDJDwBbbWxqEp337X0l+bB/yuClTBmPlcZhlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(83380400001)(86362001)(36756003)(38100700002)(41300700001)(54906003)(5660300002)(478600001)(316002)(8936002)(66946007)(66476007)(66556008)(4326008)(6486002)(8676002)(186003)(2616005)(6512007)(6506007)(53546011)(6916009)(2906002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aRFnIuA5DDadjuzfEdUO+xPiHf6S5QdEwNMsSrP6VExG3gvsKR/0Yag7KFAI?=
 =?us-ascii?Q?G1V+sEIqjKEIlJJO5G+mAxiTZ4QXPXVWViDD2NDHNSYaoJONixsHLVNTjRdU?=
 =?us-ascii?Q?xHni0vf8rajWGlCpTA1tlrsU7BBhsMQFHqbRXw/Yt9+74uh5DlO87yIPFVSD?=
 =?us-ascii?Q?3gjBApG1M/IFtTfPyiAVfleNAyckf8ig1oF+CTQQlDWJr3AXcOeufsbGOuYG?=
 =?us-ascii?Q?4C/jTPQr9/FXm12vYhWZ8hsYnztbggq/iITKzd22vi2CaxhG2EeMcDkSu+kA?=
 =?us-ascii?Q?6DyhaJWPxIZChPUxhP3Dp9cMY/G9bFuEtbjaLg0A5ylinFiwr28bvb+2s8MZ?=
 =?us-ascii?Q?1Unuvjvt3Wgk2lgl0GLGNYspzS94Gsi8Cti9Ay0Z6e5kFma5CpGD8wUn/XPr?=
 =?us-ascii?Q?h6htSA+GDW79/s96aG6+3Qv+6TjM/Ym3k+FdGQ93m3ytsHUm0ap0uPC/oCQC?=
 =?us-ascii?Q?4c/samtoxpp2NI8aC86MbdTCWmW79Yx4ZUCSmAT8JnpZHIIJZ4AX/NWW+f90?=
 =?us-ascii?Q?/M82+m7fAH4BjB2H+oOW8IBeyvcDc2afWDh3R465rIW99S+RTNWuDob6v9fY?=
 =?us-ascii?Q?m7bSFWj5KRPfCRMc19kJw2dSVdIqVB6WqKyTz1IDkcifVaxcGNhNOVXM58v3?=
 =?us-ascii?Q?INwMmMdIJSN8mr+RxARfq+IfUJBz0wYB3eEh/us6cu7ldmBOPETJm7HzS9R0?=
 =?us-ascii?Q?dTKkjNEtv/XfZu5eokK4xM3t3q5/H51bNfXk/rRUfDk8XILrZwKhqlZmJQj7?=
 =?us-ascii?Q?7Yo0HH+cnRw2jxY2QqzHN/CpkSz870+eAJRAk1ddWxVmQFlAFt5XcV5sBZe1?=
 =?us-ascii?Q?chTnLKJtACyk3avPk6bcMGzQ6RRA6DGro72K1nXFJmyFLrbMcysaY6N9Ux9t?=
 =?us-ascii?Q?5mdSonmivL1EX3Hun0GoyrNuFzYtSlKHtknnLlcFXypQyGNWWJ1pEdxSnNb4?=
 =?us-ascii?Q?4HfhDs7cmGfLjS5K7exgDKxUx4wO0caCFfosBZGgEOL+t/D4ZVjoHYMOHGMk?=
 =?us-ascii?Q?4gr3vjL1UYyY3GxEVNEWgYHnW9EWjo16PKhC27uVGIynOKj8E8ij2C4QHAwP?=
 =?us-ascii?Q?ZeKFaZCDAjPjs92Z8BDEpWcgeep62AFfD4SYDYgQnfUOBUh3BkI6R0JYImMc?=
 =?us-ascii?Q?qLLzbYwD2jUVNZlbjgCxjMYTdjas69xo/uBCgDzaEBJcxa3+11kNO+/X3wq0?=
 =?us-ascii?Q?E8Ea7Wztbcw/RoBAS8O2XLVa3nyKEvFqY5Mgk6I5i7f6MP/170NfLgxwsJqw?=
 =?us-ascii?Q?+1Ahz1myMv2piFjA4t6HkZY+VG734pSbh4tt8Bflkixh6ytOmZ+sl8UgfzOp?=
 =?us-ascii?Q?CLIkj8krDP5WTDsWFmmHvnWckPvZ9bep9N6AiS2Cr1eKi92EOgf4alXWyTf7?=
 =?us-ascii?Q?nK41bnE6hGeA3ZCP0C+9ISqvVfonBkULHqn3wAJvi8FS1Xst+q6S7qjvuZy0?=
 =?us-ascii?Q?ylUqMCMysVJOlsTvUa0rZzidHcnQdeYq+tEUnai2fcumT/HhBxZZrO0f9prA?=
 =?us-ascii?Q?+aSIstBlDQhmTf/WWkjG+M4g77hUDyQtre82CYTJnt4BCF/EWagC8hiqHsBh?=
 =?us-ascii?Q?D0Fc0GccR2Yhb03P4Y7TpCYQCZPqBeTIdYGUplPr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8666dcd3-259e-4613-fd85-08da8ac1ece9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 19:57:53.5675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVdog1wl7z4fAobwOZ/s4qroqjeef56D4EH4qAxZ/qv/xBoegurVt73LDZGhk7wr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5840
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 08:53:06PM +0200, David Hildenbrand wrote:
> On 30.08.22 20:45, Jason Gunthorpe wrote:
> > On Tue, Aug 30, 2022 at 08:23:52PM +0200, David Hildenbrand wrote:
> >> ... and looking into the details of TLB flush and GUP-fast interaction
> >> nowadays, that case is no longer relevant. A TLB flush is no longer
> >> sufficient to stop concurrent GUP-fast ever since we introduced generic
> >> RCU GUP-fast.
> > 
> > Yes, we've had RCU GUP fast for a while, and it is more widely used
> > now, IIRC.
> > 
> > It has been a bit, but if I remember, GUP fast in RCU mode worked on a
> > few principles:
> > 
> >  - The PTE page must not be freed without RCU
> >  - The PTE page content must be convertable to a struct page using the
> >    usual rules (eg PTE Special)
> >  - That struct page refcount may go from 0->1 inside the RCU
> >  - In the case the refcount goes from 0->1 there must be sufficient
> >    barriers such that GUP fast observing the refcount of 1 will also
> >    observe the PTE entry has changed. ie before the refcount is
> >    dropped in the zap it has to clear the PTE entry, the refcount
> >    decr has to be a 'release' and the refcount incr in gup fast has be
> >    to be an 'acquire'.
> >  - The rest of the system must tolerate speculative refcount
> >    increments from GUP on any random page
> > > The basic idea being that if GUP fast obtains a valid reference on a
> > page *and* the PTE entry has not changed then everything is fine.
> > 
> > The tricks with TLB invalidation are just a "poor mans" RCU, and
> > arguably these days aren't really needed since I think we could make
> > everything use real RCU always without penalty if we really wanted.
> > 
> > Today we can create a unique 'struct pagetable_page' as Matthew has
> > been doing in other places that guarentees a rcu_head is always
> > available for every page used in a page table. Using that we could
> > drop the code in the TLB flusher that allocates memory for the
> > rcu_head and hopes for the best. (Or even is the common struct page
> > rcu_head already guarenteed to exist for pagetable pages now a days?)
> > 
> > IMHO that is the main reason we still have the non-RCU mode at all..
> 
> 
> Good, I managed to attract the attention of someone who understands that machinery :)
> 
> While validating whether GUP-fast and PageAnonExclusive code work correctly,
> I started looking at the whole RCU GUP-fast machinery. I do have a patch to
> improve PageAnonExclusive clearing (I think we're missing memory barriers to
> make it work as expected in any possible case), but I also stumbled eventually
> over a more generic issue that might need memory barriers.
> 
> Any thoughts whether I am missing something or this is actually missing
> memory barriers?

I don't like the use of smb_mb very much, I deliberately choose the
more modern language of release/acquire because it makes it a lot
clearer what barriers are doing..

So, if we dig into it, using what I said above, the atomic refcount is:

gup_pte_range()
  try_grab_folio()
   try_get_folio()
    folio_ref_try_add_rcu()
     folio_ref_add_unless()
       page_ref_add_unless()
        atomic_add_unless()

So that wants to be an acquire

The pairing release is in the page table code that does the put_page,
it wants to be an atomic_dec_return() as a release.

Now, we go and look at Documentation/atomic_t.txt to try to understand
what are the ordering semantics of the atomics we are using and become
dazed-confused like me:

 ORDERING  (go read memory-barriers.txt first)
 --------

  - RMW operations that have a return value are fully ordered;

  - RMW operations that are conditional are unordered on FAILURE,
    otherwise the above rules apply.

 Fully ordered primitives are ordered against everything prior and everything
 subsequent. Therefore a fully ordered primitive is like having an smp_mb()
 before and an smp_mb() after the primitive.

So, I take that to mean that both atomic_add_unless() and
atomic_dec_return() are "fully ordered" and "fully ordered" is a super
set of acquire/release.

Thus, we already have the necessary barriers integrated into the
atomic being used.

The smb_mb_after_atomic stuff is to be used with atomics that don't
return values, there are some examples in the doc

Jason
