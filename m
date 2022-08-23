Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B966259ED80
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 22:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbiHWUkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 16:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbiHWUju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 16:39:50 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E052327B2D
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 13:28:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AS/O4Z9ZbIrNa3vcJbPRN84BmVzsGLtQsF20N+fajX83trZQjeaT0xrSchpL/g7kkjM0WwGXTKwWm0balExTzshFVehXJHafKTSRXzEBKcqURrOGPNjHUNE+btM9ZJg0mXmJLXH4uotDXEwJzpQrr4QCgLF8cSR/AsyPi9wxb4JI7+npnSklCfk5uQyfMSP1SXiRLlPQsGbLkKbK/D//lrLK8AHAYiYy1ylkveICqK3fnjQmy55xI5UK9cB05DdUXKlddhPlaTJ+TlAWAPPdwcTVhEQtSqMR2DP6TUpbN9tlSW4AwqQsBT3U0BxmczKxb1APoV5ULmdNF/j/FcZ9kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bFw2JyWBqdCkh7+c1fL4YM3nYeA+8pVFK+yCOHsVno=;
 b=mns+gnxMpZOt081n2U8g3Wy5VKRFEyxdNKZCw5mePRap/362TaIMeY5KUK5AkHgeiOgrnVmxpVXprwaAxzQgeN4ROYfX8RmLmIEbzePSimzeenQzGMkqWOKQ3Om6xsQNSrOWs9nrkZa+bthH+rn3pKb+Y84XxwYG0D/pROwoyt/m/Exx/YbKFKYWy8G3zy1LaCzyXD7ZUvV348RcmJcbPbsxmFrydqzaJhPfX/dresPWTCwxJvfy/1N/6/lhBGyObkwrGGQz2Llhg3M6F6IwoaGPBJO3pt8SuZOn/r72laFNFOjWRmbSK4hUYrOX+IosF7o0jGOIUHGj5txdO7spFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bFw2JyWBqdCkh7+c1fL4YM3nYeA+8pVFK+yCOHsVno=;
 b=sfIu3QPEAv0d05hv4nz2nc+Zp4cR+U+gtZGrCBzZgnEibcaFu5WW/8UbUVU9ya3H12tgwKWt4VfGf817Y4kqbjdDy1EwFFV0WtQ/XFlctmulL7100m5zRjNLyp2q98IjdNlVmqGv6Y5xU4XvyxUV9L9PuiPhyR3d4Y/6G6cle5cVREjWP1e6OwYYivUUhomeB0ap1RrDoe+jND6OLnUAcjdn1fCU8oeIT7BUN5YLwEg1XS4naPFgWJeTnqm3SG6KNr8mvAJepVfGF9Qs30NUYP6qbB6TR/vz72JVDCSsOpCApvB/GhCd6Mm/iaruohtcsvsXiAVvy4yDjG4I5O0fAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SN1PR12MB2463.namprd12.prod.outlook.com (2603:10b6:802:22::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Tue, 23 Aug
 2022 20:28:37 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 20:28:37 +0000
Date:   Tue, 23 Aug 2022 17:28:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Eric Auger <eric.auger@redhat.com>,
        regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION 5.19.x] AMD HD-audio devices missing on 5.19
Message-ID: <20220823202824.GA4516@nvidia.com>
References: <874jy4cqok.wl-tiwai@suse.de>
 <20220823010021.GA5967@nvidia.com>
 <87h723sdde.wl-tiwai@suse.de>
 <87ilmjqj1f.wl-tiwai@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ilmjqj1f.wl-tiwai@suse.de>
X-ClientProxiedBy: YQBPR0101CA0184.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::27) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42eb10fd-a977-4bff-260f-08da85460ef6
X-MS-TrafficTypeDiagnostic: SN1PR12MB2463:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hGC8ZSjhv6FXjjLZCtgnR90YH2Pb6F5etNtKdQ5BCUlxbdd5lbJ3+E8Dcbk+qXMs277KBdY3SWdEPxKYZo/CSZd7NGwF/F3b3Zj0oy/Z22Qsqv1r/cDI1CLJa4jb5m1HHrdzgwtrG+QrX5WXXXCB/jrVoz8Wqu595ZCFMXXt2Sig1ECnV5UW8Zep0o+FR6jnOhlF2L2DrwlDH9ydGZJmoIp63xKoXF7IEI9DnEczYlLW+j2jX2fFyt6SMY2hsn9Mow7GgTTLeauO7oBVOJENO9JFn+8AGhgBx+ID+Pc4xth8uShEKom5BQy6x9AdqtVppF7ETBXaydxbtOVl2jifv9QsiohREIfPyiG57cwBhXMzjIWRRZx7HDoh9k/dcvqvYyJK5knkLGGIdY+Ut8IHyVwecpggXxt36uC1uVNcMCNBsf9kSDENczOaDsPHfAEXeAdnnjhMVbCUMj3M9A1zMLtpMQzNmQdS1b40Dm34JrblznwoW20Ic9UoT4VsGPybipV5MaDenlJr85LQnPAgvvKvmN+hUrDUREYx/dEZD6m065O+brOLQxj6+ZctEIiPw2E+xXY2XbQzrKWej7eBk/ipLWHCIp+l68Chj0TmH6pqvGCdmLZf+wtGzOj09rziVJVbLX9/bznl4EIyLQmuRy/skg9kxehCHyXOCI2Jff2uhwpxkw1lVhmLW8HOdf7unLRX+cVn7sWZFHerJNMh6SLOmXf0Yso4xNNc8/tiVXS3w/qbn8aDRPe/XfZWW7JElLUfeMzLN/bn0YO7tIKS7T2tFKwyHT/qdGRVRcEfdyI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(8676002)(1076003)(86362001)(2616005)(186003)(83380400001)(38100700002)(66946007)(66556008)(66476007)(316002)(6916009)(33656002)(36756003)(2906002)(8936002)(5660300002)(54906003)(478600001)(41300700001)(6666004)(6506007)(6512007)(26005)(4326008)(966005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TI5k6s9221vp9We0JRIegpkMTkuIFlhJl5QLNksGZ+cvb9FPM9rGcogpQ72S?=
 =?us-ascii?Q?Y6VCHlxWXk0sNK5boe1ZO2YAoOz25Yy9xsnbvbo/iJlYuVCV/zq3NBGmhKzM?=
 =?us-ascii?Q?1WbmFoQMscVtz0cCieAek31iUoeJ0ogd0YeFr5ML6ner7JCC9Su/0jX9l4JL?=
 =?us-ascii?Q?OYlwTeY32cApim8EObWXd+icja+hddh6/ZOnsl9+FUnDM9zq9zDNunA6fTqq?=
 =?us-ascii?Q?LGoDwc224cu40E5t2sroKI5GHoMs0Bj1DqXVARaaZEpbUozNkfPUadu5slA1?=
 =?us-ascii?Q?dXnAblAfI4pX+7BIakH+agdOuOk9oJlyY5asQ67v7ruKkKw7vjy+AAzltyc5?=
 =?us-ascii?Q?14T2IEvshIYogd6IRhLTrMWohr4gFWlQs8dPdMbC7/AI98wF2PNmDTD1cDQK?=
 =?us-ascii?Q?JQLWtH95ZhN1VpAlaidLBf2cIetsOt5/joKHE9l8U9/fKjzRLoxgtt5ArABw?=
 =?us-ascii?Q?Liy/vQKMFwiehSOgUwZSdyzg+yNTL1GjnD6smIuT8HLc/nbHJvWrlT7zXUub?=
 =?us-ascii?Q?TMu0GumMzv8Y5H8SUAjbXu6jfkfL1hW2qxSedVvDnbAZRi/i5yOIWjczhaVM?=
 =?us-ascii?Q?ksudOhQYwEJrG2ANIvIKThs9Gad+aoCSCBVBhirbfMJJ9yggc9RKdqSxCHTy?=
 =?us-ascii?Q?ibhLROpa5cWFVLsoX8BTxvd7s1OOQPIsbf28/zP483c6/Udpxuj/mDsBiAH4?=
 =?us-ascii?Q?KNdmAeVhN6O9mnKi/jgOSZeVQONcw6dkjT67/SnrfMsv2TQD9CB4yQ2BC2Si?=
 =?us-ascii?Q?aIThqM0cpZA6eLR2M78qCjvMWTBsPdnIL8TMRegIIoZQTRQlzqDzIe2R/nu5?=
 =?us-ascii?Q?0wKJAMaSxrUev3lCDOfDnv75Z+O8LusfLRQfrHnS6JiI2gkrYWCZob6iyDHA?=
 =?us-ascii?Q?IKGoeQt6fDFSGrr5FoJDaqUAKcdk47/AFaIpPjOjMpJYcdqW9hI6Fz4g8zSj?=
 =?us-ascii?Q?3sCAb5MxpZy27oREgGz6P0KMnX5jkbESEVUg5u3fYLRUDbhzrUA4R/3g5cZf?=
 =?us-ascii?Q?QQo+e8+6dw1QP731riuNDkEfRu1rmUiSvkEJWMvvpPBq2IeX7s8gQ0tCuZrs?=
 =?us-ascii?Q?AV/QqoMIf6Z22fLOvBsi/mlvmnmw4pEw0pPqJJsxM6FSfV/0Z5Lexq/DTFtF?=
 =?us-ascii?Q?X3AZBYTv2u1jlwpuPdZe0seBbsvtq6q68O2PpEqRR0HVsrk4zSWZ7ci9miIw?=
 =?us-ascii?Q?M2mYhYQThHDVJs8sDg8NrHiivzAELT50kS76Ej82wk68kFmHu0tKa79Km1BG?=
 =?us-ascii?Q?SB0NBeW+2PmEK+UfcL/Ik2NNk7Vb6/eCvYyuwreyrqAePsKaP08FhniPqQBW?=
 =?us-ascii?Q?FnjKZT65utoy513Z8mat21Dg7cAEuH47BVky+p+ZC60MPgVH38dn8hikT7/a?=
 =?us-ascii?Q?yJQEGrm8VrS6SjOt2eDr/G5AIkduMbY1EOniytfxXnakvIqOruzSPJIqM6z3?=
 =?us-ascii?Q?8yyhJDU6A4N2x71X7nTw/xY2HUwTeIPxYLsLeaRjlgGLGiWjcK7B8vIrIJwF?=
 =?us-ascii?Q?Q6UOGHsEOARmDAytI28KOGqjlWGhc47SJyn9r31ZannwTP4k3aqcnnRqykS6?=
 =?us-ascii?Q?oOzHeTkAx4PxaYL90ewkIPeh+l1TuvCXbSvbqzBY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42eb10fd-a977-4bff-260f-08da85460ef6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 20:28:37.3907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r0bWm2h9E2ZiQTLKtfJW758pSfjlmZcRn7ynnzQzOEzAWWsiLNu6Ef6tA8rbuJVc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2463
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 01:46:36PM +0200, Takashi Iwai wrote:
> It was tested now and confirmed that the call path is via AMDGPU, as
> expected:
>   amdgpu_pci_probe ->
>   amdgpu_driver_load_kms ->
>   amdgpu_device_init ->
>   amdgpu_amdkfd_device_init ->
>   kgd2kfd_device_init ->
>   kgd2kfd_resume_iommu ->
>   kfd_iommu_resume ->
>   amd_iommu_init_device ->
>   iommu_attach_group ->
>   __iommu_attach_group

Oh, when you said sound intel I thought this was an Intel CPU..

Yes, there is this hacky private path from the amdgpu to
the amd iommu driver that makes a mess of it here. We discussed it in
this thread:

https://lore.kernel.org/linux-iommu/YgtuJQhY8SNlv9%2F6@8bytes.org/

But nobody put it together that it would be a problem with this.

Something like this, perhaps, but I didn't check if overriding the
type would cause other problems.

diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 696d5555be5794..6a1f02c62dffcc 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -777,6 +777,8 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 	if (dev_state->domain == NULL)
 		goto out_free_states;
 
+	/* See iommu_is_default_domain() */
+	dev_state->domain->type = IOMMU_DOMAIN_IDENTITY;
 	amd_iommu_domain_direct_map(dev_state->domain);
 
 	ret = amd_iommu_domain_enable_v2(dev_state->domain, pasids);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 780fb70715770d..fe8bd17f52314b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3076,6 +3076,24 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	return ret;
 }
 
+static bool iommu_is_default_domain(struct iommu_group *group)
+{
+	if (group->domain == group->default_domain)
+		return true;
+
+	/*
+	 * If the default domain was set to identity and it is still an identity
+	 * domain then we consider this a pass. This happens because of
+	 * amd_iommu_init_device() replacing the default idenity domain with an
+	 * identity domain that has a different configuration for AMDGPU.
+	 */
+	if (group->default_domain &&
+	    group->default_domain->type == IOMMU_DOMAIN_IDENTITY &&
+	    group->domain && group->domain->type == IOMMU_DOMAIN_IDENTITY)
+		return true;
+	return false;
+}
+
 /**
  * iommu_device_use_default_domain() - Device driver wants to handle device
  *                                     DMA through the kernel DMA API.
@@ -3094,8 +3112,7 @@ int iommu_device_use_default_domain(struct device *dev)
 
 	mutex_lock(&group->mutex);
 	if (group->owner_cnt) {
-		if (group->domain != group->default_domain ||
-		    group->owner) {
+		if (group->owner || iommu_is_default_domain(group)) {
 			ret = -EBUSY;
 			goto unlock_out;
 		}
