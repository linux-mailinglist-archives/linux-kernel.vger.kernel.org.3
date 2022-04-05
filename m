Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC194F516B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1846213AbiDFCDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445869AbiDEPno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:43:44 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DC01605C4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:10:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJrfD4JK0PeuU9ur1yTS4inhdPsDfDfF3ucg5FXyzUiSBPlXrjfvkvldq1ZsEkIAbOoHRdHZPgsWoOguYrM+WeTsxFc3Mc2WTLH9IUDMybGFAZ+kMBIUfdZ5yxReR6xW+TDlU0BM100+OWS5RK1Mh3l483bQjrNdXtRY+P3T701o+32gjCNeo4P8OXQ+Hv6+BTkjD6KcD0V6mZ8tCPhqALRVmUioHWbtKqA37YRMzr8BmqVYGb7VqP8Kr9abGU+ylvtn5Oh9W+yH0DXuReqPCeIVxETCFa+TzD3pFf9FpSote2N2HCvdRP6yVrEWHbkwwTC/ZTf2dreCfjNXhyCthA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMWhlF/7mXCqTPn/lkqFRJFttYuFEEFJjeNMrxCsqzM=;
 b=nrxpiREVgPULYXzlLP0Of0X/APvyvxnUFhP6KYehVH5iDbLagz1uxkURSNZ0AjL4E69N49Iba7mFbqOhhMfuKcQ0i3Wt1eujxO+lEGdk1YjNRIoe9v8GIgBdewDT1Lr6HjMp01+Zrk9Sc++Fo3bWS/dDTKg4FHnVs5Ic+sepnIx0QyHWEIJNFD9SelTvMtVKHWRnt7UsfE4aiqefY++M0EwoXQHL/5nIbOotXuf75v8ciJbRZg8iecwUsMAOkwXY13xD9NS0FjLaw0ZafSkJtYcUNJHVUDEkD4M9F/FCAHcFEoyJV5sYL++uImwsZFHVvmZiQTz09n1TrFKzCL8HFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMWhlF/7mXCqTPn/lkqFRJFttYuFEEFJjeNMrxCsqzM=;
 b=amjpA6eUNd3FAKJQKi85hPQeTfkAj+tbFAVaRxQvRCj112xic8pnvKAaUVC3nTY+8XS+9aZQjHrLAaUlka4uaFoggJSDy5hwWqtocIslLkZLguLSf3scTgu0VHyV4Tqfg0xF2/FCtjOpejBxxaiVjoqkEiySawMpcP/lKykUl3PCNcF41zWp8Lfvgfsy0hOPXCcqNm44c7ojhWHRQROEAsZtZM11tFFcEhnhFtXHbv+QJZ4lvLzEiUQQIezZYSjQFqwZ0pHuxymRlcuGpwXtl2W3L8JeqOQVOPHbh5PfOiwHqd2lLjh0jdarS7q3o8MVyb/a5xYpb+0kAxgSHx93jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN0PR12MB5739.namprd12.prod.outlook.com (2603:10b6:208:372::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 14:10:09 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%5]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 14:10:09 +0000
Date:   Tue, 5 Apr 2022 11:10:08 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Message-ID: <20220405141008.GS2120790@nvidia.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52760F455B3319789BAB1E0E8C1E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220329114259.GB1716663@nvidia.com>
 <BN9PR11MB5276239993592FF808726EF68C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220330115820.GE1716663@nvidia.com>
 <6ebd4f9b-5824-9489-43c3-7810963ec918@linux.intel.com>
 <20220404172403.GO2120790@nvidia.com>
 <5ca5d34a-2394-b8bd-837b-cd6bf3301989@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ca5d34a-2394-b8bd-837b-cd6bf3301989@linux.intel.com>
X-ClientProxiedBy: MN2PR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:208:23d::13) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fff4a7f-f670-4734-6b4c-08da170dfe31
X-MS-TrafficTypeDiagnostic: MN0PR12MB5739:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB5739F9F687219EEC38978C22C2E49@MN0PR12MB5739.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jqMnz6lLmanwhvZ6smkR7zovZSzUPRrDiph+5rSEeu2da9Dfq7TnQn+JwbAQBbH6Vo02oBoPitg5OXJiWcW59J6FAG7bLwQn0L4jkYsGR74p0EbsOK4G6MQc1ziTQ5Y1e/w0Tt+gsgLHheP/0r2nNP0y2loBky20vth9UR+wr8uljjycAn/wRzCKz3ThQhHbP4HDYPUPmkdZQczmuCT4NQ5jRx7KU+RG5tZXAfjOcDOIqgA/aPgDUTmRnBj0MV/1PfmZ2bgoRvB4NVerBy9I8X6Nf3anGX+j5XeAPba7XwwGmHyTVT5lOkBJIyebKMek8HYa1aCFHEojH0ss8BDBr+BXhYT5TgAupxGPxg9Xs2FwmlWsN4NSZxBXwK1xzbsmTtPkW9gwNZgwuDhDs6h90WnOv8PtkQrx9ZakoqcOcbCl7ZxPluhLKngxgIvT7UM2rRVnWtQ+fL8ZhlUpLawsRBbOVQgtydVJ9eE3146jFhuBBBT8669NsdPoav3241ys1xoq0NMR2LILNCYgCV9NiNPw48GmMOEDsdxRSsSgGztjJYPSTApxTxA0D8wN2wS2kbD5fkbWV8ObaT87NkZUzOyJIHXJCP9gsCcYXeL+Cil3VHXYBirbjFUuYO1dTx7g2FXeFQpl2OwwQpVugvuLcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(53546011)(6506007)(508600001)(36756003)(8936002)(6486002)(86362001)(5660300002)(6512007)(38100700002)(66556008)(26005)(54906003)(6916009)(33656002)(316002)(186003)(2616005)(1076003)(66946007)(2906002)(66476007)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k0Y+SYDulErrcKJ6XD/wZN+Ex7rtAsk4XAd/XVxrbOu9WmN9rJ0WXqp0OBBT?=
 =?us-ascii?Q?jqRY1eI9poipzFXGxC4m/UYeHCHiWKkJR2ABepan8ertYgKWU8ITWtwQKBHh?=
 =?us-ascii?Q?QFfPyRigcH2DRogQG3bDML3fUHuGl0T16mUiV54/XbRyMP4J4l+XZAMzKy2I?=
 =?us-ascii?Q?zW8NI+sOOTems5EFOtaFh0QOPL8P7N7xh76MCN/XJ4rGZsB4XuQX8ccINaK1?=
 =?us-ascii?Q?J1yrFokTqDP+OZQV+isy3PxpQaKfgiIhckfwsxip+TjVY2Z3on2o5VJUbfWt?=
 =?us-ascii?Q?xmGe33GhAaTkZMMrnaxp0dX7kQ+fJhmSnq1BW4/AOFmiQJeB4LaL5J/wFYFu?=
 =?us-ascii?Q?AdgGisYJmpI90me9ed8wJxYe09y/v29hrdfAyr/rbskdey9CHls4MKSzRXhv?=
 =?us-ascii?Q?3Wmk2FTCUjJG3lxTBY+9rWUZliO1Vqc2AOL1YEKtesfd/pSnl+nYp77/As/Y?=
 =?us-ascii?Q?dsNd1y2cjXDUyM4pcGDnKq65yS6+GAbpdYShaqQiHLia0s9jgD7kWda5QBE6?=
 =?us-ascii?Q?cwf3oo2ix404u0tC9KWQShKMoObrvwR/B4ftSFQa9yuZWNtiby6lVxCuBz04?=
 =?us-ascii?Q?mW0JoaBndZ3wc4/vfbcH+kNE9mxlpn10qJuDplAZt89NwFIMJSxQAQ0S4bu3?=
 =?us-ascii?Q?U3uH9XKz3jGixG97g+e4yCtk6Qxur6AXZaXevLLZTCQJmiv/eH952gHcc012?=
 =?us-ascii?Q?55L67XECQP4J7HrOgYgIo/zFunkesk8tH5FHML6s2pF0v3XOt414VVxW+Aj1?=
 =?us-ascii?Q?ZukIFEMPGiKBqJbKNpkzEeGOJ3/7iUk169l0OiANRoi6JO93eWCJ6DDoh90r?=
 =?us-ascii?Q?/fV8M3Z67jQhYLwuyV2fUV7lwDka8BWtmOZN4A1fYgekCzHh6rO0jZrt2iVS?=
 =?us-ascii?Q?ZKDBTEyp7XXiqOMnTXEP/CI2QwOpvcAitP0TO0K6TlnIftxp+RatjyY7KvO8?=
 =?us-ascii?Q?BXhh1kQ/rkXxHXSxNlLYo1w/Im5eiZpl6vrg5jdSFHo5BTEOp6D15uo4E+Si?=
 =?us-ascii?Q?uRSRQWs1w42UJU8qMm9n5xzAbVYjyx41IVYXWpmMK0az1tKIMKILQ5B4D4D8?=
 =?us-ascii?Q?r1VyqG/e+DuUmu5LW1NISuhTmsIFOnHRNxG6iJ+t5l1yLFJXuIvIny+L9O7W?=
 =?us-ascii?Q?34UkQtydkPZXMdfFuF3gQ7DnFJxdSvZjsLLRvUUk41Tik1aeaeYszDL/cQhw?=
 =?us-ascii?Q?jeQLArqq57WYsf9TRNzxrs/2AxZcwh1jJrx8oD7u/1IszBIhmFt7S3wawd1w?=
 =?us-ascii?Q?GTM9MnPW9qQCoJbBsSdv4086PZh8YHCJnPFR7IFPVTrm+a7QG846rLLHKYV0?=
 =?us-ascii?Q?bQ32XsNI4wUQHTuep0xcXy6VkpN2uZ7Lb0xToVR5FEeN6A8rkdsVef5wa/lC?=
 =?us-ascii?Q?WWyJPYeq4MldCEo20M5XJxzxkEMk/I+JGiKrK56uC/TWIBuRJh3udap5kKmC?=
 =?us-ascii?Q?eIqJC/Cf3D02H1Thsdch8FH3xQD3gpNQFMJ6yqj/nQQM8Fo9vulbkYrjUAnQ?=
 =?us-ascii?Q?RrtD4n7jNBY4/4uB7Cy6lZR4kuJtn01oUDAy9eYen2MbcZjKQ8dkPVQgjRRG?=
 =?us-ascii?Q?bl1V9lq8TthZaXnKN6N7gpA4eXxoUcboK29oZSy7URp8hBMGHDR1dJNA9tUl?=
 =?us-ascii?Q?XGvYiJPV1KH2vt+TQZK+1eCPrTySMmTMvklGb/MPG346roITGO/0RC8+bTde?=
 =?us-ascii?Q?c8nG+wq9JQpPIHsIUQFV7+GiYhGZhU6Z+8VtZTpgFdNS6jGv6Yc/qF8q6zyd?=
 =?us-ascii?Q?U8AgCI+qNA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fff4a7f-f670-4734-6b4c-08da170dfe31
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 14:10:09.4886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWbDVNe+HPiYjgXjUMGB/k7OZ81DEYQifv3D6dvrVvUfrEMewj0mS+gYRNjv4Fpw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5739
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 02:12:42PM +0800, Lu Baolu wrote:
> On 2022/4/5 1:24, Jason Gunthorpe wrote:
> > On Mon, Apr 04, 2022 at 01:43:49PM +0800, Lu Baolu wrote:
> > > On 2022/3/30 19:58, Jason Gunthorpe wrote:
> > > > > > Testing the group size is inherently the wrong test to make.
> > > > > What is your suggestion then?
> > > > Add a flag to the group that positively indicates the group can never
> > > > have more than one member, even after hot plug. eg because it is
> > > > impossible due to ACS, or lack of bridges, and so on.
> > > 
> > > The check method seems to be bus specific. For platform devices, perhaps
> > > this kind of information should be retrieved from firmware interfaces
> > > like APCI or DT.
> > > 
> > >  From this point of view, would it be simpler and more reasonable for the
> > > device driver to do such check? After all, it is the device driver that
> > > decides whether to provide SVA services to the application via uacce.
> > 
> > The check has to do with the interconnect, not the device - I don't
> > see how a device driver would know any better.
> 
> I'm worried about how to support this group flag for devices that are
> not connected to the system through PCI buses. If IOMMU can support
> sva_bind() only when this flag is set, the SVA on many devices cannot
> be supported. Or this flag is always set for non PCI devices by
> default?

IHMO it is not so different from how we determine if ACS like
functionality is supported on non-PCI. It is really just a more narrow
application of the existing ACS idea.

For instance it may be that if the iommu_group came from DT we can
assume it is static and then singleton can know ACS is reliable.

Jason
