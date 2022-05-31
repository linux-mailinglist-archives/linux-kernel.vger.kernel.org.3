Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425E153917E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 15:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344583AbiEaNLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 09:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiEaNK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 09:10:57 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B1060DBE
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 06:10:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcCxFwHuhElE8sc1AAAvEg1E/UjX+QhoFTdqU7ibgnbpTiAmrW0ylgwGkkmE1ZspDirKEnh0ecQJEutgrN2l8ShX28vpn7mn+MDiyzXn9odVOwIjcy0KsYzaQ9UxU2hxHi6OVeAlBpbmkgImNjsjfZgAjYDPRM0hIILL+HyhA+LUrT+4hHHHCk79cdnBIHpWijl7GtGrEbzV9zFRHDfEX7u3fGCYzYnSo9zYGIa7aen1BZX3zG9ss/20LaEsCecoDBJPnn0AzRmlAczOO8VkzJ6HJK/xh3fJAQGyfljVSOkhKmUhtIT3JG57cNCBQ8kEi2ZCrvLDSPG0ohyDtZsFYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kfml99+v+LDclX2DNd3tAzC3kZ0LOVOsEd7nupkUFeE=;
 b=NNglKSPjl0EcAHiqtUsSzTIGRQFx8/oWcB0Zo4J7A0whj2jq7NVEtXX0UHX4LFr5eH2q+Zl907TuCbTNTktfdOMoBbcfF2YWQZJa5kKN7sp+yKvrofu9XxlQeIGCadayXjjM7n471b5ct4NF1WaPtuZiJHsz1uDxV+qhA5KIesM80pPDwkUWnphqPNs955b9LeYYN4qCgT2lL/oFgWDOrg9QG1LaBmsMP07TBZaGgGnLhBPBDRQnbClCnk6KAox7QjPbD5G3Ak/LueZhtuizeFcTLbZc+8MBy7kyhdE1F2LwTEe/yTn6oz8ySJfV94XMPDTfGtesMF/AQcaMucOM8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kfml99+v+LDclX2DNd3tAzC3kZ0LOVOsEd7nupkUFeE=;
 b=lTRSCoPEHxmHbzfREK/qLYmPxLlKDZ7ojX2rIIQGMsQYuxSMeftUI5dVZvVT9sBcpRJQi+w7RRqk5BkEkmf2yXCAndRPH/p6ZtuRkSkd/GxDz5fG6DweM91i+Iv24yu3kIg77r9y3zB9cl9fgbqAyixjmBeX/xITgQYWp+j71Y95avu9v5t8eGa1Pf8xya6IhrkMC3WuVkx6nqTK4Kr/jTdet7/j6K96dJloH9aujw6wH3k8FGi4ytpBeWFphA5O8F5W+ewe4SF/Jb4bQ9VoVeHkkF3VmW7qyuTD/B/Bf/ereqmlyHSJXgU1MmlRHmQD9lXhPmF8IWDgfHPBMwFsuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB3686.namprd12.prod.outlook.com (2603:10b6:610:23::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 31 May
 2022 13:10:53 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%9]) with mapi id 15.20.5314.012; Tue, 31 May 2022
 13:10:53 +0000
Date:   Tue, 31 May 2022 10:10:52 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] iommu/vt-d: Use iommu_get_domain_for_dev() in
 debugfs
Message-ID: <20220531131052.GD1343366@nvidia.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-2-baolu.lu@linux.intel.com>
 <20220527145910.GQ1343366@nvidia.com>
 <eda4d688-257b-d12a-56c0-0f9d3a10ef8c@linux.intel.com>
 <20220530121412.GX1343366@nvidia.com>
 <42623a73-c288-1c0d-7021-93caff4ffb6f@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42623a73-c288-1c0d-7021-93caff4ffb6f@linux.intel.com>
X-ClientProxiedBy: MN2PR11CA0021.namprd11.prod.outlook.com
 (2603:10b6:208:23b::26) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ed524bc-ad2b-4efb-6670-08da4306fda3
X-MS-TrafficTypeDiagnostic: CH2PR12MB3686:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB36864B183A1FA57747824860C2DC9@CH2PR12MB3686.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +jaiGGNB8X9D6jdTIf+b5WfEUS0VJ0j6jyWT16H5ndyGAI6hpqqZ1GI7DmeyQbeEwXuqtpy+vSeka6R/Nhd2PQhnUNdihZs2O+y3TK4sA2xW8NDr1ejo+oXdCYwLt9zHCZBkHniY6uThBH7fLCTxWZ1wEcLleqjU179elbvpl1oOfGXaekel8/QYZYfv5L3GcVYxlImA8s5BGu5aWv5NfPATnmFGDbQBhYPzfCmiOSAmq0w64DUAR5cc2QJwnoGUxwT5yoQxTXMETuYkw0BTbjFUp3fNM+ndh943AM81ub/2pSyJiyQlKQtWH8fgKlfv6yVvQK5orE2uMywyDgPl3D+3lwVqxKJgCIQBOqmjgSky5EwBQS5PQJM2iMUJ78vzeVfOIZc55JMZ4J/7UrJcxrPVZCo1iw4hFmzKpe1VMApbceZ2ThSh82MQY2oqQH7+7vJV6oLlAcgl4l1ljdWZOt+mhraafWIxGTdgK+BKWFUwvDDSdUVKoY5FD3Lf49EhDSduYd5qJZ5vGHir6mj1RWs5pAxI0nRj42VNO5bQFzikXAw3W0Q5idlORbJbeFZGTkKfupU8KLKzQMeaU4lOD4i1kJAIhSt2xPW7xz7qWyS1rwODphFliWd7F3A5IjLGBNdZi97UOaEtpPwn9tGqTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(2906002)(6506007)(6512007)(33656002)(83380400001)(2616005)(1076003)(186003)(66556008)(6486002)(66946007)(7416002)(8936002)(66476007)(4326008)(8676002)(5660300002)(54906003)(36756003)(316002)(6916009)(38100700002)(86362001)(508600001)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z8APMk00/F+FZhQ6FkWP5J+j4OhiWS9FrPSz4cRRh2XXkL2agoSH/bzmDI1H?=
 =?us-ascii?Q?MD6CXdsZX0nzvA5/sPIVQMLFjZvSdh82EKwiHJ/LJ9y6B4yPm2KrC7YgKdGm?=
 =?us-ascii?Q?TU0X2UbUXHFx3Jq3hvmpy2dbyCf/W5ainAJg0DG+ihbbkzL7lgY4u64FHOkv?=
 =?us-ascii?Q?/SgV08g4Ybj62xAmJjmScsqNKzQ/duUrMcLVxuQ4ulEWG7YCh9odBRaBRGLK?=
 =?us-ascii?Q?qhPwNaaSl+o3bIsEhY/0mzZmBqyUzXieO7S2/V4ME+2/NKsthJIwzbeSj7oG?=
 =?us-ascii?Q?Tw+8MFFZr2WH0r8OCS/LwIC/zmcdnrMGNbbyci8gKWJcmxa+Og4V4sWkg+ik?=
 =?us-ascii?Q?KKDR1GWhq7wv0Tf7MSbOXfUG4KMcB+pljguZQMSDIB6lpbBxjvfkgPZXjtPs?=
 =?us-ascii?Q?60Nzz571BdbwavWiK5eEyG1xe/OojlYHKXOHe/icgcZuY9yYqsK9u368MZ29?=
 =?us-ascii?Q?FZGM2UOOp37wscSijqD9OPlv6UAf9/E1kFgaP7Im1XgJWkUiwrRhrmZIWlMi?=
 =?us-ascii?Q?P6ymAILMMSo9DLnornRWDQNsNAhkL0LZCEEFtpHHhTaBqkHhSeVFAb5GqdQM?=
 =?us-ascii?Q?0XlMJ4dWkPmwPnsQ5bW33rcmlwSXxVxTpvIKafQt4KnNFRRkR6STzfsZ4OvD?=
 =?us-ascii?Q?CHCm0qVGSimmqx6uaW85K6oPRfHa+XMNlq8VbRbduPVyWoMjDeZBJlrNKuCw?=
 =?us-ascii?Q?93nEX4/9/wxTySlvq6ruCE+6fzLh19YzRf116ZiBLOezKZchD87v9sVQe5z6?=
 =?us-ascii?Q?kmvV3a7n5xlqjTrVgF7QZlDbtvmh6OXUmrsEqX4/lY1ogoJ/QLVy2mCy+WPF?=
 =?us-ascii?Q?by9O4T31iy52LtEHcXdEdgb0clykxZAHeOJyszcPczdcbp0AFLj6sTp2WD+o?=
 =?us-ascii?Q?QE8UwszsNUibQZbARCWmAZRNHCKmyDzsaJNE6TrwShR3c7sq3qE6oGhKSOtq?=
 =?us-ascii?Q?PbxFwlpu0F+LjBGoXSG7OOdiydGvtFOsaalKPWpJHhjoJpZq9H8M7XbzU/B3?=
 =?us-ascii?Q?FIuHUtnBDJnjQkPhU/66gM3O3GKu8LvHgu62F/rv/dG9pHDEvR2DWeW66nEt?=
 =?us-ascii?Q?ovmkswFO0FMEmvn3dHEEPQvw7upngeLEx8uBJobwpyi+5cQb82ToUHJV5aR4?=
 =?us-ascii?Q?o5vC31yLK16YV10rqzwq8Dq80G34Rzc+PQNfKxCGIpUbmazsEr5Zyj5wgnnU?=
 =?us-ascii?Q?yPmXf/jsF7XOnhRooI4iYGazfriIjP9oSX91r/THvdAuqyCx/yakOqTmrQ1X?=
 =?us-ascii?Q?P58c8V/3btULqdKy9zWYt91TLRNd89ovqj+W+YP1BKf7eYdze3lvPcRg0rBL?=
 =?us-ascii?Q?g1NT9KPs8lVphUYXE1fw4p3QY6kHdZGzGjlMWHkvP0lvRiAjmnBDOeTunHZO?=
 =?us-ascii?Q?W3OPkPd6KafAwYKaLUaPexymueEbjGSgGMnVctEd6pzp4wea82lj7Hk71MhI?=
 =?us-ascii?Q?lh1GRHsVqam7EF/C3ahWQrupFrLXQ8nOhnbsvfcZlS6F3eM9lajoRO0R4nud?=
 =?us-ascii?Q?V3oDa+laQczx7kMmvDMnIyGFFz2/hNebf5rTWsUqg/ngScjxGdTbyIu0LZLg?=
 =?us-ascii?Q?aHcxHhlct6CMBgjV7PjLobDqei/ca4IEc3TXEWhXpZtN1PV2pgTwQRX3y3Zw?=
 =?us-ascii?Q?dUyb1d58qudCKKSN/irhSJDrKHOSJjXsfQW+UgcVVTqKejm/8fEehU943Q/Y?=
 =?us-ascii?Q?zuGw6T57do67ms9utBKGavh7WlJfBTLKIDqnEyMqopIlVNxRR2FFyPZJt0ve?=
 =?us-ascii?Q?h+Uc/bn72Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed524bc-ad2b-4efb-6670-08da4306fda3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 13:10:53.3055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MmwWfu6JXLco+l3hNTA8iUyj3h7GtQfljthij9ApaKEECxZjK/VfODokH7cpnppq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3686
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 11:02:06AM +0800, Baolu Lu wrote:

> For case 2, it is a bit weird. I tried to add a rwsem lock to make the
> iommu_unmap() and dumping tables in debugfs exclusive. This does not
> work because debugfs may depend on the DMA of the devices to work. It
> seems that what we can do is to allow this race, but when we traverse
> the page table in debugfs, we will check the validity of the physical
> address retrieved from the page table entry. Then, the worst case is to
> print some useless information.

Sounds horrible, don't you have locking around the IOPTEs of some
kind? How does updating them work reliably?

It is just debugfs, so maybe it is not the end of the world, but
still..

Jason
