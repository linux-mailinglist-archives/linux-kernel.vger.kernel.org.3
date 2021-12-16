Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA517476966
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 06:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbhLPFTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 00:19:01 -0500
Received: from mail-bn8nam11on2050.outbound.protection.outlook.com ([40.107.236.50]:32225
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233679AbhLPFTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 00:19:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMW7uDfuv63f25eCcn3ZBu49eGsl+scZgUta5cOCDeKo+aFjv33eTrFs8j4qfxipYsHpvEaTtvIb4LKYP4QDypo5mbHLeVIlzAYnC7/lyAsedBB+iwx22buZop0NTU07wyZjuDZPOT82YtoNuD92s0zoYsrcQmWQZz24sexbRuiy8+hXjXQy5BNtJqMt1rER6yM4fEakT8njUU+xc3OVShV5QehU0hNkGx4ODY3ysRqyzKtPl36BWOvUsVdHINyId0RoFz8WlsjCnObdq71SAIo9EX3gSDw39jDQ8DKIbgavj3zN4+7yZQFH6bzY/aKzuF8snEDibY7Ecyieqc7B5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxcV0tyjoiyrLiGx2coYrBgcm6MaDwj0OVu5LenmfGk=;
 b=DgvaytbOGjK6Id2/8uXnj7vpb6lZE3WF2HZ8oyQf/laV2rrAvVN7X1Mpy138bxXb7PEfjLQY27m7TuTFKgt5M0AEa76+OPCUq46f2sBk6127jsMwqdqGFdtJH7/nd7F2j+vIOowAY6XcF4+f++QA+nGiVT77+X16Ihx2YFhZkIb/owDEt7PR6N3pXsIVCe7NRjQ76w5NXXyVSZ6gK2yFNHR5MFJRnoy3o/IVnq8WqcKnX5EmAzrZ5b4nrzmyaV7BiLVK56KoozEdu+heXL2bIujtbvzdODENQlYEK7oRmAREXpHpsZGw82EugXtsFaFKD7eej4h1k3/4tC/U2aocrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxcV0tyjoiyrLiGx2coYrBgcm6MaDwj0OVu5LenmfGk=;
 b=VzrsISw/8mjhLgTILJanWeJabgbVtQ/ZCgIkBlv7B87SQIv2x+btAh6yzPAExploT80sOLD6iRaNnReixrYYBWwEQYETa87uJkmFw1feUUe8RvbwmR4mveeK8oXZGGP/CLMvhX5lodGij5FvOxr1bHhmJZ+FWv+Nw8ztOOd/esfZpYPZXoGvokuONkwhZFZBFSbpyA8a5G5CDU8sd1yK6jCFB/HZtgJdk0hoy47jJYiMYZnfAS9Bu24Q+5R4hnhJbOWPVRi0h+K7LvslkDJwufaFIfFUw6jq98mBB7M8FiIJ36evu2abAC/z8sJibXSA5su2MTFpesAnqvBhn5XHng==
Received: from BN9PR03CA0075.namprd03.prod.outlook.com (2603:10b6:408:fc::20)
 by DM5PR1201MB0059.namprd12.prod.outlook.com (2603:10b6:4:54::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Thu, 16 Dec
 2021 05:18:57 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::2a) by BN9PR03CA0075.outlook.office365.com
 (2603:10b6:408:fc::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17 via Frontend
 Transport; Thu, 16 Dec 2021 05:18:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4778.13 via Frontend Transport; Thu, 16 Dec 2021 05:18:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 16 Dec
 2021 05:18:56 +0000
Received: from nvdebian.localnet (172.20.187.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Wed, 15 Dec 2021
 21:18:52 -0800
From:   Alistair Popple <apopple@nvidia.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>
CC:     Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        "Matthew Wilcox" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v6 04/23] mm/uffd: PTE_MARKER_UFFD_WP
Date:   Thu, 16 Dec 2021 16:18:50 +1100
Message-ID: <1966495.R0KUr5dvoW@nvdebian>
In-Reply-To: <20211115075522.73795-5-peterx@redhat.com>
References: <20211115075522.73795-1-peterx@redhat.com> <20211115075522.73795-5-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ae5e387-0f73-4755-0ce9-08d9c0538f9b
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0059:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB005936602A4A61E38BBC8A03DF779@DM5PR1201MB0059.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a3mHh7rnalGVok8Fen69old4hdr0rUUhswovydDKvmugHmW5HfnKRIMiPRGNXSCeRY1UDATZmUNatLRiiVwhitgWcP0NTnwm+cfLwpYsRiDLgvHwdBtd7ONMzVVL/8FhxuaVFA/+znwhDmvl2EBzOFszv1ZeqUOoQnjqdBLcPbyhLZmoajIPzIYcrBGnM66mRe0+zaPoz7Fz5L8mDHr//Z+u+eENtA0apehtvyLaGNg666tIrIA4+53XjlQWodDSxmDLMFxk2KPIxoDuJRML8N4scG4k/rznzOem/XFtxZ40s3hDXqg3+KKki8heeGQ97/7gCdToVo5WWf+c9Tv+ivXbikiuHxE0nHGtmXq92Obr34eE/7ww9yFIc93OB+0bGB+3EDU5vbp6imo/WL/9Se0CeSmNmAXOt5Rrr2rB+YW/JqFFIP8RP03+lDFP5bmVGp7jzoMkC18yM5qDXy1YD/DNoe6aoQ+b2Vknfv1CtS8NT9+pW2Ye74Yr0x5My8q7quyRKZ3vuwZDE8iPG1hhHgPmamMetO4YtQJ2qd2aNYZyXyl+T1ML3d/rEKTP9a70J+TBY4pV3mz5Qmvxw0mme5MbBR8EfPz8YHFGs0v8CDUUhf1YAEtxCOrOPBJCrFIYURXW5Q7rrKfY9CvvXLTjVwMxTKG8JHUiZhhXas+xjvRrqwP0jlh/Lbp8676PfNQhmMAcXl1JxZZmJ9LUWqkPQUy2MjIB73eapFjPQJsqKG98xd/LE16EaYp9Au/MiQFYZc3qAulJ6VqJUx7zSAxfAh+YkVcacyQ776Bwbh0lAjkdKXTxBjBjNPriqMmCrBU/7+UMvSmORP61XXTvrxT+W76QUmuRaI9uqNaF0Qgv4UZhuIkdnfdrtNhQlzsWD14z
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(7416002)(86362001)(82310400004)(2906002)(336012)(186003)(81166007)(9686003)(5660300002)(16526019)(40460700001)(36860700001)(4326008)(34020700004)(8936002)(316002)(426003)(47076005)(9576002)(356005)(70586007)(54906003)(26005)(508600001)(33716001)(70206006)(110136005)(8676002)(39026012)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 05:18:57.2039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae5e387-0f73-4755-0ce9-08d9c0538f9b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0059
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 15 November 2021 6:55:03 PM AEDT Peter Xu wrote:

[...]

> +/*
> + * Returns true if this is a swap pte and was uffd-wp wr-protected in either
> + * forms (pte marker or a normal swap pte), false otherwise.
> + */
> +static inline bool pte_swp_uffd_wp_any(pte_t pte)
> +{
> +#ifdef CONFIG_PTE_MARKER_UFFD_WP
> +	if (!is_swap_pte(pte))
> +		return false;
> +
> +	if (pte_swp_uffd_wp(pte))
> +		return true;

If I'm not mistaken normal swap uffd-wp ptes can still exist when
CONFIG_PTE_MARKER_UFFD_WP=n so shouldn't this be outside the #ifdef protection?

In fact we could drop the #ifdef entirely here as it is safe to call
is_pte_marker_uffd_wp() without CONFIG_PTE_MARKER_UFFD_WP.

> +
> +	if (is_pte_marker_uffd_wp(pte))
> +		return true;
> +#endif
> +	return false;
> +}
> +
>  #endif /* _LINUX_USERFAULTFD_K_H */
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 66f23c6c2032..f01c8e0afadf 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -904,6 +904,15 @@ config PTE_MARKER
>  	help
>  	  Allows to create marker PTEs for file-backed memory.
>  
> +config PTE_MARKER_UFFD_WP
> +	bool "Marker PTEs support for userfaultfd write protection"
> +	depends on PTE_MARKER && HAVE_ARCH_USERFAULTFD_WP
> +
> +	help
> +	  Allows to create marker PTEs for userfaultfd write protection
> +	  purposes.  It is required to enable userfaultfd write protection on
> +	  file-backed memory types like shmem and hugetlbfs.
> +
>  source "mm/damon/Kconfig"
>  
>  endmenu
> 




