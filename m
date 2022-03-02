Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716054CAAE2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243279AbiCBQ4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235475AbiCBQ4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:56:48 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34A355BDD
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:56:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYvJmM4GE0Vmnk/vM9B9Uvt2Vys05/zx7KedrC/OttA1bxntg34nMLY4g8XErfrJm3E8rH9rZCaDOwGcTJoxEaL75cxjJhqj3P06iJKIzr0bcon3wS53Jakrau8sHWeuAq935UZdjEME9PbvA2Z4KdRFJ+suaG65RrfSZetvpcPlnSBJHo11Fzn9uZE1U5eDxCxttnstbwZDK5ILpZqWQTqabhqA/JmUTbLTXzxRPhg4yFEjRmCFd8y96kIp9LVIAUQIwcooyYsnG6ELI93ysfmEPUXxs1TvfiLnZXyqMVrgNMn20FvcHr5CVPCuuUlmgekDiIgtvJR+/X3ZqxmfpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3Gxvrl2nAYrnSi4OIcaJuTcFNV6uIW8oT7cONq8pnM=;
 b=WcZB0aKoOZOGRQps3dPh1KCLzt3zvTeDugGniXoHpPVXgP0i01vAzHsr6EgVT1Dnqa7TZNr1ERJOUyoXKCXE31rtJcYStVGPuIEkYpapm2HmBVlkHl+1k7hN577YLG+ZdLvIzmTWADYETBOR9EwVNJAZlV5jRiHX7rFxNtfrU11lbjcAbAuvDszmJrmjg+jUWCa88r3JMC15fHYoUb7bicCynxZOWaKe31AQgrX3SnuniPDk/q/Q8/eNpbEgrXB0/9YL9VlKXMJzRanvaEf0JmyHgQdFU2Bu1ZObVqWSEeJCVc/6+cgb83CucOzUxOAOZ3FhWRYnVhBXJAJQ5pCpPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3Gxvrl2nAYrnSi4OIcaJuTcFNV6uIW8oT7cONq8pnM=;
 b=emcgUdGwj3Q7MEyD4Cw83zpeAE6IAn9SZFRLWhwcvWhWfYg+mQzGlZhlOsLpfBwdKbqECnGf/nmQcff6TqaGrMyH7mgVuZH5w4uzX8cgOYXjqU/PlTl6p5VR6X0xt5yrYjbbtr51FXMgPQS2P9mlVr55j1qYCL2ix3bwXnfzbrtcoe+1amXprf8eeW+oYPfcGZTh+nyj1zYAwm5UluS7G/XL1SDf/DgdnLrHIxuD4x4Sqhkjq9fGdkclCslC1MwaMzKw/L1PnOgpvYEI/Y1LyqPEMFYf7hqtQoho8ltSODvlV536DLIqCV4v2OSvXPvwcVk3IUlQXr8mfg+3T4Uwlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL1PR12MB5802.namprd12.prod.outlook.com (2603:10b6:208:392::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 2 Mar
 2022 16:56:01 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::51a0:4aee:2b4c:ca28]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::51a0:4aee:2b4c:ca28%4]) with mapi id 15.20.5038.015; Wed, 2 Mar 2022
 16:56:01 +0000
Date:   Wed, 2 Mar 2022 12:55:59 -0400
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
Message-ID: <20220302165559.GU219866@nvidia.com>
References: <20220224122614.94921-1-david@redhat.com>
 <20220224122614.94921-13-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224122614.94921-13-david@redhat.com>
X-ClientProxiedBy: BL1PR13CA0111.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::26) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d8e84b5-aa7d-48e3-acf4-08d9fc6d87a1
X-MS-TrafficTypeDiagnostic: BL1PR12MB5802:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB580281DBFEF060A4E59BF153C2039@BL1PR12MB5802.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5XzcdjVRWnhnLIxhzKrznjiSLV55HSEFwQu+vGH0+hRI9amPG5RHQamLsgmdQ3/1F1uI7g7fVQPn4CT2VRVD95d6djZoPWL0+PACEJLP0MYP1Rpdoe2+fRfm+Opkn9q3CXJWx3GNTQBoRcAFAE3OahFi3j5JT6u3gh61KT4mw0soH91yIM++DJw/z+yKANKwaOT6enX63IXiupj0pqJ6lA+YSxPNjN0ZV/5200uioE0sNzpY6QyJiTuPjL7ZbunanM8QYqXDcveNwqfnwJrhZFComLiGtRECDzHzwdedY9O+LZvAKnRfkVVXcBH6Ec4LMevR0nHp2VAKIMSN1KMlZ6d1RpbXI6CDfU3/kDMo1a1rz30ISEsW6DhwCbXaV/iVP29H0bTImjoHGecsvAiGJ8WNBmiPYSHtpQqQS8NyDiz9k0/szSnW608P/zEykpwclfsCf7jrl/7fzaS6VTO1WAlwx3RrEPb1QF/veCnhRa+J5DY6yuM8hQsp4mkRkh+bIBB0ZFxT3lr+2rrC8lKmT3EpGA8jXQDDevx5E+v9k7ANptErLCyUtK2JoTRqnOMTEK/nnk261LO5AkNZuK3R9AHafm1EsaPXpi+jJ31OzLxutj2WdLXcpuTNn2tP1wyqFfCMf5LmtJA0kEWX2IAok+YuWImPaMjUbaynN9ratzvbH1HoNGFNKTm8fBDSTPfCa9mvzsoICkUOjvsl32wayA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(186003)(33656002)(6512007)(2906002)(2616005)(6506007)(1076003)(86362001)(38100700002)(83380400001)(54906003)(6916009)(4744005)(5660300002)(4326008)(8936002)(508600001)(6486002)(66556008)(316002)(66946007)(66476007)(36756003)(8676002)(7416002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7IxB3Y2X62mvld8wBfa3dL83y0B0Ljmeo4p4s5QBVvqMSODfQErjkDB7jD3m?=
 =?us-ascii?Q?oewDzo5v1rvcl+GhF9HErPhikgcMsng5gXpdwPyE2Uj3AWC9Lry+G3xZNJND?=
 =?us-ascii?Q?vxUpOugA7c4wBEF4SdEvmMHhE+hTKGHpzpUnx1q4+6JJ1LwNFdivtWhfOqQQ?=
 =?us-ascii?Q?v5xCUZMJ8L3+6g/A267/YTGEU5iVEsS3YxT3T1wjS6yaeOs1lym80M9/2c3C?=
 =?us-ascii?Q?SmH1ucvL+VWFDcVhMTpNOgwdXhhjW6TT8cfVXRKW59Rn5mfHgyPsCem6LYcj?=
 =?us-ascii?Q?Eju+360ugl4z6a5e9vWZEmRTxoL6kdRHS+UKukIl/rVntdC84xI7Y2aJT2zA?=
 =?us-ascii?Q?Soo1ZaXQZuKiZ3hoWAu319IsZLvvc7vABAWgUt1xBiawbUE2A9ya5NGDEBZk?=
 =?us-ascii?Q?mirDV8i5KZLtOEmnGVeOosenH3s8Pd8l7FWCbJ6hkQwsdZVuGSPt5Nla5iOh?=
 =?us-ascii?Q?fDGyiNut06scJSQw0w8JnqRRzOWN5QRB0rD+HvhJ1RoNbKGBvIu5E4vo3Y+k?=
 =?us-ascii?Q?gJq8wPxwdvd0NbN7UKPHZlOfUFFP5Ge2dI8a+kestwlF343n2jHsRi52RlV7?=
 =?us-ascii?Q?jRAVWkVF2b03mwQyAy/oECABh79rgnaS4TzjLj628+k5XRggOUmew0Y1xg3g?=
 =?us-ascii?Q?SxPBKGXo0erwUmShllVXM/ZTjRifHZSmYqLXJ9Z6tZPZoDMRRnm/3j5vCfjk?=
 =?us-ascii?Q?8i+c2bRRl8Tme1vk4miBOJE0GMdJvBuJ1URjVFivaRG5xeYcuOiHerHCHy9F?=
 =?us-ascii?Q?rR9Nzwus2s2pu7m62HQDmBT1ZIFytofg3Bm9RGRaXpyLjt+7lXYppXJHBm2D?=
 =?us-ascii?Q?zJRKuoicOSoalXRc7277OtBvVlgcGTpgL8lKH/+s1BuvkylyMmV1/iCana7a?=
 =?us-ascii?Q?x0I5fCPvYmCKA2Nv+wkQZp8UFee7iaVRFwZ6tUqAsNM27aYmDmK1iL+3Atgw?=
 =?us-ascii?Q?yQEITfmKaSS60qesdwm6C5ngeycPnLMeTvErpdfuDKVWxeYMm7YHe/JctLl2?=
 =?us-ascii?Q?mRStlBBIWAjiFH/wwENedOBXPjt4TM1M+YCKhh4sorGEK5HI+1CX/RamzWeJ?=
 =?us-ascii?Q?6jtF7RmjTd8jIlH7V2c/3Aqynqw1PaTzsNE0a1WsKKAep9pI0jB3ZiYI0YzQ?=
 =?us-ascii?Q?cSFBz/dH8/Y3a7bsiciEKjGyzJl5wQXPSxdyR2rJrtHTq7elYBlENWfG9sz0?=
 =?us-ascii?Q?hOWbM/eIg8rB5kSvk2j8+YyuTXByTVCu2BTiU/Fu2fRxUDZajEu2FYlhOgkA?=
 =?us-ascii?Q?tlfH929ejLcezVyI0r8FYGsfUlinXXcfvv7+hVHpX3PXO896FIRtu11Nks0q?=
 =?us-ascii?Q?OMRG7pQvjDSZZ9P47qPyqj1diKXlmG97eFlJUogOUgUnzJpssEFS91vmN9q4?=
 =?us-ascii?Q?6PeYRiax/XS0wd/E+8dJenSeBQw/JeFlDx0K9aGeQuhoq6VkWsM8Ww0HCsz4?=
 =?us-ascii?Q?6TiG1Nd6lGZtOGOoxiFRBETUM+KCEUT83XmpbKVp5/xH41zZ79nRE3D5iZBZ?=
 =?us-ascii?Q?qHlu3BSNFi9Cq8JMyjDpSlP0Qcr87nvIRbuTrdzlncdG0OTp+jnHcYhE1wcW?=
 =?us-ascii?Q?s2W387ioOc5TZAke1x0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8e84b5-aa7d-48e3-acf4-08d9fc6d87a1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 16:56:01.0084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M8FD0XXZ12c5nsSGB1g8h/3w2jkKtKIOfJRMsrTe2QV7hnC4ZVp6qybWvIW+ndnE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5802
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 01:26:13PM +0100, David Hildenbrand wrote:
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

How does this mesh with the common FOLL_FORCE|FOLL_WRITE|FOLL_PIN
pattern used for requesting read access? Can they be converted to
just FOLL_WRITE|FOLL_PIN after this?

Jason
