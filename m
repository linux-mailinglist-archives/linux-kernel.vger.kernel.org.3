Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012D4476951
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 06:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbhLPFB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 00:01:59 -0500
Received: from mail-dm3nam07on2077.outbound.protection.outlook.com ([40.107.95.77]:40992
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231639AbhLPFB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 00:01:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6NylE3BijHR/gHhOkn1m+uUlmE8oBegtHLjHPXt4uhdSy0ACfHHh1Wo8TAVEAsCXDFHJkz02/X0F6RbAQwDAgyBB2SQMzAMmYWMGJLsv0sB5KnYLBcompFMTgqMp72C3Gv81T/+mTiRnp5CoPmEIVerD1sSppHoPq+MKmT4ehzhd586RS/wZ841aeqWIDAFj8PuttTYef7oNJF5xNXMDfIgKKtDxReSRq9j441rUHl3KmH9hBEWr15UzwDbz+vdNnbNkqk7awJdlQM4G9jMT/nwfNhLdaFjUQS5JX1/VT2I43wBpKv8k8EyMWjOEbfvTf+ULoj9ZivPZ/RDtzYGOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQlVUKsZI8CAPfhHxTvXFio+ueQReA9gardyVilNz40=;
 b=ki5jiXSaxZb4Di+WvJGv5QLuM8oUiIqTnCrazdRGvULP+Cq1/B5zidkr6bxMQvOc3p6NTSEtAO1kjf6Cu35J8lDwpZYREIEnF/kjXCu2pTZ3yjC+5GnzgryVrRRWXn7wmj3zd9LlwDarQzIZ/dyZSEJKqLRjgIVY2LR6D3ovsCFMsCqiDh60GIoaGOtM6Y6ytMdVkCUxrfxwQcHNM9/8He8oVGX+yMJXClYDi7mKx294qt8ZEx924yUJZN/fC/WWeMtq0AX+ai+Nn1UVlFYXkU72+3PrzzlnB7inS0HvQAKytPMgGaVj8yutgw3cn+cIMpNDtUXtnrgsRwugct3cyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQlVUKsZI8CAPfhHxTvXFio+ueQReA9gardyVilNz40=;
 b=Dbfis2cW6adG/eLHoHs97SOcZdbqrqY7LuRwM98WHVvUVDJvqwHB2hiRgvQJfo5qLZ6by/EgzU10dMgaveZzmAz8AFxLpwHsiKlJYQ9rSQ9Q1OJ8UnFw5BfSv66Tk5lIp6sf83rnM15H8PYnuhqsjDs9jXS82++faxT69+8BX4reIX9AIX/Q1WsGPwC/tzcghAyOduFS5pKJltKuuv1Lvls/3Mhp96dvSQ8LzvJevg6XOBR3L/uus8RYAq1dLx0DnE8yJR7vpJCAfO3+VZft/BiHIGL9nHW9FCU0NpUxnIrPD3IogC4spXdh6a8btz38i6/97yzK7NOh/gWU4kfdHg==
Received: from DM5PR06CA0045.namprd06.prod.outlook.com (2603:10b6:3:5d::31) by
 CY4PR12MB1943.namprd12.prod.outlook.com (2603:10b6:903:11b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.14; Thu, 16 Dec 2021 05:01:56 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:5d:cafe::dc) by DM5PR06CA0045.outlook.office365.com
 (2603:10b6:3:5d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Thu, 16 Dec 2021 05:01:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 05:01:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 16 Dec
 2021 05:01:54 +0000
Received: from nvdebian.localnet (172.20.187.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Wed, 15 Dec 2021
 21:01:50 -0800
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
Subject: Re: [PATCH v6 03/23] mm: Check against orig_pte for finish_fault()
Date:   Thu, 16 Dec 2021 16:01:47 +1100
Message-ID: <6260997.DYpkEd5BTb@nvdebian>
In-Reply-To: <20211115075522.73795-4-peterx@redhat.com>
References: <20211115075522.73795-1-peterx@redhat.com> <20211115075522.73795-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d04085f-5d24-4990-6907-08d9c0512ede
X-MS-TrafficTypeDiagnostic: CY4PR12MB1943:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB19432E91E2FD3E595844F115DF779@CY4PR12MB1943.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1uVSSVedQY6FxwdpgI74s9RIKtbJ52komoe/ihFHRHmhG/DypdJSj5wJB+ZhRSFaO4yvR5/0SyWXQEPeZbxBBRFTL8cNtGBY45Gn3vbYqnx0kTHNeVp7cjjIqyCX+ElEgGSKRZHz+5KoLMbhystlrhwzAfo8oGfCjiPpACOPPkcYxpbDcVhrz5+JB4hZbCiIRxLK8jxaadyXIHqqqlqr9JFr8O11ygGBnCon51JAoJBLshCbxIoEKkp5MOH0Sq7GUa/1CIOL1LwM4d+QsCz/MOzNRhP8FqpdAqR+RktayRpV3mPtUNIpMXv3BuxGGhkDDWl758ZP6Adf+H9zHtFcpRTq03sJgGOQQJoIsPTi93Rahp+5OfGMTJdtQmY8Deyn3jGI2XI4A9zgbDi2DGE/VUzEytZLzeXA2Mzznnos3lpPm7Albq7ttQXxHkdsa+8A5IgKusyChOJ2NE2IRkRiJI42R6ScyCeaqZ37Gs8hNaC3H6CiK50g63g3OhVBoNyo+JfIaH3Fy1B3TEhdH0d8XJjyrP3kxSYuZZqAEzf0UqB8NDCV8tJUt/kjQ3wNRiOgbHuCeAwHL+I+SrKOeYRdv+owwo6v4Fxg7wFDcMdWEG7Zo7gnN/1vG7GSt5UG/NUxwZCt6tK+sMaHlBYtLwBFJxMcoLXdSzPhIXGnhb73Lhgm9fcq++tOlKJ6HAUwbvdEYkr5VIjUixOoOQ/pmTVwnNOo1AX6AVOwdfsQx8OJebHUQ0ojExQF6ITCtm/oAIrgGrrQBRtefOSrFoiEcxjfclVimpUzR6SOuMxyycsKZkUWOmrVMZA8nBov86n5w3ABHBlD79HXbUc8IAhnLFFrbwKtE5XhlS1ejOpEqptKWEUbbvOyQQLzYnGdnsvH+Swm
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(6666004)(7416002)(36860700001)(86362001)(9686003)(70586007)(70206006)(356005)(81166007)(2906002)(5660300002)(4326008)(40460700001)(83380400001)(26005)(8676002)(110136005)(54906003)(33716001)(316002)(508600001)(9576002)(34020700004)(186003)(82310400004)(426003)(47076005)(336012)(16526019)(8936002)(39026012)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 05:01:55.9597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d04085f-5d24-4990-6907-08d9c0512ede
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1943
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 15 November 2021 6:55:02 PM AEDT Peter Xu wrote:
> We used to check against none pte and in those cases orig_pte should always be
> none pte anyway.

Is that always true? From what I can see in handle_pte_fault() orig_pte only
gets initialised in the !pmd_none() case so might not be pte_none.

> This change prepares us to be able to call do_fault() on !none ptes.  For
> example, we should allow that to happen for pte marker so that we can restore
> information out of the pte markers.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 04662b010005..d5966d9e24c3 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4052,7 +4052,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>  				      vmf->address, &vmf->ptl);
>  	ret = 0;
>  	/* Re-check under ptl */
> -	if (likely(pte_none(*vmf->pte)))
> +	if (likely(pte_same(*vmf->pte, vmf->orig_pte)))
>  		do_set_pte(vmf, page, vmf->address);
>  	else
>  		ret = VM_FAULT_NOPAGE;
> 




