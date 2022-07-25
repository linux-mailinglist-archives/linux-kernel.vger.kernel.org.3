Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFED5800F0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 16:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbiGYOsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 10:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiGYOsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 10:48:04 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DAA13EA3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 07:48:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+9KbHSYhX8T2W573AetTlbXSwPUPgZgFzIKPyRVexgdYWZ+92XW7TdV6yCvKb7g2mEz9OPRS4O1mGkSoMnYJJwBREFOReSnLg4SsHLpRlsZ5ACVeePPbDQv1mCYlsjKdMx04DjYg47m0s1DMBrUI4qte6tDQEUDDzeEC+OcJKtD9z29sDafBDtfozHSmbjC1pW80e0kw4b4JstcyEQhrJnJl2xzEgKBgd/wLZ67XDYDTQmvkgGt3Dk9o9ScCwY7E9WnwK5EPG82h6e4NVfNtVk5IGwzcBfYh3Ve2WcuLLEYUoZAGdjUZJSOoVmwTZaiCd9WfiKwiEA1wxNMjpeftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvcwXjKfTnvwlyY6OnOArGo+/kc4ZRYtSmYHhHnGWt8=;
 b=AbOhkA9mpw8aqfu9FsYF19+7RV3DsroQQS5pC1njCTBYeBvWiBaH6F0EiefYWz1hpu1WXwGOeW1VOZ7dUFRwRCdwAsKeZN7ff9s3xvDDkeUTq+FYK2TYGjWp+9fCtv5778yF13tBcoa6qQ8qA9/IriUDcohA+PC1zCIvonqx2ko5C7odeyk66z+bnfDzcdJ9o8I93c0gy+G+LkvNN1sI976XBl+h6F4rZ2idKvAUNIAWofXTWo3df6kwvXmmnjQgADkeVA7EfvCdZE7cROgtb8+ALYcwFMa6Fn/xBp2xGxxnjC5lm8saLq/AqeKveHYx43KUEPik1dTVdTh4iZ+oOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvcwXjKfTnvwlyY6OnOArGo+/kc4ZRYtSmYHhHnGWt8=;
 b=CVjXTStPlHtlOG1X0F0YW0UgaaijHyARpdmTm77gtCwhCHNy5eTNX0rnybGS6F4vTr3ErKXR6Uwe8i5mkNrTrHEY2mpm28THEuS7YGCsk0mJEamUgMA4OWB2YrMoD2ukB9kl3VvaOzy+b8zO6zkGhUeYuXFiPvENtPQNwr5Ng5voxmU1r6P1oDpabttiyyFmQZaaa34vp4Dk0QVHZQc4NEs4MO1BU+0cJ6HK81L+QPar1c7Mx4DJ6Wn9fc/DIxqFhNc5Xeme0Y1VqiZ4tl8hx9JfikFfM/Pb23TqAd+5p+s22WLNpNJtDmXrhNqF+di0moH9Aunu2KCYMPMz+srl1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Mon, 25 Jul
 2022 14:48:01 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 14:48:01 +0000
Date:   Mon, 25 Jul 2022 11:47:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 08/12] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Message-ID: <20220725144758.GG3747@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-9-baolu.lu@linux.intel.com>
 <20220723142650.GH79279@nvidia.com>
 <bffb6e2d-d310-49b9-0725-37ab4263c22d@linux.intel.com>
 <BN9PR11MB52764D3E07E6755EF52DDC138C959@BN9PR11MB5276.namprd11.prod.outlook.com>
 <b868cd13-4902-7d60-048a-31bb92b94cda@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b868cd13-4902-7d60-048a-31bb92b94cda@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0351.namprd04.prod.outlook.com
 (2603:10b6:303:8a::26) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fb377fb-6af6-4160-4d66-08da6e4cac36
X-MS-TrafficTypeDiagnostic: DM4PR12MB6134:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2uoDGR9ZErYgPThXFUDCSOysbp/2/5vRS5HqH/YdYqYasCSOUMcdoTG9KtROa+5bfWBJVjKaN9Hi6FzwSQ3StmHcXS5pgf6HeDtySh9F8rKASs/OVTdXwrYvxZQchdILPh0GwZlkhMV+lKVU6jWvKt7rLuOMUINLkGE0gTJhvEPuC0qrShnFtp42j4a1KCX8cxNGi5YTFJ3AXL81aMSYKIBBTpUma1pmnhz0Bm1GLOWrLkatu2angvt9VvV+gv06LhQrr3pQbWzjPOR+IRZahb8hN6+fmE8uzDXtIHdXz5toNv0KTVQwkDQFrwkPQ3rlrIusTelfyduSfDmYiJcIpfshqURp/zevvH5qrnE2mfqcX71pFO3UqUV55te3tvQKiGf3R3MTZ31nPliNPjLMRtQrbq5+oGCwgceKCRGpt+hFDkSbDa4uFFtCohWeO0D5Bvh5whyg7NYtwFq1DrFlWT3517uq6YhwOaS15ABtI9I7C7uBwzj01DXJKBfYmB4CCwi6iw0EHT2iKFnTdGCdyxkXXr39cGA1LT0n9v4w33+xd/+7RMNiA7xpbj8r2uli8/dozGUnA/NSTvoyIcE7P2tajPCGd40ck1Xjhtf2nYSlT0nqhAAQ9+DoGm3IG/09tfg4FGcNRF02IZk+2BbfK6UODWkiR+EXlDMMS3t0ZzJ6s4WFEYBrmrkbahhQtTsVSpnSDykseAsSKEJMU4btxrW1dDOSzTcYhXABFtiC4azJv6epPY2LxL023pli6WnU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(54906003)(41300700001)(316002)(6512007)(6916009)(6506007)(6666004)(53546011)(26005)(478600001)(6486002)(66556008)(66946007)(5660300002)(4326008)(8676002)(66476007)(7416002)(8936002)(33656002)(36756003)(38100700002)(2906002)(2616005)(186003)(86362001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1UP71y9HpS6DyBUu7vpAKEgU6JWwdnlLM77bqB9jbQ03gSeChnHfdZ33wUg1?=
 =?us-ascii?Q?SXhvkYLXcQxm8QxYTS9OXHeH6jq8b3PXsDKWk2wQla+WtMQov3bEgw2n1V9Y?=
 =?us-ascii?Q?vnEOplq/7fDl6nYrKiyHWaskIilH8GO8gyGJwaSnbvZ57oARDdJu2js8imTZ?=
 =?us-ascii?Q?lzQgiKR+WIyGXu+aWbHWI1eO/a3ozYFNZCIVKTNxhQteaesoT+Z4lOUI3dVY?=
 =?us-ascii?Q?aCl5cmHqJvOzFaaBWRJu85Em7IARQUyPayq2vZ4WvjBiYqbY1JAWgCuEAq1I?=
 =?us-ascii?Q?8cHzdnS1uCFitYHdRrf1Oz9N3jDnD/Oy9js+Ui5TWW+PEEWeHAEua/hm/Axm?=
 =?us-ascii?Q?Wu0ta/XNo4mVA8TaUkjjk5kHrZ/UjnxUP5EbZi29wmnZWhteS/Dy59NObazw?=
 =?us-ascii?Q?Vr5bgoIORqe5gjdHb816yK18KflBuLcYE6sJcZxlFo1ZkJH/rUsuJil6AXul?=
 =?us-ascii?Q?zuYexoi8CBAUvWTa3eYYAAVg/NjyslraYXnGCu9Rbdkm1CTB5yZsT7DxcUKA?=
 =?us-ascii?Q?Hyys+Y5/2FTf+UgXU9xQPoftNRaKTmlIQ+6hDhp7f8oqcOgYf7oJFI1yWwse?=
 =?us-ascii?Q?mFR509qETWW9MJZiYaqwSr0KxDic2zCdG9RLTYhcAqGrykVQcn80fXPske7M?=
 =?us-ascii?Q?far4WCv5b2KeCCsLvBAyA5SQba1/h8CuBmg+3rWuRwWAL1G2LAntlzxus3Ij?=
 =?us-ascii?Q?BKh5kUvrB8YQCneHddjqBP7S19AVKfiQOZJjIxt8Eag447c+TfkwJPTTmwAG?=
 =?us-ascii?Q?uLhTsq4SxgE5YRKKOqseV4Ad31ZKiGG64hP6J/iT5Fdt5EYgz40Md8XxWqre?=
 =?us-ascii?Q?Jd7tNW80BRgi5lHHlXVr3ElyZ660GmcaR13xwxI6rKwxS5m1SV8AsH02ZX3R?=
 =?us-ascii?Q?s+U6XJKc/ByTCb4GLJ9rthymDdIcpvkGZ+YNOrM6PqngRRnX/Cwh3qXBLUnq?=
 =?us-ascii?Q?6I3nOg/nX+zB2nF6uNzNf23LvL1jvy2NMDDPeEySFu/NN7uEJwun0yfunI48?=
 =?us-ascii?Q?aYJV0MQ9DVnLmO8Dolo4P6Opel1zh2GVKSNehdjTl9RksOd5uIz7/X7lum8K?=
 =?us-ascii?Q?v1b62jmZoccnDGsUtanvW2RwKD/j8StHSSvl6Y2SndHQSx02sp7VhdqJ9aNT?=
 =?us-ascii?Q?THd8jQd2nW8nH5Mr7hA9dy2yXfAqGaWRhuicRAfLz4kNe2CG9fqL9XdA3X+v?=
 =?us-ascii?Q?DUFLlNDpEzOyJXH1zohIfzTe3BIj3yNw4Dl1Eu6axLnwoFg/HrdA6L0hSNMJ?=
 =?us-ascii?Q?6bTgSZlmsrAIJY/fm8o2PIEITKXp4x2iZvcLee2CoBJ/Su4JO/mgGPbbqdU5?=
 =?us-ascii?Q?H73O8RO7q9/GK1uhhsV9P6/B6fn3ugwyqq0u9xsP7VYtfW62rsojBjrF6Nbi?=
 =?us-ascii?Q?AAK4jBmlokEtq5KNbCCNwJJwT9eLJ3L7sn2BmyQ8pVL8sYIKKLr2BESSnzR5?=
 =?us-ascii?Q?IU1QOqtXj9MUIyhGfNrz7uZN1QOvjDfJ32h1oFneUZ+t4qkGe1W3/cIxqvnY?=
 =?us-ascii?Q?SMIa5cN+NPP2t3WufKbKC9O826mqEkaLvzrsa7PX/pgeolgdymsSpemPQ/2C?=
 =?us-ascii?Q?RGi9yrZHnChAT++kU00=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb377fb-6af6-4160-4d66-08da6e4cac36
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 14:48:01.4526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7q/hagiVKcIQPxEBAp5hSBFhtwPyyNkv56C29EN22zknnl3KXRPSNPhvCaCJ4Une
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 06:22:06PM +0800, Baolu Lu wrote:
> On 2022/7/25 15:50, Tian, Kevin wrote:
> > > From: Baolu Lu <baolu.lu@linux.intel.com>
> > > Sent: Sunday, July 24, 2022 9:48 PM
> > > > 
> > > > The API is really refcounting the PASID:
> > > > 
> > > > > +struct iommu_sva *iommu_sva_bind_device(struct device *dev,
> > > > > +					struct mm_struct *mm);
> > > > > +void iommu_sva_unbind_device(struct iommu_sva *handle);
> > > > 
> > > > So what you need to do is store that 'iommu_sva' in the group's PASID
> > > > xarray.
> > > > 
> > > > The bind logic would be
> > > > 
> > > >     sva = xa_load(group->pasid, mm->pasid)
> > > >     if (sva)
> > > >        refcount_inc(sva->users)
> > > >        return sva
> > > >     sva = kalloc
> > > >     sva->domain = domain
> > > >     xa_store(group->pasid, sva);
> > > 
> > > Thanks for the suggestion. It makes a lot of sense to me.
> > > 
> > > Furthermore, I'd like to separate the generic data from the caller-
> > > specific things because the group->pasid_array should also be able to
> > > serve other usages. Hence, the attach/detach_device_pasid interfaces
> > > might be changed like below:
> > > 
> > > /* Collection of per-pasid IOMMU data */
> > > struct group_pasid {
> > > 	struct iommu_domain *domain;
> > > 	void *priv;
> > > };
> > > 
> > 
> > Is there any reason why pasid refcnt is sva specific and needs to be
> > in a priv field?
> 
> I am going to store the iommu_sva data which represents the bind
> relationship between device and domain.

Why do you need that?

If you are starting at the pasid xarray then you already know the
group/device, so we don't need to store it again.

The only thing needed is the refcount so just store a refcount in this
structure and be done with it. If someone needs to add something later
then we can use a union or something, but right now adding an untagged
void * is bad.

Jason
