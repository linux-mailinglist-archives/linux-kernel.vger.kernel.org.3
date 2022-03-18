Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02734DDADC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 14:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbiCRNt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 09:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236831AbiCRNtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 09:49:51 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2086.outbound.protection.outlook.com [40.107.100.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF4CBC1F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 06:48:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ivt9HxYhDj6SjBGbrgWUuu5HMqME7Jt2rf079WVqGC040YxUd3Ktpmkq2QvDJcYdaoph5dZVD499hXqTt7nvu1/iQ1TEfviLZMylg8IjPM9XGecE5HAF1Z0oDFfuqre8ACUto+m+MdQsyE5koXpRXQFPIPolqscE7qcagtjuIbu0JDYwJMQB3fPZgdtIUAc7/TfsM/Mjrqpb68qzPnHzQ/qSvqK+zb4g3C3XaTQuSpdi4nR+ocbyfYhrJfshujzDRCh8LbV6ROkp/LYeMCHx+jUpIIgVqvB5oukM+XV278oCsWBQTlgMBHN5fQTgLQu0jb/LLWt+B3rxRBAAgWsz0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTD7bbgHy6yug/JW7rJs5GcfDTGb3eof6YuKLCSiIT0=;
 b=U7wkn1/hNhi8cOk82suLjt46yrTjKy/lWw7Xkc62dcxwlMmegqaK+kPlysGADlg6F4Gcl7Jkol6TwGO1DQQOIa8iKZGgoDAUoiXw6JoTdHiW1Rnee3+LQLxiq3n4pSJtlWxWnRJVOlmE/mPhMfrQc27GRbfOUn1+4GxAoQet1RCL48R7IIlC/+TQiq1JSfhxNm7JVJYrMXmBgg91Me6BE/JZ99E0LJ6HA4Ya4oHTDOscDO26sK8hzt/GRGCdMEB1RTipQuew7loMIs9HoSHizvOCokJzaDUl/nh8doFmaGOsgNohFKcVNYJ4NQWTABnEkKyQ9a7D0k0ynyp6zIcXYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTD7bbgHy6yug/JW7rJs5GcfDTGb3eof6YuKLCSiIT0=;
 b=nVA/qM2AomKs0bERh7j+kLtR1UKGn27pYwx0IgK4/hO6nkimtgU4F9HPeEKH6nzaP4gOOMDKlx8+9U0km4DFkc8ulF96Urb0AIDGlmaWsHwZUpCDAqXuKAXNCbp2Hod4uOMS9CJoSUpzuFcTcV8r7XAUbiRc2UfOaJ5da6OHm+F681vCpy6UNPSe65dLHPV17ygGZIGi7dRlztPZctCS5UGS/jZmxdkcFUYQ2wEuiHxb/xmGNGLQ0aZRqCtoxA8l73MLUYae4ATPaOGIaypKkjB3I3HA6nx4sJlrEvhchBlEEQcQNcBTK17LJzLfAnLlOL/A/CHb5AkaFZ0NckX3Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY4PR12MB1783.namprd12.prod.outlook.com (2603:10b6:903:121::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Fri, 18 Mar
 2022 13:48:30 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 13:48:30 +0000
Date:   Fri, 18 Mar 2022 10:48:28 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 2/8] iommu: Add attach/detach_dev_pasid domain ops
Message-ID: <20220318134828.GL11336@nvidia.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-3-jacob.jun.pan@linux.intel.com>
 <51f6a64a-194b-0aca-bd2b-64737bd2140e@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51f6a64a-194b-0aca-bd2b-64737bd2140e@linux.intel.com>
X-ClientProxiedBy: MN2PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:208:c0::43) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 310b9e9b-61b3-4fd6-0511-08da08e5fc69
X-MS-TrafficTypeDiagnostic: CY4PR12MB1783:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB17839957838DD5C9A4A0C7C8C2139@CY4PR12MB1783.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T/OumOgISYl4O0vIDZo3l3PoX4M3KQl3VS1RypPQdReuy5P6UgOFj2PYLnXoC4pcubgg/LqH6cMa0+4I7pk5iGxek3TzFXmi6v/zmbJom7YmPpyvV6QkLxzX9+BM+u3Z6ThtQVzpklox03THQAQXJuha1pNFul9P2YU0RXkvxLzsPCLePZVuIgxYUbwie+JXkbvVYRyVHA1Un3jqCxzeaSIbUXclmmN+IJi11SPWlg/Ku8ddIAkHZ18BwM97rzfJ5klJ5ayOvmgJyqTHteQxrBuMskR00wOb39jLHK4OyUw9M9mly/w3/WlIbiGXLxO33JhNwGYQ9Z2e9jUzqGFcDXaA1B37l8OO+GvQwkAFuFkl9r1y/dNwxNhfyfW7TkgBVNSW1Yjg4dUnv66Mi3WjoiIoFisgQRTQkxfIA3UEH3S2OtDrSUkUpIagHWbsHGoHKAp0WIxTv9ioiE9r23gk7J1rzY6DFlLbuUafRJob+zU9t2XbAqnoq18aOLOQr7S4kONLYp5vVyNN3FsceZGl4e6zq6bD7DQoHwOaKR3FH5YKEuevyMiFfkqrz7RlLKis3UnXPaRPXLDdpLYw2ML/qhGcqd80jliV1W6zF+i1tOpAl7wX8PfWxTGjEDb3IL6L7YhXg47TtCJBY8wIsM5E/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(316002)(54906003)(2616005)(1076003)(186003)(26005)(2906002)(38100700002)(4326008)(6506007)(66476007)(66556008)(53546011)(6916009)(66946007)(5660300002)(8676002)(7416002)(86362001)(83380400001)(508600001)(33656002)(8936002)(36756003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zigp0v9sEoX99MgWKdwOy58+bMaOrLKKubXpjJjL1/9J3tkTAhP6l4doBzQR?=
 =?us-ascii?Q?GXAzBwbLNRpZARd4P/dj1KOXUylnz6k+Y2ATKpzEcvd90K/evmRYYh7KV7XF?=
 =?us-ascii?Q?RkZIAdlU72Zb0KBdngZMeVqzcBSk/6KNADjxAtwm8fQtUwCZzqHuF7EJ9PxT?=
 =?us-ascii?Q?tGNgonM6eyiO9YF3boF3jcyUb1Irr1i0DT8NjaWlAF0EugKJfV2C6ogEPvDu?=
 =?us-ascii?Q?CElfZvxS0fv+/BrUs27jjIYdebFOK0DqYKSPSJO/te6bLKN5xe1jNb6wq9OC?=
 =?us-ascii?Q?4AR5o/VjM2tGv12Xsy5+4KQJRAq7vJh0Ty49FPxyGCRVZlQch1+bnfTPdEl/?=
 =?us-ascii?Q?67PbzFkB4K/YDJYAEjMUWwtUG/7q62nwTt50z5vFx94xinjo/hIJ2sTUdKIA?=
 =?us-ascii?Q?m+vvp4uR2cn7m9mryPuXGRgct6P4khSnc3ZQBfn9CHJmmN82NxYwL1KJP5AC?=
 =?us-ascii?Q?bekW3dH5gShX/p9KS4DOBa9g4QWTGbmsNmbk9TAtPatEScAXOMSrTQ6c5amb?=
 =?us-ascii?Q?9iKPK485QrRGuYRWMYtWXnM0zt3zW8umcTPSqswN+DbLcJ6ol47q0OQUkhZf?=
 =?us-ascii?Q?RV0MyYD2roRPC+JGTw8G5CvryswEo0oxfXK+Jg6T/j9gjomxNP3AVubnUEpw?=
 =?us-ascii?Q?UK0FKBkJ+60mZk6jpomEsSZ+OA/DouOpuM6m/rCs/fnMNfg1d5XRqI20kJCq?=
 =?us-ascii?Q?URhgNufGE0NdJEByWVWZE8hm9AFRo0vEXuIIHGuKE+Dt73DhVTgDRfQv/g/h?=
 =?us-ascii?Q?afbd9DH1Cpwh2/QbaJGFCSIs7ujYUWmSb8qRQQQFc31KR9RT4r5iRdz5fSQF?=
 =?us-ascii?Q?QRiGI/nya90RVKm0gRybYh1eVGd7ZVguiPvdGGIbGtujuxvdhqBi/tX6LEAt?=
 =?us-ascii?Q?vDL9vJB/PvqzK5uK+0ICXAHqdmZ3/eZ7TF4Ln2XiIaGSclI+zxGMzpCiJas7?=
 =?us-ascii?Q?BzvgIcn4Rn+SiXvv+w6UiJvDHyeIuTo0LkT+g5air87wglrUq/mbBme0lF1n?=
 =?us-ascii?Q?KQl2Q45kGpMKZ2pCr6uI5PTVQ5f0P4czXITvH+ZuOiHnCoHuXFb5UKhYnnJy?=
 =?us-ascii?Q?UDEdOKylJ5yy4iMM4/To1swMagDm02lh1Du0fVAxcZzOfoNKHb5guR7WcEv2?=
 =?us-ascii?Q?Kk2Th23XTsNQtevlbOo23lzvoF7WvgVQNvChUgj5HFvoqHpsYCo/Pufy73Ep?=
 =?us-ascii?Q?SF1Bv/1D7bNbwNCsKQ4yCB5bhEZ8tYoUV74nv31thOe12RU/z3HIXdhLzrfN?=
 =?us-ascii?Q?wi+6exLvGsEhWSH/ylMKzMT0qLrBDOmp13O9npu9qKeAYUdQQz+9p+wTAfXD?=
 =?us-ascii?Q?Ql2laBCJcUMYPqQ3i6ElAj8IiavzHs2oMFOEIoUNxm3E+J4dqHrsiIOxC8KP?=
 =?us-ascii?Q?D9JFLt4mgW4a8LtmX+WZtVrKVf7UfoUg6eu/rmlTIbJTMohIWfefUOn48Enp?=
 =?us-ascii?Q?Gi4Rp3/8Q62y5UA+huAD9/sSXufMJ3lg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 310b9e9b-61b3-4fd6-0511-08da08e5fc69
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 13:48:30.2401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPqZdBnplDFHjOw8mRRClAkoNwXVpO2k67vOSD1JsvQnwlvwPvhMg/mFfWclmeIY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1783
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 07:52:33PM +0800, Lu Baolu wrote:
> On 2022/3/15 13:07, Jacob Pan wrote:
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > 
> > An IOMMU domain represents an address space which can be attached by
> > devices that perform DMA within a domain. However, for platforms with
> > PASID capability the domain attachment needs be handled at device+PASID
> > level. There can be multiple PASIDs within a device and multiple devices
> > attached to a given domain.
> > This patch introduces a new IOMMU op which support device, PASID, and
> > IOMMU domain attachment. The immediate use case is for PASID capable
> > devices to perform DMA under DMA APIs.
> > 
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >   include/linux/iommu.h | 6 ++++++
> >   1 file changed, 6 insertions(+)
> > 
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 369f05c2a4e2..fde5b933dbe3 100644
> > +++ b/include/linux/iommu.h
> > @@ -227,6 +227,8 @@ struct iommu_iotlb_gather {
> >    * @aux_get_pasid: get the pasid given an aux-domain
> >    * @sva_bind: Bind process address space to device
> >    * @sva_unbind: Unbind process address space from device
> > + * @attach_dev_pasid: attach an iommu domain to a pasid of device
> > + * @detach_dev_pasid: detach an iommu domain from a pasid of device
> >    * @sva_get_pasid: Get PASID associated to a SVA handle
> >    * @page_response: handle page request response
> >    * @cache_invalidate: invalidate translation caches
> > @@ -296,6 +298,10 @@ struct iommu_ops {
> >   	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct *mm,
> >   				      void *drvdata);
> >   	void (*sva_unbind)(struct iommu_sva *handle);
> > +	int (*attach_dev_pasid)(struct iommu_domain *domain,
> > +				struct device *dev, ioasid_t id);
> > +	void (*detach_dev_pasid)(struct iommu_domain *domain,
> > +				 struct device *dev, ioasid_t id);
> 
> As we have introduced iommu_domain_ops, these callbacks should be part
> of the domain ops.

+1

Jason
