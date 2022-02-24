Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614C44C2CBE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 14:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbiBXNKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiBXNKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:10:18 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F4464BDB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 05:09:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ag0mcUlnbExf8KHd1D//KCuzzEIvl88tBJQoapROQ/iE7hzLMdXZGVGOK22lnKIZm5d+AAu33bgm/ErhfBZtpGaONYawB/1/a2i3FMzUMJj9rR94IOO3vL8/oD81Miep3AdeaQPrIUNJ9+aIpGWqZKutujQY4tOFnY8no2nOGAvngqSY5ozqyy2PGXEkB1tt2baqSWqBsrJBqsKW3oFfl1B/B+gXM7xgU2t/YWV4VsnChuf7gNrNjrI8zuxfEBtyeHUzHVr5Pqhl3r5pXZ8Sr09swnZS560Jlozgu0uEqmA3Lj4coLrRX0Sud/25pr3oXfvmI2kOwQKtUVgzl/a6PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqLwjWLeIK90yzkKH4TpmA2VQ1fAHugJ7IluMMg/6oU=;
 b=nj/eRvGvortDr26QD9JKT+uiw9EhSBxc1a/I695W3hEItp8ybOxd+DPH9MO7YiN0cxRoVInKK1PG++Gce2KsbyoYxe9D0+QbWQTe1GwDeloHmrGgiV7x3pZSbNMDCPvsZ5/UnHa0hzw/BS5t0L+45TQWmTg2hrwQtv/bCiOJIz4B6OE0gkfz3PBGQvvhZxnwuIbRTrTWDaboXt6vr+L9EBW/pYtEwfyHRXLZSGeCUevHVepetk5TIaKZ2lHY75allBBu5S/IqlqYSPFX4sjBrKPSS3xBrhCMwOh0rwmoxgAxC0NF4Ld07MB56Jqh9YUJmFea4cMa3RCVqDas2jNYTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqLwjWLeIK90yzkKH4TpmA2VQ1fAHugJ7IluMMg/6oU=;
 b=g+XwXt78HDs1CwY33/wApnNtCT9bu5R4xj5jqqL6WALHUcZEzxIfKd2jcv42e4tWr6WuVjPNQWDq7EWcHfWam+f74SHYJPxAFv18UIUkN2zMeElhaPSp3QHzyjVM4df2Z4JORwxCQo/gXuGBovk7WVCnTv7JsJFQOUE29o0WaODAnKQbllw4pBJPUi/E5zYzVmPLOk6V6eHfFYjieMz1s28mrAd2dEtRZJfQBY9eZ3wr0cbWjF1fbTnMLvFqjydVtgRviJB5EArVEfXxh1NFzNcwbNpLEA7my0pLvcrkrlThgbRUAMbymB2Ma4VWXBwTR3itHdb6cY6t4fEwZsqwJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by MW2PR12MB2411.namprd12.prod.outlook.com (2603:10b6:907:10::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Thu, 24 Feb
 2022 13:09:46 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::287d:b5f6:ed76:64ba]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::287d:b5f6:ed76:64ba%3]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 13:09:46 +0000
Date:   Thu, 24 Feb 2022 09:09:45 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/11] iommu/vt-d: Remove commented code
Message-ID: <20220224130945.GL6413@nvidia.com>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
 <20220214025704.3184654-10-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214025704.3184654-10-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:208:256::10) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e4dd99d-7967-4232-73d4-08d9f796ee32
X-MS-TrafficTypeDiagnostic: MW2PR12MB2411:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB24119577DA40B88714A3B9EDC23D9@MW2PR12MB2411.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GPWQEuLS7HWu69jlwBjtKMaNgmPzPFGOIZvVSylphVp4r/HNrnKDKoxtT+45hpvIX8L/h+seM4++LZhx8vucZGpJIABUeAy7LeeFqjsluOdQuhBDSlpETVAlxI9CagmutgXN0bCOv0yrFYp2dlG/WR7ZcgV8R4KPA00za30oT61dSLVwqQXRJCjND4nzVx7DzXLHaC487J2/aoxDis8UH7av2vE949/B4Wk0R4PJMnUmiZw9t639ukh5D2UKBBizsD2JY8T2BCtoFU/NjAZXcHWQ0uZE09T/JA+GZRsqdH0Z3KI3ie/SwLDTJ1rKjjc6eZyReN9TCJR9fpedeUvqQSC51/wSUCMpVwMXxDdpwP4Za9j5So2jTJmSx2JaG8L2JTqvEsTB+Phx4613UVECGRtpBb85R9mCvp0MhftfdTo2I/eww8/1UAyNvhafeXQcuwFavzMMbvNkgKCyCfgxtAZ68bMDKt2q0wolAeLXmvF2ITfAct7X2RCQHphpC8dgrjfM2mPnoKWX5kame5JxdrnNNUTqTguZFp+bB9w3/j34LHYfqOe+QSyA/g1E6eScQ8wqsMgzrBrGRiUz/eluRv8WgpxmngPl9R44OAethTNIRFxrFdpkfQ5lE8VWzzMJzCFdp95UNBJIkpwXCs9Urw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(26005)(1076003)(6512007)(54906003)(6506007)(66556008)(6486002)(86362001)(508600001)(6916009)(2616005)(316002)(66946007)(66476007)(8676002)(33656002)(83380400001)(4326008)(7416002)(4744005)(38100700002)(5660300002)(8936002)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ECrE/UABv6A/JqbdA6yslVzjj6ouyoxzspeMm4wYFvuJFZjFRH+QB/Iym6IT?=
 =?us-ascii?Q?N67CpC04dVRjN4I836Pj4M/J/Yd7gjT7d8p5fjsCarWPJNwrycob5n4y+6xm?=
 =?us-ascii?Q?3a2lSJM5QTfP1ktAFJi8wNVMfYi9C1s0GYGnf7VxgNV1uqSeeQaOyI5vHGNv?=
 =?us-ascii?Q?Q2Me5iFPphDbT8Tjw+aY9DFJh/tEZ8QhFWOyejj4f3Wbuzu3rDwubfYaRBaa?=
 =?us-ascii?Q?2Qdb9NKf3qAFd1XtOpCbUGeakh58IqhsVBWab3Jn2SEBF9qwnwXcTlbDRmVT?=
 =?us-ascii?Q?p9eiIsUcbr9mtt+Im1l1Fuxk/bK5oNPwIaNXiiIC6fnYHxMY1QclUSHe4rGa?=
 =?us-ascii?Q?GWswURFP1O6DVdO6dsaWUbDWBNt1eEj7UPoFVJukpMSxA8UVjH6C6m60BbIg?=
 =?us-ascii?Q?ns/6x7ugA4jiU+mgQM+4BgTbumO0P1mVhNppPaLdHhm9nJ2J+H+lS7SQv07d?=
 =?us-ascii?Q?DhxhqHoxZMHiSbxYN3kNWCCqg+f8W9eBWYRC8Oa0cQPuRIvYK8DEZQ3QE+ZD?=
 =?us-ascii?Q?Q7ZaOVjGAsHRnzTSTWn0f3H9MxfHE/WMtX/xGMsQL+mzZTgfSruU65dajfGj?=
 =?us-ascii?Q?Wj1Knuit3fGkPkwPn3375xqEa5ahbzdVpIM9+cCbrYU6ZfiCzsFPvn4/9Lmw?=
 =?us-ascii?Q?yn84eP6E7EFrZzLSzcojVKkBEgbFZVrDJ8jNPuF4wTMQyQma4KsKA7MYkPre?=
 =?us-ascii?Q?/u+pa0vQ54LsCPrVw6TZbtVBHI9D7dTRAlPu4OqgMvmZiPsDKzCQIp2oXo8x?=
 =?us-ascii?Q?sERDI7vKUIVlKpn85RE7lVywcZGUyjV/CVNTp20Rm0LenJwNlFpMwnvDZ4tl?=
 =?us-ascii?Q?D+/CpOeF/Q+1wU/o4S2oFa1rtpmkS7mSoXXGu4D0EbLyaWnKviYAc90NWVDc?=
 =?us-ascii?Q?45GGIQcbn1wCaZwNC1sraQasK1dqPesTdogNWPVxvbFEaT2twX+4zTKj35w0?=
 =?us-ascii?Q?DAGI+BKSXZRjOIRoq7MCD1LYMPYe73pyycFsSjPJ8AA49bH3vaLndZj5q3Cw?=
 =?us-ascii?Q?6j12unwFT8a2tUIDSb5WbzWM7a3D+fC54jr2jhMpWOlXLr9LqLGxieoU0cQK?=
 =?us-ascii?Q?yztVQfOTZ54G8JUfWEFh0RFv7s8BSd4Cvpgh2jL/GpWGfeld5/XIbhkYptHK?=
 =?us-ascii?Q?nyU9t4fXKSzkc5d/khfS57lgCMEG9ZTdCJTPrctD/HqLFeZEtQokWcrifnGT?=
 =?us-ascii?Q?zReH+/8aabRepEWQwy6lPJwAiNQYV2YSAhKsVRk4aplcoC4JDx53X5VPHghb?=
 =?us-ascii?Q?GElhKCxcWcwDHksxa5+kjhvWF9AqsEtEFIt4V+colfLoFsINKCr2dWaglhRq?=
 =?us-ascii?Q?eVv3QGiX+vFlxdKNNpWOCTu5coScxykIZiVN4BcqgsrVrFkzOfKBQ8KfQ5Pz?=
 =?us-ascii?Q?k83RYFDfi7HZtAz7mWLGb9JTXUbRpUzSPEnm1T3NawJ/CIbrXQdmw9P1BIKC?=
 =?us-ascii?Q?qikIUs9b5XErLHoG2jozlHNAsgFH9MUrTD3s54NqrNHAXfRTt8RmuL5PHCJv?=
 =?us-ascii?Q?Zs3tGEBNpox2pn1ez5qer63Hw1RMezr2LP8JVLkxz9ndIVckXkv1ZU7N/RqG?=
 =?us-ascii?Q?ocamwpYWOqA2WScLowI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e4dd99d-7967-4232-73d4-08d9f796ee32
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 13:09:46.3856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UlMB2Cr2I98Kjhl0DCqNOasNV345PC9kMVLCnFKz+ljiod9fL9S+41kn3hDoJD8Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2411
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 10:57:02AM +0800, Lu Baolu wrote:
> This removes unnecessary commented code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)

Assuming you don't want to uncomment it

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
