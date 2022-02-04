Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34104A91B7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 01:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356280AbiBDApp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 19:45:45 -0500
Received: from mail-dm6nam11on2078.outbound.protection.outlook.com ([40.107.223.78]:54273
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236660AbiBDApo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 19:45:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LApSu2HseDxwrdXHeh/DZibbwJk+RsFro+lhOmYzNG9fsEwiIjATesEVoo/ogGeI48QMhz+NdkdP1nNs+uZ+B0itlujmY/8kn8Q0v+EyJ9Wg9noVWKfND0ztVlumW8iQHwnesAkelMJZeGRogU6zym3T0POfo61jLy02Vw1DuDJbGtlA6IYQphNgCLgPWeo9+W0hCsWa2YsDvnDILeqlaacFdU91NDaPrpKCf2IT77rXEgoh6zCLxZFJljOW9OMuUNIx56IkjnBspU5yHXoTgQkrnkp2EFAm9Gg4XUF7e+V7qCywUhFQNpF2NslawweazmPvHBP94oHxcLeo0xr6GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7im2etUpDfPwS54vp4sXTyNH3iO+3Ur/agGSnds/WRg=;
 b=H9nNHxiyguuSppSBuHVm+3n2N3XqTMA2TPubx3k1T6mC1Ykooj1L7fMBClM+mfXK1InDPK48YQU9Btl73esgJ0TucEhkfXZc62SMhMJqDLTCG79d+P13Wo8Neo9VgCuazyd8rLfyHE/HJObvSMR7GPAtG1E6xYZT28so7g3KOZdK2N5QnuIaSz5qX7qSBnn3luiI/pwBcz0Og4cImLK9M8i8Earrd2zmsIFjhCZiFyHcnuvZOUZqmeNfVqxz8rXwzcyfGnkeM3Wd4RaM1psTQEZSkScfMQitL9S8eeNDr4q+Lc1IGlY5x0GmP/apQuvU89/0mEVXKaBnig5XnGqSzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7im2etUpDfPwS54vp4sXTyNH3iO+3Ur/agGSnds/WRg=;
 b=CrvWlL65VwHPwPleID3+mzl6wUDNfsRahNRkbjO5lvuy727ufcjOUYWHVwATLAqZ7bw3UR9cituFIHwmQfnFTP7G2ieSi8Hfd6YbcTZzMmZaYGGqywxW/8xOj/oqTVF0KJIf7wUKaAqBtyJ9szaEMuF4RgXJqy+bRFTR8ncZA2p13DH8sMPigksMCnHkGTFjT92XFdoEY5PcxMGgEUgNXqq+ZNArS2hvQCCtGR+fWhBTtVlFy5SB3KSKHB/1mecDBFpiJDV9oP/kLoBvn+44S24fXtRBBVDDAyz4roto8kwyegO52CdoQmIyOhCoxxH05BZKLQQ72APwF5m83e3JkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN8PR12MB2961.namprd12.prod.outlook.com (2603:10b6:408:65::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 00:45:43 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4951.012; Fri, 4 Feb 2022
 00:45:42 +0000
Date:   Thu, 3 Feb 2022 20:45:41 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Peter Xu <peterx@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: Weird code with change "mm/gup: clean up follow_pfn_pte()
 slightly"
Message-ID: <20220204004541.GL1786498@nvidia.com>
References: <CAKXUXMxFK9bo8jDoRZbQ0r2j-JwAGg3Xc5cpAcLaHfwHddJ7ew@mail.gmail.com>
 <6d38ed2a-72cb-3eb6-5af1-caee61d94005@nvidia.com>
 <20220203130137.GZ1786498@nvidia.com>
 <222e01e6-bb00-51ee-a94c-089b43cbaf42@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <222e01e6-bb00-51ee-a94c-089b43cbaf42@nvidia.com>
X-ClientProxiedBy: BL0PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:207:3c::19) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f7c95dd-05ea-4660-38f7-08d9e777ac3a
X-MS-TrafficTypeDiagnostic: BN8PR12MB2961:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB2961930067597DEF04CD4341C2299@BN8PR12MB2961.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uuvwUlmKXb9g6h2QvSwCpJwecy1cko3LuQAJR3facNjTMxxFZ6ldpxjbppXEjqpwTgQ4Low+x8+uWsw6NmItA2rpCW7uvnxHIya9b4dHRUz17lBBZqANfa9ej8xtlZkssvEiPpSKgL1JlvpvezbsMsCXYyJ+dpJgmlhBM7DB/I705xRenkT2pJ2n5Gyzbeu23IvumRwd1GxJZgugkTdSuVhu08zV4zWQJbbXQiatZzS4udqdDVWIkj7fEDmfSGvsKr/sTYFzl0MR4VN8ilIRrheA93PCLShK/aaoi8Z2Hem+GtAvrQdotX4aVdtOfQNQHaaN1znpKNKPjBmt6uGN4najdkHyy2JDdG2cdRy7ENsEG6bm3KkX6k1ekmXD2woYI2o/62peEu539WLumWuBr8EG1SVs50nguHjSw3aYYIL2FaqC8T5GInaHR+3VDstQJNosxH9Lw1AnFn3b9wrdR5NmHH0SLTncN1TRTUg44Jdv1Z+13CXeEhTEw5TIn6m1lp5FRM72I9SwI2bwdFaVYuKS52uFYhZt8b+iWVYL9zsQOmjB7+fVeUwLzgIpzOtm79vLpHmRaAMK+FNdJIwyxBwl593AhXxbIKp35enmxq1NwKwAPNnCYnRCT/+AkjTZ5xfY5zkN/7Sxc3FqpXfVrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66476007)(4326008)(66946007)(5660300002)(8676002)(8936002)(6862004)(86362001)(37006003)(2906002)(7416002)(54906003)(6636002)(316002)(508600001)(38100700002)(186003)(1076003)(2616005)(26005)(6512007)(33656002)(6506007)(6486002)(36756003)(83380400001)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?naVpDYzBxACO0aQNSJ1rUm7GtlH/Rt2zqpGasQF3ccxK4X9OMaFdpwRuwTZn?=
 =?us-ascii?Q?MBENynhE1syAKUwDZHcMx9qye32pdBVI1Alrs1GdtI612CXCXPtJZmTDNRMq?=
 =?us-ascii?Q?Y0C3+EmsdU/pFMtJ+EZCSv+P8xhSecDquzfgxI0tdBhiRF2NPHAXr4hhn4X0?=
 =?us-ascii?Q?Xr8HLuc9xl88ZAn+gBVGtz/ky2c59M/cphKpWeTxeF4HwcW00zIaZVdBxozP?=
 =?us-ascii?Q?i5qv7ofEFrm38yBBhMHT9iVsXl4kMy4zs2DbZHK1ECN8aNE3veOtltYmpgI/?=
 =?us-ascii?Q?eCnvaiPjxMhfvMcpOSRjrIxGMBumDbIklqLGMIS7T9yCAEMswLfSCM04uHK1?=
 =?us-ascii?Q?FjxtpcG0+D5HO1Yh2Gkx307hfe6V3LRcTyPEQi+41pPkvn5sf/vbc/O8clrj?=
 =?us-ascii?Q?zz4fm5upCJYAvN6MIa0e8Q2RHlq42SkWT5WgjU1O82nbBP/kdVuqsSagX2hJ?=
 =?us-ascii?Q?jJqmGMY1ueBpJc7CUervBI0l/6rq1wcYdwfLSzYb2GciZRuHgN8mug1klnDh?=
 =?us-ascii?Q?t8ZkDRTwL8TdFkCROrG1Wah1i/kq0QwDISGU3e5bgfzC3PmhMMXtbz0ekIUk?=
 =?us-ascii?Q?bA5O/LQ2Ooagiz+/7e8bdolhb+w0vc1RvLc3So2l5+3F86hhH3D1Qdh2rHin?=
 =?us-ascii?Q?6yoFc+1lYKKnTEJehCIxRCCjWAcGXB/mPS4qRNi5ZS6C+tr2Taog/03rAIBN?=
 =?us-ascii?Q?+Tbq3/HjtaF2Lx3bIASWcmjZktLPzzSdyERbQdqEDY8w5KN4VB94R/8Pu8n2?=
 =?us-ascii?Q?8mTdZWp+4WOMRfTj4mzzNyLNyKPuEbmZVb3L0Q947EDIpjZznvwH7J0LA0br?=
 =?us-ascii?Q?qbUcdDPTMkvwZOhtOaOiYeABQK7VPy4GBI7Rie7hLyR9QYlWBRB+HaRf9a9J?=
 =?us-ascii?Q?ke4i0Q7y9kkfCagdeIXCt571X/+CpObLyl+BRCPlgk9wY3XRKIDVBcD0mK8j?=
 =?us-ascii?Q?9WEDKjtseZGh2waGPY+KdSjcQ/Q5DpKDIsBw0nTFiaiV9Hgiwy7BPPRirWHY?=
 =?us-ascii?Q?wtD73O6aWq6vGa/rij1uKu8CnRcWh2P//VCnUAWCeqGFhpSj4ql/2nU92B/5?=
 =?us-ascii?Q?lyI2iQars3JZDeAuHnkLgwDSageZzPDuIjh1sBeQXDe5Q2Y8I4KIWnNDOmAx?=
 =?us-ascii?Q?Y+JyrcZ6ziWN6Zrd2GFu0E6gLFYCNicSM7Wf1A3MjBX3NatDrPvU05HqHotO?=
 =?us-ascii?Q?u85nRQbf//GwCVHB1Zw38iureeXc2p97WRAyeNH+dnLuBSj47+CFS755XOav?=
 =?us-ascii?Q?Cn+7C4socnGnMpMNXmcEprVwm1bSNG3Y4XkYsumYlE5BjOwLXk7vrpVBnDEI?=
 =?us-ascii?Q?aMMHpe0rS9n5WnFzN77hpBjNJsaTdjydc3ZQ1P4VIqbxeCDRgOSCiuCHRu7D?=
 =?us-ascii?Q?ehRKdXc65KXktZuB8Gr6LPiNg6u9rdqF1Gk8QmLiKy4nvzjDMLgMPRUucdPD?=
 =?us-ascii?Q?Ui0lN04rwCZaSF3DumIfScNq3TefRjO1T7Kc9nR+Leq2a5/TKuJxgI1wrWm7?=
 =?us-ascii?Q?tKHofN5L3opGBAkbftbp+Fn8i21msNZUNIGSLTMpeEJbvN274LlJy2ELqZe7?=
 =?us-ascii?Q?eSux/mjNhaURkagHd7M=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7c95dd-05ea-4660-38f7-08d9e777ac3a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 00:45:42.9069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llsJ8fMg2RVtfpRfHG2uhChGbjgZM5JwXG7+M3LHQA8vpQ1tCoCdCY8sV0E8gihr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2961
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 12:44:57PM -0800, John Hubbard wrote:
> On 2/3/22 05:01, Jason Gunthorpe wrote:
> ...
> > > > In the new branch if (pages), you set page = ERR_PTR(-EFAULT) and goto
> > > > out. However, at the label out, the value of page is not used, but the
> > > > return uses the variables i and ret.
> > > 
> > > Yes, I think that the complaint is accurate. The intent of this code is
> > > to return either number of pages so far (i) or ret (which should be zero
> > > in this case), because we are just stopping early, rather than calling
> > > this an actual error.
> > 
> > IIRC GUP shouldn't return 0, it should return an error code, not zero.
> > 
> > Jason
> 
> Errors work for single pages, but GUP is a multi-page API call. If it
> returned an error part way through the list of pages, then callers would
> have no way of knowing how many pages to release.

Yes, but that is returning a positive error code, I said it should not
return zero.

When it hits an error with pages already loaded it returns that number
and the caller will then do gup once more with the VA pointing at the
problematic page. Then GUP can return the error code because it has 0
pages on the next iteration.

It should not return 0 here when it got an error.

>  * Returns either number of pages pinned (which may be less than the
>  * number requested), or an error. Details about the return value:
>  *
>  * -- If nr_pages is 0, returns 0.
>  * -- If nr_pages is >0, but no pages were pinned, returns -errno.
>  * -- If nr_pages is >0, and some pages were pinned, returns the number of
>  *    pages pinned. Again, this may be less than nr_pages.
>  * -- 0 return value is possible when the fault would need to be retried.

I actually don't know of any place that handles the 0 return code, or
what 'fault would need to be retried' is supposed to mean for the
caller ...

Jason
