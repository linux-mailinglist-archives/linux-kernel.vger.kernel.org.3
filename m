Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8586B4CB084
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245035AbiCBVAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245006AbiCBVAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:00:39 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2061.outbound.protection.outlook.com [40.107.101.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8C3D2050
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:59:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjGjuaoPHb/92TnZ9wBj53+tVmAxLCNFOBRr7qIGFHtHXbnmFUoUgMjNFtz6/6HoO7log02AtRuzJoNXDqu7KdB3CwWfMxCzDOrDjrMMvxOFT4b2ts7gOUEEiakEUnfPIRcn1e9L+E85yNmu+PHqFK8NLtBBuzU3y68XQlQfmPYQGcNPQgONBXPyWscCsxe8ppVuZlXdF9NVf3l1oEGX6XgW67zIEUG3uqjRZkbc0RubElAdkwmdZCgBgtttCjsRhLU+RzT/M85ZeEnwJYqJNZyWNqqkbVDLRZEzptqNOWf0kEiKwhRvXpjYXUDDMMg5BeA2gPcWEPi5gxe8VTXBwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oa9q+rgXs/P3UIETDatGIY6LxbFKacOgll5iLBHz2o0=;
 b=IQYC1LET3FSvev6Jod79z+Sn7Pt1shGpXGJhZ+6jPxdEvXa+BBC7Sdf4UWAIKa14dQO6wj4AhnpMwglQZD7bTYlRA4pRA7vAg1gjeQuerVQ0tRWUMtvDxyMEsCL+7rOMjOhhZPnryNcIA0bkacRo48Xhsd2j4pHxt6oFa4ZnxDTHkwCNOEo/NMXWg1TxCf/4VVK0y/0gmDXIYjuRC33cyJ5LNN5rvrlqnZoJytb3eOZWWzhmye6oQGKeeWWr7T/gXiyMrs9XCIFt6AeNDqm1YYkEYbB9wCvy67PQe0Jfrw1/ZNuOuAEzzA0uG8GajzuTWWnMtiAa4DlkWrmNyY5IYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oa9q+rgXs/P3UIETDatGIY6LxbFKacOgll5iLBHz2o0=;
 b=TxGh1MMql6rxFgqYWIUGfJNDPNdByvxSgRpXYLOL5JashJnVJrW16LCm6M8nE39wEBzicKFl00y4fgsoj1pekOFO1iTbjLy46x4kkpbABciZSbfbF8U5dGKksN9yhVZ7UFdb74rVuMXjAxxGBukbj5OgdnaVS1+cPrchuVelE8+SqdEz9yggIdII/WdVlp3hGQD7ue4q6C4hhRot41q/HtgfAR74+GFiUlavTAxGF/cppXaRhnxbEW+NuNeu+ZkPRgG15zaZ0jG5h5I0jy1QI2j8+rhIvBrpv9M/jNObRuZrHtLbkZfHAZDa/kfmnWl8yUNK7g2J9SgxGpByeKRU4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BY5PR12MB4952.namprd12.prod.outlook.com (2603:10b6:a03:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 2 Mar
 2022 20:59:37 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::51a0:4aee:2b4c:ca28]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::51a0:4aee:2b4c:ca28%4]) with mapi id 15.20.5038.015; Wed, 2 Mar 2022
 20:59:37 +0000
Date:   Wed, 2 Mar 2022 16:59:34 -0400
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
Subject: Re: [PATCH RFC 12/13] mm/gup: trigger FAULT_FLAG_UNSHARE when
 R/O-pinning a possibly shared anonymous page
Message-ID: <20220302205934.GV219866@nvidia.com>
References: <20220224122614.94921-1-david@redhat.com>
 <20220224122614.94921-13-david@redhat.com>
 <20220302165559.GU219866@nvidia.com>
 <fb895ba3-9d7e-7421-d5c6-f5e7a2d1231a@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb895ba3-9d7e-7421-d5c6-f5e7a2d1231a@redhat.com>
X-ClientProxiedBy: BYAPR11CA0048.namprd11.prod.outlook.com
 (2603:10b6:a03:80::25) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ee75e29-82b1-48c9-7f68-08d9fc8f8f9d
X-MS-TrafficTypeDiagnostic: BY5PR12MB4952:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB495238FF8D2E85FDC2EE557BC2039@BY5PR12MB4952.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IZswe2a1bEVIWGukowkPnOYVMfNvbk+rKdhQtbALq3uUDSjdsLL2V9l/3MdUUihlD2GtuFxPPqj+sPVQkMp5W/ZHAL76TRK7EOsBelTGfpkYrscT1BfDGlkU0lIFxYEMV/qcGSm6oVJ8MCWKFL3iwiJITtTJiyx34vj5BeVchY+ulIxh9TyU5KxWLdHs8LBAchgfDnBoBmS3+6L0T8w3JMFpfd6O6zALA3bEZQPhv7Yap/ZHLPs8raVvHgVWzDdPYypREYe2DORKi/6e0FnOhD8EHinzydtnwTapBfDoLTNCqJIy7Y2QIPxTpJ3Qks+pSSbo/AT31WCsYW99/70up9AuOkuAILdcKVqmcDtpWd4xviBnl65NrGLm0BAiSeI2mHTPGrod0Ro8LHZzR8Pv4TzmKo2HMxlbwKCHBE6z/d5n7/ZfudSlXG9+Jil6dbk2TiM5GT/vv6cx3XYgxGdWHcjwD6DFVmVUmgVVkhJwqkLJciypLqMwunJnI7byISmNTOnC8RpZzbadYen+d3/df51JLtvPPCGls42uRBTsPXLlipz7NcjO19T/Er+yjNvsQv5hvoismJUKYCXkOtj4uMocHJzaz7uZNIt6Hcfw2+DidAGo0FeB3t050EaJT7TJ1CfRHGLEMvmVjJHfkpkIx4SvYa1fS9fMH+zko9jU7NbdmfKO/JgtJwh9YxZEHoviLK5yDcDZtjxzh0U7EAcvbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(8936002)(6486002)(8676002)(66476007)(4326008)(26005)(6916009)(54906003)(1076003)(5660300002)(7416002)(86362001)(36756003)(508600001)(66556008)(6666004)(4744005)(66946007)(2906002)(6512007)(6506007)(38100700002)(83380400001)(186003)(2616005)(33656002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ca1FU/B/Lc5Nf7EjE9dhmp92kzbe1qv+d4X1RZoBjfB1Cq1LM9TgccgOq/pi?=
 =?us-ascii?Q?YQSP5yIgOtKIuuNpNMTjfuOj1fRYFnSUBIfjG28Hf03bsEV+PJ5QhrGwRiVm?=
 =?us-ascii?Q?aZ3hOVpObvC4R/AxECCHFB9/Ocipgo1RaLARLBv/5WsK4O2L61FYqbQ4Y+jv?=
 =?us-ascii?Q?2e9nrC1bqj2wQJSz9ClGwSlbqW3SeQ3/Zlkk7T0p5ffLFxsPBXbfuJ8FlFS7?=
 =?us-ascii?Q?2G9DYxQzalzbTP48jzlggsT3H8RiOM1tULBi0jrqLsY/vIsGAkNcJibdLRbD?=
 =?us-ascii?Q?iHknK9TDv1vXBFVLPHetzItI9TKlZ6oYhqALNkEu8/qrrQYSM8Cb112FSUOA?=
 =?us-ascii?Q?z2VX5b8uGtOpk8VRISvTxuN6j8mokApCO1AoKQQfvkL+DRQMIhkQkCTEFMAs?=
 =?us-ascii?Q?v/ryuyGge4LRLhrehsk0RQQxQ8RELeO43V1jQqAvA9GHcbQM37I/+O5s+40K?=
 =?us-ascii?Q?qMIjJq4Oxieo8NxhuqL038qMbax2amIZb+P8yqYi/EiWstV3vhVW4EP+KkXd?=
 =?us-ascii?Q?lU3R1xAopLlGID8/wDLcAT32LdN72cmskP2Vd+YDqnqQQfMXvwTR/b8TIUg6?=
 =?us-ascii?Q?ImR9bmdHrnh04lXIFE84WGHGSmRnvkHXPgAHda7WYBOJOnfkd8J5YNV47q5J?=
 =?us-ascii?Q?lah4T0MJOKMsfjXmZi7XtbL0KCoDjvykIfrt0uxqDFu3j5eZlQn4oCDU51nQ?=
 =?us-ascii?Q?OWb4viD1wysGp3vGU6BRaA3um6KtMEioV4pR3oRYvbr8a7/OqYZ9F6BUiA5g?=
 =?us-ascii?Q?WSZrphGORRHaDVoqmpixDcvZWIxu51wi9iqLjw1q3tbT7GqRXURFIz3wV2jS?=
 =?us-ascii?Q?kntFJ+BfXoIrxC5NqwLtJbhhtDgdWw2rASB2GQwq/cpurBPV7N79a1bPDiPd?=
 =?us-ascii?Q?B0mJVYl7m+4v5vKC4O0Ffqk/YKz18+1/VKTasczwDsbcMlXEOP4V/LHWl5WU?=
 =?us-ascii?Q?qFcFvi+BtIUCh13toxtqVdI4Y1+x8/1uMvnjou9xLz28h0w6AceYwE4sgRrA?=
 =?us-ascii?Q?wQKydD9sAgl9jFvIn+riEQphZ9tsrfvhpVLJa9SUjhXPEy2avOG0+EUSEWUz?=
 =?us-ascii?Q?o28R6QcZUvsthzRwmHRKuw+tgen0uN1QAkPpHEepFDhzenGeCp4G+0OuGF2j?=
 =?us-ascii?Q?xN7v0/GZoq0TbrrOFJHLwXWrb3ftXZOOZ85GXLNKYl1bPXId0KLSG1Psm7lK?=
 =?us-ascii?Q?gUor8BppgQlHtGZINNfpQTKzcn0DJ8iIvr8neMJFVEpNLFRF6GFSYxYOs3ny?=
 =?us-ascii?Q?18uEUlSP9qdRhc1shZ9ZLCfnpX9ut/f0N5P3eGzTfa0ptqjLjFwljjm6gbvC?=
 =?us-ascii?Q?+5Tqs093zsZpxfqcmycxP/d0I6eAhliPKeBWsneBZJJ11d9R78+qP7YWFcK8?=
 =?us-ascii?Q?Xg2rcWKqP2sUPSXxDmgSZ8rXgcjmKFPjdU+ixr5h8XoTMZN4jD4dLul7hplk?=
 =?us-ascii?Q?T2M3AnMes+zxlChexUmiAkUp2q3ywz6/oR1yng0wY6iQ8Eq4ZL1obWXd2gVj?=
 =?us-ascii?Q?8lW5UWU/NcERu4Sjg46mGqGEcqgwKsNFpZ+9/hXnvwwoZmn4nUr/AkPXN0kM?=
 =?us-ascii?Q?VOPdIQbfrl1ssVQQPD4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee75e29-82b1-48c9-7f68-08d9fc8f8f9d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 20:59:37.2278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nOqEtwt4CtwqMyrA5hZNJDQ/HZ+oJVHPpCvn/UI7QgnNWVmgJ/RZJRDykgCuyGqa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4952
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 09:38:09PM +0100, David Hildenbrand wrote:

> (a) I want a R/O pin to observe file modifications.
> (b) I want the R/O pin to *not* observe file modifications but observe
>     my (eventual? if any) private modifications,

A scenario I know that motivated this is fairly straightfoward:

   static char data[] = {};

   ibv_reg_mr(data, READ_ONLY)
   data[0] = 1
   .. go touch data via DMA ..

We want to reliably observe the '1'

What is happening under the covers is that 'data' is placed in the
.data segment and becomes a file backed MAP_PRIVATE page. The write
COWs that page

It would work OK if it was in .bss instead

I think the FOLL_FORCE is there because otherwise the trick doesn't
work on true RO pages and the API becomes broken.

Jason
