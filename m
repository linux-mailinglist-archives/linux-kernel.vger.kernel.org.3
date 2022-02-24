Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F524C2C4D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 13:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbiBXM7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 07:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbiBXM7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 07:59:14 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B57A28DDE5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:58:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dl9IZHLB7+W4A0oYnLPu1HhQmb/pYyZ4+GU18wEhsnftUGmKM/0SU8w9N1+EblJJHOAcdpt3iakrBRXgT2xZkxh3aDFzSDwRAT7xXXMqYa9MwNiaR1lE7PDs8MettMGojmLEUXkKUWnaonymCWHCTiJJSMTf6jivmDV+E0UQwvAXGpyKPLyhROQfPiRvyBk5CvOs+57x6pFnD9AmBnY6QI6MACIy9CluCO9DwIs23/04G+mrCnlKuwQvHWjD3Tq1wGcGvFhyourXWsS878rAgFTc/IVmbTpXq2JO5vyiyEmHjBYyFAFqTaOTWsEi3sb9KAoT7PgxG/xdMQsml018kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJaRq1uQKdS9ywGG3B3dKmPLxL1FUGLojp3x1OscV6Y=;
 b=if0csP2qmaYlgedXM6udgyGQheXmflg/rLCVoWQHZKmC/8wWRLO122y9oFI94q9cd7jhwhavPnuX/gG2A3mYecNyaKZJHlCQoHyYD9IivmsyJKPwldJWS2RBQnTBiY3hmk59j2BFq0ay1QNyvmBNb2b9hiR+eZ+2UUBoYagnwWJNKPnWaEFuAEb3orBtKwhFYbiG+ddd/WUSds+++AQtEugLDViKPGbsmGIwpHpAEXVib9OESIMerkT0MpbaPOJPWFyS7t47ynXkDmHkzt8F+4xNQjzfn8mMJflHg6eBQOiWU+L4TCaymT2GSdczQgNGeSphZ2h3wNQQ2S/i3/jdbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJaRq1uQKdS9ywGG3B3dKmPLxL1FUGLojp3x1OscV6Y=;
 b=hTacfZX3u0dr3htv68hgTkJhuNzSnSjIhCZoNBhirZgP00cDd3ztsmBzUubzAT4PZmyY2/gGACwVOqbrEqrN58VhWkN7HpdZSOYL1T9jEJwYusHbcyWl7L64BkE77EEbFM3Pm7TyZFNQ2mQVoVpXqVFb/t4S9hE0B93yYHSFc9jJuSo9friUNpvIJPuyS/Jgs5s8ncyPRVR1bUxi0kBUrjrdFpZ74O4tWoq2Em6SL5YkNYyqF0X1OX55x9PbX/zaC8WAtTjdElw5fHwX+itUebgRUF8gC1opbbUAGSgghLH9qP3+VA3rV2gryd5iHMAwKVZoSUiZ5umNfAZ0yEmILQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by BN8PR12MB3250.namprd12.prod.outlook.com (2603:10b6:408:99::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 12:58:40 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::287d:b5f6:ed76:64ba]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::287d:b5f6:ed76:64ba%3]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 12:58:40 +0000
Date:   Thu, 24 Feb 2022 08:58:39 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/11] iommu/vt-d: Remove intel_iommu::domains
Message-ID: <20220224125839.GD6413@nvidia.com>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
 <20220214025704.3184654-2-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214025704.3184654-2-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:208:236::27) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12c66640-d3fd-4428-e8c1-08d9f795611b
X-MS-TrafficTypeDiagnostic: BN8PR12MB3250:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB32509FD2CD3E097A4394812BC23D9@BN8PR12MB3250.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b60FH0wZe8hPcKF4Oyb65MRUYd9x11RoOqUgYOk66/mQSTUP1GMB+BDbscBqJl3OAjv9ucWFrXTAQtK5hS1EhlHR7FDuzRzFCnFmrBc3IjhOtYXpAwc2vsrCGduCmLY1x8OokBr0ewmsLUZ7icdgbKjSymxd1XzflAwXUljyMG5ZKE/8mgHUuuln9VUAjg3E0gLizwJeAB1zNHA/FOInwmlFsLIpfgn0ABhmI7GfzxLLBfDdke9xyorbMw0Y2C3unrjkNZNvRYET2dPOG5iFQj/olpMSDcpfDvSbPUPh2CA6RF2HqejCSPXcpVp52PidRCV/FZM9UcWxX2nbU4tQ/9MFWetENG990wN5EflNnVxVDH+8IX0HRtSjWuX2LB+QclDYkLJgZNpSOVchasGbrGUoIfnT948svXl0X78xnMYQdKINbI2jesFFd7Lv+tDeOXYEvDYyPrltVnFL9PKYnOMdfoMsESotvZTOZkY7lMkvbJacLVxsrculOxWCDCoYOLdlzYQbR5a0rGI4/lOSeDoVBZHu2AGkgVHNgsrrrj8d7UYukZ0PXNL9FxyhSn9M+90SYTw/c7vY4SxWcHAQhmzddS3Y3CTFjQDE9ctFqh8L9wypRbghMBL5l39LsD2/+5Xw/mwNoe24sEXqO1b5aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(66946007)(66556008)(66476007)(8936002)(8676002)(83380400001)(5660300002)(6506007)(33656002)(186003)(4744005)(26005)(86362001)(7416002)(1076003)(6512007)(54906003)(38100700002)(6486002)(6916009)(2616005)(2906002)(508600001)(316002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fQBtzQRbX9UsuFcELJ9RW+V/+WAlcsHLZmG9PHVz8hnjPNExznPsrVC5+XCW?=
 =?us-ascii?Q?jqlelPbL/Z/YZXQTjZUuZgNDNyqSzyr9zZHwp+cJyFbrNNu7KWgSjIMm2x76?=
 =?us-ascii?Q?FIBVIMZe/Jymzqq0Ti3tLMaj23CDV3W9XSdTCtnzp2ODBOGC9DndQvZayZAQ?=
 =?us-ascii?Q?ovbyJ18uLxtGZRvtsrr5jZaQ9u4dwUYaJxAJkJ2yS2NnReL2JDy8nQAk6cYT?=
 =?us-ascii?Q?3h6J48EIgtaCQZCFT2r3q7fvZgFIWv3RCyI1bCLK846Ez0Zgp4L0AD+5+0yj?=
 =?us-ascii?Q?fDE71fvnfaXOns2Ky2wnSHfCTZlaBzjU8wJfK3JYBnNtkSujN7GifM1ZAvq/?=
 =?us-ascii?Q?W4H4hP0QzCrYSTazZxsAGzClWxbzAcdN2uZ4zb9jvJACKJBcUW7XRaYoizZh?=
 =?us-ascii?Q?MYfHrlx8YBXjVf50WeYAb2smASvp9ekg8BSRjiI/XtK6cHe7L7DDqafAKGj7?=
 =?us-ascii?Q?mO0njRFI99aMa/Ixks7iojz0AjEJePu/HkXZWNtbp19vjxGXf4DVOLIUovDQ?=
 =?us-ascii?Q?AIK4BEwPKUZ4NTeLwLAhF+DiOE37Gpg7+FXFF4p7E2Yf2lYYrbIzubammm5P?=
 =?us-ascii?Q?3jir3GWebsTRqp4i/ILCj/0rkVuNajKjsmtmgWTRVQ3vXBL6QhvEwSTsa6Pj?=
 =?us-ascii?Q?FjrGxSYDQmTrZxs6j7Cq3beR/hmKjuP4WNZzCIhXODMrbMU0PcnbgaJ1N86Z?=
 =?us-ascii?Q?bv+4z9Nj00+sBCjveH02CDNhm/ayXphZKFDlTzMq+pf7xpyUAaHIOfh3NSRR?=
 =?us-ascii?Q?t8W+jtsqIg6KtKuMSVCjVzPy7mBX4Fs3kNMb0eVg/CSu18YWUxTkk4FsNJfp?=
 =?us-ascii?Q?QzTuIK2muegbe207Sx3IPkKLe2xmewRbCFH8DECfNb6sQ2VI3yqsayj/NEzu?=
 =?us-ascii?Q?MY1Z+Rfq/Ttf1AI0DgThlUd4LanJ+QHpyourU6oBmBJJAutP9Ya0CG2ER0/D?=
 =?us-ascii?Q?RfkaBQ1yrjVa8EbG4YbgWOifvtMMfU4YEq61vnv2aFAK5EniLs4l1hDPk4d4?=
 =?us-ascii?Q?+bQ3qz/7liLo8VmyfJnlQ2IyKFwUJ6TzjXsVhOHE88Eb1FUPFwMTvEIqTJNt?=
 =?us-ascii?Q?QcGAmGW0oK6g8wZlJ/mjV8yjHXVEgligeEGMmF3c/GYbdQRfbuFCLIoONAWN?=
 =?us-ascii?Q?9Te5OUSAt5B+4qACPSVVJUuwf7jsy7/HqKjFblA1TECyW8d3qnTeyUylVE7U?=
 =?us-ascii?Q?qsCRAdbEcUnz5kH4Y2TF/ynuAq+qCyv9LKPhia7K3n8jaU9g7DsOBcHwIvoV?=
 =?us-ascii?Q?e/CXVNGkIHdEI34DB7JNV9yUM5ZNh2PVAYE4jl003E2p1v+J59ycMu/N5EUU?=
 =?us-ascii?Q?Vnfyn7A0GvxjkPW5OAc7rTv92dv3+jbOolUol6eyxxkVE0rU0BVWMRazu4LJ?=
 =?us-ascii?Q?+5gDCUM09RHCx7Stvi4pGuP7VDOlrBXh4TdOHkrN5VXSpyMne7to/uPhv1iR?=
 =?us-ascii?Q?/fAObI6TU46Wys/DahswgVjFVMCuK0yqoPAVY8hKyEhEW016so2SdFagQLAO?=
 =?us-ascii?Q?GkymqlM1PlFaXKgRKUokncRaMrGTW8pewKGb6YDryJM2F5PFhYuxMYaNyVMF?=
 =?us-ascii?Q?BgACN4+3jW7g2YWHbYI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c66640-d3fd-4428-e8c1-08d9f795611b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 12:58:40.2907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLoFq6W1W9Rsg8Btnk3vhaYqwoiJJYYsbbh41Zs0dKXLttc9VHzyD1zsU1zcnfoL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3250
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 10:56:54AM +0800, Lu Baolu wrote:
> The "domains" field of the intel_iommu structure keeps the mapping of
> domain_id to dmar_domain. This information is not used anywhere. Remove
> and cleanup it to avoid unnecessary memory consumption.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/intel-iommu.h |  1 -
>  drivers/iommu/intel/iommu.c | 68 ++-----------------------------------
>  2 files changed, 3 insertions(+), 66 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
