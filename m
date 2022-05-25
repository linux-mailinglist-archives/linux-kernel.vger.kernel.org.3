Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF876534053
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiEYPZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbiEYPZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:25:42 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D582AFB12
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:25:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhWF0/YwUCArkxJ2Lz0PYzOsRBiSO3jlLKpqTgLZDI4WFIQYRArMoB/9zhIOCV9BsEwaiTuCnkQT0GKTPvSy6TmMN2ajhxqoNDSVJkTsIk7+1FDKgdDflgX5eJUPDGAwOXzNR1zk+To48+y76Gytpq9ITpM9UukhI2c/ueniRSaVuqr9553wYOigLma8Wv6W+ponKXseRPrkjsJPYSOITo/efb7ORgvFQpa9tewkQ2hA3IjSv1N8Gn3OeqG4tbHp5OtjjNlWHRMifggWpT9zm8KH7ihbssM16iyQcX/E4AaTOiTlvGWRSCQp8n5asWsSXEUJSExJuIoBuPKW8pbpxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=616aOlhAPVTQ6p6gLCMD/HwD/s9NVry1dtZcr4nmDrQ=;
 b=QQBIFYcugA7BJ5fnk0Y3F3MZVXizh2zBJ7ZP3Kk3nPF1CEqTOEQZOIkgnkzhHJ0arzKgryjJlfvzGwBlHlFY+NPrNTdwxQUg2pLJci8IZUCxwN0OXJNgPNd2FtJQQpP9aT8LFrkclpaYK5JgdMLKM2LwHm+IuwK8tQWgypyLuqzdvooaV4N8hFZ9iSG4w+edne8O5Ue2G0mThw1UuX4BZ8tS8kVKIqXGeeC4Aw9C54Elwo/9gtpLeXD3nVt7VfHzAHiVtZ531bi7ffgjDYR3pTjaEBWz7BbyBd7fkiiOlfZUJOn3Z8W0R8swtnVT+x23a+CYAfU2JnAH3XFq8H3/Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=616aOlhAPVTQ6p6gLCMD/HwD/s9NVry1dtZcr4nmDrQ=;
 b=N+vfD1NNZKskdERh3Z3v4BLi5tvgf5pBUQqW1XLRPYXonDvMBaB99d8B3TUi3xsb8JgZvAF7HUrgsmzZZlHbxRJMGXv+eMJE4utikuxqwfHmCKb7ddZCRb9/w1l1OTtOxikZO95RbbSzrhRB0G9tV1VEVkA3W9qMs6VzrWPuxi6T4w5h79zTSNxpp8oa95RXFuVP/8Avj7TWSlezNbZi4OQw5K2AhxfMB9YQs5JmWjfyzhUA1bF4PprcvZMhJnbdXL2aZkhRmuN5fZFJIA5EQZ9+pL1Rfl1WJwRaNY4m4wCYYu2uyEkC2dQdp6gtCcf8iBL/QTuJ8mB1a8bkByZzvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL3PR12MB6404.namprd12.prod.outlook.com (2603:10b6:208:3b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Wed, 25 May
 2022 15:25:39 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%7]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 15:25:39 +0000
Date:   Wed, 25 May 2022 12:25:38 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
Message-ID: <20220525152538.GD1343366@nvidia.com>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-4-baolu.lu@linux.intel.com>
 <20220524134440.GT1343366@nvidia.com>
 <3ce2f162-7b0c-391d-7978-d1703fbe9b79@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ce2f162-7b0c-391d-7978-d1703fbe9b79@linux.intel.com>
X-ClientProxiedBy: BLAPR03CA0134.namprd03.prod.outlook.com
 (2603:10b6:208:32e::19) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e43052e6-0aa9-4657-318a-08da3e62d2ff
X-MS-TrafficTypeDiagnostic: BL3PR12MB6404:EE_
X-Microsoft-Antispam-PRVS: <BL3PR12MB6404243DECFDC27090C01429C2D69@BL3PR12MB6404.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ibr6/Yd+fao7lnBYpdP/6Id420MkA8IyVMtqd+hJttulwBn7CW8hpYIKzG/M7K1+L1YKokTedXqkWQD1ghQ3slvJcT2bEoibRtQV7qNjvMbJW+4AFyBHXvQ3miVUu3cqhL5rxPdZwQgFkNnsidBK6VDSpQc5gItxfYL76a8sMG+z2CbpmziWJ8u4TsohQwPVnp5QuUMvxEIP1bwDE+AvpbaIU02NJBy2tXD5gZMbR73+mnaZv44txDFhxoTLe0Oem+AR2/Ung9ypTleQHmPVPp2gL7wKZxTSeRG+pGGCaa+kXuINgbB6uDjbf7hu7SLWe9RWGVCgwYpq10OueeBv3EjWG2QqlYE9bjZiQvECIjSqdXhrwA96Cmvor0LPXc76wfIUvJyqDzHINm2EMRGUQ20zfqVJxQ7DngAUzo8KsrItqcoGA3Uyt+2KBcfbxEaZn71XrCjL9RMfC9WS/jegk5t5+2QAqqezuL217gfGObHPvvDKM4qRiUojUkrft/unA5nDT7GSn4/8g2hrNxQoWV/VUx6lsvlxrPLkE7QYHrgXE/iptL9PnvDg83lu7x7H3BUa8esW9VF3LIWFWPOawj44l6bYhtCtL39d5kSEFkTf2G/RAWUkxT4QqXuEYrs2RU75F5rc+q7O+/CPKdL2dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(2616005)(1076003)(66556008)(66946007)(6916009)(54906003)(6512007)(5660300002)(26005)(508600001)(7416002)(316002)(38100700002)(36756003)(186003)(4326008)(86362001)(2906002)(53546011)(6486002)(8676002)(33656002)(8936002)(4744005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OE/O2tU95RCxCJV9MOpGuwgcNlXUAOF1BgszyRYaaFGqVVrf/O6rUA7yBPYd?=
 =?us-ascii?Q?BgA3cuily7R5QCh+AKfCxMlAN4KuKbeN078rq2I/Y5u9MUeRODwcrkQ5w2E7?=
 =?us-ascii?Q?v4XLNQ46kLsB2t6is8ooiza5AjADkmI0dmzax5Zw0TQoSOi8X0fWd2XUDY/D?=
 =?us-ascii?Q?h5EHyJ5QB0cITSVfASfq37qXrWBD98cbbYx7V7UIRwadWWBGF+BPBQSABhc4?=
 =?us-ascii?Q?7eszYNkCt5z21PIIn+3cmNQuQqxEWKpkbwC7BSgpiUPsB3T6mhSq3Z2eHniU?=
 =?us-ascii?Q?OFv3V4iO7OH5PCHyDJEpZ65kIu6kv3FaicbDw11NcdepaJD7vzuIqgBRG5qV?=
 =?us-ascii?Q?MZSs5I5KSt4ZyDFT4+ato7/asaGYH+Y9tRn7OsIA5YN09VHYkZSzgm6cuUJv?=
 =?us-ascii?Q?9yj5QhIqU0lsxFw7C8ha0fl6Mp2ySf+O83+s4qcSH+uf1KPePNO98k3ZHzyO?=
 =?us-ascii?Q?sMZNSRuQbw492D88tzmRmBVJr86wIKibGwI5140KgYbSSs3nkYKnuF+IEP4R?=
 =?us-ascii?Q?Z5BC06jWMP90v6/SqNImmG6DFfZshbAMg4e9Gtjz+wkl4XLgtEli/odhwGuB?=
 =?us-ascii?Q?AhHR/1IVtyTFv3RmWu90Mmjt1rdd0CVCXbAw4VP5QNVmJV3P1Ctlwj241Kd8?=
 =?us-ascii?Q?6mGagg16WWYSwKaTJ5133y3AxNo3M0yObgnke5yiPXGUW4mH0AAo9eAbs0mJ?=
 =?us-ascii?Q?viLhDyjw2qNYdvRUwKcGdCR9X2LvCOqOiXYz0/UjQJCm0qXGPP6Uws3nMNoF?=
 =?us-ascii?Q?sizSwQi6oqb6vdDtn7GyBHCohJftfvtkOG6Wu+RunZvB9kbTg4BvfQHVTmwR?=
 =?us-ascii?Q?1NkD7Dueb7KNv5rfIQMPRimEQ4eU7qEUQhwmfgqjsE8iTw0pRi4nt2M32lTn?=
 =?us-ascii?Q?YglFgeVxx3tYI2lLuzKIfSNLOKrLPjYrmdeMYSoYJHvws5WknxXGHj4YO/H1?=
 =?us-ascii?Q?y/48CYDyYjdOTJq3XSNZrlN/0W78yMjlR1s9FoMWXxHKhaolHf/YOPU/Se2s?=
 =?us-ascii?Q?6xhGZH64ttkAeFP/S2EYsIWTX8W7IVgrnFs+t3g/eGEoI338aq78d8j7YSZ8?=
 =?us-ascii?Q?B/w7cl7SzDHRIWiW2UX0aLcGmvW2ytrf6yMQW9JEKhhq8f7vtxRGxH0Mo7hs?=
 =?us-ascii?Q?Z4Uv7jOOZop4WMVDcaPQ9PFfzpR8M5En6Z6mcwrnuKOJhci9hONZ9mOaAowu?=
 =?us-ascii?Q?D7i8FCkAHyNijBAgV6gFzLY9WVqjinr9rMjveg+mHNaox24IQUxnoJ+7NMFH?=
 =?us-ascii?Q?i3Jfqtt6FsDaULe9DC4rowjtRCjYOmZXrYQgFy6taJQqvDuwWvIfWw2YqBte?=
 =?us-ascii?Q?NThVRlr6bl8iphtmYxxbrRIgb21ttNpNCcaSoe/0F5K9ZX/KUaeL5yPA9H0W?=
 =?us-ascii?Q?mUQAkvHBEIFgSHqCNFAOOEzQbJmp+DpI3l3F4RPnTHmJNSw9PXLPvKfO9kzR?=
 =?us-ascii?Q?ptODRmI+zUby+oSbH1xlI/mPLexMKl9/Mfs4yud0txnfExDjz7vKhFhiNwpd?=
 =?us-ascii?Q?lTLWmeBDLK+3Y44bCkrScbPWFtkqKvpRk3tG4VCbu7Q+0FDtzcMc0rhj6czK?=
 =?us-ascii?Q?cAsp2ba5LBhIE2x5i92JGgx11VHUMDgGwelX/6JKUaebmDXFlzLraDoSPHOJ?=
 =?us-ascii?Q?zg5DCgklYXInOJYh1g6zbx4WDMgQOpltRNStTVotJepECb/+QVOiCzPC07pA?=
 =?us-ascii?Q?dJIv0k8ea1+nwl11YSxbNb++SWXSgDfAzPH8mvZis/WRQGayZsbZWMo+LS+M?=
 =?us-ascii?Q?JSK4Pq3vLQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e43052e6-0aa9-4657-318a-08da3e62d2ff
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 15:25:39.5721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 93Fmh3lXSgG29j3vcxw2t+HPrnNzCdkCtKI6IXFfISOGAMFYccrCdbFSShiJdJ8V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6404
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 01:19:08PM +0800, Baolu Lu wrote:
> Hi Jason,
> 
> On 2022/5/24 21:44, Jason Gunthorpe wrote:
> > > diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
> > > index 106506143896..210c376f6043 100644
> > > +++ b/drivers/iommu/iommu-sva-lib.c
> > > @@ -69,3 +69,51 @@ struct mm_struct *iommu_sva_find(ioasid_t pasid)
> > >   	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
> > >   }
> > >   EXPORT_SYMBOL_GPL(iommu_sva_find);
> > > +
> > > +/*
> > > + * IOMMU SVA driver-oriented interfaces
> > > + */
> > > +struct iommu_domain *
> > > +iommu_sva_alloc_domain(struct bus_type *bus, struct mm_struct *mm)
> > This should return the proper type
> > 
> 
> Can you please elaborate a bit on "return the proper type"? Did you mean
> return iommu_sva_domain instead? That's a wrapper of iommu_domain and
> only for iommu internal usage.

If you are exposing special SVA APIs then it is not internal usage
only anymore, so expose the type.

Jason
