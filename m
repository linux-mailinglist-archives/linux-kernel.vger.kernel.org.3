Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276E357EFBE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 16:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238189AbiGWOey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 10:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbiGWOev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 10:34:51 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294BEB70
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 07:34:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2Y1q/5ajKeKyjRLzAFFGe7zIer9JNTD9KCj3ElvkIrZ29ovgiqzjcfi3EjKnjWSqF2JnPqh386hoceCATIKltNWVwTqRdyi6/JIrFb7IY3MDKxXhSOUaY9ewd09D4dzBdlMI8IW2YV4HNkxzMkmAwjzfI8qIsa8UwViL/nRI4eAliUvOKMQkcLKuCrNP1lGVUJi+vTxVVnzVpMZbLNCE/6DqlOWN+6z1mZo5JxAXujvoU7GGwvk50MYjJbMw/W3Ax4yEZ4DjOIYdpbWtmAICyoMPUOZqYS+XV+FHPWgWWZ8aL8NwRtwK6erghRoNc+MEDA093HNVhY9KH2nDqfeaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jFnCd7AjFGQDlyB45AZgdcYZubv3QxDICMbRDxdJaA=;
 b=GMUBoki1cxjL8mDZsgaLmEKVy0AItBvUV9+ZeGwIVS7ofnamYV9NlvXIgMvC4uHC7iJG5qXgXUQWi+90rR7P2VX6vTqEkD3Na+wH+OzmenmAFSKa0WIyZxuW3nw+wNHKT7/mtSlCJQhhLqprjLy8Z0CrZndAviMy1GDF//rDuFJ9do48nT7ku/W+BbkLqkye3VdNVEkjhZ0wWiYIDzVgzlluz+MhGFqhs/WuGRDXHBtBi6v0VWdZSA4dkXPSsFIJl68bEhAU9GRL2Q2SezeWYTmlZoDqmcdCfUQJixnrLYIjalQavgADbj8gmptiOoXIdEu+cMOS+7X8IyUpixTVvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jFnCd7AjFGQDlyB45AZgdcYZubv3QxDICMbRDxdJaA=;
 b=I6ikxFQThZXIKk5pu0dKNKUSFaK8eRazVrdZT5PXbVqmeVZ+RnJtRBdx43EjEDxuqneeT0wJ9FmCgEhJd8ZyjUIGpSE0wjDQ3SruoeT0qgAcVwkcdmwr21Wcomnf9RxNOziHTLmJoLV8rwX2suaXpTNehscmqjnazRP1OVnrD5kfJ5EHgByIh9zGfPLhpsY1tD13tq8Ro2HAXFuTP0V7VA7eUJ3b48YNCL2wo7VYvhFgCxv58Ej1VmJN4j4w91Rn8+RtZrBbNBJ0miPYY3HPjua0RD+X+uLEysieBxdQ7bHRY+psAN/dhXrJOVvux/meoDg7LG4XdfUFGTdtl6CGZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Sat, 23 Jul
 2022 14:34:48 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5458.021; Sat, 23 Jul 2022
 14:34:48 +0000
Date:   Sat, 23 Jul 2022 11:34:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
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
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 11/12] iommu: Per-domain I/O page fault handling
Message-ID: <20220723143445.GK79279@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-12-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705050710.2887204-12-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0075.namprd04.prod.outlook.com
 (2603:10b6:303:6b::20) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b7f0426-8319-495c-e5ca-08da6cb87ec4
X-MS-TrafficTypeDiagnostic: CH2PR12MB4199:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LI9MygpdtPgVpwYuP/JREHl+B7b7mEl6cVuGTisRF7bhZtYCxVlbvdIh1j/B5L2er/SEL8swOLfDlMZ3DnxrUvha5DhhVM09qFCzztjr1ZosDzPUFpbKlKSPKQhJ9Fc4ULtiluoL0GXvs4Tq330IkWClB5P8OIf7LQdlt8Ry1RCg89dU1oEQ8kWmazonQPTSucYKcJ3JaygGdLelhCw9jAFV4vuvH0TwxT76DNiu8H0Ab+ZBrAF/c6LJfD6jMLRHLAVt0YDjDtkMOYwutDD/Mnm2T76V+VtwG4tsBCw+sUkpY0ZkK6ytHkR/mkPT5DBcQdEBHAsEwRCu1dpNOKQ6pdgTjXKHk0+e9fElO2vpj2fZUf6Dc8iB2tNhf1F3wYupxdy1aZ5l1MMXFIADQuF7RFMdCJrG3h5xY4x9Vww8kQXm0U85LGqRyPNNgzVKs1vKnXjg/Z9rOyGpfnH85GZ9XD5kCYFknZovpDPMc0Ly52lUfmiYRr5a2U0Q50VfEic8LrwUX70G0++QWtFsvEM+puvXYs1t6X6Tr16vyKyLgLYU8bIwrX73mA6Hu/W65nxm+f3wJBWkFIBuS98rS5yR5ZBU4bDAZ6EslcbZm8W+McW3/LEBY7AoEre2/WLZA2jiv5fqF9m5+jioqqVao4VXZxVEwgd2oSfPX53cu8v6kDroKViSVwxTYnPRzwF5hQpkT9e5529Fz+hBRMvMdD1Sy7okGXEqP5Zbz7H5ET5yCkQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(26005)(1076003)(6512007)(2616005)(83380400001)(6666004)(41300700001)(6506007)(2906002)(38100700002)(54906003)(6916009)(36756003)(7416002)(478600001)(186003)(5660300002)(6486002)(8676002)(66556008)(316002)(66946007)(4326008)(86362001)(66476007)(33656002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2D2ww4aNOoxz+ZyAVCfrA0YZWIgBkknRgRpMW+AM9YuaaWmo+gtLg0MKu5Mw?=
 =?us-ascii?Q?ra0vsdBqg5eI/5fLlqcFrGVUK/hxvnAzbBzn/3ukMTI7ccidNl+o7+cyqkd8?=
 =?us-ascii?Q?IO/IIyXgAyzucjnYkO0r1eFC5VMb58idq7gle/AqG/+A6EWhcKElt15Gq9Q3?=
 =?us-ascii?Q?EAY+vcZTx1xdqnV1HOLbT+aa9JRCtUkStfMrRgJ3yxQX2NRiF7mYrzIYKvwr?=
 =?us-ascii?Q?4kI1mZ2JCvxkAeOA/VLkYOYOWobpoiUnc6Fuy/MQEnolW175JlAjHGBk21Nx?=
 =?us-ascii?Q?5tnLTBybQ7sJR+D3OxkWxAXoz35+NQFlsf/hXr/2adaR1zS0jPekVmpoQLU7?=
 =?us-ascii?Q?Zz/D4nLHweL+dKh67sqvSX3PBd423yPHZ3U87zQZZdaMBCbl2i/nCuuZKYJ2?=
 =?us-ascii?Q?Ll9Tk1gAz2HlzBnTEtnn4RTffki4Rp5oC7do8rAYU3O5DT7VIx9wM+zTfULn?=
 =?us-ascii?Q?FciNaFpcKcw5c8PoyYZBVEXlh9416/eCC8FLgh+BWtx/kQmif6vLuy62jnG4?=
 =?us-ascii?Q?83rp3quPqFtDWPLzs16CKSk3E7qAi50kGzEWl5inb/YpICtEtOJUJoT1wrIq?=
 =?us-ascii?Q?nhghR2xxRU/iqGvFXzf3CrnJSJD8ZTUEIZabzSN1vWv5sVCT7uK1RALOKhCD?=
 =?us-ascii?Q?vQ6tFwRjYS885kKYDzp+Tpm7vQ+m8CuJmXOMzDI1mn3f9YVtNJgvaOZQ0RO3?=
 =?us-ascii?Q?/ucT15d0YiCmvO3QR9Yn1YjMWFzFtiPBuF1d/IfawsuiuHj1GjPe0CUUn/xM?=
 =?us-ascii?Q?jnHmfOsVSh3+D0OKBGIuwGh+SUghLcAMceiac9gYJmJ/XgRpfSdBO1qmwfsK?=
 =?us-ascii?Q?Ds7DUc0oWlUw3sptkMNFHNifiUp9iPcFqeEOGmnNOhpoXUNPu2bj7Sapjmoz?=
 =?us-ascii?Q?icEH4CqVNVGF8YyVTiudNSiIKk9fU24AVKVMHSsRehDXIBPvjKEVSq/nK4C/?=
 =?us-ascii?Q?QWkTg+0zWJK+1XQFwbdt1CmC25t2z1BLQg9JTQgAJ94EySsPZtgtZPs9KMCo?=
 =?us-ascii?Q?u3eRKKcA7v2Fp6z23Fhb0B/13bqgYeE2A3woLl/t1ZFg6ChLbaDCEQsWwwL8?=
 =?us-ascii?Q?lBwkh6b/q68Q728EVh0A65oQSTeLoX5fh/3EzQgDdc4fUsUmxt9NlpLMB2mM?=
 =?us-ascii?Q?/5zqRJUIcbdgjWzuiLZmokKORLN4sYS9Yul611MkQLBhE9KOoM2HfdWAPZ5J?=
 =?us-ascii?Q?qCWXcfb1Elrat1OOITeLvcMTbPTRoAc5lqkLg2fcnpyEcFDycCo2zlVNIcwQ?=
 =?us-ascii?Q?3QnoUXNO537bib1NVFW/nRbf5u+WEKA217PzyymOpRoCihk3dNQvQZlwTJ25?=
 =?us-ascii?Q?92UQZvN5gT2dF6JhuMHkzK25iHEXcyD/8TPTcv3lEN6PqNJX74TXRKCyDUIu?=
 =?us-ascii?Q?oQUgaCwofqHvBAw9+mdn2b4yJCuiDYUmiRc8UHXn9nb62ZB9s4t7WM3I2zhA?=
 =?us-ascii?Q?02Iw964kUKPluz2qKYv4h08k8qFQMdinQXfxnVPiQVLUuwNdcFMWmkzDeqhM?=
 =?us-ascii?Q?0ogDzBVTBia5hSW0nM9O72g7NuaIUo2Ry+DB9J+LFeJUsDzXAk6RJzpm5byS?=
 =?us-ascii?Q?vgXZaPd5opuKD4L9Aiuf1k1DW8fi6PeyAxjWQ6bC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7f0426-8319-495c-e5ca-08da6cb87ec4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2022 14:34:48.4055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZrtoP80akUpFeZo8yM5AbAMX2G3thTWlY4khbXyZ0AOkCdig1/09VJHZlii8EzF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4199
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 01:07:09PM +0800, Lu Baolu wrote:
> Tweak the I/O page fault handling framework to route the page faults to
> the domain and call the page fault handler retrieved from the domain.
> This makes the I/O page fault handling framework possible to serve more
> usage scenarios as long as they have an IOMMU domain and install a page
> fault handler in it. Some unused functions are also removed to avoid
> dead code.
> 
> The iommu_get_domain_for_dev_pasid() which retrieves attached domain
> for a {device, PASID} pair is used. It will be used by the page fault
> handling framework which knows {device, PASID} reported from the iommu
> driver. We have a guarantee that the SVA domain doesn't go away during
> IOPF handling, because unbind() won't free the domain until all the
> pending page requests have been flushed from the pipeline. The drivers
> either call iopf_queue_flush_dev() explicitly, or in stall case, the
> device driver is required to flush all DMAs including stalled
> transactions before calling unbind().
> 
> This also renames iopf_handle_group() to iopf_handler() to avoid
> confusing.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Tony Zhu <tony.zhu@intel.com>
> ---
>  drivers/iommu/io-pgfault.c | 68 +++++---------------------------------
>  1 file changed, 9 insertions(+), 59 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
