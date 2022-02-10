Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A5B4B0B3F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240070AbiBJKqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:46:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240006AbiBJKqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:46:14 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09D7FE2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 02:46:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjToKzJo6aAJNlUy8oBFNkXFdJkw9SHGPfqjgQxo0xreISaR0rBuaKi/MMASr4dmt7AOUN9jGOwJYqWTzJ9qvpVZAjGSddlku2olcn71b8f/helyOArqPbwkuFJ3W86ETqLB6ti2P4DVtNu1g9oYDUMDB6E+EqEIowipkw36FV9md9mFajzb73nSpQr0sjZCnFr6kogi7i2CN+WTad6fxCZKF6fU6TXjCiT3tWmB5k9rFrCaBlYvVC1PhoPj/063+d5ZnJUYSbq3JVSs7KIXnaWWlxvbhwDr5I3zIOrR/h+03VKevAVxcAI5An9YPd9cmMx1dbwJbwuJ4zmhXwEQ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHJdHP3XsDlfuJQe2q73BClNb8AfWL94Ii6kL948ayI=;
 b=LtcPoxwkaRjehZSTD7JdnXQMJgP3VY1A+b91VYRhqTqDV8TVl66nnFfbNZZuF44829+rnWXoURG/GDxXgyOXviTSDmUnveH5jyofsq57AWSzyvIfJ82CRSfUScx5QZdHDYpqmMz3jJiLSNKRpjUgZD5PFVSpbrX0rkMbat/OxhIv5eEoUTLTHgHFz9rkJILTco03Lp4S9wa4wt16v/Y2UM5rK2zPAWW0WgKlmQhYTJV9dg59IIX+Oi9t1hyejWyKyvShVW0uXJ3aVnJcnH9ha2YrjM5roDpIn5VkAVJfpHxsgDlkDo5RHTholib0nQKjZpzeRHCQLeQXEZ6TbOyupw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHJdHP3XsDlfuJQe2q73BClNb8AfWL94Ii6kL948ayI=;
 b=t08YNwMf5i9ZNa/uMOjZPhXqIJjY0dOhIOONX79TkOQJ0jqVDbblePK4d2coGYabr5y/3ZfF467QkdC3eGvlZcKe2FJZThmxNgxQOAzNVgdO02jCEcA0IFU4OagruqrXRqKvKu38lLim1oOSRqTThLn5fLoYDjT00Gd3lFw9SjN+OhfYi6qVtHztn1bB95gGIhuxzpm5s9fuhwmyF90ps09zalTZ2SLEL+D/TboXUIQqSAiEADGr0vukOHkZKMr4I6AIC9nCdMr6YoGW3BqHFDNfyay9XyA2k73kXXg50tCQ+DA1KX8COtHf5ofgVXEMPGeA9USGEoOOCnp5bJ0fUg==
Received: from MW4PR03CA0174.namprd03.prod.outlook.com (2603:10b6:303:8d::29)
 by BL1PR12MB5378.namprd12.prod.outlook.com (2603:10b6:208:31d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Thu, 10 Feb
 2022 10:46:13 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::10) by MW4PR03CA0174.outlook.office365.com
 (2603:10b6:303:8d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Thu, 10 Feb 2022 10:46:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Thu, 10 Feb 2022 10:46:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 10 Feb
 2022 10:46:12 +0000
Received: from nvdebian.localnet (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Thu, 10 Feb 2022
 02:46:08 -0800
From:   Alistair Popple <apopple@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>
CC:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>
Subject: Re: [PATCH 12/27] mm: refactor the ZONE_DEVICE handling in migrate_vma_pages
Date:   Thu, 10 Feb 2022 21:46:05 +1100
Message-ID: <2486253.gG6I7sY731@nvdebian>
In-Reply-To: <20220210072828.2930359-13-hch@lst.de>
References: <20220210072828.2930359-1-hch@lst.de> <20220210072828.2930359-13-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77d714c6-ed32-4c04-57fb-08d9ec828e85
X-MS-TrafficTypeDiagnostic: BL1PR12MB5378:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB537860F44DF5F20D4F6BD0E5DF2F9@BL1PR12MB5378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kcbEHdE6kpF7sxS6GDIcAxii/TzCQjGIOv1TKIZtg6Ntv2mjMBwPQzOd7uEpxfJFW9kF/q1L5hMlfd+jjQdqHYfi0m4HivdKa2wvwAlxw5L2Yl7kldWjwvsMm7yferitovqh8uxPP8jrJlImtwkVA9B/MtmzGNy7K1dmoqcxjk9KK6VgBjxiq80R81cJKsxuu9HhQDb96prDtj93rHwLt/EEVIhTC4mwOFymNZ8ZFozxwS3sfvoQlnc/kL4PE9DrHTu+iaVFHSHaT18A7Cnz2jdgMWU42dfr35WOnYsGQQa9fO51z5H+5/IFFQZJUbytM95QfblP/PHlYKsb7eYSrJcvkfIPpSdtQe06Mi9GMX+gZBIrTTNDAP7Zd19+DbEQpAsx+7KUr4JmcfKohfrOS4VQndBluxggjQSCnpA/+Iw2l151ToUohfESZprkWngb6FnR5ZFgUVpDurSVTFnIfjoV/w1aDW+cY5NA+Byztjfth5DRsGx3Q8sZDCMKu8saQQWNwrDBlS6nWZX2N9FVfp6vh83uMzQny+zcUElG6z4gLMI0X6kwxhRBN7mYj0kGjUSo1qM9B5gGI7K03X6hcr+ZQjarYXAmD/41iZeuhx7X7XsyzezEIqrEBKjTGvOGrzUKtDD9P8IVqdobW0rwPQ/6UaYvcth/3SvXre8GrN21GFJRhUiBvvV90U+V4T9SPwJTSp4OM5sJoTZWqLJ8Zg==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(508600001)(26005)(5660300002)(54906003)(81166007)(186003)(426003)(336012)(7416002)(316002)(40460700003)(86362001)(356005)(16526019)(110136005)(70206006)(8676002)(33716001)(70586007)(9686003)(83380400001)(6666004)(36860700001)(47076005)(4326008)(82310400004)(2906002)(8936002)(9576002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 10:46:12.7518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d714c6-ed32-4c04-57fb-08d9ec828e85
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5378
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alistair Popple <apopple@nvidia.com>

On Thursday, 10 February 2022 6:28:13 PM AEDT Christoph Hellwig wrote:
> Make the flow a little more clear and prepare for adding a new
> ZONE_DEVICE memory type.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/migrate.c | 27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 30ecd7223656c1..746e1230886ddb 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2788,24 +2788,21 @@ void migrate_vma_pages(struct migrate_vma *migrate)
>  
>  		mapping = page_mapping(page);
>  
> -		if (is_zone_device_page(newpage)) {
> -			if (is_device_private_page(newpage)) {
> -				/*
> -				 * For now only support private anonymous when
> -				 * migrating to un-addressable device memory.
> -				 */
> -				if (mapping) {
> -					migrate->src[i] &= ~MIGRATE_PFN_MIGRATE;
> -					continue;
> -				}
> -			} else {
> -				/*
> -				 * Other types of ZONE_DEVICE page are not
> -				 * supported.
> -				 */
> +		if (is_device_private_page(newpage)) {
> +			/*
> +			 * For now only support private anonymous when migrating
> +			 * to un-addressable device memory.
> +			 */
> +			if (mapping) {
>  				migrate->src[i] &= ~MIGRATE_PFN_MIGRATE;
>  				continue;
>  			}
> +		} else if (is_zone_device_page(newpage)) {
> +			/*
> +			 * Other types of ZONE_DEVICE page are not supported.
> +			 */
> +			migrate->src[i] &= ~MIGRATE_PFN_MIGRATE;
> +			continue;
>  		}
>  
>  		r = migrate_page(mapping, newpage, page, MIGRATE_SYNC_NO_COPY);
> 




