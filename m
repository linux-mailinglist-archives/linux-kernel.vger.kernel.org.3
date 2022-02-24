Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759864C2C5E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 14:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbiBXNAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234591AbiBXNAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:00:48 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E1670CEA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 05:00:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArlX4L5nIbZmc6JKRxF4JRkUGjvroJ+X7tDBTWhs5Xo7MxlfpX3FhSg+B70Iy/MQpkrl9dZkIDjXX9p5hD3h/OGjXZQd6+g/TtAx9b+sLLXr5sKOwJccdPj/5TaDVaU3IX1KOh0HaPM7AJ37JDr5IArqZlZqFI12vPRRMgtZGhpLxc9SZlnLJKCZCeR0FBFhNWg6Iy32iHVaIzyhz/xHaw3jESmZdjkk9ZbA1/FwY2u+drw5UZ6tXzIUL2PMbNJ2CsZ3d8Ms8GWb3vPEupDqYgBA1vuTiZTiVJv4mfviDZCoa+yjz+UI2oS9hUUwTx41t1ALPUyn7+kUI5JrjLgevw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHa9G+bUpfUwH9eXzc5uaXjH9+mPlklpRk7K+ar6bbs=;
 b=oBw5FWgT14+YYANeZ/BT7vpkVciHB/Vyoc3iTxO2elCSgYG+GMqg+AaP87yTHafM4tmjapXGKpPyS2qwsI2Rv+otZODjkDKLCFd9ILnyJdLyl6dSwYmkxOPjVCiyFZTU51Cs3EarP1+p/5HzAjDV4qLq3hSYu7Dvr9mIYVax3Yam1Mm9WXCF9wGH/Kj7KIbX98egr+UzhPE2jlv/Zv0pioN8qh6VHF92T4tbJNPgBftXDDHQMhvWUQ+Gaw58XJSGyVrtmsOocbis+IURDeEBnzqKL1accbf45v9uRGL6vsy1Eik1Mzadub2WKrOSl2P51suS5uuk0aqGLdDEeg1CHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHa9G+bUpfUwH9eXzc5uaXjH9+mPlklpRk7K+ar6bbs=;
 b=T5V5kzvYkAYVWwaZsevFWNKfSZ2TXy2+JBQGJSzRSfRys7QFiIlqM6dmzfLhDAv4bsLERX2Iga2db589t2SA82/xlQAm4bEamN8YQFHvgu311FsUpameP/igPOvu67jWNN4dQhWDFDR7irz4aNIos7Adh37ewVBTptqEnIHneYXW/208xa2wbsxKpur/7xWxyUR2dkIsXcmqnsmASeYl2jKjAzMowsArpB5vEB/NFoRCP8rckJUlNHCOho8NLpjeZBZWWzff3QCMN/eequTpyO0YtChocZ0Tgdhui+pQfyaYiSPBXV0CgbSFbCkm4KI6AdVHqDQTUqZJ2zzQA0zsDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by BN8PR12MB3250.namprd12.prod.outlook.com (2603:10b6:408:99::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 13:00:16 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::287d:b5f6:ed76:64ba]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::287d:b5f6:ed76:64ba%3]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 13:00:16 +0000
Date:   Thu, 24 Feb 2022 09:00:14 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/11] iommu/vt-d: Remove iova_cache_get/put()
Message-ID: <20220224130014.GF6413@nvidia.com>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
 <20220214025704.3184654-4-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214025704.3184654-4-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0276.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::11) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bef36eb5-d4db-4343-a3f2-08d9f7959a01
X-MS-TrafficTypeDiagnostic: BN8PR12MB3250:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3250FCA2A0245828E0DC7358C23D9@BN8PR12MB3250.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lVn/fsJ8f9O7jpuxwWmEorvLa2QtoCIjlhSI0lW+4cxZnMI78wggqUmRKuCVTDp8h0b0DCW7WYD9ov3fiBIMGBC6pwLJSmrexaZDvJbiHmc9FQ50ATokISb9mO9n0qvwMzWAFA1EZI2+lXJqHEnpzkzVQ9ZQ9A19qgyM6wt52LIZ7GKzlOFels5aVK69EbqiF3ahMENRvY88UzIGxD/cuU78+rNem1VdE6F3VrX6kyU7wid6hc6ONQXmzo1QCVR8KmwlWnuYoKFQlW6enPMBIDl9MrnZres5KL9heRZaANTWGRyAoESfWyQO6sKlyQTjj5TwJofRDLxGYnKbxMgpXF/eex6uTseYvw9cahX/PCPce/ccWWRjP4eKQeStuGw75dt0a0hKBhx7ufssAlJ9xGmJxLUMRnINSePe9BLHYXVFZB3h/SDzsFX3ceTheeju67PTe1lC9TGQy93bbjewXWpAEmWv1829FvCuSsLfZRW8G6MYf+Nz9GEAaDjFMgv602vXyxslqEg5i/juXoSCQ+oK0b8uKhEBVVLltTTBM4BkdKdCU6qMQsPJNcN0Bbmq5CJZrNVrBt21fpI6NXZDvFSYFiGVitJSb6RvS38DzDdwDVBxpNYEoYDF2ODcAgWSL/Gt9cAffIQTV6mGKs2Byw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(66946007)(66556008)(66476007)(8936002)(8676002)(83380400001)(5660300002)(6506007)(33656002)(186003)(4744005)(26005)(86362001)(7416002)(1076003)(6512007)(54906003)(38100700002)(6486002)(6916009)(2616005)(2906002)(508600001)(316002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cL8WDSVd1A5us4GV2wHxqvhk8n6VXsEQPFkBA6sBHOQZYmai0b/4T2H0wT3Z?=
 =?us-ascii?Q?HZ2J8+i/j7DTAwaM6MDgSE+ivmrqedN+viS3HqjlxMrcedE8TXL4AU20Wjtt?=
 =?us-ascii?Q?z8VLk2NkRkq1+kO5FmYWO+bDClngDtU7hV1KdfIkPy3SRSmEZ82fcSc7gEYZ?=
 =?us-ascii?Q?1lam99MqY9ijX1ue6gyCb/pPW7617h+rkn0vKfSeUuRu9MMFLbrV91yK26zg?=
 =?us-ascii?Q?FonQBHAvk0yJHEFbRGuvWjZ/gmbkOhlrw6UK3FjzuRxn6TYeRqAjoMSw2B79?=
 =?us-ascii?Q?5nCutagIq9NXHIZxmKvVBjzrtSi5OMgBnS9I5MFLImd3ThXe1SoDOoNO+PZc?=
 =?us-ascii?Q?Rb6dx00P9JfP0jmDApI6vCNlggvSf/IKrVk/gxariYXtyJMP5zovJTTCfCCG?=
 =?us-ascii?Q?18JVPx3xegdcV7C0q0X+IiG8xnwuRH/jjU7KTuNmCGcQ3qZq7Kj/GVuyNntg?=
 =?us-ascii?Q?BTHlqMUvOeaDl4mU4KuRmN//oNVZkpw03UDA+c+HP1hH/vNcaSn+EQBslWJK?=
 =?us-ascii?Q?++cXbAaE7t+7WBqiHG+UUzCV+WPTn5SxktkaGCWbAQfqGabUINjzajo6ffAT?=
 =?us-ascii?Q?wG077srBNxA6dPmGWsSRkhWafeXzB7zV96OANOJrcPA/pw+Hp+CqeF+CR7ex?=
 =?us-ascii?Q?Q8xyzVd5mPMyIX+dsEi5NofliVAMvW+AAHT4j92u+onUoiGpGxA1Wpu7s1NH?=
 =?us-ascii?Q?F5PHYg0t6Xr0/seNPCYEqrqi33zg/KNKSdBJhJTiwc3Yj/92rQqtXk5Q+4ig?=
 =?us-ascii?Q?dxqeTDQ6uUO1NTMG503Gkf8iOMCyqg7K/leNwUDXxiQMhAvmyTXNSAbNna2e?=
 =?us-ascii?Q?WLgOmG9fb3GbYGyw3UQjDqPn3Fl0WnzMdszxhqOQCjO1rkkpWyF8DVMw+oZU?=
 =?us-ascii?Q?iDcUr2GYGUT0zUm7XrTWlfP+FaoYk1ApB5g9/fQx9V3GYLB0AIUf5oFIVRjw?=
 =?us-ascii?Q?o88w5fCNH0MnT88mTUAHL4HS3sAV1gRxPrYe5iAk6Fkn/nLpmPbuCM5b/9Qn?=
 =?us-ascii?Q?doMpWXiyBUTukGzHLIsiQWyaqfu7q8h5d4GssPuxNlY+7m61dVBc4+0jZigX?=
 =?us-ascii?Q?8d8PZvI+233PR5uLgXiLMx1nFUCDp/btfkmicwl3+neRnoF/D4lMbMT7XMln?=
 =?us-ascii?Q?0CKjIMiwfe/w7yns1MW1rq3SXmh1dZFnFFLx/jRD5cB6jDyU65pFy8fr91Bn?=
 =?us-ascii?Q?sJIiyqOxJ6KxBJDQ/hnflHrDsi3W/yvo3VnPYXJEFq33UFXCSkp8Ap6ynfRc?=
 =?us-ascii?Q?sTowQsAxHVEKFx5xCtiq9IIdpsuUP8zzYEE+82rcAzqDJYZJC8DobxWnPCUG?=
 =?us-ascii?Q?fw49t2/zUU4849/V+rgEVkUxIW7ZNzvF0iPd8rLzn/R0Zwqvdf/cGH/lS2eB?=
 =?us-ascii?Q?PmWk2b7Xftme3d8pYyGaFaLEnvkWbaHArxmZO9csUNncPOVsavUJazwf6uIu?=
 =?us-ascii?Q?byRgk4DMoiu7P9k1nof8iRu+0E8OdRIybFLZAFZKK0g1D07Zc5ceCwbykNb4?=
 =?us-ascii?Q?3JZKOVpiuF2EUYQAGKst1aDEkikS1rAHlEZ4Gb7UctGc38KWuAD7polZ4VP0?=
 =?us-ascii?Q?vkmJ1IYyKSxp4zIHQtA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bef36eb5-d4db-4343-a3f2-08d9f7959a01
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 13:00:15.9853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x6GhOz27fMjufSkRU6gJFqdZ1pRuNwjpr3L2BZe9icRltzdV6/najHVr4lKxeGCT
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

On Mon, Feb 14, 2022 at 10:56:56AM +0800, Lu Baolu wrote:
> These have been done in drivers/iommu/dma-iommu.c. Remove this duplicate
> code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/iommu/intel/iommu.c | 5 -----
>  1 file changed, 5 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jasno
