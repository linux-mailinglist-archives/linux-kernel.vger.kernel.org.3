Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDB34B3A64
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 09:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbiBMI43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 03:56:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiBMI40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 03:56:26 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2074.outbound.protection.outlook.com [40.107.101.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D56251
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 00:56:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cq4/5v8IHQV/YJ2/ivFMraH0TY8BGzolgAZIbqV0JXTpLzprB3SCWnddPTiTOhaiCpxScIqtcI6XOhQ23e3EGg+3+YEmWXfOwllCcqKkCc9Y7LOU/t0cFiHAG1r7ZoAHP4fm2PIfufSzG400R7n9xOyc9dMKzKDEoZLz6A2SunBUYPRRnxGEBZqLlULamunDSA3Ia9uULyfO8g80ZoXPsxW1nOvV4ZwpkCi6/d5Djoq0Fwh0MbfocSMmfgap8P54+ZUKTovwEZTOF0yDEizPtPa4WRDAhaIBKYc/9scwxCWPqKBGy3TRKM+s15JpkDkX1ZDVlC01RIZP11D5Cd78gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQJWmc8CRCglnhoxG/JfDv8MiHpuY6N2DSej1PX0MAE=;
 b=kBBqfaWMGBunlLN3nE9Xu04SBL2zAHuQnML5Vx5k9axLbuXHpnfitJYIPiD6N4RlJi67LUEuGwIGNJnABAzUC6fhpJlAReidg+is5Jh7NSYM4Zw7ryaS5MuQdRBrItPwft9/JqpD3lQt5Z7neukPlksyLFdjYaFWPnwh7f91pqtzDK7O1nF7TlV+t56/iaPRWaA7yZdvFwuMNSF9W7MLHFPCvy28EAKPaLdGSswEnZQF+2DWGA8bj/WSRQgD9BYP4BJ/SeNZHjT1HvcsX2nCxIHPr56FzWv0ZkS9dkQvlhrIu66zGEwGTwFwBKaZlvdB98b0Aqa821nblXBu07wRdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQJWmc8CRCglnhoxG/JfDv8MiHpuY6N2DSej1PX0MAE=;
 b=QntQg+j6wvoPCU09KyE9xTNF5O3Nmds6TI444nvAXM7GySf6YIQYe4W4MVO+Ko5gstSy8vO/MDfrcPKLi3qmk4B17kyiWOW5WICU7G1FtEkAWdYdBDOQSOcFctdctdGC8jdZDVD107l4Bssp1Z8tIPoubv+k+0+JsbyUZRi8XZWgEzvp1BiXde+Ar0JcxGm1ZqabvfFIyBnscFFC/NYCidXhEwvh2xXBTxKupJYYDttJtEeY4wl7bDtrz30A9kOFTB1EqNhWGjdBWs3lH9w5ONkf4/IewIh6STcTse3dqf6MYUUrR+yg4tCSib569LHS8p9oeqwrsZdM33UoCEAj4w==
Received: from BN9PR03CA0430.namprd03.prod.outlook.com (2603:10b6:408:113::15)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Sun, 13 Feb
 2022 08:56:18 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::d2) by BN9PR03CA0430.outlook.office365.com
 (2603:10b6:408:113::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15 via Frontend
 Transport; Sun, 13 Feb 2022 08:56:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Sun, 13 Feb 2022 08:56:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sun, 13 Feb
 2022 08:56:14 +0000
Received: from blueforge.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Sun, 13 Feb 2022
 00:56:14 -0800
Date:   Sun, 13 Feb 2022 00:56:14 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Rik van Riel <riel@surriel.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm: clean up hwpoison page cache page in fault path
In-Reply-To: <20220211170557.7964a301@imladris.surriel.com>
Message-ID: <10f4319c-45fe-2a7b-db6f-2d5fe8ae98a0@nvidia.com>
References: <20220211170557.7964a301@imladris.surriel.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa399f8c-a98d-4c01-1e29-08d9eeceb2fc
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4175B34AEF572A4B41C6ADC1A8329@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jmHXChNKjp9kgqHL62rziCpB6bkhvmvjbp1uz8gBOUGW1WIIElRQaTrTnBuXba+RUIWKuemOBTQNtgB2t4S/1rTjJa0WRx8hWvGKZTm5T9ToK5ah3xAqvhdft+TiB0ALsuiBdALMofbLGNgJAW4Wc5QW+C0vdynoVaSNg9GuyosgcaaT5ceg7jogWSFP0dvDRVCPqtumVx1OZgBjoK9TzA5TGGBUXaH7R3vJgNGXHUhDk0VQ8jOlVerWLdib9fC7rEdzZmGr4oCJRUStarpiG5tUtSJJd8r8RbTI0eZIR5f5WLmdNckvCc/d+1UO5dXga2qkwm2H+JIKXDT2188e6jekmTt/lRpWVfulnfrz0LZmVjktKLLU9RqNA7wdgze3QmLD+s4XKV3IHvf3dnKpyYtuWvXmjU6RayL/I0vNJz38g+rpFGw9FKffueWOR1UmsNEY/PkfKQAqCN2Bp72bi+X36NFWAlmzaDqjYiACy76fvRwafPw+KjLuxZ8UWtYmcWUK4wS07nRrkxy4ceSnJzdALCa3adOYM52l8d+FHqadZmIIte80xn3m/POmiGsS3toI8ECi6bSjgKUx2pgFPjjIkCTiPgwPDOUUsJm+fivqMl1mKk0HEBspZwtc/qJ91gu7U0eJWjjzRLZGBKyx4dt6jUoyJFWxC1U9prxwMgVZRvbYwyT2TI1z46YUFkw8ryWWN7jimiNPloW0tkLV4A==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36860700001)(8936002)(508600001)(4326008)(316002)(36756003)(47076005)(6916009)(31686004)(8676002)(70586007)(70206006)(54906003)(83380400001)(2616005)(2906002)(426003)(336012)(31696002)(5660300002)(81166007)(86362001)(40460700003)(16526019)(82310400004)(7696005)(186003)(26005)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2022 08:56:18.1458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa399f8c-a98d-4c01-1e29-08d9eeceb2fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2022, Rik van Riel wrote:
> Sometimes the page offlining code can leave behind a hwpoisoned clean
> page cache page. This can lead to programs being killed over and over
> and over again as they fault in the hwpoisoned page, get killed, and
> then get re-spawned by whatever wanted to run them.

Hi Rik,

This looks good. Some minor suggestions below:

>     
> This is particularly embarrassing when the page was offlined due to
> having too many corrected memory errors. Now we are killing tasks
> due to them trying to access memory that probably isn't even corrupted.

I'd recommend deleting that paragraph entirely. It's a separate
question, and it is not necessarily an accurate assessment of that
question either: the engineers who set the thresholds for "too many
corrected errors" may not--in fact, probably *will not*--agree with your
feeling that the memory is still working and reliable!

>     
> This problem can be avoided by invalidating the page from the page
> fault handler, which already has a branch for dealing with these
> kinds of pages. With this patch we simply pretend the page fault
> was successful if the page was invalidated, return to userspace,
> incur another page fault, read in the file from disk (to a new
> memory page), and then everything works again.

Very nice write-up here, it's rare that I get to read such a short, yet
clear explanation. Thank you for that. :)

>     
> Signed-off-by: Rik van Riel <riel@surriel.com>
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index c125c4969913..2300358e268c 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3871,11 +3871,16 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
>  		return ret;
>  
>  	if (unlikely(PageHWPoison(vmf->page))) {
> -		if (ret & VM_FAULT_LOCKED)
> +		int poisonret = VM_FAULT_HWPOISON;
> +		if (ret & VM_FAULT_LOCKED) {

How about changing those two lines to these three (note the newline
after the declaration):

		vm_fault_t poison_ret = VM_FAULT_HWPOISON;

		if (ret & VM_FAULT_LOCKED) {

...which should fix the krobot complaint, and the underscore is just a
very tiny readability improvement while we're there.

> +			/* Retry if a clean page was removed from the cache. */

This is more cryptic than necessary, and in fact you've already provided
a write-up, so how about something like this, instead of the above:

		/*
		 * Avoid refaulting on the same poisoned page
		 * forever: attempt to invalidate the page. If that
		 * succeeds, then pretend the page fault was successful,
		 * return to userspace, incur another page fault, read
		 * in the file from disk (to a new page),and then
		 * everything works again.
		 */

> +			if (invalidate_inode_page(vmf->page))
> +				poisonret = 0;
>  			unlock_page(vmf->page);
> +		}
>  		put_page(vmf->page);
>  		vmf->page = NULL;
> -		return VM_FAULT_HWPOISON;
> +		return poisonret;
>  	}
>  
>  	if (unlikely(!(ret & VM_FAULT_LOCKED)))
> 
> 
> -- 
> All rights reversed.

Anyway, those are all documentation nits, except for the vm_fault_t,
which is a declaration nit :) , so I'm comfortable saying:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA 

