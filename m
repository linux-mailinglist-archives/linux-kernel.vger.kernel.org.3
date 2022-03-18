Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B064DE48A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 00:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241548AbiCRXiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 19:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241541AbiCRXh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 19:37:58 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6257330CA9C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 16:36:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDL3VfYnd6mxZpp3+rufoM1nlcvK8nAMj8FHCi9wMD0BRUqqDqkGeQjUq/OBkYFHzawWTVSN6mmSnn3M/Afriz6V8JNcgAd87lD8nkvDEQL/8qaa1I0G+koqpKBxSKK2Ooj/EfH/SZ1k4ZQ95SiBpifjXJ3elTu7uTZKnycg1IZIVKfD/jovqMBSV44yEX7ubrV9XaFzAp3mWWxXvQHm8jxjEhjKq/oxxEfUpBLJHawkVyoTZksNljnQo1ITo5WM/1O6HJnxAdaH2xrGE7+DYzqix3ON0sVWbeF6+s3O+OQgVYZz+MYEOrCpXyffRE82BDTKZxffzMe/w9CyxbmVQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56B9zc8CbxHg1+CKJbzmP1/j1MyAEgBEBoszPsuzQ+c=;
 b=Ggf6N6jmNKSloog6goAtV2DRpaeBMrvwP2MihiGrZi6Nvhl42tFG51+G9xHy1G/hvHkHPKPUKPx+LkofEXH4KHc4SIuqvPuEJtkHtxQKz2j4gbJXsJofsQv04qdrqX6e93r5zqjyvYkrsE6gGVzCX3ffp8nNptwa5PutNIiP62CeJjyTDmq6xZrbyKJHOBFrwPawJeTIMVxHfw0wfvQy5s67FwAz6QMCWZfQO5XfgsIvoVkxBzcsDKclSWQcJ8fQ9S4wobVoqBMX5Bf2KUcr6F22JOVv4APh5cbDWMPD8r8GxMSkFvONw0Zoj6P6jRcy5ekuhNug66mpmjnh6WnxEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56B9zc8CbxHg1+CKJbzmP1/j1MyAEgBEBoszPsuzQ+c=;
 b=Zb2Y1JKC6YlS3QcCyuDFfekDq/mA7zmm9pO0PKfuJ+lA7K/8Q4ocrPhmoKd2zAv7Alh5uzN4b3N/IjcG1Jh91Q3iRK9DC7vSvyNA1BxqMrTBzvZWO/p/Yw4wFElmv7mCOqF/56qJWTTJ24N7awV0zLLsrIkwjsCVLPkTEeFrHhLtR+ygCsTFKS9x0U5FVP4PppXwnmFcyVTyUUyi2THgDZzYGrThzHEiXs+KlubmddQMfDSxl57wjWP90iz7Bx4md6lF/Uas11dpnjAEFtYsgvic16yZ9hz+giMmtLno73pwfi5u9DwdYtRI0XSntdjAnA0kqExSK6hPqNtXHCmG2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SN1PR12MB2591.namprd12.prod.outlook.com (2603:10b6:802:30::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 23:36:37 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 23:36:37 +0000
Date:   Fri, 18 Mar 2022 20:36:35 -0300
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
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org,
        Khalid Aziz <khalid.aziz@oracle.com>
Subject: Re: [PATCH v2 00/15] mm: COW fixes part 2: reliable GUP pins of
 anonymous pages
Message-ID: <20220318233635.GC11336@nvidia.com>
References: <20220315104741.63071-1-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315104741.63071-1-david@redhat.com>
X-ClientProxiedBy: MN2PR11CA0011.namprd11.prod.outlook.com
 (2603:10b6:208:23b::16) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35210681-3bd8-49b5-a35e-08da093824ce
X-MS-TrafficTypeDiagnostic: SN1PR12MB2591:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2591F9FFB9A083EC7ADF577CC2139@SN1PR12MB2591.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VpUAUI9oxjBzNJCNJadOwgxElTT0SnJOwqodg4x4fVaPgvhGR5xeaBsNCA8LWDXDOwk/+/mIGYW1qBP4eVFoYKfwXU51wt+PCIL2daxQXIjIX6r/m8Q7Qgl/RRRJ5Y/SYg33DrTsYhUHgw9AzY/h3d3RX/6apeROP70XYQhlMj0csYG6PfHvnacBHTVn4Otybpij+ZFQwvw0cZ+9eqmw1VAhcDgjqua5I3tVgrbppWa8xlDSf3hv+9GvFtzslQQqWxN4qNnOpUxY9wCh4yZY6b9oWs3Kx6QqIlCZBKe6yxsSkRcJh48uSSUEshO0sS66FQGIUgWFWD7EKxtk/PauhwTwDZAx0MMyReqXaVtZCxtn2xclCe+LIyMKkaDcJThmS2X3c0QZVCJMTqsSLUIGHXBS2s1FgYYbrfBxtc2X1jAeA0L7axBNOfmFgekhioi0fxHG2cLV9h2/j3xVNtz5dPympM3lX70NZ1pA6DWQxj3Fu2PS6TzHdoOin5YRaQCVfvqngUbspWFMQBJE6l4IdAUoFNuMg2yOmaJrUZF2+vbuj9jlP9Mc+eOH0RAv/gUYDxHdyJfS3jl1a8Na8OqgrF9x0lbKUS6JUQLPs2PeJO9PeWmIkMDPLu855NYDfb4XPcvHDuulu6IvDOwGzItmrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(6916009)(36756003)(6512007)(66946007)(4326008)(316002)(508600001)(66476007)(8676002)(8936002)(6506007)(5660300002)(2906002)(7416002)(2616005)(4744005)(1076003)(66556008)(38100700002)(186003)(83380400001)(33656002)(26005)(6486002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BzPvLaxKYtcU8DofzfKC3kduWOFSXS1Ps2Zt7D+JS0+LTkrMBYLnHX2urcWq?=
 =?us-ascii?Q?4ZUIcpn0lnOXaMeSA051gY7J5EAThs8NM8JMNOApZWD2cw9b1YtGd3v+cznN?=
 =?us-ascii?Q?jQGlctAs2zEl9RcmvFldejZj0JhkMXnNBT/BNSrPN/kSnfgLsIhb8j44Z3yC?=
 =?us-ascii?Q?IwJViNMeyFe0Q2oRitBEW84m/o9ojeu22QZDgg4LIoiCO9/dRx052dEFLo8r?=
 =?us-ascii?Q?C90fakM7RD9ZYaTC6ZnaPm/1KC/GYiXy3XAxZESxEWy2Mz0LxTdBAACHGtG/?=
 =?us-ascii?Q?zYDDXE8lUR/Rp7DBVK0dfXgvcBmVM9xuq+9PeOHMmuwEol1jZfbl6kwot51k?=
 =?us-ascii?Q?0HB7ErkDDD8vElgIqzObHDXgbdFXfXhxf6FxiylVjKMqJ7M3aMWvCCdu2SNh?=
 =?us-ascii?Q?rmJhGbnWiJi5iYC3l411DF4fdPlB10i/avxjbAk2i7+Hs6cPo/VT4E7jKBrG?=
 =?us-ascii?Q?By3y76Gp3Yu/A9glQ6rtM5NdSDnneSxy82MDOw2sMn2Yg18P+vwzNMa3xD9C?=
 =?us-ascii?Q?AQhJpI4xvWjYmFGZkjf+DOy/6kjesT34ae4+VYap9kVZc7e7wt7EWn7YWp0D?=
 =?us-ascii?Q?VuJeaxDTRoASFUQWqzU88nukv2yrmaJllo0Zlc8OaZ0CozbiEA3DAujk8iq0?=
 =?us-ascii?Q?HcWTD60dQGlra2QJaHph7lHouk/J8Zxa6JwxHO09G45Y7ZOqZItOVjOaWOvj?=
 =?us-ascii?Q?jQ5WCHqpO+nvAFrPwJVW4H4S2zD4XFCCl2HzCkVmixy0XxOr4iNLHQOugNZ3?=
 =?us-ascii?Q?TxVtdMG70ZfXJjoHPAvebnlWOcuPVF1/tMbd8rpntFVW7iN+5RY1O+vM1laY?=
 =?us-ascii?Q?3lhS9sCjO7KclRk6eP11QgWzSmPDrDq5mApe4bznc8jegU/wDEZCa4WL+sc+?=
 =?us-ascii?Q?KZyuBT/TpBq3Mf2/Y3so/6GTKyIfzRc3k5Dl69dIAk++gWB9djq3heu5+f2L?=
 =?us-ascii?Q?1//dLjJBDD56YeCoFh56CHg88HYdHmkvHJEUFL8zZyhTG9o0YPtq8rExZjGt?=
 =?us-ascii?Q?mBh4lwqRk7pbEocSJsjJhbeTdMSwUovN/ZZ/P7a4JCySl7551f/BVBE0jEWO?=
 =?us-ascii?Q?dmuvvoeFPt9rMsT+8vNFFc/rozXMJpOLScTN4EOeFZH6TN7Uu06EmlyTd5dk?=
 =?us-ascii?Q?Cpv2f1klmByos8NbxE9wPyHWIUvvCHXPxqXKvFSpaFkiuCnQE2r6ex+ZYjc7?=
 =?us-ascii?Q?fqEq4GLqBYaIfylNXrc1nMdheQuM7hakv1yifD4Keau4Gmk1A5u+AK/cel0O?=
 =?us-ascii?Q?UoZt9c80rRWZ+y4Bn8gpl6M7QzexmOMhkjxAlULRfzzfJHeD9CKHb0BVlGU2?=
 =?us-ascii?Q?rQdF3EgXFNBPsZ98jvfGkuEzBK44omA3R1EdBr5RiK+X7fDyBRo8uRjG2f95?=
 =?us-ascii?Q?qACisUpgY82XwmmbYnM4k/lPV2tphWI9JiJM4nhTZJMr4SWFhwRgi2i1RfnM?=
 =?us-ascii?Q?LIebUtOhoqPqm/kpuLpRwRVDzz0Cgm02?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35210681-3bd8-49b5-a35e-08da093824ce
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 23:36:37.0917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dOamuNctbm8WlpBZP0guoSGaDZMfXeJe2OVs5gUS1IcLiO9YT97MVjWNwIFoq9WM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2591
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 11:47:26AM +0100, David Hildenbrand wrote:

> This series fixes memory corruptions when a GUP pin (FOLL_PIN) was taken
> on an anonymous page and COW logic fails to detect exclusivity of the page
> to then replacing the anonymous page by a copy in the page table: The
> GUP pin lost synchronicity with the pages mapped into the page tables.

I don't know much about most of this part of the mm, but nothing here
gave me serious pause. We are trying to run this series in our RDMA
testing. Will let you know.

Thanks,
Jason
