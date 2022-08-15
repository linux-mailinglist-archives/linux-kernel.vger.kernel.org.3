Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54BC5928C8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240657AbiHOE3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiHOE3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:29:06 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A9812772
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 21:29:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bT10Y1dEN6ZFc+sK/9TKrtVAeQ+ag5r7aun85FeTYjLHliS03lxBBwnhlftzXAbP7LY1LzZ0Hk/wwg9Dm1AN+MiBudxQO/jt1r93n/pZiFDTyD9OspspNvbeSi4Tlf8eZeJL6eARSpQQOJigGVHpvJp4/t9DV+xdqoYEXs8R9m4HY87jQvrwQf88Dfg8q4Xomz6yjofhXDcoq9gtSVyCOoefl8VxZrZfW/6i7mJ27PDsziPk53T/XtMCW63qBdrxKzojq7os+Dw4LNC9/SLdBxs2/iqOz8H8qXnfmzOkdQzmkvJZLlGzeDCmZ8R4B6CvJ08EDM4gDSD5OqKc26em6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwhF1Hbb1NCwyRrzsVixskArU/4A8veRSjyvxUqWzd0=;
 b=csNuhAzIZWBw+St67eAvn8MfPGq5CcwME8IISlM6Dwh4gzuc7eVWQuoisd3DwmDykdQMqtrwaju7pyUGk5utBjDUXiO+mriZOSNCTO4DLoNJhKUt/7BNswJQ/OCwXUlC5T2VbDUeCidvw/2AmuI3/dn/m5zWXTgzHogbPrMObz58Xs2ev4Y8Btd//iXS50kWil6juUMjb+vUp8HZ/tvdkRJyYd4CIkkhqfIk1L7Fu6SxtVSnGGkgKqlXfm9fvDv3m7oQWvrHTkavoYwA/ngQqvKDSitm4L7U11QUoO0CQ+6GECgUCiwHpZROR+qW3oLB4mxB7a+EZd0nGCWVdxXZTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwhF1Hbb1NCwyRrzsVixskArU/4A8veRSjyvxUqWzd0=;
 b=bPjLr9/VWriL+QsFM9J5z4SfSfQVcYB1X/Mbij4LnsumRALGKb0eFYQQTcJr/2Ke/ahfMTvdfMZ9xF6IIRjmoxuVZkG/jqBP+n2KYLMR5LPX/ycPXmxqlRm9pfA/EqY/HSDLijjcEx6oPET6//upkgoBFnwK0w+hJd4nGyCNdxx2xXrE4skLNtXDvi5n5uh0HOo8KEJehxsHiR60wm9/cZTetqo49l+8liprfXJ9CjZRYC+K//OYzMPefS/b3fqs5aZdArBYGIdLgvWvBeoEntn8w/kPicvu/+hXE6bqpV9QVLuqo89Thx56tEGSyJMkppALrH2p6EKG/1YIKBnqcg==
Received: from DM6PR03CA0022.namprd03.prod.outlook.com (2603:10b6:5:40::35) by
 BN9PR12MB5084.namprd12.prod.outlook.com (2603:10b6:408:135::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Mon, 15 Aug
 2022 04:29:03 +0000
Received: from DM6NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::17) by DM6PR03CA0022.outlook.office365.com
 (2603:10b6:5:40::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.18 via Frontend
 Transport; Mon, 15 Aug 2022 04:29:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT092.mail.protection.outlook.com (10.13.173.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5546.7 via Frontend Transport; Mon, 15 Aug 2022 04:29:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Mon, 15 Aug
 2022 04:29:02 +0000
Received: from nvdebian.localnet (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sun, 14 Aug
 2022 21:28:59 -0700
From:   Alistair Popple <apopple@nvidia.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Haiyue Wang <haiyue.wang@intel.com>
CC:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <linmiaohe@huawei.com>, <ying.huang@intel.com>,
        <songmuchun@bytedance.com>, <naoya.horiguchi@linux.dev>,
        <alex.sierra@amd.com>, Haiyue Wang <haiyue.wang@intel.com>
Subject: Re: [PATCH v4 1/2] mm: migration: fix the FOLL_GET failure on following huge page
Date:   Mon, 15 Aug 2022 14:28:56 +1000
Message-ID: <5767084.K44AtQxeQl@nvdebian>
In-Reply-To: <20220815015909.439623-2-haiyue.wang@intel.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com> <20220815015909.439623-1-haiyue.wang@intel.com> <20220815015909.439623-2-haiyue.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5395edc9-a221-4622-7065-08da7e76aef6
X-MS-TrafficTypeDiagnostic: BN9PR12MB5084:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qblghk8eB0M1YokzC0RioqS866kiM5+PnWdJt+KBTWr66FWlPtzsCZq+6UnVFANjFZ0UfV8vArv/BoXvGfRbs8HLPLQ88wevtLmsbMrqh9BeX4lOdniw6fhAVR7nwGUuw8mPkNvF/n63AZfARwHi/kX3dLaThsNBAjk89t2ardeA33dAxeYytNJKKa9iXfw/5K1INGgVDOXLthb4t0gcISXyf+X7r8WjQRpngKOoA7loLobf/yNFgolxs8Jn2Athv9rBLAWr+x5AELl697THmvnZ+8jR+9LiHrxSTGhAS3NGFIYBFiBBUZwcrtWte76H/SIvhisntUR+9D+UMJzsldjKGVlyQWHCheu/o2DmUGu8W/Ywih4ulcDRB2Bjpsvgtbs1gqh83F65ARC54MGuF3XDGm0uPHZKm0047bCdiVq1PaTxG99MbPe7ZTG5RsYhtxlkLbCVrHvSPBeN6Pgfz/NMZF/EeHXLzc8rWJYZbIIkEG6qHSrcanM0AUaqXy/j+YVdv5WosueAF+CmDambMKnQqJtMlzEM4IwzNW+0IGT5chIIUb3Zp7EzXXnr6Wh5vSTLE+iF2o0O4oV8mcDprCyjANkh1sbVpTr0M3VuFv6SgFLAlqqP3eiZ34B6OZQoOaRwvzh+ahnitnmWjmwCFHkbwcypyy8Beo8l18faDCxBLHALeMPT7qCv+1WG6l2WT+ChbHmMSWjViPTM0SqQXuCROUHG2GSbKnWhtI0AND6CFFZQu+Q0J36bTusqUbVFzIUXojDq4ZAE7yxo5qu5Paov5l1USKm1nmacSXQHjbcUXRrWFfJiARmJc/fN34VMfQXYTf+tNFPzWimG4fTA47uhIXutAJ1yghOGzyOBFBctDp3tju61c0sYpyGSG4G2r974iSuVNU3pho6txEjzGklmgWYwMokV+S7Ie0aSp+o=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(39860400002)(396003)(46966006)(40470700004)(36840700001)(110136005)(9686003)(26005)(6666004)(86362001)(426003)(336012)(316002)(54906003)(33716001)(478600001)(186003)(41300700001)(82310400005)(40480700001)(356005)(81166007)(40460700003)(82740400003)(83380400001)(47076005)(16526019)(36860700001)(7416002)(8936002)(9576002)(70206006)(8676002)(4326008)(5660300002)(70586007)(2906002)(39026012)(14583001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 04:29:03.1723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5395edc9-a221-4622-7065-08da7e76aef6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5084
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 15 August 2022 11:59:08 AM AEST Haiyue Wang wrote:
> Not all huge page APIs support FOLL_GET option, so the __NR_move_pages
> will fail to get the page node information for huge page.

I think you should be explicit in the commit message about which functions do 
not support FOLL_GET as it's not obvious what support needs to be added before 
this fix can be reverted.

Thanks.

 - Alistair

> This is an temporary solution to mitigate the racing fix.
> 
> After supporting follow huge page by FOLL_GET is done, this fix can be
> reverted safely.
> 
> Fixes: 4cd614841c06 ("mm: migration: fix possible do_pages_stat_array racing 
with memory offline")
> Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> ---
>  mm/migrate.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 6a1597c92261..581dfaad9257 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1848,6 +1848,7 @@ static void do_pages_stat_array(struct mm_struct *mm, 
unsigned long nr_pages,
>  
>  	for (i = 0; i < nr_pages; i++) {
>  		unsigned long addr = (unsigned long)(*pages);
> +		unsigned int foll_flags = FOLL_DUMP;
>  		struct vm_area_struct *vma;
>  		struct page *page;
>  		int err = -EFAULT;
> @@ -1856,8 +1857,12 @@ static void do_pages_stat_array(struct mm_struct *mm, 
unsigned long nr_pages,
>  		if (!vma)
>  			goto set_status;
>  
> +		/* Not all huge page follow APIs support 'FOLL_GET' */
> +		if (!is_vm_hugetlb_page(vma))
> +			foll_flags |= FOLL_GET;
> +
>  		/* FOLL_DUMP to ignore special (like zero) pages */
> -		page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
> +		page = follow_page(vma, addr, foll_flags);
>  
>  		err = PTR_ERR(page);
>  		if (IS_ERR(page))
> @@ -1865,7 +1870,8 @@ static void do_pages_stat_array(struct mm_struct *mm, 
unsigned long nr_pages,
>  
>  		if (page && !is_zone_device_page(page)) {
>  			err = page_to_nid(page);
> -			put_page(page);
> +			if (foll_flags & FOLL_GET)
> +				put_page(page);
>  		} else {
>  			err = -ENOENT;
>  		}
> 




