Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C98528C81
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344517AbiEPSFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344525AbiEPSFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:05:04 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5793701A
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 11:05:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvCjAAzLR24EgDMtuJGK9oix54TpRU3g3uES1bY5C4686klhvXAH/lgZy7Poss7zMMgPM50P78Hl07dFHasJ7ibAKsszLLwUcr4kabdcYV6NZ69496+yNSVkP04wwpL357XS7RHAD/4f3UtTFQ3lFYxvZsCmFVR9PNXbpxF1i5T/+y68mlnPBgTK3jjsSX9JAzLQjwaeBXVygXTJNHQ4OkGObJdJd8VSk0ZXSfrPLnvPgSedoawgxNNKMv99o3FEwo0NSMBiQjXT+vpaoOEab4fUdYswaJVPZICcmykwAQKiA1mFbxuXNsbSUdPig7fEkTOjaI0iWRST/Lj58VKpbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOghJ5X0gCN9xWKbdCoM0CPRtasFSC9Oja2bGjCPWAo=;
 b=RHgLarUdYMNIZzSCD5B2iEFqLRx/uS5cOe/rE6QM0s3lVQRaBDlDcMKJla4Kz8N0cxEs3xiSHD6g0zBGHB027hFxr4iFbeYPlgP0ACHdKo6VNCgi13CGvERd8hcgfQtBVmNqXg+StwUuLYK8xA5T9NGo8ZfCM9bKHwulfyJX1YkBtxDjVMTVM3OVSVwf8TYvPoaguzAf3hZkVlmV7+FkRvCYLGF3ydV/WMlqG3yEgr05gk43aj1RLg9zSwiH9/KtckJ/IEeuM5FvbaW2aQZTRcQxc33DgLYbN/b1C1O9GQCYBxSI13Q6UnKJ8cJB0PCj6VMHIAQxayguIdinSstiZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOghJ5X0gCN9xWKbdCoM0CPRtasFSC9Oja2bGjCPWAo=;
 b=pycShA7NE8R27BDk9oCScAbI3zETn3PKkkjb39NBRp5IhC5rVQceEyBelua4Lp/pOBfsBAEf52QNxLUoit1imVO35juX84S8IjcFP8Sz45gvVBi7ZlEgdxIPd9jG+G5kP6twF88OmrOHPET9YXK1pBdCmsvYaKlf4tckdgoE95I0/2uRQptxge9lx3UaX5PjuYuVAsQS9CsoXuJWhtW2nOSq2wQ1OWMCj4/DW6XuLj/XJfI7Ay1S9L3FmQYkV0vLjb4nqMO4g5d4DJCQT7yAB12PhG1HEDIDYpzFVsYFmAjkY+MVB1eSzFVSrRL+iW/mMKRu5Jf46jcFikYF7B2tIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM5PR12MB1337.namprd12.prod.outlook.com (2603:10b6:3:6e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15; Mon, 16 May
 2022 18:05:01 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 18:05:01 +0000
Date:   Mon, 16 May 2022 15:04:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ning Sun <ning.sun@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Steve Wahl <steve.wahl@hpe.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] drm/i915: Remove unnecessary include
Message-ID: <20220516180459.GJ1343366@nvidia.com>
References: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
 <20220514014322.2927339-5-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514014322.2927339-5-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL0PR02CA0031.namprd02.prod.outlook.com
 (2603:10b6:207:3c::44) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 515d9ce6-b114-4255-91e8-08da3766988c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1337:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1337DE23AD4D2C368C0145F4C2CF9@DM5PR12MB1337.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jyLatWSnw+kpN7luqdqULsrDjMVdG1D8p35toXfKXDwdg9fG6qumWmhZ6vhcglVwVvzHhO9AU3P8kAEM+H+dWm0NRM9/0sYhQk65ttk3mdlxeJGvyXy5ml45lGTOrWXCLwonFsrcj7w1JaSI6h3bn7vZTz/c7r1PJDA/udmevb7jhkYAT/sjVl+1wobuunoCinkoTk/GirEYxw6s+lb3DlmvKklWYa9cBMSopGzwqndKnOyEU82WSpwG5pP/C2Gjo3e82stANHrVYljccxJ4ZxID7RClPhl/mWcybB1Ay8lgBmrqGZG1WgE7cZK+sczG+opfwIRdxOWBfbVCfxwRb2nwg3yM+gVoe/Dy6Xnmbyn4PLT1rhgIv7jnAsOtxaAyt9qSd6eQ1ulBJM947x1TkcAeJGSwP5/ZDZJ+DgflqUk5FmxDDGuGz3heiMNUKTwqX6shpUWCS/1mBwKQCSUBTcSFiw+hFlQENZf0lkCkK5eRidtoXEOpWnZFTwo+h+n/3Ao6CJPfJzrIuR0tQkharqJq2C4ng74X8LfcpQ1Q8SK3OH5kvreGLvVV9yIdAkXNQYQNYJT06dF8jUXIqso6qLu8gno+1XAsDw1krJOabsfgI0nwEiePByXCbbdI7c64f3EC4YA9+I1lK53V8lXDuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(6512007)(7416002)(86362001)(4744005)(6916009)(36756003)(508600001)(6506007)(8936002)(26005)(186003)(6486002)(316002)(66476007)(8676002)(66946007)(4326008)(66556008)(54906003)(83380400001)(1076003)(2906002)(33656002)(38100700002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cdIm4CViuFClDi/qH81oCNPEePZj4bsFRbuUT+wwWwbQOkYCITrrSQjog3CR?=
 =?us-ascii?Q?ah6D66YRooqpm2RCWG3cLaaR2VtFBNdCxdHBPTvsSkBvtkKunGZC35mZr/+/?=
 =?us-ascii?Q?MzTv3zpzE5kzrKv930EP1QHJ9DDpS+92WK+YobWFxCt9krqwCa2J8gp8h0r7?=
 =?us-ascii?Q?7iMgMQLeQL9WVubub3m+IGPPYDq1LwV6Cyd6tSOuU/qgL+w0mtOf/BefZgoh?=
 =?us-ascii?Q?On0Y3VQJ6YS9gT1YCEE+wFLxLdRer8GocI7frrgPHQ8+vlemWMzPZH9rORh+?=
 =?us-ascii?Q?8H+lDTf7P0a3MmaIcoDAcuIEXjDgFbSRTnDWVmMVjjJZccl77bFElHImQ43X?=
 =?us-ascii?Q?u6+cPe0FvsByZSrzoUKtEKaPu9iLvDBdh/X5Gx/yPyIdaPM0Wv/06DgB0K3r?=
 =?us-ascii?Q?f6r/jTJkYjBQTVpzjb2Gi+HkScr6u8Oj7ZOSnOaQ4aQQUEOlXlhNXb7L4Tgc?=
 =?us-ascii?Q?WRwtDc0bkXCNjVXNsuXpMEAXRyE003pNyyrKGwNayKhLxNOLTeBntSggxl5s?=
 =?us-ascii?Q?FaZObp0GwL5O54i5NhrxFPrEGiw2jk+kF/wnbZH4MfC+t9zV6GE+6h1U4eUm?=
 =?us-ascii?Q?gDCYgSAV3c3MBPNRqujJOhwOUL9WWlrk+dc6LWadQdDJaUkCh+I5uvpJVVD7?=
 =?us-ascii?Q?eQhh1a4OWQ5aO2SrqoJtqAAQq2B/VS7HqVGhLqP+FvAx5xDdMYFlqZbNIVKZ?=
 =?us-ascii?Q?ooylJ4umxJEm7x63PeW4qJG/bK74mevUkrwu/rJu1r2RAXfI+pjPA9gWQuoY?=
 =?us-ascii?Q?k+zhS1sEE8bq7HHfLT0JbyfWVAXUsaUbSqUbO8WpvPrnxRNJg884E1eZTGv9?=
 =?us-ascii?Q?oH0JzqTpyjq7cDQCLlnESE3XyByjqGENzlAbTJbAh4W7AYomhyGuVMqpqD1g?=
 =?us-ascii?Q?UFbTDvNFOzinID/2+IrrsMW+h96mThe7kkVltpgCBV2mckAn7FIcrJXmcdTU?=
 =?us-ascii?Q?6GhzbR6bu5B1McYwK9v8HEfCoGwu4SFbiZggj7pFit/VQRiIo6hGm/qIg5um?=
 =?us-ascii?Q?RyHrgDJegifnPPiy8g4hv1hOog6o0LSTdK9dEgWFsEg2QVUw+ZWFDvx+K4dx?=
 =?us-ascii?Q?uljRNYopoQhUpca2Acc+zTzg1Zw/pTfFCsMMBqwGlDu0rJp0cF71y8tN5NBW?=
 =?us-ascii?Q?tDMJbM0UwOyTYTZsFux2qMvglXFLycCfMCGJyDMgKPsY0rAS4PBLiSP1K3Uq?=
 =?us-ascii?Q?0Gk/bDB7IW1f/6A0JlGqgieO9PsA0UUyLE8GrUldDvdAsJZtMVcsG7L8LOS2?=
 =?us-ascii?Q?c9tGQn1yK5QbGiG7Ts3r6lqujCWmJ7t61JwhOGfJ/92D+yfJPeXvyINjves0?=
 =?us-ascii?Q?+bMi7R08rQKXKC3aqEgH6C7LkO2C0onJXf8/hreT6/Jk7cVW+zyDZ85CyOvg?=
 =?us-ascii?Q?xROcgx9rRnYmhOE2ap+eXjWzQD7+R0ylp4SdDiQCW1c+XSZD3D7xT8zBOrUV?=
 =?us-ascii?Q?2r0wswSHkdOZvnYRuS8g59UpkXV7foDzO6w9gHgWD++NE1omi+NCC2NWHuej?=
 =?us-ascii?Q?QgPDALO7BE/N76mQ52XCaLn/RQ/iQ9MmCAfStDJjo22a+RKnt0ksUfFASuiL?=
 =?us-ascii?Q?p7QOXDzQT4yb6oVhfnQ97FwNGX/Kkk/sqJ7CwawbN9lWbHDIknP3W33JLViN?=
 =?us-ascii?Q?r/HtP95TOHT3a6fdMkofuxR0blsquTehsHsyUpNvJOJZjl/DbnFdXMnnqzZx?=
 =?us-ascii?Q?N2kTkjXlx5IKhxizq6mz5jojpaAiADtguCCaG6Qvm2gmLbb/lNTv6MALR5da?=
 =?us-ascii?Q?fknm+JdfjQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 515d9ce6-b114-4255-91e8-08da3766988c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 18:05:01.3617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYxCHNZTm9eMlSKTeFYVYM6IJpIZE2x0PhN5ufV7siMgJB3e+yToW6x9bEje+vYn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1337
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2022 at 09:43:19AM +0800, Lu Baolu wrote:
> intel-iommu.h is not needed in drm/i915 anymore. Remove its include.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/gpu/drm/i915/i915_drv.h                | 1 -
>  drivers/gpu/drm/i915/display/intel_display.c   | 1 -
>  drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 1 -
>  3 files changed, 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
