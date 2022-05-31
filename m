Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502F95393B3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 17:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345537AbiEaPNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 11:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344487AbiEaPNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 11:13:39 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CCB25F0
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:13:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBRuZZp8Qi4CzAvJO2J43pSIodZNYWH3RVEoE3gOf9beNQL17snHGXKgvWwI27tPRIu8Wzvh+VMvJMd5tu7/lHwd4eC4UlWLxelkp0iax+rIv2lNnGZQJXpzzdwalHgHGAUCzBAziydK85rLi7YO9oHUYhoTMPqH5SL4xEnTd86FDSkr3QMMWQ9y+IBSZERASu3+sApQXWku8gWGJHsC/c7yP/VN6de/3ipmYL2X7EPLVns28upqIiDb0RYWROAkDt99NlsVZZNURQGT/mJD+qly1Uzfyai0mqMoTSpLLknPGoGxutBDXYRPvIQ7qmVBzLKeDY+UJ5UJ5B46r0354g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANht1PovPxPmwOS3jhAN6mauRAaC9vpmSzuZCy6I0ps=;
 b=Wfp++l8clHpXv09toGY61zzr4eMkqD8+lW7Kn6RwwOpAeiWgp/ByahxDcYlBv3481n3Y+bJapaPAXmxzwJ6NPvlHnH7IfBknCeVZVA7Rt3U+qCz0UiBeWXK5u3A4XMcXiCP73U337w/HGPXxr8qoZ9eAqcEti51/NESFwI0XJi0WYLyhbLd5/qywFU+09d3DhsAPDqaC5ZbJEFi4NavLo2KJ0RQr5B6uIiohKJoCAAjyYmyBN7XoH67N6UBlt+7mx/0bvZWyqCS9Tb5foisXgVICvoO1oSZiaFKnSxdpgB7buW1b9bdNdL08IFNVxGZoftEcEeS2ZMrZnQPnpFD4qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANht1PovPxPmwOS3jhAN6mauRAaC9vpmSzuZCy6I0ps=;
 b=tgjSUa946Zk11Ab721doNfzENtr0mJ5Sq67ZVB1n5rnxfZAree7dN7xGvjVWYnNvknR8LbbDSO581bDoiKHZsj0XZGgUChjsp4VGF/dPdyOn4HKJGl+jOh9YhlD1QLi0f4mPx3d+zLc95q7ygUKZ2pphly8GGL1iHLDAsdpgvfCHTQGm4j/pkQ5u8fz/q8/pbaL4sAB6Akwb6cisYSlrX1bIGM/yT1Za4tdvp0/GqtyVy9M9mX1r/jLU9I4K7qmWEE3A1tLhZPt3wQEZogQOSjx80LZggnSKwOITwigV6xo7SBUANnT7tzDcTEKwN0pA1AiZmLFsN6BJOiKUZ+l4mQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB4391.namprd12.prod.outlook.com (2603:10b6:208:269::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 31 May
 2022 15:13:34 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%9]) with mapi id 15.20.5314.012; Tue, 31 May 2022
 15:13:34 +0000
Date:   Tue, 31 May 2022 12:13:32 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will@kernel.org>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] iommu/vt-d: Use iommu_get_domain_for_dev() in
 debugfs
Message-ID: <20220531151332.GF1343366@nvidia.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-2-baolu.lu@linux.intel.com>
 <20220527145910.GQ1343366@nvidia.com>
 <eda4d688-257b-d12a-56c0-0f9d3a10ef8c@linux.intel.com>
 <20220530121412.GX1343366@nvidia.com>
 <42623a73-c288-1c0d-7021-93caff4ffb6f@linux.intel.com>
 <20220531131052.GD1343366@nvidia.com>
 <60318d83-e22f-f922-436f-6c31bce24d59@linux.intel.com>
 <20220531145301.GE1343366@nvidia.com>
 <a7d6d830-cb06-e0d7-0688-028f9af900e5@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7d6d830-cb06-e0d7-0688-028f9af900e5@arm.com>
X-ClientProxiedBy: BLAPR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:208:32d::31) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a649dd6-77f6-4729-ea40-08da4318211f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4391:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB43911184D602AD3D1EBB0DDAC2DC9@MN2PR12MB4391.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J/AJOyE4+9tYEolfxMkY1RX9b+OMU+dvfLxVuCsDBDu0oGvHxbuvLcg2+oO4IkU3qUcRqcEuWlwst+eDT614lM1M26kfQqoBGC6P/25b+2j69ddiisv8l8JG57h+BvbrqVt876mkYHih3UfBPzRpOU7bl8nP/cnKaqNnKTYsIwJecj8dNcFcZ0j6JYPhb0LZfwycn64ulxqPe6BmKlUw5kLbQ3/9QtIyb+jrwc6zKuPMm6426k4JfhGSkb/I29GLYEaqfFQKYOg+OjGR/aaxbOrexXHPtdBPIExE6VW7kugMe7u1WMbLfyFycw/V1s7KZnKq7nZLnG7+2gGJsYkiY3+OuD7nqwnz+5FwgyCCNK2jIgGNPgWqudeWe+cATJx3esgBwar3GxTO+EEKExmm/UUtavgSx/gHTZ7J2eDHpMAAe/Eco6OLnS98Uc6YpQuAYRVt8jf9yijIGHatTcS/CaKbPQueYh0VbiocJZSMDuEOy2cmhmjCURvEoKld/ethWlkPlVFZDWfXkrZTmVl/AaFee4i6bGpEd4pWSwvPphKnqmzlrCWOCzzDhwr1ScMTCiZMtzr7JA3qJRSqtaWBdKZFSEJPrdA5xBls1cD2QkNSW+GKn/isZLdTKM3mjx8cPaRqvQSzxzdFn2fuoylDuxg617ucyd9cydbVm3/QWQ6WUdn6H2s8snnLK2t3M0ljOWGQOpUuhvDPNq3mq08LjPk292Il7RvZ7/6lBPY31mU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(36756003)(6916009)(2906002)(38100700002)(508600001)(66946007)(8936002)(966005)(8676002)(7416002)(316002)(186003)(66476007)(6512007)(66556008)(6486002)(26005)(53546011)(6506007)(4326008)(33656002)(54906003)(5660300002)(83380400001)(2616005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RGuu19Y3a5+Oy4sHruTOYn9Bzu6uUvHVrW35M9ZeLo0733upjUHOjv13z16s?=
 =?us-ascii?Q?cl6rPRLa9LczWVdI/R43EWrTMF8ZXmaBTOHXDCtTultQhvwwoTMXuJjpyHuD?=
 =?us-ascii?Q?YLWYeYl1V27BONWJTMbhCbkp8H/9FeMHELUSqgyylXoikqwt0G568XHCmvAA?=
 =?us-ascii?Q?NWZI/DlTYAQcsuigmvJB82EkWejxx1IzrIP8SgqNv19lOdywKzCCdAvhSVQF?=
 =?us-ascii?Q?h6GYXnatSGqKHgj/1g8/6TPlQDoIwH871HMHgYKP3bXb8i7nUYwRHQgdnEuO?=
 =?us-ascii?Q?+gSTbaexS3xy0ZzL5D/EcifOvHGXOMCoU0tfhmvZ6rRD0CkYxcbeWcJ0W1/i?=
 =?us-ascii?Q?tpzs9Bg/svwhh+rPJzHSpKmkeoNc4TNAGS4TB2Jd49vqRhG4OgVtDDKcKjFp?=
 =?us-ascii?Q?V+Fg1UeYkrfy7jOOAp0ScPduAbP9YrjgFt4Vu7h1f6yj4Jc6CprqiCHYCB6j?=
 =?us-ascii?Q?uUls8MQq/wfY1AiXMLmYqRQU0WFe42wWH0S+0McNS1JLjKKVoaYiN0vFbWb1?=
 =?us-ascii?Q?B8ra64Z4dkJfvnouZ39KXw5anikZfFfNDCOW8+fKFK3lx14/+DQibePi1fQ6?=
 =?us-ascii?Q?fX2hG8VFOZEiTOmciRCNi4AUVD7wZOyZrsTtr24+wXLSKJqpL3g/YZ8LwVa3?=
 =?us-ascii?Q?2fuIMXK2fNsRdQVNBqK1JVmu91Qt/+fjl1qB6f6EqEfOzPTVi2qhlAt95KSK?=
 =?us-ascii?Q?00+Vkpxkg0nW2/PIco9hmImtCI/SMMegOkARnZUutCFAxf/tAebsYuoZZVId?=
 =?us-ascii?Q?wMC91l2vTHzT8uscviDNYRUDflkNmkWvFuAdwkISJAFvV5oziz6DEATP/135?=
 =?us-ascii?Q?ZMsB2EljqCDqGYWD8qdho7NefNiA31MA6FvjYAQw74xXBaJvIG/2KNnrSA6R?=
 =?us-ascii?Q?MyVpZrn8EasuSAdddVVPOQWC8zCI1zSnLlg+O73WeltV8GHiujHnaQAx+yaz?=
 =?us-ascii?Q?mKs8x+f8Hl7dXMwOBiH1NjAFIih+QAmPdyO+eRbci63hazGGRXRqCPH836Fo?=
 =?us-ascii?Q?BZDckqHwqGsNHdS0RtCpnSd1RQPh/JCYsnaeQKjXeCjp8piHlrAi9PNFv5WU?=
 =?us-ascii?Q?D4wKHAsPREynVDqwlNF7CjdRyDa+c7oFcvoaQCSUBTso5FtU96b7WKDnQZz3?=
 =?us-ascii?Q?rC1+uqZkMmMFwM/fErETiczBIpd4fgAt8pOlm2yXMuS2DwgRv5WI48zG3054?=
 =?us-ascii?Q?Y/TX+MlYjrDcgwdDke4D9fJfHjFErcn0wiG4EG6fNDBDjCItcfoVZAl7FDYp?=
 =?us-ascii?Q?ZHv+Upf3hwdd2QGcsuGh9oCDvsleZpAkLgO3PyvcsIYmRwOYbRlKqrGXDLgM?=
 =?us-ascii?Q?Ywq+zAdOf79EJzC1/daTuNlBhDEYEArxJeZxN3qC7UIj3Yw0u9EKLFMQP1vK?=
 =?us-ascii?Q?hbcsHz+07oVE7/9MrR7XWtj62wGGFNXhsJb+eh/tolHgs/asHxn4RZf2dwtJ?=
 =?us-ascii?Q?mTB2lc/TM6UZdyBZW5K1qBWQ5JQK2pXseUOEo4ewcp2e+PbqnW9Oi8Ynyekk?=
 =?us-ascii?Q?7FlLtFPLXBun3h6F9S2nsifyyntviAW6FehRLKtqQ10JSfVimXCc+E4tH7fv?=
 =?us-ascii?Q?qGW8T3OB98TnfPul+lLJgHdgllD3ZFagWIYMR02KtS2GUHqA0Rlv2KiiUsAF?=
 =?us-ascii?Q?Sa2GVDYo2LPRPHxIRqG/arHpfVhn8SJgEdIgDIxPQJkbO5+lYM5qWGzWZU7O?=
 =?us-ascii?Q?cKU+AhnZ8urvRt1qENgwV4Ug9Ajzde0YmvWgN30UmGdrhBXKN3fAQTykPBuQ?=
 =?us-ascii?Q?yWmytZO+vQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a649dd6-77f6-4729-ea40-08da4318211f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 15:13:34.1299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ONyiKcUMU0sMtAiWsnnJrqcXGeFzyE4tzw8wZ4rFvPKeryPJAk7zxN1CeG10+pGt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4391
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 04:01:04PM +0100, Robin Murphy wrote:
> On 2022-05-31 15:53, Jason Gunthorpe wrote:
> > On Tue, May 31, 2022 at 10:11:18PM +0800, Baolu Lu wrote:
> > > On 2022/5/31 21:10, Jason Gunthorpe wrote:
> > > > On Tue, May 31, 2022 at 11:02:06AM +0800, Baolu Lu wrote:
> > > > 
> > > > > For case 2, it is a bit weird. I tried to add a rwsem lock to make the
> > > > > iommu_unmap() and dumping tables in debugfs exclusive. This does not
> > > > > work because debugfs may depend on the DMA of the devices to work. It
> > > > > seems that what we can do is to allow this race, but when we traverse
> > > > > the page table in debugfs, we will check the validity of the physical
> > > > > address retrieved from the page table entry. Then, the worst case is to
> > > > > print some useless information.
> > > > 
> > > > Sounds horrible, don't you have locking around the IOPTEs of some
> > > > kind? How does updating them work reliably?
> > > 
> > > There's no locking around updating the IOPTEs. The basic assumption is
> > > that at any time, there's only a single thread manipulating the mappings
> > > of the range specified in iommu_map/unmap() APIs. Therefore, the race
> > > only exists when multiple ranges share some high-level IOPTEs. The IOMMU
> > > driver updates those IOPTEs using the compare-and-exchange atomic
> > > operation.
> > 
> > Oh? Did I miss where that was documented as part of the iommu API?
> > 
> > Daniel posted patches for VFIO to multi-thread iommu_domin mapping.
> > 
> > iommufd goes out of its way to avoid this kind of serialization so
> > that userspace can parallel map IOVA.
> > 
> > I think if this is the requirement then the iommu API needs to
> > provide a lock around the domain for the driver..
> 
> Eww, no, we can't kill performance by forcing serialisation on the entire
> API just for one silly driver-internal debugfs corner :(

I'm not worried about debugfs, I'm worried about these efforts to
speed up VFIO VM booting by parallel domain loading:

https://lore.kernel.org/kvm/20220106004656.126790-1-daniel.m.jordan@oracle.com/

The DMA API should maintain its own external lock, but the general
domain interface to the rest of the kernel should be safe, IMHO.

Or at least it should be documented..

Jason
