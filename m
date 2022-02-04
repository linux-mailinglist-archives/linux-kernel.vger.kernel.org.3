Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8354C4A91DD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 02:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353214AbiBDBGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 20:06:19 -0500
Received: from mail-dm6nam10on2054.outbound.protection.outlook.com ([40.107.93.54]:32736
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229884AbiBDBGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 20:06:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VA5uk2S61FdfmUw6EDmX+RQWErJUMi6NFA2YEJLAwp7VjD1CSfcnCMgCN1raYtPiSQf/QSxK6Boswe6sPiSF8gOvUIHiv0not/5oJd2MlIhiichcmTf3oZTgPXWMucpf+iCU0NNKTqyxBYsHvbEoij74ObDhU0nMY03kUQAdblxdy2HqZUxHYyJKk61AO0J1nAldobjDPXW6yW9vWXK3tyg7Dp7KXm9AaWuke09MC/akpQSm+5TZjA/ZRXspbcHmKTCp2kbBZquvE+NCkqwnCsrbNXqTwkq/juXItjbURhYtiMzHXwQ3c86ZfQ1b//TekIyjS8xb3IAOEnO84aO9TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CEl8ERZVf64BEhsG1LKfI0wbLOq4IL5N6I8iObp0g8=;
 b=ePW3wFXNg06O9cpc5iiRxT7lOXpUNhxVVRIQ17s+7wPL0d3RxwJITNnxB2sshO3xcuA0dXPOG88BQl8hicH1ljqjdwZC9X//+rXWyepSUw/VNzGYAobIBPpX4xj5//g9bXlwMrHozdqKiuqOsARPxTK2Pwn56V1lGGdXJ5VY8WIA1L6EX+5Foe6oSDcE1RykGeSP4gnIGUYRvGLwMFnwhXzl5filiM+tqkUpDqYrvkpIyZmmdXwyCqqwk5IXoXwOl/fMV9rl0kCnyohyOd/M61V4gRhOwRPzVCwU4pwMYvjD41LZUwUDjVYral4SmtFMjN9BtIetM5cyhqfXnZjN8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CEl8ERZVf64BEhsG1LKfI0wbLOq4IL5N6I8iObp0g8=;
 b=qYLIA+jI8Yl463KxD0t9DmwL4Q0wCevI9UOUrnIEOABbXPbwLr8CXRKb6Ns3svpu0xHkAbGuBARcPGU+clIAPdtBGSu0tCl4fb7Zuy007/mtFLUV3UYrF5EVR8WeQpN5xsmmImh5HF7lsiF2zIaYtbcKuk1gjdVIST+qCz/SkRomanroojKAMykgH3SA5GL2Fx+d00iaArqXR/9nl7P264Vb8RtrTZl8TDhbPH0z79p1WokA6yx3IMFF6DGe+HssV35HwZIR2utquBPVPFhrjzs3q7XyhImp5y1BbM0hjf+IOL+U9p2ajeA7n6D5ATRv1J83Gxq8wo/rm430NQol2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4281.namprd12.prod.outlook.com (2603:10b6:5:21e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 01:06:14 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4951.012; Fri, 4 Feb 2022
 01:06:13 +0000
Date:   Thu, 3 Feb 2022 21:06:12 -0400
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
Message-ID: <20220204010612.GO1786498@nvidia.com>
References: <CAKXUXMxFK9bo8jDoRZbQ0r2j-JwAGg3Xc5cpAcLaHfwHddJ7ew@mail.gmail.com>
 <6d38ed2a-72cb-3eb6-5af1-caee61d94005@nvidia.com>
 <20220203130137.GZ1786498@nvidia.com>
 <222e01e6-bb00-51ee-a94c-089b43cbaf42@nvidia.com>
 <20220204004541.GL1786498@nvidia.com>
 <c0f57bfc-d34b-a34b-4f2d-0d66782e4ae7@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0f57bfc-d34b-a34b-4f2d-0d66782e4ae7@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0131.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::16) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a039590a-e0b4-4f77-5c1e-08d9e77a8a06
X-MS-TrafficTypeDiagnostic: DM6PR12MB4281:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB42810D04AB0F65A3D1B2BD2AC2299@DM6PR12MB4281.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2+uoYVHzvpvTFllrP8n0YYyL4QMeAYxos6Wi2z+RJzdLXGy5WMVLTdEjQ66NKdujI95bRlig7BncB2sKW2nAYbcocZrwPQp04qDOJ3pdZlrC22OL5qWISvpSc18Y94dKJAsJ6rCcSAoSJ6Xj+eYO3bCGIBA99kZKrHQg2DAw8NrQxDLXoEyLZU6KU//G7GsE4oUwz2xNrhBV31XlKUiEzU8y+K0Ru6Bf5daYoaXj9uEm58uP4yDFxhdGobFTxrqXcdZJ/2Md75vCZYSzzoT0Dc/8jLigeG1IZBpZ4GapzWKtnzNOOE5Hypi6xOAiSYWN4rKNbVEQOSj5sfZNqsf4V0XXdTe6eYv1bPgzeXxHuRVUDot9nRT8PGYvncEbJe7jQbspnOErka5KQuqcwJikJQntHsFm85ZnnBMuotnKJYo87ZcpRdIfgJkWsixudt1sg1EkevksUbYOaf4dGyYA4vwYT3cITbY4oGmHrysankOPMr+V5J444Dd6iXzIgXnwkD3g807eqAtpPExzwVj79srBH5XKnd3qyNeMA4OFJOe6dFNeUdpitBqReYop6zNbJ91SB/DWqfXt7ul2VFBj+YwUt+ysFchCt97Th143ppHo/33ilfXmYe9VHPcXhRm8YvFXdR20bYIIoZDbWb7axA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(316002)(6486002)(6636002)(54906003)(508600001)(86362001)(37006003)(36756003)(186003)(66946007)(6862004)(8936002)(8676002)(66556008)(4326008)(66476007)(5660300002)(7416002)(38100700002)(1076003)(6506007)(26005)(6512007)(33656002)(2906002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ts6HZk6rPZa8eDjkclsvebrrepkDiBW7tVFr7Brwd4c1BGVlcU+OA7/kNEnE?=
 =?us-ascii?Q?S3bBqtNYc/Kzea98beW3U6jlsMIA3B5j70+2XVt6ee+axiL5TqrcbNV02v8C?=
 =?us-ascii?Q?rt4bTe/jC2kN4i3BCbsaA5ssNcpIKpncGayjnTDAEXy867SX5xLtLRPu6qr3?=
 =?us-ascii?Q?usMDrPqNcH8qXm/B6c6Vr/0qSRZ/IqnrVqRRJit+bTxNuPqj9BdTXhEfZE9O?=
 =?us-ascii?Q?V3bt6jFN60UoHEsbJ43e+mE8yn2/opu451jIkv55S0kbL8o/0p4zPmL+NVWy?=
 =?us-ascii?Q?1ihbEDXDtT1kfkuuMbd38WbYnQImih2LQpz7IfzYNgC4nDZQCkCbNQA+Ne/S?=
 =?us-ascii?Q?yriQ8x2eJsvJC2BIt6iOgnPh+GwIpSKfnF1IOG/jVDwdjimemXornWSctO4V?=
 =?us-ascii?Q?VgOhg3Yxyr7JacCELWQqxVYjVWKp1BMpqqAUpkD3/ycMbJlVZVMeS0gYuXVD?=
 =?us-ascii?Q?i+As+rbMg50HxtxbEE9B628lUiUxHLUpHnejuSPdmgIRPMdWmK5/ae9o5Xv/?=
 =?us-ascii?Q?XiscA7Z54ntb9KPRtis4akps6fVlnDPFt9o/i5Oaqq80dVMaQwnvfM+69apg?=
 =?us-ascii?Q?M2rgJuPn1OzWufRVwrco4oPpDpiSWcGpfw7lyqhrmFl+zp3yhzsTXguZQi3b?=
 =?us-ascii?Q?Kve9aEBI3s0rNKrOGB+ACsU/b/vkU05/ln7f28CZJxg8cB7p2S5vFhtKpcez?=
 =?us-ascii?Q?P9Iknvu8WNallug56Jo3NxVg5rz4IghLtLyZF89qSv7pH8JXn6adDKulcAay?=
 =?us-ascii?Q?dMQrMustXVHB4ym02PbWGGRq2i2IsowhDAcUsMMst33ZxnekLC0ioCmJHlOt?=
 =?us-ascii?Q?TPt0/pl2QSPXU6SFO7jpKLKfpuXd6eUlUTbaBXS/8m9toWYeAJ7M1Cul8DoL?=
 =?us-ascii?Q?4PQqcYlLKs3TzgSpqSsJsuSugNcnOtkcxHsE8WLqnxU1JcKfKG7l17dgGeSy?=
 =?us-ascii?Q?jqsxEnpJHnzljV0AFemIYXQyMjUrWXwPA1gQXYL7kvYVHC7gz6PlQLPx5dPC?=
 =?us-ascii?Q?VuxjVBdY8Oiw6GWaFu9LQgUrSKtjbBslDPwHb9UxAlVEF4AVElZEjMNpayDg?=
 =?us-ascii?Q?V3u3HX8BoEqTu2eQs5D5mxoVGfC/aEa59/U+jR5h11vsaZMVgPujWGVi3MgU?=
 =?us-ascii?Q?BeQweo2O35TT0XWtXa5Wt/3DC7xFKr4GjtgPhfsZugRpTTT/CRw7D0WJxbbs?=
 =?us-ascii?Q?4ttjROiMSwLD473FGYk7OpP7nua2dj+fajFqnDO2MTJNWRP8CNTm23ZBVBx6?=
 =?us-ascii?Q?xkiqRe9SKSlVWZUXiypTeGhhVzWuZHcqXGS7Ca19u2x6pg2iIH6yua3zJaHb?=
 =?us-ascii?Q?lgAtlSUVFtpQDzYkVf9i2Y/PamzTWQid9eVG5uVuOm1cg5qbLO0xonzQhqyo?=
 =?us-ascii?Q?iZe/tijtY1Q1YG4EdoDSfO6cAGZ3NCvMYTZExymnmDSEe9o+Fzdc4ulvdjq0?=
 =?us-ascii?Q?ytvCB/O5Wlw1eTTTDh299wfZnCHZWVJMLL4j9nwY2gbDYcpzB25SsWW8Fgk3?=
 =?us-ascii?Q?rvcLRU+9kz7/bJndw1d24k3QPTl0im+WZM8ACFhZm/qW0PCy/psAjm5O2MHD?=
 =?us-ascii?Q?3nGB7wJGR1O2OC7c5/w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a039590a-e0b4-4f77-5c1e-08d9e77a8a06
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 01:06:13.8740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDuUg/rOEsWyGtFuM+iVlgDQVIanxo2Tc0EpcBJA+s76R4O4ozt2qKHnIgLfuk/2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4281
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 04:59:56PM -0800, John Hubbard wrote:
> On 2/3/22 16:45, Jason Gunthorpe wrote:
> > On Thu, Feb 03, 2022 at 12:44:57PM -0800, John Hubbard wrote:
> > > On 2/3/22 05:01, Jason Gunthorpe wrote:
> > > ...
> > > > > > In the new branch if (pages), you set page = ERR_PTR(-EFAULT) and goto
> > > > > > out. However, at the label out, the value of page is not used, but the
> > > > > > return uses the variables i and ret.
> > > > > 
> > > > > Yes, I think that the complaint is accurate. The intent of this code is
> > > > > to return either number of pages so far (i) or ret (which should be zero
> > > > > in this case), because we are just stopping early, rather than calling
> > > > > this an actual error.
> > > > 
> > > > IIRC GUP shouldn't return 0, it should return an error code, not zero.
> > > > 
> > > > Jason
> > > 
> > > Errors work for single pages, but GUP is a multi-page API call. If it
> > > returned an error part way through the list of pages, then callers would
> > > have no way of knowing how many pages to release.
> > 
> > Yes, but that is returning a positive error code, I said it should not
> > return zero.
> > 
> > When it hits an error with pages already loaded it returns that number
> > and the caller will then do gup once more with the VA pointing at the
> > problematic page. Then GUP can return the error code because it has 0
> > pages on the next iteration.
> > 
> > It should not return 0 here when it got an error.
> 
> This is perhaps better API design, but it's not what exists now. 

I think it is what exists today, 0 certainly is not implemented as
'need retry' anywhere I found.

So why do we return 0, if it means an error, instead of returning the
actual errno?

> The call sites today handle 0 pages ret value correctly,

This isn't correct though:

 	if (get_user_pages(vaddr, 1, write ? FOLL_WRITE : 0, &page, NULL) <= 0)
 		return -EFAULT;

If GUP wanted the caller to permanently fail with -EFAULT, it should
have directly returned EFAULT.

0 means 'to be retried', whatever that means, and there is no retry
in the above.

IOW, the above does not handle a 0 return correctly, according to the
comment.

Jason
