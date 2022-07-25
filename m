Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357EA5800F9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 16:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbiGYOtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 10:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbiGYOtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 10:49:24 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B0F13EA3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 07:49:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAeuBtBP5dalMtCSdY+8Ps79nRJzZgPrN+lENg4ZWoo7nbLlCXthk2GfP9qC8lh4E8MXwK+jUr7tj2YANcAWXoheVx89OpmmE/SitHc4IdN6PzHQ24LEYl8YeMRpt3USH+sv8w2o+R7DJnEGgkCr5BFFKn+mzvCM48w4M1Exsz5N9OARTSMZiGZcetkQFwgs8A4r6mYQbC4IAJpAm5w79dVaEVSjS2tJSoI7G9Ur3792GGW1nJWvuEq4VbeKnLFpCbiAY6Lmd0s/6qN02o+DhGEA4ND9Eg0HTODgaOnycioTbUi3tNsLtg2VGE9O+SgBoIfCkSJo4Gvq8q1WwJnwSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpZc20ODEQkwbOYPFs2kbq7WbziAxAht96asOf23/4Y=;
 b=c+dKBmaK0TpEkQJIXEKI1vS5PtfW7i3ztT8+qPRbnnpvNL0XzXsDH/s/2eSB+S8NQeb+tS9LCQ5GCLsBqQ/uYidgx8BwlZFBN/8pFEtD/3joXmTwYCXtO7CypOhTWLrVrQ7qBimHjt3l1FLkUXRxKLa61XZjt2qznOPh02Ais79QwffiTRflM+W4crQm6AJDfYfCY4zqzLaY23A2L/pAOYQPPjqTlYnwFwkr7EGVKzZdJxSdbedu7maxcwJHNwWR3vEPMC6UEZFX02CL9qx2pqiLSrQqfmkKLCH+NqL1sfa/7np3X5KBIDlU9FDgJ9gQd8jeeQhl+XK3Vj+VcsbFYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpZc20ODEQkwbOYPFs2kbq7WbziAxAht96asOf23/4Y=;
 b=NUl0XunzJrfFvt+35TCj1zpT0pSuw0KgvpTuxg+O15U29huln5WgxR5E/uW67Z3cwCSliNBW5hsNj5lIFQtirQSZwKEr77jntQdcXRGCGal6igmfhN41II1AMGFUcIR6H/cKzXNLcJQV96MAA06cftYh/yy60KrV7gw2EQRVdMd8lyZXqXYyCx5IfBWoNGv8g9dU83vLYpLyPfMFK+ussNZ3287+TVtrUdaPnnwtxWgAugHnql328pjsDP08pvxGP+NKE8Kjwfzw15vl+e2vjLVv4ydFnRFTKvGLJ33dvLv2vt1KbPKhvi9AXNpxG1cGfTfHWUjhTL7pDeNJmcKYKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Mon, 25 Jul
 2022 14:49:21 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 14:49:21 +0000
Date:   Mon, 25 Jul 2022 11:49:18 -0300
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
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 10/12] iommu: Prepare IOMMU domain for IOPF
Message-ID: <20220725144918.GH3747@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-11-baolu.lu@linux.intel.com>
 <20220723143334.GJ79279@nvidia.com>
 <487b533a-b289-eee7-0bd8-3be36c6e00e3@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <487b533a-b289-eee7-0bd8-3be36c6e00e3@linux.intel.com>
X-ClientProxiedBy: MW2PR16CA0071.namprd16.prod.outlook.com
 (2603:10b6:907:1::48) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f972783-3f4e-43de-d1b2-08da6e4cdbc2
X-MS-TrafficTypeDiagnostic: PH7PR12MB6955:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IjqFZJyJ2n2t4w1GlBa9XOMWxLUDppFG8ELreI/tifgUE7FUIIv7VGTFX2+TXhx1xLZXDgHJZtK6LVpCyolUUzLqLE+bfDXffDr7epyi2oSOKeyM6cbrD4q7OhFbK1gubSSAH84GdgPQKhTjN3l2t4H4UnSiUdYApL10fjyUby6UfB2afn/d47EECL+GaUkt3YTKv4G8uiNIXoZOqwxkB0ao0qTU6BH9lJtuXcU9z8NmA4HyFwhX7j+yqrWiDdDlDMx4AS4eJaS/ira511rkq64xeijBWvMeHJeFf8pCWZGBUgbFCK7odw+QYMjsScyYVwshDI87Y+za2rcd5hrTtMwst1yj6wpOtVAlJsl0UkICkDdGIdW6hHVn0t5ZjFaAp/wMBcmneuVYGIbnDmb2/ysHjI6oxn3CERwduOeBq4UaBmZwEC/xmLrmjqfHeT2YHj3lLfIUNacrfzyhcDftI06osavspjjPOmBxp2FfmdwLL6FnlHWhD/AKU0tJmdUQ0RkiMEwQZMOjPI5dzyPJPISZ77sr2TxgptOTOSaOM97rzNHudx4lBwExok5sd2jmeVo8Nnmp8117ghjTGUjmdAZYAeuiPaFZ7aJwvJTlCBIl+DvgLBWUe8BT0i2/4AtlIErTG4TSE8ekEMq1ZwVUCXqqAmTCT26W8HdHWlTPOrqAqd50Sxly75vP+EsPPZxyPkqWheOa22PrdfRUx3jd40TilVeZzneLcpfzfp9z/BOWnKpNGNpzt5hffy5DRP4XTh3y9c08WIqNCUg2vNnufuChH8o+o3XCCP7HdJ5GKA9O3Plpnu8BNQqdFaCAb3qY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(6512007)(86362001)(186003)(66946007)(6916009)(8936002)(36756003)(478600001)(33656002)(316002)(2616005)(38100700002)(54906003)(8676002)(66476007)(4744005)(4326008)(7416002)(66556008)(2906002)(26005)(5660300002)(1076003)(6486002)(966005)(41300700001)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wcyq8zVJie4OP14hLoz8PYRuheyBymFTSIhNLtK+toeykqBmDMRuqMmmP6Wf?=
 =?us-ascii?Q?PcBGnKwxKKxhd/Jp1W31Xm/C5Js2nnxDOnsO/G/pivg/NUjDFxS4GnA3dfB+?=
 =?us-ascii?Q?ESlAQ6V2Fi3ga1jB/8iO7jF+7x3ewqNlslDDkeceHqzIV1xpd5Psmfub0xei?=
 =?us-ascii?Q?MQ8EpZ+nTfsTdcyAxE727FfqVzFrgAApmtUqjieL8K2AwdKXyUlgiCele7eD?=
 =?us-ascii?Q?lP/QbJaaEvcz2ciiaLru7nd/E2ygvrn8QWKoQqMUwpraU69Wpjajj/GwJCdc?=
 =?us-ascii?Q?TjKVNNiDCWbV6EzkZ9H9kuQybluHGUVghiA+4ELQzEfa8uFJjTe1NXqnac+N?=
 =?us-ascii?Q?zxtuBAS3Ysc4WYV1d1ufpTskk2UGCq7HIGLFEBc4f1VYM27Pj99mRP9Y8uUE?=
 =?us-ascii?Q?zN4E9mzV3N6lqTAsFh7b7RfAOPr09Fz8O9rEHk88tz64go/hyiVFbf2ifpao?=
 =?us-ascii?Q?cDaJbRn177uLpR1E+oIabCSnWyzjk9AWHYDQiujx51cW8Aw3bszDc6Nym0kb?=
 =?us-ascii?Q?T98h1fVkh2qvNK/6Y6szQ3llTrqf2H0kMuSAwdiHXnRANQCGJD83QLPdHMeO?=
 =?us-ascii?Q?jQuQhYMAz+AFz/w19DEPt0vpd8DJjrnzZJZvDGa+ZkjlszKcBW4XABShJCu4?=
 =?us-ascii?Q?zNnKUecLG2+nclNBbiRnobu9/ibvQZwDQfx3x9bH80mwiYibqYGysY7oi/5+?=
 =?us-ascii?Q?IVdYtfPeOmSwoFuQq2UwAUiEMIIi/i2Gi3yG6jpwNpoSd1PVMID5F8GDfUfV?=
 =?us-ascii?Q?WttVNmKL/FqgkGbyhwlB6pih9XdkEszF8OE4qzihOvm4uLR+R35hbNRn53bX?=
 =?us-ascii?Q?wqItNPBJKow7h5mLvhScTo4Eb7M9X+cIXRa4ynHS1l4WAinOBFR+oOjsaYC4?=
 =?us-ascii?Q?b6vNZlTS6rfB8TuJfdtaZ3LtPRJ1Inpb9deVVLdAdi3o2maXJ1Nn5VKi/hO2?=
 =?us-ascii?Q?/4rReX12HK9yCLCGbmfotjuML5QEoWuxHNoMrZtEQJ8ypnL8pm/o0dWfuo3n?=
 =?us-ascii?Q?FFFR0rdAtHoUJyVAa0vrLTMjlZzYRD+Wr23gaRPfejkXudzpDXzttLg8KFM6?=
 =?us-ascii?Q?/G8tbyiahZMnq1HKwhyzTAkAVRVuE2Mbryy/GaxgQxkziwXfHHZKIk/xrZz4?=
 =?us-ascii?Q?DWYWLAr13iruPbRt0K9OMeSrCzCfx4urMK23TXfSoT4Mr55V/bD4a0KokmkH?=
 =?us-ascii?Q?787RSvzjfj9SUtbPQPpPbKnUjxa3S90c6KLhIN0r/6rq7eeqVm3bsRPb5Iiz?=
 =?us-ascii?Q?yokDlAXi3A320E5PhXIjLDDw7Wdbpkft7FFzW58sAMn5ukYq7ULbWMFLFMJK?=
 =?us-ascii?Q?wfQY2x5IrkuMFWxyUx5uz5FXGhOiME2ExmqdF99yQ3GL/otMAnNn1jNm6fg+?=
 =?us-ascii?Q?IiHhkbOLwn/aCZoGYgz7JWBrJLwO/A1w/pGY/MoCNWFIWFCToGIRelu8A0IF?=
 =?us-ascii?Q?CykSs2qiWX9dUNCFjKn5QZvD2ey8jpEFtz5t5qQ6Mp2cT+4LhvTTY4iyBXQo?=
 =?us-ascii?Q?8Ny7J0Nn40Xtd+37NOhWPbwrgBcNkcp7b+nBRygGBQucvuS0585kFO2o8gwM?=
 =?us-ascii?Q?m3P9AEOlQxVsl0uP+uo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f972783-3f4e-43de-d1b2-08da6e4cdbc2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 14:49:21.1612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lhyFL6zmWLIzuVU5t1M4PvawBcLNRNSqABtBABmg7UaokExZMFS2ix3dM7ydFAaf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 10:04:50PM +0800, Baolu Lu wrote:
> > Why do we need two falut callbacks? The only difference is that one is
> > recoverable and the other is not, right?
> > 
> > Can we run both down the same op?
> 
> The iommu_fault_handler_t is for report_iommu_fault() which could be
> replaced with the newer iommu_report_device_fault().
> 
> https://lore.kernel.org/linux-iommu/Yo4Nw9QyllT1RZbd@myrica/

Okay, sounds like a good future project, maybe add a fixme comment or
something so others understand.

Jason 
